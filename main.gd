extends Node2D
export (PackedScene) var Enemy
var enemy_resource = preload("res://enemy.tscn")
var enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	enemy = enemy_resource.instance()
	var x = rand_range(0, 1250)
	var y = rand_range(0, 1250)
	enemy.set_position(Vector2(x,y))
	self.add_child(enemy)
	enemy.connect("hit", $player, "_on_enemy_hit")