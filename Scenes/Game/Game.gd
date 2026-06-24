extends Node2D

@onready var hud: Control = $HUDCanvas/HUD
@onready var player: Player = $Player
@onready var level_timer: Timer = $LevelTimer
@onready var wave_manager: Node2D = $WaveManager

@export var max_level: int = 3
@export var level_time_increase_amt: float = 2.0

var current_level: int = 1
var level_length: float = 3.0
var level_complete: bool = false
var level_complete_upgrade_amt: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_die.connect(on_player_die)
	SignalHub.on_start_next_level.connect(on_start_next_level)
	SignalHub.on_enemy_dequeue.connect(on_enemy_dequeue)
	hud.health_bar.setup(player)
	start_level_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hud.set_level_time(level_timer.time_left)
	hud.set_difficulty_on_screen(wave_manager._wave_difficulty, wave_manager.current_wave_diff)
	hud.set_level(max_level, current_level)
	hud.set_player_dmg(player.prim_bullet_dmg)
	hud.set_mov_speed(player.speed)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape") == true:
		GameManager.load_main_menu()


func start_level_timer() -> void:
	level_timer.wait_time = level_length
	level_timer.start()
	level_timer.one_shot = true


func on_enemy_dequeue(_eny_diff: float) -> void:
	if level_complete == true and wave_manager.current_wave_diff <= 0:
		if current_level == max_level:
			print("YOU WIN THE RUN!")
			GameManager.load_main_menu()
		else:
			SignalHub.emit_on_create_level_complete_upgrades(level_complete_upgrade_amt)
			level_complete = false
			current_level += 1

func on_player_die() -> void:
	GameManager.load_main_menu()

func on_start_next_level() -> void:
	level_length += level_time_increase_amt
	start_level_timer()
	hud.health_bar.update_max_health(player)
	

func _on_level_timer_timeout() -> void:
	level_complete = true
	SignalHub.emit_on_level_complete()
