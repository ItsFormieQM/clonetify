
var vid_data = video_draw()
if vid_data[0] == 0 {
	var surface = vid_data[1]
	if surface_exists(surface) {
		draw_surface(surface,8,90)
	}
}