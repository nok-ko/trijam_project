extends MarginContainer

class_name UIHeart

# times to tick
@export_range(0, 100, 1, "suffix: times") var decay_times: int = 5
# time per tick
@export_range(0, 10, 0.25, 'suffix:s') var decay_timeout_seconds: float = 5
# duration of per fade animation
@export_range(0, 10) var fade_duration: float = 0.2

# is it being decayed right now?
var decaying = false

var decay_timer = null
@onready var INITIAL_COLOR = %UIHeartDisplay.color

signal broken

# times ticked down / current iteration; ticks from 0 to (`decay_times` - 1)
var decay_iteration = 0

# called when the heart should start decaying
func start_decaying():
	decay_timer = get_tree().create_timer(decay_timeout_seconds)
	decay_timer.timeout.connect(tick_down)
	decaying = true

func tick_down():
	decay_iteration += 1
	var tween = get_tree().create_tween()
	tween.tween_property(
		%UIHeartDisplay, 'color', 
		INITIAL_COLOR.darkened(0.2 * decay_iteration),
		clamp(fade_duration, 0, max(decay_timeout_seconds - 1, 0.2))
	)
	
	# decayed all the way?
	if decay_iteration < decay_times:
		#no, heart decays one more time
		decay_timer = get_tree().create_timer(decay_timeout_seconds)
		decay_timer.timeout.connect(tick_down)
	else:
		#yes, heart breaks
		broken.emit()
	
