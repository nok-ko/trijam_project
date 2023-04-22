extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(position_delta: Vector2i):
	self.position += Vector2(position_delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
