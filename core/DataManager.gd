extends Node

var default_characters_folder = "res://data/json/characters/"
var enemies_folder = "res://data/json/characters/"
var characters := []
var enemies := []

func init():
	load_characters()
	load_enemies()
	pass

func load_json(file_path):
	var file = File.new()
	var json_result
	file.open(file_path, file.READ)
	var file_text = file.get_as_text()
	var json_parse = JSON.parse(file_text) # typeto JSONResultParse
	json_result = json_parse.result
	file.close()
	return json_result

func load_json_dir(dir_path):
	var files = []
	var json_result = []
	System.dir_contents(files, dir_path, "json")
	for n in files:
		for m in load_json(n):
			json_result.append(m)
	return json_result


func load_characters():
	var json_list = load_json_dir(default_characters_folder)
	for j in json_list:
		characters.append(Character.new(characters.size(), j))
	return


func get_character(n : int) -> Character:
	return characters[n]

func load_enemies():
	var json_list = load_json_dir(enemies_folder)
	for j in json_list:
		enemies.append(Character.new(characters.size(), j))
	return

func get_enemy(n : int) -> Character:
	return enemies[n]





