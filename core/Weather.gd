extends Node

enum WeatherType {SUNNY, CLOUDY, RAINY, WIND}

var weather : int = WeatherType.SUNNY setget _set_weather, _get_weather

var temp : int = 25 setget _set_temp, _get_temp

func _ready():
	pass

func _set_temp(new_value):
	temp = new_value


func _get_temp():
	return temp


func _set_weather(new_value):
	weather = new_value


func _get_weather():
	return weather


func string_temp():
	return "%d℃" % [temp]

func string_weather():
	match weather:
		WeatherType.SUNNY:
			return "晴れ"
		WeatherType.CLOUDY:
			return "曇り"
		WeatherType.RAINY:
			return "雨"
		WeatherType.WIND:
			return "強風"
	return "晴れ"
