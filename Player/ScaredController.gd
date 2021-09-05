extends Node2D

onready var LightRangeDetector = $LightRangeDetector
onready var textureProgress = $CanvasLayer/TextureProgress

var is_light_range = false

enum {
	STATIC,
	DECREASE,
	PAUSE,
	INCREASE,
	STOPPED
}

var state = STATIC
var current_bar_value: float = 100

export var MAX_BAR_VALUE = 100
export var DECREASE_SPEED = 15
export var RECOVERY_SPEED = 50
export var PAUSE_TIME = 2

signal cold_timeout_game_over

func _ready():
	LightRangeDetector.connect("in_any_light_range", self, "_on_in_any_light_range")
	LightRangeDetector.connect("out_any_light_range", self, "_on_out_any_light_range")
	textureProgress.value = current_bar_value

func _process(delta):
	match state:
		STATIC:
			pass
		DECREASE:
			current_bar_value -= DECREASE_SPEED * delta
			current_bar_value = max(current_bar_value, 0)
			if (current_bar_value == 0):
				state = STOPPED
				emit_signal("cold_timeout_game_over")
			textureProgress.value = current_bar_value
		PAUSE:
			pass
		INCREASE:
			current_bar_value += RECOVERY_SPEED * delta
			current_bar_value = min(current_bar_value, MAX_BAR_VALUE)
			textureProgress.value = current_bar_value
		STOPPED:
			pass

func _on_in_any_light_range():
#	print('LightController :: IN')
	state = INCREASE
	is_light_range = true

func _on_out_any_light_range():
#	print('LightController :: OUT')
	state = DECREASE
	is_light_range = false
