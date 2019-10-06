extends "res://enemy.gd"

var shot_resource = preload("res://shot.tscn")
var shot

# Called when the node enters the scene tree for the first time.
func _ready():
	enemyType = "shoot"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_shootTimer_timeout():
	if get_parent().get_node("player").get_global_position().distance_to(self.get_global_position()) < 500:
		shot = shot_resource.instance()
		var pos = Vector2(0,0)
		shot.set_position(pos)
		self.add_child(shot)
		shot.connect("shot", get_parent().get_node("player"), "_on_shot")
	
	