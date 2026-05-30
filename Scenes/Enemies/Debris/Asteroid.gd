extends EnemyBase


@export var spin_speed: float = 1.0
@onready var sprite_2d: Sprite2D = $sprite_2d
@onready var hitbox: Area2D = $Hitbox

@export var difficulty: float = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	spin()


func get_difficulty() -> float:
	return difficulty


func spin() -> void:
	sprite_2d.rotation_degrees += spin_speed
	hitbox.rotation_degrees += spin_speed
