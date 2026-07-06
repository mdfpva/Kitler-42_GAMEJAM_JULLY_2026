extends CharacterBody2D
const BULLET = preload("res://bullet.tscn")
const EXPLODE = preload("res://explode.tscn")
const PRIZE = preload("res://prize.tscn")
@export var can_shoot = false
@export var shoot_speed = 1
@export var SPEED = 150
@export var bullet_speed = 700
@export var type = 0

var shoot_timer = 0.0

func _physics_process(delta):
	velocity.x = -SPEED
	velocity.y = 0
	move_and_slide()

	if position.x < -150:
		queue_free()
		
	shoot_timer += delta

	if can_shoot and shoot_timer > shoot_speed:
		shoot_timer = 0
		shoot()
	
func shoot():
	var bullet = BULLET.instantiate()
	bullet.SPEED = bullet_speed
	bullet.global_position = global_position + Vector2(-25, 15)
	bullet.direction = Vector2.LEFT

	var bullets = get_tree().current_scene.get_node("Bullets")
	bullets.add_child(bullet)
	
func set_type(type: int):
	match type:
		0:
			$AnimatedSprite2D.play("mouse1")
			SPEED = 100
			can_shoot = true
			bullet_speed = 700
			shoot_speed = 1
		1:
			$AnimatedSprite2D.play("mouse2")
			SPEED = 180
			can_shoot = true
			bullet_speed = 1500
			shoot_speed = 0.8

func death() -> void:
	var explosion = EXPLODE.instantiate()
	#explosion.show_prize = false
	#print(EXPLODE)
	#print(explosion)
	explosion.position = position
	get_tree().current_scene.get_node("Explodes").add_child(explosion)
	queue_free()
	if randf() > 0:
		var prize = PRIZE.instantiate()
		prize.position = position
		#prize.type = 2
		get_tree().current_scene.get_node("Prizes").add_child(prize)
		
