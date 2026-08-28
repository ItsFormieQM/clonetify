function scr_filter_str(_char,_str){
	var actual_str = ""
	for (var i = 1; i <= string_length(_str); i++) {
		if string_char_at(_str,i) == _char {
			return actual_str
		}
		actual_str += string_char_at(_str,i)
	}
	return -1
}