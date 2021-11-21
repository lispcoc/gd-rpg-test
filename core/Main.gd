extends ViewportContainer

export(PackedScene) var character_tscn
export(String, FILE, "*.tscn") var default_map

func _ready():
	var map = load(default_map).instance()
	$MapView.add_child(map)
	var player = character_tscn.instance()
	Game.place_player(player, map)
	pass
