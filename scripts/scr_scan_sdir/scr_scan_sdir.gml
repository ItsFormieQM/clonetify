/// @desc Loops through the game_save_id directory and returns an array of all files found
/// @return {array} An array of strings containing the file names
function scr_scan_sdir() {
	
    var audio_files = []
    var _search_pattern = game_save_id + "*.*"
    var _file_name = file_find_first(_search_pattern, 0)
    
    while _file_name != ""{

        if _file_name != "." && _file_name != ".." && (filename_ext(_file_name) == ".ogg" || filename_ext(_file_name) == ".mp4") {
			
            array_push(audio_files, _file_name)
			
        }
        _file_name = file_find_next()
    }
    
    file_find_close()
	
	array_sort(audio_files,true)
    if array_length(audio_files) != 0 {
		return audio_files
	}
	else {
		return []
	}
	
}
