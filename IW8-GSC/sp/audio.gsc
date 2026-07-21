/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\audio.gsc
***********************************************/

init_audio() {
  level.player clearallsoundsubmixes(0.05);

  if(isDefined(level.audio) && isDefined(level.audio.initialized)) {
    return;
  }
  init_audio_struct();
  level.audio.initialized = 1;
  setdvarifuninitialized("debug_audio", "0");
  setdvarifuninitialized("debug_headroom", "-1");
  setdvarifuninitialized("music_enable", "1");
  init_timescale();
  thread level_fadein();
}

rex_emitter_test() {
  wait 2;
  var_0 = 0;

  for(;;) {
    if(level.player buttonPressed("DPAD_UP")) {
      radiusdamage(level.player.origin, 1500, 150, 10, undefined, "MOD_EXPLOSIVE");
      wait 2;
    }

    wait 0.1;
  }
}

init_audio_struct() {
  if(!isDefined(level.audio))
    level.audio = spawnStruct();
}

is_deathsdoor_audio_enabled() {
  if(!isDefined(level.audio.deathsdoor_enabled))
    return 1;

  return level.audio.deathsdoor_enabled;
}

restore_after_deathsdoor(var_0) {
  if(is_deathsdoor_audio_enabled() || isDefined(level.audio.in_deathsdoor)) {
    level.audio.in_deathsdoor = undefined;
    level.player clearpriorityclienttriggeraudiozone("deathsdoor");
    level.player clearsoundsubmix("deaths_door_sp");

    if(isDefined(level.deathsdoor_sfx)) {
      wait(var_0);

      if(isDefined(level.deathsdoor_sfx)) {
        level.deathsdoor_sfx playSound("deaths_door_out", "sounddone");
        level.deathsdoor_sfx waittill("sounddone");
      }

      if(isDefined(level.deathsdoor_sfx))
        level.deathsdoor_sfx delete();
    }
  }
}

set_deathsdoor() {
  level.audio.in_deathsdoor = 1;

  if(is_deathsdoor_audio_enabled()) {
    if(isDefined(level.deathsdooroverride)) {
      level.player setpriorityclienttriggeraudiozonepartial(level.deathsdooroverride, "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    } else {
      level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
      level.player setsoundsubmix("deaths_door_sp");
    }

    if(!isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx = spawn("script_origin", level.player.origin);
      wait 0.05;
    }

    level.deathsdoor_sfx playSound("deaths_door_in");
  }
}

stop_deaths_door_audio() {
  if(isDefined(level.deathsdoor_sfx)) {
    level.deathsdoor_sfx scalevolume(0, 2);
    wait 2;

    if(isDefined(level.deathsdoor_sfx))
      level.deathsdoor_sfx stopsounds();

    wait 0.05;

    if(isDefined(level.deathsdoor_sfx))
      level.deathsdoor_sfx delete();
  }
}

level_fadein() {
  if(!isDefined(level.audio.level_fade_time))
    level.audio.level_fade_time = 1;

  wait 0.05;
  levelsoundfade(1, level.audio.level_fade_time);
}

set_audio_level_fade_time(var_0) {
  init_audio_struct();
  level.audio.level_fade_time = var_0;
}

audio_bink_transition_ambient(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 2;

  if(!isDefined(var_4))
    var_4 = 2;

  if(!isDefined(var_6))
    var_6 = 2;

  if(isDefined(var_5))
    thread bink_transition_music(var_0, var_5, var_6);

  var_7 = var_4 + 0.05;
  var_8 = 1;

  if(isDefined(var_1))
    level.player setclienttriggeraudiozone(var_1);

  while(!iscinematicplaying())
    wait 0.05;

  level.player setclienttriggeraudiozone("fade_to_black_minus_music", var_2);

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
      level.player setclienttriggeraudiozone(var_3, var_4);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_4);
  } else
    level.player clearclienttriggeraudiozone();
}

bink_transition_music(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = var_2 + 0.05;

  while(!iscinematicplaying())
    wait 0.05;

  while(1 && iscinematicplaying()) {
    var_5 = cinematicgettimeinmsec() / 1000;
    var_6 = var_0 - var_5;

    if(var_6 <= var_4) {
      var_3 = 0;
      break;
    }

    wait 0.05;
  }

  if(var_3 == 0)
    setmusicstate(var_1);
}

audio_bink_fadeout_ambient(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2;

  if(isDefined(var_0))
    level.player setclienttriggeraudiozone(var_0);

  while(!iscinematicplaying())
    wait 0.05;

  level.player setclienttriggeraudiozone("fade_to_black_minus_music", var_1);
}

audio_bink_fadein_ambient(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 2;

  var_5 = var_2 + 0.05;

  if(!isDefined(var_4))
    var_4 = 2;

  if(isDefined(var_3))
    thread bink_transition_music(var_0, var_3, var_4);

  var_6 = 1;

  while(!iscinematicplaying())
    wait 0.05;

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
      level.player setclienttriggeraudiozone(var_1, var_2);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else
      level.player clearclienttriggeraudiozone(var_2);
  } else
    level.player clearclienttriggeraudiozone();
}

