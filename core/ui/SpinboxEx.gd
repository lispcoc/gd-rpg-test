extends Button
class_name SpinBoxEx

signal value_changed(value)

var delay = 0.2
var _delay_count = 0

export(int) var value = 0
export(int) var max_value = 100
export(int) var min_value = 0
export(int) var step = 1


func _input(event):
	if not has_focus():
		return
	if InputMap.has_action("ui_up") and event.is_action_pressed("ui_up"):
		value += step
		emit_signal("value_changed", value)
		get_tree().set_input_as_handled()
	if InputMap.has_action("ui_down") and event.is_action_pressed("ui_down"):
		value -= step
		emit_signal("value_changed", value)
		get_tree().set_input_as_handled()
	if min_value > value:
		value = min_value
	if max_value < value:
		value = max_value

func _process(delta):
	text = String(value)
	if not has_focus():
		return
	if _delay_count > 0:
		_delay_count -= delta
		return
