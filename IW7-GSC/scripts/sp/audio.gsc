/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\audio.gsc
********************************/

init_audio() {
  if(isDefined(level.var_1188)) {
    return;
  }

  setdvarifuninitialized("debug_audio", "0");
  setdvarifuninitialized("debug_headroom", "-1");
  setdvarifuninitialized("music_enable", "1");
  level.var_1188 = spawnStruct();
  func_9785();
  thread func_ABD5();
}

func_9BB3() {
  if(!isDefined(level.var_1188.var_4E60)) {
    return 1;
  }

  return level.var_1188.var_4E60;
}

func_E2BB() {
  if(func_9BB3() || isDefined(level.var_1188.var_9392)) {
    level.var_1188.var_9392 = undefined;
    level.player clearpriorityclienttriggeraudiozone("deathsdoor");
    level.player clearsoundsubmix();
    if(isDefined(level.var_4E61)) {
      level.var_4E61 ghostattack(0, 2);
      wait(2);
      if(isDefined(level.var_4E61)) {
        level.var_4E61 stoploopsound("deaths_door_lp");
      }

      wait(0.05);
      if(isDefined(level.var_4E61)) {
        level.var_4E61 delete();
        return;
      }
    }
  }
}

func_F334() {
  level.var_1188.var_9392 = 1;
  if(func_9BB3()) {
    if(isDefined(level.var_4E62)) {
      thread func_D0D0();
      level.player _meth_8329(level.var_4E62, "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    } else {
      thread func_D0D0();
      level.player _meth_8329("deathsdoor", "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    }

    if(!isDefined(level.var_4E61)) {
      level.var_4E61 = spawn("script_origin", level.player.origin);
      level.var_4E61 ghostattack(0, 0.05);
      wait(0.05);
    }

    level.var_4E61 ghostattack(1, 2);
    level.var_4E61 playLoopSound("deaths_door_lp");
  }
}

func_D0D0() {
  self endon("death");
  var_00 = 0.85;
  wait(0.2);
  for(;;) {
    if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
      self playlocalsound("breathing_heartbeat");
    } else {
      break;
    }

    wait(var_00);
  }

  self playlocalsound("breathing_heartbeat_fade1");
  wait(var_00 + 0.1);
  self playlocalsound("breathing_heartbeat_fade2");
}

func_ABD5() {
  if(!isDefined(level.var_1188.var_ABD4)) {
    level.var_1188.var_ABD4 = 1;
  }

  wait(0.05);
  levelsoundfade(1, level.var_1188.var_ABD4);
}

func_257D(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 2;
  }

  if(!isDefined(param_04)) {
    param_04 = 2;
  }

  if(!isDefined(param_06)) {
    param_06 = 2;
  }

  if(isDefined(param_05)) {
    thread func_2AE8(param_00, param_05, param_06);
  }

  var_07 = param_04 + 0.05;
  var_08 = 1;
  if(isDefined(param_01)) {
    level.player _meth_82C0(param_01);
  }

  while(!iscinematicplaying()) {
    wait(0.05);
  }

  level.player _meth_82C0("fade_to_black_minus_music", param_02);
  while(1 && iscinematicplaying()) {
    var_09 = cinematicgettimeinmsec() / 1000;
    var_0A = param_00 - var_09;
    if(var_0A <= var_07) {
      var_08 = 0;
      break;
    }

    wait(0.05);
  }

  if(var_08 == 0) {
    if(isDefined(param_03)) {
      level.player _meth_82C0(param_03, param_04);
      wait(2);
      level.player clearclienttriggeraudiozone(2);
      return;
    }

    level.player clearclienttriggeraudiozone(param_04);
    return;
  }

  level.player clearclienttriggeraudiozone();
}

func_2AE8(param_00, param_01, param_02) {
  var_03 = 1;
  var_04 = param_02 + 0.05;
  while(!iscinematicplaying()) {
    wait(0.05);
  }

  while(1 && iscinematicplaying()) {
    var_05 = cinematicgettimeinmsec() / 1000;
    var_06 = param_00 - var_05;
    if(var_06 <= var_04) {
      var_03 = 0;
      break;
    }

    wait(0.05);
  }

  if(var_03 == 0) {
    setmusicstate(param_01);
  }
}

func_257C(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 2;
  }

  if(isDefined(param_00)) {
    level.player _meth_82C0(param_00);
  }

  while(!iscinematicplaying()) {
    wait(0.05);
  }

  level.player _meth_82C0("fade_to_black_minus_music", param_01);
}

