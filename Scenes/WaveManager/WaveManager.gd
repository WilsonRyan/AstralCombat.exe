extends Node2D


const ENEMY_SHIP = preload("uid://dh23xq2tjob0u")
const ASTEROID = preload("uid://duxjvl52lken3")

@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer

var _paths_list: Array[Path2D] = []
var _spawn_time: float = 0.5
var _wave_difficulty: float = 10.0

var can_spawn: bool = true
var current_wave_diff: float = 0.0
var enemy_creation_funcs: Array[Callable] = [
	create_asteroid,
	create_enemy_ship
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for pth in paths.get_children():
		_paths_list.push_back(pth)
	spawn_random_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if current_wave_diff < _wave_difficulty:
		spawn_random_enemy()


func create_asteroid() -> EnemyBase:
	var scene: EnemyBase
	scene = ASTEROID.instantiate()
	current_wave_diff += scene.get_difficulty()
	return scene

func create_enemy_ship() -> EnemyBase:
	var scene: EnemyBase
	scene = ENEMY_SHIP.instantiate()
	current_wave_diff += scene.get_difficulty()
	return scene

func create_random_enemy() -> EnemyBase:
	var rand_func: Callable = enemy_creation_funcs.pick_random()
	var rand_eny: EnemyBase = rand_func.call()
	return rand_eny

func spawn_random_enemy() -> void:
	var path: Path2D = null
	if can_spawn == true:
		path = _paths_list.pick_random()
		path.add_child(create_random_enemy())
		can_spawn = false
		start_spawn_timer()
		print("Current: ", current_wave_diff)
		print("Max: ", _wave_difficulty)


func start_spawn_timer() -> void:
	spawn_timer.wait_time = _spawn_time
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	can_spawn = true
