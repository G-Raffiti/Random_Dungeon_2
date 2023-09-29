class_name MobStats
extends Stats

# XP stats ---------------------------------------------------------------------
@export_category('XP')
## XP gained on kill
@export var xp_value: int = 1 

@export_category('Abilities')
## this is the main mob ability (if only one pattern of attack, then use this)
@export var main_ability: Ability_Resource

## called when a MOB is spawned
func scale_stats(mob_level: int):
	var factor: float = pow(1.2, mob_level - 1)
	max_hp = floor(max_hp * factor)
	self.hp = max_hp
	damage_value = floor(damage_value * factor)
	xp_value = max(1, floor(xp_value * factor - 1))
