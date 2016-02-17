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
import model.ModelLocator;
import phoenix.geometry.Geometry;
import spod.entities.Runner;
import spod.entities.Snowman;
import spod.model.SPODModel;

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
	
	var _model:SPODModel;
	
	public function new(?_name:String='untitled scene')
	{
		_model = ModelLocator.instance().spodModel;
		
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
		
		inline function make_checkbox(_n,_x,_y,_w,_h,_t,_onchange) {

            new mint.Label({
				parent: window,
				name: "lb_" + _n,
				x:_x, y:_y, w:_w, h:_h,
				text: _t,
				align:left,
				text_size: 14
			});

			new mint.Checkbox({
				parent: window,
				name: "cb_" + _n,
				x: _x + _w + 5, y: _y + 7, w: 20, h: 20,
				onchange: _onchange
			});
        }
		
		inline function make_slider(_n, _x, _y, _min, _max,
			_initial, _step:Null<Float>, _vert, _onslchange) 
		{			
            var _s = new mint.Slider({
                parent: window, 
				name: "sl_" + _n, 
				x: _x, y: _y, w: 100, h: 20,
                options: { color_bar:new Color().rgb(0x9dca63) },
                min: _min, max: _max, 
				step: _step, vertical: _vert, 
				value: _initial
            });
			
			_s.onchange.listen(_onslchange);

            var _l = new mint.Label({
                parent: _s, 
				text_size: 12, 
				x: 0, y: 0, w: _s.w, h: _s.h,
                align: TextAlign.center, 
				align_vertical: TextAlign.center,
                name : _s.name+'.label', 
				text: '${_s.value}'
            });

        }
		
		make_checkbox("overlap", 10, 25, 60, 32, "Overlap", 
		function(s, p) {
				_model.overlap = s;
		});
		
		make_checkbox("parallax", 10, 50, 60, 32, "Parallax", 
		function(s, p) {
				_model.parallax = s;
		});
		
		make_checkbox("vp", 110, 25, 100, 32, "Vanishing Point", 
		function(s, p) {
				_model.toggleVanishingPoint(s);
		});
		
		make_slider('vp', 240, 32, 0, Luxe.screen.h, Luxe.screen.h / 3, 5, false,
		function(v, p) {
				_model.vanishingPointY = v;
		});

    }

	override function reset()
	{
		super.reset();
	}

}
