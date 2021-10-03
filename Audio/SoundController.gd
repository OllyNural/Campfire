extends Node2D

onready var audioStreamPlayer = $AudioStreamPlayerBackground
onready var pianoController = $PianoController

func _process(delta):
	if (audioStreamPlayer.playing == false):
		audioStreamPlayer.play()

func set_piano(type: String, is_play: bool):
	match type:
		'background':
			pianoController.play_background_piano(is_play)
		'ending':
			pass
