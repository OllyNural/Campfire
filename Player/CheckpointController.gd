extends Node2D

signal recent_lightsource_checkpoint

func _ready():
	connect_listeners()
		
func connect_listeners():
	for i in get_tree().get_nodes_in_group("LightSources"):
		i.connect("in_light_range", self, "_on_light_in_light_range")

func _on_light_in_light_range(area: Area2D, type: String, checkpoint_position: Vector2):
	if (area.get_name() == 'CheckpointArea2D' && type != 'lantern'):
		emit_signal("recent_lightsource_checkpoint", checkpoint_position)
