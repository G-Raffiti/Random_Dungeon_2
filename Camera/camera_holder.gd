extends StaticBody2D

@export var player: Node2D
@export var speed: float
var follow: bool = false

func _ready():
    if player != null:
        player.tree_exiting.connect(_on_player_tree_exiting)
        follow = true

func _on_player_tree_exiting():
    follow = false

func _physics_process(delta):
    if not follow: return
    var destination = (get_global_mouse_position() - player.global_position) / 10 + player.global_position
    var distance = (destination - global_position).length()
    global_position = global_position.move_toward(destination, delta * distance * distance * speed)

func _exit_tree():
    if player != null:
        player.tree_exiting.disconnect(_on_player_tree_exiting)
