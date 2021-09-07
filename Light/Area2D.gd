extends Area2D

signal in_light_range
signal out_light_range

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func _on_LightSourceRange_area_entered(_area):
	emit_signal("in_light_range")

func _on_LightSourceRange_area_exited(_area):
	emit_signal("out_light_range")
