#tool
class_name RichLabel
extends Label

var font = DynamicFont.new()

func _ready():
	var font_data:DynamicFontData = preload("res://NotoSansJP-Regular.otf")
	font.font_data = font_data
	set("custom_fonts/font", font)
	pass
