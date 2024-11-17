shader_type spatial;
render_mode cull_disabled;

uniform sampler2D _albedo: source_color;
global uniform vec4 border_color: source_color;
uniform sampler2D _noise;
uniform float emission_strength;
uniform mat4 cutplane;

varying vec3 worldvertex;

void vertex() {
	// World to Local
	worldvertex = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	
	vec3 planeNormal = normalize(-cutplane[1].xyz);
	float planeDistance = dot(planeNormal, cutplane[3].xyz);
	float vertexDistance = dot(planeNormal, worldvertex);
	float dist = vertexDistance - planeDistance;
	//float dist = distance(planeDistance,vertexDistance);
	
	// NOISE
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	vec2 uv = clip_pos.xy / 5.0;
	
	uv += TIME * 0.03;
	float noise = texture(_noise, uv).r;
	dist += noise*0.3;
	
	if (dist <0.0) discard;
	
	// BORDER
	float border_dist = smoothstep(0.0, 0.3, dist);
	vec4 albedo_color = texture(_albedo, UV);
	ALBEDO = (mix(border_color, albedo_color, border_dist)).rgb;
	EMISSION = (mix(border_color * emission_strength, vec4(0.0), border_dist)).rgb;
}

