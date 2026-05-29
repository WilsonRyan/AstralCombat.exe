extends Area2D



class_name EnemyBulletBase
enum BulletType { Regular }


@export var _direction: Vector2 = Vector2.LEFT
@export var _speed: float = 400.0
@export var _dmg: float = 10.0

var can_shoot: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += delta * _direction * _speed



func setup(dir: Vector2, speed_multi: float, dmg: float) -> void:
	_speed = _speed * speed_multi
	_direction = dir
	_dmg = dmg

func get_dmg() -> float:
	return _dmg



func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		SignalHub.emit_on_player_hit(get_dmg())
		queue_free()
