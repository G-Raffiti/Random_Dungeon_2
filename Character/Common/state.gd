@icon("res://Art/Icons/state.svg")
class_name State
extends Node2D

## signal sent try to enter this state (if a collision trigger, or if hp drop below a certain amount)
signal state_condition_on(state_name: StringName)
## signal sent to exit this state if a ondition trigger (will automatically go back to the main state)
signal state_condition_off
## the importance of a state, bigger = more important ex:(attack > idle)
@export var priority: int

@onready var state_machine: StateMachine
var character: Character

# state variable (the state machine get this values)
## normalized direction with the character as referentiel
var direction: Vector2 = Vector2.ZERO

func connectState(machine: StateMachine) -> void:
	state_machine = machine
	state_condition_on.connect(state_machine.try_change_state)
	state_condition_off.connect(state_machine.back_main_state)
	character = state_machine.user
	initialize()

func initialize() -> void:
	return

func get_state_name() -> StringName:
	return 'NONE'

func can_enter_state() -> bool:
	return true

func enter_state() -> void:
	return

func exit_state() -> void:
	return

func update(_delta: float) -> void:
	return

func send_signal_on() -> void:
	if can_enter_state():
		state_condition_on.emit(get_state_name())

func send_signal_off() -> void:
	if state_machine.state == self:
		state_condition_off.emit()
