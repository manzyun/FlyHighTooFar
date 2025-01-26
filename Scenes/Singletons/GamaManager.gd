extends Node

var score: int

var title_scene: PackedScene = preload("res://Scenes/Title/Title.tscn")
var in_game_scene: PackedScene = preload("res://Scenes/main.tscn")
var result_scene: PackedScene = preload("res://Scenes/Result/Result.tscn")

func load_ingame_scene() -> void:
	get_tree().change_scene_to_packed(in_game_scene)
func load_result_scene() -> void:
	get_tree().change_scene_to_packed(result_scene)
func load_title_scene() -> void:
	get_tree().change_scene_to_packed(title_scene)	
func set_score(s: int):
	score = s
