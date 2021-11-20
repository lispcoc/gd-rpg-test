extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var file : String
var sub_frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load():
	var res = load(file)
	texture = res

func next_frame():
	sub_frame = frame % 3
	frame -= sub_frame
	sub_frame = (sub_frame + 1) % 3
	frame += sub_frame

func set_dir(dir):
	frame = sub_frame
	print (dir)
	match dir:
		Direction.Const.S:
			frame += 0
		Direction.Const.SW:
			frame += 3
		Direction.Const.W:
			frame += 6
		Direction.Const.SE:
			frame += 9
		Direction.Const.E:
			frame += 12
		Direction.Const.NW:
			frame += 15
		Direction.Const.N:
			frame += 18
		Direction.Const.NE:
			frame += 21
		Direction.Const.W:
			frame += 24
	print(frame)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
