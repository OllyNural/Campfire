extends Node2D

onready var lightController = $LightController

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	lightController.set_light_type("lampost")
	lightController.set_texture_scale(1.75)
	lightController.set_light_intensity(1.2)
	lightController.set_flicker_amount(5)
	lightController.set_collision_range(15)
	lightController.fade_in(time)

#func _process(delta):
#	lightController.set_light_type("lampost")
#	lightController.set_texture_scale(1.5)
#	lightController.set_light_intensity(1)
#	lightController.set_flicker_amount(2)
#	lightController.set_collision_range(15)
#	lightController.fade_in(time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
