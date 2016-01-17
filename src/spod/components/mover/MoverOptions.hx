package spod.components.mover;

import luxe.options.ComponentOptions;
import phoenix.Vector;


typedef MoverOptions = {

  > ComponentOptions,

    @:optional var maxVelocity : Vector;
	
	@:optional var acceleration : Vector;
	
    @:optional var maxRight : Float;
	
    @:optional var maxLeft : Float;
	
	@:optional var maxUp : Float;
	
    @:optional var maxDown : Float;
	
    @:optional var friction : Float;

} //MoverOptions