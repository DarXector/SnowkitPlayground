package spod.entities;

import luxe.options.SpriteOptions;
import luxe.Sprite;
import spod.components.depth.DepthManager;

import hxmath.math.MathUtil;

/**
 * ...
 * @author Marko Ristic
 */
class Snowman extends Sprite
{
	public function new(options:SpriteOptions) 
	{
		super(options);
	}
	
	override function init()
	{		
		this.pos.y = MathUtil.clamp(this.pos.y, Luxe.screen.h / 3, Luxe.screen.h);
		
		this.add(new DepthManager( {
				name: "depth_manager", 
				horizonY: Luxe.screen.h / 3,
				scale: true,
				overlap: true,
				minScale: 0.25,
				maxScale: 1,
				blur: true
			}));
	}
}