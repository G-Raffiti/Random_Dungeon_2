class_name RandomTimer
extends Timer

var rnd = RandomNumberGenerator.new()
@export var time_minimum: float = 0.2
@export var time_maximum: float = 1.0

func start_random(time_min: float = time_minimum, time_max: float = time_maximum):
	if !is_inside_tree() : return
	self.start(rnd.randf_range(time_min, time_max))
