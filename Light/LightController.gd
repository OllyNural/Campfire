extends Node2D

onready var light2D = $Light2D
onready var collisionShape = $LightSourceRange/CollisionShape2D

func set_texture_scale(scale):
	light2D.set_texture_scale(scale)

func set_light_intensity(energy):
	light2D.set_light_intensity(energy)

func fade_in(time):
	yield(light2D.fade_in(time), "completed")
	collisionShape.disabled = false

func fade_out(time):
	yield(light2D.fade_out(time), "completed")
	collisionShape.disabled = true

func set_collision_range(col_range):
	collisionShape.scale = Vector2(col_range, col_range)

func set_flicker_amount(amount):
	light2D.set_flicker_amount(amount)
