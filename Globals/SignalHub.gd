extends Node



signal on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType)
signal on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType)


func emit_on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	on_create_player_bullet.emit(pos, speed_multi, bullet_type)

func emit_on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType) -> void:
	on_create_enemy_bullet.emit(pos, dir, speed_multi, bullet_type)
