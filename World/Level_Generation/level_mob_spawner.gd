extends Node
var cell_size: int

const dirs8 = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT, \
Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]

func initialize(_cell_size: int):
	cell_size = _cell_size

func get_spawn_positions(_map: LevelGenerator.Map) -> Array[Vector2i]:
	var spawn_pos: Array[Vector2i] = []
	for cell in _map.level:
		if randf() > 0.9:
			spawn_pos.append(cell)
	return spawn_pos

func get_player_spawn_position(_map: LevelGenerator.Map) -> Vector2i:
	_map.level.sort_custom(func(a,b): return (a.y == b.y and a.x < b.x) or a.y > b.y)
	for cell in _map.level:
		var is_room_center: bool = true
		for dir in dirs8:
			if not _map.level.has(cell + dir):
				break
			for dir2 in dirs8:
				if not _map.level.has(cell + dir):
					is_room_center = false
					break
		if is_room_center:
			return cell
	return Vector2i.ZERO

func spawn_player(pos: Vector2i) -> void:
	Event.player_teleport.emit(Vector2(pos.x * cell_size + 0.5 * cell_size, pos.y * cell_size + 0.5 * cell_size))

func spawn_mob(pos: Vector2i) -> void:
	var mob_ps: PackedScene = Data.get_random_monster()
	var global_pos = Vector2(pos.x * cell_size + 0.5 * cell_size, pos.y * cell_size + 0.5 * cell_size)
	Event.spawn_mob.emit(mob_ps, global_pos)

func spawn_units(_map : LevelGenerator.Map) -> void:
	var player_pos: Vector2i = get_player_spawn_position(_map)
	spawn_player(player_pos)
	var spawn_pos: Array[Vector2i] = get_spawn_positions(_map)
	var last = Vector2i.ZERO
	for pos in spawn_pos:
		if abs(pos.x - player_pos.x) + abs(pos.y - player_pos.y) < 5:
			continue
		if abs(pos.x - last.x) + abs(pos.y - last.y) < 5:
			continue
		last = pos
		spawn_mob(pos)
