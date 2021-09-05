extends Light2D

const MAX_VALUE = 100000000;
var noise = OpenSimplexNoise.new()
var value = 0.0

func _ready():
	noise.seed = randi() % MAX_VALUE
	noise.period = 16

func _process(_delta):
	value += 0.5
	if (value > MAX_VALUE):
		value = 0.0
	var noise_value = noise.get_noise_1d(value)
	var alpha = ((noise_value + 1) / 4.0) + 0.5

	self.color = Color(color.r, color.g, color.b, alpha)
	
	self.texture_scale = 1 + (noise_value / 12)
