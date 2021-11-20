class_name Game
extends Node

export(NodePath) var combat_screen
export(NodePath) var exploration_screen
export(Resource) var character_class

const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

var player : Player = null

func _ready():
	exploration_screen = get_node(exploration_screen)
	combat_screen = get_node(combat_screen)
	combat_screen.connect("combat_finished", self, "_on_combat_finished")
	for n in $Exploration/Grid.get_children():
		if not n.type == n.CellType.ACTOR:
			continue
		if not n.has_node("DialoguePlayer"):
			continue
		n.get_node("DialoguePlayer").connect("dialogue_finished", self,
			"_on_opponent_dialogue_finished", [n])
	remove_child(combat_screen)

	player = character_class.instance()
	player.connect("player_moved", self, "_on_player_moved")
	place_player(player, exploration_screen, Vector2( 416, 288 ))

func _process(_delta):
	# キー入力処理
	
	# 方向入力
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if dir.length () > 0.5:
		dir = Direction.vector_to_coordinate(dir)
	else:
		dir = null

	# プレイヤーを移動させる
	if dir && player:
		player.move(dir)

func place_player(player, map, pos : Vector2):
	player.get_node("Camera2D").make_current()
	var grid = map.get_node("Grid")
	grid.place(player, Vector2(16, 10))

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
	add_child(exploration_screen)
	var dialogue = load("res://dialogue/dialogue_player/DialoguePlayer.tscn").instance()
	if winner.name == "Player":
		dialogue.dialogue_file = PLAYER_WIN
	else:
		dialogue.dialogue_file = PLAYER_LOSE
	yield($AnimationPlayer, "animation_finished")
	var player = $Exploration/Grid/Player
	exploration_screen.get_node("DialogueUI").show_dialogue(player, dialogue)
	combat_screen.clear_combat()
	yield(dialogue, "dialogue_finished")
	dialogue.queue_free()
