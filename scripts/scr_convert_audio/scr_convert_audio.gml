function scr_convert_audio(_file){

	var _status = 0
	if global.ext_path == "" {
	    var _source_file = game_save_id + _file
	    var _save_folder = game_save_id 
	    var _filename    = _file         

	    if _source_file == "" || _save_folder == "" || _filename == "" {
        
	        return -4.0
	    }

	    _status = external_call(
			global.fn_convert_to_ogg, 
			_source_file, 
			_save_folder, 
			_filename
		)

	    if file_exists(game_save_id + _file) {
	        file_delete(game_save_id + _file)
	    }
	}
	else {
		var _source_file = global.ext_path + "\\" + _file
		var _save_folder = global.ext_path
		var _filename = _file
		
		_status = external_call(
			global.fn_convert_to_ogg,
			_source_file,
			_save_folder,
			_filename
		)
		if file_exists(_source_file) {
	        file_delete(_source_file)
	    }
	}
    return _status; 
}
