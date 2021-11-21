extends Node

var year = 100
var mon = 1
var day = 1
var hour = 8
var minute = 0
var second = 0


func _ready():
	EventSignal.connect("player_moved", self, "_on_player_moved")
	pass # Replace with function body.

func to_string():
	return "%d年%d月%d日 %02d:%02d:%02d" % [year, mon, day, hour, minute, second]

func _on_player_moved(player):
	increment_second()
	print(to_string())

func increment_second():
	second = (second + 1) % 60
	if second == 0:
		increment_minute()

func increment_minute():
	minute = (minute + 1) % 60
	if minute == 0:
		increment_hour()

func increment_hour():
	hour = (hour + 1) % 24
	if hour == 0:
		increment_day()

func increment_day():
	day = (day + 1) % 31
	if day == 0:
		day = 1
		increment_mon()

func increment_mon():
	mon = (mon + 1) % 12
	if mon == 0:
		mon = 1
		increment_year()

func increment_year():
	year = (year + 1)
