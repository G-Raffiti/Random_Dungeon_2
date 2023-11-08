extends Node2D

@export var level_service: LevelService

func _ready():
	Event.start_new_game.connect(func():
		level_service.generate_map()
		Event.game_started.emit() 
	)
