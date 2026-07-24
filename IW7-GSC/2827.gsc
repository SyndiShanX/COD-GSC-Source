/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2827.gsc
**************************************/

init_audio() {
  if(isDefined(level._id_1188)) {
    return;
  }
  setdvarifuninitialized("debug_audio", "0");
  setdvarifuninitialized("debug_headroom", "-1");
  setdvarifuninitialized("music_enable", "1");
  level._id_1188 = spawnStruct();
  _id_9785();
  thread _id_ABD5();
}

_id_9BB3() {
  if(!isDefined(level._id_1188._id_4E60)) {
    return 1;
  }

  return level._id_1188._id_4E60;
}

_id_E2BB() {
  if(_id_9BB3() || isDefined(level._id_1188._id_9392)) {
    level._id_1188._id_9392 = undefined;
    level.player clearpriorityclienttriggeraudiozone("deathsdoor");
    level.player clearsoundsubmix();

    if(isDefined(level._id_4E61)) {
      level._id_4E61 _meth_8278(0, 2);
      wait 2;

      if(isDefined(level._id_4E61)) {
        level._id_4E61 stoploopsound("deaths_door_lp");
      }

      wait 0.05;

      if(isDefined(level._id_4E61)) {
        level._id_4E61 delete();
      }
    }
  }
}

