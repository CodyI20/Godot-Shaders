@tool
extends MeshInstance3D
@export var effector : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mat: ShaderMaterial = get_active_material(0)
	mat.set_shader_parameter("dimensions", get_aabb().size)
	if effector:
		mat.set_shader_parameter("effector", effector.global_position)
