function scr_toggle_mus(pause,mus = global.current_mus_stream){
	try {
		if audio_is_playing(mus) && pause{
			audio_pause_sound(mus)
		}
		else if audio_is_playing(mus) && !pause{
			audio_resume_sound(mus)
		}
		else {
			return pointer_null
		}
	}
	catch (_exception) {
		return pointer_null
	}
}