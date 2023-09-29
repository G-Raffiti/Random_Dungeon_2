extends AudioStreamPlayer2D
var rnd = RandomNumberGenerator.new()

func _ready():
	if is_autoplay_enabled():
		randomize_pitch()

func randomize_pitch():
	rnd.randomize()
	set_pitch_scale(rnd.randf_range(0.8, 1.5))
