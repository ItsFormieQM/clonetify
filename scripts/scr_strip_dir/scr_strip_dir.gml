function scr_strip_dir(_dir_fn){
	var count = string_last_pos(" \ ", _dir_fn)
	var _stripped_fn = ""
	for (var i = string_length(_dir_fn); i  > 0; i--) {
		if string_char_at(_dir_fn,i) == "\\" {
			break			
		}
		_stripped_fn += string(string_char_at(_dir_fn,i))		
	}
	return (scr_flip_str(_stripped_fn))
}