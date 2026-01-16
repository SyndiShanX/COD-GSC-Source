/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_stream_manager.gsc
**************************************************/

sm_init() {
  level._audio.stream = spawnstruct();
  level._audio.stream.music = spawnstruct();
  level._audio.stream.music.curr = smx_create_struct();
  level._audio.stream.music.prev = smx_create_struct();
  level._audio.stream.ambience = spawnstruct();
  level._audio.stream.ambience.curr = smx_create_struct();
  level._audio.stream.ambience.prev = smx_create_struct();
}

sm_start_preset(var_0, var_1, var_2, var_3, var_4) {
  if(!soundexists(var_0)) {
    return;
  }
  var_6 = 1.0;

  if(isdefined(var_1))
    var_6 = max(var_1, 0);

  var_7 = 1.0;

  if(isdefined(var_4))
    var_7 = max(var_4, 0);

  smx_set_values_for_struct(level._audio.stream.ambience.prev, level._audio.stream.ambience.curr.name, level._audio.stream.ambience.curr.vol, level._audio.stream.ambience.curr.fade);
  smx_set_values_for_struct(level._audio.stream.ambience.curr, var_0, var_7, var_6);
  ambientplay(var_0, var_6, var_7);
}

sm_start_music(var_0, var_1, var_2, var_3, var_4) {
  if(!soundexists(var_0)) {
    return;
  }
  var_6 = 1.0;

  if(isdefined(var_1))
    var_6 = max(var_1, 0);

  var_7 = 1.0;

  if(isdefined(var_2))
    var_7 = var_2;

  var_8 = 1.0;

  if(isdefined(var_3))
    var_8 = max(var_3, 0);

  smx_set_values_for_struct(level._audio.stream.music.prev, level._audio.stream.music.curr.name, level._audio.stream.music.curr.vol, level._audio.stream.music.curr.fade);
  smx_set_values_for_struct(level._audio.stream.music.curr, var_0, var_8, var_6);

  if(isdefined(var_4)) {
    musicstop(var_7, var_4);
    musicplay(var_0, var_6, var_8, 0);
  } else
    musicplay(var_0, var_6, var_8);
}

sm_stop_ambient_alias(var_0, var_1) {
  if(var_0 != "none") {
    if(!soundexists(var_0)) {
      return;
    }
    var_3 = 1.0;

    if(isdefined(var_1))
      var_3 = max(var_1, 0);

    if(level._audio.stream.ambience.curr.name == var_0) {
      level._audio.stream.ambience.curr = level._audio.stream.ambience.prev;
      smx_clear_struct(level._audio.stream.ambience.prev);
    } else if(level._audio.stream.ambience.prev.name == var_0)
      smx_clear_struct(level._audio.stream.ambience.prev);

    ambientstop(var_3, var_0);
  }
}

sm_stop_music_alias(var_0, var_1) {
  if(!soundexists(var_0)) {
    return;
  }
  var_3 = 1.0;

  if(isdefined(var_1))
    var_3 = max(var_1, 0);

  if(level._audio.stream.music.curr.name == var_0) {
    level._audio.stream.music.curr = level._audio.stream.music.prev;
    smx_clear_struct(level._audio.stream.music.prev);
  } else if(level._audio.stream.ambience.prev.name == var_0)
    smx_clear_struct(level._audio.stream.music.prev);

  musicstop(var_3, var_0);
}

sm_stop_ambience(var_0) {
  var_1 = 1.0;

  if(isdefined(var_0))
    var_1 = var_0;

  ambientstop(var_1);
}

sm_stop_music(var_0) {
  var_1 = 1.0;

  if(isdefined(var_0))
    var_1 = var_0;

  smx_clear_struct(level._audio.stream.music.curr);
  smx_clear_struct(level._audio.stream.music.prev);
  musicstop(var_1);
}

sm_mix_ambience(var_0) {
  var_1 = 0.009;

  if(var_0.size == 1)
    smx_set_values_for_struct(level._audio.stream.ambience.curr, var_0[0].alias, var_0[0].vol, var_0[0].fade);
  else if(var_0.size == 2) {
    smx_set_values_for_struct(level._audio.stream.ambience.prev, var_0[0].alias, var_0[0].vol, var_0[0].fade);
    smx_set_values_for_struct(level._audio.stream.ambience.curr, var_0[1].alias, var_0[1].vol, var_0[1].fade);
  }

  for (var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6].alias;
    var_8 = max(var_0[var_6].vol, 0);
    var_9 = clamp(var_0[var_6].fade, 0, 1);

    if(var_7 != "none") {
      if(!soundexists(var_7)) {
        continue;
      }
      if(var_8 < var_1) {
        ambientstop(var_9, var_7);
        continue;
      }

      ambientplay(var_7, var_9, var_8, 0);
    }
  }
}

sm_get_current_ambience_name() {
  return level._audio.stream.ambience.curr.name;
}

sm_get_current_music_name() {
  return level._audio.stream.music.curr.name;
}

smx_set_values_for_struct(var_0, var_1, var_2, var_3) {
  var_0.name = var_1;
  var_0.vol = var_2;
  var_0.fade = var_3;
}

smx_create_struct() {
  var_0 = spawnstruct();
  var_0.name = "";
  var_0.vol = 0.0;
  var_0.fade = 0.0;
  return var_0;
}

smx_clear_struct(var_0) {
  var_0.name = "";
  var_0.vol = 0.0;
  var_0.fade = 0.0;
}