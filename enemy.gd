extends Area2D
var enemySize = 1
var enemyID
var enemyType
var speed = 50
var directionChangeTime = 10
onready var sprite = get_node("./AnimatedSprite")
onready var collision = get_node("./CollisionShape2D")
signal hit(enemySize, enemyID, enemyType)
var velocity = Vector2(0, 0)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = get_parent().get_node("player").size
	enemySize = rand_range(x - 0.7, x + 2)
	sprite.set_scale(Vector2(enemySize,enemySize))
	collision.set_scale(Vector2(enemySize,enemySize))
	speed = enemySize * 50
	enemyID = get_instance_id()
	
	# Generate random direction and time 
	_on_directionTimer_timeout()
	#velocity = Vector2(rand_range(-50,50),rand_range(-50,50)).normalized() * speed
	
	#connect("hit", $player, "_on_enemy_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	set_position(get_position()+velocity*delta)


func _on_enemy_body_entered(body):
	
	var playerID = get_parent().get_node("player").get_instance_id()
	if body.get_instance_id() == playerID:
		print("Hit player, enemy")
		emit_signal("hit", enemySize, enemyID, enemyType)
		#queue_free()
	#else:
		#print("Hit enemy, enemy")
		#queue_free()


func _on_directionTimer_timeout():
	$directionTimer.set_wait_time(rand_range(1, directionChangeTime))
	velocity = Vector2(rand_range(-50,50),rand_range(-50,50)).normalized() * speed
	
	if abs(velocity.x) > abs(velocity.y):
		sprite.set_rotation(deg2rad(90))
		if velocity.x > 0:
			sprite.set_flip_v(true)
		else:
			sprite.set_flip_v(false)
	else:
		sprite.set_rotation(deg2rad(0))
		if velocity.y < 0:
			sprite.set_flip_v(true)
		else:
			sprite.set_flip_v(false)
	
		

func _damage(damage):
	enemySize = enemySize - damage
	sprite.set_scale(Vector2(enemySize,enemySize))
	collision.set_scale(Vector2(enemySize,enemySize))
	
	if enemySize < 0.5:
		queue_free()


func _on_lifeTimer_timeout():
	queue_free()
