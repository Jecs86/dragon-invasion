class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var model: Node2D
@export var speed := 300

var direction: Vector2 = Vector2.ZERO

func tick() -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed
	body.velocity.y = direction.y * speed
	
	body.move_and_slide()
