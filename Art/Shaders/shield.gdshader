shader_type spatial;
render_mode shadows_disabled;
#include "funcs.gdshaderinc"

uniform vec3 fresnel_color : source_color;
uniform vec3 border_color : source_color;
uniform sampler2D shield_texture;

uniform float _fresnel_power: hint_range(1,8) = 5.0;
uniform float _rotation : hint_range(0.0, 1.0);
uniform float _panning : hint_range(0.0, 1.0);
uniform float _displacement : hint_range(0.0, 0.01);

uniform sampler2D _noise;
varying float noise;

void vertex(){
	vec2 uv_normal = remapVec2(NORMAL.xy, -1, 1, 0, 1);
	uv_normal = rotation(uv_normal, vec2(1), TIME * _rotation);
	uv_normal += vec2(3,1) * TIME * _panning;
	noise = texture(_noise, uv_normal).r;
	VERTEX += noise * NORMAL * _displacement;
}

void fragment() {
	float bmask = texture(shield_texture, UV).r;
	vec3 color = border_color * bmask;
	float f = fresnel(_fresnel_power, NORMAL, VIEW);
	vec3 color2 = fresnel_color * f;
	vec3 rcolor = max(color,color2);
	ALBEDO = rcolor;
	EMISSION = rcolor * 12.;
	ALPHA = saturate(bmask * noise + f);
}
