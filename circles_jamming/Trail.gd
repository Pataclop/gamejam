extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var point
var pos = Vector2(0.25, 0.25)
var center = pos * OS.window_size
var trailLength = 100

var init_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	point=global_position
	add_point(point)
	
	# Supprimer les 2 points random qui créent un début de trail
	init_counter = init_counter + 1
	#print(init_counter)
	if(init_counter < 2):
		remove_point(0)
	
	var cmp = get_point_count ()
	
	for x in range (cmp):
		var pos=get_point_position (x)
		#if (pos[0]<-100 or pos[0]>2000 or pos[1]<-100 or pos[1]>2000):
		#	remove_point(x)
		
		set_point_position (x,pos+((pos-center)/1000))
		

	while(get_point_count()>trailLength):
		remove_point(0)
