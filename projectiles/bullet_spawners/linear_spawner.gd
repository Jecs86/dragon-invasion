class_name LinearSpawner extends Node2D

@export var bullet_scene: PackedScene
@export var cannons: int = 1
@export var opening_angle: float = 15.0
@export var cadence: float = 0.1

var fire_timer: Timer

func _ready() -> void:
	fire_timer = Timer.new()
	fire_timer.wait_time = cadence
	fire_timer.autostart = true
	fire_timer.timeout.connect(shoot)
	add_child(fire_timer)

func shoot() -> void:
	if not bullet_scene:
		return
		
	if cannons == 1:
		_projectile_instantiate(0.0)
		return
		
	var total_arc = opening_angle * (cannons - 1)
	var initial_angle = -total_arc / 2.0
	
	for i in range(cannons):
		var deviation_angle = initial_angle + (i * opening_angle)
		_projectile_instantiate(deviation_angle)
		
func _projectile_instantiate(deviation_angle: float) -> void:
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position
	
	var rotated_direction = Vector2.RIGHT.rotated(deg_to_rad(deviation_angle))
	new_bullet.direction = rotated_direction
	new_bullet.rotation = rotated_direction.angle()
	
	get_tree().current_scene.add_child(new_bullet)
