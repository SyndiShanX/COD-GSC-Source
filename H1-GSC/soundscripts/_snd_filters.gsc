/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_snd_filters.gsc
*****************************************/

snd_filters_init() {
  snd_init_current_filters();
  snd_init_current_occlusion();
  snd_load_filter_presets();
  snd_load_occlusion_presets();
}

snd_set_filter_lerp(var_0) {
  level._snd.current_filters.lerp = var_0;
  level.player seteqlerp(var_0, 0);
}

snd_get_current_filter_lerp() {
  return level._snd.current_filters.lerp;
}

snd_init_current_filters() {
  var_0 = spawnstruct();
  var_0.names = [];
  var_0.names[0] = "";
  var_0.names[1] = "";
  var_0.lerp = 0;
  level._snd.current_filters = var_0;
}

snd_get_current_filter_name(var_0) {
  return level._snd.current_filters.names[var_0];
}

snd_set_current_filter_name(var_0, var_1) {
  level._snd.current_filters.names[var_0] = var_1;
}

snd_init_current_occlusion() {
  var_0 = spawnstruct();
  var_0.name = "";
  level._snd.current_occlusion = var_0;
  snd_set_current_occlusion_name("");
}

snd_get_current_occlusion_name() {
  return level._snd.current_occlusion.name;
}

snd_set_current_occlusion_name(var_0) {
  level._snd.current_occlusion.name = var_0;
}

snd_load_dsp_buses() {
  var_0 = soundscripts\_snd::snd_parse_soundtables("DSP bus", ["sounddata\dspbuses.csv"], 2, "name", "name");

  if(isdefined(var_0))
    level._snd.dsp_buses = var_0;
  else
    level._snd.dsp_buses = [];
}

snd_get_dsp_buses() {
  var_0 = [];

  foreach(var_2 in level._snd.dsp_buses)
  var_0[var_0.size] = var_2.name;

  return var_0;
}

snd_is_dsp_bus(var_0) {
  return isdefined(level._snd.dsp_buses[var_0]);
}

snd_get_dsp_filename() {
  return "sounddata\dspbuses.csv";
}

