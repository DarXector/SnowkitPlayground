package;

import luxe.Input;
import spod.SixPrinciplesOfDepth;

class Main extends luxe.Game
{

	var sixPrinciplesOfDepth:SixPrinciplesOfDepth;

	override function config(config:luxe.AppConfig)
	{
		config.preload.textures.push({ id:'assets/textures/background.png' });
		config.preload.textures.push({ id:'assets/textures/run_cycle.png' });
		config.preload.textures.push( { id:'assets/textures/snow_assets.png' } );
		
		config.preload.shaders.push({ id:'depth', frag_id:'assets/shaders/depth_frag.glsl', vert_id:'default' });

		return config;
	} //config

	override function ready()
	{
		Luxe.input.bind_key('left', Key.left);
		Luxe.input.bind_key('left', Key.key_a);

		Luxe.input.bind_key('right', Key.right);
		Luxe.input.bind_key('right', Key.key_d);

		Luxe.input.bind_key('up', Key.up);
		Luxe.input.bind_key('up', Key.key_w);

		Luxe.input.bind_key('down', Key.down);
		Luxe.input.bind_key('down', Key.key_s);

		sixPrinciplesOfDepth = new SixPrinciplesOfDepth('six principles of depth scene');
	}

	override function onkeyup(e:KeyEvent)
	{
		if(e.keycode == Key.escape)
			Luxe.shutdown();
	}

	override function update(dt:Float)
	{
	}
}
