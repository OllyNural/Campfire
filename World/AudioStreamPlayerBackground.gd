extends AudioStreamPlayer

const MAX_VALUE = 100000000;
var noise = OpenSimplexNoise.new()
var value = 0.0

var base_volume = -10
var base_energy = 0.9
var max_volume_ratio = 2

func _ready():
	self.volume_db = -10
	noise.seed = randi() % MAX_VALUE
	noise.period = 16

func _process(_delta):
	value += 0.5
	if (value > MAX_VALUE):
		value = 0.0
	var noise_value = noise.get_noise_1d(value)

	
	self.volume_db = base_volume + (noise_value * max_volume_ratio)
#	self.volume_db = -80

#	self.color = Color(color.r, color.g, color.b, alpha)
	
#	self.texture_scale = base_light_scale + (noise_value / 100)
