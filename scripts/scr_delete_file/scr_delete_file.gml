function scr_delete_file(_filename){
	if global.ext_path == "" {
		if global.current_mus_playing_file != _filename {
			if obj_overworld_controller_desktop.song_index == array_length(obj_overworld_controller_desktop.song_list) - 1 {
				obj_overworld_controller_desktop.song_index--
			}
		
			var _actual_file = game_save_id + _filename
			file_delete(_actual_file)
			return 0
		}
		else {
			return -1
		}
	}
	else {
		if global.current_mus_playing_file != _filename {
			if obj_overworld_controller_desktop.song_index == array_length(obj_overworld_controller_desktop.song_list) - 1 {
				obj_overworld_controller_desktop.song_index--
			}
		
			var _actual_file = global.ext_path + "\\" + _filename
			file_delete(_actual_file)
			return 0
		}
		else {
			return -1
		}
	}
}