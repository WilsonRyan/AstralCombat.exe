extends EnemyBase


@export var spin_speed: float = 1.0
@onready var sprite_2d: Sprite2D = $EnemyVisuals/sprite_2d





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	spin()



func spin() -> void:
	sprite_2d.rotation_degrees += spin_speed
	hitbox.rotation_degrees += spin_speed
