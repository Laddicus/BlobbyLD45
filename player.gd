extends KinematicBody2D

export (int) var speed = 200
var size = 1
onready var sprite = get_node("./Sprite")
onready var collision = get_node("./CollisionShape2D")
signal gameOver

var velocity = Vector2()


func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)

func _process(delta):
	if size < .5:
		emit_signal("gameOver")
		print("You lose")

func _on_enemy_hit(enemySize):
	print("Hit")
	print(enemySize)
	if(enemySize<size):
		size = size + enemySize/10
	else:
		size = size - enemySize/10
	
	sprite.set_scale(Vector2(size,size))
	collision.set_scale(Vector2(size,size))
