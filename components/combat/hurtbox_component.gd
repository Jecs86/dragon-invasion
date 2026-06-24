class_name HurtboxComponent extends Area2D

signal damage_taken(amounth: int)

@export var health_component: HealthComponent

func _ready() -> void:
	monitorable = false
	monitoring = true
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		inflict_damage(area.damage)
		
		var bullet = area.get_parent()
		if bullet and bullet is EnemyBullet:
			bullet.queue_free()

func inflict_damage(amounth: int) -> void:
	if health_component:
		health_component.take_damage(amounth)
		damage_taken.emit(amounth)
