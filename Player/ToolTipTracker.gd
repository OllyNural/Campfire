extends Node2D

signal show_tooltip

var objects = {
	'lantern': false,
	'lampost': false,
	'locked_door': false,
	'key': false,
	'end_game': false,
	'cabin_note': false,
}

func _ready():
	for i in get_tree().get_nodes_in_group('ToolTipTrigger'):
		i.connect('trigger_tooltip', self, '_on_tooltip_trigger')

func display_tooltip(type: String, duration: int):
	emit_signal('show_tooltip', type, duration)

func _on_tooltip_trigger(type, duration = 1):
	if (objects[type]):
		return

	display_tooltip(type, duration)
	objects[type] = true
	
