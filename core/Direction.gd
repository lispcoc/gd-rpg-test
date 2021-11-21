class_name Direction
extends Node

static func vector_to_coordinate(v : Vector2):
	var array = [
		Vector2(-1,0), Vector2(-1,-1), Vector2(0,-1), Vector2(1,-1),
		Vector2(1,0), Vector2(1,1), Vector2(0,1), Vector2(-1,1), Vector2(-1,0), 
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]

static func vector_to_const(v : Vector2):
	var array = [
		Enum.Direction.W, Enum.Direction.NW, Enum.Direction.N, Enum.Direction.NE,
		Enum.Direction.E, Enum.Direction.SE, Enum.Direction.S, Enum.Direction.SW, Enum.Direction.W,
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]
