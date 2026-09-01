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
						break
					}
				}
			}
			break
		case allow_folder_conversion_macro:
			with obj_overworld_controller_desktop {
				for (var i = 0; i < array_length(_settings); i++) {
					if _settings[i].iname == allow_folder_conversion_macro {
						_settings[i].truthy = !_settings[i].truthy
						global.allow_folder_conversion = _settings[i].truthy
						if global.allow_folder_conversion {
							global.ext_path = buffer_ext_path 
							show_debug_message("BUFFER: " + buffer_ext_path)
						}
						
						else {
							buffer_ext_path = global.ext_path
							global.ext_path = ""
							show_debug_message("BUFFER: " + buffer_ext_path)
						}
						break
					}
				}
			}
			break
		case sandbox_macro:
			with obj_overworld_controller_desktop {
				for (var i = 0; i < array_length(_settings); i++) {
					if _settings[i].iname == sandbox_macro {
						_settings[i].truthy = !_settings[i].truthy
						global.sandbox = _settings[i].truthy
						
						break
					}
				}
			}
			break
		case video_play_macro:
			with obj_overworld_controller_desktop {
				for (var i = 0; i < array_length(_settings); i++) {
					if _settings[i].iname == video_play_macro {
						_settings[i].truthy = !_settings[i].truthy
						global.use_video = _settings[i].truthy
						break
					}
				}
			}
			break
		default:
			show_debug_message($"NOT VALID SETT: {_sett}")
			return -2
	}	
	return 0
}