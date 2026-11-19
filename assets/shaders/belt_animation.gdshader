shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;
uniform int border_size:hint_range(0, 50, 1)=13;

void fragment() {
	ivec2 tex_size=textureSize(TEXTURE,0);
	vec2 pixel_pos=UV*vec2(tex_size);
	float EPSILON=0.1;
	vec2 uv=UV;

	if (pixel_pos.x>float(border_size)+EPSILON&&pixel_pos.x<float(tex_size.x-border_size)-EPSILON) {
		uv.y=fract(uv.y+speed*TIME);
	}

	vec4 col=texture(TEXTURE,uv);
	COLOR=col;
}
