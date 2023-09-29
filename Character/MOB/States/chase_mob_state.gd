extends State

var target: Player = null

func _ready():
	self.body_entered.connect(_on_player_entered)
	self.body_exited.connect(_on_player_exited)

func get_state_name() -> StringName:
	return 'CHASE'

func can_enter_state() -> bool:
	return target != null and not target.is_dying

func enter_state() -> void:
	character.set_anim('walk')
	direction = get_target_direction()

func exit_state() -> void:
	target = null

func update(_delta: float) -> void:
	direction = get_target_direction()

func _on_player_entered(body: CharacterBody2D) -> void:
	if not body is Player: return
	target = body as Player
	send_signal_on()

func _on_player_exited(_body: CharacterBody2D) -> void:
	send_signal_off()

func get_target_direction() -> Vector2:
	return (target.position - character.position).normalized()
