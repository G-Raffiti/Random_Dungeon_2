extends Node

## where the effects will be spawned
@export var units: Node2D

func _ready():
	Event.spawn_mob.connect(_on_mob_spawned)

func _on_mob_spawned(mob_ps: PackedScene, pos: Vector2) -> void:
	var mob: Mob = mob_ps.instantiate()
	mob.global_position = pos
	units.add_child(mob)
