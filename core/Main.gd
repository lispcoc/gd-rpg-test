extends ViewportContainer

export(String, FILE, "*.tscn") var default_map

func start():
	var map = load(default_map).instance()
	$MapView.add_child(map)
	
	Game.place_player(DataManager.characters[0].generate_pawn(), map)
	pass


func is_window_running() -> bool:
	return $Window.get_child_count() > 0

func fade():
	print("fade")

func end_fade():
	print("end_fade")
