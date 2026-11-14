shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;

void fragment() {
	vec2 uv=UV;
	uv.x+=sqrt(1.0-uv.y*uv.y);
	if (!(uv.x<0.0||uv.x>1.0||uv.y<0.0||uv.y>1.0)) {
		discard;
	}
	uv.y=fract(uv.y+speed*TIME);
	uv.x=uv.x-sqrt(1.0-uv.y*uv.y);
	vec4 col=texture(TEXTURE,uv);
	COLOR=col;
}
