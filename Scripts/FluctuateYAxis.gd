@tool
extends Node3D

@export var min_Y_value: float = 0.0
@export var max_Y_value: float = 1.0
@export var speed: float = 1.0  # Adjusts the speed of fluctuation

var _time: float = 0.0  # Tracks time for fluctuation

func _physics_process(delta: float) -> void:
	# Increment time based on speed
	_time += delta * speed
	
	# Calculate sine wave-based Y position
	var fluctuation = (sin(_time) + 1.0) / 2.0  # Normalize sine output to [0, 1]
	var new_y = lerp(min_Y_value, max_Y_value, fluctuation)
	
	# Update the position
	position.y = new_y
