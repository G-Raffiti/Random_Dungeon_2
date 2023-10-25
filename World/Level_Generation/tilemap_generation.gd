extends Node

@onready var tile_map: TileMap = $TileMap
@export var tile_size: int = 128
@export var tileset: TileSet
@export var level_generator: LevelGenerator

func _input(event):
	if event.is_action_pressed('ui_accept'):
		tile_map.clear()
		var map: LevelGenerator.Map = level_generator.get_level() as LevelGenerator.Map;
		tile_map.set_cells_terrain_connect(0, map.level, 0, 0, false)
	# for location in map.level:
	# 	tile_map.set_cellv(location, -1)
	# tile_map.update_bitmask_region()
	# var extrem_rooms = get_extrem_room(walker)
	# exit.position = extrem_rooms[1]
	# player.position = extrem_rooms[0]
	# emit_signal("level_infos_ready", map, walker.rooms, player.position, exit.position, cell_size)
	# walker.queue_free()
