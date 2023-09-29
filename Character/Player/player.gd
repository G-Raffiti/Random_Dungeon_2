class_name Player
extends Character

@export var player_stats: PlayerStats

# CharacterController override
func _ready() -> void:
	stats = PlayerData.stats
	Event.player_level_up.connect(_on_level_up)
	super._ready()

func _on_take_hit(other_hitbox: Hitbox) -> void:
	super._on_take_hit(other_hitbox)
	Event.player_take_hit.emit()

func _on_die() -> void:
	Event.player_die.emit()
	super._on_die()

func _physics_process(_delta):
	target_direction = (get_global_mouse_position() - global_position).normalized()

#Animation
func _on_level_up(_level):
	hit_anim.play("Holly")
