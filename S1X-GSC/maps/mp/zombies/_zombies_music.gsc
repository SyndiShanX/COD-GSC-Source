/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_music.gsc
**********************************************/

init() {
  level.zmmusicents = [];
  var_0 = 3;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.zmmusicents[var_1] = spawn("script_model", (0, 0, 0));
    level.zmmusicents[var_1] scalevolume(0);
    level.zmmusicents[var_1].index = var_1;
  }

  level.zmb_music_states = [];
  level.zmb_music_states_active = 1;
  level thread setupmusicstate(0, "round_start", "zmb_mus_roundcount", 0, 0, 0.5, 0);
  level thread setupmusicstate(1, "round_normal", ["zmb_mus_wave_01_lp", "zmb_mus_wave_02_lp", "zmb_mus_wave_03_lp"], 0, 1, 1, 1);
  level thread setupmusicstate(1, "round_zombie_dog", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread setupmusicstate(1, "round_zombie_host", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread setupmusicstate(0, "round_end", "zmb_mus_roundfinish", 0, 0, 0.5, 0);
  level thread setupmusicstate(2, "round_intermission", "zmb_mus_postround", 0, 1, 1, 0);
  level thread setupmusicstate(0, "game_over", "zmb_mus_sweeper", 0, 0, 0, 0);
  level thread setupmusicstate(-1, "player_died", "zmb_mus_deathsting", 1, 0, 0, 0);

  if(isDefined(level.customzombiemusicstates)) {
    level thread[[level.customzombiemusicstates]]();
  }
}

setupmusicstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_3) {
    var_0 = undefined;
  }

  if(!isDefined(level.zmb_music_states[var_1])) {
    level.zmb_music_states[var_1] = spawnStruct();
  }

  if(isarray(var_2)) {
    level.zmb_music_states[var_1].alias = var_2[0];
    level.zmb_music_states[var_1].alias_list = var_2;
  } else {
    level.zmb_music_states[var_1].alias = var_2;
  }

  level.zmb_music_states[var_1].ent_num = var_0;
  level.zmb_music_states[var_1].is_looping = var_4;
  level.zmb_music_states[var_1].on_player = var_3;
  level.zmb_music_states[var_1].start_wait = var_5;
  level.zmb_music_states[var_1].stop_wait = var_6;
}

changezombiemusic(var_0, var_1) {
  if(!level.zmb_music_states_active) {
    return;
  }
  var_2 = level.zmb_music_states[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(level.old_music_state)) {
    if(level.old_music_state == var_2) {
      return;
    } else if(level.old_music_state == level.zmb_music_states["game_over"]) {
      return;
    }
  }

  if(maps\mp\zombies\_util::getzombieslevelnum() == 4) {
    thread dimmallmusic(var_0, var_1);
  }

  thread _playmusic(var_2, var_1);
  level.old_music_state = var_2;
}

dimmallmusicforplayer() {
  self endon("disconnect");
  self clientaddsoundsubmix("h2o_dim_mall_music", 2);
  wait 20;
  self clientclearsoundsubmix("h2o_dim_mall_music", 5);
}

dimmallmusic(var_0, var_1) {
  if(var_0 == "player_died") {
    var_1 clientaddsoundsubmix("h2o_dim_mall_music", 2);
  } else {
    foreach(var_1 in level.players) {
      var_1 thread dimmallmusicforplayer();
    }
  }
}

shouldskipplayingmusic(var_0) {
  var_1 = 0;

  if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && var_0 == level.zmb_music_states["round_start_hard_mode"]) {
    var_1 = 1;
  }

  return var_0 != level.zmb_music_states["round_start"] && var_0 != level.zmb_music_states["round_end"] && !var_1 && isDefined(level.sq_song_ent) && maps\mp\zombies\_util::is_true(level.sq_song_ent.playing);
}

aliasisDefined(var_0) {
  if(soundexists(var_0)) {
    return 1;
  } else {
    return 0;
  }
}

disablemusicstatechanges() {
  level.zmb_music_states_active = 0;
}

enablemusicstatechanges() {
  level.zmb_music_states_active = 1;
}

_playmusic(var_0, var_1) {
  if(shouldskipplayingmusic(var_0)) {
    return;
  }
  if(isDefined(var_0.start_wait) && var_0.start_wait > 0) {
    wait(var_0.start_wait);
  }

  if(var_0 == level.zmb_music_states["round_intermission"]) {
    if(!aliasisDefined(var_0.alias)) {
      return;
    }
    var_2 = level.zmmusicents[var_0.ent_num];
    var_2 playLoopSound(var_0.alias);
    var_2 scalevolume(1, 0.5);
    wait 10;
    var_2 scalevolume(0, 5);
    wait 5;
    var_2 stoploopsound();
  } else if(var_0.is_looping) {
    var_2 = level.zmmusicents[var_0.ent_num];
    var_3 = var_0.alias;

    if(isDefined(var_0.alias_list)) {
      if(!isDefined(var_0.last_alias_index)) {
        var_0.last_alias_index = randomint(var_0.alias_list.size);
      } else {
        var_0.last_alias_index = (var_0.last_alias_index + 1) % var_0.alias_list.size;
      }

      var_3 = var_0.alias_list[var_0.last_alias_index];
      var_0.alias = var_3;
    }

    if(!aliasisDefined(var_3)) {
      return;
    }
    var_2 playLoopSound(var_3);
    var_2 scalevolume(1);
    thread _stoponroundend(var_2, var_0);

    if(level.roundtype == "normal") {
      thread _stopontimeelapsed(var_2, var_0);
      return;
    }
  } else if(var_0.on_player) {
    if(!aliasisDefined(var_0.alias)) {
      return;
    }
    var_1 playsoundtoplayer(var_0.alias, var_1);
  } else {
    if(!aliasisDefined(var_0.alias)) {
      return;
    }
    var_2 = level.zmmusicents[var_0.ent_num];
    var_2 playsoundonmovingent(var_0.alias);
    var_2 scalevolume(1);
  }
}

_stoponroundend(var_0, var_1) {
  level endon("zombie_stopOnTimeElapsed");
  level waittill("zombie_wave_ended");

  if(isDefined(var_1.stop_wait) && var_1.stop_wait > 0) {
    wait(var_1.stop_wait);
  }

  var_0 scalevolume(0, 2);
  wait 2;
  var_0 stoploopsound();
  var_0 scalevolume(1);
}

_stopontimeelapsed(var_0, var_1) {
  level endon("zombie_wave_ended");
  wait 20;
  var_0 scalevolume(0, 20);
  wait 20;
  var_0 stoploopsound();
  var_0 scalevolume(1);
  level notify("zombie_stopOnTimeElapsed");
}