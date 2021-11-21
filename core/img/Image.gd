class_name ImageManager
extends Node

var character_images = []

var is_loaded = false

func _ready():
	# キャラクタの画像をロード
	dir_contents(character_images, "res://img/characters")
	is_loaded = true
	print("ImageManager.init() end")
	print(character_images)

func default_character_sprite():
	return character_images[1]

func dir_contents(array, path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if file_name != "." && file_name != "..":
					dir_contents(array, path.plus_file(file_name))
			else:
				var v = file_name.rsplit(".", true)
				if v[v.size() - 1] == "png":
					array.push_back(path.plus_file(file_name))
					print("Found file: " + path.plus_file(file_name))
			file_name = dir.get_next()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
