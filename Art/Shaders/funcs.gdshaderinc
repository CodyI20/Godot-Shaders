float remap (float value, float i_min, float i_max, float o_min, float o_max){
	return o_min + ((value - i_min) / (i_max-i_min) * (o_max - o_min));
}

vec2 remapVec2(vec2 value, float i_min, float i_max, float o_min, float o_max){
	vec2 remappedVec;
	remappedVec.x = o_min + ((value.x - i_min) / (i_max-i_min) * (o_max - o_min));
	remappedVec.y = o_min + ((value.y - i_min) / (i_max-i_min) * (o_max - o_min));
	return remappedVec;
}

float saturate (float value) {
	return clamp (value, 0, 1);
}

vec2 rotation (vec2 uv, vec2 center, float angle){
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),vec2(sin(angle), cos(angle)));
	uv -= center;
	uv *= rotation;
	uv *= center;
	return uv;
}

float fresnel(float power, vec3 normal, vec3 view){
	return pow(1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0), power);
}

float random(float x){
	return fract(sin(x*12.9898 + 78.233) * 43758.5453);
}

float random2_1(vec2 uv){
	return fract(sin(dot(uv.xy + vec2(sin(TIME), cos(TIME)), vec2(12.9898,78.233)))*43758.5453123);
}