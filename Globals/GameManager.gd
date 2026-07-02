extends Node


const MAIN_MENU: String = "res://Scenes/Menus/MainMenu/MainMenu.tscn"
const GAME: String = "res://Scenes/Game/Game.tscn"


## Brings the Player to the Main Menu screen
## Called by: Game.gd in _unhandled_input(_event) && Game.gd in on_enemy_dequeue(_eny_diff) && Game.gd in on_player_die()
func load_main_menu() -> void:
	get_tree().call_deferred("change_scene_to_file", MAIN_MENU)

## Brings the Player to the real game
## Called by: MainMenu.gd in _unhandled_input(_event)
func load_game() -> void:
	get_tree().call_deferred("change_scene_to_file", GAME)

## Completely exits the game and program
## Called by: MainMenu.gd in _unhandled_input(_event)
func quit_game() -> void:
	get_tree().call_deferred("quit")
