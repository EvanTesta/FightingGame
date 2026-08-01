extends Node3D
class_name HealthComponent

@export var MAX_HEALTH : float
var health: float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent_node_3d().queue_free()
