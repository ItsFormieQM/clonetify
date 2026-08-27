if up_click {
	up_click = false
	if song_index <= 0 {
		song_index = array_length(song_list) - 1
	}
	else {
		song_index--
	}
}
else if down_click {
	down_click = false
	if song_index >= array_length(song_list) - 1 {
		song_index = 0
	}
	else {
		song_index++
	}
}
else if play {
	if !pause {
		play_mus(sel_song)
	}
	else {
		pause = false
		audio_resume_sound(global.current_mus)
	}
	play = false
}