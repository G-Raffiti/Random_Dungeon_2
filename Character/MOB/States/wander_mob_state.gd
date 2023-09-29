extends State

## point arround witch the character wander
var starting_point: Vector2
## average duration in second of one move in one direction
@export var change_time: float = 2.5
## chance to stop moving after each move
@export_range(0, 1.0, 0.01) var chance_to_idle: float = 0.5

@onready var timer: RandomTimer = $random_timer

func _ready():
	timer.timeout.connect(_on_timeout)

func initialize():
	starting_point = character.position

func get_state_name() -> StringName:
	return 'WANDER'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	character.stats.speed_modifier = 0.5
	character.anim_tree['parameters/walk/TimeScale/scale'] = 0.5
	set_direction()

func exit_state() -> void:
	character.stats.speed_modifier = 1
	character.anim_tree['parameters/walk/TimeScale/scale'] = 1
	timer.stop()

func update(_delta: float) -> void:
	return

func set_direction() -> void:
	direction = ((starting_point - character.position).normalized() + Vector2(randf_range(-1, 1), randf_range(-1, 1))).normalized()
	character.set_anim('walk')
	timer.start_random(change_time * 0.5, change_time * 1.5)

func _on_timeout() -> void:
	if randf() > chance_to_idle:
		state_condition_off.emit()
		return
	set_direction()
