extends Node

var stats: PlayerStats = preload("res://Character/Player/player_stats.tres")

# Abilities --------------------------------------------------------------------
var main_action : Ability_Resource:
	get: return main_action
	set(value):
		main_action = value
		Event.player_ability_changed.emit(main_action, 'main_action')

var special_action : Ability_Resource:
	get: return special_action
	set(value):
		special_action = value
		Event.player_ability_changed.emit(special_action, 'special_action')

var dash_action : Ability_Resource:
	get: return dash_action
	set(value):
		dash_action = value
		Event.player_ability_changed.emit(dash_action, 'dash_action')

var AbilityPoint: int = 0:
	get: return AbilityPoint
	set(value): 
		AbilityPoint = max(value, 0)
		Event.player_gained_ability_point.emit()

var Reserve = []
var Skill_Trees = {}

func new_action(ability: Ability_Resource):
	self.main_action = ability

func new_special(ability: Ability_Resource):
	self.special_action = ability

func new_dash(ability: Ability_Resource):
	self.dash_action = ability

func refresh_skills():
	self.main_action = main_action
	self.special_action = special_action
	self.dash_action = dash_action
