extends Node

onready var PlayerContainer = get_parent();

const Credits = preload("res://UI/Credits.tscn")

func _ready():
	for i in get_tree().get_nodes_in_group('CutsceneTrigger'):
		i.connect('cutscene_trigger', self, '_on_cutscene_trigger')

func _on_cutscene_trigger():
	PlayerContainer.set_can_move(false);
	PlayerContainer.set_move_right(1)
	yield(get_tree().create_timer(4.30), "timeout")
	PlayerContainer.set_action_ui_drop(true)
	PlayerContainer.toggle_lantern()
	yield(get_tree().create_timer(3.72), "timeout")
	PlayerContainer.set_move_right(0)
	yield(get_tree().create_timer(5), "timeout")
	PlayerContainer.set_state_sitting()
	PlayerContainer.set_sitting()
	yield(get_tree().create_timer(20), "timeout")
	var credits = Credits.instance()
	add_child(credits)
