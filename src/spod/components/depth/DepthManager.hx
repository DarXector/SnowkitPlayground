package spod.components.depth;

import luxe.Color;
import luxe.Component;
import luxe.options.ComponentOptions;
import phoenix.Shader;
import spod.components.depth.DepthOptions;
import luxe.Sprite;
import luxe.Vector;
import spod.components.mover.Mover;

/**
 * ...
 * @author Marko Ristic
 */
class DepthManager extends Component
{
	var _focalY: Float = 0;
	
	var _view:Sprite;
	
	var _updateOverlap:Bool;
	
	var _updateScale:Bool;
	
	var _minScale:Float = 0.3;
	var _maxScale:Float = 1;
	var _originalOrigin:Vector;
	var _originalSize:Vector;
	
	var _updateColor:Bool;
	var _targetColor:Color;
	
	var _updateBrightness:Bool;
	var _minBrightness:Float = 0.1;
	var _maxBrightness:Float = 1;
	
	var _depthShader:Shader;
	
	var _updateBlur:Bool;
	var _blurModifier:Float = 0;
	
	var _updateParallax:Bool;
	
	var _moverComponent:Mover;
	var _cameraPosition:Vector;

	public function new(_options:DepthOptions)
	{
		if (_options.focalY != null) 
		{
			_focalY = _options.focalY;
		}
		
		if (_options.overlap) 
		{
			_updateOverlap = _options.overlap;
		}
		
		if (_options.scale != null) 
		{
			_updateScale = _options.scale;
			if (_options.minScale != null)
			{
				_minScale = _options.minScale;
			}
			if (_options.maxScale != null)
			{
				_maxScale = _options.maxScale;
			}
		}
		
		if (_options.color != null) 
		{
			_updateColor = (_options.color != null);
			_targetColor = _options.color;
		}
		
		if (_options.brightness != null) 
		{
			_updateBrightness = _options.brightness;
			
			if (_options.minBrightness != null)
			{
				_minBrightness = _options.minBrightness;
			}
			if (_options.maxBrightness != null)
			{
				_maxBrightness = _options.maxBrightness;
			}
		}
		
		if (_options.blur != null) 
		{
			_updateBlur = (_options.blur != null);
			_blurModifier = _options.blur;
		}
		
		if (_options.parallax != null)
		{
			_updateParallax = _options.parallax;
			if (_options.camerPosition != null)
			{
				_cameraPosition = _options.camerPosition;
			} 
			else
			{
				_cameraPosition = new Vector(Luxe.screen.w / 2, Luxe.screen.h / 2);
			}
		}
		
		super(_options);
	}

	override function init()
	{
		try
		{
			_view = cast(entity, Sprite);
		}
		catch (e:Dynamic)
		{
			return;
		}
		
		if (_updateScale)
		{
			_originalOrigin = new Vector(_view.origin.x, _view.origin.y);
			_originalSize = new Vector(_view.size.x, _view.size.y);
		}
		
		if (_updateBlur || _updateBrightness || _updateColor)
		{
			_depthShader = Luxe.resources.shader('depth').clone("depth_" + _view.name);
			
			_depthShader.set_vector2("u_dir", new Vector(1.0, 0.0));
			
			_depthShader.set_float("u_blur", 0.0);
			
			_depthShader.set_vector3("u_color", new Vector(0.0, 0.0, 0.0));
			
			_depthShader.set_float("u_brightness", 0.0);
			
			_view.shader = _depthShader;
		}
		
		if (_updateParallax)
		{
			_moverComponent = cast entity.get("mover");
			
			var pDepthScale = _getDepthScale((_view.pos.y - _focalY) / (Luxe.screen.h - _focalY));

			_view.pos.x = (_view.pos.x - _cameraPosition.x) * pDepthScale + _cameraPosition.x;
		}
		
		_updateDepth();
	}

	override function update(dt:Float)
	{
        _updateDepth();
	}

	function _updateDepth()
	{
		if (_view == null)
			return;

		var destDepth = (_view.pos.y - _focalY) / (Luxe.screen.h - _focalY);
		var destDepthSqrt = Math.sqrt(destDepth);

		if (_updateOverlap)
		{
			_view.depth = destDepth;
		}
		
		if (_updateScale)
		{
			var depthScale = _getDepthScale(destDepth);
			_view.size = new Vector(_originalSize.x * depthScale, _originalSize.y * depthScale);
			_view.origin = new Vector(_originalOrigin.x * depthScale, _originalOrigin.y * depthScale);
		}
		
		if (_updateColor)
		{
			var depthColorModifier = 1 - destDepthSqrt;
			
			_depthShader.set_vector3("u_color", new Vector(depthColorModifier * _targetColor.r, depthColorModifier * _targetColor.g, depthColorModifier * _targetColor.b));
		}
		
		if (_updateBrightness)
		{
			var depthBrightnessModifier = _minBrightness + ((1 - destDepthSqrt) * (_maxBrightness - _minBrightness));
				
			_depthShader.set_float("u_brightness", depthBrightnessModifier);
		}
		
		if (_updateBlur)
		{
			_depthShader.set_float("u_blur", _blurModifier * (1.0 - destDepthSqrt) / 1000);
		}
		
		if (_updateParallax)
		{
			var pDepthScale = _getDepthScale(destDepth);
			
			if (_moverComponent != null)
			{
				_moverComponent.velocity.x *= Math.sqrt(Math.sqrt(pDepthScale));
				_moverComponent.velocity.y *= Math.sqrt(Math.sqrt(pDepthScale));
			}
		}
	}
	
	inline function _getDepthScale(destDepth:Float):Float
	{
		return _minScale + (destDepth * (_maxScale - _minScale));
	}
}
