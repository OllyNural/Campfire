extends CanvasModulate

onready var Tween = $Tween

enum FADE_TYPES {
	OPACITY,
}

export (FADE_TYPES) var fade_type = FADE_TYPES.OPACITY
var current_color = Color(1, 1, 1, 1)

var time_scale: float = 1.0

#func _ready():
#	self.color = current_light_scale

func fade_out(time: float):
	Tween.interpolate_property(self, "color", Color(1, 1, 1, 1), Color(1, 1, 1, 0), time, 0, 1)
	Tween.start()
	yield(Tween, "tween_all_completed")
