class_name Mob
extends Character

@export var mob_stats: MobStats

func _ready():
	stats = mob_stats
	super._ready()
