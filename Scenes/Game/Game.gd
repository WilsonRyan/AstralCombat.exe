extends Node2D

@onready var hud: Control = $HUDCanvas/HUD
@onready var health_bar: HealthBar = $HUDCanvas/HUD/margin_container/HealthBar
@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.setup(player)
	SignalHub.on_player_die.connect(on_player_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape") == true:
		GameManager.load_main_menu()


func on_player_die() -> void:
	GameManager.load_main_menu()
