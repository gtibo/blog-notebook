@tool
extends Node2D

@onready var foot_sprite_l = %FootSpriteL
@onready var foot_sprite_r = %FootSpriteR
@onready var body_sprite = %BodySprite
@onready var beak_sprite = %BeakSprite
@onready var face_sprite_group = %FaceSpriteGroup
@onready var anchors = [%FootAnchorL, %FootAnchorR, %BodyAnchor, %EyesAnchor, %BeakAnchor, body_sprite, beak_sprite]
@onready var animation_tree : AnimationTree = %AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

@export_range(0.0, 360.0, 0.1, "radians") var direction : float = 0.0 : set = _set_direction

const HALF_PI : float = PI / 2.0
var move_speed : float = 1.0 : set = _set_move_speed

func _set_direction(value : float):
	if !is_inside_tree(): return
	direction = value

	var angle = wrapf(direction, 0.0, TAU)
	
	for anchor in anchors:
		anchor.rotation = angle

	foot_sprite_l.rotation = angle + 0.5
	foot_sprite_r.rotation = angle - 0.5

	var z_index_value = -1 if angle > HALF_PI and angle < PI + HALF_PI else 1
	
	face_sprite_group.z_index = z_index_value
	body_sprite.z_index = 1.0 - z_index_value

func _set_move_speed(value : float):
	move_speed = value
	animation_tree.set("parameters/StateMachine/move/MoveSpeed/scale", move_speed)

func set_state(state : String):
	state_machine.travel(state)
