package spod.components;

import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.Sprite;

/**
 * ...
 * @author Marko Ristic
 */
class DepthManager extends Component
{
	var destDepth:Float = 0;
	
	var horizonY: Float = 0;
	var view:Sprite;

	public function new(_options:ComponentOptions) 
	{
		super(_options);
	}
	
	override function init() 
	{
		try 
		{
			view = cast(entity, Sprite);
		} 
		catch (e:Dynamic) 
		{
			return;
		}
		
		horizonY = Luxe.screen.h / 3;
    }
	
    override function update(dt:Float) 
	{
        _updateDepth();
	}
	
	function _updateDepth() 
	{
		if (view == null)
			return;
		
		destDepth = (entity.pos.y - horizonY) / (Luxe.screen.h - horizonY);
		
		view.depth = destDepth;
	}
	
	
}