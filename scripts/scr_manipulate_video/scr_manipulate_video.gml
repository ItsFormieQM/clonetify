function scr_manipulate_video(time){
	time = time * 1000
	var vid_track_pos = video_get_position() 
	show_debug_message($"TIME: {vid_track_pos}")
	video_seek_to(vid_track_pos+time)
	return 0
}