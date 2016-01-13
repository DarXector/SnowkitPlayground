package spod.components.depth;

import luxe.options.ComponentOptions;
import phoenix.Shader;

typedef DepthOptions = {

  > ComponentOptions,

    @:optional var overlap : Bool;
	
    @:optional var horizonY : Float;

    @:optional var scale : Bool;
	
    @:optional var minScale : Float;
	
    @:optional var maxScale : Float;
	
	@:optional var color:Bool;
	
	@:optional var minColorModifier:Float;
	
	@:optional var maxColorModifier:Float;
	
	@:optional var blur:Bool;

} //DepthOptions