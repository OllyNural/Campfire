extends Particles2D

enum SNOW_SCALES {
	LIGHT,
	MEDIUM,
	STRONG
}

var camera_position = Vector2(0, 0)

var snow_map = {
	SNOW_SCALES.LIGHT: {
#		"pos": Vector2(0, -200),
#		"pos": Vector2(160, -25),
		"angle": 0,
		"angular_velocity": 0,
		"speed_scale": 1,
		"amount": 1000,
	},
	SNOW_SCALES.MEDIUM: {
#		"pos": Vector2(0, -100),
		"angle": 0,
		"speed_scale": 2,
		"amount": 750,
	},
	SNOW_SCALES.STRONG: {
#		"pos": Vector2(0, -0),
		"angle": 0,
		"speed_scale": 4,
		"amount": 1000,
	},
}

const TIME_SCALE: float = 1.0

var time: float = 0

export (SNOW_SCALES) var snow_scale = SNOW_SCALES.LIGHT
var current_snow_scale = snow_map[snow_scale]

export(bool) var direction_left = true
var current_direction: bool = direction_left

func _ready():
	var dir_mult = 1 if direction_left else -1
	current_snow_scale = snow_map[snow_scale]
#	self.amount = current_snow_scale.amount
	self.speed_scale = current_snow_scale.speed_scale

	self.rotation_degrees = current_snow_scale.angle * dir_mult
	
	self.amount = amount

func _process(delta):
	var dir_mult = 1 if direction_left else -1

	if (
		current_snow_scale != snow_map[snow_scale] ||
		current_direction != direction_left
	):
		var new_snow_scale = snow_map[snow_scale]

		self.time += delta
		self.speed_scale = new_snow_scale.speed_scale

		self.rotation_degrees = new_snow_scale.angle * dir_mult

		if (self.time > TIME_SCALE):
			current_snow_scale = new_snow_scale
			current_direction = direction_left
#			self.amount = new_snow_scale.amount
	else:
		self.time = 0
