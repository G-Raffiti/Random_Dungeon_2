class_name Stats
extends Resource

# private signals to catch with the owner of the stats
signal hp_changed(hp: int, max_hp: int)
signal die()

# Life -------------------------------------------------------------------------
@export_group('Life')
## seconds of invulnerability after taking a hit
@export var safety_duration: float = 0.0
## maximum life
@export var max_hp: int = 2
var hp: int = max_hp:
	get: return hp
	set(value):
		hp = clamp(value, 0, max_hp)
		hp_changed.emit(hp, max_hp)
		if hp == 0:
			die.emit()

# Damage -----------------------------------------------------------------------
@export_group('Damage')
## damage value delt on hit
@export var damage_value: int = 1
# TODO: implement damage type and Resistance 
@export var damage_type: G.Element = G.Element.PHYS
## when a hit knockbacks, this strength play a roll in cc time and distance
@export var knockback_strength: int = 0

# Move -------------------------------------------------------------------------
@export_group('Movement')
## acceleration increase the time it takes to reach full speed
@export var acceleration = 300
## normal speed of the owner
@export var speed = 150
## mass increase the resistance to knockback
@export var mass = 200
## change it to slow / chill / hast etc..
var speed_modifier: float = 1.0

## get the damage structure
func get_damage()-> G.Damage:
	return G.Damage.new(damage_value, damage_type)

# TODO: implement damage type and Resistance
func _on_take_hit(hitbox: Hitbox) -> void:
	on_damaged(hitbox.damage.value)

func on_damaged(damage_taken) -> void:
	self.hp -= damage_taken
	
func on_healed(heal_taken) -> void:
	self.hp += heal_taken
