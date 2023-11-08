class_name Player
extends Character

@export var player_stats: PlayerStats

@export_group('Sound & Anim Dependencies')
@export var rotation_part: Node2D

# CharacterController override
func _ready() -> void:
	stats = PlayerData.stats
	Event.player_level_up.connect(_on_level_up)
	super._ready()
	Event.player_ready.emit(self)
	Event.player_teleport.connect(_on_teleport)

func _on_take_hit(other_hitbox: Hitbox) -> void:
	super._on_take_hit(other_hitbox)
	Event.player_take_hit.emit()

func _on_die() -> void:
	Event.player_die.emit()
	super._on_die()

func _physics_process(_delta):
	target_direction = (get_global_mouse_position() - global_position).normalized()

func _on_teleport(_position: Vector2) -> void:
	global_position = _position

#Animation
func _on_level_up(_level):
	hit_anim.play("Holly")

func _process(delta):
	var isMoving = velocity != Vector2.ZERO
	super._process(delta)
	if velocity == Vector2.ZERO:
		if isMoving:
			state_machine.try_change_state('IDLE')
	else:
		if !isMoving:
			state_machine.try_change_state('WALK')

func save() -> Dictionary:
	for prop in get_property_list():
		print(prop.name)
		print(get(prop.name))
	var save_data = {}
	return save_data