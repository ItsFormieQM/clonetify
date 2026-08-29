function file_move_to_sandbox(_dir_to_file){
	
    var _filename = filename_name(_dir_to_file);
    
    var src = _dir_to_file;
    
    var dest = game_save_id + _filename;

    file_copy(_dir_to_file,dest)
	if !string_ends_with(_filename,".ogg") && !string_ends_with(_filename,".mp4"){
		scr_convert_audio(_filename)
	}
	else if string_ends_with(_filename,".mp4") {
		
	}
	
}
