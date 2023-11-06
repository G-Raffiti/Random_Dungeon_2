extends InventoryItem
class_name Ability_Item

var ability_resource: Ability_Resource

func get_resource():
	return ability_resource

func _init(_ability_resource: Ability_Resource):
	ability_resource = _ability_resource
	type = Type.SKILL
	texture = ability_resource.icon
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED