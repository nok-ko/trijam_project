@tool
extends Node2D

# TEMP DRAWING CODE
func _ready():
	queue_redraw()
	pass # Replace with function body.

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.RED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
