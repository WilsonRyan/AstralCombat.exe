extends Node2D


const ADD_OBJECT: String = "add_object"
const PLAYER_BULLET_BASE = preload("uid://cib33sfbqqvbh")
const PLAYER_BULLET_PRIMARY = preload("uid://brw7nqs7qauw5")



func _enter_tree() -> void:
	SignalHub.on_create_player_bullet.connect(on_create_player_bullet)



func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos



func on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	var scene: PlayerBulletBase
	match bullet_type:
		PlayerBulletBase.BulletType.Primary:
			scene = PLAYER_BULLET_PRIMARY.instantiate()
	if scene:
		scene.setup(speed_multi)
		call_deferred(ADD_OBJECT, scene, pos)
