extends Control

@export var background: TextureRect
@export var play_btn: Button
@export var option_btn: Button
@export var save_and_quit_btn: Button

@onready var start_pos: Vector2 = background.position + get_viewport_rect().size / 2
@onready var min_pos: Vector2 = Vector2.ZERO
@onready var max_pos: Vector2 = get_viewport_rect().size - background.size

func _process(delta):
	var dest = start_pos - get_local_mouse_position()
	var pos: Vector2 = Vector2(clamp(dest.x, max_pos.x, min_pos.x), clamp(dest.y, max_pos.y, min_pos.y))
	background.position = lerp(background.position, pos, delta)

func _ready():
	play_btn.pressed.connect(_on_play_pressed)
	option_btn.pressed.connect(_on_option_pressed)
	save_and_quit_btn.pressed.connect(_on_save_pressed)

func _on_play_pressed():
	Event.start_new_game.emit()

func _on_option_pressed():
	Event.ui_show_option_menu.emit()

func _on_save_pressed():
	Event.save_game.emit()
	Event.quit_game.emit()
