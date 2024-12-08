extends State

@export var fleeDist : float = 6

func enter():
	super.enter()
	controller.isRunning = true
	Flee()

func exit():
	super.exit()
	controller.isRunning = false
	

func Flee():
	var playerDir = (controller.position - controller.player.position).normalized()
	var movePos = controller.position + playerDir * fleeDist
	controller._move_to_position(movePos)

##BUG##
#goes back to wonder state but stops moving.

func navigation_complete():
	stateMachine.change_state("Wonder")
	
