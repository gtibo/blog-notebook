@tool
extends Line2D

@export var target_nodes : Array[Node2D]

func _ready():
	points.resize(target_nodes.size())
	_compute_points()

func _process(_delta):
	_compute_points()

func _compute_points():
	for i in target_nodes.size():
		points[i] = target_nodes[i].global_position
