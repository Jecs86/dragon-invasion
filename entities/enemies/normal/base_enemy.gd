class_name BaseEnemy extends CharacterBody2D

@onready var health_component: HealthComponent = %HealthComponent
@onready var attack_component: AttackComponent = %AttackComponent
@onready var enemy_behavior_component: EnemyBehaviorComponent = %EnemyBehaviorComponent

var movement: Vector2 = Vector2.LEFT

func _ready() -> void:
	if get_parent() is Squadron:
		if enemy_behavior_component:
			enemy_behavior_component.queue_free()


func _physics_process(delta: float) -> void:
	if enemy_behavior_component:
		enemy_behavior_component.tick(delta)
	
	attack_component.alternate_attack(true)
