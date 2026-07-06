extends Node

#const ENEMY = preload("res://enemy.tscn")
const ENEMIES = [
	preload("res://enemy.tscn")
]

var rand = RandomNumberGenerator.new()
#var completed = false
#var level = 1
var spawn_timer = 0.0
var spawn_interval = 2.0
var difficulty = 1.0
var max_x = 0
var max_y = 0

func _ready():
	max_x = get_viewport().get_visible_rect().size.x
	max_y = get_viewport().get_visible_rect().size.y
		
func _process(delta):
	spawn_timer += delta
	
	difficulty += delta * 0.02
	spawn_interval = max(0.3, 3.0 / difficulty)
	#spawn_interval = 0.5

	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_enemy()
		
func spawn_enemy():
	#var enemy = ENEMY.instantiate()
	
	var enemies = ENEMIES.pick_random()
	var enemy = enemies.instantiate()
	enemy.global_position = Vector2(
		max_x + 20,
		randi_range(50, max_y - 50)
	)
	enemy.SPEED = randi_range(100, 200)
	enemy.set_type(randi_range(0, 1))
	
	var enemy_scene = get_tree().current_scene.get_node("Enemies")
	enemy_scene.add_child(enemy)
