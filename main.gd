extends Node2D
var enemyBasic_resource = preload("res://enemyBasic.tscn")
var enemyBasic
var enemyShoot_resource = preload("res://enemyShoot.tscn")
var enemyShoot
var enemySprint_resource = preload("res://enemySprint.tscn")
var enemySprint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_spawnTimer_timeout():
	var type = randi()%4+1
	if type == 1:
		enemyBasic = enemyBasic_resource.instance()
		var pos = $spawner.get_position()
		enemyBasic.set_position(pos)
		self.add_child(enemyBasic)
		enemyBasic.connect("hit", $player, "_on_enemy_hit")
	elif type == 2:
		enemyShoot = enemyShoot_resource.instance()
		var pos = $spawner.get_position()
		enemyShoot.set_position(pos)
		self.add_child(enemyShoot)
		enemyShoot.connect("hit", $player, "_on_enemy_hit")
	elif type == 3:
		enemySprint = enemySprint_resource.instance()
		var pos = $spawner.get_position()
		enemySprint.set_position(pos)
		self.add_child(enemySprint)
		enemySprint.connect("hit", $player, "_on_enemy_hit")
	if ($spawnTimer.get_wait_time() > 0.1):
		$spawnTimer.set_wait_time($spawnTimer.get_wait_time() - 0.005)
