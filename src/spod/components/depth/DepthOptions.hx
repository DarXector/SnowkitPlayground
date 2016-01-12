package spod.components.depth;

import luxe.options.ComponentOptions;

typedef DepthOptions = {

  > ComponentOptions,

    @:optional var overlap : Bool;
	
    @:optional var horizonY : Float;

    @:optional var scale : Bool;
	
    @:optional var minScale : Float;
	
    @:optional var maxScale : Float;

} //DepthOptions