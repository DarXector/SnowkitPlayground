package spod.components.mover;

import hxmath.math.MathUtil;
import luxe.Component;
import luxe.Sprite;
import phoenix.Vector;
import spod.components.mover.MoverOptions;

/**
 * ...
 * @author Marko Ristic
 */
class Mover extends Component
{
	var _view:Sprite;
	
	var _maxLeft : Float = 0;
	var _maxRight : Float = 0;
	var _maxUp : Float = 0;
	var _maxDown : Float = 0;
	var _friction : Float = 1;
	
	var _acceleration: Vector;
	var _maxVelocity: Vector;
	
	@:isVar public var velocity(get, set): Vector = new Vector(0, 0);
	@:isVar public var moving(get, null): Bool;

	public function new(?_options:MoverOptions) 
	{
		
		if (_options.acceleration != null) 
		{
			_acceleration = _options.acceleration;
		}
		
		if (_options.maxVelocity != null) 
		{
			_maxVelocity = _options.maxVelocity;
		}
		
		if (_options.friction != null) 
		{
			_friction = _options.friction;
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
	}
	
	override function update(dt:Float)
	{
        _updateSpeed(dt);
        _updateMove(dt);
	}
	
	function _updateSpeed(delta:Float)
	{
		if (_view == null) return;
		
		moving = false;
		
		if (Luxe.input.inputdown('left'))
		{
			velocity.x -= _acceleration.x;
			_view.flipx = true;
			moving = true;
		}
		else if (Luxe.input.inputdown('right'))
		{
			velocity.x += _acceleration.x;
			_view.flipx = false;
			moving = true;
		}
		else 
		{
			velocity.x *= _friction;
		}

		if (Luxe.input.inputdown('up'))
		{
			velocity.y -= _acceleration.y;
			moving = true;
		}
		else if(Luxe.input.inputdown('down'))
		{
			velocity.y += _acceleration.y;
			moving = true;
		}
		else 
		{
			velocity.y *= _friction;
		}
		
		velocity.x = Math.fround(velocity.x * 10) / 10;
		velocity.y = Math.fround(velocity.y * 10) / 10;
		
		velocity.x = MathUtil.clamp(velocity.x, -_maxVelocity.x, _maxVelocity.x);
		velocity.y = MathUtil.clamp(velocity.y, -_maxVelocity.y, _maxVelocity.y);
	}
	
	function _updateMove(delta:Float)
	{
		_view.pos.x += velocity.x * delta;
		_view.pos.y += velocity.y * delta;
		
		trace("_view.pos.y " + _view.pos.y + " velocity.y " + velocity.y + " _acceleration.y " + _acceleration.y);
	}
	
	function get_velocity():Vector 
	{
		return velocity;
	}
	
	function set_velocity(value:Vector):Vector 
	{
		return velocity = value;
	}
	
	function get_moving():Bool 
	{
		return moving;
	}
	
}