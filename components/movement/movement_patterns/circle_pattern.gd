class_name CirclePattern extends MovementPattern

@export var circle_radius: float = 100.0
@export var angular_velocity: float = 3.0
var current_angle: float = 0.0

func get_velocity(body: CharacterBody2D, delta: float, time:float, center: Vector2, speed: float) -> Vector2:
	current_angle += angular_velocity * delta
	var target_x = center.x + cos(current_angle) * circle_radius
	var target_y = center.y + sin(current_angle) * circle_radius
	var target_position = Vector2(target_x, target_y)
	var direction: Vector2 = body.global_position.direction_to(target_position)
	var velocity = direction * speed
	return velocity
