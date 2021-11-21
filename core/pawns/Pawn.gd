class_name Pawn
extends Node2D

#warning-ignore:unused_class_variable
export(Enum.CellType) var type = Enum.CellType.ACTOR

var active = true setget set_active

func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)

func on_touch(dir : Vector2):
	var event = get_node_or_null("OnTouchEvent")
	if event:
		event.main(self, dir)

func on_examine(dir : Vector2):
	var event = get_node_or_null("OnExamineEvent")
	if event:
		event.main(self, dir)
