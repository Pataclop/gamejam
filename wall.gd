extends Area2D


func _on_wall_area_entered( area ):
	if area.get_name() == "ball":
		#oops, ball went out of game place, reset
		area.reset()