func_257B(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 2;
  }

  var_05 = param_02 + 0.05;
  if(!isDefined(param_04)) {
    param_04 = 2;
  }

  if(isDefined(param_03)) {
    thread func_2AE8(param_00, param_03, param_04);
  }

  var_06 = 1;
  while(!iscinematicplaying()) {
    wait(0.05);
  }

  while(1 && iscinematicplaying()) {
    var_07 = cinematicgettimeinmsec() / 1000;
    var_08 = param_00 - var_07;
    if(var_08 <= var_05) {
      var_06 = 0;
      break;
    }

    wait(0.05);
  }

  if(var_06 == 0) {
    if(isDefined(param_01)) {
      level.player _meth_82C0(param_01, param_02);
      wait(2);
      level.player clearclienttriggeraudiozone(2);
      return;
    }

    level.player clearclienttriggeraudiozone(param_02);
    return;
  }

  level.player clearclienttriggeraudiozone();
}

func_9785() {
  level.var_1188.var_11926 = spawnStruct();
  level.var_1188.var_11926.var_C8 = "";
  func_F5CE("default");
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("musicnopause_lr", 0);
  soundsettimescalefactor("musicnopause_lsrs", 0);
  soundsettimescalefactor("mus_emitter_3d", 0);
  soundsettimescalefactor("menu_unres_2d", 0);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("menu_2_2d_lim", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("scn_fx_res_3d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
}

func_F5A0() {
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

func_F59F() {
  soundsettimescalefactor("voice_air_3d", 1);
  soundsettimescalefactor("voice_special_2d", 1);
  soundsettimescalefactor("voice_narration_2d", 1);
  soundsettimescalefactor("voice_plr_2d", 1);
  soundsettimescalefactor("voice_radio_2d", 1);
  soundsettimescalefactor("voice_plr_efforts_2d", 1);
  soundsettimescalefactor("voice_plr_breath_2d", 1);
  soundsettimescalefactor("voice_animal_1_3d", 1);
  soundsettimescalefactor("voice_bchatter_1_3d", 1);
}

func_25C0(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 2.5;
  }

  if(!isDefined(param_01)) {
    param_01 = "normal";
  }

  if(!isDefined(param_02)) {
    param_02 = "clear_all";
  }

  level.player playSound("plr_helmet_on_visor_down_lr");
  if(param_00 != 0) {
    level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
    wait(param_00);
    if(param_01 == "normal") {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
    } else {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
    }

    if(param_02 == "clear_all") {
      level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
      return;
    }

    level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, param_02, 0.2);
  }
}

func_25C1() {}

func_25C2(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 2.5;
  }

  if(!isDefined(param_01)) {
    param_01 = "normal";
  }

  if(!isDefined(param_02)) {
    param_02 = "clear_all";
  }

  level.player playSound("plr_helmet_visor_pull_down_w_air_lr");
  level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
  wait(param_00);
  if(param_01 == "normal") {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
  } else {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
  }

  if(param_02 == "clear_all") {
    level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
    return;
  }

  level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, param_02, 0.2);
}

func_25C3() {
  level.player playSound("plr_helmet_visor_pull_up_w_air_lr");
}

func_25BF() {
  level.player playSound("plr_helmet_off_lr");
  level.player playSound("plr_helmet_off_lyr_lr");
  level.player clearclienttriggeraudiozone(0.25);
}

func_25BE() {
  level.player playSound("plr_helmet_off_lr");
}

func_F5CE(param_00) {
  if(level.var_1188.var_11926.var_C8 == param_00) {
    return;
  }

  level.var_1188.var_11926.var_C8 = param_00;
  level.player giveaward(param_00);
}

func_4F0F(param_00, param_01) {}

func_4ED0() {
  return 0;
}