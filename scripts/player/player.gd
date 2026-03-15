class_name Player extends CharacterBody2D

@onready var animation: AnimationPlayer = $Animation
@onready var sprite: Sprite2D = $Sprite
@onready var label: Label = $Label

var move_speed : float  = 35.0
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"
var cardinal_direction : Vector2 = Vector2.DOWN

func _ready() -> void:
	print("ready!")
	label.text = state
	pass

func _process(_delta):
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = direction * move_speed
	
	Run()
	
	if SetState() == true || SetDirection() == true :
		UpdateAnimation()
	
	pass
	
func _physics_process(_delta):
	move_and_slide()
	
	pass
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0 :
		if direction.x < 0:
			new_dir = Vector2.LEFT
		else:
			new_dir = Vector2.RIGHT
	if direction.x == 0 :
		if direction.y < 0:
			new_dir = Vector2.UP
		else:
			new_dir = Vector2.DOWN
			
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	return true
	
func SetState() -> bool:
	var new_state : String = "idle" 
	
	if direction == Vector2.ZERO:
		new_state = "idle" 
	#elif direction != Vector2.ZERO && Input.is_action_pressed("run"):
		#new_state = "run"
	else:
		new_state = "walk"
	
	if new_state == state:
		return false
	state = new_state
	label.text = state
	return true
	
func UpdateAnimation() -> void:
	animation.play("anim_asha_"+ state + "_" + AnimationDirection())
	pass
	
func AnimationDirection() -> String:
	#
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		return ""

func Run():
	#i dont think this is how u should implement it
	if Input.is_action_pressed("run") && direction != Vector2.ZERO:
		move_speed = 75.0
		animation.speed_scale = 2.2
	else:
		move_speed = 35.0
		animation.speed_scale = 1
