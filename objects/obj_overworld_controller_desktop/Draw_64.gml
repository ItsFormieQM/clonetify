draw_self()

var _dsettings = draw_get_settings()
draw_set_font(fnt_main)
draw_set_colour(c_white)
draw_text(30,20,"---Playlists---")

if !opened_settings {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text(room_width / 2, 80, "SONG LIST")
    
    draw_set_halign(fa_left)
    draw_set_valign(fa_left)
    
    song_hitbox = []
    
    for (var i = 0; i < array_length(song_list); i++) {
        var _item_x = x_offset
        var _item_y = y_offset + i * 30
        var _display_text = $"{i + 1}: {scr_filter_str(".", song_list[i])}"
        
		
        if song_index == i {
            draw_set_colour(c_blue)
        }
        else if song_list[i] == global.current_mus_playing_file {
            draw_set_colour(c_yellow)
        }
        else {
            draw_set_colour(c_white)
        }
        
        array_push(song_hitbox, {
            _x: _item_x,
            _y: _item_y,
            _w: string_width(_display_text),
            _h: string_height(_display_text),
            name: song_list[i],
            index: i
        })
        
        draw_text(_item_x, _item_y, _display_text)
    }
    
    draw_set_colour(c_white)
}
else {
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	draw_text(room_width / 2,80,"SETTINGS")
	draw_set_halign(fa_left)
	draw_set_valign(fa_left)
}

if global.current_mus != pointer_null {
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	draw_text(display_get_width() / 2,room_height - 150,
		$"Time Elapsed: {string_format(time_elapsed_song,0,0)}s / {string_format(time_max_song,0,0)}s")
	draw_set_halign(fa_left)
	draw_set_valign(fa_left)
}

