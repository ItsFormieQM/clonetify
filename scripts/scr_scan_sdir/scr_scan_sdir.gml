/// @desc Loops through the chosen directory or game_save_id and returns an array of all files found
/// @return {array} An array of strings containing the file names
function scr_scan_sdir() {
    var audio_files = []
    var _search_pattern = game_save_id + "*.*"
    
    if instance_exists(obj_overworld_controller_desktop) && global.ext_path != "" {
        var _base_path = global.ext_path
        
        var _last_char = string_char_at(_base_path, string_length(_base_path))
        if _last_char != "\\" && _last_char != "/" {
            _base_path += "\\"
        }
        
        _search_pattern = _base_path + "*.*"
    }
    
    var _file_name = file_find_first(_search_pattern, 0)
    
    while _file_name != "" {
        if _file_name != "." && _file_name != ".." {
            var _ext = string_lower(filename_ext(_file_name))
            if _ext == ".ogg" || _ext == ".mp4" {
                array_push(audio_files, _file_name)
            }
			else {
				scr_convert_audio(_file_name)
			}
        }
        _file_name = file_find_next()
    }
    file_find_close()
	
    if array_length(audio_files) > 0 {
		var temp_array = []
        for (var i = 0; i < array_length(audio_files) - 1; i++) {
			var temp_str_1 = string_lower(audio_files[i])
			var temp_str_2 = string_lower(audio_files[i + 1])
			
			if temp_str_1 > temp_str_2{
				array_push(temp_array,audio_files[i])
			}
			else if temp_str_2 > temp_str_1 {
				array_push(temp_array,audio_files[i])
			}
			else {
				scr_delete_file(audio_files[i])
			}
			
		}
        return audio_files
    }
    
    return []
	
}
