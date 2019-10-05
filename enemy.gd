extends Area2D
var enemySize = 1
onready var sprite = get_node("./Sprite")
onready var collision = get_node("./CollisionShape2D")
signal hit(enemySize)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = get_parent().get_node("player").size
	enemySize = rand_range(x - 0.7, x + 1.5)
	sprite.set_scale(Vector2(enemySize,enemySize))
	collision.set_scale(Vector2(enemySize,enemySize))
	
	#connect("hit", $player, "_on_enemy_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_enemy_body_entered(body):
	print("hit ", enemySize)
	emit_signal("hit", enemySize)
	queue_free()
