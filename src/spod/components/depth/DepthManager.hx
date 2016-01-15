package spod.components.depth;

import luxe.Color;
import luxe.Component;
import luxe.options.ComponentOptions;
import phoenix.Shader;
import spod.components.depth.DepthOptions;
import luxe.Sprite;
import luxe.Vector;

/**
 * ...
 * @author Marko Ristic
 */
class DepthManager extends Component
{
	var _horizonY: Float = 0;
	
	var view:Sprite;
	
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

	public function new(_options:DepthOptions)
	{
		if (_options.horizonY != null) 
		{
			_horizonY = _options.horizonY;
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
		
		super(_options);
	}

	override function init()
	{
		try
		{
			view = cast(entity, Sprite);
			
			if (_updateScale)
			{
				_originalOrigin = new Vector(view.origin.x, view.origin.y);
				_originalSize = new Vector(view.size.x, view.size.y);
			}
			
			if (_updateBlur || _updateBrightness || _updateColor)
			{
				_depthShader = Luxe.resources.shader('depth').clone("depth_" + view.name);
				
				_depthShader.set_vector2("u_dir", new Vector(1.0, 0.0));
				
				_depthShader.set_float("u_blur", 0.0);
				
				_depthShader.set_vector3("u_color", new Vector(0.0, 0.0, 0.0));
				
				_depthShader.set_float("u_brightness", 0.0);
				
				view.shader = _depthShader;
			}
			
			_updateDepth();
		}
		catch (e:Dynamic)
		{
			return;
		}
	}

	override function update(dt:Float)
	{
        _updateDepth();
	}

	function _updateDepth()
	{
		if (view == null)
			return;

		var destDepth = (entity.pos.y - _horizonY) / (Luxe.screen.h - _horizonY);
		var destDepthSqrt = Math.sqrt((entity.pos.y - _horizonY) / (Luxe.screen.h - _horizonY));

		if (_updateOverlap)
		{
			view.depth = destDepth;
		}
		
		if (_updateScale)
		{
			var depthScale = _minScale + (destDepth * (_maxScale - _minScale));
			view.size = new Vector(_originalSize.x * depthScale, _originalSize.y * depthScale);
			view.origin = new Vector(_originalOrigin.x * depthScale, _originalOrigin.y * depthScale);
		}
		
		if (_updateColor)
		{
			var depthColorModifier = 1 - destDepthSqrt;
			
			_depthShader.set_vector3("u_color", new Vector(depthColorModifier * _targetColor.r, depthColorModifier * _targetColor.g, depthColorModifier * _targetColor.b));
		}
		
		if (_updateBrightness)
		{
			var depthBrightnessModifier = _minBrightness + ((1 - destDepthSqrt) * (_maxBrightness - _minBrightness));
			
			trace("depthBrightnessModifier " + depthBrightnessModifier);
			
			_depthShader.set_float("u_brightness", depthBrightnessModifier);
		}
		
		if (_updateBlur)
		{
			_depthShader.set_float("u_blur", _blurModifier * (1.0 - destDepthSqrt) / 1000);
		}
	}
}
