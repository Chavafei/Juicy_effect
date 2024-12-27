extends Juicy_effect

class_name Juicy_effect_playSound

## assign the AudioStreamer that the effect will play
## if none assigned, It will create its own AudioStreamPlayer
@export_node_path("AudioStreamPlayer", "AudioStreamPlayer3D", "AudioStreamPlayer2D") var audio_steam_player_path 

var audioStream_player

## assign the Audio stream that the 
@export var audioClip : AudioStream
@export_range(-80,80) var volume : float = 0.0
@export var audioBus : String = "Master"
var base_audio

## when this is true, Audio will play at the same place even when the object is moved or destroyed
@export var unparent_on_play : bool
# good for AudioStreamPlayer2D/3D
# also works to make the sound still play even if the object is deleted



## Choose the action you want to do
@export var action : AudioAction

@export_category("Effect")
@export var pitch : float = 1.0

@export_category("Random")
## choose if it will use random audiostreamplayer instead
@export var random : bool
## This will choose random Audio streamer assigned, 
@export var audioStream_rand : Array[AudioStreamPlayer]
# will probably add random audio clip later

@export_category("Random pitch")
@export var random_pitch : bool
@export var pitch_scale_max : float = 1.2
@export var pitch_scale_min : float = 0.8
var initial_pitch : float

func _ready():
	if audio_steam_player_path != null :
		audioStream_player = get_node(audio_steam_player_path)

func Play_Enter():
	var audio_to_play
	
	if audioStream_player == null :
		audioStream_player = AudioStreamPlayer.new()
		add_child(audioStream_player)
	audioStream_player.pitch_scale = pitch
	audioStream_player.bus = audioBus
	audioStream_player.volume_db = volume
	if random :
		var rand_index = randi() % audioStream_rand.size()
		audio_to_play = audioStream_rand[rand_index]
		pass
	else : audio_to_play = audioStream_player
	
	if unparent_on_play:
		base_audio = audio_to_play
		var new = audio_to_play.duplicate()
		
		#remove_child(audio_to_play)
		get_tree().get_current_scene().add_child(new)
		
		
		if new is AudioStreamPlayer2D or new is AudioStreamPlayer3D:
			new.global_position = owner.global_position
		
		
		new.finished.connect(new.queue_free)
		
		audio_to_play = new
		
	#audio_to_play.play()
	if audioClip != null:
		audio_to_play.stream = audioClip
	
	
	if random_pitch :
		var pitch_scale = randf_range(pitch_scale_min,pitch_scale_max)
		
		audio_to_play.pitch_scale = pitch_scale
	
	match action :
		AudioAction.Play :
			audio_to_play.play()
		AudioAction.Stop :
			audio_to_play.stop()
			pass
		
	
	if unparent_on_play:
		audioStream_player = base_audio
	pass
	
	
enum AudioAction {
	Play,
	Stop,
	Pause
	
}
