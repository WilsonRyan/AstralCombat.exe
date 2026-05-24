extends Area2D


@onready var timer_fire_rate: Timer = $timer_fireRate


@export var speed: float = 350.0
@export var prim_bullet_speed_multi: float = 1.0
@export var prim_bullet_fire_rate: float = 0.3

var can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
			SignalHub.emit_on_create_player_bullet(Vector2(global_position.x,global_position.y), prim_bullet_speed_multi, PlayerBulletBase.BulletType.Primary)
			can_shoot = false
			timer_fire_rate.start()


func _on_timer_fire_rate_timeout() -> void:
	can_shoot = true
	timer_fire_rate.wait_time = prim_bullet_fire_rate
