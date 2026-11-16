shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;

void fragment() {
	vec2 uv=UV;
	uv.y=fract(uv.y+speed*TIME);
	vec4 col=texture(TEXTURE,uv);
	COLOR=col;
}
