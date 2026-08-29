function play_mus(mus = noone){
	global.current_mus = mus; 
    global.current_mus_stream = mus;
    if (mus == noone || !is_string(mus)) {
        return -1;
    }

    var _saf_dir = global.__storage_external + "/";
    var proper_mus = filename_change_ext(mus, ".ogg");
    
    if (!string_starts_with(proper_mus, game_save_id)) {
        proper_mus = _saf_dir + proper_mus; 
    }
   
    // Stop any music playing natively inside GameMaker's engine
    audio_stop_all();

    // 1. Tell your Java extension layer to stop the previous MediaPlayer track
    clonetify_stop_audio();

    // 2. Clear old GML audio trackers so your step event doesn't crash on undefined values
    

    // 3. Play the absolute external path directly using Android's core MediaPlayer
    // (Bypasses GameMaker's sandboxed file_exists check and asset hijacking entirely!)
    clonetify_play_audio(string(proper_mus));
    
    // 4. Safely query your new extension tracker to update your UI duration fields
    if (instance_exists(obj_overworld_controller)) {
        obj_overworld_controller.time_max_song = clonetify_get_duration();
        obj_overworld_controller.time_elapsed_song = 0;
    }

    global.current_mus_playing_file = proper_mus;
}
