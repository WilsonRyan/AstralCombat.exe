extends EnemyBase

@onready var timer_fire_rate: Timer = $timer_fireRate


@export var prim_bullet_speed_multi: float = 0.5
@export var prim_bullet_fire_rate: float = 3.0
@export var prim_bullet_dmg: float = 10.0


var can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_fire_rate.wait_time = prim_bullet_fire_rate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dead == false:
		shoot()
	super(delta)


func shoot() -> void:
	if can_shoot == true:
		SignalHub.emit_on_create_enemy_bullet(Vector2(global_position.x,global_position.y), Vector2.LEFT, prim_bullet_speed_multi, EnemyBulletBase.BulletType.Regular, prim_bullet_dmg)
		can_shoot = false
		timer_fire_rate.start()


func _on_timer_fire_rate_timeout() -> void:
	can_shoot = true
	timer_fire_rate.wait_time = prim_bullet_fire_rate
