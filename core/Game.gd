extends Node

const input_delay_time = 0.2


var player : Player = null
var is_dialog_running = false


func _ready():
	DataManager.init()
	pass


func _process(_delta):
	if is_dialog_running:
		return
	if is_window_running():
		return
	#
	# キー入力処理
	#

	# 方向入力
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if dir.length () > 0.5:
		dir = Direction.vector_to_coordinate(dir)
	else:
		dir = null

	if player:
		#ボタン入力
		if Input.is_action_just_pressed("ui_accept"):
			player.examine()
		# プレイヤーを移動させる
		elif dir:
			player.move(dir)


func get_current_save() -> int:
	return 0


func place_player(new_player : Player, map : Map, pos = null):
	if not pos:
		pos = map.start_pos
	map.place(new_player, pos)
	new_player.get_node("Camera2D").make_current()
	player = new_player


func get_main_node():
	return get_node_or_null("/root/Main")


func is_window_running() -> bool:
	var ret = false
	var main = get_main_node()
	if main:
		ret = main.is_window_running()
	return ret


func _on_player_moved(player):
	Time.increment_second()


func _on_timeline_start(timeline_name):
	print("_on_timeline_start")
	is_dialog_running = true


func _on_timeline_end(timeline_name):
	print("_on_timeline_end")
	yield(get_tree().create_timer(input_delay_time), "timeout")
	is_dialog_running = false

