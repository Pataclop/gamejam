extends Area2D


const BALL_SPEED = 100
var direction = Vector2(-1, 0)
var speed = BALL_SPEED
var packedObstacle = preload("res://Obstacle.tscn")
var packedAnchor = preload("res://Anchor.tscn")

onready var initial_pos = self.position

func reset():
	position = initial_pos
	speed = BALL_SPEED
	direction = Vector2(-1, 0)

func create():
	var scene = load("res://Obstacle.tscn") # Will load when the script is instanced.
	
func _ready():
	$newObstacleTimer.start()
	$newAnchorTimer.start()
	
func _process(delta):
	
	#var width = get_viewport_rect().size[0]
	#var heigth = get_viewport_rect().size[1]
	#position.x = width/2
	#position.y = heigth/2
	#var obstacle_ress = preload("res://Obstacle.tscn")
	#var obstacle = obstacle_ress.instance()
	#obstacle.set_position(Vector2(position.x,position.y))
	#get_parent().add_child(obstacle)
	pass
	


func _on_newObstacleTimer_timeout():
	var width = get_viewport_rect().size[0]
	var heigth = get_viewport_rect().size[1]
	position.x = width/2
	position.y = heigth/2
	
	var obstacle = packedObstacle.instance()
	
	obstacle.set_position(Vector2(position.x,position.y))
	get_parent().add_child(obstacle)


func _on_newAnchorTimer_timeout():
	var width = get_viewport_rect().size[0]
	var heigth = get_viewport_rect().size[1]
	position.x = width/2
	position.y = heigth/2
	
	var anchor = packedAnchor.instance()
	
	anchor.set_position(Vector2(position.x,position.y))
	get_parent().add_child(anchor)
	anchor.connect("is_clicked",$Player,"_on_Anchor_is_clicked")
