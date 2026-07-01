extends EnemyBase

@onready var timer_fire_rate: Timer = $timer_fireRate
@onready var timer_stop: Timer = $timer_stop


var prim_bullet_speed_multi: float = 0.5
var prim_bullet_fire_rate: float = 0.3
var prim_bullet_dmg: float = 10.0
var stop_time: float = 1.0
var ship_speed: float = 300.0


var can_shoot: bool = false
var has_stopped: bool = false
var can_move: bool = true

var _path: Path2D = null
var _stop_point: Vector2 = Vector2(0,0)
var _stop_progress: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = ship_speed
	enemy_visuals.show()
	_path = get_parent()
	_stop_point = _path.curve.get_point_position(1)
	_stop_progress = _path.curve.get_closest_offset(_stop_point) - 10
	timer_stop.wait_time = stop_time
	timer_fire_rate.wait_time = prim_bullet_fire_rate
	timer_fire_rate.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress >= _stop_progress and has_stopped == false:
		if can_move == true:
			timer_stop.start()
		can_move = false
		can_shoot = true
	if can_move == true:
		super(delta)

## Makes the enemy "shoot" an EnemyBullet scene from the enemies location in the left direction ONLY if the can_shoot boolean is true, then starts the fire_rate timer.
## Called by: EnemyShip.gd in _on_timer_fire_rate_timeout()
func shoot() -> void:
	if can_shoot == true:
		SignalHub.emit_on_create_enemy_bullet(Vector2(global_position.x,global_position.y), Vector2.LEFT, prim_bullet_speed_multi, EnemyBulletBase.BulletType.Regular, prim_bullet_dmg)
		can_shoot = false
		timer_fire_rate.start()

## When the timer finishes based on the prim_bullet_fire_rate, then call the shoot() function
func _on_timer_fire_rate_timeout() -> void:
	if dead == false and can_shoot == true:
		shoot()
	timer_fire_rate.wait_time = prim_bullet_fire_rate

## Once the enemy stops in its stationary position for stop_time amount, then make enemy unable to shoot and start moving again.
func _on_timer_stop_timeout() -> void:
	has_stopped = true
	can_move = true
	can_shoot = false
	enemy_visuals.rotation_degrees = 90
