extends Sprite

onready var door_front = $CollisionsArea2D/DoorFront
onready var door_back = $CollisionsArea2D/DoorBack
onready var tooltip_trigger = $TooltipArea2D/CollisionShape2D

signal trigger_tooltip

func _ready():
	for i in get_tree().get_nodes_in_group("Player"):
		i.connect("key_picked_up", self, "_on_key_picked_up")
	door_front.set_deferred("disabled", false)
	door_back.set_deferred("disabled", false)
	tooltip_trigger.set_deferred("disabled", false)

func _on_key_picked_up():
	print('key picked up')
	door_front.set_deferred("disabled", true)
	door_back.set_deferred("disabled", true)
	tooltip_trigger.set_deferred("disabled", true)

func _on_TooltipArea2D_area_entered(_area):
	emit_signal('trigger_tooltip', 'locked_door')
