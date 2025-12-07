shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 0.333, 1.0);
uniform float glow_intensity : hint_range(0.0, 3.0) = 1.5;
uniform float glow_size : hint_range(0.0, 10.0) = 3.0;

void fragment() {
	vec4 original = texture(TEXTURE, UV);

	// Sample surrounding pixels for glow
	float glow = 0.0;
	float samples = 0.0;

	for (float x = -glow_size; x <= glow_size; x += 1.0) {
		for (float y = -glow_size; y <= glow_size; y += 1.0) {
			vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
			glow += texture(TEXTURE, UV + offset).a;
			samples += 1.0;
		}
	}

	glow = glow / samples * glow_intensity;

	// Combine glow with original
	vec4 glow_layer = glow_color * glow;
	COLOR = mix(glow_layer, original, original.a);
	COLOR.a = max(glow_layer.a, original.a);
}
