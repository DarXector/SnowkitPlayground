package spod;

import luxe.components.sprite.SpriteAnimation;
import luxe.Input.Key;
import luxe.Rectangle;
import luxe.Scene;
import luxe.Sprite;
import luxe.Vector;
import phoenix.geometry.Geometry;

import luxe.utils.Random;

/**
 * ...
 * @author Marko Ristic
 */
class SixPrinciplesOfDepth extends Scene
{
	public function new(?_name:String='untitled scene') 
	{
		super(_name);
	}
	
	override function init(_)
	{		
		var random = new Random(123);
		
		var background = new Sprite({
			name: "background",
			texture: Luxe.resources.texture('assets/background.png'),
			pos : new Vector( Luxe.screen.w/2, Luxe.screen.h/2 ),
			size: Luxe.screen.size
		});
		
		var runner1 = new Runner({
            name : "runner1",
			texture : Luxe.resources.texture('assets/run_cycle.png'),
			pos : new Vector( Luxe.screen.w/2, Luxe.screen.h/2 ),
			size : new Vector(128,128)
		});
		
		var runner2 = new Runner({
            name : "runner2",
			texture : Luxe.resources.texture('assets/run_cycle.png'),
			pos : new Vector( Luxe.screen.w/2, Luxe.screen.h/2 - 100 ),
			size : new Vector(128,128)
		});
		
		for (i in 1...16) 
		{
			var snowman = new Snowman( {
				name : "snowman"+i,
				texture : Luxe.resources.texture('assets/snow_assets.png'),
				pos : new Vector( random.float(0, Luxe.screen.w), random.float(Luxe.screen.h / 3, Luxe.screen.h) ),
				geometry: Luxe.draw.plane( { uv: new Rectangle( 0, 0, 512, 512 ) } ),
				size : new Vector(512,512)
			});
		}
		
		super.init(_);
	}
	
	override function reset() 
	{
		super.reset();
	}
	
}