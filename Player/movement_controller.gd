extends Node3D

@export var player : CharacterBody3D
@export var mesh_root : Node3D
@export var rotation_speed : float = 8
var direction : Vector3
var velocity : Vector3
var acceleration : float
var speed : float

func _physics_process(delta):
	velocity.x = speed * direction.normalized().x
	velocity.z = speed * direction.normalized().z
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	player.move_and_slide()
	
	# gets the target rotation as an angle
	# player rotation is removed to account of the player's current rotation.
	var target_rotation = atan2(direction.x, direction.z) - player.rotation.y
	# move from the current angle to the target angle at the rotation speed
	# angle is used because of the flip from 359 to 0
	mesh_root.rotation.y = lerp_angle(mesh_root.rotation.y, target_rotation, rotation_speed * delta)

# Take speed and acceleration from Player Node
func _on_set_movement_state(_movement_state : MovementState):
	speed = _movement_state.movement_speed
	acceleration = _movement_state.acceleration

# Take direction from Player Node
func _on_set_movement_direction(_movement_direction : Vector3):
	direction = _movement_direction
