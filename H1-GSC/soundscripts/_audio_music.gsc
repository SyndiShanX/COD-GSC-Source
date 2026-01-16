/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_music.gsc
*****************************************/

mus_init() {
  ams_init();

  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  level._audio.music = spawnstruct();
  level._audio.music.cue_cash = [];
  level._audio.music.curr_cue_name = "";
  level._audio.music.prev_cue_name = "";
  level._audio.music.enable_auto_mix = 0;
  level._audio.music.env_threat_to_vol = [[0.0, 0.5],
    [0.9, 1.0],
    [1.0, 1.0]
  ];
  thread musx_monitor_game_vars();
}

mus_play(var_0, var_1, var_2, var_3, var_4) {
  if(!soundexists(var_0)) {
    return;
  }
  var_5 = undefined;
  var_6 = mus_get_playing_cue_preset();
  var_7 = musx_construct_cue(var_0);
  var_8 = var_7["fade_in_time"];

  if(isdefined(var_1))
    var_8 = var_1;

  var_9 = 2.0;

  if(isdefined(var_6)) {
    if(isdefined(var_2))
      var_9 = var_2;
    else if(isdefined(var_1))
      var_9 = var_1;
    else if(isdefined(var_6["fade_out_time"]))
      var_9 = var_6["fade_out_time"];
  }

  var_10 = var_7["volume"];

  if(isdefined(var_3))
    var_10 = var_3;

  musx_start_cue(var_7["name"], var_8, var_9, var_10, var_4);
}

mus_stop(var_0) {
  var_1 = 3.0;

  if(mus_is_playing()) {
    var_2 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
    var_1 = var_2["fade_out_time"];
  }

  if(isdefined(var_0))
    var_1 = var_0;

  musx_stop_all_music(var_1);
}

mus_is_playing() {
  return isdefined(level._audio.music.curr_cue_name) && level._audio.music.curr_cue_name != "";
}

mus_get_playing_cue_preset() {
  var_0 = undefined;

  if(mus_is_playing())
    var_0 = musx_get_cashed_cue(level._audio.music.curr_cue_name);

  return var_0;
}

musx_construct_cue(var_0) {
  var_1 = musx_get_cashed_cue(var_0);

  if(!isdefined(var_1)) {
    var_1 = [];
    var_1["alias"] = var_0;
    var_1["volume"] = 1.0;
    var_1["fade_in_time"] = 1.5;
    var_1["fade_out_time"] = 1.5;
    var_1["auto_mix"] = 0;
    var_1["name"] = var_0;
    musx_cash_cue(var_1);
  }

  return var_1;
}

musx_start_cue(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isdefined(var_4))
    var_5 = var_4;

  if(var_0 == level._audio.music.curr_cue_name && !var_5)
    return;
  else {
    var_6 = level._audio.music.prev_cue_name;
    var_7 = level._audio.music.curr_cue_name;
    level._audio.music.prev_cue_name = level._audio.music.curr_cue_name;
    level._audio.music.curr_cue_name = var_0;
    var_8 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
    var_9 = musx_get_cashed_cue(level._audio.music.prev_cue_name);
    var_10 = undefined;

    if(isdefined(var_9))
      var_10 = var_9["alias"];

    soundscripts\_audio_stream_manager::sm_start_music(var_8["alias"], var_1, var_2, var_3, var_10);
  }
}

musx_stop_all_music(var_0) {
  soundscripts\_audio_stream_manager::sm_stop_music(var_0);
}

musx_get_auto_mix() {
  return level._audio.music.enable_auto_mix;
}

musx_get_cashed_cue(var_0) {
  return level._audio.music.cue_cash[var_0];
}

musx_cash_cue(var_0) {
  level._audio.music.cue_cash[var_0["name"]] = var_0;
}

musx_monitor_game_vars() {
  if(musx_get_auto_mix()) {
    var_0 = 1.0;

    for (;;) {
      wait(var_0);

      if(musx_get_auto_mix()) {
        var_1 = soundscripts\_audio::aud_get_threat_level();
        var_2 = soundscripts\_audio::deprecated_aud_map(var_1, level._audio.music.env_threat_to_vol);
      }
    }
  }
}

ams_init() {
  level._snd._ams = spawnstruct();
  level._snd._ams.curr_intensity = 0;
  level._snd._ams.curr_state = "";
  soundscripts\_snd::snd_register_message("ams_start", ::ams_start);
  soundscripts\_snd::snd_register_message("ams_stop", ::ams_stop);
  soundscripts\_snd::snd_register_message("ams_set_state", ::ams_set_state);
  soundscripts\_snd::snd_register_message("ams_set_proxy_vehicle", ::ams_set_proxy_vehicle);
  soundscripts\_snd::snd_register_message("ams_set_intensity", ::ams_set_intensity);
  soundscripts\_audio_vehicle_manager::avm_register_callback("ams_intensity", ::ams_intensity);
  soundscripts\_audio_vehicle_manager::avm_register_callback("ams_proxy_vehicle_speed", ::ams_proxy_vehicle_speed);
}

ams_start(var_0, var_1, var_2, var_3) {
  var_4 = amsx_get();
  var_4.proxy = soundscripts\_audio_vehicle_manager::avm_create_vehicle_proxy();
  var_5 = 3;
  var_6 = 3;

  if(isdefined(var_0) && !isstring(var_0)) {
    var_7 = var_0;
    var_0 = var_7.preset_name;
    var_1 = var_7.initial_state;
    var_2 = var_7.fadein_time;
    var_3 = var_7.fadeout_time;
  } else {}

  ams_set_state(var_1);
  var_8 = spawnstruct();
  var_8.preset_name = var_0;
  var_8.fadein_time = soundscripts\_audio::aud_get_optional_param(var_5, var_2);
  var_8.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_6, var_3);
  var_4.proxy soundscripts\_snd::snd_message("snd_start_vehicle", var_8);
}

ams_stop(var_0) {
  var_0 = soundscripts\_audio::aud_get_optional_param(3.0, var_0);
  var_1 = amsx_get_proxy();
  var_1 soundscripts\_snd::snd_message("snd_stop_vehicle", var_0);
  var_1 delete();
}

ams_get_state() {
  return level._snd._ams.curr_state;
}

ams_set_state(var_0) {
  level._snd._ams.curr_state = var_0;
}

ams_set_intensity(var_0) {
  var_1 = amsx_get();
  var_1.curr_intensity = var_0;
}

ams_set_proxy_vehicle(var_0) {
  level._snd._ams.proxy.veh_ent = var_0;
}

ams_intensity() {
  return amsx_get().curr_intensity;
}

ams_player_health() {
  return level.player.health;
}

ams_proxy_vehicle_speed() {
  var_0 = 0;
  var_1 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
  var_2 = amsx_get_proxy_vehicle_ent();

  if(isdefined(var_2))
    var_0 = var_2 vehicle_getspeed();

  return var_0;
}

amsx_get() {
  return level._snd._ams;
}

amsx_get_proxy() {
  return level._snd._ams.proxy;
}

amsx_get_proxy_vehicle_ent() {
  var_0 = undefined;
  var_1 = amsx_get_proxy();

  if(isdefined(var_1))
    var_0 = level._snd._ams.proxy.veh_ent;

  return var_0;
}