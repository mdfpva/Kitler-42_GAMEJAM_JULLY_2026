extends Area2D

const EXPLODE = preload("res://explode.tscn")

@export var type = -1
@export var sprites: Array[Texture2D]

func _ready() -> void:
	if type == -1:
		type = randi_range(0, sprites.size() - 1)
	$Sprite2D.texture = sprites[type]

	await get_tree().create_timer(3.0).timeout
	explode()

func explode() -> void:
	var explosion = EXPLODE.instantiate()
	explosion.position = position
	get_tree().current_scene.get_node("Explodes").add_child(explosion)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		if type == 0:
			get_tree().current_scene.get_node("GameManager").heal_player()
		if type == 1:
			get_tree().current_scene.get_node("Player").super_shot()
		if type == 2:
			get_tree().current_scene.get_node("Player").speed_player()
		#print("GETPRIZE")
		#print(type)
		#get_tree().current_scene.get_node("GameManager").damage_player()
#		remove prize
		queue_free()
