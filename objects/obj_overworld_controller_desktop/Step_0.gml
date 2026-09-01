_button_names = [
	{name: "Import File", x_pos: 320, y_pos: 20},
	
	{name: "Export Files from Sandbox", x_pos: global.allow_folder_conversion ? 320 + 220 : 320 + 200, y_pos: 20},
	{name: "Settings", x_pos: 320 + 1440, y_pos: 20},
	{name: "Import Folder", x_pos: 320, y_pos: 20},
]
var vd_list = scr_scan_sdir(true)
if global.current_mus != pointer_null && 
	audio_is_playing(global.current_mus) {
    time_elapsed_song = audio_sound_get_track_position(global.current_mus);
	time_max_song = audio_sound_length(global.current_mus);
}

if keyboard_check_pressed(vk_space) && 
	global.current_mus_stream != pointer_null{
	pause = !pause
	scr_toggle_mus(pause)
	
}

if !opened_settings && !global.use_video{
	if keyboard_check_pressed(vk_escape) {
		audio_stop_all()
		global.current_mus = pointer_null
		global.current_mus_playing_file = pointer_null
		global.current_mus_stream = pointer_null
	}
	else if keyboard_check_pressed(ord("Z")) {
		play_mus(sel_song)
		pause = false
	}

	if keyboard_check(vk_delete) {
		clear_timer++
		if clear_timer >= 120 {
			audio_stop_all()
			song_index = 1
			scr_clean_sandbox_dir()
		}
	}	
	else {
		clear_timer = 0
	}
	if keyboard_check_pressed(vk_delete) {
	    result = scr_delete_file(sel_song)
		show_debug_message(result)
	}
	if keyboard_check_pressed(vk_down) {
		if song_index < array_length(song_list) - 1 {
			song_index++
		}
		else {
			song_index = 0
		}
	}

	else if keyboard_check_pressed(vk_up) {
		if song_index > 0 {
			song_index--
		}
		else {
			song_index = array_length(song_list) - 1
		}
	} 
}
else if global.use_video && !opened_settings {
	if keyboard_check_pressed(vk_escape) {
		audio_stop_all()
		global.current_mus = pointer_null
		global.current_mus_playing_file = pointer_null
		global.current_mus_stream = pointer_null
		video_close()
	}
	else if keyboard_check_pressed(ord("Z")) {
		audio_stop_all()
		instance_destroy(obj_video_drawer)
		video_close()
		instance_create(0,0,obj_video_drawer)
		obj_video_drawer.file_path = sel_vid
		obj_video_drawer.start = true
		pause = false
	}
	else if keyboard_check_pressed(vk_space)  {
		pause = !pause
		if pause {
			video_pause()
		}
		else {
			video_resume()
		}
	}
	if keyboard_check(vk_delete) {
		clear_timer++
		if clear_timer >= 120 {
			audio_stop_all()
			song_index = 1
			scr_clean_sandbox_dir()
		}
	}	
	else {
		clear_timer = 0
	}
	if keyboard_check_pressed(vk_delete) {
	    result = scr_delete_file(sel_vid)
		show_debug_message(result)
	}
	if keyboard_check_pressed(vk_down) {
		if song_index < array_length(vd_list) - 1 {
			song_index++
		}
		else {
			song_index = 0
		}
	}

	else if keyboard_check_pressed(vk_up) {
		if song_index > 0 {
			song_index--
		}
		else {
			song_index = array_length(vd_list) - 1
		}
	}	
}	
else if opened_settings {
	sel_sett = _settings[setting_index].iname
	
	if keyboard_check_pressed(vk_down) {
		if setting_index < array_length(_settings) - 1 {
			setting_index++
		}
		else {
			setting_index = 0
		}
	}
	else if keyboard_check_pressed(ord("Q")) {
		scr_save_state()
	}

	else if keyboard_check_pressed(vk_up) {
		if setting_index > 0 {
			setting_index--
		}
		else {
			setting_index = array_length(_settings) - 1
		} 
	} 
	if keyboard_check_pressed(ord("Z")) {
		show_debug_message(scr_toggle_sett(sel_sett))
	}
}

if sent && !window_get_fullscreen(){
	file_name = filename_get_externally("")
	sent = false
}

var _time = 3
if keyboard_check_pressed(vk_right) || forward{
	if !global.use_video {
		scr_set_track_pos_song(_time)
		forward = false
	}
	else {
		scr_manipulate_video(_time)
		forward = false
	}
}
else if keyboard_check_pressed(vk_left) || backward{
	scr_set_track_pos_song(-1 * _time)
	backward = false
}

song_list = scr_scan_sdir()

if keyboard_check_pressed(ord("G")) || sent_folder{
	global.ext_path = external_call(global.dll_pick_folder)
	show_debug_message(global.ext_path)
	sent_folder = false
	song_list = scr_scan_sdir()
	if global.ext_path == "" {
		_settings[2].truthy = true
		global.sandbox = _settings[2].truthy
	}
	else {
		_settings[2].truthy = false
		global.sandbox = _settings[2].truthy
	}
}

if array_length(song_list) > 0 && !global.use_video{
	if song_index >= array_length(song_list) {
		song_index = array_length(song_list) - 1
	}
	sel_song = song_list[song_index]
}
else if array_length(song_list) <= 0{
	song_index = 0
}
else if array_length(vd_list) > 0 && global.use_video {
	if song_index >= array_length(vd_list) {
		song_index = array_length(vd_list) - 1 
	}
	sel_vid = vd_list[song_index]
}
else if array_length(vd_list) <= 0 {
	song_index = 0
}
