shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 0.333, 1.0);
uniform float glow_intensity : hint_range(0.0, 5.0) = 3.0;
uniform float glow_size : hint_range(1.0, 20.0) = 10.0;

void fragment() {
	vec4 original = texture(TEXTURE, UV);

	// Blur for glow effect with distance falloff
	float glow = 0.0;
	float total_weight = 0.0;

	for (float x = -glow_size; x <= glow_size; x += 1.0) {
		for (float y = -glow_size; y <= glow_size; y += 1.0) {
			float dist = length(vec2(x, y));
			if (dist <= glow_size) {
				float weight = 1.0 - (dist / glow_size);
				weight = weight * weight;
				vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
				glow += texture(TEXTURE, UV + offset).a * weight;
				total_weight += weight;
			}
		}
	}

	glow = (glow / total_weight) * glow_intensity;

	// Combine: glow behind, original on top
	vec4 glow_layer = glow_color * glow;
	COLOR = glow_layer + original;
	COLOR.a = clamp(glow_layer.a + original.a, 0.0, 1.0);
}
