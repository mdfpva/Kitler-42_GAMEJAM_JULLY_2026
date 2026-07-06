extends Node2D

const STAR_TEXTURES = [
	preload("res://images/stars/1.png"),
	preload("res://images/stars/2.png"),
	preload("res://images/stars/3.png")
]

var timer = 0.0

func _ready() -> void:
	z_index = -100

func _process(delta):
	timer += delta

	if timer > 5:
		timer = 0
		#spawn_star()

	for star in get_children():
		star.position.x -= star.get_meta("speed") * delta

		if star.position.x < -50:
			star.queue_free()
		
func spawn_star():
	print("star")
	var star = Sprite2D.new()
	star.texture = STAR_TEXTURES.pick_random()
	var screen = get_window().size
	star.position = Vector2(
		screen.x + 20,
		randi_range(0, screen.y)
	)
	star.set_meta("speed", randf_range(20, 60))
	add_child(star)
