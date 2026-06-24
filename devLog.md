Sesh 15: 2026-06-24 AM
Pushed: Wave end spawns X number of distinct upgrades to pick from and all dequeue when the player selects one of them.
Learned: How arrays of enumerated class is just an array of ints and how to use the groups to dequeue multiple objects in a scene.
Next: Basic enemy ship behavior work. Have the ship face the direction of movement.

Sesh 14: 2026-06-23 AM
Pushed: N/A. Continued working on spawning multiple distinct random upgrades.
Learned: Moved around some Signals so that I am not checking for wave and game complete in the process() of the Game scene.
Next: Continue in the ObjectMaker scene, to have the Game spawn multiple X amount of upgrades on WaveComplete.

Sesh 13: 2026-06-19 AM
Pushed: Upgrade apply to the player now. Health, bullet dmg, player speed all controlled in the player scene. Upgrade amounts are all controlled in the Upgrade scene.
Learned: Better design choices when it comes to sending variables across scenes. Instead of putting a player reference in a the bullet scene, just have the signal send the value to the player.
Next: When the level completes, show X number of distinct upgrades (between 1-X), X being the number of available upgrades. That way I can quickly edit how many upgrades the player has to pick from on level complete.

Sesh 12: 2026-06-10 AM
Pushed: Level complete spawns a singular random upgrade. No push though since game is currently broken.
Learned: The design of having multiple upgrades that interact with various scenes makes it complicated...practiced a lot of matching enum types and passing those types into SignalHub signals.
Next: Upgrade needs to actually APPLY the upgrade to the player. Need to move the HEALTH and BULLET DMG into the Player scene where all the upgrade info will be controlled. Then have the level complete spawn X number of upgrades that are all distinct.

Sesh 11: 2026-06-09 PM
Pushed: The wave spawns the end of wave powerup ONLY if there are no enemies on the screen now. After completing X amount of levels the game returns the player to the menu, and prints YOU WIN to the console. Creation of the end of wave upgrade is done in the ObjectMaker scene now, instead of in the Game scene.
Learned: Reminder on how to effectively use the ObjectMaker to create objects in the Game scene that aren't part of the WaveManager.
Next: Create 3 different power up options. +movement speed, +bullet dmg, +player health. Once done, then have the end of wave spawn TWO distinct random upgrades that apply to the player when the player flies over to one which progresses the game to the next level.

Sesh 10: 2026-06-09 AM
Pushed: Moved the level timer to the "Game" scene, level completes after X amount of time. When level timer completes a blank powerup appears that the player can move onto to progress to the next level, which increase difficulty and level time. Added timer and difficulty on screen to the HUD sceen for easier troubleshooting.
Learned: SignalHub can send signal to multiple scenes if needed, rather than just 1 scene per signal. More like 1 signal to many scene relationship.
Next: Have blank powerup to progress player ONLY appear if the difficulty on screen is ZERO. After X amount of levels display a "YOU WIN" text on the screen, which then prompts the player to go back to the menu to try again.

Sesh 9: 2026-06-06 AM
Pushed: Player takes impact dmg from enemy and asteroid. Health bar displays health amount as text. WaveManager randomly spawns asteroid or enemyship. WaveManager stops spawning enemies after set amount of time in the wave was active.
Tested: Player takes impact dmg from both enemy types. WaveManager stops spawning enemies after set amount of time.
Learned: Reminder on how to format strings string = "This is the number 100: %d" % 100. The %d removed decimals from the float.
Next: When the timer ends increase difficulty and progress to the next "level" and start spawning more enemies. Have it do this for X iterations then display "You win!"

Sesh 8: 2026-06-01 PM
Pushed: Enemies dequeue and remove difficulty from the wave scene ONLY when they reach the end of their Path, but the enemy can still die along the path.
Tested: When enemies die it does NOT return difficulty, but enemies do not shoot or have hitboxes that work. Enemy dequeues at the end of their path, and then spawns more enemies based on difficulty of the wave.
Learned: Remembered the syntax for set_deferred("monitoring", false) in order to make hitboxes not break when in the middle of a collision event.
Next: Add dmg on the player when the player hits enemy Hitboxes, THEN add a TIME variable to the WaveManager, which is the time for the "level", that then progresses the player to the next "level" once the time finishes. This will be managing the run essentially.

Sesh 7: 2026-06-01 AM
Pushed: Redid my wave design a bit, by creating Node2D scene with all the paths for each enemy type. WaveManager now spawns enemies and adds them randomly to one of the paths in their EnemyPaths scene.
Tested: Both asteroids and ships can spawn and only get added to their associated paths.
Learned: More practice using the "match" feature to match various types.
Next: Dequeue the enemies ONLY when they reach the end of their Path NOT when they die. When they dequeue the difficulty level should drop.

Sesh 6: 2026-05-30 AM
Pushed: WaveManager does spawn either an asteroid or enemy ship randomly and keeps spawning until it hits the desired difficulty, but then stops spawning.
Tested: That the game will spawn enemies.
Learned: A lot. Idk, just again played with where to spawn the packedscenes. Ended up doing it in the WaveManager. How to create an array of callable functions and call them randomly.
Next: As enemies either die or despawn, I want the difficulty to be decreased so that the WaveManager spawns more enemies after an enemy is removed from the tree.

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
