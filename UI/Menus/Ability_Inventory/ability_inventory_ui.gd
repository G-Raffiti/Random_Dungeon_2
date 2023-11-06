extends Control

var reserve: Array[InventorySlot]
@onready var main_skill: InventorySlot = %main_skill
@onready var secondary_skill: InventorySlot = %secondary_skill
@onready var movement_skill: InventorySlot = %movement_skill

func _ready():
  for child in %reserve.get_children():
    reserve.append(child)
  main_skill.dropped_item.connect(func(item: InventoryItem): 
    PlayerData.ability_main = item.get_resource())
  secondary_skill.dropped_item.connect(func(item: InventoryItem): 
    PlayerData.ability_secondary = item.get_resource())
  movement_skill.dropped_item.connect(func(item: InventoryItem): 
    PlayerData.ability_movement = item.get_resource())
  for slot in reserve:
    if slot.get_child_count() > 0:
      slot.remove_child(slot.get_child(0))
  for ability_res in PlayerData.Reserve:
    var item = Ability_Item.new(ability_res)
    for slot in reserve:
      if slot.get_child_count() == 0:
        slot.add_child(item)
        break
