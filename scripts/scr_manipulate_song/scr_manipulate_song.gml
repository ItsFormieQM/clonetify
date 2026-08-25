function scr_set_track_pos_song(_time = 0,_mus = global.current_mus){
	
	if global.current_mus_stream != pointer_null && audio_is_playing(global.current_mus_stream) {
		audio_pause_sound(_mus)
		var _track_time = audio_sound_get_track_position(_mus)
		var _max_track_time = audio_sound_length(_mus)
		if _track_time < _max_track_time - _time {
			if _track_time < _time && _time < 0 {
				_time = 0
				audio_sound_set_track_position(_mus, 0)
			}
		
			else if _time > 0 {
				var set_time = _track_time + _time
				audio_sound_set_track_position(_mus, set_time)
				
			}
			else if _time != 0 {
				var set_time = _track_time + _time
				audio_sound_set_track_position(_mus, set_time)
				
			}
		}
		else if _track_time < _max_track_time - 1.99{
			audio_sound_set_track_position(_mus,_max_track_time - 2)
		}
		else if _track_time > _max_track_time - 2.1{
			audio_sound_set_track_position(_mus,_max_track_time - 0.1)
		}
	}
	else if global.current_mus_stream != pointer_null {
		global.current_mus = audio_play_sound(global.current_mus_stream,100,obj_overworld_controller_desktop.loop)
		
		return 0
	}
	else {
		
		
		return -1
		
	}
	audio_resume_sound(_mus)
}

function scr_toggle_mus_loop(_bool,_mus = global.current_mus) {
	if _bool && global.current_mus != pointer_null || global.current_mus_stream != pointer_null {
		audio_sound_loop(_mus,_bool)
	}
	else {
		return -1
	}
}