extends Node
var rnd = RandomNumberGenerator.new()
#const save = preload("res://Save/save.tres")

# Monsters ---------------------------------------------------------------------
#const bat = preload("res://Character/MOB/MOBs/bat.tscn")
#const alien = preload("res://Character/MOB/MOBs/alien.tscn")

@onready var mobs = []

# Objects ----------------------------------------------------------------------
#const grass = preload("")
#const obstacle = preload("")

@onready var objects = []

# Special ----------------------------------------------------------------------
#const exit_door = preload("")

# Abilities ----------------------------------------------------------------------
const ability_ps: PackedScene = preload("res://Ability/ability.tscn")
#const ability_ui_ps = preload("")

#const attack_resource: Ability_Ressource = preload("res://Ability/Abilities/Attack/attack_resource.tres")
#const dash_resource: Ability_Ressource = preload("res://Ability/Abilities/Dash/dash_resource.tres")
#const hook_resource: Ability_Ressource = preload("res://Ability/Abilities/Hook/hook_resource.tres")
#const nova_resource: Ability_Ressource = preload("res://Ability/Abilities/Nova/nova_resoure.tres")
#const shuriken_resource: Ability_Ressource = preload("res://Ability/Abilities/Shuriken/shuriken_resource.tres")
#const throw_stick_resource: Ability_Ressource = preload("res://Ability/Abilities/Stick/stick_resource.tres")

@onready var abilities: Array[Ability_Resource] = []

#const attack_tree: PackedScene = preload("res://Ability/Abilities/Attack/attack_tree.tscn")
#const dash_tree: PackedScene = preload("res://Player/Ability_Trees/Dash/dash_tree.tscn")
#const hook_tree: PackedScene = preload("res://Player/Ability_Trees/Hook/hook_tree.tscn")
#const nova_tree: PackedScene = preload("res://Player/Ability_Trees/Nova/nova_tree.tscn")
#const shuriken_tree: PackedScene = preload("res://Player/Ability_Trees/Shuriken/shuriken_tree.tscn")
#const stick_tree: PackedScene = preload("res://Player/Ability_Trees/Stick/stick_tree.tscn")

@onready var trees: Array[PackedScene] = []

# Projectiles ------------------------------------------------------------------
#const stick: PackedScene = preload("res://Ability/Abilities/Stick/stick_projectile.tscn")
#const shuriken: PackedScene = preload("res://Ability/Abilities/Shuriken/shuriken_projectile.tscn")
#const hook: PackedScene = preload("res://Ability/Abilities/Hook/hook_projectile.tscn")
#const nova: PackedScene = preload("res://Ability/Abilities/Nova/nova_projectile.tscn")
#const dash: PackedScene = preload("res://Ability/Abilities/Dash/dash_projectile.tscn")
#const green_ball: PackedScene = preload("res://Ability/Abilities/GreenBall/green_ball_projectile.tscn")

# Boost ------------------------------------------------------------------------
#const boost_ps = preload("res://Boost/Boost.tscn")

#const Boost_Invincibility = preload("res://Boost/Boost_Resource/Invincibility.tres")
#const Boost_MoveSpeed = preload("res://Boost/Boost_Resource/MoveSpeed.tres")

# Randoms ----------------------------------------------------------------------
func get_random_object():
	rnd.randomize()
	return objects[rnd.randi_range(0, objects.size() - 1)]

func get_random_monster():
	rnd.randomize()
	return mobs[rnd.randi_range(0, mobs.size() - 1)]

func get_random_ability():
	rnd.randomize()
	return abilities[rnd.randi_range(0, abilities.size() - 1)]

func get_skill_tree(ability):
	if not (abilities.has(ability)): return null
	return trees[abilities.find(ability)]
