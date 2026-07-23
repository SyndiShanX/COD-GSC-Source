/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\176.gsc
**************************************/

mus_init() {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  level._audio.music = spawnStruct();
  level._audio.music.cue_cash = [];
  level._audio.music.curr_cue_name = "";
  level._audio.music.prev_cue_name = "";
  level._audio.music.enable_auto_mix = 0;
  level._audio.music.env_threat_to_vol = [[0.0, 0.5], [0.9, 1.0], [1.0, 1.0]];
  thread musx_monitor_game_vars();
}

mus_play(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = mus_get_playing_cue_preset();
  var_7 = musx_construct_cue(var_0);
  var_8 = var_7["fade_in_time"];

  if(isDefined(var_1)) {
    var_8 = var_1;
  }
  var_9 = 2.0;

  if(isDefined(var_6)) {
    if(isDefined(var_2)) {
      var_9 = var_2;
    } else if(isDefined(var_1)) {
      var_9 = var_1;
    } else if(isDefined(var_6["fade_out_time"])) {
      var_9 = var_6["fade_out_time"];
    }
  }

  var_10 = var_7["volume"];

  if(isDefined(var_3)) {
    var_10 = var_3;
  }
  musx_start_cue(var_7["name"], var_8, var_9, var_10, var_4);
}

mus_stop(var_0) {
  var_1 = 3.0;

  if(mus_is_playing()) {
    var_2 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
    var_1 = var_2["fade_out_time"];
  }

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  musx_stop_all_music(var_1);
}

mus_is_playing() {
  return isDefined(level._audio.music.curr_cue_name) && level._audio.music.curr_cue_name != "";
}

mus_get_playing_cue_preset() {
  var_0 = undefined;

  if(mus_is_playing()) {
    var_0 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
  }
  return var_0;
}

musx_construct_cue(var_0) {
  var_1 = musx_get_cashed_cue(var_0);

  if(!isDefined(var_1)) {
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

  if(isDefined(var_4)) {
    var_5 = var_4;
  }
  if(var_0 == level._audio.music.curr_cue_name && !var_5) {
    return;
  } else {
    var_6 = level._audio.music.prev_cue_name;
    var_7 = level._audio.music.curr_cue_name;
    level._audio.music.prev_cue_name = level._audio.music.curr_cue_name;
    level._audio.music.curr_cue_name = var_0;
    var_8 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
    var_9 = musx_get_cashed_cue(level._audio.music.prev_cue_name);
    var_10 = undefined;

    if(isDefined(var_9)) {
      var_10 = var_9["alias"];
    }
    maps\_audio_stream_manager::sm_start_music(var_8["alias"], var_1, var_2, var_3, var_10);
  }
}

musx_stop_all_music(var_0) {
  maps\_audio_stream_manager::sm_stop_music(var_0);
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

    for(;;) {
      wait(var_0);

      if(musx_get_auto_mix()) {
        var_1 = maps\_audio::aud_get_threat_level();
        var_2 = maps\_audio::aud_map(var_1, level._audio.music.env_threat_to_vol);
      }
    }
  }
}