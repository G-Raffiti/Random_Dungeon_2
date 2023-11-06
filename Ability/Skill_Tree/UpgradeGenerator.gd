@tool
extends Node

@export var ability: Ability_Resource:
	get: return ability
	set(value):
		ability = value
		get_dict()
@export var stats: Dictionary = {}
@export var upgrade_rarity: G.Rarity = G.Rarity.COMMON
@export var upgrade_name: String = 'New Upgrade'
@export var upgrade_description: String = 'New Upgrade Description'
@export var upgrade_icon: Texture = null

@export var get_property: bool:
	get: return ability != null
	set(value):
		get_property = value
		get_dict()
@export var save: bool:
	get: return ability != null
	set(value):
		save = value
		save_upgrade()

func get_dict():
	stats = {}
	if ability == null:
		return 
	ability.get_property_list().map(func(p):
		if p.name != 'animation_time' \
			and (p.hint_string == 'bool' \
			or p.hint_string == 'int' \
			or p.hint_string == 'float' \
			or p.hint_string == 'Vector2'): 
				print(p.name, ' ', p.hint_string)
				stats[p.name] = get_value(p.hint_string)
		elif p.type == 2 :
			stats[p.name] = G.Element.PHYS
	)

func get_value(hint) -> Variant:
	match hint:
		'bool': return bool(false)
		'int' : return int(0)
		'float' : return float(0.0)
		'Vector2' : return Vector2(0, 0)
		_: 
			print("can't create var of type ", hint) 
			return int(0)

func save_upgrade():
	var upgrade = Upgrade.new(upgrade_name, upgrade_description, stats, upgrade_icon, upgrade_rarity)
	ability.upgrades.append(upgrade)