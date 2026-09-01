function scr_save_state(){
	var _dir_name = "config"
	var _file_name = "/save.txt"
	directory_destroy(_dir_name)
	directory_create(_dir_name)
	var _filename = _dir_name + _file_name	
	var _file = file_text_open_write(_filename)
	
	file_text_write_real(_file,global.use_float)
	file_text_writeln(_file)
	
	file_text_write_real(_file,global.allow_folder_conversion)
	file_text_writeln(_file)
	file_text_write_string(_file,global.ext_path)
	show_debug_message(global.ext_path)
	file_text_writeln(_file)
	file_text_write_real(_file,global.sandbox)
	file_text_writeln(_file)
	file_text_write_real(_file,global.use_video)
	file_text_writeln(_file)
	file_text_write_real(_file,global.plh)
	file_text_writeln(_file)
	
	file_text_close(_file)
	
	
}