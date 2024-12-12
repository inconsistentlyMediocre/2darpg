shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D screen_sampler : hint_screen_texture;
uniform vec4 reflectable_color : source_color;

void fragment() {
	vec4 screen = texture(screen_sampler, SCREEN_UV);
	////vec4 screen = textureLod(screen_sampler, SCREEN_UV, 0.0);
	//if (screen.rgb != reflectable_color.rgb) {
		//screen.a = 0.0;
		////screen.rgb = vec3(0.0, 1.0, 0.0);
	//}
	screen.r = 0.0;
	screen.b = 0.0;
	COLOR.rgb = screen.rgb;


}