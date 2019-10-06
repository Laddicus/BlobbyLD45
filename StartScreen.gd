extends Node2D

var highScore = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	var next_resource = load("res://main.tscn")
	var current = get_node("Title")
	remove_child(current)
	
	var next = next_resource.instance()
	add_child(next)
	next.get_node("GUI/background/values/highScoreValue").set_text(str(highScore))
	
	print("Pressed")

func _game_over(score):
	if score > highScore:
		highScore = score
	var next_resource = load("res://loseScreen.tscn")
	var current = get_node("main")
	remove_child(current)
	
	var next = next_resource.instance()
	add_child(next)
	next.get_node("values/highScoreValue").set_text(str(highScore))
	next.get_node("values/scoreValue").set_text(str(score))
	next.get_node("TextureButton").connect("pressed", next, "_on_TextureButton_pressed()")
	print("gameover")