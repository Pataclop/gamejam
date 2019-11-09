extends Area2D




var gameSpeedControler = load("res://GameSpeedControler.gd").new()
var packedObstacle = preload("res://Obstacle.tscn")
var packedAnchor = preload("res://Anchor.tscn")

onready var initial_pos = self.position

func reset():
	pass

func create():
	#var scene = load("res://Obstacle.tscn") # Will load when the script is instanced.
	
	pass
	
func _ready():
	$newObstacleTimer.start()
	$newAnchorTimer.start()
	
func _process(delta):
	gameSpeedControler.step()
	gameSpeedControler.registerMovingElement($Player)
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
	gameSpeedControler.registerMovingElement(anchor)
	anchor.connect("is_clicked",gameSpeedControler,"_on_Anchor_is_clicked")
