class_name Player
extends Pawn

#warning-ignore:unused_class_variable
export(PackedScene) var combat_actor
#warning-ignore:unused_class_variable
var lost = false

var look_direction : Vector2 = Vector2(1,0)

signal player_moved(player)
signal timeline_start(player)

func _ready():
	$Control/CharacterSprite.load(ImageManager.default_character_sprite())
	update_look_direction(Vector2.RIGHT)
	connect("player_moved", Game, "_on_player_moved")


func move(input_direction : Vector2):
	if target_position == null:
		if not input_direction:
			return
		update_look_direction(input_direction)
		target_position = parent.request_move(self, input_direction)
		if target_position:
			current_position = position
			move_time = 0
			$Control/CharacterSprite.next_frame()


func examine():
	parent.request_examine(self, look_direction)


func update_look_direction(direction):
	look_direction = direction
	$Control/CharacterSprite.set_dir(Direction.vector_to_const(direction))
	$Pivot/Sprite.rotation = direction.angle()


func on_examine(dir : Vector2):
	update_look_direction(-dir)
	print("on_examine " , self)
	var new_dialog = Dialogic.start('hello')
	add_child(new_dialog)
	connect("timeline_start", Game, "_on_timeline_start")
	emit_signal("timeline_start", 'hello')
	new_dialog.connect("timeline_end", Game, "_on_timeline_end")

