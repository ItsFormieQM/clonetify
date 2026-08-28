if(global.__permission) && room != room_mobile
{
    if(mouse_check_button_released(mb_left))
    {
        if(point_in_rectangle(mouse_x, mouse_y, room_width/8*1, room_height/32*2, room_width/8*7, room_height/32*4))
        {
            intent_saf_request(SAF_REQUEST_SEARCH_DIRECTORY);
        }
        
        
    }
}
if global.__storage_external != "" && room != room_mobile{
	room_goto(room_mobile)
}