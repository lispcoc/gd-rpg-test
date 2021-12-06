tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("InputEx", "Input", preload("InputEx.gd"), preload("icon.png"))


func _exit_tree():
	remove_custom_type("InputEx")
