package;

import luxe.Input;
import spod.SixPrinciplesOfDepth;

class Main extends luxe.Game 
{
	var sixPrinciplesOfDepth:SixPrinciplesOfDepth
	;
	override function config(config:luxe.AppConfig) 
	{

        config.preload.textures.push({ id:'assets/background.png' });
        config.preload.textures.push({ id:'assets/run_cycle.png' });
        config.preload.textures.push({ id:'assets/snow_assets.png' });

        return config;

    } //config
	
	override function ready() 
	{
		Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);

        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
		
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
