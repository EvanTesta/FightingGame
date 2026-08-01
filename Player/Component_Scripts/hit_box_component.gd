extends Area3D

@export var display_time: float
@export var attack_damage : float
@export var knockback_force : float
@export var attack_positon : Vector3
@export var stun_time : float
@export var self_stun: float
@export var collider: CollisionShape3D
@export var self_hurtbox : Area3D
var timer: Timer
var attack: Attack
var attack_active: bool

func _ready():
	timer = $Timer
	timer.wait_time = display_time
	collider.disabled = true
	
	attack = Attack.new()
	attack.attack_damage = attack_damage
	attack.knockback_force = knockback_force
	attack.attack_positon = position
	attack.stun_time = stun_time

func _process(delta):
	if Input.is_action_pressed("Q"):
		timer.start()
		collider.disabled  = false
		visible = true # For testing only
		attack_active = true

func _on_timer_timeout():
	collider.disabled  = true
	attack_active = false
	visible = false # For testing only

func _on_area_entered(area):
	if attack_active and area.has_method("damage") and area != self_hurtbox:
		area.damage(attack)
