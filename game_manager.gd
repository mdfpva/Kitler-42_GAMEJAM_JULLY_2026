extends Node
const GAME_OVER = preload("res://game_over.tscn")
#@export var death_sounds: Array[AudioStream]

var lives = 5
var score = 0

func _ready() -> void:
	#$AudioStreamPlayer.stream = death_sounds.pick_random()
	$AudioStreamPlayer.play()
	#await $AudioStreamPlayer.finished

func add_score(points):
	score += points
	update_ui()

func damage_player():
	lives -= 1
	if lives == 0:
		game_over()
	else:
		update_ui()

func heal_player():
	lives += 1
	if lives > 5:
		lives = 5
	update_ui()

func game_over():
	#$AudioStreamPlayer.stream = death_sounds.pick_random()
	#$AudioStreamPlayer.play()
	#await $AudioStreamPlayer.finished
	var go = GAME_OVER.instantiate()
	var label = go.get_node("StatsLabel")
	label.text = "Your score: %d" % score

	get_tree().current_scene.add_child(go)
	
	get_tree().paused = true
	#var label = get_tree().current_scene.get_node("CanvasLayer/StatsLabel")
	#label.text = "GAME OVER\nScore: %d" % score
	#var button = get_tree().current_scene.get_node("CanvasLayer/RestartButton")
	#button.visible = true

func update_ui():
	var label = get_tree().current_scene.get_node("CanvasLayer/StatsLabel")
	label.text = "Lives: %d   Score: %d" % [lives, score]
