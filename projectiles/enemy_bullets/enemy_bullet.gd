extends Node2D

@export var velocity: float = 600.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)

func _process(delta: float) -> void:
	global_position += direction * velocity * delta
