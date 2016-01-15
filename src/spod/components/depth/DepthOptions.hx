package spod.components.depth;

import luxe.options.ComponentOptions;
import phoenix.Shader;
import luxe.Color;


typedef DepthOptions = {

  > ComponentOptions,

    @:optional var overlap : Bool;
	
    @:optional var horizonY : Float;

    @:optional var scale : Bool;
	
    @:optional var minScale : Float;
	
    @:optional var maxScale : Float;
	
	@:optional var color:Color;
	
	@:optional var brightness:Bool;
	
	@:optional var minBrightness:Float;
	
	@:optional var maxBrightness:Float;
	
	@:optional var blur:Float;

} //DepthOptions