extends State

func get_state_name() -> StringName:
	return 'IDLE'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	character.set_anim('idle')

func exit_state() -> void:
	return

func update(_delta: float) -> void:
	return
