extends Area2D
export var ball_dir = 1


var width = get_viewport_rect().size[0]
var heigth = get_viewport_rect().size[1]

var centerPosX=width/2
var centerPosY=heigth/2

var angle = 0.0
var radius = width/5
var center = Vector2(centerPosX,centerPosY)


	
func _process(delta):
	width = get_viewport_rect().size[0]
	heigth = get_viewport_rect().size[1]
	radius = width/15
	var which = get_name()


	
	position.x = centerPosX+radius*cos(angle)-((0.2*100)*cos(angle))
	position.y = centerPosY+radius*sin(angle)-((0.2*100)*sin(angle))#-size[1]/2
	angle +=0.03



	
	

	

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		
		centerPosX = event.position.x
		centerPosY = event.position.y
		center = Vector2(centerPosX,centerPosY)
		
		

	
func _on_area_entered( area ):
	if area.get_name() == "ball":
		# assign new direction
		
		area.direction = Vector2(ball_dir, randf() * 2 - 1).normalized()
