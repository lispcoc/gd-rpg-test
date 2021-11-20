class_name Player
extends Pawn

onready var parent = get_parent()
#warning-ignore:unused_class_variable
export(PackedScene) var combat_actor
#warning-ignore:unused_class_variable
var lost = false
var move_time = 0.0
var tile_per_sec = 5.0
var target_position = null
var current_position = null

var ImageManager : ImageManager

signal player_moved(player)

func _ready():
	ImageManager = get_node("/root/Game/ImageManager")
	ImageManager.default_character_sprite()
	update_look_direction(Vector2.RIGHT)

func _process(_delta):
	if target_position:
		move_time += _delta
		position = (target_position - current_position) * (move_time * tile_per_sec) + current_position
		#move_to(target_position)
		#$Tween.start()
		if (move_time * tile_per_sec) >= 1.0:
			position = target_position
			target_position = null
			emit_signal("player_moved", self)


func move(input_direction : Vector2):
	if target_position == null:
		if not input_direction:
			return
		update_look_direction(input_direction)
		target_position = parent.request_move(self, input_direction)
		if target_position:
			current_position = position
			move_time = 0
			print(target_position)
			$CharacterSprite.next_frame()


func update_look_direction(direction):
	$CharacterSprite.set_dir(Direction.vector_to_const(direction))
	$Pivot/Sprite.rotation = direction.angle()


func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")
	var move_direction = (position - target_position).normalized()
	$Tween.interpolate_property($Pivot, "position", move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Pivot/Sprite.position = position - target_position
	position = target_position

	yield($AnimationPlayer, "animation_finished")

	set_process(true)


func bump():
	$AnimationPlayer.play("bump")
