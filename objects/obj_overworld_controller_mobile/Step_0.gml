if window_get_width() != base_width || window_get_height() != base_height {
    window_set_size(base_width, base_height)
	window_center()
}

if global.current_mus != pointer_null {
	time_elapsed_song = audio_sound_get_track_position(global.current_mus)
	time_max_song = audio_sound_length(global.current_mus)
}

song_list = scr_scan_sdir()

if array_length(song_list) > 0 {
	sel_song = song_list[song_index]
}
