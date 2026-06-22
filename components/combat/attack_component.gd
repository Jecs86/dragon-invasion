class_name AttackComponent extends Node2D

@export var spawner: Node2D
@export var active := true

func _ready() -> void:
	_update_pattern_state()
	
func alternate_attack(turned_on: bool) -> void:
	active = turned_on
	_update_pattern_state()
	
func _update_pattern_state() -> void:
	if spawner:
		if active:
			spawner.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			spawner.process_mode = Node.PROCESS_MODE_DISABLED
