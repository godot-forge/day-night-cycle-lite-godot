@tool
extends EditorPlugin

func _enable_plugin() -> void:
	add_autoload_singleton("DayNight", "res://addons/day_night_cycle_lite/day_night_cycle.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton("DayNight")
