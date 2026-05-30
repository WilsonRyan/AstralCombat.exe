extends Node2D


const ADD_BULLET: String = "add_bullet"
const ADD_ENEMY: String = "add_enemy"
const PLAYER_BULLET_BASE = preload("uid://cib33sfbqqvbh")
const PLAYER_BULLET_PRIMARY = preload("uid://brw7nqs7qauw5")
const ENEMY_BULLET_BASE = preload("uid://c6p63th4ulpxq")



func _enter_tree() -> void:
	SignalHub.on_create_player_bullet.connect(on_create_player_bullet)
	SignalHub.on_create_enemy_bullet.connect(on_create_enemy_bullet)
	#SignalHub.on_create_enemy.connect(on_create_enemy)


func add_bullet(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func add_enemy(obj: Node) -> void:
	add_child(obj)


#func on_create_enemy(enemy_type: EnemyBase.EnemyType) -> EnemyBase:
	#var scene: EnemyBase
	#match enemy_type:
		#EnemyBase.EnemyType.Asteroid:
			#scene = ASTEROID.instantiate()
		#EnemyBase.EnemyType.EnemyShip:
			#scene = ENEMY_SHIP.instantiate()
	#if scene:
		#call_deferred(ADD_ENEMY, scene)
	

func on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	var scene: PlayerBulletBase
	match bullet_type:
		PlayerBulletBase.BulletType.Primary:
			scene = PLAYER_BULLET_PRIMARY.instantiate()
	if scene:
		scene.setup(speed_multi)
		call_deferred(ADD_BULLET, scene, pos)


func on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float) -> void:
	var scene: EnemyBulletBase
	match bullet_type:
		EnemyBulletBase.BulletType.Regular:
			scene = ENEMY_BULLET_BASE.instantiate()
	if scene:
		scene.setup(dir, speed_multi, dmg)
		call_deferred(ADD_BULLET, scene, pos)
