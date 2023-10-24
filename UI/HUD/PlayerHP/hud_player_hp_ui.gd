class_name PlayerHPBar
extends Control

@onready var player_hp_bar: ProgressBar = $ProgressBar
@onready var player_hp_label: Label = $Label

func _ready():
	PlayerData.stats.hp_changed.connect(_on_hp_changed)
	var hp: int = PlayerData.stats.hp
	var max_hp: int = PlayerData.stats.max_hp
	player_hp_bar.max_value = max_hp
	player_hp_bar.value = hp
	player_hp_label.text = str(hp) + "/" + str(max_hp)

func _on_hp_changed(hp: int, max_hp: int):
	player_hp_bar.max_value = max_hp
	player_hp_bar.value = hp
	player_hp_label.text = str(hp) + "/" + str(max_hp)
