shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 color : source_color;
uniform vec3 emission_color : source_color;
uniform float emission_strength : hint_range(0.0, 10.0);
uniform float effector_range : hint_range(0.0, 5.0) = 1.0;
uniform float effector_strength : hint_range(0.0, 2.0);
uniform vec3 dimensions;
uniform vec3 effector;

varying float proximity;

void vertex() {
	vec3 baked_pivot;
	
	// Getting the pivots from the 2D UV coords
	baked_pivot.x = UV.x * dimensions.x - dimensions.x / 2.0;
	baked_pivot.y = (1.0 - UV.y) * dimensions.y;
	baked_pivot.z = (1.0 - UV2.x) * dimensions.z - dimensions.z / 2.0;
	
	// World space conversion
	baked_pivot = (MODEL_MATRIX * vec4(baked_pivot, 1.0)).xyz;
	
	vec3 force = baked_pivot - effector;
	vec3 dir = normalize(force);
	proximity = length(force);
	
	proximity = 1.0 - smoothstep(0, effector_range, proximity);
	
	VERTEX += dir * effector_strength * proximity;
}

void fragment() {
	ALBEDO = color;
	EMISSION = emission_color * proximity * emission_strength;
}
