extends Node2D

class_name EnemyPathsBase

var _paths_list: Array[Path2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for pth in get_children():
		_paths_list.push_back(pth)


func get_paths_list() -> Array[Path2D]:
	return _paths_list
