extends Node
class_name Character

export(PackedScene) var pawn = preload("pawns/CharacterPawn.tscn")

var _data : Dictionary = {
	"name" : "キャラクター",
	"level" : 1,
	"hp" : 65535,
	"mp" : 65535,
	"strength" : 1,
	"dexterity" : 1,
	"constitution" : 1,
	"intelligence" : 1,
	"wisdom" : 1,
	"charisma" : 1,
}

var level setget _set_level, _get_level
var hp setget _set_hp, _get_hp
var mp setget _set_mp, _get_mp
var strength setget _set_strength, _get_strength
var dexterity setget _set_dexterity, _get_dexterity
var constitution setget _set_constitution, _get_constitution
var intelligence setget _set_intelligence, _get_intelligence
var wisdom setget _set_wisdom, _get_wisdom
var charisma setget _set_charisma, _get_charisma


var number = 0


func generate_pawn():
	return pawn.instance()


func get_max_hp() -> int:
	var base_hp = 20
	var growth_hp = (constitution * 2 + strength) / 6
	return int(base_hp + growth_hp * level)


func get_max_mp() -> int:
	var base_mp = 20
	var growth_mp = (intelligence * 2 + wisdom) / 6
	return int(base_mp + growth_mp * level)


#
# コンストラクタ
#
func _init(_number = 0, dict = {} as Dictionary):
	for key in dict.keys():
		_data[key] = dict[key]
	number = _number
	print (json_string())


func json_string():
	return JSON.print(_data, "  ")


#
# Setter & Getter
#
func _set_hp(new_value):
	_data["hp"] = new_value
func _get_hp():
	if _data["hp"] > get_max_hp():
		hp = get_max_hp()
	return _data["hp"]

func _set_mp(new_value):
	_data["mp"] = new_value
func _get_mp():
	if _data["mp"] > get_max_mp():
		hp = get_max_mp()
	return _data["mp"]

func _set_level(new_value):
	_data["level"] = new_value
func _get_level():
	return _data["level"]

func _set_strength(new_value):
	_data["strength"] = new_value
func _get_strength():
	return _data["strength"]

func _set_dexterity(new_value):
	_data["dexterity"] = new_value
func _get_dexterity():
	return _data["dexterity"]

func _set_constitution(new_value):
	_data["constitution"] = new_value
func _get_constitution():
	return _data["constitution"]

func _set_intelligence(new_value):
	_data["intelligence"] = new_value
func _get_intelligence():
	return _data["intelligence"]

func _set_wisdom(new_value):
	_data["wisdom"] = new_value
func _get_wisdom():
	return _data["wisdom"]

func _set_charisma(new_value):
	_data["charisma"] = new_value
func _get_charisma():
	return _data["charisma"]
