extends Area2D

class_name UpgradeBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func turn_on(val: bool) -> void:
	set_deferred("monitoring", val)
	set_deferred("monitorable", val)
	visible = val


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		print("player upgrade and next level GO!")
		SignalHub.emit_on_start_next_level()
		turn_on(false)
