class_name stateMachine
extends Node

@export var defaultState : State
var currentState : State
var states : Dictionary = {}

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.initialize()
	
	if defaultState != null:
		change_state(defaultState.name)

func change_state(state_name):
	var new_state = states.get(state_name)
	
	if new_state == null:
		return
	
	if new_state == currentState:
		return
	
	if currentState != null:
		currentState.exit()
	
	currentState = new_state
	new_state.enter()
	
	print("Change state" + state_name)

func _process(delta: float) -> void:
	if currentState != null:
		currentState.update(delta)

func _physics_process(delta: float) -> void:
	if currentState != null:
		currentState.physics_update(delta)
		
func _on_navigation_agent_3d_target_reached() -> void:
	if currentState != null:
		currentState.navigation_complete()
