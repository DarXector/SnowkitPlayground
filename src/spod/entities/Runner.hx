package spod.entities;

import luxe.Color;
import luxe.components.sprite.SpriteAnimation;
import luxe.options.SpriteOptions;
import luxe.Sprite;
import phoenix.Vector;
import spod.components.depth.DepthManager;
import spod.components.mover.Mover;

import hxmath.math.MathUtil;

/**
 * ...
 * @author Marko Ristic
 */
class Runner extends Sprite
{
	var _anim:SpriteAnimation;
	var _moverComponent:Mover;

	public function new(options:SpriteOptions)
	{
		super(options);
	}

	override function init()
	{
		_createAnimation();
		
		_moverComponent =  new Mover( {
			name: "mover", 
			maxVelocity: new Vector(256, 128),
			acceleration: new Vector(10, 5),
			maxUp: Luxe.screen.h / 3,
			maxDown: Luxe.screen.h,
			maxRight: Luxe.screen.w - 64,
			maxLeft: 64,
			friction: 0.90
		});
		
		this.add(_moverComponent);

		this.add(new DepthManager( {
			name: "depth_manager", 
			
			focalY: Luxe.screen.h / 3,
			
			scale: true,
			parallax: true,
			
			overlap: true,
			
			minScale: 0.25,
			maxScale: 1,
			
			brightness: true,
			minBrightness: 0.1,
			
			color: new Color(0.8, 0.89, 1),
			
			blur: 2
		}));
	}

	function _createAnimation()
	{
		_anim = new SpriteAnimation({ name:'anim' });
		this.add( _anim );
		
		var animation_json = '
			{
				"run" : {
                    "frame_size":{ "x":"128", "y":"128" },
                    "frameset": ["1-12"],
                    "pingpong":"false",
                    "loop": "true",
                    "speed": "18"
                }
			}
		';

		//We can create the animation from a json string
		_anim.add_from_json( animation_json );

		//Or we can add them manually, using the anim.animation_list.push(new SpriteAnimationData)
		_anim.animation = 'run';
		_anim.play();
	}
	
	override function update(dt:Float)
	{
		//set the correct animation
		if(_moverComponent.moving)
		{
			_anim.play();
		}
		else
		{
			_anim.stop();
		}
	}
}
