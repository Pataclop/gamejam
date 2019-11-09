extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var angle
var player
var speedControler#:GameSpeedControler

	
#TEST ENUM
enum anchor_variants {RED, GREEN, BLUE}

	

# Called when the node enters the scene tree for the first time.
func _ready():
	var s = get_node("Sprite")
	s.position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_variant():
	var amount_variants = len(anchor_variants)
	return rng.randi_range(0, amount_variants-1)


func build_ball(new_ball):
	
	var anchor_variant = get_variant()
	
	new_ball.anchor_variant = anchor_variant
	new_ball.position = position
	new_ball.direction = rng.randf_range(0.0, 6.3)
	new_ball.player = player
	new_ball.angular_speed = (rng.randf()-0.5)/5
	
	if(anchor_variant == anchor_variants.RED):
		new_ball.color = Color(1, 0, 0)
		pass
		
	if(anchor_variant == anchor_variants.GREEN):
		new_ball.color = Color(0, 1, 0)
		pass
		
	if(anchor_variant == anchor_variants.BLUE):
		new_ball.color = Color(0, 0, 1)
		pass
		
	else:
		pass
	
	new_ball.modulate = new_ball.color
	
	return new_ball
	

func _on_Timer_timeout():	

	var new_ball = preload("res://Ball.tscn").instance()
	

	new_ball = build_ball(new_ball)
	

	
	
	# Choisir un élément selon l'enum
	
	#print(amount_variants)


	
	

	
	
	# On a besoin de récupérer 1 fois ces données
	#if(anchor_variants==null):
		#anchor_variants = new_ball.anchor_variants.keys()
	
	# TODO typage de l'ancre
	#new_ball.anchor_variant = get_variant()
	
	
	add_child(new_ball)
	new_ball.connect("is_clicked",$PlayerCharacter,"_on_Target_is_clicked")
	speedControler.registerMovingElement(new_ball)

