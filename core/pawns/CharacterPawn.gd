class_name CharacterPawn
extends Pawn

var look_direction : Vector2 = Vector2(1,0)


signal player_moved(player)


func _ready():
	if texture == "":
		texture = ImageManager.default_character_sprite()
	$CharacterSprite.load_texture(texture)
	update_look_direction(Vector2.RIGHT)
	connect("player_moved", Game, "_on_player_moved")


func activate_camera():
	$Camera2D.make_current()


func move(input_direction : Vector2):
	if target_position == null:
		if not input_direction:
			return
		update_look_direction(input_direction)
		target_position = map.request_move(self, input_direction)
		if target_position:
			current_position = position
			move_time = 0
			$CharacterSprite.next_frame()


func examine():
	map.request_examine(self, look_direction)


func update_look_direction(direction):
	look_direction = direction
	$CharacterSprite.set_dir(Direction.vector_to_const(direction))


func on_examine(dir : Vector2):
	update_look_direction(-dir)
	.on_examine(dir)

