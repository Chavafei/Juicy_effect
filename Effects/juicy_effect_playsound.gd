extends Juicy_effect

class_name Juicy_effect_playSound

@export var audioStream : AudioStreamPlayer
# if no assigned, It will create it's own AudioStreamPlayer

@export var audioClip : AudioStream
var base_audio
@export var unparent_on_play : bool
# when this is true, Audio will play at the same place even when the object is move
# good for AudioStreamPlayer/3D
# also works to make the sound still play even if the object is deleted

@export var action : AudioAction

@export_category("Random")
@export var random : bool
@export var audioStream_rand : Array[AudioStreamPlayer]

func Play_Enter():
	var audio_to_play
	
	if audioStream == null :
		audioStream = AudioStreamPlayer.new()
		add_child(audioStream)
	
	if random :
		var rand_index = randi() % audioStream_rand.size()
		audio_to_play = audioStream_rand[rand_index]
		pass
	else : audio_to_play = audioStream
	
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
	
	
	match action :
		AudioAction.Play :
			audio_to_play.play()
		AudioAction.Stop :
			audio_to_play.stop()
			pass
		
	
	if unparent_on_play:
		audioStream = base_audio
	pass
	
	
enum AudioAction {
	Play,
	Stop,
	Pause
	
}
