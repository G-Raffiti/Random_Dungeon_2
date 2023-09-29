@icon("res://_Art/Icons/Ability.svg")
class_name Ability_Resource
extends Resource

@export_group('Info')
@export var ability_name: StringName
@export var icon: Texture2D

@export_group('Times and Charge')
@export var stay_active: bool = false
@export var animation_time: float
@export var cooldown_time: float
@export var active_time: float
@export var charge: int

func starts(_user : Character):
	pass

func ends(_user : Character):
	pass

func process(_user : Character, _delta: float):
	pass

func can_use(ability_holder: AbilityHolder) -> bool:
	return ability_holder.is_inactive()

func scale_animation_speed(user : Character, parameter):
	var ratio = animation_time / active_time
	user.anim_tree.set(parameter, ratio)

func scale_animation_speed_back(user: Character, parameter):
	user.anim_tree.set(parameter, 1)

func get_description(_user: Character) -> String:
	return ""
