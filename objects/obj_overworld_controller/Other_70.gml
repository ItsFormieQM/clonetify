var _event_type = async_load[? "type"];

if _event_type == "clonetify_scan_complete" {
    var _payload = async_load[? "raw_data"];
    if (is_string(_payload) && _payload != "") 
    {
        global.music_playable_paths = string_split(_payload, "|", true)
        song_list = scr_strip_dir(global.music_playable_paths)
        var _total_songs = array_length(song_list)
    }
    else {
        global.music_playable_paths = []
        song_list = []
    }
}
