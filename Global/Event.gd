extends Node

# Game
signal start_new_game()
signal game_started()
signal quit_game()
signal save_game()
signal load_game()

# Player
signal player_take_hit()
signal player_level_up()
signal player_gain_xp()
signal player_die()
signal player_ability_changed(ablility_resource: Ability_Resource, input: String)
signal player_gained_ability_point()
signal player_ready(player: Player)
signal player_teleport(pos: Vector2)

# Effects
signal play_effect(effect_ps: PackedScene, pos: Vector2)

# MOBs
signal spawn_mob(mob_ps: PackedScene, pos: Vector2)
signal mob_died(mob: Mob)

# Map
signal map_changed(map: LevelGenerator.Map)

# UI
signal ui_show_main_menu()
signal ui_show_pause_menu()
signal ui_show_hud()
signal ui_show_option_menu()