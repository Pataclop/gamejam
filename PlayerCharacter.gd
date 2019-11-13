extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isClicked = false
var target = null
const startingSpeed = 0.7

var t
var length
var clockwise
var timeSinceClicked =0


var doUseRightClic: bool = true #alternate control sheme

const baseAngularSpeed=PI/300
var clickSpeed = 0
var speed = baseAngularSpeed
#var normalColor = Color(1,1,1)
const selectedColor = Color(0.1, 0.1, 0.1)

signal targetChanged
signal playerHit

func clean():
	isClicked = false
	t = 0
	length = 0
	clockwise = true
	target = null
	timeSinceClicked = 0
	clickSpeed = 0
	$Trail.get_node("Trail").clean()
	
func hasATarget()->bool:
	return target != null && target.get_ref()

func _draw():
	if(hasATarget()):
		var targetPosInLocal = to_local(target.get_ref().to_global(Vector2(0,0)))
		var dist = (targetPosInLocal).length()
		#print(dist)
		var thickness = clamp(2000/dist,0.5,20)
		draw_line(Vector2(0,0), targetPosInLocal, Color(1, 0, 0, 0.4), thickness)
	pass

func _ready():
	t = 0
	length = 0
	clockwise = true
	
	

func stepForward(gameSpeed:float):
	if(target==null):
		position -= position.direction_to(Vector2(0,0)) * startingSpeed * gameSpeed
		pass
	else:
		speed = baseAngularSpeed+clickSpeed
		if isClicked :
			clickSpeed=clickSpeed*1.02
		else :
			clickSpeed = clickSpeed*0.90
		if clickSpeed>10*baseAngularSpeed :
			clickSpeed=10*baseAngularSpeed
		var delta = speed * gameSpeed
		if hasATarget():
			if clockwise:
				t = t + delta 
			else:
				t = t - delta 
			length=length*(1-(1-target.get_ref().attraction)*gameSpeed)
			
			position = Vector2(cos(t) *  length, sin(t)*length) + target.get_ref().global_position
		
	var sprite = get_node("Sprite")
	update()
	
	
func _input(event):
	
	if event is InputEventMouseButton:
		var changeMagnitude = 0.97
		if event.button_index == BUTTON_WHEEL_UP:
			length = length * (1/changeMagnitude)
		if event.button_index == BUTTON_WHEEL_DOWN:
			length = length * changeMagnitude
		if event.button_index == BUTTON_LEFT and event.pressed:
			clickSpeed=baseAngularSpeed
			isClicked = true
		if event.button_index == BUTTON_LEFT and event.pressed==false:
			isClicked=false
		if event.button_index == BUTTON_RIGHT and event.pressed:
			clickSpeed=baseAngularSpeed
			isClicked=true
		if event.button_index == BUTTON_RIGHT and event.pressed==false:
			isClicked = false

func _on_Target_is_clicked(elementClicked, isClockwise):
	if typeof(elementClicked) == 17: #it's an anchor
		if( hasATarget() && target.get_ref() == elementClicked):
			return
	
		if(hasATarget()):
			
			if( ! doUseRightClic):
				var vectorToTarget:Vector2 = target.get_ref().position - self.position
				var normalToTarget = Vector2(-vectorToTarget.y,vectorToTarget.x)
				#//TODO retirer le clockwise (produit scalaire)
				var vectorToNewTarget:Vector2 = elementClicked.position - self.position
				isClockwise = normalToTarget.dot(vectorToNewTarget) > 0
			
			target.get_ref().reset_color()
		
		clockwise = isClockwise
		var oldTarget = target
		target = weakref(elementClicked)
		
		target.get_ref().change_color(selectedColor)
		#var pos = target.get_ref().position - target.get_ref().dist_to_center/2
		#length = sqrt(pow((pos[0] - position[0]),2) + pow((pos[1]-position[1]),2))
		#t = atan2(pos[1]-position[1], pos[0] - position[0]) + PI
		
		print("tgt pos  ",target.get_ref().position)
		print("pos ",self.position)
		var vectToTarget:Vector2 = target.get_ref().global_position - self.global_position
		length = vectToTarget.length()
		print("length ",length)
		t = atan2(-vectToTarget.y,-vectToTarget.x)
		
		
		if(oldTarget == null):
			emit_signal("targetChanged", null, target.get_ref())
		else:
			emit_signal("targetChanged", oldTarget.get_ref(), target.get_ref())
		#print(t)

func _on_PlayerCharacter_area_entered(area):
	self.emit_signal("playerHit",self,area)
