extends Node2D

@onready var hud: Control = $HUDCanvas/HUD
@onready var health_bar: HealthBar = $HUDCanvas/HUD/margin_container/HealthBar
@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.setup(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
