extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = null
var t
var length
var clockwise
var attraction = 0.998


var doUseRightClic: bool = true

var baseAngularSpeed=PI/300
#var normalColor = Color(1,1,1)
var selectedColor = Color(0.1, 0.1, 0.1)


func _ready():
	t = 0
	length = 0
	clockwise = true
	
	

func stepForward(gameSpeed:float):
	var delta = baseAngularSpeed * gameSpeed
	if typeof(target) == 17:
		if clockwise:
			t = t + delta
		else:
			t = t - delta
		length=length*(1-(1-attraction)*gameSpeed)
		var pos = target.position - target.dist_to_center/2#//TODO wtf ???
		position = Vector2(pos[0]+cos(t) *  length, pos[1]+sin(t)*length)
		
	var sprite = get_node("Sprite")
	sprite.position = position
	
	
func _input(event):
	
	if event is InputEventMouseButton:
		var changeMagnitude = 0.97
		if event.button_index == BUTTON_WHEEL_UP:
			length = length * (1/changeMagnitude)
		if event.button_index == BUTTON_WHEEL_DOWN:
			length = length * changeMagnitude


func _on_Target_is_clicked(elementClicked, isClockwise):
	if typeof(elementClicked) == 17: #it's an anchor
		if(target == elementClicked):
			return
	

	
		var hasATarget:bool = target!=null
	
	
		if(hasATarget):
			
			if( ! doUseRightClic):
				var vectorToTarget:Vector2 = target.position - self.position
				var normalToTarget = Vector2(-vectorToTarget.y,vectorToTarget.x)
				#//TODO retirer le clockwise (produit scalaire)
				var vectorToNewTarget:Vector2 = elementClicked.position - self.position
				isClockwise = normalToTarget.dot(vectorToNewTarget) > 0
			
			target.color(target.color)
		
		clockwise = isClockwise
		target = elementClicked
		
		target.color(selectedColor)
		var pos = target.position - target.dist_to_center/2
		length = sqrt(pow((pos[0] - position[0]),2) + pow((pos[1]-position[1]),2))
		t = atan2(pos[1]-position[1], pos[0] - position[0]) + PI
		#print(t)
