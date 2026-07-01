extends TextureProgressBar

class_name HealthBar


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

var start_health: float = 20
var max_health: float = 20
var current_health: float = 50
var level_med: float = max_health * 0.65
var level_low: float = max_health * 0.35

@onready var health_amount: Label = $healthAmount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)

## Updates the max health in the health bar. Example, max health increases by 10, so increase max health and current health by 10
## Called by: Game.gd in on_start_next_level()
func update_max_health(player: Player) -> void:
	if player == null:
		return
	var new_max_health = player.get_health()
	var health_inc = new_max_health - max_health
	max_health = new_max_health
	current_health += health_inc
	max_value = max_health
	value = current_health
	level_med = max_health * 0.6
	level_low = max_health * 0.2
	stretch_margin_right = int(max_health * 2)
	health_amount.text = "%.1f/%.1f" % [current_health, max_health]
	set_color()


## Sets up the health bar, setting the max value to max_health and current value to start_health and setting the thresholds for red/yellow/green health bar alerts
## Called by: Game.gd in _ready()
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
	health_amount.text = "%.1f/%.1f" % [current_health, max_health]
	set_color()


## Sets the color values for the health bar based on the level_low, med, and high health values (red, yellow, green)
## Called by: HealthBar.gd in setup() && HealthBar.gd in incr_value(v)
func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD

## Decreases the players health in the health bar by v amount, then updates the text and color of the health bar
## Called by: HealthBar.gd in on_player_hit(dmg)
func incr_value(v: float) -> void:
	current_health -= v
	value = current_health
	health_amount.text = "%d/%d" % [current_health, max_health]
	set_color()


## Applies damage to the player and updates the health bar
## Called by: SignalHub.gd in emit_on_player_hit(dmg) && Player.gd in _on_area_entered(area) && EnemyBulletBase.gd in _on_area_entered(area)
func on_player_hit(dmg: float) -> void:
	incr_value(dmg)
	value = current_health
	if current_health <= 0.0:
		SignalHub.emit_on_player_die()
