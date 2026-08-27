function scr_load_state(){
	var _filename = "config/save.txt"
	if !file_exists(_filename) {
		return -1
	}
	var _file = file_text_open_read(_filename)
	
	global.use_float = file_text_read_real(_file)
	file_text_readln(_file)
	global.plh = file_text_read_real(_file)
	file_text_readln(_file)
}