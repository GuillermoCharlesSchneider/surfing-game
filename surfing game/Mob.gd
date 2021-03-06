
signal squashed

extends KinematicBody

# Minimum speed of the mob in meters per second.
export var min_speed = 10
# Maximum speed of the mob in meters per second.
export var max_speed = 20

var velocity = Vector3.ZERO


func _physics_process(_delta):
	move_and_slide(velocity)
	
func initialize(start_position, player_position):
	translation = start_position
	# We turn the mob so it looks at the player.
	look_at(player_position, Vector3.UP)
	# And rotate it randomly so it doesn't move exactly toward the player.
	rotate_y(rand_range(-PI / 4, PI / 4))	
	
	var random_speed = rand_range(min_speed, max_speed)
	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the vector based on the mob's Y rotation to move in the direction it's looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func _on_VisibilityNotifier_screen_exited():
	queue_free() # Replace with function body.
	
	
func squash():
	emit_signal("squashed")
	queue_free()
