extends PanelContainer
class_name InventorySlot

@export var type: InventoryItem.Type
signal dropped_item(item: InventoryItem)
signal emptied_slot()

# Custom init function so that it doesn't error
func init(t: InventoryItem.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == InventoryItem.Type.ALL:
			if get_child_count() == 0:
				return true
			else:
				# Swap two items
				var parentSource: InventorySlot = get_child(0).get_parent()
				var parentTarget: InventorySlot = data.get_parent()
				
				if parentSource.type == parentTarget.type: return true
				
				return get_child(0).type == data.type
		else:
			return data.type == type
	return false


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data: return
		remove_child(item)
		data.get_parent().add_child(item)
		data.get_parent().dropped_item.emit(item)
	data.get_parent().emptied_slot.emit()
	data.get_parent().remove_child(data)
	add_child(data)
	dropped_item.emit(data)
