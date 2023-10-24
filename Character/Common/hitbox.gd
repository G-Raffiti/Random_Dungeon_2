class_name Hitbox
extends Area2D

@export var is_allways_active: bool = false
var knockback_fixed_direction: Vector2 = Vector2.ZERO
var knockback_strength: int = 0
var hurtbox_touched: Array[Hurtbox]
var damage: G.Damage

func _ready():
	monitorable = is_allways_active
	self.area_entered.connect(_on_hurtbox_touched)

func set_stats(set_damage: G.Damage, knockback_str: int = 0, knockback_fixed_dir: Vector2 = Vector2.ZERO) -> void:
	damage = set_damage
	knockback_strength = knockback_str
	knockback_fixed_direction = knockback_fixed_dir

func get_knockback(hurtbox_position : Node2D) -> Vector2:
	if knockback_fixed_direction != Vector2.ZERO:
		return knockback_fixed_direction * knockback_strength
	else:
		return (get_global_position() - hurtbox_position.get_position()).normalized() * knockback_strength

func enable() -> void:
	set_deferred('monitorable', true)

func disable() -> void:
	set_deferred('monitorable', false)
	hurtbox_touched.clear()

func _on_hurtbox_touched(area: Area2D) -> void:
	if not area is Hurtbox: return
	hurtbox_touched.append(area as Hurtbox)
