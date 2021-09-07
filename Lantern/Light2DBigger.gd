extends Light2D

const MAX_VALUE = 100000000;
var noise = OpenSimplexNoise.new()
var value = 0.0

var light_scale = 1

func _ready():
	noise.seed = randi() % MAX_VALUE
	noise.period = 16

func set_texture_scale(scale):
#	light_scale = scale
	self.texture_scale = scale
	
func set_light_intensity(intensity):
	self.energy = intensity

func _process(_elta):
	value += 0.5
	if (value > MAX_VALUE):
		value = 0.0
	var noise_value = noise.get_noise_1d(value)
	var alpha = ((noise_value + 1) / 4.0) + 0.5

	self.color = Color(color.r, color.g, color.b, alpha)

	self.texture_scale = light_scale + (noise_value / 12)
