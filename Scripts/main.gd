extends Node

@export var obstacle_scene: PackedScene #= preload("res://Scenes/ObstacleManager.tscn")
var timer = 0

const CRUSH_TIMER = 3
var crush_timer = CRUSH_TIMER
var is_crush_timer_started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var player_pos = $Player.position
	$CameraPivot.set_pos(player_pos)
	$Bubble.set_pos(player_pos)
	$Cloud.set_pos(player_pos, not $Player.get_crushed())
	
	if not $Bubble.get_visible():
		is_crush_timer_started = true
		$Player.set_crushed(true)
		$Cloud.visible_set(true)
	if is_crush_timer_started:
		crush_timer -= delta
		if crush_timer < 0:
			is_crush_timer_started = false
			crush_timer = CRUSH_TIMER
			$Player.set_crushed(false)
			$Player.reset_restrain_count()
			$Bubble.visible_set()
			$Cloud.visible_set(false)
			
	get_timer()
	$Control/LabelGameTimer.display_timer(timer)

func get_timer():
	timer = $GameTimer.time_left
func _on_game_timer_timeout():
	print("GameOver")
	GameManager.load_result_scene()

func _on_obstacle_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	obstacle.initialize($Player.position)
	add_child(obstacle)
