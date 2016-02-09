package;

import luxe.Color;
import luxe.Input;
import mint.focus.Focus;
import spod.AutoCanvas;
import spod.SixPrinciplesOfDepth;
import mint.render.luxe.LuxeMintRender;
import mint.layout.margins.Margins;
import mint.Canvas;

class Main extends luxe.Game
{

	var sixPrinciplesOfDepth:SixPrinciplesOfDepth;
	
	public static var canvas: Canvas;
    public static var rendering: LuxeMintRender;
    public static var layout: Margins;
	public static var focus: Focus;

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
		rendering = new LuxeMintRender();
        layout = new Margins();
		
		var auto_canvas = new AutoCanvas({
            name:'canvas',
            rendering: rendering,
            options: { color:new Color(1,1,1,0.0) },
            x: 0, y:0, w: 960, h: 640
        });

        auto_canvas.auto_listen();
        canvas = auto_canvas;
        
            //this is required to handle input focus in the default way
        focus = new Focus(canvas);
		
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
