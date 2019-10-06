extends KinematicBody2D

export (int) var speed = 200
var size = 1
var shoot = 0
var shootCooldown = 0
var shotTarget
var sprint = 0
var armour = 0
var score = 0

onready var sprite = get_node("./AnimatedSprite")
onready var collision = get_node("./CollisionShape2D")
var loseScreen_resource = preload("res://loseScreen.tscn")

var playerShot_resource = preload("res://playerShot.tscn")
var playerShot

signal gameOver(score)

var velocity = Vector2()


func get_input():
	if Input.is_action_just_pressed('ui_right'):
		sprite.set_rotation(deg2rad(270))
	if Input.is_action_just_pressed('ui_left'):
		sprite.set_rotation(deg2rad(90))
	if Input.is_action_just_pressed('ui_down'):
		sprite.set_rotation(deg2rad(0))
	if Input.is_action_just_pressed('ui_up'):
		sprite.set_rotation(deg2rad(180))
	
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 2
		sprite.set_rotation(deg2rad(270))
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 2
		sprite.set_rotation(deg2rad(90))
	if Input.is_action_pressed('ui_down'):
		velocity.y += 2
		sprite.set_rotation(deg2rad(0))
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 2
		sprite.set_rotation(deg2rad(180))
	velocity = velocity.normalized() * speed
	
	
	if Input.is_action_pressed('ui_accept') and shootCooldown == 0:
		shootCooldown = 10
		if shoot == 0:
			print("No ammo")
		else:
			playerShot = playerShot_resource.instance()
			var pos = self.get_position()
			playerShot.set_position(pos)
			get_parent().add_child(playerShot)
			playerShot.connect("playerShot", self, "_on_playerShot")
			
			shoot = shoot - 1
	
	if Input.is_action_pressed("ui_shift") and sprint > 0:
		speed = 400
		sprint = sprint - 1
		print(sprint)
	if Input.is_action_just_released("ui_shift") or sprint == 0:
		speed = 200
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _process(delta):
	if size < .5:
		connect("gameOver", get_parent().get_parent(), "_game_over")
		emit_signal("gameOver", score)
		print("You lose")
		
		
		
		
	
	if shootCooldown>0:
		shootCooldown = shootCooldown - 1
	
	$Camera2D.set_zoom(_lerp($Camera2D.get_zoom(), Vector2(size,size), 0.1))
	

func _on_enemy_hit(enemySize, enemyID, enemyType):
	print("Size: ",enemySize)
	print("Type: ",enemyType)
	if(enemySize<size):
		size = size + enemySize/10
		instance_from_id(enemyID).queue_free()
	else:
		size = size - enemySize/10
	
	_change_size(size)
	
	if enemyType == "shoot":
		shoot = shoot + 10
	elif enemyType == "sprint":
		sprint = sprint + 10
	
	
func _on_shot(damage):
	print("ouch ", damage)
	size = size - damage
	_change_size(size)

func _change_size(x):
	sprite.set_scale(Vector2(x,x))
	collision.set_scale(Vector2(x,x))
	
	var temp = (size)*10
	if temp > score:
		score = temp
	get_node("score").set_text(str(score))
	print("Score: ", score)
	#var zoom = lerp($Camera2D.get_zoom(), Vector2(x,x), 0.5)
	#$Camera2D.set_zoom(zoom)

func _on_playerShot(enemyID):
	shotTarget = enemyID
	if enemyID != self.get_instance_id():
		instance_from_id(enemyID)._damage(0.1)

func _lerp(f, t, w):
	return lerp(f, t, w)