snd_load_filter_presets() {
  level._snd.filters = spawnstruct();
  var_0 = [];
  var_0[var_0.size] = "soundtables\sp_defaults.csv";
  var_0[var_0.size] = "soundtables\" + level.script + ".csv ";
  level._snd.filters.presets = soundscripts\_snd::snd_parse_soundtables("Filter", var_0, 6, "filter_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

snd_set_filter(var_0, var_1, var_2) {
  if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  var_3 = 0;

  if(isdefined(var_1))
    var_3 = var_1;

  if(!isdefined(var_0) || isdefined(var_0) && (var_0 == "" || var_0 == "none")) {
    snd_set_current_filter_name(var_3, "");
    level.player deactivateeq(var_3);
    return;
  }

  var_4 = snd_get_filter_preset(var_0);

  if(!isdefined(var_4)) {
    return;
  }
  if(snd_get_current_filter_name(var_3) != var_0) {
    snd_set_current_filter_name(var_3, var_0);
    thread snd_set_filter_threaded(var_3, var_4);
  }
}

sndx_fade_in_filter_lerp(var_0) {
  self endon("fade_begin");
  var_1 = 0.0;
  var_2 = 0.05 / var_0;

  while (var_1 < 1.0) {
    snd_set_filter_lerp(var_1);
    var_1 = var_1 + var_2;
    wait 0.05;
  }

  snd_set_filter_lerp(1.0);
}

snd_fade_in_filter(var_0, var_1) {
  self notify("fade_begin");
  snd_set_filter_lerp(0);
  snd_clear_filter(0);
  snd_clear_filter(1);
  snd_set_filter(var_0);
  thread sndx_fade_in_filter_lerp(var_1);
}

sndx_fade_out_filter_lerp(var_0) {
  self endon("fade_begin");
  var_1 = snd_get_current_filter_lerp();
  var_2 = var_1 * (0.05 / var_0);

  while (var_1 > 0.0) {
    snd_set_filter_lerp(var_1);
    var_1 = var_1 - var_2;
    wait 0.05;
  }

  snd_set_filter_lerp(0.0);
}

snd_fade_out_filter(var_0) {
  self notify("fade_begin");
  thread sndx_fade_out_filter_lerp(var_0);
}

snd_get_filter_preset(var_0) {
  if(isdefined(level._snd.filters.presets[var_0]))
    return level._snd.filters.presets[var_0];

  return undefined;
}

sndx_get_dsp_filter_setting(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3.dsp_bus = var_1;
  var_3.index = var_0;
  var_3.type = var_2["type"];
  var_3.gain = var_2["gain"];
  var_3.freq = var_2["freq"];
  var_3.q = var_2["q"];
  return var_3;
}

snd_set_filter_threaded(var_0, var_1) {
  var_2 = soundscripts\_snd::snd_get_throttler();
  var_3 = [];

  foreach(var_5 in var_1.settings) {
    var_6 = var_5["dsp_bus_name"];

    if(var_6 == "all" || var_6 == "set_all") {
      var_7 = snd_get_dsp_buses();

      foreach(var_9 in var_7)
      var_3[var_9] = sndx_get_dsp_filter_setting(var_0, var_9, var_5);

      continue;
    }

    if(snd_is_dsp_bus(var_6)) {
      var_3[var_6] = sndx_get_dsp_filter_setting(var_0, var_6, var_5);
      continue;
    }
  }

  foreach(var_13 in var_3) {
    level.player seteq(var_13.dsp_bus, var_13.index, var_13.type, var_13.gain, var_13.freq, var_13.q);
    var_2 soundscripts\_snd::snd_throttle_wait();
  }
}

snd_clear_filter(var_0) {
  var_1 = 0;

  if(isdefined(var_0))
    var_1 = var_0;

  snd_set_filter(undefined, var_1);
}

snd_load_occlusion_presets() {
  level._snd.occlusion = spawnstruct();
  var_0 = [];
  var_0[var_0.size] = "soundtables\sp_defaults.csv";
  var_0[var_0.size] = "soundtables\" + level.script + ".csv ";
  level._snd.occlusion.presets = soundscripts\_snd::snd_parse_soundtables("Filter", var_0, 6, "occlusion_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

snd_set_occlusion(var_0) {
  if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  if(!isdefined(var_0)) {
    snd_set_current_occlusion_name("");
    thread snd_disable_occlusion_threaded();
    return;
  }

  var_1 = snd_get_occlusion_preset(var_0);

  if(!isdefined(var_1)) {
    return;
  }
  if(snd_get_current_occlusion_name() != var_0) {
    snd_set_current_occlusion_name(var_0);
    thread snd_set_occlusion_threaded(var_1.settings);
  }
}

snd_get_occlusion_preset(var_0) {
  if(isdefined(level._snd.occlusion.presets[var_0]))
    return level._snd.occlusion.presets[var_0];

  return undefined;
}

snd_set_occlusion_threaded(var_0) {
  var_1 = soundscripts\_snd::snd_get_throttler();

  foreach(var_3 in var_0) {
    var_4 = var_3["dsp_bus_name"];

    if(var_4 == "all") {
      var_5 = snd_get_dsp_buses();

      foreach(var_7 in var_5) {
        level.player setocclusion(var_7, var_3["freq"], var_3["type"], var_3["gain"], var_3["q"]);
        var_1 soundscripts\_snd::snd_throttle_wait();
      }

      break;
    } else {
      if(snd_is_dsp_bus(var_4))
        level.player setocclusion(var_4, var_3["freq"], var_3["type"], var_3["gain"], var_3["q"]);
      else {

      }

      var_1 soundscripts\_snd::snd_throttle_wait();
    }
  }
}

snd_enable_occlusion() {
  level._snd.occlusion.is_enabled = 1;
}

snd_disable_occlusion_threaded() {
  var_0 = soundscripts\_snd::snd_get_throttler();
  var_1 = snd_get_dsp_buses();

  foreach(var_3 in var_1) {
    level.player deactivateocclusion(var_3);
    var_0 soundscripts\_snd::snd_throttle_wait();
  }
}

snd_disable_occlusion() {
  level._snd.occlusion.is_enabled = 0;
  thread snd_disable_occlusion_threaded();
}

snd_disable_zone_filters() {
  level._snd.zone_filters_enabled = undefined;
}

snd_enable_zone_filters() {
  level._snd.zone_filters_enabled = 1;
}

snd_get_zone_filters_enabled() {
  return isdefined(level._snd.zone_filters_enabled);
}

snd_disable_zone_occlusion_and_filtering() {
  snd_set_filter(undefined, 0);
  snd_set_filter(undefined, 1);
  snd_disable_occlusion();
  snd_disable_zone_filters();
}

snd_enable_zone_occlusion_and_filtering() {
  var_0 = undefined;
  var_1 = "default";

  if(isdefined(level._audio.zone_mgr.current_zone) && isdefined(level._audio.zone_mgr.zones[level._audio.zone_mgr.current_zone])) {
    var_2 = soundscripts\_audio_zone_manager::azm_get_current_zone();
    var_3 = level._audio.zone_mgr.zones[var_2];

    if(isdefined(var_3["occlusion"]) && var_3["occlusion"] != "none")
      var_1 = var_3["occlusion"];

    if(isdefined(var_3["filter"]) && var_3["filter"] != "none")
      var_0 = var_3["filter"];
  }

  if(snd_get_current_occlusion_name() != var_1)
    var_1 = snd_get_current_occlusion_name();

  snd_enable_zone_filters();
  snd_set_filter(var_0, 0);
  snd_set_filter(undefined, 1);
  snd_set_occlusion(var_1);
}