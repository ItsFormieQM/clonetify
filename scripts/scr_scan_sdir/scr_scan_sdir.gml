/// @desc Loops through the game_save_id directory and returns an array of all files found
/// @return {array} An array of strings containing the file names
function scr_scan_sdir() {
	
    var audio_files = []
    var _search_pattern = game_save_id + "*.*"
    var _file_name = file_find_first(_search_pattern, 0)
    
    while (_file_name != "") {

        if (_file_name != "." && _file_name != "..") {
			
            array_push(audio_files, _file_name)
			
        }
        _file_name = file_find_next()
    }
    
    file_find_close()
	
    if array_length(audio_files) != 0 {
		
		
		return audio_files
		
	}
	else {
		return ""
	}
	
}
