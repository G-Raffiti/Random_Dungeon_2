extends State

func get_state_name() -> StringName:
	return 'WALK'

func can_enter_state() -> bool:
	return character.velocity != Vector2.ZERO

func enter_state() -> void:
	character.set_anim('walk')

func exit_state() -> void:
	return

func update(_delta: float) -> void:
	return
