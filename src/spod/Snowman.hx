package spod;

import luxe.components.sprite.SpriteAnimation;
import luxe.importers.texturepacker.TexturePackerData;
import luxe.importers.texturepacker.TexturePackerJSON;
import luxe.importers.texturepacker.TexturePackerSpriteAnimation;
import luxe.options.SpriteOptions;
import luxe.Sprite;

import hxmath.math.MathUtil;

/**
 * ...
 * @author Marko Ristic
 */
class Snowman extends Sprite
{
	var destDepth:Float = 0;
	var horizonY:Float = 0;

	public function new(options:SpriteOptions) 
	{
		super(options);
	}
	
	override function init()
	{
		horizonY = Luxe.screen.h / 3;
	}
	
	override function update( delta:Float )
	{
		this.pos.y = MathUtil.clamp(this.pos.y, horizonY, Luxe.screen.h);
		
		_updateDepth();
    } //update
	
	function _updateDepth() 
	{
		destDepth = (this.pos.y - horizonY) / (Luxe.screen.h - horizonY);
		
		this.depth = destDepth;
	}
}