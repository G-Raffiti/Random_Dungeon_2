extends Control
class_name MobUIManager

func initialize(mob: Mob):
	for child in get_children():
		if 'initialize' in child:
			child.initialize(mob)
