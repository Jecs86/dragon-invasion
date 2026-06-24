class_name BaseEnemy extends CharacterBody2D

@onready var health_component: HealthComponent = %HealthComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var attack_component: AttackComponent = %AttackComponent

var movement: Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	movement_component.direction = movement
	movement_component.tick()
	
	attack_component.alternate_attack(false)
