extends Ability_Resource

@export_group('Damages')
@export var damage_value: int
@export var damage_type: G.Element

@export_group('Ability Stats')
@export var knockback_strenght: int = 120
@export var can_move: bool = false
@export var multistrike: int = 0
@export var area_scale: Vector2= Vector2.ONE

var multistrike_count: int = 0

func starts(user : Character):
	var animation_active_time: float = active_time
	var attack_direction = (user.get_global_mouse_position() - user.global_position).normalized()
	
	user.rotation_part.set_rotation(attack_direction.angle() - PI/2)
	scale_attack(user)
	user.hitbox.set_stats(get_damage(user), knockback_strenght, attack_direction)

	if not can_move:
		user.stats.speed_modifier = 0
	if multistrike > 0:
		animation_active_time /= 1 + multistrike
		multistrike_count = multistrike
		user.anim_tree.animation_finished.connect(func(): replay_attack(user))

	scale_animation_speed(user, "parameters/Attack/TimeScale/scale", animation_active_time)
	user.sound.randomize_pitch()
	user.set_anim("ability_slash")
	pass

func ends(user : Character):
	if not can_move:
		user.stats.speed_modifier = 1
	user.hitbox.disable()
	unscale_attack(user)
	scale_animation_speed_back(user, "parameters/Attack/TimeScale/scale")

func process(_user : Character, _delta: float):
	return

func can_use(ability_holder: AbilityHolder) -> bool:
	return ability_holder.is_inactive()

func get_description(user: Character) -> String:
	var ret = super.get_description(user)
	ret += "A Melee Attack in the cursor direction,\n"
	ret += "Deals " + get_damage(user).str() + " in "
	if area_scale.y <= 1 : ret += "small"
	elif area_scale.y <= 1.5 : ret += "medium"
	else : ret += "big"
	ret += " area."
	if can_move : ret += "\n" + "can move while attacking."
	return ret
	
#Region Extra
func scale_attack(user):
	if area_scale != Vector2.ONE:
		user.hitbox.scale = area_scale
		user.rotation_part.scale.x = area_scale.y
		user.rotation_part.scale.y = area_scale.x
	
func unscale_attack(user):
	user.hitbox.scale = Vector2.ONE
	user.rotation_part.scale = Vector2.ONE

func get_damage(user: Character = null) -> G.Damage:
	if not user:
		return G.Damage.new(damage_value, damage_type)
	return G.Damage.new(user.stats.damage_value + damage_value, damage_type)

func replay_attack(user):
	if multistrike_count > 0:
		multistrike_count -= 1
		user.sound.randomize_pitch()
		user.set_anim("ability_slash")
	pass