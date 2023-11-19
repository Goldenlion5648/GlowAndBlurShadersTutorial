shader_type canvas_item;

uniform vec2 border_threshold = vec2(0.01, 0.01);

bool is_on_border(sampler2D TEXTURE2, vec2 uv) {
	vec4 color_up = texture(TEXTURE2, uv + vec2(0.0, border_threshold.y));
	vec4 color_down = texture(TEXTURE2, uv + vec2(0.0, -border_threshold.y));
	vec4 color_left = texture(TEXTURE2, uv + vec2(-border_threshold.x, 0.0));
	vec4 color_right = texture(TEXTURE2, uv + vec2(border_threshold.x, 0.0));
	
	bool is_next_to_transparent = color_up.a < 1.0 || color_down.a < 1.0 ||
									color_left.a < 1.0 || color_right.a < 1.0;
	bool is_next_to_solid = color_up.a == 1.0 || color_down.a == 1.0 ||
							color_left.a == 1.0 || color_right.a == 1.0;
	
	return is_next_to_transparent && is_next_to_solid;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (is_on_border(TEXTURE, UV)) {
		COLOR = vec4(1.0, 0.3 + sin(TIME) / 3.0, 0, 1);
	} else {
		COLOR = color;
	}
	
}
