shader_type spatial;
render_mode unshaded;

uniform vec3 albedo : source_color;
uniform float energy = 1.0;

void fragment() {
	ALBEDO = albedo * energy;
	ALPHA *= clamp(1.0 - (distance(UV, vec2(0.5)) * 2.0), 0.0, 1.0) * COLOR.a;
}