extends CanvasModulate

enum LIGHT_SCALES {
	LIGHT,
	MEDIUM,
	DARK,
	BLACK,
}

var light_map = {
	LIGHT_SCALES.LIGHT: Color("#5f5f71"),
	LIGHT_SCALES.MEDIUM: Color("#3e3e4a"),
	LIGHT_SCALES.DARK: Color("#202026"),
	LIGHT_SCALES.BLACK: Color("#000000")
}

const TIME_SCALE: float = 1.0

var time: float = 0

export (LIGHT_SCALES) var light_scale = LIGHT_SCALES.BLACK
var current_light_scale

func _ready():
	current_light_scale = light_map[LIGHT_SCALES.BLACK]
	self.color = current_light_scale
