sent = false
input = ""
window_set_size(room_width,room_height)
window_center()
time_elapsed_song = 0
time_max_song = 0
file_name = ""
room_width = display_get_width()
room_height = display_get_height()


hover = false
pause = false
forward = false
backward = false
loop = true
x_offset = room_width / 2 - 650
y_offset = 150
opened_settings = false

song_hitbox = [
	{}
]
song_index = 0
setting_index = 0
song_list = scr_scan_sdir()
// store hitboxes as an array of structs
audio_controller = [
	{name: "||", iname: "pause",x_pos: room_width / 2,y_pos: room_height - 100},
	{name: "-->", iname: "forward",x_pos: (room_width / 2) + 60, y_pos: room_height - 100},
	{name: "<--", iname: "backward",x_pos: (room_width / 2) - 60, y_pos: room_height - 100},
	{name: "LOOP: ", iname: "backward",x_pos: room_width / 2, y_pos: room_height - 60},
]

_button_names = [
	{name: "Import File", x_pos: 320, y_pos: 20},
	{name: "Export Files from Sandbox", x_pos: 320 + 200, y_pos: 20},
	{name: "Settings", x_pos: 320 + 1440, y_pos: 20},
]

_settings = [
	{iname: use_float_macro, name: "Use decimals", truthy: global.use_float, x_pos: x_offset, y_pos: 150 + 30},
	{iname: plh_macro, name: "PLACEHOLDER", truthy: global.plh, x_pos: x_offset, y_pos: 0},
]

sel_song = ""
clear_timer = 0
sel_sett = ""
