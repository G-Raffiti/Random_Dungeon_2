class_name Hurtbox
extends Area2D

signal on_hit_taken(hitbox: Hitbox)
@onready var safety_timer: Timer = $safety_timer
var can_take_hit: bool = true
var hit_anim: AnimationPlayer = null
var user: Node2D

func _ready():
	self.area_entered.connect(_on_hit_taken)
	safety_timer.timeout.connect(_on_safety_timeout)

func initialize(hurtbox_owner: Node2D, anim: AnimationPlayer, safety_duration: float) -> void:
	hit_anim = anim
	safety_timer.wait_time = safety_duration
	user = hurtbox_owner

func _on_hit_taken(area: Area2D) -> void:
	if not can_take_hit: return
	if not area is Hitbox: return
	if area.hurtbox_touched.has(self) and not area.is_allways_active: return
	can_take_hit = false
	on_hit_taken.emit(area as Hitbox)
	safety_timer.start()
	hit_anim.play('blink_on')

func _on_safety_timeout() -> void:
	hit_anim.play('blink_off')
	can_take_hit = true
