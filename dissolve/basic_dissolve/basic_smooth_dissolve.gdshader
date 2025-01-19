shader_type canvas_item;

uniform sampler2D noise_sampler : repeat_enable;
uniform float dissolve : hint_range(0.0, 1.0, 0.1) = 0.0;
uniform float smoothness : hint_range(0.0, 1.0, 0.01) = 0.1;

float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

void fragment() {
	float mask = texture(noise_sampler, UV).x;
	float mapped_dissolve = map(dissolve, 0.0, 1.0, - smoothness, 1.0 + smoothness);
	COLOR.a *= smoothstep( - smoothness, + smoothness, mask - mapped_dissolve);
}