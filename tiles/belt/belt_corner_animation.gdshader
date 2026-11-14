shader_type canvas_item;

uniform float speed:hint_range(0.0, 10.0, 0.1)=1.0;

void fragment() {
    vec2 uv=UV;
	float radius=0.5;
    vec2 center=vec2(1.0,1.0);
    vec2 p=uv-center;
    float r=length(p);
    float angle=atan(p.y,p.x);
    if (angle<0.0) {
        angle+=TAU;
    }
    float progress=(angle-PI)/(PI/2.0);
    float inner_radius=radius-0.5;
    float outer_radius=radius+0.5;
    if (r<inner_radius||r>outer_radius||progress<0.0||progress>1.0) {
        discard;
    }
    float across=outer_radius-r;
    float along=fract(progress+speed*TIME);

    vec2 sample_uv=vec2(across,along);
    COLOR=texture(TEXTURE,sample_uv);
}
