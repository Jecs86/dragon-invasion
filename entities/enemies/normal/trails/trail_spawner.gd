class_name TrailSpawner extends Node2D

@export var enemy_scene: PackedScene
@export var amounth_of_enemies: int = 5
@export var pixel_distance: float = 60.0

@export_group("Trail Pattern Configuration")
@export var trail_pattern: EnemyBehaviorComponent.PatternType = EnemyBehaviorComponent.PatternType.POLYGON
@export var sides: int = 5
@export var polygon_radius: float = 150.0

var trail_center: Vector2
var polygon_vertices: Array[Vector2] = []
var x_stop_position: float = 0.0

var generated_enemies: int = 0
var timer_spawn: Timer

func _ready() -> void:
	x_stop_position = randf_range(500.0, 600.0)
	trail_center = Vector2(x_stop_position, global_position.y)
	
	if trail_pattern == EnemyBehaviorComponent.PatternType.POLYGON:
		_calculate_trail_route()
	
	timer_spawn = Timer.new()
	add_child(timer_spawn)
	timer_spawn.timeout.connect(_drop_enemy)
	
	_drop_enemy()
	
func _drop_enemy() -> void:
	if generated_enemies >= amounth_of_enemies:
		timer_spawn.stop()
		queue_free()
		return
	
	var new_enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child(new_enemy)
	new_enemy.global_position = global_position
	
	var behavior = new_enemy.get_node("EnemyBehaviorComponent")
	if behavior:
		behavior.follower_config(
			trail_center,
			polygon_vertices,
			trail_pattern,
			x_stop_position
		)
		
		if generated_enemies == 0:
			var calculated_time = pixel_distance / behavior.movement_velocity
			timer_spawn.wait_time = calculated_time
			timer_spawn.start()
	
	generated_enemies += 1

func _calculate_trail_route() -> void:
	polygon_vertices.clear()
	var real_sides = max(3, sides)
	var angle_increment = TAU / real_sides
	
	for i in range(real_sides):
		var vertex_angle = (i * angle_increment) - (PI / 2.0)
		var x = trail_center.x + cos(vertex_angle) * polygon_radius
		var y = trail_center.y + sin(vertex_angle) * polygon_radius
		polygon_vertices.append(Vector2(x,y))
