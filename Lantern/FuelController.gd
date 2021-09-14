extends Node2D

onready var fuelSourceDetector = $FuelSourceDetector
onready var fuelBar = $FuelBar
onready var textureProgress = $FuelBar/TextureProgress

enum {
	STATIC,
	DECREASE,
	PAUSE,
	INCREASE,
	STOPPED
}

var is_on = false
var is_in_light_source = false
var can_move = true setget set_can_move

var state = STATIC
var current_bar_value: float = 100

export var MAX_BAR_VALUE = 100
export var DECREASE_SPEED = 5
export var RECOVERY_SPEED = 75
export var PAUSE_TIME = 2

signal lantern_fuel_empty
signal lantern_fuel_not_empty

func _ready():
	fuelSourceDetector.connect("in_any_light_range", self, "_on_in_any_light_range")
	fuelSourceDetector.connect("out_any_light_range", self, "_on_out_any_light_range")
	textureProgress.value = current_bar_value

func _process(delta):
	if (!can_move):
		fuelBar.get_child(0).hide()
		fuelBar.get_child(1).hide()
		fuelBar.get_child(2).hide()
	else:
		fuelBar.get_child(0).show()
		fuelBar.get_child(1).show()
		fuelBar.get_child(2).show()

	match state:
		DECREASE:
			if (is_in_light_source): state = INCREASE
			current_bar_value -= DECREASE_SPEED * delta
			current_bar_value = max(current_bar_value, 0)
			if (current_bar_value == 0):
				state = STOPPED
				emit_signal("lantern_fuel_empty")
			textureProgress.value = current_bar_value
		PAUSE:
			if (is_in_light_source): state = INCREASE
		INCREASE:
			current_bar_value += RECOVERY_SPEED * delta
			current_bar_value = min(current_bar_value, MAX_BAR_VALUE)
			textureProgress.value = current_bar_value
		STOPPED:
			pass

func set_lantern_on():
	is_on = true
	state = DECREASE

func set_lantern_off():
	is_on = false
	state = PAUSE

func _on_in_any_light_range():
	is_in_light_source = true
	state = INCREASE
	emit_signal("lantern_fuel_not_empty")

func _on_out_any_light_range():
	is_in_light_source = false
	if (is_on):
		state = DECREASE

func set_can_move(move: bool):
	can_move = move
	state = PAUSE
