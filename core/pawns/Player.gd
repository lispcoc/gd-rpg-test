class_name Player
extends Pawn

#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
var lost = false
var look_direction : Vector2 = Vector2(1,0)

signal player_moved(player)


func _ready():
	$Control/CharacterSprite.load(ImageManager.default_character_sprite())
	update_look_direction(Vector2.RIGHT)
	connect("player_moved", Game, "_on_player_moved")


func move(input_direction : Vector2):
	if target_position == null:
		if not input_direction:
			return
		update_look_direction(input_direction)
		target_position = map.request_move(self, input_direction)
		if target_position:
			current_position = position
			move_time = 0
			$Control/CharacterSprite.next_frame()


func examine():
	map.request_examine(self, look_direction)


func update_look_direction(direction):
	look_direction = direction
	$Control/CharacterSprite.set_dir(Direction.vector_to_const(direction))


func on_examine(dir : Vector2):
	update_look_direction(-dir)
	.on_examine(dir)

