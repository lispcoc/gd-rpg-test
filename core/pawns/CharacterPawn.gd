class_name CharacterPawn
extends Pawn

signal player_moved(player)

var look_direction : Vector2 = Vector2(1,0)

var _custom_character_parts : Dictionary = {}
var _custom_character_color : Dictionary = {}

func _ready():
	load_custom_character(ImageManager.default_character_image_data(), {})
	update_look_direction(Vector2.RIGHT)
	connect("player_moved", Game, "_on_player_moved")


func clear_sprites():
	for c in get_children():
		if c is CharacterSprite:
			remove_child(c)


func set_custom_character (parts : Dictionary, color = {}):
	_custom_character_parts = parts
	_custom_character_color = color


func load_custom_character(parts : Dictionary, color = {}):
	set_custom_character(parts, color)
	clear_sprites()
	for part in parts.keys():
		var name = parts[part]
		var front = ImageManager.get_character_parts(part, name)
		var back = ImageManager.get_character_parts(part, name, "back")
		var hsv = [0, 0, 0]
		if color.has(part):
			hsv = color[part]
		print (part)
		print (hsv)
		if front:
			var sprite := CharacterSprite.new()
			sprite.load_texture(front)
			sprite.set_hsv(hsv[0], hsv[1], hsv[2])
			sprite.z_index = ImageManager.get_character_parts_z(part)
			add_child(sprite)
		if back:
			var sprite := CharacterSprite.new()
			sprite.load_texture(back)
			sprite.set_hsv(hsv[0], hsv[1], hsv[2])
			sprite.z_index = ImageManager.get_character_parts_z(part)
			add_child(sprite)


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
			next_frame()


func examine():
	map.request_examine(self, look_direction)


func next_frame():
	for c in get_children():
		if c is CharacterSprite:
			c.next_frame()


func update_look_direction(direction):
	look_direction = direction
	for c in get_children():
		if c is CharacterSprite:
			c.set_dir(Direction.vector_to_const(direction))


func on_examine(dir : Vector2):
	update_look_direction(-dir)
	.on_examine(dir)

