extends Node

signal player_moved(player)

func _ready():
	pass # Replace with function body.

func connect_tx(signal_str: String, other):
	other.connect(signal_str, self, "_on_" + signal_str)

func _on_player_moved(other):
	emit_signal("player_moved", other)