init_timescale() {
  level.audio.timescale = spawnStruct();
  level.audio.timescale.current = "";
  set_timescale("default");
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

set_slowmo_dialogue_start() {
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

set_slowmo_dialogue_end() {
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

set_slowmo_sniper_breath_start() {
  soundsettimescalefactor("voice_air_3d", 0.05);
  soundsettimescalefactor("voice_special_2d", 0.05);
  soundsettimescalefactor("voice_narration_2d", 0.05);
  soundsettimescalefactor("voice_plr_2d", 0.05);
  soundsettimescalefactor("voice_radio_2d", 0.05);
  soundsettimescalefactor("voice_plr_efforts_2d", 0.05);
  soundsettimescalefactor("voice_plr_breath_2d", 0.05);
  soundsettimescalefactor("voice_animal_1_3d", 0.05);
  soundsettimescalefactor("voice_bchatter_1_3d", 0.05);
  soundsettimescalefactor("amb_bed_2d", 0.2);
  soundsettimescalefactor("shock_nofilter_2d", 0.05);
  soundsettimescalefactor("explo_main_3d", 0.05);
  soundsettimescalefactor("explo_close_3d", 0.05);
  soundsettimescalefactor("explo_body_3d", 0.05);
  soundsettimescalefactor("explo_body2_3d", 0.05);
  soundsettimescalefactor("explo_debris_3d", 0.05);
  soundsettimescalefactor("explo_atmo_3d", 0.05);
  soundsettimescalefactor("explo_atmo_alt_3d", 0.05);
  soundsettimescalefactor("explo_lfe_3d", 0.05);
  soundsettimescalefactor("explo_dist_3d", 0.05);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.05);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.05);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.05);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.05);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.05);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0.05);
}

set_slowmo_sniper_breath_end() {
  set_slowmo_dialogue_end();
  soundsettimescalefactor("amb_bed_2d", 1.0);
  soundsettimescalefactor("shock_nofilter_2d", 1.0);
  soundsettimescalefactor("explo_main_3d", 1.0);
  soundsettimescalefactor("explo_close_3d", 1.0);
  soundsettimescalefactor("explo_body_3d", 1.0);
  soundsettimescalefactor("explo_body2_3d", 1.0);
  soundsettimescalefactor("explo_debris_3d", 1.0);
  soundsettimescalefactor("explo_atmo_3d", 1.0);
  soundsettimescalefactor("explo_atmo_alt_3d", 1.0);
  soundsettimescalefactor("explo_lfe_3d", 1.0);
  soundsettimescalefactor("explo_dist_3d", 1.0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 1.0);
  soundsettimescalefactor("weap_plr_fire_2_2d", 1.0);
  soundsettimescalefactor("weap_plr_fire_3_2d", 1.0);
  soundsettimescalefactor("weap_plr_fire_4_2d", 1.0);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 1.0);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 1.0);
}

audio_helmet_transition_helmet_on_visor_down_w_lma(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 2.5;

  if(!isDefined(var_1))
    var_1 = "normal";

  if(!isDefined(var_2))
    var_2 = "clear_all";

  level.player playSound("plr_helmet_on_visor_down_lr");

  if(var_0 != 0.0) {
    level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
    wait(var_0);

    if(var_1 == "normal")
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
    else
      level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");

    if(var_2 == "clear_all")
      level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
    else
      level.player scripts\engine\utility::delaycall(0.45, ::setclienttriggeraudiozone, var_2, 0.2);
  }
}

audio_helmet_transition_helmet_on_visor_up_no_lma() {}

audio_helmet_transition_visor_down_w_lma(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 2.5;

  if(!isDefined(var_1))
    var_1 = "normal";

  if(!isDefined(var_2))
    var_2 = "clear_all";

  level.player playSound("plr_helmet_visor_pull_down_w_air_lr");
  level.player scripts\engine\utility::delaycall(0.5, ::setclienttriggeraudiozonepartialwithfade, "helmet_on_visor_down", 0.2, "mix", "filter");
  wait(var_0);

  if(var_1 == "normal")
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_short_boot_up_lr");
  else
    level.player scripts\engine\utility::delaycall(0.1, ::playsound, "plr_helmet_boot_up_fast_lr");

  if(var_2 == "clear_all")
    level.player scripts\engine\utility::delaycall(0.45, ::clearclienttriggeraudiozone, 0.2);
  else
    level.player scripts\engine\utility::delaycall(0.45, ::setclienttriggeraudiozone, var_2, 0.2);
}

audio_helmet_transition_visor_up() {
  level.player playSound("plr_helmet_visor_pull_up_w_air_lr");
}

audio_helmet_transition_helmet_off_release_scripted_filter() {
  level.player playSound("plr_helmet_off_lr");
  level.player playSound("plr_helmet_off_lyr_lr");
  level.player clearclienttriggeraudiozone(0.25);
}

audio_helmet_transition_helmet_off_no_filter_change() {
  level.player playSound("plr_helmet_off_lr");
}

set_timescale(var_0) {
  if(level.audio.timescale.current == var_0) {
    return;
  }
  level.audio.timescale.current = var_0;
  level.player settimescalefactorfromtable(var_0);
}

debug_println(var_0, var_1) {}

debug_enabled() {
  return 0;
}