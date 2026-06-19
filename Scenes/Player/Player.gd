extends Area2D


class_name Player


@onready var timer_fire_rate: Timer = $timer_fireRate


var speed: float = 350.0
var prim_bullet_speed_multi: float = 1.0
var prim_bullet_fire_rate: float = 0.3
var prim_bullet_dmg: float = 3.0
var health: float = 100.0 

var can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_die.connect(on_player_die)
	SignalHub.on_player_selects_upgrade.connect(on_player_selects_upgrade)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position += input * delta * speed
	global_position.x = clamp(global_position.x, 0, get_viewport_rect().end.x)
	global_position.y = clamp(global_position.y, 0, get_viewport_rect().end.y)
	shoot()



func get_input() -> Vector2:
	var v = Vector2(Input.get_axis("ship-left","ship-right"), Input.get_axis("ship-up", "ship-down"))
	return v.normalized()

func shoot() -> void:
	if Input.is_action_pressed("ship-shoot"):
		if can_shoot == true:
			SignalHub.emit_on_create_player_bullet(Vector2(global_position.x,global_position.y), prim_bullet_speed_multi, prim_bullet_dmg, PlayerBulletBase.BulletType.Primary)
			can_shoot = false
			timer_fire_rate.start()

func die() -> void:
	print("PLAYER DEAD")
	queue_free()

func get_health() -> float:
	return health

func on_player_die() -> void:
	die()

func on_player_selects_upgrade(type: Upgrade.UpgradeType, amt: float) -> void:
	match type:
		Upgrade.UpgradeType.health:
			health += amt
			print("health up: ", amt)
		Upgrade.UpgradeType.dmg:
			prim_bullet_dmg += amt
			print("dmg up: ", amt)
		Upgrade.UpgradeType.mov_speed:
			speed += amt
			print("speed up: ", amt)
		


func _on_timer_fire_rate_timeout() -> void:
	can_shoot = true
	timer_fire_rate.wait_time = prim_bullet_fire_rate


func _on_area_entered(area: Area2D) -> void:
	if area is not EnemyBulletBase:
		SignalHub.emit_on_player_hit(25)
