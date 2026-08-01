extends CharacterBody3D

signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_direction: Vector3)

@export var movement_states : Dictionary

var movement_direction : Vector3

func _ready():
	set_movement_state.emit(movement_states["idle"])

func _input(event):
	if event.is_action("movement"):
		# Whenever an action is pressed the strength becomes 1
		movement_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		movement_direction.z = Input.get_action_strength("Back") -  Input.get_action_strength("Forward")
		
		# Adding movement animations go here
		if is_movement_ongoing():
			#if Input.is_action_pressed("movement"):
			set_movement_state.emit(movement_states["walk"])
		else:
			set_movement_state.emit(movement_states["idle"])
			
func _physics_process(delta):
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)

func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
