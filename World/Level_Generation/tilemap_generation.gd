extends Node

@onready var tile_map: TileMap = $TileMap
@export var tile_size: int = 128
@export var tileset: TileSet
@export var level_generator: LevelGenerator

func _input(event):
	if event.is_action_pressed('ui_accept'):
		tile_map.tile_set = tileset
		tile_map.cell_quadrant_size = tile_size
		tile_map.clear()
		var map: LevelGenerator.Map = level_generator.get_level() as LevelGenerator.Map;
		tile_map.set_cells_terrain_connect(1, map.level, 0, 0, false)
		tile_map.set_cells_terrain_connect(2, map.border, 0, 1, false)
		tile_map.set_cells_terrain_connect(0, map.level + map.border, 0, 2, false)
