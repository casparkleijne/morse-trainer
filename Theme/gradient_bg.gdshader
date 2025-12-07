shader_type canvas_item;

uniform vec4 color_top : source_color = vec4(0.5, 0.0, 0.5, 1.0);
uniform vec4 color_bottom : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	COLOR = mix(color_top, color_bottom, UV.y);
}
