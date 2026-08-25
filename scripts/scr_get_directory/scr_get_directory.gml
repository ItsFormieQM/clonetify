function scr_get_directory(){
	var _directory = get_open_filename_ext("Any File","The file in the diretory you want to export to!","","Select a directory, GameMaker doesn't support directory selection so just select a file of the directory you want to export to!")
	return filename_path(_directory)
}