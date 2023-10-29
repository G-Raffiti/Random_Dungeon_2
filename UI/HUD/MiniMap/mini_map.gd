extends Control

@export var tileset : TileSet
@export var zoom: float = 0.5
@onready var container = $MarginContainer/SubViewportContainer
@onready var viewport = $MarginContainer/SubViewportContainer/SubViewport
@onready var player_marker = $MarginContainer/SubViewportContainer/SubViewport/TileMap/PlayerMarker
@onready var mob_marker = $MobMarker
@onready var exit_marker = $ExitMarker
@onready var tile_map = $MarginContainer/SubViewportContainer/SubViewport/TileMap

var is_player_ready: bool = false
var player : Character
var mobs: Dictionary = {}
var door: Node2D
var grown: bool = false

var is_mouse_inside = false

func _init():
	Event.map_changed.connect(_on_map_loaded)
	Event.player_ready.connect(_add_player)

func _ready():
	tile_map.scale = Vector2(zoom, zoom)

func _process(_delta):
	if not is_player_ready : return
	var pos: Vector2 = -player.position * tile_map.get_global_scale() + container.size / 2
	tile_map.position = pos
	player_marker.position = player.position
	for mob in mobs:
		mobs[mob].position = mob.position

func _on_map_loaded(map: LevelGenerator.Map):
	clear()
	tile_map.set_cells_terrain_connect(0, map.border, 0, 0, false)

func _add_player(new_player: Character):
	player = new_player
	if !player.tree_exiting.is_connected(stop):
		player.tree_exiting.connect(stop)
	is_player_ready = true

func _add_mob(mob: Character):
	var marker = mob_marker.duplicate()
	tile_map.add_child(marker)
	mobs[mob] = marker

func _add_exit(pos):
	door = exit_marker.duplicate()
	tile_map.add_child(door)
	door.position = pos
	
func _on_mob_dies(mob):
	if not is_player_ready : return
	mobs[mob].queue_free()
	mobs.erase(mob)

func _on_mouse_entered():
	is_mouse_inside = true

func _on_mouse_exited():
	is_mouse_inside = false

func _unhandled_input(event):
	if event.is_action_pressed('map'):
		if grown:
			shrink()
		else:
			grow()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += 0.01
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= 0.01
	zoom = clamp(zoom, 0.05, 0.5)
	tile_map.scale = Vector2(zoom, zoom)

func stop():
	is_player_ready = false

func clear():
	for marker in mobs.values():
		marker.queue_free()
	mobs = {}
	tile_map.clear()

func grow():
	var tween = create_tween()
	tween.parallel().tween_property($MarginContainer, 'anchor_left', 0.1, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_top', 0.1, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_right', 0.9, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_bottom', 0.9, 0.5)
	grown = true

func shrink():
	var tween = create_tween()
	tween.parallel().tween_property($MarginContainer, 'anchor_left', 0.8, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_top', 0, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_right', 1, 0.5)
	tween.parallel().tween_property($MarginContainer, 'anchor_bottom', 0.3, 0.5)
	tween.parallel()
	grown = false
