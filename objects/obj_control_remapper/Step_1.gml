global.l_click = device_mouse_check_button_pressed(0,mb_left)
global.l_held = device_mouse_check_button(0,mb_left)

if global.osflavors == PC {
	if keyboard_check_pressed(vk_f11) {
		global.is_fs = !global.is_fs	
		window_set_fullscreen(global.is_fs)
	}
	
}

