extends Node2D
class_name LevelService

signal map_generated()

@export var tile_size: int = 128
@export var tileset: TileSet
@export var level_generator: LevelGenerator

@onready var tile_map_generation = $tile_map_generation
@onready var unit_generation = $unit_generation

func _ready():
	unit_generation.initialize(tile_size)

func generate_map():
	var map: LevelGenerator.Map = tile_map_generation.generate_map(tile_size, tileset, level_generator)
	unit_generation.spawn_units(map)
	map_generated.emit()