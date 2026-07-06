extends CanvasLayer
var paused = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	paused = false
	#pass # Replace with function body.

	
func _input(event):
	if event.is_action_pressed("ui_accept") and not paused:
		get_tree().paused = false
		get_tree().reload_current_scene()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
