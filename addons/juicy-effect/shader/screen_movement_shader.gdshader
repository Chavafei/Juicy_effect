/*
	Camera Shake Effect Shader by @Near

	MIT License
*/

shader_type canvas_item;
uniform float ShakeStrength = 0;
uniform vec2 uv_offset;
uniform float uv_rotation_offset = 0.0;
uniform vec2 pivot = vec2(0.5,0.5);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

vec2 rotateUV(vec2 uv, vec2 p, float rotation) {
    float sine = sin(rotation);
    float cosine = cos(rotation);

    uv -= p;
    uv.x = uv.x * cosine - uv.y * sine;
    uv.y = uv.x * sine + uv.y * cosine;
    uv += p;

    return uv;
}

void fragment() {
    vec2 uv = SCREEN_UV;

	uv += uv_offset;
	float rot = radians(uv_rotation_offset);
	vec2 rotated_uv = rotateUV(uv, pivot, rot);

	COLOR = texture(SCREEN_TEXTURE,rotated_uv);
}
