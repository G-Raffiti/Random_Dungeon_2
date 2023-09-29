class_name Movement
extends Node

const MINIMUM_VELOCITY: float = 1.0

var stats: Stats
var state: StateMachine

var push: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func initialize(controller_stats: Stats, controller_state_machine: StateMachine):
	stats = controller_stats
	state = controller_state_machine

func knockback(knockback_vector: Vector2):
	push = knockback_vector

func _process(delta):
	# case the character is knocked back
	if push != Vector2.ZERO:
		push = push.move_toward(Vector2.ZERO, stats.mass * delta)
		if push.length() <= MINIMUM_VELOCITY:
			push = Vector2.ZERO
		velocity = push
	# else the direction is given by the state machine
	elif state.get_direction() != Vector2.ZERO:
		velocity = velocity.move_toward(state.get_direction() * stats.speed * stats.speed_modifier, stats.acceleration * delta)
		if velocity.length() <= MINIMUM_VELOCITY:
			velocity = Vector2.ZERO
	# in the case the state machine doesen't give direction
	else:
		velocity = Vector2.ZERO
	
