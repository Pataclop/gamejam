extends Node

export (PackedScene) var Ball

var player
var speedControler

var isGameOver:bool = false
var gameOverSpeedMultiplier = 1
var background_rotation = 0.001


func _ready():
	var windowSize = get_viewport().get_visible_rect().size
	
	
	player = load("res://PlayerCharacter.tscn").instance()
	player.position = windowSize/4
	add_child(player)
	player.connect("playerHit",self,"_on_Player_playerHit")
	
	speedControler = load("res://GameSpeedControler.gd").new()
	speedControler.registerMovingElement(player)
	
	var center = preload("res://Center.tscn").instance()
	center.position = windowSize/2
	center.player = player
	center.speedControler = speedControler
	add_child(center)
	
	$External_barrier.connect("collide", center, "_on_External_barrier_collide")
	
	
	speedControler.registerMovingElement($Background)
	
	
	
	
	
func _process(delta):
	
	
	get_node("background").rotate(background_rotation)
	
	
	if(isGameOver):
		background_rotation *= 0.95
		gameOverSpeedMultiplier *= 0.995
		speedControler.gameSpeed *= gameOverSpeedMultiplier
	
	
	speedControler.step()
	
	
	
	
func _input(event):
	
	if (event.is_action_pressed("ui_restart")):
		get_tree().reload_current_scene()
	
	
	if (event.is_action_released("ui_cancel")):
		get_tree().quit()

func _on_Player_playerHit(player,area):
	if(area == $External_barrier):
		print("Hit the barrier")
		isGameOver = true
	elif(area.is_type("Collectible")):
		print("Picked up a collectible")
	elif(area.is_type("Ball")):
		print("Hit a ball")
		area.change_color(Color(255,255,255))
		isGameOver = true
	else:
		print("Hit an unknown element")
	


