extends Node


signal level_set

var current_level: Level = null:
	set(value):
		current_level = value
		level_set.emit()
