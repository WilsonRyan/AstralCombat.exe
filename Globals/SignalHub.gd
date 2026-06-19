extends Node



signal on_create_player_bullet(pos: Vector2, speed_multi: float, dmg: float, bullet_type: PlayerBulletBase.BulletType)
signal on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float)
signal on_create_level_complete_upgrade(pos: Vector2)
signal on_player_selects_upgrade(upgrade_type: Upgrade.UpgradeType, amt: float)
signal on_player_hit(dmg: float)
signal on_player_die()
signal on_enemy_dequeue(eny_diff: float)
signal on_level_complete()
signal on_start_next_level()



func emit_on_create_player_bullet(pos: Vector2, speed_multi: float, dmg: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	on_create_player_bullet.emit(pos, speed_multi, dmg, bullet_type)

func emit_on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float) -> void:
	on_create_enemy_bullet.emit(pos, dir, speed_multi, bullet_type, dmg)

func emit_on_create_level_complete_upgrade(pos: Vector2) -> void:
	on_create_level_complete_upgrade.emit(pos)

func emit_on_player_selects_upgrade(upgrade_type: Upgrade.UpgradeType, amt: float) -> void:
	on_player_selects_upgrade.emit(upgrade_type, amt)

func emit_on_player_hit(dmg: float) -> void:
	on_player_hit.emit(dmg)

func emit_on_player_die() -> void:
	on_player_die.emit()

func emit_on_enemy_dequeue(eny_diff: float) -> void:
	on_enemy_dequeue.emit(eny_diff)

func emit_on_level_complete() -> void:
	on_level_complete.emit()

func emit_on_start_next_level() -> void:
	on_start_next_level.emit()
