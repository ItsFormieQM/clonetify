///@desc Returns the filename of what the user selected

function filename_get_externally(_filter = "Audio Files (*.ogg, *.wav, *.mp3)|*.ogg;*.wav;*.mp3|All Files|*.*)") {
	var _file_notyet_stripped = get_open_filename(_filter,"")
	if _file_notyet_stripped == "" {
		return "Nuh uh"
	}
	if global.ext_path == "" {
		file_move_to_sandbox(_file_notyet_stripped)
	}
	else {
		var _filename = filename_name(_file_notyet_stripped)
		file_copy(_file_notyet_stripped, global.ext_path + "\\"+_filename)
		show_debug_message("ranNNN")
	}
	return (scr_strip_dir(_file_notyet_stripped))
}