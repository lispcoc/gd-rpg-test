class_name Game
extends Node

export(NodePath) var image_manager
export(NodePath) var combat_screen
export(String, FILE, "*.tscn") var default_map
export(PackedScene) var character_tscn

const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

var player = null
var is_loaded = false
var is_init = false

func _ready():
	pass

func img() -> ImageManager:
	return get_node(image_manager) as ImageManager

func update_load_state():
	is_loaded = get_node(image_manager).is_loaded

func init():
	var map = load(default_map).instance()
	add_child(map)
	combat_screen = get_node(combat_screen)
	combat_screen.connect("combat_finished", self, "_on_combat_finished")
	remove_child(combat_screen)

	player = character_tscn.instance()
	player.connect("player_moved", self, "_on_player_moved")
	place_player(player, map)
	is_init = true

func _process(_delta):
	# ロードが終わるまで待つ
	while not is_loaded:
		update_load_state()
		yield()
	
	# ゲームの初期化処理
	if not is_init:
		init()
	
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

	#ボタン入力
	if Input.is_action_pressed("ui_accept"):
		player.examine()
	# プレイヤーを移動させる
	elif dir && player:
		player.move(dir)

func place_player(player, map : Map, pos = null):
	player.get_node("Camera2D").make_current()
	if not pos:
		pos = map.start_pos
	map.place(player, pos)

func start_combat(combat_actors):
	remove_child($Exploration)
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	add_child(combat_screen)
	combat_screen.show()
	combat_screen.initialize(combat_actors)
	$AnimationPlayer.play_backwards("fade")


func _on_player_moved(player):
	print("%s" % [player.position])


func _on_opponent_dialogue_finished(opponent):
	if opponent.lost:
		return
	var player = $Exploration/Grid/Player
	var combatants = [player.combat_actor, opponent.combat_actor]
	start_combat(combatants)


func _on_combat_finished(winner, _loser):
	remove_child(combat_screen)
	$AnimationPlayer.play_backwards("fade")
	#add_child(exploration_screen)
	var dialogue = load("res://dialogue/dialogue_player/DialoguePlayer.tscn").instance()
	if winner.name == "Player":
		dialogue.dialogue_file = PLAYER_WIN
	else:
		dialogue.dialogue_file = PLAYER_LOSE
	yield($AnimationPlayer, "animation_finished")
	var player = $Exploration/Grid/Player
	#exploration_screen.get_node("DialogueUI").show_dialogue(player, dialogue)
	combat_screen.clear_combat()
	yield(dialogue, "dialogue_finished")
	dialogue.queue_free()
