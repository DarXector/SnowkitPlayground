package spod;

import luxe.components.sprite.SpriteAnimation;
import luxe.Input.Key;
import luxe.Rectangle;
import luxe.Scene;
import luxe.Sprite;
import luxe.Vector;
import phoenix.geometry.Geometry;
import spod.entities.Runner;
import spod.entities.Snowman;

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
		var random = new Random(1234);

		var background = new Sprite({
			name: "background",
			texture: Luxe.resources.texture('assets/background.png'),
			pos : new Vector( Luxe.screen.w/2, Luxe.screen.h/2 ),
			size: Luxe.screen.size
		});

		var runner1 = new Runner({
			name : "runner1",
			texture : Luxe.resources.texture('assets/run_cycle.png'),
			pos : new Vector( Luxe.screen.w / 2, Luxe.screen.h / 2 + 64 ),
			origin : new Vector(64, 128),
			size : new Vector(128,128)
		});

		var runner2 = new Runner({
			name : "runner2",
			texture : Luxe.resources.texture('assets/run_cycle.png'),
			pos : new Vector( Luxe.screen.w / 2, Luxe.screen.h / 2 + 192 ),
			origin : new Vector(64, 128),
			size : new Vector(128,128)
		});

		for (i in 1...20)
		{
			var snowman = new Snowman({
				name : "snowman"+i,
				texture : Luxe.resources.texture('assets/snow_assets.png'),
				pos : new Vector( random.float(0, Luxe.screen.w), random.float(Luxe.screen.h / 3 + 64, Luxe.screen.h) ),
				uv: new Rectangle( 60, 160, 135, 180 ),
				size : new Vector(135, 180),
				origin : new Vector(67, 180)
			});
		}

		super.init(_);
	}

	override function reset()
	{
		super.reset();
	}

}
