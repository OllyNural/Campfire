extends CanvasModulate

onready var Tween = $Tween

var faded_in = Color(0.8, 0.8, 0.8, 1)
var faded_out = Color(0.8, 0.8, 0.8, 0)

func _ready():
	self.color = faded_out

func fade_out(duration: int):
	Tween.interpolate_property(self, "color", faded_in, faded_out, duration, 0, 1)
	Tween.start()
	yield(Tween, "tween_all_completed")

func fade_in(duration: int):
	Tween.interpolate_property(self, "color", faded_out, faded_in, duration, 0, 1)
	Tween.start()
	yield(Tween, "tween_all_completed")
