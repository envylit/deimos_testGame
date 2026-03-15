class_name State_Idle extends State

@onready var walk: State = $"../Walk"
@onready var label: Label = $"../Label"

# what happens when player enter this state
func Enter() -> void:
	player.UpdateAnimation("idle")
	label.text = "idle"
	pass # Replace with function body.
	
# what happens when player exit this state
func Exit() -> void:
	pass
	
#what happens during _process update in this state
func Process (_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
#what happens during _physics_process update in this state
func Physics (_delta : float) -> State:
	return null
	
#what happens with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
