extends CharacterBody2D


const SPEED = 300.0
@export var number_of_hearts: int = 5
var direction: Vector2i = Vector2i.ZERO

signal game_over_decay

signal game_over_eaten
signal game_over_symbiosis

var UIHeart = preload("res://UIHeart.tscn")
@onready var reference_heart = %HeartsUI/HBoxContainer/UIHeart

var hearts = []

func _ready():
	# Use heart in editor for reference, but keep it around.
	reference_heart.get_parent().remove_child(reference_heart)
	for __ in range(number_of_hearts):
		add_heart()
	# last heart should start decaying
	hearts[number_of_hearts - 1].start_decaying()
	

# add a heart to the UI & to the player
func add_heart():
	var heart = UIHeart.instantiate()
	heart.decay_times = reference_heart.decay_times
	heart.decay_timeout_seconds = reference_heart.decay_timeout_seconds
	heart.fade_duration = reference_heart.fade_duration
	heart.broken.connect(self.next_heart)
	
	%HeartsUI/HBoxContainer.add_child(
		heart
	)
	hearts.append(heart)

# called every time a heart decay timer times out
func next_heart():
	var broken = hearts.pop_back()
	broken.queue_free()
	if (len(hearts) > 0):
		hearts[-1].start_decaying()
	else:
		# last heart has decayed
		game_over_decay.emit()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var action_directions = {
		"movement_down": Vector2i.DOWN,
		"movement_up": Vector2i.UP,
		"movement_left": Vector2i.LEFT,
		"movement_right": Vector2i.RIGHT,
	}
	
	direction = Vector2i.ZERO
	for action in action_directions:
		if Input.is_action_pressed(action):
			direction = action_directions[action]
	
	if direction.length_squared() != 0:
		velocity = direction * SPEED
	move_and_slide()


# Want to:
# - Tick down a heart timer
# - Indicate decay visually (easy through colorrects)
# - On timeout, remove left- or rightmost heart
# - Also have a game over condition
