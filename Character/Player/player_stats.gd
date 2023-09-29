class_name PlayerStats
extends Stats

# Level ------------------------------------------------------------------------
var level: int = 1
var xp_to_level: int = 20
var xp: int = 0:
	get: return xp
	set(value):
		xp = value
		if xp >= xp_to_level:
			xp -= xp_to_level
			level_up()
		Event.player_gain_xp.emit()

func level_up() -> void:
	on_healed(ceil(max_hp / 3.0))
	level += 1
	Event.player_level_up.emit()
	xp_to_level = ceil(xp_to_level * 1.3)
	self.AbilityPoint += 1
	if level % 3 == 0:
		Event.player_gained_new_skill.emit()
