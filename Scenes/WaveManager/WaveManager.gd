extends Node2D


const ASTEROID = preload("uid://duxjvl52lken3")
@onready var enemy_paths_asteroid: EnemyPathsBase = $EnemyPaths/EnemyPathsAsteroid
const ENEMY_SHIP = preload("uid://dh23xq2tjob0u")
@onready var enemy_paths_ship: EnemyPathsBase = $EnemyPaths/EnemyPathsShip

var enemyList: Array[EnemyBase.EnemyType] = [
	EnemyBase.EnemyType.Asteroid,
	EnemyBase.EnemyType.EnemyShip
]

@onready var spawn_timer: Timer = $SpawnTimer


var _spawn_time: float = 1.0
var _wave_difficulty: float = 10.0

var level_complete: bool = false
var current_wave_diff: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_enemy_dequeue.connect(on_enemy_dequeue)
	SignalHub.on_level_complete.connect(on_level_complete)
	SignalHub.on_start_next_level.connect(on_start_next_level)
	start_spawn_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## MUST ADD EACH NEW ENEMY TO THIS FUNCTION
## Returns the list of paths that each enemy is assigned to. 
## Called by: WaveManager.gd in spawn_random_enemy()
func get_enemy_path(enemy_type: EnemyBase.EnemyType) -> EnemyPathsBase:
	var enemy_paths: EnemyPathsBase
	match enemy_type:
		EnemyBase.EnemyType.Asteroid:
			enemy_paths = enemy_paths_asteroid
		EnemyBase.EnemyType.EnemyShip:
			enemy_paths = enemy_paths_ship
	return enemy_paths

## Creates and returns an enemy and adds the difficulty of that enemy to the current wave total difficulty.
## Called by: WaveManager.gd in spawn_random_enemy()
func create_enemy(enemy_type: EnemyBase.EnemyType) -> EnemyBase:
	var scene: EnemyBase
	match enemy_type:
		EnemyBase.EnemyType.Asteroid:
			scene = ASTEROID.instantiate()
		EnemyBase.EnemyType.EnemyShip:
			scene = ENEMY_SHIP.instantiate()
	current_wave_diff += scene.get_difficulty()
	return scene

## Creates a random enemy everytime the spawn_timer runs out and there is room for more total difficulty in the wave
## Called by: WaveManager.gd in _on_spawn_timer_timeout()
func spawn_random_enemy() -> void:
	var path: Path2D = null
	var enemy_type: EnemyBase.EnemyType = enemyList.pick_random()
	if level_complete == false and current_wave_diff < _wave_difficulty:
		path = get_enemy_path(enemy_type).get_paths_list().pick_random()
		path.add_child(create_enemy(enemy_type))
		start_spawn_timer()

## Increases the wave difficulty total amount allowed for the next level
## Called by: SignalHub.gd in emit_on_start_next_level() && Upgrade.gd in _on_area_entered(area)
func on_start_next_level() -> void:
	level_complete = false
	_wave_difficulty += 2

## Removes the difficulty from the wave difficulty total when an enemy is dequeued from the scene NOT when the enemy dies
## Called by: SignalHub.gd in emit_on_enemy_dequeue(eny_diff) && EnemyBase.gd in _process(delta)
func on_enemy_dequeue(eny_diff: float) -> void:
	current_wave_diff -= eny_diff

## Sets level_complete to true
## Called by: SignalHub.gd in emit_on_level_complete() && Game.gd in _on_level_timer_timeout()
func on_level_complete() -> void:
	level_complete = true
	print("LEVEL COMPLETE")

## Starts updates the spawn timer if needed then starts the spawn timer
## Called by: WaveManager.gd in _ready()
func start_spawn_timer() -> void:
	spawn_timer.wait_time = _spawn_time
	spawn_timer.start()

## Spawns a random new enemy when the spawn timer runs out
## Called by: N/A
func _on_spawn_timer_timeout() -> void:
	spawn_random_enemy()
