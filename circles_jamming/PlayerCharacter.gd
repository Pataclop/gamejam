extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target
var speed
var t = 0
var length
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if typeof(target) == 17:
		t = t + delta/2
		speed = target.speed
		var targetPos = target.position
		var pos = targetPos - target.dist_to_center/2
		position = Vector2(pos[0]+cos(t) *  length, pos[1]+sin(t)*length)
	
	var sprite = get_node("Sprite")
	sprite.position = position
	
func _on_Target_is_clicked(elementClicked):
	if typeof(elementClicked) == 17: #it's an anchor
		target = elementClicked
		var targetPos = target.position
		var pos = targetPos - target.dist_to_center/2
		length = sqrt(pow((targetPos[0] - position[0]),2) + pow((targetPos[1]-position[1]),2))
	pass