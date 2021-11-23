class_name Rng
extends Node

static func rand(a : int, b : int) -> int:
	var rng = max(a, b) - min(a, b) + 1
	return randi() % rng + min(a, b)

static func roll(a : int, b : int, c : int = 0) -> int:
	for i in range(a):
		c += rand(1, b)
	return c
