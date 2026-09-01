var type = ds_map_find_value(async_load, "type")

if type == "video_end" {
    show_debug_message("done")
    video_close()
	obj_overworld_controller_desktop.pause = false
	global.vid_playing = pointer_null
    instance_destroy()
}
