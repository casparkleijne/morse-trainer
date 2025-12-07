shader_type canvas_item;

uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float vignette_size : hint_range(0.0, 1.0) = 0.5;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);

	// Scanlines (interlaced effect)
	float scanline = sin(FRAGCOORD.y * 3.14159) * 0.5 + 0.5;
	scanline = mix(1.0, scanline, scanline_intensity);
	color.rgb *= scanline;

	// Vignette
	vec2 uv = SCREEN_UV * 2.0 - 1.0;
	float vignette = 1.0 - dot(uv * vignette_size, uv * vignette_size);
	vignette = clamp(vignette, 0.0, 1.0);
	vignette = mix(1.0, vignette, vignette_intensity);
	color.rgb *= vignette;

	COLOR = color;
}
