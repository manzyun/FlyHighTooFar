extends CharacterBody3D

var direction = Vector3.ZERO
const MAX_UP_IMPULSE = 6
@export var up_impulse = 3
@export var gravity = 3

var restrain_count = 0

var is_crushed = false
func get_crushed():
	return is_crushed
func set_crushed(state: bool):
	is_crushed = state
func reset_restrain_count():
	restrain_count = 0

func _physics_process(delta: float):
	if not is_crushed and direction.y < MAX_UP_IMPULSE:
		if Input.is_action_just_pressed("click"):
			$"../fly".play()
			print("clicked")
			#directionのyが一定以上になったらシャボン玉を割りたい
			direction.y += up_impulse
	if is_crushed and restrain_count == 0:
		direction.y = 2
		restrain_count += 1
		print("restrain")

	if not is_on_floor() and direction.y > -2:
		direction.y -= gravity * delta
		
	velocity = direction
	move_and_slide()
