extends EnemyBase


var spin_speed: float = 1.0
@onready var sprite_2d: Sprite2D = $EnemyVisuals/sprite_2d





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	spin()


## Makes the asteroid spin at a set spin_speed amount, defined in each instance of each asteroid
## Called by: Asteroid.gd in _process(delta)
func spin() -> void:
	sprite_2d.rotation_degrees += spin_speed
	hitbox.rotation_degrees += spin_speed
