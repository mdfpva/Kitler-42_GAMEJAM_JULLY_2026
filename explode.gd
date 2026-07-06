extends CharacterBody2D
signal finished

func _ready():
	$AnimatedSprite2D.play("explode")

func _physics_process(delta: float) -> void:
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	#print("finished")
	finished.emit()
	queue_free()
