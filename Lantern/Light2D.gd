extends Light2D

onready var Tween = $Tween

const MAX_VALUE = 100000000;
var noise = OpenSimplexNoise.new()
var value = 0.0

var base_light_scale = 1
var base_energy = 0.9
var flicker_amount = 1

func _ready():
	self.scale = Vector2(1, 1)
	noise.seed = randi() % MAX_VALUE
	noise.period = 16

func set_texture_scale(scale: float):
	base_light_scale = scale / 5

func set_light_intensity(energy):
	base_energy = energy

func set_flicker_amount(amount):
	flicker_amount = amount

func set_shadows(is_shadow):
	shadow_enabled = is_shadow

func fade_in(time):
	Tween.interpolate_property(self, "energy", self.energy, base_energy, time, 0, Tween.EASE_IN)
	Tween.start()
	yield(Tween, "tween_all_completed")

func fade_out(time):
	Tween.interpolate_property(self, "energy", self.energy, 0, time, 0, Tween.EASE_OUT)
	Tween.start()
	yield(Tween, "tween_all_completed")

func _process(_delta):
	value += 0.5
	if (value > MAX_VALUE):
		value = 0.0
	var noise_value = noise.get_noise_1d(value)
	var alpha = ((noise_value + 1) / (4.0 * flicker_amount)) + 0.5

	self.color = Color(color.r, color.g, color.b, alpha)
	
	self.texture_scale = base_light_scale + (noise_value / 100)
