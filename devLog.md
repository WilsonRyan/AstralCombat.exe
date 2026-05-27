Sesh 3: 2026-5-27 AM
Pushed: Player has health that is reduced when hit by an enemy bullet and will "die" when health reaches zero.
Tested: Player is actually hit by bullets and loses health and will queue_free() when health reaches zero.
Learned: How to use TextureProgressBar as a health bar scene
Next: Connect the player health with the HealthBar scene and add that health bar to the HUD scene.

Sesh 2: 2026-05-26 AM
Pushed: Enemy ship created. Enemy ship fires basic bullet and bullet collides with player.
Tested: Enemy ship shoots bullets at designated fire rate and player is hit by enemy bullets.
Learned: Can reuse a lot of the same code from player bullets and player ship to the enemy ship and bullets. Similar code is easier to troubleshoot.
Next: Give the player a health that takes damage when hit by enemy bullets.

Sesh 1: 2026-05-25 AM
Pushed: Enemy base created. Functional asteroid that follows a Path2D, has health, gets hit by player, and dies once health is gone. Asteroid spins.
Tested: Asteroid queues free when health equals zero, bullets collide, asteroid queues free at the end of the Path2D.
Learned: Refresher on Inherited Scenes and how to use them with multiple scripts. Have make sure the child scene "extends" the parents scene. Nested inherited scenes dont really work. Use super() to use parent's function
Next: Create enemy ship that shoots EnemyBullets back in a straight line.

Sesh 0: 2026-05-24 AM
Pushed: Project created. All globals created, Game, Player, and Player Bullet scenes created. Player can move around the screen and shoot bullet.
Tested: Player movement clamped to viewport and fire rate shoots the bullets.
Learned: Short refresher on how to use an ObjectMaker scene to manage all of the object creation. Will need to keep practicing this though.
Next: Create Enemy Base and make the player bullets and ship collide with the enemy ship.
