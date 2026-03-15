class_name PlayerStateMachine extends Node

var states : Array[ State ]
var current_state : State
var prev_state : State
var next_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #disable this node, the Player will initialize this node
	process_mode = Node.PROCESS_MODE_DISABLED 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: #can change state on state_x.Process
	ChangeState( current_state.Process( delta ) )
	pass
	
func _physics_process(delta: float) -> void: #can change state on state_x.Physics
	ChangeState( current_state.Physics( delta ) )
	pass
	
func _unhandled_input(event: InputEvent) -> void: #can change state on state_x.HandleInput
	ChangeState( current_state.HandleInput( event ) )

func Initialize( _player : Player ) -> void:
	states = []
	
	for n in get_children(): #get all children on StateMachine Node
		if n is State: #if its a state, then append to array
			states.append(n)
		
		if states.size() > 0: #must have a state, if not then state machine will return error.
			states[0].player = _player
			ChangeState( states[0] )
			process_mode = Node.PROCESS_MODE_INHERIT
	pass

func ChangeState( new_state : State ) -> void: 
	if new_state == null || new_state == current_state: #if no new_state or state doesn't change, do nothing
		return
		
	if current_state: #if there's a change in current state, exit the current state, enter new state
		current_state.Exit()
	
	prev_state = new_state
	current_state = new_state
	current_state.Enter()
