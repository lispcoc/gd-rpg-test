extends NinePatchRect
class_name MultiPageSelector


# signals
signal item_activated(index)
#signal item_rmb_selected(index, at_position)
#signal item_selected(index)
#signal multi_selected(index, selected )
#signal nothing_selected()
#signal rmb_clicked(at_position)

export(Array, String) var selection
export(int) var columns : int = 1

var _btn = []
var _current_btn = []
var _meta = []
var page = 0
var lines = 3
var container : GridContainer

func _init(_selection = ["None"], _child : NodePath = ""):
	selection = _selection


func _ready():
	container = GridContainer.new()
	add_child(container)
	container.rect_position = Vector2(patch_margin_left, patch_margin_top)
	container.columns = columns
	for n in selection:
		add_item(n)
	grab_focus()


func _process(delta):
	rect_size = container.rect_size
	rect_size += Vector2(patch_margin_left + patch_margin_right, patch_margin_top + patch_margin_bottom)
	pass


func grab_focus():
	_current_btn[0].grab_focus()


func has_focus():
	for n in _current_btn:
		if n.has_focus():
			return true
	return false

func _input(event):
	#if not has_focus():
	#	return
	if InputMap.has_action("ui_left") and event.is_action_pressed("ui_left"):
		set_page(page - 1)
		grab_focus()
		get_tree().set_input_as_handled()
	if InputMap.has_action("ui_right") and event.is_action_pressed("ui_right"):
		set_page(page + 1)
		grab_focus()
		get_tree().set_input_as_handled()

#
# ItemList Compatibility
#
func add_item(text, meta = null):
	var btn = Button.new()
	btn.text = text
	btn.flat = true
	btn.connect("pressed", self, "_on_pressed")
	_btn.push_back(btn)
	_meta.push_back(meta)
	update_item()

func get_item_metadata(idx : int):
	if _meta.size() > idx:
		return _meta[idx]
	return null

func max_page() -> int:
	return int(ceil(_btn.size() / lines))


func set_page(new_page):
	page = new_page
	if page < 0:
		page = 0
	if page > int(_btn.size() / lines):
		page = int(_btn.size() / lines)
	update_item()

func update_item():
	for n in container.get_children():
		container.remove_child(n)
	_current_btn.clear()

	var label = Label.new()
	label.text = "{} / {}".format([page + 1, max_page() + 1], "{}")
	container.add_child(label)

	var i = 0
	for n in _btn:
		if (i >= page * lines) && (i < (page + 1) * lines):
			container.add_child(n)
			_current_btn.push_back(n)
		i += 1


func _on_pressed():
	var i = 0
	for n in _btn:
		if n.has_focus():
			emit_signal("item_activated", i)
			print(i)
			return
		i += 1
	emit_signal("item_activated", -1)
