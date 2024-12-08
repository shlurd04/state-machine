class_name State
extends Node

var active : bool
var stateMachine : stateMachine
var controller : AIController
@export_node_path("AIController") var controllerPath : NodePath

func initialize():
	stateMachine = get_parent()
	controller = get_node(controllerPath)

func enter():
	active = true

func exit():
	active = false

func update(delta):
	pass

func physics_update(delta):
	pass

func navigation_complete():
	pass

func randomOffset() -> Vector3:
	var offset = Vector3(randf_range(-1,1), 0, randf_range(-1,1))
	return offset.normalized()
