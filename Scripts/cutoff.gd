@tool
extends Node3D
@onready var cutoff_model: MeshInstance3D = $"Cutoff-model"
@onready var cutoff_point: Node3D = %"Cutoff-point"


func _process(delta: float) -> void:
	cutoff_model.material_override.set_shader_parameter("cutplane", cutoff_point.transform)
