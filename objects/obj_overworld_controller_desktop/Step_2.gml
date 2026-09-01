var files = scr_scan_sdir(true)
if keyboard_check_pressed(ord("R")) {
	instance_create(0,0,obj_video_drawer)
	obj_video_drawer.start = true
	obj_video_drawer.file_path = files[0]
}