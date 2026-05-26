2026-05-26 AM
Pushed: Enemy ship created. Enemy ship fires basic bullet and bullet collides with player.
Tested: Enemy ship shoots bullets at designated fire rate and player is hit by enemy bullets.
Learned: Can reuse a lot of the same code from player bullets and player ship to the enemy ship and bullets. Similar code is easier to troubleshoot.
Next: Give the player a health bar that takes damage when hit by enemy bullets.

2026-05-25 AM
Pushed: Enemy base created. Functional asteroid that follows a Path2D, has health, gets hit by player, and dies once health is gone. Asteroid spins.
Tested: Asteroid queues free when health equals zero, bullets collide, asteroid queues free at the end of the Path2D.
Learned: Refresher on Inherited Scenes and how to use them with multiple scripts. Have make sure the child scene "extends" the parents scene. Nested inherited scenes dont really work. Use super() to use parent's function
Next: Create enemy ship that shoots EnemyBullets back in a straight line.

2026-05-24 AM
Pushed: Project created. All globals created, Game, Player, and Player Bullet scenes created. Player can move around the screen and shoot bullet.
Tested: Player movement clamped to viewport and fire rate shoots the bullets.
Learned: Short refresher on how to use an ObjectMaker scene to manage all of the object creation. Will need to keep practicing this though.
Next: Create Enemy Base and make the player bullets and ship collide with the enemy ship.
