extends Node


var delay = 0.12
var _delay_count = 0
var _prev_dir : Vector2 = Vector2(0, 0)

func _ready():
	pass

func _process(delta):
	var up = InputEventAction.new()
	up.action = "ui_up"
	up.pressed = false
	var down = InputEventAction.new()
	down.action = "ui_down"
	down.pressed = false
	var left = InputEventAction.new()
	left.action = "ui_left"
	left.pressed = false
	var right = InputEventAction.new()
	right.action = "ui_right"
	right.pressed = false

	var dir = Vector2(
		Input.get_action_strength("ui_right_stick") - Input.get_action_strength("ui_left_stick"),
		Input.get_action_strength("ui_down_stick") - Input.get_action_strength("ui_up_stick")
	)

	if dir.length () > 0.5:
		dir = Direction.vector_to_coordinate(dir)

		match dir:
			Direction.N:
				up.pressed = true
			Direction.NW:
				up.pressed = true
				left.pressed = true
			Direction.NE:
				up.pressed = true
				right.pressed = true
			Direction.S:
				down.pressed = true
			Direction.SW:
				down.pressed = true
				left.pressed = true
			Direction.SE:
				down.pressed = true
				right.pressed = true
			Direction.W:
				left.pressed = true
			Direction.E:
				right.pressed = true
	else:
		dir = Vector2(0,0)
	
	if _prev_dir == dir:
		if dir == Vector2(0,0):
			return
		print(_delay_count)
		if _delay_count > 0:
			_delay_count -= delta
			return

	_delay_count = delay
	_prev_dir = dir

	Input.parse_input_event(up)
	Input.parse_input_event(down)
	Input.parse_input_event(left)
	Input.parse_input_event(right)
	pass


static func get_direction_v2():
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if dir.length () > 0.5:
		dir = Direction.vector_to_coordinate(dir)
	else:
		dir = null
	return dir
