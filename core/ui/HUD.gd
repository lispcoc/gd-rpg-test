extends Control


func _ready():
	update_all()
	pass


func _process(delta):
	update_all()
	pass


func update_all():
	update_calender()
	update_weather()
	update_temp()


func update_calender():
	$Calender.set_text(Time.to_string())


func update_weather():
	$Weather.set_text(Weather.string_weather())


func update_temp():
	$Temp.set_text(Weather.string_temp())

