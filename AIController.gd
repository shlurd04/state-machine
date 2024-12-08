class_name AIController
extends CharacterBody3D

@export var walkSpeed : float = 1.0
@export var runSpeed : float = 5.0

var isRunning : bool = false
var isStopped : bool = false
var lookAtPlayer : bool = false

var moveDir : Vector3
var targetYRot : float

@onready var agent : NavigationAgent3D = get_node("NavigationAgent3D")
@onready var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player = get_tree().get_nodes_in_group("Player")[0]

var playerDistance : float

func _process(_delta: float) -> void:
	if player != null:
		playerDistance = position.distance_to(player.position)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var targetPos = agent.get_next_path_position()
	moveDir = position.direction_to(targetPos)
	moveDir.y = 0
	moveDir = moveDir.normalized()
	
	if agent.is_navigation_finished() or isStopped:
		moveDir = Vector3.ZERO
	
	var currentSpeed = walkSpeed
	
	if isRunning:
		currentSpeed = runSpeed
	
	velocity.x = moveDir.x * currentSpeed
	velocity.z = moveDir.z * currentSpeed
	
	move_and_slide()
	
	if lookAtPlayer:
		var playerDir = player.position - position
		targetYRot = atan2(playerDir.x, playerDir.z)
	elif velocity.length() > 0:
		targetYRot = atan2(velocity.x, velocity.z)
	
	rotation.y = lerp_angle(rotation.y, targetYRot, 0.1)

func _move_to_position(toPos : Vector3, adjustPos : bool = true):
	if not agent:
		agent = get_node("NavigationAgent3D")
	
	isStopped = false
	
	if adjustPos:
		var map = get_world_3d().navigation_map
		var adjustedPos = NavigationServer3D.map_get_closest_point(map, toPos)
		agent.target_position = adjustedPos
	else:
		agent.target_position = toPos
		
