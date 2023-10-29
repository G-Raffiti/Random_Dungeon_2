extends Node

@onready var tile_map: TileMap = $TileMap

func generate_map(tile_size: int, tileset: TileSet, level_generator: LevelGenerator) -> LevelGenerator.Map:
	tile_map.tile_set = tileset
	tile_map.cell_quadrant_size = tile_size
	tile_map.clear()
	var map: LevelGenerator.Map = level_generator.get_level() as LevelGenerator.Map
	Event.map_changed.emit(map)
	tile_map.set_cells_terrain_connect(1, map.level, 0, 0, false)
	tile_map.set_cells_terrain_connect(2, map.border, 0, 1, false)

	var background_tiles: Array[Vector2i] = []
	for x in range(map.top_left.x - 10, map.bottom_right.x + 11):
		for y in range(map.top_left.y - 5, map.bottom_right.y + 6):
			background_tiles.append(Vector2i(x, y))
	tile_map.set_cells_terrain_connect(0, background_tiles, 0, 2, false)
	return map