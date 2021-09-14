extends Node2D

onready var animationPlayer = $LightingAnimationPlayer
onready var lightController = $LightController

var isPlayerInRange: bool = false
var is_lampost_on: bool = false

export var turn_on = true

func _ready():
	lightController.set_light_type("lampost")
	if (turn_on):
		turn_on()
	else:
		turn_off()
	lightController.set_texture_scale(1.5)
	lightController.set_light_intensity(1)
	lightController.set_flicker_amount(2)
	lightController.set_collision_range(7)

func _process(_delta):
	if Input.is_action_just_pressed("ui_lampost_toggle") && isPlayerInRange:
		toggle_state()

func toggle_state(time: float = 0.2):
	if (is_lampost_on):
		is_lampost_on = false
		turn_off(time)
	else:
		is_lampost_on = true
		turn_on(time)

func turn_on(time: float = 0.2):
	is_lampost_on = true
	animationPlayer.play("On")
	lightController.fade_in(time)

func turn_off(time: float = 0.2):
	is_lampost_on = false
	animationPlayer.play("Off")
	lightController.fade_out(time)

func _on_Area2D_area_entered(_area):
	isPlayerInRange = true

func _on_Area2D_area_exited(_area):
	isPlayerInRange = false
