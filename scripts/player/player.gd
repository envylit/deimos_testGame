class_name Player extends CharacterBody2D

@onready var animation: AnimationPlayer = $Animation
@onready var sprite: Sprite2D = $Sprite
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction : Vector2 = Vector2.ZERO
var state : String = "idle"
var cardinal_direction : Vector2 = Vector2.DOWN

func _ready() -> void:
	state_machine.Initialize( self ) #player initialize state machine
	pass

func _process(_delta):
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # ( 1/-1 , 0 )
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up") # ( 0 , 1/-1 )
	print(direction)
	pass
	
func _physics_process(_delta):
	move_and_slide() #allows characterbody2d to move around
	pass
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction # which way are you facing?
	
	if direction == Vector2.ZERO: #no function if no change in direction or move input
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
	
func UpdateAnimation( _state : String ) -> void:
	animation.play("anim_asha_"+ _state + "_" + AnimationDirection())
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
