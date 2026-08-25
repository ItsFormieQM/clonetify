function clickedOn(){
	if global.l_click && position_meeting(mouse_x,mouse_y,id) {
		return true
	}
	else {
		return false
	}
}