extends Node2D

onready var animationPlayer = $LightingAnimationPlayer
onready var lightController = $LightController

var isPlayerInRange: bool = false
var is_lampost_on: bool = false

func _ready():
	turn_on()

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
	lightController.play("FadeIn")

func turn_off():
	is_lampost_on = false
	animationPlayer.play("Off")
	lightController.play("FadeOut")

func _on_Area2D_area_entered(area):
	isPlayerInRange = true

func _on_Area2D_area_exited(area):
	isPlayerInRange = false
