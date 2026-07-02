extends Node



signal on_create_player_bullet(pos: Vector2, speed_multi: float, dmg: float, bullet_type: PlayerBulletBase.BulletType)
signal on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float)
signal on_create_level_complete_upgrades(amt: int)
signal on_player_selects_upgrade(upgrade_type: Upgrade.UpgradeType, amt: float)
signal on_player_hit(dmg: float)
signal on_player_die()
signal on_enemy_dequeue(eny_diff: float)
signal on_level_complete()
signal on_start_next_level()


## Emits the signal to create a Player bullet.
## Called by: Player.gd in shoot()
func emit_on_create_player_bullet(pos: Vector2, speed_multi: float, dmg: float, bullet_type: PlayerBulletBase.BulletType) -> void:
	on_create_player_bullet.emit(pos, speed_multi, dmg, bullet_type)

## Emits the signal to create a enemy bullet.
## Called by: EnemyShip.gd in shoot()
func emit_on_create_enemy_bullet(pos: Vector2, dir: Vector2, speed_multi: float, bullet_type: EnemyBulletBase.BulletType, dmg: float) -> void:
	on_create_enemy_bullet.emit(pos, dir, speed_multi, bullet_type, dmg)

## Emits the signal to create the upgrades when the Player finishes a level.
## Called by: Game.gd in on_enemy_dequeue(_eny_diff)
func emit_on_create_level_complete_upgrades(amt: int) -> void:
	on_create_level_complete_upgrades.emit(amt)

## Emits the signal when the Player selects a level complete upgrade.
## Called by: Upgrade.gd in _on_area_entered(area)
func emit_on_player_selects_upgrade(upgrade_type: Upgrade.UpgradeType, amt: float) -> void:
	on_player_selects_upgrade.emit(upgrade_type, amt)

## Emits the signal when the player is hit.
## Called by: Player.gd in  _on_area_entered(area) && EnemyBulletBase.gd in  _on_area_entered(area)
func emit_on_player_hit(dmg: float) -> void:
	on_player_hit.emit(dmg)

## Emits the signal when the player dies.
## Called by: HealthBar.gd in on_player_hit(dmg)
func emit_on_player_die() -> void:
	on_player_die.emit()

## Emits the signal when an enemy is dequeued NOT when they just "die"
## Called by: EnemyBase.gd in _process(delta)
func emit_on_enemy_dequeue(eny_diff: float) -> void:
	on_enemy_dequeue.emit(eny_diff)

## Emits the signal when the level is complete.
## Called by: Game.gd in _on_level_timer_timeout()
func emit_on_level_complete() -> void:
	on_level_complete.emit()

## Emits the signal to start the next level.
## Called by: Upgrade.gd in _on_area_entered(area)
func emit_on_start_next_level() -> void:
	on_start_next_level.emit()
