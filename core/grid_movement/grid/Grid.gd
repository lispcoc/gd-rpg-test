extends TileMap

enum CellType { ACTOR, OBSTACLE, OBJECT }
export(NodePath) var dialogue_ui

func _ready():
	update_grid()

func update_grid():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)

func get_cell_pawn(cell, type = CellType.ACTOR):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)

func place(obj, pos : Vector2):
	add_child(obj)
	obj.position = map_to_world(pos) + cell_size / 2

func request_move(pawn, direction):
	update_grid()
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	print("cell_start:%s cell_target:%s" % [cell_start, cell_target])

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		#何もない場合
		-1:
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		#通行不可オブジェクトがある場合
		CellType.OBJECT, CellType.ACTOR:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print("Cell %s contains %s" % [cell_target, target_pawn.name])

			if not target_pawn.has_node("DialoguePlayer"):
				return
			get_node(dialogue_ui).show_dialogue(pawn, target_pawn.get_node("DialoguePlayer"))