#region Hitboxes 
	#region Song hitbox
	var _old_sett = draw_get_settings()
	
	if global.osflavors != pointer_null {
		for (var i = 0; i < array_length(song_hitbox); i++) {
			var button_names = song_hitbox
			

			draw_set_halign(fa_left)
			draw_set_valign(fa_left)
			var _tx = button_names[i]._x     
			var _ty = button_names[i]._y          
			var _text = button_names[i].name

			var _tw = string_width(_text)
			var _th = string_height(_text)

			var _mx = device_mouse_x_to_gui(0)
			var _my = device_mouse_y_to_gui(0)
			draw_set_halign(fa_right)
			draw_set_valign(fa_right)

			var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

			if _hover {
				show_debug_message("Hovered at: "+ button_names[i].name)
				draw_set_colour(c_yellow)
				if global.l_click && global.current_mus_stream != pointer_null {
					pause = !pause
					scr_toggle_mus(pause)
				}
			} 
			else {
				draw_set_colour(c_white)
				hover = true
			}
		}
	}
	else {
		var button_names = audio_controller
		draw_set_colour(c_gray)
			
		draw_set_colour(c_white)
	}
	draw_set_settings(_old_sett)
	#endregion
	#region Setting Options Hitboxes
		#region add decimality back
		_old_sett = draw_get_settings()
		if global.osflavors != pointer_null && opened_settings {
			var button_names = _settings
			

			draw_set_halign(fa_left)
			draw_set_valign(fa_left)

			var _tx = button_names[0].x_pos + 0 * 30          
			var _ty = button_names[0].y_pos           
			var _text = button_names[0].name

			var _tw = string_width(_text)
			var _th = string_height(_text)

			var _mx = device_mouse_x_to_gui(0)
			var _my = device_mouse_y_to_gui(0)

			var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

			if _hover {
				hover = true
				draw_set_colour(c_yellow)
				if global.l_click && global.current_mus_stream != pointer_null {
					pause = !pause
					scr_toggle_mus(pause)
				}
			} 
			else {
				draw_set_colour(c_white)
				hover = true
			}
		
			draw_set_halign(fa_left)
			draw_set_valign(fa_left)
			draw_text(x_offset + 0 * 30, _ty, $"{_settings[0].name} {_settings[0].truthy ? "True":"False"}")
			draw_set_colour(c_white)
		}
		else {
			var button_names = audio_controller
			draw_set_colour(c_gray)
			
			draw_set_colour(c_white)
		}
		draw_set_settings(_old_sett)
		#endregion
	
	#endregion

	#region for pausing
	_old_sett = draw_get_settings()
	if global.osflavors != pointer_null {
		var button_names = audio_controller
		if pause {
			button_names[0].name = "| >"
		}
		else {
			button_names[0].name = "| |"
		}

		draw_set_halign(fa_center)
		draw_set_valign(fa_center)

		var _tx = button_names[0].x_pos           
		var _ty = button_names[0].y_pos           
		var _text = button_names[0].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click && global.current_mus_stream != pointer_null {
				pause = !pause
				scr_toggle_mus(pause)
			}
		} 
		else {
			draw_set_colour(c_white)
			hover = true
		}
		
		draw_text(button_names[0].x_pos,
			button_names[0].y_pos,
			button_names[0].name
		)
		draw_set_halign(fa_left)
		draw_set_valign(fa_left)
		draw_set_colour(c_white)
	}
	else {
		var button_names = audio_controller
		draw_set_colour(c_gray)
		draw_text(button_names[0].x_pos,
			button_names[0].y_pos,
			button_names[0].name
		)
		draw_set_colour(c_white)
	}
	draw_set_settings(_old_sett)
	#endregion
	
	#region for forward
	_old_sett = draw_get_settings()
	if global.osflavors != pointer_null {
		var button_names = audio_controller
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		var _tx = button_names[2].x_pos           
		var _ty = button_names[2].y_pos           
		var _text = button_names[2].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click && global.current_mus_stream != pointer_null {
				backward = true
			}
		} 
		else {
			draw_set_colour(c_white)
			hover = true
		}
		
		draw_text(button_names[2].x_pos,
			button_names[2].y_pos,
			button_names[2].name
		)
		draw_set_halign(fa_left)
		draw_set_valign(fa_left)
		draw_set_colour(c_white)
	}
	else {
		var button_names = audio_controller
		draw_set_colour(c_gray)
		draw_text(button_names[2].x_pos,
			button_names[2].y_pos,
			button_names[2].name
		)
		draw_set_colour(c_white)
	}
	draw_set_settings(_old_sett)
	#endregion
	
	#region for loop truthy or falsy
	_old_sett = draw_get_settings()
	if global.osflavors != pointer_null {
		var button_names = audio_controller
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		var _tx = button_names[3].x_pos           
		var _ty = button_names[3].y_pos           
		var _text = button_names[3].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click && global.current_mus_stream != pointer_null {
				loop = !loop
				scr_toggle_mus_loop(loop)
			}
		} 
		else {
			draw_set_colour(c_white)
			hover = true
		}
		draw_text(button_names[3].x_pos,
			button_names[3].y_pos,
			button_names[3].name + string(loop ? "True":"False")
		)
		draw_set_halign(fa_left)
		draw_set_valign(fa_left)
		draw_set_colour(c_white)
	}
	else {
		var button_names = audio_controller
		draw_set_colour(c_gray)
		draw_text(button_names[3].x_pos,
			button_names[3].y_pos,
			button_names[3].name + string(loop)
		)
		draw_set_colour(c_white)
	}
	draw_set_settings(_old_sett)
	#endregion
	
	#region for forward
	_old_sett = draw_get_settings()
	if global.osflavors != pointer_null {
		var button_names = audio_controller
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		var _tx = button_names[1].x_pos           
		var _ty = button_names[1].y_pos           
		var _text = button_names[1].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx - _tw / 2 && _mx <= _tx + _tw / 2 && _my >= _ty - _th / 2 && _my <= _ty + _th / 2)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click && global.current_mus_stream != pointer_null {
				forward = true
			}
		} 
		else {
			draw_set_colour(c_white)
			hover = true
		}
		
		draw_text(button_names[1].x_pos,
			button_names[1].y_pos,
			button_names[1].name 
		)
		draw_set_halign(fa_left)
		draw_set_valign(fa_left)
		draw_set_colour(c_white)
	}
	else {
		var button_names = audio_controller
		draw_set_colour(c_gray)
		draw_text(button_names[1].x_pos,
			button_names[1].y_pos,
			button_names[1].name
		)
		draw_set_colour(c_white)
	}
	draw_set_settings(_old_sett)
	#endregion

	#region for export files
	var button_names = _button_names
	if !global.is_fs {
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		var _tx = button_names[1].x_pos           
		var _ty = button_names[1].y_pos           
		var _text = button_names[1].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx && _mx <= _tx + _tw && _my >= _ty && _my <= _ty + _th)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click {
				var _dir = scr_get_directory()
				if _dir != "" {
					scr_move_from_dir(_dir)
				}
			}
		} 
		else {
			draw_set_colour(c_white)
			hover = false
		}
		
		draw_text(button_names[1].x_pos,
			button_names[1].y_pos,
			button_names[1].name
		)
		draw_set_colour(c_white)
	}
	else {
		draw_set_colour(c_gray)
		draw_text(button_names[1].x_pos,
			button_names[1].y_pos,
			button_names[1].name
		)
		draw_set_colour(c_white)
	}
	#endregion
	
	#region for settings
	button_names = _button_names
	if global.osflavors != pointer_null {
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		var _tx = button_names[2].x_pos           
		var _ty = button_names[2].y_pos           
		var _text = button_names[2].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx && _mx <= _tx + _tw && _my >= _ty && _my <= _ty + _th)

		if _hover {
			hover = true
			draw_set_colour(c_yellow)
			if global.l_click {
				show_debug_message("click")
				opened_settings = !opened_settings
			}
		} 
		else if opened_settings {
			draw_set_colour(c_yellow)
		}
		else if !_hover || !opened_settings {
			draw_set_colour(c_white)
			hover = false
		}
		
		draw_text(button_names[2].x_pos,
			button_names[2].y_pos,
			button_names[2].name
		)
		draw_set_colour(c_white)
	}
	else {
		draw_set_colour(c_gray)
		draw_text(button_names[2].x_pos,
			button_names[2].y_pos,
			button_names[2].name
		)
		draw_set_colour(c_white)
	}
	#endregion

	#region for import file
	if !global.is_fs {
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		var _tx = button_names[0].x_pos           
		var _ty = button_names[0].y_pos           
		var _text = button_names[0].name

		var _tw = string_width(_text)
		var _th = string_height(_text)

		var _mx = device_mouse_x_to_gui(0)
		var _my = device_mouse_y_to_gui(0)

		var _hover = (_mx >= _tx && _mx <= _tx + _tw && _my >= _ty && _my <= _ty + _th)

		if _hover {
			draw_set_colour(c_yellow)
			if global.l_click {
				sent = true
			}
		} 
		else {
			draw_set_colour(c_white)
		}
		draw_text(button_names[0].x_pos,
			button_names[0].y_pos,
			button_names[0].name
		)
		draw_set_colour(c_white)
	}
	else {
		draw_set_colour(c_gray)
		draw_text(button_names[0].x_pos,
			button_names[0].y_pos,
			button_names[0].name
		)
		draw_set_colour(c_white)
	}
	#endregion
#endregion

draw_set_settings(_dsettings)