_id_F334() {
  level._id_1188._id_9392 = 1;

  if(_id_9BB3()) {
    if(isDefined(level._id_4E62)) {
      thread _id_D0D0();
      level.player _meth_8329(level._id_4E62, "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    } else {
      thread _id_D0D0();
      level.player _meth_8329("deathsdoor", "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    }

    if(!isDefined(level._id_4E61)) {
      level._id_4E61 = spawn("script_origin", level.player.origin);
      level._id_4E61 _meth_8278(0, 0.05);
      wait 0.05;
    }

    level._id_4E61 _meth_8278(1, 2);
    level._id_4E61 playLoopSound("deaths_door_lp");
  }
}

_id_D0D0() {
  self endon("death");
  var_0 = 0.85;
  wait 0.2;

  for(;;) {
    if(scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay")) {
      self playlocalsound("breathing_heartbeat");
    } else {
      break;
    }

    wait(var_0);
  }

  self playlocalsound("breathing_heartbeat_fade1");
  wait(var_0 + 0.1);
  self playlocalsound("breathing_heartbeat_fade2");
}

_id_ABD5() {
  if(!isDefined(level._id_1188._id_ABD4)) {
    level._id_1188._id_ABD4 = 1.0;
  }

  wait 0.05;
  levelsoundfade(1, level._id_1188._id_ABD4);
}

_id_257D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  if(!isDefined(var_4)) {
    var_4 = 2;
  }

  if(!isDefined(var_6)) {
    var_6 = 2;
  }

  if(isDefined(var_5)) {
    thread _id_2AE8(var_0, var_5, var_6);
  }

  var_7 = var_4 + 0.05;
  var_8 = 1;

  if(isDefined(var_1)) {
    level.player _meth_82C0(var_1);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player _meth_82C0("fade_to_black_minus_music", var_2);

  while(1 && iscinematicplaying()) {
    var_9 = cinematicgettimeinmsec() / 1000;
    var_10 = var_0 - var_9;

    if(var_10 <= var_7) {
      var_8 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_8 == 0) {
    if(isDefined(var_3)) {
      level.player _meth_82C0(var_3, var_4);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_4);
  } else
    level.player clearclienttriggeraudiozone();
}

_id_2AE8(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = var_2 + 0.05;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    var_5 = cinematicgettimeinmsec() / 1000;
    var_6 = var_0 - var_5;

    if(var_6 <= var_4) {
      var_3 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_3 == 0) {
    setmusicstate(var_1);
  }
}

_id_257C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  if(isDefined(var_0)) {
    level.player _meth_82C0(var_0);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player _meth_82C0("fade_to_black_minus_music", var_1);
}

_id_257B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  var_5 = var_2 + 0.05;

  if(!isDefined(var_4)) {
    var_4 = 2;
  }

  if(isDefined(var_3)) {
    thread _id_2AE8(var_0, var_3, var_4);
  }

  var_6 = 1;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    var_7 = cinematicgettimeinmsec() / 1000;
    var_8 = var_0 - var_7;

    if(var_8 <= var_5) {
      var_6 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_6 == 0) {
    if(isDefined(var_1)) {
      level.player _meth_82C0(var_1, var_2);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_2);
  } else
    level.player clearclienttriggeraudiozone();
}

_id_9785() {
  level._id_1188._id_11926 = spawnStruct();
  level._id_1188._id_11926._id_00C8 = "";
  _id_F5CE("default");
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("musicnopause_lr", 0);
  soundsettimescalefactor("musicnopause_lsrs", 0);
  soundsettimescalefactor("mus_emitter_3d", 0);
  soundsettimescalefactor("menu_unres_2d", 0);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("menu_2_2d_lim", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0.0);
  soundsettimescalefactor("scn_fx_res_3d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
}

_id_F5A0() {
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_special_2d", 0);
  soundsettimescalefactor("voice_narration_2d", 0);
  soundsettimescalefactor("voice_plr_2d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_plr_efforts_2d", 0);
  soundsettimescalefactor("voice_plr_breath_2d", 0);
  soundsettimescalefactor("voice_animal_1_3d", 0);
  soundsettimescalefactor("voice_bchatter_1_3d", 0);
}

_id_F59F() {
  soundsettimescalefactor("voice_air_3d", 1.0);
  soundsettimescalefactor("voice_special_2d", 1.0);
  soundsettimescalefactor("voice_narration_2d", 1.0);
  soundsettimescalefactor("voice_plr_2d", 1.0);
  soundsettimescalefactor("voice_radio_2d", 1.0);
  soundsettimescalefactor("voice_plr_efforts_2d", 1.0);
  soundsettimescalefactor("voice_plr_breath_2d", 1.0);
  soundsettimescalefactor("voice_animal_1_3d", 1.0);
  soundsettimescalefactor("voice_bchatter_1_3d", 1.0);
}

_id_25C0(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 2.5;
  }

  if(!isDefined(var_1)) {
    var_1 = "normal";
  }

  if(!isDefined(var_2)) {
    var_2 = "clear_all";
  }

  level.player playSound("plr_helmet_on_visor_down_lr");

  if(var_0 != 0.0) {
    level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
    wait(var_0);

    if(var_1 == "normal") {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
    } else {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
    }

    if(var_2 == "clear_all") {
      level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
    } else {
      level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, var_2, 0.2);
    }
  }
}

_id_25C1() {}

_id_25C2(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 2.5;
  }

  if(!isDefined(var_1)) {
    var_1 = "normal";
  }

  if(!isDefined(var_2)) {
    var_2 = "clear_all";
  }

  level.player playSound("plr_helmet_visor_pull_down_w_air_lr");
  level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
  wait(var_0);

  if(var_1 == "normal") {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
  } else {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
  }

  if(var_2 == "clear_all") {
    level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
  } else {
    level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, var_2, 0.2);
  }
}

_id_25C3() {
  level.player playSound("plr_helmet_visor_pull_up_w_air_lr");
}

_id_25BF() {
  level.player playSound("plr_helmet_off_lr");
  level.player playSound("plr_helmet_off_lyr_lr");
  level.player clearclienttriggeraudiozone(0.25);
}

_id_25BE() {
  level.player playSound("plr_helmet_off_lr");
}

_id_F5CE(var_0) {
  if(level._id_1188._id_11926._id_00C8 == var_0) {
    return;
  }
  level._id_1188._id_11926._id_00C8 = var_0;
  level.player settimescalefactorfromtable(var_0);
}

_id_4F0F(var_0, var_1) {}

_id_4ED0() {
  return 0;
}