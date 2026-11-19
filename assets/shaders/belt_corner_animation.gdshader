shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;
uniform int border_size:hint_range(0, 50, 1)=13;
uniform bool flip_y=false;

void fragment() {
	vec2 uv=UV;

	vec2 p=uv-vec2(1.0,1.0);
	float r=length(p);
	float angle=atan(p.y,p.x);
	if (angle<0.0) {
		angle+=TAU;
	}
	float progress=(angle-PI)/(PI/2.0);
	if (r<0.0||r>1.0||progress<0.0||progress>1.0) {
		discard;
	}
	float across=1.0-r;
	float along=progress;

	vec2 sample_uv=vec2(across,along);

	ivec2 tex_size=textureSize(TEXTURE,0);
	vec2 pixel_pos=sample_uv*vec2(tex_size);
	float EPSILON=0.1;

	if (pixel_pos.x>float(border_size)+EPSILON&&pixel_pos.x<float(tex_size.x-border_size)-EPSILON) {
		sample_uv.y=fract((flip_y?1.0-sample_uv.y:sample_uv.y)+speed*TIME);
	}

	COLOR=texture(TEXTURE,sample_uv);
}
