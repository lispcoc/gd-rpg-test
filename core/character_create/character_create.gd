extends Node

const test_data = {
	"ベース": "ベースA",
	"前髪": "01a_A",
	"服上": "シャツ01b_E",
	"服下": "スカート01a_A",
	"顔": "なし",
	"髪": "ポニテa_A",
	"髪+": "ポニテa_長01_A",
	"デフォルト": "なし"
}

const test_color = {
	"ベース": [0.0, 0, 0],
	"前髪": [0.0, 0, 0],
}

export(NodePath) var base_selector
export(NodePath) var face_selector
export(NodePath) var hair_selector
export(NodePath) var front_hair_selector
export(NodePath) var side_hair_selector
export(NodePath) var clothes_0_selector
export(NodePath) var clothes_1_selector
export(NodePath) var preview

export(NodePath) var container_node
export(NodePath) var first_focus

var _internal_time = 0
var _direction_cnt = 0
var pawn : CharacterPawn

var selectors = {}
var color_pickers = {}
var color_slider_s = {}
var s_sliders = {}

const color_level = 23


func get_selector(key : String) -> OptionButton:
	return selectors[key]
	var selectors = {
		"ベース": base_selector,
		"顔": face_selector,
		"髪": hair_selector,
		"前髪": front_hair_selector,
		"髪+": side_hair_selector,
		"服上": clothes_0_selector,
		"服下": clothes_1_selector,
	}
	if selectors.has(key):
		return get_node_or_null(selectors[key]) as OptionButton
	return null


func _ready():
	get_node(first_focus).grab_focus()

	test()
	pawn.load_custom_character(test_data, test_color)
	
	var container = get_node(container_node)
	# 各セレクタの初期化
	for key in ImageManager.character_parts.keys():
		container.columns = 6
		#パーツのセレクタを追加
		var label = Label.new()
		label.text = key
		container.add_child(label)
		var new_selector = OptionButton.new()
		selectors[key] = new_selector
		container.add_child(new_selector)
		new_selector.add_item("なし")
		for name in ImageManager.character_parts[key].keys():
			new_selector.add_item(name)
		for idx in range(new_selector.get_item_count()):
			if test_data.has(key) and new_selector.get_item_text(idx) == test_data[key]:
				new_selector.selected = idx

		#パーツの色設定を追加
		label = Label.new()
		label.text = "色相"
		var new_color_picker = SpinBoxEx.new()
		new_color_picker.max_value = color_level
		new_color_picker.rect_min_size.x = 100
		color_pickers[key] = new_color_picker
		container.add_child(label)
		container.add_child(new_color_picker)

		label = Label.new()
		label.text = "彩度"
		var new_color_slider_s = SpinBoxEx.new()
		new_color_slider_s.max_value = color_level
		new_color_slider_s.min_value = -color_level
		new_color_slider_s.rect_min_size.x = 100
		color_slider_s[key] = new_color_slider_s
		container.add_child(label)
		container.add_child(new_color_slider_s)

		# 変更時にシグナルを受け取る
		new_selector.connect("item_selected", self, "_on_item_selected")
		new_color_picker.connect("value_changed", self, "_on_item_selected")
		new_color_slider_s.connect("value_changed", self, "_on_item_selected")

	pass


func _process(delta):
	var update_frame_time = 0.5
	var directions = [Vector2.DOWN, Vector2.RIGHT, Vector2.UP, Vector2.LEFT]
	_internal_time += delta
	if update_frame_time < _internal_time:
		_internal_time = 0
		_direction_cnt += 1
		pawn.update_look_direction(directions[int(_direction_cnt / 4) % directions.size()])
		pawn.next_frame()


func test():
	var chara = Character.new()
	pawn = chara.generate_pawn()
	pawn.name = "pawn"
	get_node(preview).add_child(pawn)

func reload_sprite():
	var data = test_data
	var color = test_color
	for key in ImageManager.character_parts.keys():
		var selector = get_selector(key)
		if selector:
			data[key] = selector.get_item_text(selector.selected)
		var h = 0
		var s = 0
		var v = 0
		var h_slider = color_pickers[key]
		if h_slider:
			print(h_slider.value)
			h = (h_slider.value as float) / (color_level as float)
		var s_slider = color_slider_s[key]
		if s_slider:
			print(s_slider.value)
			s = (s_slider.value as float) / (color_level as float)
		color[key] = [h, s, v]
		print(color[key])
	print(JSON.print(data, "  "))
	print(JSON.print(color, "  "))
	pawn.load_custom_character(data, color)
	_internal_time = 0
	_direction_cnt = 0

#
# Signals
#
func on_change_value():
	reload_sprite()

func _on_item_selected(index):
	on_change_value()
	pass # Replace with function body.
