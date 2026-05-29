extends TextureProgressBar

class_name HealthBar


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

@export var start_health: float = 50
@export var max_health: float = 50
@export var current_health: float = 50
@export var level_med: float = max_health * 0.65
@export var level_low: float = max_health * 0.35


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)


func setup(player: Player) -> void:
	if player != null:
		max_health = player.get_health()
	start_health = max_health
	max_value = max_health
	current_health = start_health
	stretch_margin_right = int(max_health * 2)
	value = current_health
	level_med = max_health * 0.6
	level_low = max_health * 0.2
	set_color()

func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD

func incr_value(v: float) -> void:
	current_health -= v
	value = current_health
	set_color()

func take_damage(v: float) -> void:
	incr_value(v)



func on_player_hit(dmg: float) -> void:
	incr_value(dmg)
	value = current_health
	print(current_health)
	if current_health <= 0.0:
		SignalHub.emit_on_player_die()
