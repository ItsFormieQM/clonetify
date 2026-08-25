function scr_clean_sandbox_dir(){
	if global.current_mus_stream != pointer_null {
		if (variable_global_exists("current_mus")) {
	        if (is_real(global.current_mus)) {
	            if (audio_is_playing(global.current_mus)) {
	                audio_stop_sound(global.current_mus)
	            }
	        }
	    }
    
	    audio_stop_all()
		var _temp_stuff = global.current_mus_stream
		global.current_mus = pointer_null
		
    
	    var file_find = file_find_first(game_save_id + "*.*", 0)
	    while (file_find != "") {
	        file_delete(game_save_id + file_find)
	        file_find = file_find_next()
	    }
	    file_find_close()
		obj_overworld_controller_desktop.song_hitbox = [{}]
	    obj_overworld_controller_desktop.song_index = 0
		return 0
	}
}