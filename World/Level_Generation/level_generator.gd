extends Resource
class_name LevelGenerator

enum LevelType {cave, dungeon, forest}
const dirs = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
const dirs8 = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT, \
Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]

@export_category('Level Generator')
@export var type = LevelType.cave
@export_range(50, 2000) var steps = 500
@export_range(1, 10) var walkers = 3
@export_group('Dungeon')
@export_range(1, 20) var max_room_size = 7
@export_range(1, 20) var coridor_len = 5
@export_range(1, 20) var dencity_room = 10

class Map:
	var level: Array[Vector2i]
	var border: Array[Vector2i]
	var size: Vector2i
	var type: LevelType

	func _init(_level: Array[Vector2i], _size: Array[Vector2i], _type: LevelType, _border: Array[Vector2i] = []):
		level = _level
		size = _size[1] - _size[0]
		type = _type
		border = _border

class Walker:
	var pos: Vector2i = Vector2i.ZERO
	var steps: int = 0
	var dir: int
	var type: LevelType
	var special: int

	func _init(n: int, _type: LevelType, _special: int = 0):
		dir = n % 4
		type = _type
		special = _special

	func get_next_dir() -> Vector2i:
		match type:
			LevelType.cave:
				dir += [-1, 0, 1].pick_random()
				dir %= 4
			LevelType.dungeon:
				if steps % special == 0:
					dir += randi_range(0, 4)
					dir %= 4
		return dirs[dir]
	
	func get_next_pos() -> Vector2i:
		pos += get_next_dir()
		steps += 1
		return pos

func generate_cave_level(number_of_walker: int, max_steps: int) -> Array[Vector2i]:
	var dungeon: Array[Vector2i] = [Vector2i.ZERO]
	for n in range(number_of_walker):
		var walker: Walker = Walker.new(n, LevelType.cave)
		while walker.steps < (max_steps / number_of_walker):  #warning-ignore:integer_division
			var step = walker.get_next_pos()
			if not dungeon.has(step):
				dungeon.push_front(step)
			if not dungeon.has(step + Vector2i.UP):
				dungeon.push_front(step + Vector2i.UP)
			if not dungeon.has(step + Vector2i.RIGHT):
				dungeon.push_front(step + Vector2i.RIGHT)
			if not dungeon.has(step + Vector2i(1, -1)):
				dungeon.push_front(step + Vector2i(1, -1))
			else:
				walker.steps -= 1
	return dungeon		 

func add_room(dungeon: Array[Vector2i], pos: Vector2i):
	var room_size = Vector2i(randi_range(4, max_room_size), randi_range(4, max_room_size))
	var corner = pos - room_size / randi_range(2, max_room_size / 2) #warning-ignore:integer_division
	for y in range(room_size.y):
		for x in range(room_size.x):
			if not dungeon.has(corner + Vector2i(x,y)):
				dungeon.push_front(corner + Vector2i(x,y))
	return room_size.x * (room_size.y - 1)


func generate_dungeon_level(number_of_walker: int, max_steps: int) -> Array[Vector2i]:
	var dungeon: Array[Vector2i] = [Vector2i.ZERO]
	for n in range(number_of_walker):
		var walker: Walker = Walker.new(n, LevelType.dungeon, coridor_len)
		add_room(dungeon, walker.pos)
		while walker.steps < (max_steps / number_of_walker): #warning-ignore:integer_division
			var step = walker.get_next_pos()
			if not dungeon.has(step):
				dungeon.push_front(step)
			if not dungeon.has(step + Vector2i.UP):
				dungeon.push_front(step + Vector2i.UP)
			if not dungeon.has(step + Vector2i.RIGHT):
				dungeon.push_front(step + Vector2i.RIGHT)
			if not dungeon.has(step + Vector2i(1, -1)):
				dungeon.push_front(step + Vector2i(1, -1))
			elif walker.steps % (21 - dencity_room) == 0:
				add_room(dungeon, step)
		add_room(dungeon, walker.pos)
	return dungeon 

func get_size(dungeon: Array[Vector2i]) -> Array[Vector2i]:
	var up_left: Vector2i = dungeon[0]
	var down_right: Vector2i = dungeon[-1]
	for cell in dungeon:
		if cell.x < up_left.x:
			up_left.x = cell.x
		if cell.x > down_right.x:
			down_right.x = cell.x
	return [up_left, down_right]

func get_level(number_of_walkers: int = walkers, max_steps: int = steps, level_type: LevelType = type) -> Map:
	# var level: Array[Array] = []
	var dungeon: Array[Vector2i] = []
	match level_type:
		LevelType.cave:
			dungeon = generate_cave_level(number_of_walkers, max_steps)
		LevelType.dungeon:
			dungeon = generate_dungeon_level(number_of_walkers, max_steps)
	dungeon.sort_custom(func(a,b): return (a.y == b.y and a.x < b.x) or a.y < b.y)
	var size = get_size(dungeon)
	return Map.new(dungeon, size, level_type, get_border(dungeon))
	
func get_border(level: Array[Vector2i]) -> Array[Vector2i]:
	var border: Array[Vector2i] = []
	for cell in level:
		for dir in dirs8:
			if not level.has(cell + dir):
				border.push_front(cell + dir)
	return border

func print_dungeon(level: Array[Vector2i], size: Array[Vector2i]) -> void:
	var up_line = ''
	for x in range(size[0].x - 1, size[1].x + 1):
		up_line += '# '
	print(up_line)
	for y in range(size[0].y, size[1].y):
		var line = '# '
		for x in range(size[0].x, size[1].x):
			if level.has(Vector2i(x, y)):
				line += '  '
			else:
				line += '# '
		print(line + '# ')
	print(up_line)

func print_level(level: Array[Array]):
	for line in level:
		var l = ''
		for cell in line:
			if cell:
				l += '  '
			else:
				l += '# '
		print(l)
