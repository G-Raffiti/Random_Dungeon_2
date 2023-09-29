class_name StateMachine
extends Node2D

## Dictionary[StringName, State] all available States
var states: Dictionary = {}
var state: State = null:
	get: return state
	set(new_state):
		if new_state.can_enter_state():
			if state != null:
				state.exit_state()
			state = new_state
			state.enter_state()

# Dependency
var abilities: AbilityHolder
var user: Character

func initialize(ability_holder: AbilityHolder, character: Character) -> void:
	abilities = ability_holder
	user = character
	for n in get_child_count():
		if not get_child(n) is State: continue
		var state_n = get_child(n) as State
		states[state_n.get_state_name()] = state_n
	connect_states()
	self.state = states['INACTIVE']

func connect_states() -> void:
	for n in states:
		states[n].connectState(self)

func try_change_state(state_name: StringName) -> void:
	if not states.has(state_name): return
	var new_state = states[state_name]
	if new_state.priority >= state.priority:
		self.state = new_state

func back_main_state() -> void:
	self.state = states['IDLE']
	for n in states:
		if 'monitoring' in states[n]:
			states[n].set_deferred('monitoring', false)
	await get_tree().physics_frame
	for n in states:
		if 'monitoring' in states[n]:
			states[n].set_deferred('monitoring', true)

func _physics_process(delta):
	state.update(delta)

func get_direction() -> Vector2:
	return state.direction
