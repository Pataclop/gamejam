extends Node

export (PackedScene) var Ball

var player
var speedControler
var center

var isGameOver:bool = false
var gameOverSpeedMultiplier = 1
var background_rotation = 0.001
var started
var ui
var ui_hidden
var old_gameSpeed
var score = 0
func _ready():	
	get_node("UI/StartPanel/VBoxContainer/HBoxContainer/Button3").hide()
	started = false
	ui = get_node("UI")
	
	
	
	
	
	
	
	
func _process(delta):
	
	if started:
		$HUD.update_score(score)

		get_node("background").rotate(background_rotation)
		
		
		if(isGameOver):
			background_rotation *= 0.95
			gameOverSpeedMultiplier *= 0.995
			speedControler.gameSpeed *= gameOverSpeedMultiplier
		
		
		speedControler.step()
	
	
	
	
func _input(event):
	
	
	if (event.is_action_released("ui_cancel")):
		if ui_hidden:
			old_gameSpeed = speedControler.gameSpeed
			speedControler.gameSpeed = 0.0
			ui.show()
		else:
			ui.hide()
			speedControler.gameSpeed = old_gameSpeed
		ui_hidden = !ui_hidden

func _on_Player_playerHit(player,area):
	if(isGameOver):
		return
	if(area == $External_barrier):
		print("Hit the barrier")
		isGameOver = true
	elif(area.is_type("Collectible")):
		area.queue_free()
		print("Picked up a collectible")
		score+=1
	elif(area.is_type("Ball")):
		print("Hit a ball")
		area.change_color(Color(255,255,255))
		isGameOver = true
	else:
		print("Hit an unknown element")
	

func initialize_childs():
	var windowSize = get_viewport().get_visible_rect().size
	player.position = Vector2(windowSize.x/8,windowSize.x/2)
	center.position = windowSize/2
	speedControler.gameSpeed = 1.0


func create_childs():
	pass
	player = load("res://PlayerCharacter.tscn").instance()
	add_child(player)
	player.connect("playerHit",self,"_on_Player_playerHit")
	
	speedControler = load("res://GameSpeedControler.gd").new()
	speedControler.registerMovingElement(player)
	
	center = preload("res://Center.tscn").instance()
	center.player = player
	center.speedControler = speedControler
	add_child(center)
	
	$External_barrier.connect("collide", center, "_on_External_barrier_collide")
	speedControler.registerMovingElement($Background)

func clean_childs():
	player.clean()
	center.clean()
	
func _on_Button_pressed():
	get_tree().quit()


func _on_Button3_pressed():#restart
	#get_tree().reload_current_scene()
	clean_childs()
	#_on_Button2_pressed()
	ui.hide()
	ui_hidden = true
	started = true
	isGameOver = false
	gameOverSpeedMultiplier = 1
	score = 0
	initialize_childs()


func _on_Button2_pressed():#start
	get_node("UI/StartPanel/VBoxContainer/HBoxContainer/Button3").show()
	get_node("UI/StartPanel/VBoxContainer/HBoxContainer/Button2").hide()
	ui.hide()
	ui_hidden = true
	started = true
	create_childs()
	initialize_childs()
