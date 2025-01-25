extends Node3D

#生成するシーンをセット
var obstacle_scenes: Array[PackedScene] = [preload("res://Scenes/obstacle_01.tscn"),preload("res://Scenes/obstacle_01.tscn"),preload("res://Scenes/obstacle_01.tscn")]
const BIRD: int = 0
const UFO: int = 1
const ASTEROID: int = 2
var obstacle_type: int

const WIDTH_MIN: int = -2
const WIDTH_MAX: int = 2
#初期位置
@export var start_positions: Array[Vector3] = [Vector3(-10,10,0),Vector3(10,10,0)]

var direction: Vector3 = Vector3.ZERO

#切り返した回数
var flip_count: int = 0
#切り返しの最大数。obstacleのタイプによって変動
var max_flip_count = 0
@export var speed = 10

func initialized(player_pos: Vector3):
	#生成するobstacleを乱数で指定
	#randi()が0からintの最大値までを返すので、3で割った余剰を渡す
	obstacle_type = randi()%3
	var obstacle_scene = obstacle_scenes[obstacle_type]
	var obstacle = obstacle_scene.instantiate()
	#左右どちらに生成するか指定
	#0が左、1が右	
	var start_pos = start_positions[randi()%2]
	var height_dist = 4
	#生成位置をPlayerの少し上に指定。後で乱数にする
	start_pos.y = player_pos.y + height_dist
	obstacle.position = start_pos
	
func _init():
	initialized(Vector3(0, 5, 0))
#Obstacleの移動
func move(dir: Vector3, obstacle_type: int):
	match obstacle_type:
		BIRD:
			max_flip_count = 0
		UFO:
			max_flip_count = 4
		ASTEROID:
			max_flip_count = 0
		_:
			print("error")
	if flip_count <= max_flip_count:
		if self.position.x < WIDTH_MIN:
					dir.x = speed
		if self.position.x > WIDTH_MAX:
			dir.x = -speed
	global_translate(dir)
	
func _physics_process(delta: float) :
	move(direction * delta, obstacle_type)
