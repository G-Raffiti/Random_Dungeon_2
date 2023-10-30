extends Ability_Resource

@export_group('Type and Values')
@export var damage_value: int
@export var damage_type: G.Element
@export var knockback_strenght: int = 120
@export var can_move: bool = false

func starts(user: Character):
	scale_animation_speed(user, 'parameters/melee_attack/TimeScale/scale')
	user.hitbox.set_stats(get_damage(user.stats.damage_value), knockback_strenght)
	user.sound.randomize_pitch()
	if not can_move:
		user.stats.speed_modifier = 0
	user.set_anim('melee_attack')

func ends(user):
	user.stats.speed_modifier = 1
	scale_animation_speed_back(user, "parameters/melee_attack/TimeScale/scale")

func process(_user, _delta):
	return

#Region Extra

func get_damage(user_damage: int) -> G.Damage:
	return G.Damage.new(user_damage + damage_value, damage_type)

#Region UI
func get_description(user: Character) -> String:
	var ret = super.get_description(user)
	ret += "A Melee Attack in the target direction, deal damage on hit\n"
	ret += "Damage = " + get_damage(user.stats.damage_value + damage_value).str()
	if can_move : ret += "\n" + "can move while attacking"
	return ret
#EndRegion