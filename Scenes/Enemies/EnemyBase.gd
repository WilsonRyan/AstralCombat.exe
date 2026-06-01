extends PathFollow2D


class_name EnemyBase
enum EnemyType { EnemyShip, Asteroid }

@onready var hitbox: Area2D = $EnemyVisuals/Hitbox
@onready var enemy_visuals: Node2D = $EnemyVisuals

@export var health: float = 10.0
@export var speed: float = 50.0
@export var difficulty: float = 1.0

var dead: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 0.999:
		SignalHub.emit_on_enemy_dequeue(get_difficulty())
		queue_free()


func get_difficulty() -> float:
	return difficulty

func die() -> void:
	enemy_visuals.hide()
	dead = true
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is PlayerBulletBase:
		health -= area.get_dmg()
		if health <= 0:
			die()
