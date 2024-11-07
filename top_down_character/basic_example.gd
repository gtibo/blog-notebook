extends Node2D

@onready var point_anchor = %PointAnchor

func _ready():
	var t = create_tween().set_loops(0)
	t.tween_property(point_anchor, "rotation_degrees", 360.0, 2.0).from(0.0)
