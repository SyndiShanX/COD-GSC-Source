/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_snd_timescale.gsc
*******************************************/

snd_timescale_init() {
  snd_load_timescale_presets();
  snd_set_current_timescale_preset_name("");
}

snd_set_current_timescale_preset_name(var_0) {
  level._snd.timescale.current_preset_name = var_0;
}

snd_get_current_timescale_preset_name() {
  return level._snd.timescale.current_preset_name;
}

snd_load_timescale_presets() {
  level._snd.timescale = spawnstruct();
  var_0 = [];
  var_0[var_0.size] = "soundtables\sp_defaults.csv";
  var_0[var_0.size] = "soundtables\" + level.script + ".csv ";
  level._snd.timescale.presets = soundscripts\_snd::snd_parse_soundtables("Timescale", var_0, 3, "timescale_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

snd_set_timescale(var_0) {
  var_1 = snd_get_timescale_preset(var_0);

  if(!isdefined(var_1)) {
    return;
  }
  if(snd_get_current_timescale_preset_name() != var_0)
    thread snd_set_timescale_threaded(var_1);
}

snd_get_timescale_preset(var_0) {
  if(isdefined(level._snd.timescale.presets) && isdefined(level._snd.timescale.presets[var_0]))
    return level._snd.timescale.presets[var_0];

  return undefined;
}

snd_set_timescale_threaded(var_0) {
  var_1 = soundscripts\_snd::snd_get_throttler();

  foreach(var_3 in var_0.settings) {
    var_4 = var_3["dsp_bus_name"];

    if(var_4 == "all") {
      var_5 = soundscripts\_snd_filters::snd_get_dsp_buses();

      foreach(var_7 in var_5) {
        soundsettimescalefactor(var_7, var_3["scalefactor"]);
        var_1 soundscripts\_snd::snd_throttle_wait();
      }

      continue;
    }

    soundsettimescalefactor(var_4, var_3["scalefactor"]);
  }
}

snd_set_timescale_all(var_0) {
  thread snd_set_timescale_all_threaded(var_0);
}

snd_set_timescale_all_threaded(var_0) {
  var_1 = soundscripts\_snd::snd_get_throttler();
  var_2 = soundscripts\_snd_filters::snd_get_dsp_buses();

  foreach(var_4 in var_2) {
    soundsettimescalefactor(var_4, var_0);
    var_1 soundscripts\_snd::snd_throttle_wait();
  }
}

snd_set_timescale_array_to_value(var_0, var_1) {
  thread snd_set_timescale_array_to_value_threaded(var_0, var_1);
}

snd_set_timescale_array_to_value_threaded(var_0, var_1) {
  var_2 = soundscripts\_snd::snd_get_throttler();

  foreach(var_4 in var_0) {
    soundsettimescalefactor(var_4, var_1);
    var_2 soundscripts\_snd::snd_throttle_wait();
  }
}