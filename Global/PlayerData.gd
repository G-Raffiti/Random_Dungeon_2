extends Node

var stats: PlayerStats = preload("res://Character/Player/player_stats.tres")

# Abilities --------------------------------------------------------------------
var ability_main : Ability_Resource:
	get: return ability_main
	set(value):
		ability_main = value
		Event.player_ability_changed.emit(ability_main, 'ability_main')

var ability_secondary : Ability_Resource:
	get: return ability_secondary
	set(value):
		ability_secondary = value
		Event.player_ability_changed.emit(ability_secondary, 'ability_secondary')

var ability_movement : Ability_Resource:
	get: return ability_movement
	set(value):
		ability_movement = value
		Event.player_ability_changed.emit(ability_movement, 'ability_movement')

var AbilityPoint: int = 0:
	get: return AbilityPoint
	set(value): 
		AbilityPoint = max(value, 0)
		Event.player_gained_ability_point.emit()

var Reserve: Array[Ability_Resource] = [Data.slash.duplicate(true)]
var Skill_Trees = {}

func refresh_skills():
	self.ability_main = ability_main
	self.ability_secondary = ability_secondary
	self.ability_movement = ability_movement
