/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\800.gsc
**************************************/

handle_crash_fx() {
  level waittill("crash_teleport");
  thread handle_sled_fx();
  thread handle_wing_fx();
  thread handle_engine_fx();
  thread handle_tail_fx();
  thread handle_tail_impact_fx();
  thread handle_volumetric_fx();
  level waittill("crash_impact");
  thread handle_paper_explosions();
  level waittill("crash_throw_player");
}

handle_paper_explosions() {
  var_0 = getEntArray("sled_paper_explosion", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_paper_explosion");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }

  level.crash_models[0] waittillmatch("single anim", "paper_start");
  playFXOnTag(common_scripts\utility::getfx("hijack_crash_papers"), level.crash_models[0], "J_Mid_Section");
  level.crash_models[0] waittillmatch("single anim", "paper_stop");
  stopFXOnTag(common_scripts\utility::getfx("hijack_crash_papers"), level.crash_models[0], "J_Mid_Section");
}

handle_volumetric_fx() {
  level waittill("crash_impact");
  wait 1;
  var_0 = getEntArray("crash_window_volseq1", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_crash_window_volumetric");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }

  wait 0.1;
  var_0 = getEntArray("crash_window_volseq2", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_crash_window_volumetric");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }

  wait 0.1;
  var_0 = getEntArray("crash_window_volseq3", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_crash_window_volumetric");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }

  wait 0.3;
  wait 0.1;
  wait 0.1;
  var_0 = getEntArray("crash_window_volseq6", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_crash_window_volumetric");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }

  wait 0.1;
  var_0 = getEntArray("crash_window_volseq7", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_crash_window_volumetric");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "sled_scrape_stop");
  }
}

handle_sled_fx() {
  level.crash_models[0] waittillmatch("single anim", "split");
  var_0 = level.crash_models[0];
  var_1 = common_scripts\utility::getfx("fuselage_break_sparks1");
  playFXOnTag(var_1, var_0, "FX_Mid_Break_1");
  playFXOnTag(var_1, var_0, "FX_Mid_Break_2");
  playFXOnTag(var_1, var_0, "FX_Mid_Break_3");
  var_2 = getEntArray("sled_drag", "script_noteworthy");

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::getfx("fuselage_scrape");
    playFXOnTag(var_5, var_4, "tag_origin");
    var_4 thread stop_fx_on_notify(var_5, "sled_scrape_stop");
  }
}

handle_wing_fx() {
  level waittill("crash_impact");
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("wing_fuel_explosion"), level.crash_models[0], "FX_R_Wing");
  level.crash_models[0] thread stop_fx_on_notify(common_scripts\utility::getfx("wing_fuel_explosion"), "sled_scrape_stop");
}

handle_engine_fx() {
  wait 6.733;
  playFXOnTag(common_scripts\utility::getfx("engine_explosion"), getEnt("engine_explosion", "script_noteworthy"), "tag_origin");
  level.crash_models[0] waittillmatch("single anim", "engine_fire");
  playFXOnTag(common_scripts\utility::getfx("hijack_engine_trail"), level.crash_models[0], "J_rwing_engine");
  var_0 = level.crash_models[0] gettagorigin("J_rwing_engine");
  playFX(common_scripts\utility::getfx("hijack_engine_split"), var_0);
}

handle_tail_fx() {
  var_0 = common_scripts\utility::getfx("smoke_geotrail_debris");
  var_1 = common_scripts\utility::getfx("reaper_explosion");
  var_2 = common_scripts\utility::getfx("hijack_engine_split");
  var_3 = common_scripts\utility::getfx("tail_wing_impact");
  wait 17.333;
  var_4 = getEnt("tail_wing_impact1", "script_noteworthy");
  playFXOnTag(var_2, var_4, "tag_origin");
  playFXOnTag(var_1, var_4, "tag_origin");
  level.player thread maps\_utility::play_sound_on_entity("hijk_explosion_lfe");
  wait 0.7333;
  var_4 = getEnt("tail_wing_impact2", "script_noteworthy");
  playFX(var_3, var_4.origin);
  wait 0.2667;
  var_4 = getEnt("tail_wing_impact3", "script_noteworthy");
  var_5 = level.crash_models[0] gettagorigin("J_RFin_tip2");
  playFX(var_1, var_5);
  level.player thread maps\_utility::play_sound_on_entity("hijk_explosion_lfe");
  wait 1.7333;
  var_4 = getEnt("tail_wing_impact4", "script_noteworthy");
  playFX(var_3, var_4.origin);
  playFXOnTag(var_2, var_4, "tag_origin");
  level.player thread maps\_utility::play_sound_on_entity("hijk_explosion_lfe");
  wait 0.6;
  common_scripts\utility::exploder(2000);
  maps\_audio::aud_send_msg("tower_impact");
  level notify("tail_hits_tower");
}

handle_tail_impact_fx() {
  var_0 = getEnt("tail_impact1", "script_noteworthy");
  wait 18.5;
  playFX(common_scripts\utility::getfx("hijack_tail_impact"), var_0.origin);
  playFXOnTag(common_scripts\utility::getfx("hijack_tail_trail"), level.crash_models[0], "J_Tail_Sled");
  level.crash_models[0] thread stop_fx_on_notify(common_scripts\utility::getfx("hijack_tail_trail"), "sled_scrape_stop");
  var_0 = getEnt("tail_impact2", "script_noteworthy");
  wait 1.3;
  playFX(common_scripts\utility::getfx("hijack_tail_impact"), var_0.origin);
  var_0 = getEnt("tail_spray", "script_noteworthy");
  wait 1;
  playFX(common_scripts\utility::getfx("hijack_tail_spray"), var_0.origin);
}

fluorescentflicker() {
  level endon("stop_flicker");

  for(;;) {
    wait(randomfloatrange(0.05, 0.1));
    self setlightintensity(randomfloatrange(0.25, 3.0));
  }
}

handle_pre_sled_lights() {
  common_scripts\utility::flag_wait("turn_on_crash_sled_lights");
  thread pre_sled_light();
}

pre_sled_light() {
  var_0 = getEntArray("sled_fill_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getfx("hijack_fxlight_default_med_dim");
    playFXOnTag(var_3, var_2, "tag_origin");
    var_2 thread stop_fx_on_notify(var_3, "crash_stop_pre_sled_lights");
  }
}

handle_crash_lights() {
  var_0 = getEntArray("sled_emergency_light_fx", "script_noteworthy");
  var_1 = common_scripts\utility::getfx("hijack_fx_light_red_blink");

  foreach(var_3 in var_0) {
    playFXOnTag(var_1, var_3, "tag_origin");
    var_3 thread stop_fx_on_notify(var_1, "crash_impact");
  }

  thread sled_emergency_light_post_impact_flicker();
  var_5 = getEnt("sled_emergency_spotlight_fx", "script_noteworthy");
  level waittill("crash_sequence_done");
}

sled_emergency_light_post_impact_flicker() {
  level waittill("crash_impact");
  wait 2.0;
  var_0 = getEntArray("sled_emergency_light_fx", "script_noteworthy");
  var_1 = common_scripts\utility::getfx("hijack_fxlight_red_blink_flicker");

  foreach(var_3 in var_0) {
    playFXOnTag(var_1, var_3, "tag_origin");
    var_3 thread stop_fx_on_notify(var_1, "crash_throw_player");
  }
}

stop_fx_on_notify(var_0, var_1) {
  level waittill(var_1);
  stopFXOnTag(var_0, self, "tag_origin");
}

custom_fire_fx(var_0) {
  var_0.a.lastshoottime = gettime();
  var_0 thread maps\_utility::play_sound_on_tag("weap_ak47_fire_npc", "tag_flash");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), var_0, "tag_flash");
  var_1 = var_0 gettagorigin("tag_weapon");
  var_2 = anglesToForward(var_0 getmuzzleangle());
  var_3 = var_1 + var_2 * 1000;
  magicbullet(var_0.weapon, var_1, var_3);
}