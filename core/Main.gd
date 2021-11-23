extends ViewportContainer

export(String, FILE, "*.tscn") var default_map

func _ready():
	var map = load(default_map).instance()
	$MapView.add_child(map)
	
	var player = DataManager.characters[0].generate_pawn()
	Game.place_player(player, map)
	pass


func is_window_running() -> bool:
	return $Window.get_child_count() > 0

func fade():
	print("fade")

func end_fade():
	print("end_fade")
