extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()
	pass # Replace with function body.

func _draw():
	draw_circle(0.0, 16, Color.RED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
