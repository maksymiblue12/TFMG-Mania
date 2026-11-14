shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;

void fragment() {
	vec2 uv=UV;
    uv=1.0-uv;
	float offset=1.0-sqrt(max(0.0,1.0-uv.y*uv.y));
	uv.x-=offset;
	uv.y=fract(uv.y+speed*TIME);
	if (dot(uv,uv)>1.0) {
		discard;
	}
	uv.y-=0.5;
	vec4 col=texture(TEXTURE,uv);
	COLOR=col;
}
