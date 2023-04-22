extends Node2D


var direction : Vector2i = Vector2i.ZERO

const GRID_SIZE = 32

@onready var segments = [
	self,
	$"../WormBodySegment",
	$"../WormTail"
]

# Called when the node enters the scene tree for the first time.
func _ready():
#	move(Vector2i.LEFT)
	queue_redraw()

func _move(direction):
	self.position += Vector2(direction)

func move(direction: Vector2i):
	# we move in the direction `direction`
	self._move(direction * GRID_SIZE)
	self.direction = direction
	
	# go "backwards" through all the segments and move them, too
	segments.slice(1).reduce(
		func(next, current):
			current.move(
				Vector2i(current.to_local(next.global_position)) #.snapped(Vector2i.ONE * GRID_SIZE)
			)
			return current, 
			self
	)
#	for segment in segments.slice(1):
#		segment.move(direction)
	

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.RED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		move(Vector2i.LEFT)
	pass
