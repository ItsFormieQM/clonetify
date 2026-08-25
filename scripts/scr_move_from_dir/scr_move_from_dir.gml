function scr_move_from_dir(_dir){
	var _sandbox = game_save_id
	var search_path = _sandbox + "*.*"
	
	var _filename = file_find_first(search_path,0)
	
	while _filename != "" {
		_filename = file_find_next()
		file_copy(_sandbox + _filename,_dir + _filename)
	}
	file_find_close()
	
}