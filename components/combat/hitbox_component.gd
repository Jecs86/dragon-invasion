class_name HitboxComponent extends Area2D

@export var damage: int = 1

func _ready() -> void:
	monitorable = true
	monitoring = false
