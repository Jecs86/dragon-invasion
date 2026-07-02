class_name PolygonPattern extends MovementPattern

@export_range(3, 12) var sides: int = 3
@export var polygon_radius: float = 150.0

var vertices: Array[Vector2] = []
var current_index: int = 0

func setup_pattern(center: Vector2) -> void:
	vertices.clear()
	var real_sides = max(3, sides)
	var angle_increment = TAU / real_sides
	
	for i in range(real_sides):
		var vertex_angle = (i * angle_increment) - (PI / 2.0)
		var x = center.x + cos(vertex_angle) * polygon_radius
		var y = center.y + sin(vertex_angle) * polygon_radius
		vertices.append(Vector2(x, y))
		

func get_velocity(body: CharacterBody2D, delta: float, time: float, center: Vector2, speed: float) -> Vector2:
	if vertices.is_empty():
		return Vector2.ZERO
		
	var target: Vector2 = vertices[current_index]
	var direction: Vector2 = body.global_position.direction_to(target)
	var velocity = direction * speed
	
	if body.global_position.distance_to(target) < 10.0:
		current_index = (current_index + 1) % vertices.size()
		
	return velocity
