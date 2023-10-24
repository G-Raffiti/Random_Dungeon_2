extends Control
class_name MobHPBar

@onready var mob_hp_bar: ProgressBar = $ProgressBar
@onready var mob_hp_label: Label = $Label

func initialize(mob: Mob):
	mob.stats.hp_changed.connect(_on_hp_changed)
	var hp: int = mob.stats.hp
	var max_hp: int = mob.stats.max_hp
	mob_hp_bar.max_value = max_hp
	mob_hp_bar.value = hp
	mob_hp_label.text = str(hp) + "/" + str(max_hp)

func _on_hp_changed(hp: int, max_hp: int):
	mob_hp_bar.max_value = max_hp
	mob_hp_bar.value = hp
	mob_hp_label.text = str(hp) + "/" + str(max_hp)
