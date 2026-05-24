extends Node



signal on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType)



func emit_on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	on_create_player_bullet.emit(pos, speed_multi, bullet_type)
