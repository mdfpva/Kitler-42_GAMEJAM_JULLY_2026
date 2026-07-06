extends CharacterBody2D
const BULLET = preload("res://bullet.tscn")

var bullet_speed = 1500
var player_speed = 500
var triple_short = 0

#var level_completed = false

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	velocity = direction.normalized() * player_speed
	move_and_slide()
	position.x = clamp(position.x, 20, get_viewport().get_visible_rect().size.x - 50)
	position.y = clamp(position.y, 50, get_viewport().get_visible_rect().size.y - 50)
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		if triple_short:
			await get_tree().create_timer(0.2).timeout
			shoot()
			await get_tree().create_timer(0.2).timeout
			shoot()
		  
func shoot():
	var bullet = BULLET.instantiate()
	bullet.type = "player"
	bullet.position = position + Vector2(35 , 0)
	bullet.SPEED = bullet_speed
	if triple_short:
		bullet.set_bullet_type(2)
	else:
		bullet.set_bullet_type(0)
	#get_parent().add_child(bullet)
	var bullets = get_tree().current_scene.get_node("Bullets")
	bullets.call_deferred("add_child", bullet)
	
func speed_player():
	player_speed += 500
	bullet_speed += 500
	await get_tree().create_timer(10.0).timeout
	player_speed -= 500
	bullet_speed -= 500
	if player_speed < 500:
		player_speed = 500
	if bullet_speed < 1500:
		player_speed = 1500
		
func super_shot():
	triple_short = 1
	await get_tree().create_timer(10.0).timeout
	triple_short = 0


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var game_manager = get_tree().current_scene.get_node("GameManager")
		game_manager.add_score(1)
		game_manager.damage_player()
		body.death()
		#death()   # или GameManager.game_over()
