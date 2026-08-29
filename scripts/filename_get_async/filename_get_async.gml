/// @function filename_get_async(filter, fname, callback)
/// @param {string} filter    File filter string
/// @param {string} fname     Default file name or ""
/// @param {function} callback Function to execute with the resulting path string
function filename_get_async(_filter = "All Files|*.*", _fname = "", _callback = undefined) {
    var _started = external_call(global.fn_start_file_dialog, _filter, _fname);
    if (_started != 1.0) return false;

    // Create an inline time source to poll the path every frame in the background
    var _ts_container = [ undefined ];
    
    var _poll_method = function(_ts_holder, _cb) {
        var _result_path = external_call(global.fn_poll_file_dialog);

        if (_result_path != "WAITING") {
            // Stop and destroy the time source once completed
            if (_ts_holder[0] != undefined && time_source_exists(_ts_holder[0])) {
                time_source_destroy(_ts_holder[0]);
            }

            // Return path string to callback if valid, or "" if canceled
            var _final_path = (_result_path != "CANCELED") ? _result_path : "";
            
            if (is_callable(_cb)) {
                _cb(_final_path);
            }
        }
    };

    var _ts = time_source_create(
        time_source_global,
        1,
        time_source_units_frames,
        _poll_method,
        [_ts_container, _callback],
        -1
    );

    _ts_container[0] = _ts;
    time_source_start(_ts);
    return true;
}