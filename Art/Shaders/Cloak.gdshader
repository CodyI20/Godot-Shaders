shader_type spatial;
render_mode blend_add, cull_back, depth_draw_always;
#include "funcs.gdshaderinc"

uniform vec4 emission_color : source_color;
uniform float emission_amount: hint_range(0.0,16.0) = 5.0;
uniform float rim_sharpness: hint_range(0.0, 16.00) = 3.0;

void fragment() {
	EMISSION = emission_color.rgb * emission_amount;
	
	float fluctuating_rim_sharpness = remap(sin(TIME),-1,1,0,16);
	ALPHA = pow(1.0 - dot(NORMAL, VIEW), fluctuating_rim_sharpness) * emission_color.a;
}
