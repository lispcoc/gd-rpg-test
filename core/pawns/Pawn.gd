class_name Pawn
extends Node2D

#warning-ignore:unused_class_variable
export(Enum.CellType) var type = Enum.CellType.ACTOR

var active = true setget set_active

var move_time = 0.0
var tile_per_sec = 5.0
var target_position = null
var current_position = null

var map = null


export(String) var examine_event = ""
signal timeline_start(player)


func _init(_map = null):
	._init()
	set_map(_map)


func set_map(_map):
	map = _map


func _process(_delta):
	if target_position:
		move_time += _delta
		position = (target_position - current_position) * (move_time * tile_per_sec) + current_position
		#move_to(target_position)
		#$Tween.start()
		if (move_time * tile_per_sec) >= 1.0:
			position = target_position
			target_position = null
			emit_signal("player_moved", self)


func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)


func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")
	var move_direction = (position - target_position).normalized()
	$Tween.interpolate_property($Pivot, "position", move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Pivot/Sprite.position = position - target_position
	position = target_position

	yield($AnimationPlayer, "animation_finished")

	set_process(true)


func on_touch(dir : Vector2):
	var event = get_node_or_null("OnTouchEvent")
	if event:
		event.main(self, dir)


func on_examine(dir : Vector2):
	print("on_examine " , self)
	var event = get_node_or_null("OnExamineEvent")
	if event:
		event.main(self, dir)
	if examine_event != "":
		var new_dialog = Dialogic.start(examine_event)
		add_child(new_dialog)
		connect("timeline_start", Game, "_on_timeline_start")
		emit_signal("timeline_start", examine_event)
		new_dialog.connect("timeline_end", Game, "_on_timeline_end")


func bump():
	$AnimationPlayer.play("bump")

