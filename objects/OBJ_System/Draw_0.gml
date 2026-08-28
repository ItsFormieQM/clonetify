draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.font)

if(global.__permission)
{
	if room != room_mobile {
	    draw_text(room_width/2, room_height/32*1, "Music Location: \n" + global.__storage_external);
	    draw_text(room_width/2, room_height/32*3, "< Set Music Location (One-Time Only!)>");
	}
	
}