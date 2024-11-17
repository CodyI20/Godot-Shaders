shader_type spatial;
render_mode unshaded, shadows_disabled;
#include "funcs.gdshaderinc"

void fragment(){
	float n = random2_1(SCREEN_UV);
	
	ALBEDO = vec3(n);
}
