Sesh 6: 2026-05-30 AM
Pushed: WaveManager does spawn either an asteroid or enemy ship randomly and keeps spawning until it hits the desired difficulty, but then stops spawning.
Tested: That the game will spawn enemies.
Learned: A lot. Idk, just again played with where to spawn the packedscenes. Ended up doing it in the WaveManager. How to create an array of callable functions and call them randomly.
Next: As enemies either, die or despawn, I want the difficulty to be decreased so that the wave spawner summons more enemies after an enemy is removed from the tree.

Sesh 5: 2026-05-29 PM
Pushed: Working Main menu that you launch the game from and go to when the player dies. Creating the first actual game loop.
Tested: Can enter the game or quit from launch. Transitions to main menu when player dies and can resume the game again.
Learned: In the GameManager save the scenes as Strings then use "get_tree().call_deferred("change_scene_to_file", SCEEN_NAME)" to trasition scenes.
Next: Create a working wave scene that can spawn the asteroid and EnemyShip.

Sesh 4: 2026-05-29 AM
Pushed: Player has working health bar that takes dmg when hit and kills player when it reaches 0. Enemy Bullet dmg is controlled in EnemyShip scene.
Tested: Player takes dmg and queues_free() when reaching 0. Adjusting starting health from player node affects health bar. Adjusting enemy bullet dmg from EnemyShip scene affects bullet dmg on the player health bar.
Learned: Use a simple CanvasLayer to add UI elements to. This makes them format and fit on the viewport easier.
Next: Create simple "Main Menu" where the player starts the game and returns when they die, and they can restart from.

Sesh 3: 2026-05-27 AM
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
