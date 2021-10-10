extends CanvasLayer

onready var tooltip = $VBoxContainer/Tooltip

var lampost_text = "Press M to toggle the Lampost light"
var lantern_text_array = ["Press J to pick up the lantern", "Press L to toggle the lantern light"]
var locked_door_text = "The door is locked"
var picked_up_key_text = "You picked up a key"
var end_game_text = [
	{ 'text': "Hello?", 'font_color': 'ffffff' },
	{ 'text': "You're back! Thank goodness", 'font_color': 'dddddd' },
	{ 'text': "I was getting worried...", 'font_color': 'dddddd' },
	{ 'text': "Are you okay?", 'font_color': 'dddddd' },
	{ 'text': "I think I am now", 'font_color': 'ffffff' },
	{ 'text': "Got any cocoa left?", 'font_color': 'ffffff' },
]

onready var canvasModulate = $CanvasModulate

var fade_duration = 2

func _ready():
	get_tree().get_root().get_node("World/YSort/PlayerContainer/Player/ToolTipTracker").connect('show_tooltip', self, 'show_tooltip')

func show_tooltip(type, duration):
	yield(canvasModulate.fade_out(0.2), "completed")
	match type:
		'lampost':
			tooltip.text = lampost_text
			yield(canvasModulate.fade_in(fade_duration), "completed")
			yield(get_tree().create_timer(duration), "timeout")
			yield(canvasModulate.fade_out(fade_duration), "completed")
		'lantern':
			for i in lantern_text_array:
				tooltip.text = i
				yield(canvasModulate.fade_in(fade_duration), "completed")
				yield(get_tree().create_timer(duration), "timeout")
				yield(canvasModulate.fade_out(fade_duration), "completed")
		"locked_door":
			tooltip.text = locked_door_text
			yield(canvasModulate.fade_in(fade_duration), "completed")
			yield(get_tree().create_timer(duration), "timeout")
			yield(canvasModulate.fade_out(fade_duration), "completed")
		"key":
			tooltip.text = picked_up_key_text
			yield(canvasModulate.fade_in(fade_duration), "completed")
			yield(get_tree().create_timer(duration), "timeout")
			yield(canvasModulate.fade_out(fade_duration), "completed")
		"end_game":
			for i in end_game_text:
				tooltip.text = i.text
				tooltip["custom_colors/font_color"] = i.font_color
				yield(canvasModulate.fade_in(fade_duration), "completed")
				yield(get_tree().create_timer(duration), "timeout")
				yield(canvasModulate.fade_out(fade_duration), "completed")
				
