///@desc Returns the filename of what the user selected

function filename_get_externally(_filter = "Audio Files (*.ogg, *.wav, *.mp3)|*.ogg;*.wav;*.mp3|All Files|*.*)") {
	var _file_notyet_stripped = get_open_filename(_filter,"")
	if _file_notyet_stripped == "" {
		
		return "Nuh uh"
	}
	file_move_to_sandbox(_file_notyet_stripped)
	
	return (scr_strip_dir(_file_notyet_stripped))
}