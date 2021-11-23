class_name System
extends Node


static func dir_contents(array, path, ext = ""):
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
				if ext == "" or v[v.size() - 1] == ext:
					array.push_back(path.plus_file(file_name))
					print("Found file: " + path.plus_file(file_name))
			file_name = dir.get_next()

