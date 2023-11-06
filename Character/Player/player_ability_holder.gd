class_name PlayerAbilityHolder
extends AbilityHolder

var state_machine: StateMachine
@export var abilities_inventory: Array[Ability_Resource] = []

func _process(_delta):
	for n in abilities:
		if Input.is_action_just_pressed(n):
			state_machine.try_change_state('USE_ABILITY')
			abilities[n].use_ability()

func _ready():
	Event.player_ability_changed.connect(add_ability)
	super._ready()
	for action in InputMap.get_actions():
		if not action.begins_with("ability_") : continue
		if abilities.has(action) : continue
		var ability: Ability = ability_ps.instantiate()
		add_child(ability)
		ability.ability_holder = self
		ability.input_action = action
		abilities[action] = ability

func set_ability(ability_resource: Ability_Resource, input_action: StringName):
	abilities[input_action].ability = ability_resource
