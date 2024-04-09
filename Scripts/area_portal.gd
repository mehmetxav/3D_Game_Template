extends Area3D

@export_file var level_to_load

var player_entered = false
signal update_console

func _unhandled_input(_event):
	if Input.is_action_just_pressed("portal") and global.has_special_key and global.apple_count >= 3:
			get_tree().change_scene_to_file(level_to_load)

func _on_body_entered(_body):
	player_entered = true
	if not global.has_special_key:
		emit_signal("update_console","You need to find the special key")
	elif global.apple_count < 3:
		emit_signal("update_console", "You need 3 cases to go to the next level")
	else:
		emit_signal("update_console", "Press G to go to the next level")



func _on_body_exited(_body):
	player_entered = false
	emit_signal("update_console","")
	
