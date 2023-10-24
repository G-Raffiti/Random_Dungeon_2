extends State

var target: Player = null
@export var ability_resource: Ability_Resource = null
var ability: Ability

func _ready():
	self.area_entered.connect(_on_player_entered)

func initialize() -> void:
	character.ability_holder.add_ability(ability_resource, get_state_name())
	ability = character.ability_holder.abilities[get_state_name()]
	ability.active_timer.timeout.connect(send_signal_off)

func get_state_name() -> StringName:
	return 'MELEE_ATTACK'

func can_enter_state() -> bool:
	return ability.state == Ability.READY and target != null

func enter_state() -> void:
	character.target_direction = get_target_direction()
	character.stats.speed_modifier = 0.1
	ability.use_ability()

func exit_state() -> void:
	character.stats.speed_modifier = 1
	target = null

func update(_delta: float) -> void:
	if not target: 
		return send_signal_off()
	direction = get_target_direction()
	character.target_direction = direction

func _on_player_entered(area: Area2D) -> void:
	if not 'user' in area or not area.user is Player: return
	target = area.user as Player
	send_signal_on()

func get_target_direction() -> Vector2:
	return (target.position - character.position).normalized()
