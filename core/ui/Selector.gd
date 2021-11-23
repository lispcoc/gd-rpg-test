class_name Selector
extends ItemList


export(Array, String) var selection
export(Array, NodePath) var node

func _init(_selection = ["None"]):
	selection = _selection

func _ready():
	#grab_focus()
	for n in selection:
		add_item(n)
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_parent_control():
			give_focus(get_parent_control())
		queue_free()


func give_focus(node : Control):
	node.grab_focus()

