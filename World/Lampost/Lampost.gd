extends Node2D

onready var animationPlayer = $LightingAnimationPlayer
onready var lightController = $LightController

var isPlayerInRange: bool = false
var is_lampost_on: bool = false

func _ready():
	turn_on()
	lightController.set_texture_scale(2)
	lightController.set_light_intensity(1)
	lightController.set_flicker_amount(2)
	lightController.set_collision_range(7)

func _process(_delta):
	if Input.is_action_just_pressed("ui_lampost_toggle") && isPlayerInRange:
		toggle_state()

func toggle_state():
	if (is_lampost_on):
		is_lampost_on = false
		turn_off()
	else:
		is_lampost_on = true
		turn_on()

func turn_on():
	is_lampost_on = true
	animationPlayer.play("On")
	lightController.fade_in(0.2)

func turn_off():
	is_lampost_on = false
	animationPlayer.play("Off")
	lightController.fade_out(0.2)

func _on_Area2D_area_entered(_area):
	isPlayerInRange = true

func _on_Area2D_area_exited(_area):
	isPlayerInRange = false
