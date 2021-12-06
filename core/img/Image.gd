extends Node

var character_images = []

var character_parts : Dictionary = {
	"デフォルト": {},
	"ベース": {},
	"顔": {},
	"髪": {},
	"髪+": {},
	"帽子": {},
	"前髪": {},
	"服下": {},
	"服上": {},
	"服セット": {},
	"上着": {},
}

var character_parts_z_idx : Dictionary = {
	"ベース": 0,
	"顔": 1,
	"髪": 10,
	"髪+": 11,
	"前髪": 12,
	"帽子": 20,
	"服セット": 2,
	"服下": 3,
	"服上": 4,
	"上着": 5,
}

var _default_character_image_data = {
	"デフォルト": "001",
}

func init():
	# キャラクタの画像をロード
	load_character_images("./img/characters/")
	load_character_parts("./img/character_parts/")
	debug_verbose()

func debug_verbose():
	print("character_images:")
	print(character_images)
	print("character_parts:")
	print(character_parts)
	
func default_character_image_data():
	return _default_character_image_data

func load_character_images(path):
	var a = []
	dir_contents(a, path)
	for file in a:
		var image = Image.new()
		var texture = ImageTexture.new()
		image.load(file)
		texture.create_from_image(image)
		character_images.push_back(texture)

func load_character_parts(dir):
	for part in character_parts.keys():
		var a = []
		dir_contents(a, dir + part)
		for path in a:
			# ウディタ規格でパーツの前後に対応する
			# ファイル名の末尾に$が付くのが後ろ側
			var image = Image.new()
			var texture = ImageTexture.new()
			var file = path.get_file()
			var name = file.get_basename().trim_suffix("$")
			image.load(path)
			texture.create_from_image(image)
			if not character_parts[part].has(name):
				character_parts[part][name] = {}
			if file.get_basename().ends_with("$"):
				character_parts[part][name]["back"] = texture
			else:
				character_parts[part][name]["front"] = texture
	pass

func get_character_parts(part : String, name : String, fb := "front") -> Texture:
	if character_parts.has(part):
		if character_parts[part].has(name):
			if character_parts[part][name].has(fb):
				return character_parts[part][name][fb] as Texture
	return null

func get_character_parts_z(part : String) -> int:
	if character_parts_z_idx.has(part):
		return character_parts_z_idx[part]
	return 0

func dir_contents(array, path, ext = "png"):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if file_name != "." && file_name != "..":
					dir_contents(array, path.plus_file(file_name))
			else:
				if file_name.get_extension() == ext:
					array.push_back(path.plus_file(file_name))
					print("Found file: " + path.plus_file(file_name))
			file_name = dir.get_next()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
