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
		var ratio = 1-((1-pulseRatio)*speedControler.gameSpeed)
		if pulseUp:
			var centerSprite = get_node("Sprite")
			centerSprite.scale = centerSprite.scale*ratio
		else:
			var centerSprite = get_node("Sprite")
			centerSprite.scale = centerSprite.scale/ratio
	




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



