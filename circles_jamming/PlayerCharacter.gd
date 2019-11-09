extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target
var speed
var t
var length
var clockwise
	
var old_anchor = null

func _ready():
	t = 0
	length = 0
	clockwise = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if typeof(target) == 17:
		if clockwise:
			t = t + delta/2
		else:
			t = t - delta/2
		speed = target.speed
		var targetPos = target.position
		var pos = targetPos - target.dist_to_center/2
		position = Vector2(pos[0]+cos(t) *  length, pos[1]+sin(t)*length)
	
	var sprite = get_node("Sprite")
	sprite.position = position
	
func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			length = length *1.03
		if event.button_index == BUTTON_WHEEL_DOWN:
			length = length *0.97


func _on_Target_is_clicked(elementClicked, isClockwise):
	if typeof(elementClicked) == 17: #it's an anchor
	
		if(old_anchor == null):
			old_anchor = elementClicked
			
		print(old_anchor, elementClicked)
		
		#old_color = Color(1,1,1)
		#new_color = Color(1,1,1)
		#elementClicked.color()
		
		
		old_anchor = elementClicked
		
		clockwise = isClockwise
		target = elementClicked
		var targetPos = target.position
		var pos = targetPos - target.dist_to_center/2
		length = sqrt(pow((pos[0] - position[0]),2) + pow((pos[1]-position[1]),2))
		t = atan2(pos[1]-position[1], pos[0] - position[0]) + PI
		print(t)
