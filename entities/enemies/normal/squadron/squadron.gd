class_name Squadron extends CharacterBody2D

@onready var enemy_behavior_component: EnemyBehaviorComponent = %EnemyBehaviorComponent

func _physics_process(delta: float) -> void:
	if enemy_behavior_component:
		enemy_behavior_component.tick(delta)
