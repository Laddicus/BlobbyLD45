extends Area2D

var velocity
var direction

var enemyID

signal playerShot(enemyID)

# Called when the node enters the scene tree for the first time.
func _ready():
	direction =  get_global_mouse_position() - get_position()
	velocity = direction.normalized() * 250
	$Timer.set_wait_time(0.8*get_parent().get_node("player").size)
	print(0.8*get_parent().get_node("player").size)
	print(get_parent().get_node("player").size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	set_position(get_position()+velocity*delta)


func _on_playerShot_body_entered(body):
	pass


func _on_Timer_timeout():
	queue_free()


func _on_playerShot_area_entered(area):
	enemyID = area.get_instance_id()
	emit_signal("playerShot", enemyID)

func _damage(damage):
	pass
