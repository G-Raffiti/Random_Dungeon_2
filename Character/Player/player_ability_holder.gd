class_name PlayerAbilityHolder
extends AbilityHolder

func _process(_delta):
	for n in abilities:
		if Input.is_action_just_pressed(n):
			abilities[n].Use_Ability()

func _ready():
	Event.player_ability_changed.connect(add_ability)
	super._ready()
	for action in InputMap.get_actions():
		if action.begins_with("ui") : continue
		if not action.begins_with("ability_") : continue
		if abilities.has(action) : continue
		var ability: Ability = ability_ps.instantiate()
		add_child(ability)
		ability.ability_holder = self
		ability.input_action = action
		abilities[action] = ability
