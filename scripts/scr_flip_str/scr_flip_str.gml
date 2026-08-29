///@desc Flips the string backward

function scr_flip_str(_str){
	var _flipped_str = ""
	for (var i = string_length(_str); i > 0; i--) {
		_flipped_str += string_char_at(_str,i)
	}
	return _flipped_str
}