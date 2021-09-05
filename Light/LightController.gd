extends Node2D

onready var brightnessPlayer = $BrightnessPlayer
onready var light2D = $Light2D
onready var collisionShape = $LightSourceRange/CollisionShape2D

export var LIGHT_SCALE = 5
export var LIGHT_INTENSITY = 0.8

func _ready():
	light2D.set_texture_scale(LIGHT_SCALE / 5)
	light2D.set_light_intensity(LIGHT_INTENSITY)
	collisionShape.scale = Vector2(LIGHT_SCALE, LIGHT_SCALE)

func play(animation):
	brightnessPlayer.play(animation)
