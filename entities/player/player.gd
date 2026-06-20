extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovemenetComponent
@onready var health_component: HealthComponent = %HealthComponent

func _physics_process(delta: float) -> void:
	
	input_component.update()
	
	movement_component.direction = input_component.direction
	movement_component.tick()
	
	
