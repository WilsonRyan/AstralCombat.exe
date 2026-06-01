extends Node



signal on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType)
signal on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float)
signal on_player_hit(dmg: float)
signal on_player_die()
signal on_enemy_dequeue(eny_diff: float)


func emit_on_create_player_bullet(pos: Vector2, speed_multi: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	on_create_player_bullet.emit(pos, speed_multi, bullet_type)

func emit_on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float) -> void:
	on_create_enemy_bullet.emit(pos, dir, speed_multi, bullet_type, dmg)

func emit_on_player_hit(dmg: float) -> void:
	on_player_hit.emit(dmg)

func emit_on_player_die() -> void:
	on_player_die.emit()

func emit_on_enemy_dequeue(eny_diff: float) -> void:
	on_enemy_dequeue.emit(eny_diff)
