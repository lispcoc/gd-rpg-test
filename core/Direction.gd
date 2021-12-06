class_name Direction
extends Node

const N = Vector2.UP
const W = Vector2.LEFT
const S = Vector2.DOWN
const E = Vector2.RIGHT
const NE = N + E
const NW = N + W
const SE = S + E
const SW = S + W

static func vector_to_coordinate(v : Vector2):
	var array = [
		Vector2(-1,0), Vector2(-1,-1), Vector2(0,-1), Vector2(1,-1),
		Vector2(1,0), Vector2(1,1), Vector2(0,1), Vector2(-1,1), Vector2(-1,0), 
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]

static func vector_to_const(v : Vector2):
	var array = [
		W, NW, N, NE, E, SE, S, SW, W,
	]
	var index = round((v.angle() / PI + 1 + 1 / 8) * 4)
	return array[index]
