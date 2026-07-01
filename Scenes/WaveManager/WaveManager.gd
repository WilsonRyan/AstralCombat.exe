extends Node2D

#### NEED TO ADD COMMENTS TO THIS GDSCRIPT ####
#### NEED TO ADD COMMENTS TO THIS GDSCRIPT ####
#### NEED TO ADD COMMENTS TO THIS GDSCRIPT ####
#### NEED TO ADD COMMENTS TO THIS GDSCRIPT ####

const ASTEROID = preload("uid://duxjvl52lken3")
@onready var enemy_paths_asteroid: EnemyPathsBase = $EnemyPaths/EnemyPathsAsteroid
const ENEMY_SHIP = preload("uid://dh23xq2tjob0u")
@onready var enemy_paths_ship: EnemyPathsBase = $EnemyPaths/EnemyPathsShip

var enemyList: Array[EnemyBase.EnemyType] = [
	EnemyBase.EnemyType.Asteroid,
	EnemyBase.EnemyType.EnemyShip
]

@onready var spawn_timer: Timer = $SpawnTimer


var _spawn_time: float = 0.5
var _wave_difficulty: float = 10.0

var level_complete: bool = false
var can_spawn: bool = true
var current_wave_diff: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_enemy_dequeue.connect(on_enemy_dequeue)
	SignalHub.on_level_complete.connect(on_level_complete)
	SignalHub.on_start_next_level.connect(on_start_next_level)
	start_spawn_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if current_wave_diff < _wave_difficulty and level_complete == false:
		spawn_random_enemy()

#MUST ADD EACH ENEMY TO THIS FUNCTION
func get_enemy_path(enemy_type: EnemyBase.EnemyType) -> EnemyPathsBase:
	var enemy_paths: EnemyPathsBase
	match enemy_type:
		EnemyBase.EnemyType.Asteroid:
			enemy_paths = enemy_paths_asteroid
		EnemyBase.EnemyType.EnemyShip:
			enemy_paths = enemy_paths_ship
	return enemy_paths

func create_enemy(enemy_type: EnemyBase.EnemyType) -> EnemyBase:
	var scene: EnemyBase
	match enemy_type:
		EnemyBase.EnemyType.Asteroid:
			scene = ASTEROID.instantiate()
		EnemyBase.EnemyType.EnemyShip:
			scene = ENEMY_SHIP.instantiate()
	current_wave_diff += scene.get_difficulty()
	return scene

func spawn_random_enemy() -> void:
	var path: Path2D = null
	var enemy_type: EnemyBase.EnemyType = enemyList.pick_random()
	if can_spawn == true and level_complete == false:
		path = get_enemy_path(enemy_type).get_paths_list().pick_random()
		path.add_child(create_enemy(enemy_type))
		can_spawn = false
		start_spawn_timer()


func on_start_next_level() -> void:
	level_complete = false
	_wave_difficulty += 2

func on_enemy_dequeue(eny_diff: float) -> void:
	current_wave_diff -= eny_diff

func on_level_complete() -> void:
	level_complete = true
	print("LEVEL COMPLETE")

func start_spawn_timer() -> void:
	spawn_timer.wait_time = _spawn_time
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	can_spawn = true
