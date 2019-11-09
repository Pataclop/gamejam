extends Node

export (PackedScene) var Ball

var player
var speedControler

func _ready():
	player = preload("res://PlayerCharacter.tscn").instance()
	player.position = Vector2(0.05, 0.25) * OS.window_size
	add_child(player)
	
	speedControler = GameSpeedControler.new()
	speedControler.registerMovingElement(player)
	
	var pos = Vector2(0.25, 0.25)
	var center = preload("res://Center.tscn").instance()
	center.position = pos * OS.window_size
	center.player = player
	center.speedControler = speedControler
	add_child(center)
	
	
func _process(delta):
	speedControler.step()
	
func _input(event):
	
	if (event.is_action_released("ui_cancel")):
		get_tree().quit()