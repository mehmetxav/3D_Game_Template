extends Area3D

@export_file var level_to_load

var player_entered = false
signal update_console

func _unhandled_input(event):
	if Input.is_action_just_pressed("portal"):
		if global.has_special_key:
			get_tree().change_scene_to_file(level_to_load)
		else:
			emit_signal("update_console","You need to find the special key")
		

func _on_body_entered(body):
	player_entered = true
	emit_signal("update_console", "Press G to go to the next level")



func _on_body_exited(body):
	player_entered = false
	emit_signal("update_console","")
	
