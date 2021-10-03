extends Area2D

signal in_any_light_range
signal out_any_light_range

# Listen to the signals from all light sources
var lightCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_listeners()
		
func connect_listeners():
	for i in get_tree().get_nodes_in_group("LightSources"):
		i.connect("in_light_range", self, "_on_light_in_light_range")
		i.connect("out_light_range", self, "_on_light_out_light_range")

func _on_light_in_light_range(area: Area2D, type: String, _position: Vector2):
	if (area.get_name() == 'FuelSourceDetector' && type != 'lantern'):
		lightCount += 1
		if (lightCount > 0):
			emit_signal("in_any_light_range")

func _on_light_out_light_range(area, type: String, _position: Vector2):
	if (area.get_name() == 'FuelSourceDetector' && type != 'lantern'):
		lightCount -= 1
		if (lightCount < 1):
			emit_signal("out_any_light_range")
