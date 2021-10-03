extends AnimatedSprite

onready var lightController = $LightController

onready var crackleAudio = $CrackleAudio

func _ready():
	lightController.set_light_type("fire")
	lightController.set_texture_scale(1.5)
	lightController.set_light_intensity(1)
	lightController.set_flicker_amount(2)
	lightController.set_collision_range(14)
	lightController.fade_in(0.1)

func _process(delta):
	if (crackleAudio.playing == false):
		crackleAudio.play()
