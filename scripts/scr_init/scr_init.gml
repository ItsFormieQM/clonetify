function scr_init(){
    global.osflavors = 0
    global.audio_files = []
    global.current_mus = pointer_null
    global.loading_file = false
    global.current_mus_stream = pointer_null
    global.current_mus_playing_file = pointer_null
	global.song_list = []
	global.save_dir = ""
	global.font = fnt_main
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
  
	game_set_speed(display_get_frequency(),gamespeed_fps)
    return true
}
