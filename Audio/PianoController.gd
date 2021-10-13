extends Node2D

var is_background_piano = false

onready var piano_clip_1 = $PianoClip1
onready var piano_clip_2 = $PianoClip2
onready var piano_clip_3 = $PianoClip3
onready var piano_clip_4 = $PianoClip4
onready var piano_clip_5 = $PianoClip5
onready var piano_clip_6 = $PianoClip6
onready var piano_clip_7 = $PianoClip7
onready var piano_clip_8 = $PianoClip8
onready var piano_clip_9 = $PianoClip9
onready var piano_clip_10 = $PianoClip10
onready var piano_clip_11 = $PianoClip11
onready var piano_clip_12 = $PianoClip12
onready var piano_clip_13 = $PianoClip13
onready var piano_clip_14 = $PianoClip14

var current_playing

var played_background_piano
var unplayed_background_piano

func _ready():
	unplayed_background_piano = [
		piano_clip_1,
	]

	played_background_piano = [
		piano_clip_2,
		piano_clip_3,
		piano_clip_4,
		piano_clip_5,
		piano_clip_6,
		piano_clip_7,
		piano_clip_8,
		piano_clip_9,
		piano_clip_10,
		piano_clip_11,
		piano_clip_12,
		piano_clip_13,
		piano_clip_14,
	]

func _process(delta):
	if (is_background_piano):
		if (!current_playing || current_playing.playing == false):
			pass
			play_piano()

func play_background_piano(is_play: bool):
	is_background_piano = is_play

func play_piano():
	if (unplayed_background_piano.size() == 0):
		unplayed_background_piano = [] + played_background_piano
		played_background_piano = []
	
	var new_clip = unplayed_background_piano[rand_range(0, unplayed_background_piano.size() - 1)]
	unplayed_background_piano.erase(new_clip)
	played_background_piano.append(new_clip)
	
	current_playing = new_clip
	new_clip.play()





