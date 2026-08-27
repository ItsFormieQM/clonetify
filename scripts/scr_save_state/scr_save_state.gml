function scr_save_state(){
	directory_create("config")
	var _filename = "config/save.txt"
	var _file = file_text_open_write(_filename)
	
	file_text_write_real(_file,global.use_float)
	file_text_write_real(_file,global.plh)
	
	
	file_text_close(_file)
}