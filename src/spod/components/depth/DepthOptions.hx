package spod.components.depth;

import luxe.options.ComponentOptions;
import phoenix.Shader;
import luxe.Color;
import luxe.Vector;

enum ScaleType {
	MinMax;
	EyeLevel;
}


typedef DepthOptions = {

  > ComponentOptions,

    @:optional var overlap : Bool;
	
    @:optional var vanishingPointY : Float;
	
    @:optional var eyeLevel : Float;

    @:optional var scale : Bool;
	
    @:optional var scaleType : ScaleType;
	
    @:optional var minScale : Float;
	
    @:optional var maxScale : Float;
	
	@:optional var parallax:Bool;
	
	@:optional var camerPosition:Vector;
	
	@:optional var color:Color;
	
	@:optional var brightness:Bool;
	
	@:optional var minBrightness:Float;
	
	@:optional var maxBrightness:Float;
	
	@:optional var blur:Float;
} //DepthOptions