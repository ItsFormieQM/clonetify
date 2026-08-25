function play_mus(mus = noone){
	
    if mus == noone || !is_string(mus) {
        return -1;
    }

    var proper_mus = filename_change_ext(mus, ".ogg");
    
    if !string_starts_with(proper_mus, game_save_id) {
        proper_mus = game_save_id + proper_mus; 
    }
    
 
    
    if file_exists(proper_mus) {
        if variable_global_exists("current_mus") {
            if is_real(global.current_mus) {
                if audio_is_playing(global.current_mus) {
                    audio_stop_sound(global.current_mus);
                }
            }
        }
        
        audio_stop_all();

        if variable_global_exists("current_mus_stream") && global.current_mus_stream != pointer_null {
            audio_destroy_stream(global.current_mus_stream);
            global.current_mus_stream = pointer_null;
        }

        var _mus = audio_create_stream(proper_mus);
        global.current_mus_stream = _mus;
        global.current_mus = audio_play_sound(_mus, 67, true);
        
        if instance_exists(obj_overworld_controller_desktop) {
            obj_overworld_controller_desktop.time_max_song = 0;
        }
    }
    else {
    }
	global.current_mus_playing_file = scr_strip_dir(proper_mus)
}
