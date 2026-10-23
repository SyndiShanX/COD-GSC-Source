/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1364.gsc
**************************************/

init() {
  level.zmmusicents = [];
  var_0 = 3;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.zmmusicents[var_1] = spawn("script_model", (0, 0, 0));
    level.zmmusicents[var_1] scalevolume(0);
    level.zmmusicents[var_1]._id_00D4 = var_1;
  }

  level.zmb_music_states = [];
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

  if(_isarray(var_2)) {
    level.zmb_music_states[var_1]._id_0BB4 = var_2[0];
    level.zmb_music_states[var_1]._id_0BB5 = var_2;
  } else
    level.zmb_music_states[var_1]._id_0BB4 = var_2;

  level.zmb_music_states[var_1].ent_num = var_0;
  level.zmb_music_states[var_1].is_looping = var_4;
  level.zmb_music_states[var_1].on_player = var_3;
  level.zmb_music_states[var_1].start_wait = var_5;
  level.zmb_music_states[var_1].stop_wait = var_6;
}

changezombiemusic(var_0, var_1) {
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

  thread _id_06A0(var_2, var_1);
  level.old_music_state = var_2;
}

_id_06A0(var_0, var_1) {
  if(1) {
    return;
  }
  if(isDefined(var_0.start_wait) && var_0.start_wait > 0) {
    wait(var_0.start_wait);
  }

  if(var_0 == level.zmb_music_states["round_intermission"]) {
    var_2 = level.zmmusicents[var_0.ent_num];
    var_2 playLoopSound(var_0._id_0BB4);
    var_2 scalevolume(1, 0.5);
    wait 10;
    var_2 scalevolume(0, 5);
    wait 5;
    var_2 stoploopsound();
  } else if(var_0.is_looping) {
    var_2 = level.zmmusicents[var_0.ent_num];
    var_3 = var_0._id_0BB4;

    if(isDefined(var_0._id_0BB5)) {
      if(!isDefined(var_0.last_alias_index)) {
        var_0.last_alias_index = randomint(var_0._id_0BB5.size);
      } else {
        var_0.last_alias_index = (var_0.last_alias_index + 1) % var_0._id_0BB5.size;
      }

      var_3 = var_0._id_0BB5[var_0.last_alias_index];
      var_0._id_0BB4 = var_3;
    }

    var_2 playLoopSound(var_3);
    var_2 scalevolume(1);
    thread _id_0726(var_2, var_0);

    if(level.roundtype == "normal") {
      thread _id_0727(var_2, var_0);
      return;
    }
  } else if(var_0.on_player)
    var_1 playsoundtoplayer(var_0._id_0BB4, var_1);
  else {
    var_2 = level.zmmusicents[var_0.ent_num];
    var_2 playsoundonmovingent(var_0._id_0BB4);
    var_2 scalevolume(1);
  }
}

_id_0726(var_0, var_1) {
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

_id_0727(var_0, var_1) {
  level endon("zombie_wave_ended");
  wait 20;
  var_0 scalevolume(0, 20);
  wait 20;
  var_0 stoploopsound();
  var_0 scalevolume(1);
  level notify("zombie_stopOnTimeElapsed");
}