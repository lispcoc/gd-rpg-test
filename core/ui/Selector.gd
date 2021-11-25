class_name Selector
extends ItemList


export(Array, String) var selection
export(NodePath) var child

var child_node : ItemList

signal item_nested(array)

func _init(_selection = ["None"], _child : NodePath = ""):
	selection = _selection
	child = _child

func _ready():
	#grab_focus()
	for n in selection:
		add_item(n)

	var ret 
	var ret_array = []
	child_node = get_node_or_null(child)
	if child_node:
		add_child(child_node)
		while ret_array == []:
			ret = yield(self, "item_activated")
			child_node.grab_focus()
			ret_array = yield(child_node, "item_nested")
	else:
		ret = yield(self, "item_activated")
	ret_array.append(ret)
	print(ret_array)
	emit_signal("item_nested", ret_array)
	queue_free()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_parent_control():
			give_focus(get_parent_control())
		queue_free()


func give_focus(node : Control):
	node.grab_focus()

