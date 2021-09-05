extends CanvasModulate

enum LIGHT_SCALES {
	LIGHT,
	MEDIUM,
	DARK
}

var light_map = {
	LIGHT_SCALES.LIGHT: Color("#5f5f71"),
	LIGHT_SCALES.MEDIUM: Color("#3e3e4a"),
	LIGHT_SCALES.DARK: Color("#202026"),
}

const TIME_SCALE: float = 1.0

var time: float = 0

export (LIGHT_SCALES) var light_scale = LIGHT_SCALES.MEDIUM
var current_light_scale = light_map[LIGHT_SCALES.MEDIUM]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta: float):
	if (current_light_scale != light_map[light_scale]):
		self.time += delta
		self.color = current_light_scale.linear_interpolate(light_map[light_scale], time / TIME_SCALE)
		if (self.time > TIME_SCALE):
			current_light_scale = light_map[light_scale]
	else:
		self.time = 0
