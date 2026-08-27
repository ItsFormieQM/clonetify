function scr_truncate_str(_str = "", _len = 15){
	if _str == "" {
		return -1
	}
	var _copied_str = ""
	for (var i = 0; i < string_length(_str); i++) {
		if string_length(_copied_str) >= _len{
			_copied_str = _copied_str + "..."
			return _copied_str
		}
		_copied_str += string_char_at(_str,i + 1)
	}
	return _copied_str
}