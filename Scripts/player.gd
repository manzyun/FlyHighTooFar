extends CharacterBody3D

var direction = Vector3.ZERO
var is_started = false
@export var up_impulse = 5
@export var gravity = 4

func set_game_started(is_started: bool):
	self.is_started = is_started

# 悩みどころ、シーンの定義がオブジェクト切り分けだが、ゲームシーン切り分けの時にメインシーンを止めても、
# 物理エンジンの都合上動作してしまう。 コード的にここにboolを入れると、物理エンジンっぽさがあって悩む
func _physics_process(delta: float):
	
	# ゲームのシーン状態を仮想関数というか引数から本来は渡したいので、悩む
	if !is_started:
		velocity = velocity
		return
	
	if Input.is_action_just_pressed("click"):
		print("clicked")
		#directionのyが一定以上になったらシャボン玉を割りたい
		direction.y += up_impulse
		
	if not is_on_floor() and direction.y > -2:
		direction.y -= gravity * delta
	velocity = direction
	move_and_slide()
