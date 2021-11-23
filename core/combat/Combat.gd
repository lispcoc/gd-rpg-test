extends Node

signal combat_finished(winner, loser)


var players = [0, 0, 0, 0]
var enemies = [0]
var players_pawn = []
var enemies_pawn = []


func _ready():
	var num = 0
	for n in players:
		players_pawn.append(DataManager.get_character(n).generate_pawn())
	for n in enemies:
		enemies_pawn.append(DataManager.get_enemy(n).generate_pawn())
	
	num = 0
	for pawn in players_pawn:
		$PlayerPlaceHolder.get_children()[num].add_child(pawn)
		(pawn as CharacterPawn).update_look_direction(Vector2(-1, 0))
		num+=1

	num = 0
	for pawn in enemies_pawn:
		$EnemyPlaceHolder.get_children()[num].add_child(pawn)
		(pawn as CharacterPawn).update_look_direction(Vector2(-1, 0))
		num+=1

	$Camera2D.make_current()

func _process(delta):
	$Selector.grab_focus()
	var ret = yield($Selector, "item_activated")
	print(ret)

func initialize(combat_combatants):
	for combatant in combat_combatants:
		combatant = combatant.instance()
		if combatant is Combatant:
			$Combatants.add_combatant(combatant)
			combatant.get_node("Health").connect("dead", self, "_on_combatant_death", [combatant])
		else:
			combatant.queue_free()
	$UI.initialize()
	$TurnQueue.initialize()


func clear_combat():
	for n in $Combatants.get_children():
		n.queue_free()
	for n in $UI/Combatants.get_children():
		n.queue_free()


func finish_combat(winner, loser):
	emit_signal("combat_finished", winner, loser)


func _on_combatant_death(combatant):
	var winner
	if not combatant.name == "Player":
		winner = $Combatants/Player
	else:
		for n in $Combatants.get_children():
			if not n.name == "Player":
				winner = n
				break
	finish_combat(winner, combatant)
