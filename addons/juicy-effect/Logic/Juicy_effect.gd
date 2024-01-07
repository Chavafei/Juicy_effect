@icon("../icons/juicy_effect_icon.svg")
extends Node
class_name Juicy_effect
signal on_play()
signal on_stop()
@export var active : bool = true
var playing : bool = false
# check if this Juicy effect will play or not


@export_group("Timing")

@export var stopper : bool 
# if this is true, the juicy effect after this effect will have to wait for this effect to finish first before continue.
# finishing is when stop_play() is called

@export var initial_delay : float = 0.0
# the delay before playing this juicy effect

@export var duration : float = 1.0
# the duration of this play, Some effects will use this. 

@export var loop : bool
@export var loop_infinite : bool # will loop infinitely
@export var loop_amount : int
var curloop : int

var curDuration : float


func _ready():
	Initialize();

func Play():
	if !active : return
	curloop = 0
	curDuration = 0.0; 
	Pre_Enter()
	if initial_delay > 0.0 :
		await get_tree().create_timer(initial_delay).timeout
	
	on_play.emit()
	Play_Enter()
	playing = true
	pass

func Stop() :
	stop_play(true)
	

func _physics_process(delta):

	if playing :
		Play_Physic_Process()
		curDuration += delta
		if(curDuration >= duration):
			stop_play()

func _process(delta):
	if playing :
		Play_Process()
		
		


#this is called when you want to end the play
func stop_play(ignoreloop : bool = false):

	
	on_stop.emit()
	Play_Exit()
	
	curloop += 1
	if loop :
		if loop_amount > curloop or loop_infinite:
			
			curDuration = 0.0
			Play_Enter()
			return
			
	playing = false
		
	
	
##### Down here are function that will be override, Idk how to mark a function to not be overrideable
 # this will call right away when the scene start
func Initialize():
	pass
	
 # this will call right away regardless of delay
func Pre_Enter():
	pass

# this will call when the effect start playing
func Play_Enter(): 
	pass
 
func Play_Physic_Process():
	pass
	
func Play_Process():
	pass
	
 # this will call when the effect stop playing
func Play_Exit(): 
	pass
 
##### Up here are function that will be override, Idk how to mark a function to not be overrideable

