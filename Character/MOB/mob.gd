class_name Mob
extends Character

@export var mob_stats: MobStats
@export var ui_manager: MobUIManager

func _ready():
	stats = mob_stats
	super._ready()
	ui_manager.initialize(self)

