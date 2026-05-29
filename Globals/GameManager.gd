extends Node


const MAIN_MENU: String = "res://Scenes/Menus/MainMenu/MainMenu.tscn"
const GAME: String = "res://Scenes/Game/Game.tscn"



func load_main_menu() -> void:
	get_tree().call_deferred("change_scene_to_file", MAIN_MENU)

func load_game() -> void:
	get_tree().call_deferred("change_scene_to_file", GAME)

func quit_game() -> void:
	get_tree().call_deferred("quit")
