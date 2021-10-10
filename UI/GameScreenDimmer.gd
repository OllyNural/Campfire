extends CanvasModulate

onready var Tween = $Tween

enum FADE_TYPES {
	OPACITY,
}

export (FADE_TYPES) var fade_type = FADE_TYPES.OPACITY
var current_color_in = Color(0.8, 0.8, 0.8, 1)
var current_color_out = Color(0.8, 0.8, 0.8, 0)

var time_scale: float = 1.0

func _ready():
	self.color = current_color_in

func set_color(color: Color):
	self.color = color

func fade_out(time: float):
	Tween.interpolate_property(self, "color", current_color_in, current_color_out, time, 0, 1)
	Tween.start()
	yield(Tween, "tween_all_completed")

func fade_in(time: float):
	Tween.interpolate_property(self, "color", current_color_out, current_color_in, time, 0, 1)
	Tween.start()
	yield(Tween, "tween_all_completed")
