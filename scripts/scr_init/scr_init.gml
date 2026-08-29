function scr_init(){
    global.osflavors = 0
    global.audio_files = []
    global.current_mus = pointer_null
    global.loading_file = false
    global.current_mus_stream = pointer_null
    global.current_mus_playing_file = pointer_null
	global.song_list = []
	
	game_set_speed(display_get_frequency(),gamespeed_fps)

	
	// settings
	global.use_float = false
	global.plh = false
	global.allow_folder_conversion = false
	global.ext_path = ""
	global.sandbox = false
    
    // OS TYPE
    if os_type == os_windows || os_type == os_linux || os_type == os_macosx {
        global.osflavors = PC
    }
    else {
        global.osflavors = pointer_null
    }
    
    #region DLLS/EXTENSIONS
    if os_type == os_windows {
		global.dll_file_check = external_define(
				"audio_checker.dll", 
				"is_audio_file", 
				dll_cdecl, 
				ty_real, 
				1, 
				ty_string		
		)
		global.dll_pick_folder = external_define(
				"folder_get.dll", 
				"pick_folder", 
				dll_cdecl, 
				ty_string,
				0
		)
        var _dll_path = working_directory + "audio_converter.dll"
        if file_exists(_dll_path) {
            global.fn_convert_to_ogg = external_define(
                _dll_path,
                "convert_to_ogg",
                dll_stdcall,
                ty_real,
                3,
                ty_string,
                ty_string,
                ty_string
            )
        } 
		else {
            show_debug_message("ERROR: the dll not found: " + _dll_path)
        }
    }

    #endregion
	scr_load_state()
	game_set_speed(display_get_frequency(),gamespeed_fps)
    return true
}
