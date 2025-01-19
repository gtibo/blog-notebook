shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise_sampler : repeat_enable;
uniform float dissolve : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	float mask = texture(noise_sampler, UV + TIME * 0.1).x;
	float edge = mask * UV.y - dissolve;
	ALPHA = edge;
	ALPHA_SCISSOR_THRESHOLD = 0.0;
	ALBEDO = vec3(0.5);
	ROUGHNESS = 0.5;
}