var _sett = draw_get_settings()
draw_set_font(fnt_main)

if global.current_mus != pointer_null {
	var _x_offset = _buttons[0].x_pos - 10
	var _y_offset = 800
	if global.use_float {
		draw_text(
			_x_offset,
			y_offset + _y_offset,
			$"Time Elapsed: {time_elapsed_song}s / {time_max_song}s"
		)
	}
	else {
		draw_text(
			_x_offset,
			y_offset + _y_offset,
			$"Time Elapsed: {string_format(time_elapsed_song,0,0)}s / {string_format(time_max_song,0,0)}s"
		)
	}
}

if !opened_settings{
	draw_text(
		room_width - x_offset - 100,
		y_offset - 90,
		"SONG LIST"
	)
	draw_text(
		room_width - x_offset - 380,
		y_offset - 90,
		"PLAYLISTS"
	)
	for (var i = 0; i < array_length(_buttons); i++) {
		var _tx = _buttons[i].x_pos           
		var _ty = _buttons[i].y_pos           
		var _text = _buttons[i].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = _mx >= _tx && _mx <= _tx + _tw && _my >= _ty && _my <= _ty + _th
		
		if _hover {
			draw_set_colour(c_yellow)
			if global.l_click {
				switch _buttons[i].name {
					case "^^":
						up_click = true
						break
					case "VV":
						down_click = true
						break
					case "Play":
						play = true
						break
					case "Pause":
						pause = !pause
						if global.current_mus != pointer_null {
							if pause {
								audio_pause_sound(global.current_mus)
								
							}
							else {
								if audio_is_paused(global.current_mus) {
									audio_resume_sound(global.current_mus)
								}
							}
						}
						break
					default:
						break
				}
			}
		}
		if pause && _buttons[i].name == "Pause"{
			draw_set_colour(c_yellow)
		}
		draw_text(
			_buttons[i].x_pos,
			_buttons[i].y_pos,
			_buttons[i].name
		)
		draw_set_colour(c_white)
	}
	
	for (var i = 0; i < array_length(song_list); i ++) {
		var scale = 0.7
		
		if song_index == i {
			draw_set_colour(c_blue)	
		}	
		if global.current_mus == song_list[i] {
			draw_set_colour(c_yellow)
		}
		draw_text_ext_transformed(
			x_offset + 115,
			(y_offset + i * 30) - 40,
			$"{i+1}. {scr_truncate_str(scr_filter_str(".",song_list[i]),21)}",
			scale,
			9999,
			scale,
			scale,
			0
		)
		draw_set_colour(c_white)
	}	
}

draw_set_settings(_sett)