class_name Ability
extends Node

signal ability_modified(ability)
signal charge_change(value)

## Ability that can be used from the begining
@export var preloaded_ability: Ability_Resource
## input_action can be an Action / Key_maped or a name for AI 
@export var input_action: String

@onready var ability_holder: AbilityHolder

# ability State
enum { ACTIVE, COOLDOWN, READY }
var state = READY
# timers to change State
@onready var active_timer = $active_timer
@onready var cooldown_timer = $cooldown_timer
## an Ability with an ActiveTime of 0 or less is considered as instant 
var instant: bool = false

var charge:int = 1:
	get: return charge
	set(value):
		charge = value
		charge_change.emit(charge)

var ability : Ability_Resource:
	get: return ability
	set(value): 
		ability = value
		ability_modified.emit(self)

func _ready():
	active_timer.timeout.connect(_on_active_timer_timeout)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	if preloaded_ability != null :
		self.ability = preloaded_ability
	else:
		ability = null
		return
	if ability.charge > 1:
		cooldown_timer.set_wait_time(ability.cooldown_time)
		cooldown_timer.start()

# Called by Ability Holder to Use this ability
func use_ability():
	# Check if the Ability can be used
	if ability == null : return
	if state != READY : return
	if charge < 1 : 
		state = COOLDOWN
		return
	if not ability.can_use(ability_holder) : return
	
	# Set State to Active
	state = ACTIVE
	
	# Use a Charge            
	self.charge -= 1
	
	# Use the Ability
	ability.starts(ability_holder.user)     
	
	# Start the Active Time
	if ability.active_time > 0:
		active_timer.set_wait_time(ability.active_time)
		active_timer.start()
	else:
		_on_active_timer_timeout()

## Change State from Active to Cooldown
func _on_active_timer_timeout():
	if ability == null : return
	ability.ends(ability_holder.user)

	# case the Ability has no cooldown
	if ability.cooldown_time <= 0:
		state = READY
		self.charge += 1
		return

	# check if the Ability has more than one charge available
	if charge > 0:
		state = READY
	else:
		state = COOLDOWN

	# Start the cooldown tiimer if it's not running
	if cooldown_timer.get_time_left() <= 0 and ability.cooldown_time > 0:
		cooldown_timer.start(ability.cooldown_time)

# Set the Ability to Ready
func _on_cooldown_timer_timeout():
	if ability == null : return
	self.charge += 1
	state = READY
	if charge < ability.charge:
		cooldown_timer.start(ability.cooldown_time)

func _process(delta):
	if ability == null : return
	if state != ACTIVE : return
	ability.process(ability_holder.user, delta)
