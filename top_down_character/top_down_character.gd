extends Node2D

@onready var duck = %Duck
@onready var dust_particles = %DustParticles

func _process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	var is_sprinting : bool = Input.is_action_pressed("sprint")
	
	position += input.normalized() * (500.0 if is_sprinting else 300.0) * delta
	
	if input:
		duck.direction = rotate_toward(duck.direction,  -atan2(input.x, input.y), 6.0 * delta)
	
	duck.set_state("idle" if input.is_zero_approx() else "move")
	
	var target_move_speed = 1.5 if is_sprinting else 1.0
	
	duck.move_speed = move_toward(duck.move_speed, target_move_speed, 5.0 * delta)
	dust_particles.emitting = is_sprinting
