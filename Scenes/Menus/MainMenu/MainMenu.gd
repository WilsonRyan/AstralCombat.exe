extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter") == true:
		GameManager.load_game()
	if Input.is_action_just_pressed("escape") == true:
		GameManager.quit_game()
