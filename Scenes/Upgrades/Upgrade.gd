extends Area2D

class_name Upgrade
enum UpgradeType{ health, dmg, mov_speed}

const BAR_ROUND_GLOSS_LARGE_SQUARE = preload("uid://dncq20c7pwb6k") #health sprite
const BLUE_STAR = preload("uid://b8l8uvdoo6ak2")					#dmg sprite
const CURSOR_SWORD_GOLD = preload("uid://8e87fgxvlp63")				#mov_speed sprite

var health_upgrade_amt = 25.0
var prim_dmg_upgrade_amt = 20.0
var mov_speed_upgrade_amt = 100.0

var _upgrade_amt = 0.0
var _upgrade_type: UpgradeType
@export var upgrade_array: Array[Upgrade.UpgradeType]

@onready var sprite_2d: Sprite2D = $sprite_2d




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("level_upgrades")
	match _upgrade_type:
		Upgrade.UpgradeType.health:
			sprite_2d.texture = BAR_ROUND_GLOSS_LARGE_SQUARE
			_upgrade_amt = health_upgrade_amt
		Upgrade.UpgradeType.dmg:
			sprite_2d.texture = CURSOR_SWORD_GOLD
			_upgrade_amt = prim_dmg_upgrade_amt
		Upgrade.UpgradeType.mov_speed:
			sprite_2d.texture = BLUE_STAR
			_upgrade_amt = mov_speed_upgrade_amt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func setup(type: UpgradeType) -> void: 
	_upgrade_type = type

func get_rand_upgrade() -> void:
	_upgrade_type = UpgradeType.values().pick_random()


func turn_on(val: bool) -> void:
	set_deferred("monitoring", val)
	set_deferred("monitorable", val)
	visible = val


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		var endLevelStr = "Player selects %s and goes to the next level" % _upgrade_type
		print(endLevelStr)
		SignalHub.emit_on_player_selects_upgrade(_upgrade_type, _upgrade_amt)
		SignalHub.emit_on_start_next_level()
		get_tree().call_group("level_upgrades", "queue_free")
