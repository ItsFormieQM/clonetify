base_width = room_width
base_height = room_height
var _screen_w = window_get_width()
var _screen_h = window_get_height()
x_offset = 120
y_offset = 120
if _screen_w == 0 {
	_screen_w = display_get_width()
}
if _screen_h == 0 {
	_screen_h = display_get_height()
}

var _scale_x = _screen_w / base_width
var _scale_y = _screen_h / base_height
var _scale = min(_scale_x, _scale_y)

surface_resize(application_surface, base_width * _scale, base_height * _scale)
display_set_gui_size(base_width, base_height)

view_enabled = true
view_set_visible(0, true)
view_set_wport(0, base_width * _scale)
view_set_hport(0, base_height * _scale)

var _cam = camera_create_view(0, 0, base_width, base_height, 0, -1, -1, -1, 0, 0)
view_set_camera(0, _cam)

_buttons = [
	{iname: "up", name: "^^", x_pos: x_offset - 100, y_pos: (y_offset + 770) - 40},
	{iname: "down", name: "VV", x_pos: x_offset - 50, y_pos: (y_offset + 760) - 40},
	{iname: "play", name: "Play", x_pos: x_offset + 0, y_pos: (y_offset + 760) - 40},
	{iname: "pause", name: "Pause", x_pos: x_offset + 82, y_pos: (y_offset + 760) - 40},
]

opened_settings = false
song_index = 0

time_elapsed_song = 0
time_max_song = 0

up_click = false
down_click = false
play = false
pause = false
song_list = []
x_offset = 120
y_offset = 120
song_list = []
timer = 0
max_timer = gamespeed_fps * 60
test = []
global.music_playable_paths = []