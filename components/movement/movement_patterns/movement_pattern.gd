class_name MovementPattern extends Resource

func setup_pattern(center: Vector2) -> void:
	pass
	
func get_velocity(body: CharacterBody2D, delta: float, time:float, center: Vector2, speed: float) -> Vector2:
	return Vector2.ZERO
