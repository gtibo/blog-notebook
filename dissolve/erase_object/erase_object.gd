extends Node3D

@onready var sphere_mesh = %SphereMesh

func _ready():
	var t = create_tween()
	t.tween_property(sphere_mesh.material_override, "shader_parameter/dissolve", 1.0, 2.0).set_delay(0.5)
