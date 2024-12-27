/*
	Camera Shake Effect Shader by @Near

	MIT License
*/
#define iTime TIME
#define fragColor COLOR
shader_type canvas_item;

uniform float ShakeStrength = 0;
uniform vec2 FactorA  = vec2(100.0,100.0);
uniform vec2 FactorB  = vec2(1.0,1.0);
uniform vec2 magnitude = vec2(0.01,0.01);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 uv = UV;
	uv -= 0.5;
    uv *= 1.0 - 2.0 * magnitude.x;
    uv += 0.5;
	vec2 dt = vec2(0.0, 0.0);
	dt.x = sin(iTime * FactorA.x+FactorB.x) * magnitude.x;
	dt.y = cos(iTime *FactorA.y+ FactorB.y) * magnitude.y;
	fragColor = texture(SCREEN_TEXTURE,uv + (dt*ShakeStrength));
}
