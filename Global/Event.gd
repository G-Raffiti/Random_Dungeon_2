extends Node

# Player
signal player_take_hit()
signal player_level_up()
signal player_gain_xp()
signal player_die()
signal player_ability_changed(ablility_resource: Ability_Resource, input: String)
signal player_gained_ability_point()

# Effects
signal play_effect(effect_ps: PackedScene, pos: Vector2)

# MOBs
signal mob_died(mob: Mob)
