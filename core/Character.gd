class_name Character
extends Node

export(PackedScene) var pawn = preload("pawns/CharacterPawn.tscn")

var _data : Dictionary = {
	"cname" : "キャラクター",
	"level" : 1,
	"experience" : 0,
	"hp" : 65535,
	"mp" : 65535,
	"strength" : 1,
	"dexterity" : 1,
	"constitution" : 1,
	"intelligence" : 1,
	"wisdom" : 1,
	"charisma" : 1,
	"image": {
		"ベース": "ベースA",
		"前髪": "01a_A",
		"服上": "シャツ00a_A",
		"服下": "スカート01a_A",
		"顔": "なし",
		"髪": "ショート01_A",
		"髪+": "ツインa_長01_A",
	}
}

var cname setget _set_name, _get_name
var level setget _set_level, _get_level
var experience setget _set_experience, _get_experience
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
	var _pawn := (pawn.instance() as CharacterPawn)
	_pawn.load_custom_character(_data["image"])
	return _pawn


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
# ステータス関係
#
func get_max_hp() -> int:
	var base_hp = 20
	var growth_hp = (constitution * 2 + strength) / 6
	return int(base_hp + growth_hp * level)

func get_max_mp() -> int:
	var base_mp = 20
	var growth_mp = (get_eff_intelligence() * 2 + get_eff_wisdom()) / 6
	return int(base_mp + growth_mp * level)

func get_atk() -> int:
	var weapon : Item = null
	var growth_atk = (get_eff_strength() * 2 + get_eff_dexterity()) / 6
	var base_atk = growth_atk * 4
	if not weapon:
		# 装備なし
		return int(base_atk + growth_atk * level)
	return 0

func get_def() -> int:
	return 0

func get_eff_strength():
	return strength

func get_eff_constitution():
	return constitution

func get_eff_dexterity():
	return dexterity

func get_eff_intelligence():
	return intelligence

func get_eff_wisdom():
	return wisdom

# 経験値/Lv関係
func next_experience():
	return int(100 * 1.5^(level - 1))


func add_experience(value : int):
	experience += value
	while experience >= next_experience():
		experience -= next_experience()
		level_up()

func level_up():
	level += 1
	print("%s level up to %d.", [cname, level])

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

func _set_name(new_value : String):
	_data["name"] = new_value
func _get_name():
	return _data["name"]

func _set_level(new_value):
	_data["level"] = new_value
func _get_level():
	return _data["level"]

func _set_experience(new_value):
	_data["experience"] = new_value
func _get_experience():
	return _data["experience"]

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
