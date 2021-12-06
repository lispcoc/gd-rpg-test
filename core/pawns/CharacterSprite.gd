extends Sprite
class_name CharacterSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sub_frame := [0, 1, 2 ,1]
var sub_frame_idx := 0

const x_frame = 6
const y_frame = 4

var mod_color_material : Material = preload("res://core/shader/mod_color.material")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _init():
	._init()
	hframes = x_frame
	vframes = y_frame
	.set_material(mod_color_material.duplicate())
	return self

func load_texture(_texture : ImageTexture):
	texture = _texture
	position = Vector2(-texture.get_width() / x_frame / 2, -texture.get_height() / y_frame + 16)
	centered = false


func set_hsv(h, s, v):
	print("%f %f %f", [h, s, v])
	material.set_shader_param("mod_h", h)
	material.set_shader_param("mod_s", s)
	material.set_shader_param("mod_v", v)


func next_frame():
	var base_frame = frame - frame % 3
	sub_frame_idx = (sub_frame_idx + 1) % sub_frame.size()
	frame = base_frame + sub_frame[sub_frame_idx]

func set_dir(dir):
	frame = sub_frame[sub_frame_idx]
	match dir:
		Direction.S:
			frame += 0
		Direction.SW:
			frame += 3
		Direction.W:
			frame += 6
		Direction.SE:
			frame += 9
		Direction.E:
			frame += 12
		Direction.NW:
			frame += 15
		Direction.N:
			frame += 18
		Direction.NE:
			frame += 21
		Direction.W:
			frame += 24

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
