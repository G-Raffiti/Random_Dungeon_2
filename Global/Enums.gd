extends Node

enum Element { PHYS, FIRE, WATER, NATURE }
enum Rarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }

class Damage:
	var value: int = 0
	var type: Element = Element.PHYS
	
	func _init(damage_value: int, damage_type: Element) -> void:
		value = damage_value
		type = damage_type

	func add(added_value: int):
		value += added_value
	
	func to_str() -> String:
		match (type):
			Element.PHYS:
				return str(value) + " physical damage"
			Element.FIRE:
				return str(value) + " fire damage"
			Element.WATER:
				return str(value) + " water damage"
			Element.NATURE:
				return str(value) + " nature damage"
			_: return str(value) + " damage"
