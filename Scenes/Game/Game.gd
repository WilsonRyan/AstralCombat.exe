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

## Handles when the player presses "Escape" in order to go back to the main menu from within the main Game scene
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape") == true:
		GameManager.load_main_menu()

## Sets the level_timer to be equal to level_length, then starts the timer
## Called by: Game.gd in _ready() && Game.gd in on_start_next_level()
func start_level_timer() -> void:
	level_timer.wait_time = level_length
	level_timer.one_shot = true
	level_timer.start()

## When the level is complete return the player to the menu since they WIN if at the max_level, else create the level upgrades and progress the player to the next level
## Called by: SignalHub.gd in emit_on_enemy_dequeue(eny_diff) && EnemyBase.gd in _process.
func on_enemy_dequeue(_eny_diff: float) -> void:
	if level_complete == true and wave_manager.current_wave_diff <= 0:
		if current_level == max_level:
			print("YOU WIN THE RUN!")
			GameManager.load_main_menu()
		else:
			SignalHub.emit_on_create_level_complete_upgrades(level_complete_upgrade_amt)
			level_complete = false
			current_level += 1

## When the player dies load the main menu Scene
## Called by: SignalHub.gd in emit_on_player_die() && HealthBar.gd in on_player_hit(dmg)
func on_player_die() -> void:
	GameManager.load_main_menu()

## Increases level_length time by level_time_increase_amt, then starts the timer, and updates the hud.health bar incase the player selected the health increase upgrade
## Called by: SignalHub.gd in emit_on_start_next_level() && Upgrade.gd in _on_area_entered(area)
func on_start_next_level() -> void:
	level_length += level_time_increase_amt
	start_level_timer()
	hud.health_bar.update_max_health(player)

## When the level_timer finishes set the level_complete boolean to true then emit the on_level_complete signal
func _on_level_timer_timeout() -> void:
	level_complete = true
	SignalHub.emit_on_level_complete()
