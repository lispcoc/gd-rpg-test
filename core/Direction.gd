class_name Direction
extends Node

enum Const { E, NE, N, NW, W, SW, S, SE }

static func vector_to_coordinate(v : Vector2):
	var array = [
		Vector2(-1,0), Vector2(-1,-1), Vector2(0,-1), Vector2(1,-1),
		Vector2(1,0), Vector2(1,1), Vector2(0,1), Vector2(-1,1), Vector2(-1,0), 
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]

static func vector_to_const(v : Vector2):
	var array = [
		Const.W, Const.NW, Const.N, Const.NE,
		Const.E, Const.SE, Const.S, Const.SW, Const.W,
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]
