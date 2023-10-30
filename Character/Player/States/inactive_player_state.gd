extends State

func get_state_name() -> StringName:
	return 'INACTIVE'

func can_enter_state() -> bool:
	return state_machine.abilities.is_inactive()

func enter_state() -> void:
	character.velocity = Vector2.ZERO
	character.set_anim('RESET')
	PlayerData.stats.speed_modifier = 0
	return

func exit_state() -> void:
	character.set_anim('RESET')
	PlayerData.stats.speed_modifier = 1
	return

func update(_delta: float) -> void:
	return
