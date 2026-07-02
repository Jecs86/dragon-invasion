class_name WavePattern extends MovementPattern

@export var wave_amplitude: float = 80.0
@export var wave_frecuency: float = 4.0
@export var horizontal_movement : bool = false

func get_velocity(body: CharacterBody2D, delta: float, time:float, center: Vector2, speed: float) -> Vector2:
	var velocity = Vector2.ZERO
	velocity.x = 0
	
	if horizontal_movement:
		velocity.x = -speed
	
	var new_y = center.y + sin(time * wave_frecuency) * wave_amplitude
	velocity.y = (new_y - body.global_position.y) / delta
	return velocity
