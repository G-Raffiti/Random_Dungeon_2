class_name Character
extends CharacterBody2D

@export_group('Character Dependencies')
@export var movement: Movement
@export var hurtbox: Hurtbox
@export var hitbox: Hitbox
@export var ability_holder: AbilityHolder
@export var state_machine: StateMachine

@export_group('Sound & Anim Dependencies')
@export var sound: AudioStreamPlayer2D
@export var hit_sound: AudioStreamPlayer2D
@export var hit_anim: AnimationPlayer
@export var anim: AnimationPlayer
@export var anim_tree: AnimationTree
@onready var state_anim: AnimationNodeStateMachinePlayback
@export var sprites: Node2D

@export_group('Effects')
@export var death_effect_ps: PackedScene
@export var hurt_effect_ps: PackedScene

var stats: Stats
var is_dying: bool = false
var target_direction: Vector2

func _ready() -> void:
	state_anim = anim_tree.get("parameters/playback")
	#init stats
	stats.die.connect(_on_die)
	#init movement
	movement.initialize(stats, state_machine)
	#init hurtbox
	hurtbox.initialize(self, hit_anim, stats.safety_duration)
	hurtbox.on_hit_taken.connect(stats._on_take_hit)
	hurtbox.on_hit_taken.connect(_on_take_hit)
	#init ability holder
	ability_holder.initialize(self)
	#init state machine
	anim_tree.active = true
	state_machine.initialize(ability_holder, self)

func _on_take_hit(other_hitbox: Hitbox) -> void:
	movement.knockback(other_hitbox.get_knockback(hurtbox))
	Event.play_effect.emit(hurt_effect_ps, hurtbox.global_position)

func _on_die() -> void:
	is_dying = true
	Event.play_effect.emit(death_effect_ps, hurtbox.global_position)
	queue_free()

func _process(_delta):
	velocity = movement.velocity
	if velocity.x != 0:
		if velocity.x > 0:
			sprites.scale.x = -1
		else:
			sprites.scale.x = 1
	move_and_slide()

func set_anim(anim_name: StringName) -> void:
	state_anim.travel(anim_name)
