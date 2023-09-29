shader_type canvas_item;

//uniform -> export the value in inspector
uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.0001);

void fragment()
{
	//mix -> mix(vec4 -> base color, vec4 -> target color, percent of the target color)
	COLOR = mix(COLOR, vec4(color,COLOR[3]), progress);
}
