extends Node2D


func play() -> void:
	get_tree().change_scene_to_file("res://world.tscn")


func debug() -> void:
	get_tree().change_scene_to_file("res://debug.tscn")
