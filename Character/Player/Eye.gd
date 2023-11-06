extends Node2D
class_name Eye

@onready var limit_down_left: Marker2D = $limit_down_left
@onready var limit_up_right: Marker2D = $limit_up_right
@onready var black: Sprite2D = $Sprite2D
@export var anim_part: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# var mouse = get_global_mouse_position()
	# var direction = mouse - black.position
	# direction = direction.normalized()


	var new_position = black.global_position
	
	if (anim_part.scale.x < 0):
		scale.x = -1
	else:
		scale.x = 1
	new_position.x = clamp(get_global_mouse_position().x, limit_up_right.global_position.x, limit_down_left.global_position.x)
	new_position.y = clamp(get_global_mouse_position().y, limit_up_right.global_position.y, limit_down_left.global_position.y)
	
	black.global_position += (new_position - black.global_position) * delta * 3
