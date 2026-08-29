//@desc Returns a boolean state if the file is an audio type or not.
function scr_check_file(_path){
	var _is_real_audio = external_call(global.dll_file_check, _path)

	
	return (_is_real_audio == 1.0 ? true : false)
}