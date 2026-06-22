class_name InputComponent extends Node

var direction: Vector2 = Vector2.ZERO
var attack := false

func update() -> void:
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	attack = Input.is_action_pressed("attack")
	
