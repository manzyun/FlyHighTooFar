extends CharacterBody3D

var direction = Vector3.ZERO
@export var up_impulse = 5
@export var gravity = 4

func _physics_process(delta: float):
	print(direction)
	if Input.is_action_just_pressed("click"):
		print("clicked")
		#directionのyが一定以上になったらシャボン玉を割りたい
		direction.y += up_impulse
		
	if not is_on_floor() and direction.y > -2:
		print("not on floor")
		direction.y -= gravity * delta
	velocity = direction
	move_and_slide()
