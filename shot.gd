extends Area2D

var velocity
var direction
var damage = 0.1


signal shot(damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	direction =  get_parent().get_parent().get_node("player").get_position() - get_parent().get_position()
	velocity = direction.normalized() * 250

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	set_position(get_position()+velocity*delta)


func _on_shot_body_entered(body):
	if body == get_parent().get_parent().get_node("player"):
		emit_signal("shot", damage)


func _on_deathTimer_timeout():
	queue_free()
	
func _damage(damage):
	queue_free()
