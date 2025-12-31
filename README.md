A small demo project showing an example of the Strategy Pattern implemented in Godot/GDScript

There are two strategies in this demo: A `MovementStrategy` that returns a `direction` and a `rotation`, and an `AttackStrategy` that provides an `attack()` function, and uses an `AttackData` resource.

The player ultimately does very little! It has a setter for the attack strategy that handles what happens when the value goes null and a setter for its speed that passes the info along to its movement controller. When you are pressing the left mouse button, it runs the `attack_strategy.attack()` function, and it constantly fetches `movement_controller.velocity` and `movement_controller.rotation` for updating its position, along with a little `move_and_slide()`

Similarly, attacks do very little. They delete themselves if they hit a hurtbox or if they run out their max distance or lifetime duration, then poll their movement_strategy for the same info every frame. Most of the logic comes in for the individual strategies, combined with the AttackData. Strategies use this data to set up attack nodes and spawn them into the scene, then the movement strategy carries the torch from there.

This project aims to demonstrate how flexible Strategies can be. There is a generic Weapon Pickup object which can accept an Attack Strategy, and will provide the player with that attack when they collect it. The player's old strategy (if any) will drop to the ground in its place. Movement strategies are similarly swappable. For instance, the sword scene easily becomes a thrown weapon by simply applying a ranged attack/movement strategy!
