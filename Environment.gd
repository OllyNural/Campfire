extends Node2D

#onready var background = $AmbientLighting
onready var snow = $Snow

enum LIGHT_SCALES {
	LIGHT,
	MEDIUM,
	DARK,
	BLACK
}

enum SNOW_SCALES {
	LIGHT,
	MEDIUM,
	STRONG
}

export(LIGHT_SCALES) var light_scale = LIGHT_SCALES.BLACK
export(SNOW_SCALES) var snow_scale = SNOW_SCALES.LIGHT

export(bool) var direction_left = true

func _ready():
#	Background
#	background.light_scale = light_scale

#	Snow
	snow.snow_scale = snow_scale
	snow.direction_left = direction_left

func _process(_delta):
#	Background
#	background.light_scale = light_scale

#	Snow
	snow.snow_scale = snow_scale
	snow.direction_left = direction_left
