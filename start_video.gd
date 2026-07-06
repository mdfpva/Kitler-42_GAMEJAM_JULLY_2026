extends CanvasLayer
const START = preload("res://start_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoStreamPlayer.play()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_screen()
		queue_free()

func _on_video_stream_player_finished():
	start_screen()
	queue_free()

func start_screen():
	var start = START.instantiate()
	get_tree().current_scene.add_child(start)
