# Random Dungeon 2

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Table of Contents

- [Description](#Description)
- [Road Map](#Road-Map-(in-no-order-of-priority))
- [License](#license)
- [Art](#art)

## Description

Version 2 of my game, now powered by Godot 4.X and GDScript.

random Dungeon 2 offers a simple yet addictive dungeon-crawling experience. Climb increasingly difficult dungeon levels while battling hordes of foes. At the start, choose an ability that evolves as you spend level points in a random skill tree. Unlock up to three abilities to use together during your run. Dive into the darkness and conquer the challenges that await.

## Road Map (in no order of priority)
finalized: ✔️✔️✔️, done: ✔️, in progress: 🔵,  to do: ❌
- Player :
	- Player Movement 2D Topdown or Isometric with WASD ✔️
		- Animation ✔️
	- Player Dash ❌
	- Player Ability System 🔵

- Mob Finite State Machin :
	- IDLE ✔️✔️✔️
	- WANDERING ✔️✔️✔️
	- CHASING ✔️
	- MELEE ATTACK ✔️
	- RANGED ATTACK ❌
	- FLEE ❌
	- REGROUP ❌
	- USE Special Ability ✔️

- UI HUD :
	- Player HP ✔️ / Energy ❌ / Mana ❌
	- Mini map ✔️
	- Overlay Map ✔️
	- Skill bar / cooldown ❌

- UI Menus :
	- Skill ❌
	- Passive Skill Trees ❌
	- Pause ❌
	- Main Menu ❌

- World :
	- proceduraly generated Dungeon Tilemap based ✔️
		- Spawn randomly placed Objets ❌
		- MOB Spawner ✔️
		- Spawn Player in good spot ✔️
		- Spawn Exit Door ❌
	- HUB ❌
	- BOSS Fight ❌

- Player Skills :
	- Slash 🔵 animation ❌ script ✔️ resource 🔵
		- move while attacking 🔵
		- multistrike 🔵
		- biger range 🔵
		- dash in direction ❌
		- combo ❌
		- add charge ❌ / reduce cooldown ❌ / add attack ❌

	- Throw Stick ❌
		- fork ❌
		- rotate ❌
		- pierce ❌
		- orbite ❌
		- explode ❌
		- add charge ❌ / reduce cooldown ❌ / add attack ❌

	- Nova ❌
		- increase Area of effect ❌
		- echo ❌
		- multi cast ❌
		- cast on mouse ❌
		- knockback ❌
		- add charge ❌ / reduce cooldown ❌ / add attack ❌

	- Shuriken ❌
		- add projectile ❌
		- reduce angle ❌
		- bounce ❌
		- pierce ❌
		- 1 Big Shuriken ❌
		- add charge ❌ / reduce cooldown ❌ / add attack ❌
	
	- Dash ❌
		- expolde at begining ❌ / end ❌
		- disable hitbox ❌
		- increase range ❌
		- Damage on touching ❌
		- add charge ❌ / reduce cooldown ❌

## Art

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
