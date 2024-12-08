extends State

var homePos : Vector3

@export var maxWonderRange : float = 6.0
@export var minWaitTime : float = 0.2
@export var maxWaitTime : float = 2.0
@export var chaseRange : float = 4.0

func enter():
	super.enter()
	homePos = controller.position
	newWonderPos()
	
func newWonderPos():
	var pos = homePos + randomOffset() * randf_range(0, maxWonderRange)
	controller._move_to_position(pos)

func navigation_complete():
	var waitTime = randf_range(minWaitTime, maxWaitTime)
	await get_tree().create_timer(waitTime).timeout
	
	if not active:
		return
	
	newWonderPos()

func update(delta):
	if controller.playerDistance < chaseRange:
		stateMachine.change_state("Chase")
