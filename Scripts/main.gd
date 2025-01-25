extends Node

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var player_pos = $Player.position
	$CameraPivot.set_pos(player_pos)
	$Bubble.set_pos(player_pos)
	get_timer()
	$Control/LabelGameTimer.display_timer(timer)

func get_timer():
	timer = $GameTimer.time_left
func _on_game_timer_timeout() :
	print("GameOver")
