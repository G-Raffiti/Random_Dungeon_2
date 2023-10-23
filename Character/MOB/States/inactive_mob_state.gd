extends State

#func _ready():
#	self.body_entered.connect(_on_player_entered)
#	self.body_exited.connect(_on_player_exited)

func get_state_name() -> StringName:
	return 'INACTIVE'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	character.set_anim('RESET')
	character.velocity = Vector2.ZERO
	character.stats.speed_modifier = 0
	direction = Vector2.ZERO

func exit_state() -> void:
	character.stats.speed_modifier = 1
	return

func update(_delta: float) -> void:
	return

#func _on_player_entered(_body: CharacterBody2D) -> void:
#	send_signal_off()

#func _on_player_exited(_body: CharacterBody2D) -> void:
#	send_signal_on()
