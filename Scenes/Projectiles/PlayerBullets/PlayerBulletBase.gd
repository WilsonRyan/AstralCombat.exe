extends Area2D



class_name PlayerBulletBase
enum BulletType { Primary, Alternate, Ultimate }


@export var _direction: Vector2 = Vector2.RIGHT

var _speed: float = 400.0
var _dmg: float = 5.0

var can_shoot: bool = true

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += delta * _direction * _speed

## Sets up the bullet speed and dmg
## Called by: ObjectMaker.gd in on_create_player_bullet(pos, speed_multi, dmg, bullet_type)
func setup(speed_multi: float, dmg: float) -> void:
	_speed = _speed * speed_multi
	_dmg = dmg

## Returns the dmg of the bullet
## Called by: EnemyBase.gd in  _on_hitbox_area_entered(area)
func get_dmg() -> float:
	return _dmg


## Removes the bullet when it hits something
func _on_area_entered(_area: Area2D) -> void:
	queue_free()
