extends CanvasModulate

onready var Tween = $Tween

enum LIGHT_SCALES {
	OPAQUE,
	LIGHT,
	MEDIUM,
	DARK,
	BLACK,
}

var light_map = {
	LIGHT_SCALES.OPAQUE: Color(0, 0, 0, 0),
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
	current_light_scale = light_map[LIGHT_SCALES.OPAQUE]
	self.color = current_light_scale

func change_light(light, speed: float):
	current_light_scale = self.color
	Tween.interpolate_property(self, "color", light_map[light], current_light_scale, 5 / speed)
	Tween.start()
	yield(Tween, "tween_all_completed")
