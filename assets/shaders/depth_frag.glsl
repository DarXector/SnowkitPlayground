#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D tex0;
varying vec2 tcoord;
varying vec4 color;

uniform float u_blur;
uniform vec2 u_dir;

uniform float u_brightness;

uniform vec3 u_color;

void main() {
	vec4 sum = vec4(0.0);
	
	vec4 colorized = vec4((color.rgb + u_color), color.a);
	vec4 bright = vec4((colorized.rgb + vec3(u_brightness)), colorized.a);
	//gl_FragColor.rgb = bright;

	// gaussian
	sum += texture2D(tex0, vec2(tcoord.x - 4.0*u_blur*u_dir.x, tcoord.y - 4.0*u_blur*u_dir.y)) * 0.0162162162;
	sum += texture2D(tex0, vec2(tcoord.x - 3.0*u_blur*u_dir.x, tcoord.y - 3.0*u_blur*u_dir.y)) * 0.0540540541;
	sum += texture2D(tex0, vec2(tcoord.x - 2.0*u_blur*u_dir.x, tcoord.y - 2.0*u_blur*u_dir.y)) * 0.1216216216;
	sum += texture2D(tex0, vec2(tcoord.x - 1.0*u_blur*u_dir.x, tcoord.y - 1.0*u_blur*u_dir.y)) * 0.1945945946;

	sum += texture2D(tex0, vec2(tcoord.x, tcoord.y)) * 0.2270270270;

	sum += texture2D(tex0, vec2(tcoord.x + 1.0*u_blur*u_dir.x, tcoord.y + 1.0*u_blur*u_dir.y)) * 0.1945945946;
	sum += texture2D(tex0, vec2(tcoord.x + 2.0*u_blur*u_dir.x, tcoord.y + 2.0*u_blur*u_dir.y)) * 0.1216216216;
	sum += texture2D(tex0, vec2(tcoord.x + 3.0*u_blur*u_dir.x, tcoord.y + 3.0*u_blur*u_dir.y)) * 0.0540540541;
	sum += texture2D(tex0, vec2(tcoord.x + 4.0*u_blur*u_dir.x, tcoord.y + 4.0*u_blur*u_dir.y)) * 0.0162162162;

	gl_FragColor = bright * sum;
}