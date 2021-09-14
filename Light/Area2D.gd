extends Area2D

signal in_light_range
signal out_light_range

var light_type = 'default'

func set_light_type(type):
	light_type = type

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func _on_LightSourceRange_area_entered(area):
	emit_signal("in_light_range", area, light_type)

func _on_LightSourceRange_area_exited(area):
	emit_signal("out_light_range", area, light_type)
