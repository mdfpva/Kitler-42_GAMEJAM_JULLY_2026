func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
