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
	var destDepth:Float = 0;

	var _horizonY: Float = 0;
	
	var view:Sprite;
	
	var _updateOverlap:Bool;
	
	var _updateScale:Bool;
	
	var _minScale:Float = 0;
	var _maxScale:Float = 1;
	var _originalOrigin:Vector;
	var _originalSize:Vector;
	
	var _updateColor:Bool;
	var _minColorModifier:Float = 0.1;
	var _maxColorModifier:Float = 1;
	
	var _blurShader:Shader;
	var _updateBlur:Bool;

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
			_minScale = _options.minScale;
			_maxScale = _options.maxScale;
		}
		
		if (_options.color != null) 
		{
			_updateColor = _options.color;
			_minColorModifier = _options.minColorModifier;
			_maxColorModifier = _options.maxColorModifier;
		}
		
		if (_options.blur != null) 
		{
			_updateBlur = _options.blur;
			_blurShader = Luxe.resources.shader('blur');
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
			
			if (_updateBlur)
			{
				view.shader = _blurShader;
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

		destDepth = (entity.pos.y - _horizonY) / (Luxe.screen.h - _horizonY);

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
			var depthColorModifier = _minColorModifier + (destDepth * (_maxColorModifier - _minColorModifier));
			var depthColor:Color = new Color(1, 1, 1, 1);
			if (_updateColor) 
			{
				depthColor = new Color(depthColorModifier, depthColorModifier, depthColorModifier);
			}
			
			view.color = depthColor;
		}
		
		if (_updateBlur)
		{
			if (view.name == "runner1")
			{
				trace("destDepth : " + destDepth);
			}
			_blurShader.set_float("u_strength", 1 - destDepth);
			view.shader = _blurShader;
		}
	}
}
