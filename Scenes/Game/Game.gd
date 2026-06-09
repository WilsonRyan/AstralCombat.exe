extends Node2D

@onready var hud: Control = $HUDCanvas/HUD
@onready var health_bar: HealthBar = $HUDCanvas/HUD/margin_container/HealthBar
@onready var player: Player = $Player
@onready var level_timer: Timer = $LevelTimer
@onready var wave_manager: Node2D = $WaveManager
@onready var upgrade_base: UpgradeBase = $UpgradeBase

var level_length: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_die.connect(on_player_die)
	SignalHub.on_start_next_level.connect(on_start_next_level)
	health_bar.setup(player)
	start_level_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hud.set_level_time(level_timer.time_left)
	hud.set_difficulty_on_screen(wave_manager._wave_difficulty, wave_manager.current_wave_diff)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape") == true:
		GameManager.load_main_menu()


func start_level_timer() -> void:
	level_timer.wait_time = level_length
	level_timer.start()
	level_timer.one_shot = true


func on_player_die() -> void:
	GameManager.load_main_menu()

func on_start_next_level() -> void:
	level_length += 5.0
	start_level_timer()
	

func _on_level_timer_timeout() -> void:
	SignalHub.emit_on_level_complete()
	upgrade_base.turn_on(true)
