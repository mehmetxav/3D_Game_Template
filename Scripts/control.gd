extends Control


@export var start_level_scene : PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(start_level_scene)


