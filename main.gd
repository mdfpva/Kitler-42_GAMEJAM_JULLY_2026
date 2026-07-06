extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_restart_button_pressed():
	print("test")
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_start_button_pressed() -> void:
	$StartScreen/StartMenu.visible = false
	get_tree().paused = false
