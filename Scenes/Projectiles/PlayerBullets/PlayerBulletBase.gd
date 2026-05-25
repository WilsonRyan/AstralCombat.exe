extends Area2D



class_name PlayerBulletBase
enum BulletType { Primary, Alternate, Ultimate }



@export var _direction: Vector2 = Vector2.RIGHT
@export var _speed: float = 400.0
@export var _dmg: float = 5.0

var can_shoot: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += delta * _direction * _speed



func setup(speed_multi: float) -> void:
	_speed = _speed * speed_multi

func get_dmg() -> float:
	return _dmg



func _on_area_entered(_area: Area2D) -> void:
	queue_free()
