extends PathFollow2D


class_name EnemyBase


@export var health: float = 10.0
@export var speed: float = 50.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 0.99:
		queue_free()



func die() -> void:
	queue_free()



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is PlayerBulletBase:
		health -= area.get_dmg()
		if health <= 0:
			die()
