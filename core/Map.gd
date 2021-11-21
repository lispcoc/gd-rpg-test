class_name Map
extends TileMap

enum CellType { NONE, OBSTACLE, ACTOR, OBJECT }

export(Vector2) var start_pos = Vector2(0, 0)


func place(obj, pos : Vector2):
	add_child(obj)
	obj.position = map_to_world(pos) + cell_size / 2


func update_grid():
	for child in $Attribute.get_children():
		$Attribute.set_cellv(world_to_map(child.position), child.type)
	for child in $Objects.get_children():
		$Attribute.set_cellv(world_to_map(child.position), child.type)


func get_cell_pawn(cell, type = CellType.ACTOR):
	for node in $Objects.get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)


func request_move(pawn, direction : Vector2):
	update_grid()
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	var cell_tile_id = $Attribute.get_cellv(cell_target)
	match cell_tile_id:
		#何もない場合
		-1, CellType.NONE:
			# 通行できる
			$Attribute.set_cellv(cell_target, CellType.ACTOR)
			$Attribute.set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		#通行不可
		CellType.OBSTACLE:
			return null
		#オブジェクトと衝突
		CellType.ACTOR:
			var target_pawn : Pawn = get_cell_pawn(cell_target, cell_tile_id)
			target_pawn.on_touch(direction)
			return null

func request_examine(pawn, direction : Vector2):
	update_grid()
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	print("cell_start:%s cell_target:%s" % [cell_start, cell_target])
	var target_pawn : Pawn = get_cell_pawn(cell_target)
	if target_pawn:
		target_pawn.on_examine(direction)
	return null
	
