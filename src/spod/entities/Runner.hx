package spod.entities;

import luxe.components.sprite.SpriteAnimation;
import luxe.options.SpriteOptions;
import luxe.Sprite;
import spod.components.depth.DepthManager;

import hxmath.math.MathUtil;

/**
 * ...
 * @author Marko Ristic
 */
class Runner extends Sprite
{

	var maxLeft : Float = 0;
	var maxRight : Float = 0;
	var moveSpeed : Float = 0;

	var anim:SpriteAnimation;

	public function new(options:SpriteOptions)
	{
		super(options);
	}

	override function init()
	{
		moveSpeed = 192;
		maxRight = Luxe.screen.w - 64;
		maxLeft = 64;

		_createAnimation();

		this.add(new DepthManager( {
				name: "depth_manager", 
				horizonY: Luxe.screen.h / 3,
				scale: true,
				overlap: true,
				minScale: 0.25,
				maxScale: 1
			}));
	}

	function _createAnimation()
	{
		anim = new SpriteAnimation({ name:'anim' });
		this.add( anim );
		
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
		anim.add_from_json( animation_json );

		//Or we can add them manually, using the anim.animation_list.push(new SpriteAnimationData)
		anim.animation = 'run';
		anim.play();
	}


	override function update( delta:Float )
	{
		_updateRunner(delta);
    }

	function _updateRunner(delta:Float)
	{
		var moving = false;

		if (Luxe.input.inputdown('left'))
		{
			this.pos.x -= moveSpeed * delta;
			this.flipx = true;
			moving = true;
		}
		else if (Luxe.input.inputdown('right'))
		{
			this.pos.x += moveSpeed * delta;
			this.flipx = false;
			moving = true;
		}

		if (Luxe.input.inputdown('up'))
		{
			this.pos.y -= moveSpeed / 3 * delta;
			moving = true;
		}
		else if(Luxe.input.inputdown('down'))
		{
			this.pos.y += moveSpeed / 3 * delta;
			moving = true;
		}

		if (this.pos.x >= maxRight)
		{
			this.pos.x = maxRight;
			moving = false;
		}
		if (this.pos.x <= maxLeft)
		{
			this.pos.x = maxLeft;
			moving = false;
		}

		this.pos.y = MathUtil.clamp(this.pos.y, Luxe.screen.h / 3, Luxe.screen.h);

		//set the correct animation
		if(moving)
		{
			anim.play();
		}
		else
		{
			anim.stop();
		}
	}

}
