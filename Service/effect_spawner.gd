extends Node

## where the effects will be spawned
@export var effects: Node2D

func _ready():
	Event.play_effect.connect(_on_play_effect)

func _on_play_effect(effect_ps: PackedScene, pos: Vector2) -> void:
	var effect: Node = effect_ps.instance()
	effect.global_position = pos
	get_parent().add_child(effect)
