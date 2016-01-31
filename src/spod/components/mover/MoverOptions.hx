package spod.components.mover;

import luxe.options.ComponentOptions;
import phoenix.Vector;


typedef MoverOptions = {

  > ComponentOptions,

    @:optional var maxVelocity : Vector;
	
	@:optional var acceleration : Vector;
	
    @:optional var friction : Float;

} //MoverOptions