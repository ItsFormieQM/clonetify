function scr_save(){
	var _file = file_text_open_write("song_list.json")
	file_text_close(_file)
}