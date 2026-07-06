extends Area2D

var direction = Vector2.RIGHT
@export var SPEED = 500
@export var type = "enemy"
var max_x = 0
var max_y = 0

func _ready():
	max_x = get_viewport().get_visible_rect().size.x
	max_y = get_viewport().get_visible_rect().size.y

func _process(delta):
	position += direction * SPEED * delta

	if position.x > max_x or position.x < -10:
		queue_free()
		
func set_bullet_type(type: int):
	match type:
		0:
			$ColorRect.color = Color.YELLOW
		1:
			$ColorRect.color = Color.RED
		2:
			$ColorRect.color = Color.GREEN

func _on_body_entered(body):
	if body.is_in_group("enemies") and type == "player":
		get_tree().current_scene.get_node("GameManager").add_score(1)
		body.death()
#		remove bullet
		queue_free()

	if body.is_in_group("players") and type == "enemy":
		get_tree().current_scene.get_node("GameManager").damage_player()
#		remove bullet
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullets"):
		area.queue_free()
		queue_free()
