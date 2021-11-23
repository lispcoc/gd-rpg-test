extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sub_frame = 0

const x_frame = 6
const y_frame = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_texture(file):
	var res = load(file)
	texture = res
	position = Vector2(-texture.get_width() / x_frame / 2, -texture.get_height() / y_frame + 16)
	centered = false
	

func next_frame():
	sub_frame = frame % 3
	frame -= sub_frame
	sub_frame = (sub_frame + 1) % 3
	frame += sub_frame

func set_dir(dir):
	frame = sub_frame
	match dir:
		Enum.Direction.S:
			frame += 0
		Enum.Direction.SW:
			frame += 3
		Enum.Direction.W:
			frame += 6
		Enum.Direction.SE:
			frame += 9
		Enum.Direction.E:
			frame += 12
		Enum.Direction.NW:
			frame += 15
		Enum.Direction.N:
			frame += 18
		Enum.Direction.NE:
			frame += 21
		Enum.Direction.W:
			frame += 24

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
