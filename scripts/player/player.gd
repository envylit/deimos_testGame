class_name Player extends CharacterBody2D

@onready var animation: AnimationPlayer = $Animation
@onready var sprite: Sprite2D = $Sprite

var move_speed : float  = 100.0
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

func _ready() -> void:
	print("ready!")
	pass

func _process(_delta):
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = direction * move_speed
	UpdateAnimation()
	pass
	
func _physics_process(_delta):
	move_and_slide()
	pass
	
func SetDirection() -> bool:
	
	return true
	
func SetState() -> bool:
	
	return true
	
func UpdateAnimation() -> void:
	animation.play("anim_asha_idle_down")
	pass
