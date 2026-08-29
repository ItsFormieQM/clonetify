if window_get_width() != base_width || window_get_height() != base_height {
    window_set_size(base_width, base_height)
	window_center()
}

if global.current_mus != NULL {
	time_elapsed_song = clonetify_get_position()
	time_max_song = clonetify_get_duration()
}

if array_length(song_list) > 0 {
	sel_song = song_list[song_index]
}
clonetify_scan_dir_async(global.__storage_external)


