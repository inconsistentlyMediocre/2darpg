shader_type canvas_item;


const float EPSILON = 0.0001;

uniform vec4 reflectable_color : source_color;


void fragment() {
	if (
		COLOR.r <= reflectable_color.r + EPSILON &&
		COLOR.r >= reflectable_color.r - EPSILON &&
		COLOR.g <= reflectable_color.g + EPSILON &&
		COLOR.g >= reflectable_color.g - EPSILON &&
		COLOR.b <= reflectable_color.b + EPSILON &&
		COLOR.b >= reflectable_color.b - EPSILON 
		) {
		
	} else {
		COLOR.a = 0.0;
	}
	//vec4 current_color = texture(TEXTURE, UV);
	//uvec4 uint_current_color = uvec4(round(current_color * 255.0));
	//uvec4 uint_reflectable_color = uvec4(round(reflectable_color * 255.0));
	
	//if (uint_current_color != uint_reflectable_color) {
		//COLOR.a = 0.0;
	//}
	//COLOR.rgb = vec3(255.0, 255.0, 255.0);
}
