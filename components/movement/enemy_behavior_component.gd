class_name EnemyBehaviorComponent extends Node

# States of the movement
enum States { ENTERING, PATTERN, LEAVING }
var current_state: States = States.ENTERING

# Pattern movements
enum PatternType { WAVE, POLYGON, CIRCLE}
@export var pattern_selected: PatternType = PatternType.WAVE

# Character variables
@export var body: CharacterBody2D
@export var movement_velocity: float = 200.0
@export var screen_time: float = 10.00

# Wave variables
@export_group("Wave Config")
@export var wave_amplitude: float = 80.0
@export var wave_frecuency: float = 4.0

# Polygon variables
@export_group("Polygon Config")
@export_range(3, 12) var sides: int = 3
@export var polygon_radius: float = 150.0
var vertices: Array[Vector2] = []
var current_index: int = 0

# Circle variables
@export_group("Circle Config")
@export var circle_radius: float = 100.0
@export var angular_velocity: float = 3.0
var current_angle: float = 0.0

# internal variables
var pattern_center: Vector2 = Vector2.ZERO
var accumulated_time: float = 0.0
var pattern_chronometer: float = 0.0
var x_stop_position: float = 0.0

func _ready() -> void:
	if body:
		x_stop_position = randf_range(500.0, 700.0)
		
func tick(delta: float) -> void:
	if not body:
		return
	
	match current_state:
		States.ENTERING:
			_entry_logic()
		States.PATTERN:
			_pattern_logic(delta)
		States.LEAVING:
			_leaving_logic()
	
	body.move_and_slide()

func _entry_logic() -> void:
	body.velocity = Vector2(-movement_velocity, 0)
	
	if body.global_position.x <= x_stop_position:
		current_state = States.PATTERN
		pattern_center = body.global_position
		
		if pattern_selected == PatternType.POLYGON:
			_calculate_polygon_vertices()
		

func _pattern_logic(delta: float) -> void:
	pattern_chronometer += delta
	accumulated_time += delta
	
	match pattern_selected:
		PatternType.WAVE:
			_wave_movement(delta)
		PatternType.POLYGON:
			_polygon_movement()
		PatternType.CIRCLE:
			_circle_movement(delta)
	
	if pattern_chronometer >= screen_time:
		current_state = States.LEAVING
	
func _leaving_logic() -> void:
	body.velocity.y = 0
	body.velocity.x = -movement_velocity * 1.5
	
func _wave_movement(delta: float) -> void:
	body.velocity.x = 0
	var new_y = pattern_center.y + sin(accumulated_time * wave_frecuency) * wave_amplitude
	body.velocity.y = (new_y - body.global_position.y) / delta

func _calculate_polygon_vertices() -> void:
	vertices.clear()
	var real_sides = max(3, sides)
	var angle_increment = TAU / real_sides
	
	for i in range(real_sides):
		var vertex_angle = (i * angle_increment) - (PI / 2.0)
		var x = pattern_center.x + cos(vertex_angle) * polygon_radius
		var y = pattern_center.y + sin(vertex_angle) * polygon_radius
		vertices.append(Vector2(x,y))
	

func _polygon_movement() -> void:
	if vertices.is_empty():
		return
	
	var target: Vector2 = vertices[current_index]
	var direction: Vector2 = body.global_position.direction_to(target)
	body.velocity = direction * movement_velocity
	
	if body.global_position.distance_to(target) < 10.0:
		current_index = (current_index + 1) % vertices.size()
	
func _circle_movement(delta: float) -> void:
	current_angle += angular_velocity * delta
	
	var target_x = pattern_center.x + cos(current_angle) * circle_radius
	var target_y = pattern_center.y + sin(current_angle) * circle_radius
	var target_position = Vector2(target_x, target_y)
	
	var direction: Vector2 = body.global_position.direction_to(target_position)
	body.velocity = direction * movement_velocity
