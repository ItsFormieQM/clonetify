function scr_convert_audio(_file){

    var _source_file = game_save_id + _file;
    var _save_folder = game_save_id;   
    var _filename    = _file;                

    if (_source_file == "" || _save_folder == "" || _filename == "") {
        
        return -4.0; 
    }

    var _status = external_call(global.fn_convert_to_ogg, _source_file, _save_folder, _filename);

    if (file_exists(game_save_id + _file)) {
        file_delete(game_save_id + _file);
    }
	
    return _status; 
}
