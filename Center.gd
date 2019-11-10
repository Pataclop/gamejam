extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var angle
var player
var speedControler#:GameSpeedControler
var ballFactory
var collectiblesFactory
var collectiblesCount = 0
var doesPlayerTargetNeedToBeDeleted = false
var baseScale
var pulseUp = true
var pulseRatio = 1.005

	
#TEST ENUM
enum anchor_variants {RED, GREEN, BLUE}

	

#constructor
func _init():
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var s = get_node("Sprite")
	baseScale = s.scale
	
	speedControler.registerMovingElement($ParticleScript)
	speedControler.registerMovingElement($TimerScript)

	

	ballFactory = load("res://MovingObjectFactory.gd").new(Vector2(0,0))
	collectiblesFactory = load("res://CollectibleFactory.gd").new(Vector2(0,0))
	
	
	player.connect("targetChanged",self,"_on_Player_target_change")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speedControler.gameSpeed != 0.0:
		if pulseUp:
			var centerSprite = get_node("Sprite")
			centerSprite.scale = centerSprite.scale*pulseRatio*speedControler.gameSpeed
		else:
			var centerSprite = get_node("Sprite")
			centerSprite.scale = centerSprite.scale/pulseRatio*speedControler.gameSpeed


func get_variant():
	var amount_variants = len(anchor_variants)
	return rng.randi_range(0, amount_variants-1)


func build_ball(new_ball):
	
	var anchor_variant = get_variant()
	
	new_ball.anchor_variant = anchor_variant
	new_ball.position = position
	new_ball.direction = rng.randf_range(0.0, 6.3)
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
	pulseUp = !pulseUp
	collectiblesCount += 1
	if collectiblesCount % 4 ==0:
		var new_collectible = collectiblesFactory.get_random()
		add_child(new_collectible)
		speedControler.registerMovingElement(new_collectible)
	#new_ball = build_ball(new_ball)
	var new_ball = ballFactory.get_random()
	
	add_child(new_ball)
	new_ball.connect("is_clicked",player,"_on_Target_is_clicked")
	speedControler.registerMovingElement(new_ball)
	
	#print(len(get_children()))
	
func _on_Player_target_change(oldTarget,newTarget):
	if(doesPlayerTargetNeedToBeDeleted):
		doesPlayerTargetNeedToBeDeleted = false
		oldTarget.queue_free()
	
func _on_External_barrier_collide(area):
	
	var isBall:bool = false
	for ball in self.get_children():
		if (ball == area):
			isBall=true
			print("ball !")
			#speedControler.unregisterMovingElement(ball)
			if(player.hasATarget() && player.target.get_ref() == ball):
				doesPlayerTargetNeedToBeDeleted = true
			else:
				ball.queue_free()
			
			#self.remove_child(ball)
			# ball.queue_free() #we can't use that because the player save a ball
	if(! isBall):
		print("aww, no ball")
	pass # Replace with function body.



