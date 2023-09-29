extends State
## average duration in second to stay idle
@export var idle_time: float = 2.5

@onready var timer: RandomTimer = $random_timer

func _ready():
	timer.timeout.connect(_on_timeout)

func get_state_name() -> StringName:
	return 'IDLE'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	character.set_anim('idle')
	direction = Vector2.ZERO
	timer.start_random(idle_time * 0.5, idle_time * 1.5)

func exit_state() -> void:
	timer.stop()
	return

func update(_delta: float) -> void:
	return

func _on_timeout() -> void:
	state_machine.try_change_state('WANDER')
