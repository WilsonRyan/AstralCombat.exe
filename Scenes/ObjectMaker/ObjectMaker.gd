extends Node2D


const PLAYER_BULLET_BASE = preload("uid://cib33sfbqqvbh")
const PLAYER_BULLET_PRIMARY = preload("uid://brw7nqs7qauw5")
const ENEMY_BULLET_BASE = preload("uid://c6p63th4ulpxq")
const UPGRADE = preload("uid://c721tyqybney7")


func _enter_tree() -> void:
	SignalHub.on_create_player_bullet.connect(on_create_player_bullet)
	SignalHub.on_create_enemy_bullet.connect(on_create_enemy_bullet)
	SignalHub.on_create_level_complete_upgrades.connect(on_create_level_complete_upgrades)


func add_bullet(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func add_upgrade(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func on_create_level_complete_upgrades(amt: int) -> void:
	var viewport_y = get_viewport_rect().size.y
	var y_inter = viewport_y / (amt+1)
	var selected_upgrades: Array = Upgrade.UpgradeType.values()
	selected_upgrades.shuffle()
	if amt > selected_upgrades.size():
		amt = selected_upgrades.size()
		push_error("ERROR: Too many upgrades to show.")
	for i in range(0,amt):
		var scene: Upgrade
		scene = UPGRADE.instantiate()
		scene.setup(selected_upgrades[i])
		if scene:
			call_deferred("add_upgrade", scene, Vector2(1000, (y_inter * (i+1) ) ))


func create_level_complete_upgrade(pos: Vector2) -> void:
	var scene: Upgrade
	scene = UPGRADE.instantiate()
	if scene:
		scene.get_rand_upgrade()
		call_deferred("add_upgrade", scene, pos)

func on_create_player_bullet(pos: Vector2, speed_multi: float, dmg: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	var scene: PlayerBulletBase
	match bullet_type:
		PlayerBulletBase.BulletType.Primary:
			scene = PLAYER_BULLET_PRIMARY.instantiate()
	if scene:
		scene.setup(speed_multi, dmg)
		call_deferred("add_bullet", scene, pos)

func on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float) -> void:
	var scene: EnemyBulletBase
	match bullet_type:
		EnemyBulletBase.BulletType.Regular:
			scene = ENEMY_BULLET_BASE.instantiate()
	if scene:
		scene.setup(dir, speed_multi, dmg)
		call_deferred("add_bullet", scene, pos)
