extends TextureProgressBar

class_name HealthBar


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

@export var player: Player
@export var start_health: float = 50
@export var max_health: float = 50
@export var level_med: float = max_health * 0.6
@export var level_low: float = max_health * 0.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health = player.get_health()
	start_health = max_health
	max_value = max_health
	stretch_margin_right = int(max_health)
	value = start_health
	set_color()


func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD

func incr_value(v: int) -> void:
	value += v
	if value <= 0:
		print("dead")
	set_color()

func take_damage(v: int) -> void:
	incr_value(-v)
