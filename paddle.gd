extends Area2D
export var ball_dir = 1

var centerPosX=100
var centerPosY=100
var width = 0
var heigth = 0
var angle = 0.0
var radius = 0
var center = Vector2(centerPosX,centerPosY)

	
func _draw():
	draw_circle_arc(Vector2(radius,radius), radius, 0, 360, Color(1.0, 1.0, 1.0))
	


func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)
	

func _process(delta):
	width = get_viewport_rect().size[0]
	heigth = get_viewport_rect().size[1]
	radius = width/15
	var which = get_name()
	position.x = centerPosX+radius*cos(angle)
	position.y = centerPosY+radius*sin(angle)
	angle +=0.03
	update()


	
	

	

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
