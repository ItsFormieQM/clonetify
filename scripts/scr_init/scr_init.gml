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
    
    // OS TYPE
    if os_type == os_windows || os_type == os_linux || os_type == os_macosx {
        global.osflavors = PC
    }
    else if os_type == os_android || os_type == os_ios {
        global.osflavors = Mobile
    }
    else {
        global.osflavors = pointer_null
    }
    
    #region DLLS/EXTENSIONS
	
    if os_type == os_windows {
        var _dll_path = working_directory + "audio_converter.dll"
    
        // Check if file exists before binding to avoid crashes
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
        } else {
            show_debug_message("ERROR: audio_converter.dll not found at " + _dll_path)
        }
    }
    else if os_type == os_linux {
        var _so_path = working_directory + "audio_converter_linux.so"
    
        if file_exists(_so_path) {
            global.fn_convert_to_ogg = external_define(
                _so_path,
                "convert_to_ogg",
                dll_cdecl,
                ty_real,
                3,
                ty_string,
                ty_string,
                ty_string
            )
        }
    }

    #endregion
	scr_load_state()
	game_set_speed(display_get_frequency(),gamespeed_fps)
    return true
}
