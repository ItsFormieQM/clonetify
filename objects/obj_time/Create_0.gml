input = 0;
sent = false
play_snd = pointer_null;
played = false
if scr_init() == true {
	instance_create(0,0,obj_error_handler)
}
delete_path = false
trunc_filename = ""

if global.osflavors == PC {
	room_goto(room_desktop)
}
else if global.osflavors == Mobile{
	room_goto(room_mobile)
}