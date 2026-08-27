function scr_toggle_sett(_sett = ""){
	if noone {
		return -1
	}
	
	switch _sett {
		case use_float_macro:
			with obj_overworld_controller_desktop {
				for (var i = 0; i < array_length(_settings); i++) {
					if _settings[i].iname == use_float_macro {
						_settings[i].truthy = !_settings[i].truthy
						global.use_float = _settings[i].truthy
					}
				}
			}
			break
		default:
			return -2
	}	
	return 0
}