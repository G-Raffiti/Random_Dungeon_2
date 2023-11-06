extends Node

var menus: Dictionary = {}

func _ready():
	for child in get_children():
		menus[child.name] = child
		child.hide()
	open("MainMenu")

func _unhandled_input(event):
	if event.is_action_pressed("menu_pause"):
		open("PauseMenu")
	elif event.is_action_pressed("menu_abilities"):
		open("AbilityInventory")

func open(menu_name):
	for menu in menus.values():
		menu.hide()
	if (menu_name in menus and not menus[menu_name].visible):
		menus[menu_name].show()
		if menu_name != 'HUD':
			menus['Blur'].show()
	else:
		menus['HUD'].show()

func game_mode():
	open("HUD")
