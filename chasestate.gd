extends State

@export var fleeRange : float = 1.0
@export var looseInterestRange : float = 20.0

var pathUpdateRate : float = 0.1
var lastPathUpdateTime : float

func enter():
	super.enter()
	controller.isRunning = true
	controller.lookAtPlayer = true

func exit():
	super.exit()
	controller.isRunning = false
	controller.lookAtPlayer = false

func update(delta):
	var currentTime = Time.get_unix_time_from_system()
	
	if currentTime - lastPathUpdateTime > pathUpdateRate:
		lastPathUpdateTime = currentTime
		controller._move_to_position(controller.player.position, false)
	
	if controller.playerDistance < fleeRange:
		stateMachine.change_state("Flee")
	
	if controller.playerDistance > looseInterestRange:
		stateMachine.change_state("Wonder")
