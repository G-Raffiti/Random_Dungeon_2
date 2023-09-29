class_name AbilityHolder
extends Node

@onready var ability_ps: PackedScene = Data.ability_ps

var abilities: Dictionary = {}
var user: Character

func initialize(character: Character) -> void:
	user = character

func _ready():
	for n in get_child_count():
		if not get_child(n) is Ability: continue
		var ability_n: Ability = get_child(n) as Ability
		ability_n.ability_holder = self
		abilities[ability_n.input_action] = ability_n

func add_ability(ability_resource: Ability_Resource, input: String) -> void:
	if not abilities.has(input):
		var ability: Ability = ability_ps.instantiate()
		add_child(ability)
		ability.name = input
		ability.ability_holder = self
		ability.input_action = input
		abilities[input] = ability
	abilities[input].ability = ability_resource

func swap_ability(input1, input2) -> void:
	var temp = abilities[input1]
	abilities[input1] = abilities[input2]
	abilities[input2] = temp

func is_inactive() -> bool:
	for n in abilities:
		if abilities[n].state == Ability.ACTIVE:
			return false
	return true
