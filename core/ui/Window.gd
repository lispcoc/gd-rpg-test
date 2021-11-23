extends Control

export(NodePath) var first_focus : NodePath

func _ready():
	if first_focus:
		get_node(first_focus).grab_focus()
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()

