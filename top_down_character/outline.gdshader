shader_type canvas_item;

uniform vec2 viewport_scale = vec2(1.0);
uniform vec4 line_color : source_color = vec4(1);
uniform float line_thickness = 0.5;

const vec2 OFFSETS[24] = { vec2(1, 0), vec2(0.97, 0.26), vec2(0.87, 0.5), vec2(0.71, 0.71), vec2(0.5, 0.87), vec2(0.26, 0.97), vec2(0, 1), vec2(-0.26, 0.97), vec2(-0.5, 0.87), vec2(-0.71, 0.71), vec2(-0.87, 0.5), vec2(-0.97, 0.26), vec2(-1, 0), vec2(-0.97, -0.26), vec2(-0.87, -0.5), vec2(-0.71, -0.71), vec2(-0.5, -0.87), vec2(-0.26, -0.97), vec2(0, -1), vec2(0.26, -0.97), vec2(0.5, -0.87), vec2(0.71, -0.71), vec2(0.87, -0.5), vec2(0.97, -0.26)
};

float outline(vec2 size, vec2 uv, sampler2D color){
	float outline = 0.0;
	for(int i = 0; i < OFFSETS.length(); i++){
		outline += texture(color, uv + size * OFFSETS[i]).a;
	}
	return min(outline, 1.0);
}

void vertex() {
	VERTEX += (UV * 2.0 - 1.0) * line_thickness;
}

void fragment() {
	vec2 uv = UV;
	vec2 size = (TEXTURE_PIXEL_SIZE * line_thickness) * viewport_scale;

	float outline_mask = outline(
		size,
		uv,
		TEXTURE
	);

	outline_mask = min(outline_mask, 1.0);

	vec4 screen_color = texture(TEXTURE, UV);
	COLOR.rgb = mix(line_color.rgb, screen_color.rgb, screen_color.a);
	COLOR.a = outline_mask;
}
