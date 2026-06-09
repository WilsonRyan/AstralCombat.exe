extends Control

@onready var level_time: Label = $margin_container/v_box_container/LevelTime
@onready var max_diff_label: Label = $margin_container/v_box_container/MaxDiffLabel
@onready var curr_diff_label: Label = $margin_container/v_box_container/CurrDiffLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_level_time(time: float) -> void:
	if time == null:
		return
	level_time.text = "%.1f" % time

func set_difficulty_on_screen(max_diff: float, cur_diff: float) -> void:
	if max_diff == null or cur_diff == null: 
		return
	max_diff_label.text = "Max diff: %.1f" % max_diff
	curr_diff_label.text = "Cur diff: %.1f" % cur_diff
