class_name EnemyBehaviorComponent extends Node

# States of the movement
enum States { ENTERING, PATTERN, LEAVING }
var current_state: States = States.ENTERING

# Pattern movements
@export var pattern_selected: MovementPattern

# Character variables
@export var body: CharacterBody2D
@export var movement_velocity: float = 200.0
@export var screen_time: float = 10.00

# internal variables
var pattern_center: Vector2 = Vector2.ZERO
var accumulated_time: float = 0.0
var pattern_chronometer: float = 0.0
var x_stop_position: float = 0.0
var shared_route := false

func _ready() -> void:
	if body:
		x_stop_position = randf_range(500.0, 600.0)
	
	if pattern_selected:
		pattern_selected = pattern_selected.duplicate()
	

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
		
		if not shared_route:
			pattern_center = body.global_position
		
		if pattern_selected:
			pattern_selected.setup_pattern(pattern_center)
		

func _pattern_logic(delta: float) -> void:
	pattern_chronometer += delta
	accumulated_time += delta
	
	if pattern_selected:
		body.velocity = pattern_selected.get_velocity(body,delta,accumulated_time,pattern_center,movement_velocity)
	
	if pattern_chronometer >= screen_time:
		current_state = States.LEAVING
	
func _leaving_logic() -> void:
	body.velocity.y = 0
	body.velocity.x = -movement_velocity * 1.5
	

func follower_config(master_center: Vector2, master_pattern: MovementPattern, master_stop_point: float) -> void:
	pattern_center = master_center
	pattern_selected = master_pattern.duplicate(true)
	x_stop_position = master_stop_point
	shared_route = true
	
