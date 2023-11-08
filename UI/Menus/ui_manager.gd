extends Node

var menus: Dictionary = {}

func _ready():
	for child in get_children():
		menus[child.name] = child
		child.hide()
	Event.ui_show_hud.connect(game_mode)
	Event.ui_show_pause_menu.connect(func(): open("PauseMenu"))
	Event.ui_show_option_menu.connect(func(): open("OptionMenu"))
	Event.ui_show_main_menu.connect(func(): open("MainMenu"))
	Event.game_started.connect(game_mode)
	open("MainMenu")

func _unhandled_input(event):
	if event.is_action_pressed("menu_abilities"):
		open("AbilityInventory")
	
	elif event.is_action_pressed('ui_cancel'):
		var was_open = false
		for menu in menus.values():
			if menu.visible and menu.name != 'HUD':
				was_open = true
				menu.hide()
		if was_open:
			menus['HUD'].show()
			get_tree().paused = FLAG_PROCESS_THREAD_MESSAGES
			return
		open("PauseMenu")
		get_tree().paused = true

func open(menu_name):
	var was_open = menus[menu_name].visible

	for menu in menus.values():
		menu.hide()
	if was_open:
		return
	if (menu_name in menus and not menus[menu_name].visible):
		menus[menu_name].show()
		if menu_name != 'HUD':
			menus['Blur'].show()
	else:
		menus['HUD'].show()
		get_tree().paused = false

func game_mode():
	open("HUD")
