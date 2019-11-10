extends Node2D

var radius1 = 150
var radius2 = 30

var pause_active = false

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 64
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color,10)



func _draw():
	var center = Vector2(get_viewport().size.x,get_viewport().size.y)/2
	var angle_from = 0
	var angle_to = 360
	var color = Color(0.0, 0.0, 0.0, 0.4)
	draw_circle_arc(center, radius1, angle_from, angle_to, color)
	draw_circle_arc(center, radius2, angle_from, angle_to, color)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	
	if (event.is_action_pressed("ui_pause")):
		pause_active = not pause_active
		#print("Pause : ", pause_active)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	if(not pause_active):
		radius1=radius1*1.005
		radius2=radius2*1.005

	if radius1>820:
		radius1 = 30
	if radius2>820:
		radius2 = 30

	update()
