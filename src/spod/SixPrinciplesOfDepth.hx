package spod;

import luxe.Color;
import luxe.components.sprite.SpriteAnimation;
import luxe.Input.Key;
import luxe.Rectangle;
import luxe.Scene;
import luxe.Sprite;
import luxe.Vector;
import mint.Button;
import mint.Label;
import mint.Panel;
import mint.Scroll;
import mint.Slider;
import mint.types.Types.TextAlign;
import phoenix.geometry.Geometry;
import spod.entities.Runner;
import spod.entities.Snowman;

import luxe.utils.Random;

import mint.Window;
import mint.Checkbox;
import mint.Progress;
import mint.Canvas;

/**
 * ...
 * @author Marko Ristic
 */
class SixPrinciplesOfDepth extends Scene
{
	var window: Window;
	var check: Checkbox;
    var progress: Progress;
    var canvas: Canvas;
	
	public function new(?_name:String='untitled scene')
	{
		super(_name);
	}

	override function init(_)
	{
		var random = new Random(10);

		var background = new Sprite({
			name: "background",
			texture: Luxe.resources.texture('assets/textures/background.png'),
			pos : new Vector( Luxe.screen.w/2, Luxe.screen.h/2 ),
			size: Luxe.screen.size
		});

		var runner1 = new Runner({
			name : "runner",
			texture : Luxe.resources.texture('assets/textures/run_cycle.png'),
			pos : new Vector( Luxe.screen.w / 2, Luxe.screen.h - 128 ),
			origin : new Vector(64, 110),
			size : new Vector(128,128)
		});

		var posX:Float = 50;
		var posY:Float = Luxe.screen.h - 50;
		
		for (i in 1...30)
		{
			var snowman = new Snowman({
				name : "snowman"+i,
				texture : Luxe.resources.texture('assets/textures/snow_assets.png'),
				//pos : new Vector( random.float(0, Luxe.screen.w), random.float(Luxe.screen.h / 3 + 64, Luxe.screen.h) ),
				pos : new Vector( posX, posY ),
				uv: new Rectangle( 60, 160, 135, 180 ),
				size : new Vector(135, 180),
				origin : new Vector(67, 170)
			});
			
			posX += 200;
			if (i != 0 && i % 5 == 0)
			{
				posY -= 80;
				posX = 50;
			}
		}
		
		_createUI();

		super.init(_);
	}
	
	function _createUI() 
	{
		canvas = Main.canvas;
		
		window = new mint.Window({
            parent: canvas,
            name: 'window',
            title: 'window',
            options: {
                color:new Color().rgb(0x121212),
                color_titlebar:new Color().rgb(0x191919),
                label: { color:new Color().rgb(0x06b4fb) },
                close_button: { color:new Color().rgb(0x06b4fb) },
            },
            x:10, y:10, w:940, h: 192,
            w_min: 940, h_min:192,
            collapsible:true,
			closable: false
        });
		
		new mint.Label({
            parent: window,
            name: 'labelmain',
            x:10, y:20, w:100, h:32,
            text: 'hello mint',
            align:left,
            text_size: 14,
            onclick: function(e,c) {trace('hello mint! ${Luxe.time}' );}
        });

        check = new mint.Checkbox({
            parent: window,
            name: 'check1',
            x: 120, y: 20, w: 24, h: 24,
			onchange: function(s, p) {
				trace("state: " + s + " previous: " + p);
			}
        });

        new mint.Checkbox({
            parent: window,
            name: 'check2',
            options: {
                color_node: new Color().rgb(0xf6007b),
                color_node_off: new Color().rgb(0xcecece),
                color: new Color().rgb(0xefefef),
                color_hover: new Color().rgb(0xffffff),
                color_node_hover: new Color().rgb(0xe2005a)
            },
            x: 150, y: 20, w: 24, h: 24,
			onchange: function(s, p) {
				trace("state: " + s + " previous: " + p);
			}
        });

        inline function make_slider(_n,_x,_y,_w,_h,_c,_min,_max,_initial,_step:Null<Float>,_vert) {

            var _s = new mint.Slider({
                parent: window, name: _n, x:_x, y:_y, w:_w, h:_h,
                options: { color_bar:new Color().rgb(_c) },
                min: _min, max: _max, step: _step, vertical:_vert, value:_initial
            });

            var _l = new mint.Label({
                parent:_s, text_size:12, x:0, y:0, w:_s.w, h:_s.h,
                align: TextAlign.center, align_vertical: TextAlign.center,
                name : _s.name+'.label', text: '${_s.value}'
            });

            _s.onchange.listen(function(_val,_) { _l.text = '$_val'; });

        } //make_slider

        make_slider('slider1', 14, 20, 32, 128, 0x9dca63, -100, 100, 0, 10, true);
        make_slider('slider2', 56, 20, 32, 128, 0xf6007b, 0, 100, 50, 1, true);
        make_slider('slider3', 98, 20, 32, 128, 0x9dca63, null, null, null, null, true);

        make_slider('slider4', 140, 20, 32, 128, 0xf6007b, 0, 100, 20, 10, true);
        make_slider('slider5', 182, 20, 32, 128, 0x9dca63, 0, 100, 0.3, 1, true);
        make_slider('slider6', 224, 20, 32, 128, 0xf6007b, null, null, null, null, true);
	}

	override function reset()
	{
		super.reset();
	}

}
