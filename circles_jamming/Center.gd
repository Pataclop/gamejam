extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var angle
var player
var speedControler#:GameSpeedControler

var anchor_variants = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var s = get_node("Sprite")
	s.position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_variant():
	var variant_key = rng.randi_range(0, len(anchor_variants)-1)
	return anchor_variants[variant_key]
	

func _on_Timer_timeout():	
	angle = rng.randf_range(0.0, 6.3)
	var new_ball = preload("res://Ball.tscn").instance()
	new_ball.position = position
	new_ball.direction = angle
	new_ball.player = player
	new_ball.angular_speed = (rng.randf()-0.5)/5
	
	# On a besoin de récupérer 1 fois ces données
	if(anchor_variants==null):
		anchor_variants = new_ball.anchor_variants.keys()
	
	new_ball.anchor_variant = get_variant()
	
	
	add_child(new_ball)
	new_ball.connect("is_clicked",$PlayerCharacter,"_on_Target_is_clicked")
	speedControler.registerMovingElement(new_ball)

