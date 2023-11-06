extends State

func initialize() -> void:
	for ability in character.ability_holder.abilities.values():
		ability.active_timer.timeout.connect(send_signal_off)

func get_state_name() -> StringName:
	return 'USE_ABILITY'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	character.target_direction = get_target_direction()

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	direction = get_target_direction()
	character.target_direction = direction

func get_target_direction() -> Vector2:
	return (get_global_mouse_position() - character.global_position).normalized()
