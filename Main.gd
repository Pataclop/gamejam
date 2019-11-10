extends Node

export (PackedScene) var Ball

var player
var speedControler

var isGameOver:bool = false
var gameOverSpeedMultiplier = 1
var speed_rotation = 0.001


func _ready():
	player = load("res://PlayerCharacter.tscn").instance()
	player.position = Vector2(0.05, 0.25) * OS.window_size
	add_child(player)
	player.connect("playerHit",self,"_on_Player_playerHit")
	
	speedControler = load("res://GameSpeedControler.gd").new()
	speedControler.registerMovingElement(player)
	
	var pos = Vector2(0.25, 0.25)
	var center = preload("res://Center.tscn").instance()
	center.position = pos * OS.window_size
	center.player = player
	center.speedControler = speedControler
	add_child(center)
	
	$External_barrier.connect("collide", center, "_on_External_barrier_collide")
	
	
	
	
	
	
	
func _process(delta):
	
	
	get_node("background").rotate(speed_rotation)
	
	
	if(isGameOver):
		speed_rotation *= 0.95
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
		print("barriere")
	#elif(area.get_type() == load("res://Ball.tscn")):
	#	var ball = area
	#	print("ball ",ball)
	else:
		print("element inconnu")
		
	isGameOver = true


