/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2827.gsc
***************************************/

init_audio() {
  if(isDefined(level.func_1188)) {
    return;
  }
  setdvarifuninitialized("debug_audio", "0");
  setdvarifuninitialized("debug_headroom", "-1");
  setdvarifuninitialized("music_enable", "1");
  level.func_1188 = spawnStruct();
  func_9785();
  thread func_ABD5();
}

func_9BB3() {
  if(!isDefined(level.func_1188.func_4E60)) {
    return 1;
  }

  return level.func_1188.func_4E60;
}

func_E2BB() {
  if(func_9BB3() || isDefined(level.func_1188.func_9392)) {
    level.func_1188.func_9392 = undefined;
    level.player clearpriorityclienttriggeraudiozone("deathsdoor");
    level.player clearsoundsubmix();

    if(isDefined(level.func_4E61)) {
      level.func_4E61 ghostattack(0, 2);
      wait 2;

      if(isDefined(level.func_4E61)) {
        level.func_4E61 stoploopsound("deaths_door_lp");
      }

      wait 0.05;

      if(isDefined(level.func_4E61)) {
        level.func_4E61 delete();
      }
    }
  }
}

func_F334() {
  level.func_1188.func_9392 = 1;

  if(func_9BB3()) {
    if(isDefined(level.func_4E62)) {
      thread func_D0D0();
      level.player _meth_8329(level.func_4E62, "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    } else {
      thread func_D0D0();
      level.player _meth_8329("deathsdoor", "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    }

    if(!isDefined(level.func_4E61)) {
      level.func_4E61 = spawn("script_origin", level.player.origin);
      level.func_4E61 ghostattack(0, 0.05);
      wait 0.05;
    }

    level.func_4E61 ghostattack(1, 2);
    level.func_4E61 playLoopSound("deaths_door_lp");
  }
}

func_D0D0() {
  self endon("death");
  var_00 = 0.85;
  wait 0.2;

  for(;;) {
    if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
      self playlocalsound("breathing_heartbeat");
    }
    else {
      break;
    }

    wait(var_00);
  }

  self playlocalsound("breathing_heartbeat_fade1");
  wait(var_00 + 0.1);
  self playlocalsound("breathing_heartbeat_fade2");
}

func_ABD5() {
  if(!isDefined(level.func_1188.func_ABD4)) {
    level.func_1188.func_ABD4 = 1.0;
  }

  wait 0.05;
  _levelsoundfade(1, level.func_1188.func_ABD4);
}

func_257D(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = 2;
  }

  if(!isDefined(var_04)) {
    var_04 = 2;
  }

  if(!isDefined(var_06)) {
    var_06 = 2;
  }

  if(isDefined(var_05)) {
    thread func_2AE8(var_00, var_05, var_06);
  }

  var_07 = var_04 + 0.05;
  var_08 = 1;

  if(isDefined(var_01)) {
    level.player _meth_82C0(var_01);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player _meth_82C0("fade_to_black_minus_music", var_02);

  while(1 && iscinematicplaying()) {
    var_09 = _cinematicgettimeinmsec() / 1000;
    var_10 = var_00 - var_09;

    if(var_10 <= var_07) {
      var_08 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_08 == 0) {
    if(isDefined(var_03)) {
      level.player _meth_82C0(var_03, var_04);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_04);
  } else
    level.player clearclienttriggeraudiozone();
}

func_2AE8(var_00, var_01, var_02) {
  var_03 = 1;
  var_04 = var_02 + 0.05;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    var_05 = _cinematicgettimeinmsec() / 1000;
    var_06 = var_00 - var_05;

    if(var_06 <= var_04) {
      var_03 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_03 == 0) {
    _setmusicstate(var_01);
  }
}

func_257C(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = 2;
  }

  if(isDefined(var_00)) {
    level.player _meth_82C0(var_00);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player _meth_82C0("fade_to_black_minus_music", var_01);
}

func_257B(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = 2;
  }

  var_05 = var_02 + 0.05;

  if(!isDefined(var_04)) {
    var_04 = 2;
  }

  if(isDefined(var_03)) {
    thread func_2AE8(var_00, var_03, var_04);
  }

  var_06 = 1;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    var_07 = _cinematicgettimeinmsec() / 1000;
    var_08 = var_00 - var_07;

    if(var_08 <= var_05) {
      var_06 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_06 == 0) {
    if(isDefined(var_01)) {
      level.player _meth_82C0(var_01, var_02);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_02);
  } else
    level.player clearclienttriggeraudiozone();
}

func_9785() {
  level.func_1188.func_11926 = spawnStruct();
  level.func_1188.func_11926.func_00C8 = "";
  func_F5CE("default");
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

func_25C0(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    var_00 = 2.5;
  }

  if(!isDefined(var_01)) {
    var_01 = "normal";
  }

  if(!isDefined(var_02)) {
    var_02 = "clear_all";
  }

  level.player playSound("plr_helmet_on_visor_down_lr");

  if(var_00 != 0.0) {
    level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
    wait(var_00);

    if(var_01 == "normal") {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
    }
    else {
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
    }

    if(var_02 == "clear_all") {
      level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
    }
    else {
      level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, var_02, 0.2);
    }
  }
}

func_25C1() {}

func_25C2(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    var_00 = 2.5;
  }

  if(!isDefined(var_01)) {
    var_01 = "normal";
  }

  if(!isDefined(var_02)) {
    var_02 = "clear_all";
  }

  level.player playSound("plr_helmet_visor_pull_down_w_air_lr");
  level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
  wait(var_00);

  if(var_01 == "normal") {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
  }
  else {
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");
  }

  if(var_02 == "clear_all") {
    level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
  }
  else {
    level.player scripts\engine\utility::delaycall(0.45, ::_meth_82C0, var_02, 0.2);
  }
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

func_F5CE(var_00) {
  if(level.func_1188.func_11926.func_00C8 == var_00) {
    return;
  }
  level.func_1188.func_11926.func_00C8 = var_00;
  level.player giveaward(var_00);
}

func_4F0F(var_00, var_01) {}

func_4ED0() {
  return 0;
}