extends CanvasLayer

onready var tooltip = $VBoxContainer/Tooltip

var lampost_text = "Press M to toggle the Lampost light"
var lantern_text_array = ["Press J and K to pick up and drop the lantern", "Press L to toggle the lantern light"]
var locked_door_text = "The door is locked"
var picked_up_key_text = "You picked up a key"

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
