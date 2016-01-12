package spod.components.depth;

import luxe.Component;
import luxe.options.ComponentOptions;
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
			var scale = _minScale + (destDepth * (_maxScale - _minScale));
			view.size = new Vector(_originalSize.x * scale, _originalSize.y * scale);
			view.origin = new Vector(_originalOrigin.x * scale, _originalOrigin.y * scale);
		}
	}
}
