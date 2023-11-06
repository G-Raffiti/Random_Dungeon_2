extends StateMachine

var direction: Vector2 = Vector2.ZERO
# Input
var last_move_input: Vector2 = Vector2.RIGHT

func initialize(ability_holder: AbilityHolder, character: Character) -> void:
	super.initialize(ability_holder, character)
	self.state = states['IDLE']
	ability_holder.state_machine = self

func back_main_state() -> void:
	self.state = states['IDLE']

# Get Inputs
func _process(_delta):
	direction = get_input()
	if direction != Vector2.ZERO:
		last_move_input = direction
	if not abilities.is_inactive():
		direction = Vector2.ZERO

func get_input() -> Vector2:
	return Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down').normalized()

func get_direction() -> Vector2:
	return direction
