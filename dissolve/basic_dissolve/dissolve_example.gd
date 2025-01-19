extends Control

@onready var noise = %Noise
@onready var basic_dissolve = %BasicDissolve
@onready var smooth_dissolve = %SmoothDissolve

func _ready():
	var t = create_tween().set_loops(0)
	t.tween_method(_tween_mask, 0.0, 1.0, 2.0)
	t.tween_method(_tween_mask, 1.0, 0.0, 2.0).set_delay(0.5)
	#t.tween_callback(get_tree().quit)

func _tween_mask(value : float):
	noise.material.set_shader_parameter("dissolve", value)
	basic_dissolve.material.set_shader_parameter("dissolve", value)
	smooth_dissolve.material.set_shader_parameter("dissolve", value)
