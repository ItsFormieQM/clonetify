if start && file_path != "" {
	var _corrected_path = file_path
	if global.ext_path != "" {
		_corrected_path = global.ext_path + "\\" + file_path	
	}	
	video_open(_corrected_path)
	start = false
	global.vid_playing = file_path
	
}
loop = obj_overworld_controller_desktop.loop
video_enable_loop(loop)
