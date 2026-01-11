/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_deck_tilt.gsc
**************************************/

deck_tilt_pre_load() {
  common_scripts\utility::flag_init("deck_tilt_finished");
  common_scripts\utility::flag_init("show_ocean_water");
  common_scripts\utility::flag_init("hide_ocean_water");
  common_scripts\utility::flag_init("damage_slide");
  common_scripts\utility::flag_init("hesh_react_rog");
  common_scripts\utility::flag_init("player_vault_tugger");
  common_scripts\utility::flag_init("player_vaulting");
  common_scripts\utility::flag_init("go_vault");
  common_scripts\utility::flag_init("player_vaulting_active");
  common_scripts\utility::flag_init("stop_player_vault");
  common_scripts\utility::flag_init("vault_1_done");
  common_scripts\utility::flag_init("vault_2_done");
  common_scripts\utility::flag_init("vault_3_done");
  common_scripts\utility::flag_init("player_tower_stumble");
  common_scripts\utility::flag_init("stop_dmg_check");
  common_scripts\utility::flag_init("slide_fade_out");
  common_scripts\utility::flag_init("tower_corner_hit");
  common_scripts\utility::flag_init("rog_impacts_deck");
  common_scripts\utility::flag_init("carrier_front_impact");
  common_scripts\utility::flag_init("antenna_start");
  common_scripts\utility::flag_init("antenna_done");
  common_scripts\utility::flag_init("tilt_part_1");
  common_scripts\utility::flag_init("tilt_part_2");
  common_scripts\utility::flag_init("tilt_part_10");
  common_scripts\utility::flag_init("tilt_part_15");
  common_scripts\utility::flag_init("tilt_part_23");
  common_scripts\utility::flag_init("tilt_part_30");
  common_scripts\utility::flag_init("tilt_part_35");
  common_scripts\utility::flag_init("tilt_part_40");
  common_scripts\utility::flag_init("dt_hesh_gogo");
  common_scripts\utility::flag_init("dt_hesh_towerdown");
  common_scripts\utility::flag_init("dt_hesh_right");
  common_scripts\utility::flag_init("dt_hesh_osprey");
  common_scripts\utility::flag_init("dt_hesh_watch");
  common_scripts\utility::flag_init("dt_hesh_heli");
  common_scripts\utility::flag_init("dt_hesh_makeit");
  common_scripts\utility::flag_init("dt_hesh_geton");
  common_scripts\utility::flag_init("ally_at_silenthawk");
  common_scripts\utility::flag_init("player_can_exfil");
  common_scripts\utility::flag_init("exfil_go");
  precacheshellshock("carrier_deck");
  precacherumble("heavy_1s");
  precacherumble("heavy_2s");
  precacherumble("heavy_3s");
  precacherumble("carrier_rod_of_god");
  precacherumble("carrier_tower_fall");
  precacherumble("carrier_plane_slide");
  precachemodel("crr_rog_hole_fragments01");
  precachemodel("crr_rog_hole_fragments02");
  precachemodel("crr_rog_hole_fragments03");
  precachemodel("generic_prop_x30_raven");
  precachemodel("generic_prop_x3_raven");
  precachemodel("crr_island_damage_piece_anim");
  precachemodel("viewmodel_msbs");
  precachemodel("viewmodel_acog_iw6");
  precachemodel("viewmodel_eotech_iw6");
  precacheshader("hint_mantle");
  precachestring(&"SCRIPT_MANTLE");
  precachestring(&"CARRIER_FAIL_DECK_TILT");
  level.deck_destroyed_odin = getEntArray("deck_destroyed_odin", "targetname");
  common_scripts\utility::array_thread(level.deck_destroyed_odin, maps\_utility::hide_entity);
  var_0 = getEntArray("deck_tilt_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  level.deck_damage = getEntArray("deck_damaged", "targetname");
  common_scripts\utility::array_thread(level.deck_damage, maps\_utility::hide_entity);
  var_1 = getEntArray("tower_panel_clean", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::hide_entity);
  var_2 = getent("deck_tilt_tugger_1", "targetname");
  var_2 maps\_utility::hide_entity();
  var_3 = getent("deck_tilt_tugger_1_clip", "targetname");
  var_3 maps\_utility::hide_entity();
  var_4 = getent("deck_tilt_tugger_1_mantle", "targetname");
  var_4 hide();
  var_5 = getEntArray("tower_damage", "targetname");
  common_scripts\utility::array_thread(var_5, maps\_utility::hide_entity);
  level.exploding_heli = getent("exploding_heli", "targetname");
  level.exploding_heli maps\_utility::hide_entity();
  var_6 = getEntArray("barrel_alpha", "targetname");

  foreach(var_8 in var_6) {
    var_8 movez(-4096, 0.05);
  }

  common_scripts\utility::array_thread(var_6, maps\_utility::hide_entity);
  var_10 = getent("tilt_osprey_clip", "targetname");
  var_11 = getent("tilt_osprey_left_engine_clip", "targetname");
  var_12 = getent("tilt_osprey_right_engine_clip", "targetname");
  var_10 maps\_utility::hide_entity();
  var_11 maps\_utility::hide_entity();
  var_12 maps\_utility::hide_entity();
  var_13 = getent("e_heli_clip_body", "targetname");
  var_14 = getent("e_heli_clip_nose", "targetname");
  var_15 = getent("e_heli_clip_tail", "targetname");
  var_16 = getent("e_heli_clip_tail_rotor", "targetname");
  var_17 = getent("e_heli_clip_rotor", "targetname");
  var_18 = getent("e_heli_clip_rotor_blade", "targetname");
  var_19 = getent("e_heli_clip_door", "targetname");
  var_13 maps\_utility::hide_entity();
  var_14 maps\_utility::hide_entity();
  var_15 maps\_utility::hide_entity();
  var_16 maps\_utility::hide_entity();
  var_17 maps\_utility::hide_entity();
  var_18 maps\_utility::hide_entity();
  var_19 maps\_utility::hide_entity();
  var_20 = getEntArray("exfil_c17", "targetname");
  common_scripts\utility::array_thread(var_20, maps\_utility::hide_entity);
  thread maps\carrier_code::player_slide_manager();
  thread tilt_props_aircraft();
}

setup_deck_tilt() {
  level.start_point = "deck_tilt";
  maps\carrier_code::setup_common(1);
  maps\carrier_code::spawn_allies();
  thread maps\carrier_defend_sparrow::sparrow_handle_ps4_ssao(1);
  thread maps\carrier_audio::aud_check("deck_tilt");
  var_0 = getent("blast_shield1_clip", "targetname");
  var_0 delete();
  var_1 = getent("blast_shield2_clip", "targetname");
  var_1 delete();
  var_2 = getent("water_wake_intro", "targetname");
  var_2 delete();
  level.player takeallweapons();
  level.player giveweapon("msbs+eotech_sp");
  level.player switchtoweapon("msbs+eotech_sp");
  level.player enableweapons();
  level.player disableweaponswitch();
}

begin_deck_tilt() {
  level notify("pre_odin_strike");
  level notify("deck_tilt_start");
  thread tilt_allies();
  thread tilt_generic_grapes();
  thread tilt_props_island_antenna();
  thread handle_fire_damage();
  thread stumble_volume_setup();
  thread ladder_vo();
  common_scripts\utility::exploder(5503);
  var_0 = getEntArray("deck_tilt_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  level.player setmovespeedscale(0.8);
  common_scripts\utility::flag_wait("start_main_odin_strike");
  level notify("odin_strike_starting");
  thread maps\carrier_audio::tilt_odin_impact();
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_2 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(var_1, "carrier_deck_tilt_ladder_player");
  maps\carrier_code::cinematic_on();
  level.player playerlinktoblend(var_1, "tag_player", 0.5);
  var_2 thread maps\_anim::anim_single_solo(var_1, "carrier_deck_tilt_ladder_player");
  thread tilt_odin_strike();
  thread tilt_props_island_corner();
  thread tilt_props_tugger();
  thread tilt_handler();
  thread gravity_shift();
  thread maps\carrier_code::vista_tilt();
  thread tilt_falling_guys();
  thread tilt_player_vault();
  thread tilt_exfil_props();
  wait 0.5;
  var_1 show();
  level.player playerlinktodelta(var_1, "tag_player", 0.8, 10, 20, 15, 0, 1);
  var_1 waittillmatch("single anim", "end");
  level.player setmovespeedscale(0.95);
  level.player unlink();
  maps\carrier_code::cinematic_off();
  var_1 delete();
  level.player thread tilt_handle_player_fail();
  level notify("odin_strike_over");
  common_scripts\utility::flag_wait("deck_tilt_finished");
  thread maps\_utility::autosave_tactical();
}

catchup_deck_tilt() {}

tilt_handler() {
  setsaveddvar("ragdoll_max_life", 3600000);
  wait 2.5;
  common_scripts\utility::flag_set("tilt_part_1");
  setsaveddvar("player_sprintUnlimited", "1");
  wait 1.0;
  common_scripts\utility::flag_set("tilt_part_2");
  thread tilt_exfil();
  thread tilt_vo();
  common_scripts\utility::flag_wait("tilt_part_10");
  common_scripts\utility::flag_wait("tilt_part_15");
  common_scripts\utility::flag_wait("tilt_part_23");
  thread maps\carrier_audio::aud_carr_deck_tilt_osprey();
  common_scripts\utility::flag_wait("tilt_part_30");
  common_scripts\utility::flag_wait("tilt_part_35");
  thread maps\carrier_audio::aud_carr_exp_heli_exp();
  thread tilt_player_slide();
  common_scripts\utility::flag_wait("tilt_part_40");
}

tilt_handle_player_fail() {
  level endon("player_at_silenthawk");
  level endon("kill_fail_state");
  level endon("player_failed");
  self endon("death");
  thread tilt_run_forward_monitor();

  for(;;) {
    var_0 = 0;

    for(var_1 = self getnormalizedmovement(); var_1[0] != 0 || var_1[1] != 0; var_1 = self getnormalizedmovement()) {
      common_scripts\utility::waitframe();
    }

    while(var_1[0] == 0 && var_1[1] == 0) {
      if(var_0 < 7) {
        var_0 = var_0 + 0.05;
        common_scripts\utility::waitframe();
        var_1 = self getnormalizedmovement();
        continue;
      }

      thread tilt_player_fail();
    }

    common_scripts\utility::waitframe();
  }
}

tilt_run_forward_monitor() {
  level endon("player_at_silenthawk");
  level endon("kill_fail_state");
  level endon("player_failed");
  self endon("death");
  wait 5;
  var_0 = 7500;
  level.pause_death_wave = 0;

  for(;;) {
    if(level.player.origin[1] >= var_0 || level.player.origin[1] < 1664 || level.player.origin[2] < 1208) {
      thread tilt_player_fail();
    }

    if(!level.pause_death_wave) {
      var_0 = var_0 + -8;
    }

    wait 0.05;
  }
}

tilt_player_fail() {
  level notify("player_failed");
  thread maps\carrier_audio::aud_carr_tilt_plr_death();
  self freezecontrols(1);
  thread maps\carrier_code::hide_mantle_hint();
  common_scripts\utility::flag_set("obj_exfil_complete");
  thread maps\carrier_code::player_slide_fall();
  thread player_fade_out();
  common_scripts\utility::flag_wait_or_timeout("slide_fade_out", 3);
  maps\carrier_code::set_black_fade(1.0, 0.5);
  wait 0.5;
  missionfailed();
}

player_fade_out() {
  self endon("death");
  var_0 = getEntArray("carrier_falling_fadeout", "targetname");

  while(!common_scripts\utility::flag("slide_fade_out")) {
    foreach(var_2 in var_0) {
      if(level.player istouching(var_2)) {
        common_scripts\utility::flag_set("slide_fade_out");
      }
    }

    wait 0.05;
  }
}

tilt_player_stumble() {
  level.player endon("death");
  var_0 = getent("antenna_stumble_volume", "targetname");

  if(!level.player istouching(var_0) || common_scripts\utility::flag("player_vaulting_active")) {
    return;
  }
  var_0 = getent("antenna_kill_2", "targetname");

  if(level.player istouching(var_0)) {
    return;
  }
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_1.origin = level.player.origin;
  var_1.angles = (level.player.angles[0], 270, level.player.angles[2]);
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  var_2 maps\_anim::anim_first_frame_solo(var_1, "carrier_deck_tilt_stumble_player");
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel("viewmodel_msbs");
  var_3 hide();
  var_3.origin = var_1 gettagorigin("tag_weapon_right");
  var_3.angles = var_1 gettagangles("tag_weapon_right");
  var_3 linkto(var_1, "tag_weapon_right");
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel("viewmodel_eotech_iw6");
  var_4 hide();
  var_4.origin = var_3 gettagorigin("tag_sight_on");
  var_4.angles = var_3 gettagangles("tag_sight_on");
  var_4.angles = var_4.angles + (0, 180, 0);
  var_4 linkto(var_3, "tag_sight_on");
  maps\carrier_code::cinematic_on();
  level.pause_death_wave = 1;
  common_scripts\utility::flag_set("player_tower_stumble");
  level.player playerlinktoblend(var_1, "tag_player", 0.4, 0.2, 0);
  var_2 thread maps\_anim::anim_single_solo(var_1, "carrier_deck_tilt_stumble_player");
  wait 0.4;
  var_1 show();
  var_3 show();
  var_4 show();
  wait 0.2;
  level.player dodamage(level.player.health * 0.25, level.antenna.origin, level.antenna, level.antenna);
  var_1 waittillmatch("single anim", "end");
  maps\carrier_code::cinematic_off();
  var_5 = level.player common_scripts\utility::spawn_tag_origin();
  var_5.origin = (level.player.origin[0], level.player.origin[1], 1402);
  level.player unlink();
  maps\_utility::teleport_player(var_5);
  level.pause_death_wave = 0;
  var_4 delete();
  var_3 delete();
  var_1 delete();
  var_2 delete();
  common_scripts\utility::waitframe();
  var_5 delete();
}

stumble_volume_setup() {}

tilt_player_rog_stumble() {
  level.player endon("death");

  if(level.player.origin[2] < 1400) {
    return;
  }
  var_0 = getent("stumble_volume", "targetname");
  var_1 = getEntArray("exfil_close_volume", "targetname");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = maps\_utility::spawn_anim_model("player_rig");
  var_5 hide();
  var_5.origin = level.player.origin;
  var_5.angles = level.player.angles;

  if(level.player istouching(var_0)) {
    var_2 = 1;

    foreach(var_0 in var_1) {
      if(level.player istouching(var_0)) {
        var_4 = getent(var_0.target, "targetname");
        var_4 maps\_anim::anim_first_frame_solo(var_5, "carrier_deck_tilt_stumble_knockback_player");
        var_3 = 1;
      }
    }

    if(!isDefined(var_3)) {
      var_4 = var_5 common_scripts\utility::spawn_tag_origin();
      var_4 maps\_anim::anim_first_frame_solo(var_5, "carrier_deck_tilt_stumble_knockback_player");
    }
  } else {
    var_4 = var_5 common_scripts\utility::spawn_tag_origin();
    var_4 maps\_anim::anim_first_frame_solo(var_5, "carrier_deck_tilt_stumble_knockdown_player");
  }

  var_8 = spawn("script_model", (0, 0, 0));
  var_8 setModel("viewmodel_msbs");
  var_8 hide();
  var_8.origin = var_5 gettagorigin("tag_weapon_right");
  var_8.angles = var_5 gettagangles("tag_weapon_right");
  var_8 linkto(var_5, "tag_weapon_right");
  var_9 = spawn("script_model", (0, 0, 0));
  var_9 setModel("viewmodel_eotech_iw6");
  var_9 hide();
  var_9.origin = var_8 gettagorigin("tag_sight_on");
  var_9.angles = var_8 gettagangles("tag_sight_on");
  var_9.angles = var_9.angles + (0, 180, 0);
  var_9 linkto(var_8, "tag_sight_on");
  maps\carrier_code::cinematic_on();
  level.pause_death_wave = 1;
  level.player playerlinktoblend(var_5, "tag_player", 0.4, 0.2, 0);
  level.player playrumbleonentity("heavy_3s");
  screenshake(level.player.origin, 3, 2, 2, 2.5, 0, 2.0, 256, 8, 15, 12, 5.0);
  thread maps\carrier_audio::aud_carr_elevator_exp();

  if(isDefined(var_2) && var_2 == 1) {
    var_4 thread maps\_anim::anim_single_solo(var_5, "carrier_deck_tilt_stumble_knockback_player");
  } else {
    var_4 thread maps\_anim::anim_single_solo(var_5, "carrier_deck_tilt_stumble_knockdown_player");
  }

  wait 0.2;
  var_5 show();
  var_8 show();
  var_9 show();
  level.player dodamage(level.player.health * 0.25, level.exfil_chopper.origin, level.exfil_chopper, level.exfil_chopper);
  var_5 waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("player_can_exfil") || !common_scripts\utility::flag("player_at_silenthawk")) {
    maps\carrier_code::cinematic_off();
    level.player unlink();
  }

  level.pause_death_wave = 0;
  var_9 delete();
  var_8 delete();
  var_5 delete();
  var_4 delete();
}

tilt_player_vault() {
  level endon("cant_vault");
  level.player endon("death");
  maps\carrier_code::setup_mantle_hint();
  var_0 = level.hesh_tugger common_scripts\utility::spawn_tag_origin();
  var_1 = level.hesh_tugger gettagorigin("tag_origin");
  var_2 = level.hesh_tugger gettagangles("tag_origin");
  var_0.origin = var_1;
  var_0.angles = var_2 + (0, 180, 0);
  var_0 linkto(level.hesh_tugger, "tag_origin");
  var_3 = maps\_utility::spawn_anim_model("player_rig");
  var_3 hide();
  var_4 = maps\_utility::spawn_anim_model("player_legs_rig");
  var_4 hide();
  var_5 = [var_3, var_4];
  var_0 maps\_anim::anim_first_frame(var_5, "carrier_deck_tilt_vault_tugger");
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel("viewmodel_msbs");
  var_6 hide();
  var_6.origin = var_3 gettagorigin("tag_weapon_right");
  var_6.angles = var_3 gettagangles("tag_weapon_right");
  var_6 linkto(var_3, "tag_weapon_right");
  var_7 = spawn("script_model", (0, 0, 0));
  var_7 setModel("viewmodel_eotech_iw6");
  var_7 hide();
  var_7.origin = var_6 gettagorigin("tag_sight_on");
  var_7.angles = var_6 gettagangles("tag_sight_on");
  var_7.angles = var_7.angles + (0, 180, 0);
  var_7 linkto(var_6, "tag_sight_on");
  common_scripts\utility::flag_wait("player_vault_tugger");
  var_8 = getent("vault_volume", "targetname");
  var_9 = common_scripts\utility::getstruct(var_8.target, "targetname");
  var_9 thread maps\carrier_code::player_check_mantle_lookat();

  while(!common_scripts\utility::flag("stop_player_vault") && !common_scripts\utility::flag("player_vaulting")) {
    if(level.player istouching(var_8) && level.player.looking_at_mantle) {
      thread vault_hide_hint_check();
      common_scripts\utility::flag_wait_either("go_vault", "stop_player_vault");
      level.hesh_tugger_clip notsolid();
    }

    level.player allowjump(1);

    if(!level.player istouching(var_8)) {
      maps\carrier_code::hide_mantle_hint();
      wait 0.05;
    } else {
      maps\carrier_code::hide_mantle_hint();
      level.player notify("stop_mantle_lookat");
      wait 0.05;
      common_scripts\utility::flag_set("player_vaulting");
      thread maps\carrier_audio::aud_carr_tilt_plr_vault();
    }

    wait 0.05;
  }

  if(!common_scripts\utility::flag("stop_player_vault")) {
    level.pause_death_wave = 1;
    maps\carrier_code::cinematic_on();
    var_0 unlink();
    var_10 = getEntArray("sliding_jet2", "targetname");

    foreach(var_12 in var_10) {
      var_12 notsolid();
    }

    level.player hideviewmodel();
    level.player playerlinktoblend(var_3, "tag_player", 0.4);
    common_scripts\utility::flag_set("player_vaulting_active");

    if(level.vault == "main") {
      var_0 thread maps\_anim::anim_single(var_5, "carrier_deck_tilt_vault_tugger");
      var_4 show();
      var_3 show();
      var_6 show();
      var_7 show();
      maps\_anim::anim_set_rate(var_5, "carrier_deck_tilt_vault_tugger", 1.2);
    } else {
      var_0 thread maps\_anim::anim_single(var_5, "carrier_deck_tilt_vault_tugger_alt");
      var_4 show();
      var_3 show();
      var_6 show();
      var_7 show();
      maps\_anim::anim_set_rate(var_5, "carrier_deck_tilt_vault_tugger_alt", 1.2);
    }

    var_5[0] waittillmatch("single anim", "end");
    common_scripts\utility::flag_clear("player_vaulting_active");
    level.player forcemovingplatformentity(undefined);

    if(!common_scripts\utility::flag("player_tower_stumble")) {
      level.player unlink();
    }

    maps\carrier_code::cinematic_off();
    level.player showviewmodel();
    var_14 = level.player getnormalizedmovement();

    if(var_14[1] > 0.5) {
      level.player pushplayervector((0, -10, 0));
    }

    common_scripts\utility::waitframe();
    level.pause_death_wave = 0;
    var_8 delete();
    var_3 delete();
    var_6 delete();
    var_7 delete();
    var_4 delete();
    var_0 delete();
    wait 1;
    level.hesh_tugger_clip solid();

    foreach(var_12 in var_10) {
      var_12 solid();
    }
  } else {
    var_8 delete();
    var_3 delete();
    var_4 delete();
    var_0 delete();
    level.player allowjump(1);
    level notify("cant_vault");
  }
}

vault_pick_anim() {
  level.player endon("death");
  level.vault = "main";
  level.vault_vol_1 = undefined;
  level.vault_vol_2 = undefined;
  level.vault_vol_3 = undefined;
  level.vault_vol_4 = undefined;
  var_0 = getEntArray("vault_anim_volume", "targetname");
  common_scripts\utility::flag_wait("hesh_trigger_1");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2.script_noteworthy == "a") {
      level.vault_vol_1 = var_2;
    }

    if(isDefined(var_2) && var_2.script_noteworthy == "b") {
      level.vault_vol_2 = var_2;
    }

    if(isDefined(var_2) && var_2.script_noteworthy == "c") {
      level.vault_vol_3 = var_2;
    }

    if(isDefined(var_2) && var_2.script_noteworthy == "d") {
      level.vault_vol_4 = var_2;
    }
  }

  waittillframeend;
  level.vault_vol_1 thread vault_anim_vol_check(undefined, "left_volume1");
  level.vault_vol_2 thread vault_anim_vol_check(1, "left_volume2");
  wait 15;
  level notify("vault_1_done");
  common_scripts\utility::flag_set("vault_1_done");
  level.vault_vol_1 delete();
  level.vault_vol_2 thread vault_anim_vol_check(undefined, "left_volume2");
  level.vault_vol_3 thread vault_anim_vol_check(1, "left_volume3");
  wait 3;
  level notify("vault_2_done");
  common_scripts\utility::flag_set("vault_2_done");
  level.vault_vol_2 delete();
  level.vault_vol_3 thread vault_anim_vol_check(undefined, "left_volume3");
  level.vault_vol_4 thread vault_anim_vol_check(1, "left_volume4");
  wait 1.8;
  level notify("vault_3_done");
  common_scripts\utility::flag_set("vault_3_done");
  level.vault_vol_3 delete();
  level.vault_vol_4 delete();
}

vault_anim_vol_check(var_0, var_1) {
  level.player endon("death");
  level endon("vault_1_done");
  level endon("vault_2_done");
  level endon("vault_3_done");
  self endon(var_1);
  level.player endon("not_looking_at_mantle");
  level endon("stop_player_vault");
  level endon("go_vault");

  for(;;) {
    if(level.player istouching(self)) {
      maps\carrier_code::show_mantle_hint();
      level.player allowjump(0);
      thread maps\carrier_code::player_volume_check(var_1);

      if(isDefined(var_0) && var_0 == 1) {
        level.vault = "alt";
      } else {
        level.vault = "main";
      }

      level.player notifyonplayercommand("player_vaulted", "+gostand");
      level.player waittill("player_vaulted");
      common_scripts\utility::flag_set("go_vault");
    }

    wait 0.05;
  }
}

vault_hide_hint_check() {
  while(!common_scripts\utility::flag("vault_1_done")) {
    if(!level.player istouching(level.vault_vol_1) && !level.player istouching(level.vault_vol_2)) {
      maps\carrier_code::hide_mantle_hint();
      return;
    }

    common_scripts\utility::waitframe();
  }

  while(!common_scripts\utility::flag("vault_2_done")) {
    if(!level.player istouching(level.vault_vol_2) && !level.player istouching(level.vault_vol_3)) {
      maps\carrier_code::hide_mantle_hint();
      return;
    }

    common_scripts\utility::waitframe();
  }

  while(!common_scripts\utility::flag("vault_3_done")) {
    if(!level.player istouching(level.vault_vol_3) && !level.player istouching(level.vault_vol_4)) {
      maps\carrier_code::hide_mantle_hint();
      return;
    }

    common_scripts\utility::waitframe();
  }
}

tilt_player_slide() {
  level.player endon("death");
  level endon("e_heli_done");
  var_0 = getent("allow_player_slide", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      setsaveddvar("slide_skip_hold", 1);
    }

    while(level.player istouching(var_0)) {
      common_scripts\utility::waitframe();
    }

    setsaveddvar("slide_skip_hold", 0);
    wait 0.05;
  }
}

tilt_allies() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = getnode("hesh_deck_tilt_start", "targetname");
  level.hesh maps\_utility::set_archetype("deck_tilt_ally");
  level.hesh.moveplaybackrate = 1.25;
  var_0 maps\_anim::anim_reach_solo(level.hesh, "carrier_deck_tilt_rog_reaction_hesh");
  level.hesh.moveplaybackrate = 1.0;

  if(!common_scripts\utility::flag("hesh_react_rog")) {
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "carrier_deck_tilt_ladder_wait_hesh", "stop_loop");
  }

  common_scripts\utility::flag_wait("hesh_react_rog");
  var_0 notify("stop_loop");
  level.hesh maps\_utility::disable_ai_color();
  level.hesh maps\_utility::disable_arrivals();
  level.hesh maps\_utility::disable_exits();
  level.hesh maps\_utility::disable_pain();
  level.hesh maps\_utility::disable_cqbwalk();
  level.hesh maps\_utility::disable_bulletwhizbyreaction();
  level.hesh maps\_utility::set_ignoresuppression(1);
  level.hesh maps\_utility::disable_danger_react();
  level.hesh maps\_utility::disable_surprise();
  level.hesh maps\_utility::set_ignoreall(1);
  level.hesh maps\_utility::pathrandompercent_zero();
  level.hesh.a.movement = "run";
  var_2 = getdvar("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  level.hesh pushplayer(1);
  level.hesh.ignorerandombulletdamage = 1;
  level.hesh maps\_utility::setflashbangimmunity(1);
  level.hesh.nododgemove = 1;
  var_0 maps\_anim::anim_single_solo(level.hesh, "carrier_deck_tilt_rog_reaction_hesh");
  level.hesh maps\_utility::enable_sprint();
  level.hesh thread maps\_utility::follow_path_and_animate(var_1, 9000);
  level.hesh maps\_utility::set_goalradius(32);
  level.hesh.moveplaybackrate = 1.04;
  level.hesh waittill("path_end_reached");
  common_scripts\utility::flag_set("ally_at_silenthawk");
  setsaveddvar("ai_friendlyFireBlockDuration", var_2);
}

tilt_generic_grapes() {
  var_0 = maps\_utility::array_spawn_targetname("deck_tilt_start_drones", 1);
  common_scripts\utility::array_thread(var_0, ::tilt_drone_anim);
}

#using_animtree("generic_human");

tilt_drone_anim() {
  self.animname = "generic";
  self.runanim = maps\_utility::getgenericanim("scared_run");
  self.damageshield = 1;
  self.team = "neutral";
  self.diequietly = 1;
  self.skipdeathanim = 1;
  self.ragdoll_immediate = 1;
  maps\_utility::gun_remove();
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 thread maps\_anim::anim_generic_loop(self, "civilian_stand_idle", "stop_loop");
  level.drone_anims["neutral"]["stand"]["idle"] = % casual_stand_idle;
  level.drone_anims["neutral"]["stand"]["death"] = % exposed_death;
  common_scripts\utility::flag_wait(self.script_parameters);
  var_0 thread maps\_anim::anim_single_solo(self, self.animation);

  if(isDefined(self.script_noteworthy)) {
    self waittillmatch("single anim", "end");
    self.target = self.script_noteworthy;
    thread maps\_drone::drone_move();
    self.damageshield = 0;
    common_scripts\utility::waitframe();

    if(self.script_noteworthy == "dt_start_drone_path_3") {
      self.script_noteworthy = "die_on_goal";
    } else {
      self.script_noteworthy = "delete_on_goal";
    }
  } else {
    var_1 = getanimlength(maps\_utility::getgenericanim(self.animation));
    wait(var_1 - 0.25);
    self kill();
  }
}

tilt_falling_guys() {
  maps\_utility::array_spawn_function_targetname("deck_tilt_sliding_guys_a", ::tilt_generic_fall);
  maps\_utility::array_spawn_function_targetname("deck_tilt_sliding_guys_b", ::tilt_generic_fall);
  var_0 = maps\_utility::array_spawn_targetname("deck_tilt_sliding_guys_a", 1);
  var_1 = maps\_utility::array_spawn_targetname("deck_tilt_sliding_guys_b", 1);
  common_scripts\utility::flag_wait("tilt_part_10");
  thread maps\carrier_audio::aud_tilt_sliding_guya();
  common_scripts\utility::flag_wait("tilt_part_23");
  thread maps\carrier_audio::aud_tilt_sliding_guyb();
}

tilt_generic_fall() {
  self.animname = "generic";
  self.team = "neutral";
  self.diequietly = 1;
  self.skipdeathanim = 1;
  self.ragdoll_immediate = 1;
  self.specialdeathfunc = ::tilt_generic_death;
  self.a.onback = 1;
  maps\_utility::gun_remove();
  common_scripts\utility::flag_wait(self.script_parameters);
  var_0 = common_scripts\utility::spawn_tag_origin();

  if(self.animation == "carrier_enemy_deck_slide_a") {
    self.animation = "carrier_enemy_deck_slide_b";
  }

  var_0 maps\_anim::anim_generic(self, self.animation);
  self dodamage(self.health + 100, self.origin);
  var_0 delete();
}

tilt_generic_death() {
  return 1;
}

tilt_vo() {
  level.hesh maps\_utility::smart_dialogue("carrier_mrk_heshadamheadfor");
  thread maps\carrier::obj_exfil();
  common_scripts\utility::flag_wait("dt_hesh_gogo");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_gogogo");
  common_scripts\utility::flag_wait("dt_hesh_towerdown");
  wait 1.25;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_towerscomingdown");
  common_scripts\utility::flag_wait("dt_hesh_right");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_toyourright");
  common_scripts\utility::flag_wait("dt_hesh_osprey");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_lookoutforthat");
  common_scripts\utility::flag_wait("dt_hesh_watch");
  wait 0.6;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_watchout");
  common_scripts\utility::flag_wait("dt_hesh_heli");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_gettotheosprey");
  common_scripts\utility::flag_wait("dt_hesh_makeit");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_comeonlogan");
  common_scripts\utility::flag_wait("dt_hesh_geton");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_getonletsgo");
}

ladder_vo() {
  wait 1.0;
  maps\_utility::smart_radio_dialogue("carrier_com_noradhasmultipleinbound");
  maps\_utility::smart_radio_dialogue("carrier_com_odinisoperational");
  common_scripts\utility::flag_wait("pre_odin_strike_vo");
  maps\_utility::smart_radio_dialogue("carrier_com_allhandsbracefor");
}

tilt_odin_strike() {
  thread maps\carrier_code::rod_of_god_carrier();
  thread tilt_deck_impact();
  var_0 = getEntArray("deck_intact_odin", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  common_scripts\utility::flag_wait("rog_impacts_deck");
  thread tilt_island_glass();
  common_scripts\utility::exploder(6001);
  common_scripts\utility::exploder(10);
  common_scripts\utility::exploder(6);
  common_scripts\utility::exploder(5504);
  maps\_utility::stop_exploder(5501);
  thread tilt_props_life_rafts();
  level.player thread maps\carrier_fx::handle_onplayer_debris();
  var_4 = getent("deck_node_blocker", "targetname");
  badplace_brush("deck_node_blocker", -1, var_4, "allies", "axis");
  var_5 = getent("antenna_badplace", "targetname");
  badplace_brush("antenna_badplace", -1, var_5, "allies", "axis");
  var_6 = getent("crr_phalanx_01", "targetname");
  var_6 delete();
  wait 0.5;
  thread tilt_props_odin_phys();
  wait 0.5;
  wait 1.0;
  common_scripts\utility::exploder(3);
  common_scripts\utility::exploder(4);
  common_scripts\utility::exploder(5);
  wait 1.5;
  thread bg_rog_hit("deck_tilt_bg_rog_01");
  thread maps\carrier_audio::aud_carr_bg_rog_01();
  common_scripts\utility::flag_wait("tilt_part_35");
  thread bg_rog_hit("deck_tilt_bg_rog_02");
  thread maps\carrier_audio::aud_carr_bg_rog_02();
  wait 2.5;
  thread bg_rog_hit("deck_tilt_bg_rog_03");
  thread maps\carrier_audio::aud_carr_bg_rog_03();
}

tilt_island_glass() {
  var_0 = getent("island_glass_01", "targetname");
  var_1 = getent("island_glass_02", "targetname");
  var_2 = getent("island_glass_03", "targetname");
  var_3 = getent("island_glass_lights_01", "targetname");
  var_4 = getent("island_glass_lights_02", "targetname");
  var_5 = getent("island_glass_lights_03", "targetname");
  var_6 = getEntArray("carrier_tower_lights_off_01", "targetname");
  var_7 = getEntArray("carrier_tower_lights_off_02", "targetname");
  var_8 = getEntArray("carrier_tower_lights_off_03", "targetname");
  var_9 = getEntArray("island_fixtures_01", "targetname");
  var_10 = getEntArray("island_fixtures_02", "targetname");
  var_11 = getEntArray("island_fixtures_03", "targetname");
  wait 0.35;
  var_5 delete();
  var_2 delete();
  maps\_utility::array_delete(var_11);

  foreach(var_13 in var_6) {
    var_13 setlightintensity(0.01);
  }

  wait 0.1;
  var_4 delete();
  var_1 delete();
  maps\_utility::array_delete(var_10);

  foreach(var_13 in var_7) {
    var_13 setlightintensity(0.01);
  }

  wait 0.1;
  var_3 delete();
  var_0 delete();
  maps\_utility::array_delete(var_9);

  foreach(var_13 in var_8) {
    var_13 setlightintensity(0.01);
  }
}

tilt_props_island_antenna() {
  var_0 = getent("deck_tilt_radar", "targetname");
  var_0.animname = "tilt_radar";
  var_0 maps\_anim::setanimtree();
  var_0 thread maps\carrier_fx::handle_radar_dish_fx();
  var_1 = getent("island_antenna", "targetname");
  var_1.animname = "tilt_tower";
  var_1 maps\_anim::setanimtree();
  var_1 thread maps\carrier_fx::handle_antenna_fx();
  level.antenna = var_1;
  var_2 = getent("island_antenna_cables", "targetname");
  var_2.animname = "tilt_tower";
  var_2 maps\_anim::setanimtree();
  var_3 = getent("antenna_ground_clip", "targetname");
  var_4 = getent("antenna_kill_1", "targetname");
  var_5 = getent("antenna_kill_2", "targetname");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  common_scripts\utility::flag_set("antenna_start");
  var_6 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_6 thread maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_satdish");
  thread maps\carrier_audio::aud_dish_crash();
  thread maps\carrier_audio::aud_tower_collapse();
  maps\_utility::delaythread(18, common_scripts\utility::flag_set, "antenna_done");
  var_6 thread maps\_anim::anim_single_solo(var_1, "carrier_deck_tilt_tower_b");
  var_6 thread maps\_anim::anim_single_solo(var_2, "carrier_deck_tilt_tower_b");
  var_1 waittillmatch("single anim", "impact_building");
  level.player playrumbleonentity("carrier_tower_fall");
  var_1 waittillmatch("single anim", "impact_deck1");
  var_4 thread antenna_kill();
  screenshake(level.player.origin, 3, 2, 2, 2.5, 0, 2.0, 256, 8, 15, 12, 5.0);
  var_1 waittillmatch("single anim", "impact_deck2");
  var_5 thread antenna_kill();
  var_3 movez(-4096, 0.05);
  level.player thread tilt_player_stumble();
  var_7 = getEntArray("tower_damage", "targetname");
  common_scripts\utility::array_thread(var_7, maps\_utility::show_entity);
  var_8 = getEntArray("tower_panel_clean", "targetname");
  maps\_utility::array_delete(var_8);
  wait 0.75;
}

antenna_kill() {
  level endon("antenna_done");

  for(;;) {
    if(level.player istouching(self)) {
      level.player kill();
    }

    wait 0.05;
  }
}

tilt_props_island_corner() {
  var_0 = getent("tower_corner", "targetname");
  var_1 = maps\_utility::spawn_anim_model("tilt_tower_corner");
  var_2 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 hide();
  var_2 maps\_anim::anim_first_frame_solo(var_1, "carrier_deck_tilt_island_corner");
  var_3 = getent("island_glass_lights_04", "targetname");
  common_scripts\utility::flag_wait("tower_corner_hit");
  var_3 delete();
  var_0 delete();
  var_1 show();
  var_2 maps\_anim::anim_single_solo(var_1, "carrier_deck_tilt_island_corner");
}

tilt_deck_impact() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_anim_model("tilt_deck1");
  var_1[1] = maps\_utility::spawn_anim_model("tilt_deck2");
  var_1[2] = maps\_utility::spawn_anim_model("tilt_deck3");
  var_0 maps\_anim::anim_single(var_1, "carrier_deck_tilt_sim");
}

tilt_props_life_rafts() {
  var_0 = getEntArray("odin_rafts", "script_noteworthy");
  var_1 = getEntArray("dz_initial_drop", "script_noteworthy");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_model" && var_3.model == "crr_liferaft_01_single") {
      var_3 physicslaunchclient(var_3.origin + (-8, 0, -8), (randomintrange(130000, 250000), randomintrange(-200000, 200000), randomintrange(165000, 280000)));
      continue;
    }

    var_3 delete();
  }

  wait 7.5;
  var_0 = getEntArray("odin_rafts", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

tilt_props_elevator() {
  var_0 = maps\_utility::spawn_anim_model("tilt_props");
  var_1 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "carrier_deck_tilt_elevator");
  level.dmg_rear_elevator.origin = var_0 gettagorigin("j_prop_1");
  level.dmg_rear_elevator.angles = var_0 gettagangles("j_prop_1");
  level.dmg_rear_elevator linkto(var_0, "j_prop_1");

  foreach(var_3 in level.elevator_dmg_models) {
    var_3 linkto(var_0, "j_prop_1");
  }

  foreach(var_3 in level.elevator_ac130_dmg_02) {
    var_3 linkto(var_0, "j_prop_1");
  }

  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_1 thread maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_elevator");
  wait 4;
  maps\_utility::array_delete(level.elevator_dmg_models);
  maps\_utility::array_delete(level.elevator_ac130_dmg_02);
  var_0 waittillmatch("single anim", "end");
  level.dmg_rear_elevator unlink();
  var_0 delete();
}

tilt_props_impact_barrels() {
  var_0 = getEntArray("barrel_impact", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("barrel_impact_2", "targetname"));
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "clip") {
      var_2 delete();
    }
  }

  var_0 = common_scripts\utility::array_removeundefined(var_0);

  foreach(var_2 in var_0) {
    var_2 thread tilt_anim_solo("barrels", "carrier_deck_tilt_prop_sim_pallet" + var_2.script_parameters, "start_main_odin_strike", "deck_tilt_animnode", undefined, undefined, undefined, undefined);
  }
}

tilt_props_impact_x30() {
  var_0 = maps\_utility::spawn_anim_model("tilt_impact_30");
  var_1 = getEntArray("odin_impact_objects", "targetname");
  var_2 = getEntArray("odin_impact_objects_2", "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  common_scripts\utility::array_thread(var_2, maps\_utility::show_entity);
  var_3 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_3 maps\_anim::anim_first_frame_solo(var_0, "carrier_deck_tilt_prop_sim_gp");

  foreach(var_5 in var_1) {
    if(isDefined(var_5.script_parameters) && var_5.script_parameters == "12") {
      if(var_5.script_noteworthy == "clip") {
        level.odin_fac_cart_clip = var_5;
        continue;
      }

      if(var_5.script_noteworthy == "mantle") {
        level.odin_fac_cart_mantle = var_5;
        continue;
      }

      level.odin_fac_cart = var_5;
    }
  }

  level.odin_fac_cart_clip linkto(level.odin_fac_cart);
  level.odin_fac_cart_mantle linkto(level.odin_fac_cart);

  foreach(var_5 in var_1) {
    if(var_5.script_noteworthy == "clip" || var_5.script_noteworthy == "mantle") {
      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "12") {
        continue;
      } else {
        var_5 delete();
      }

      continue;
    }

    var_8 = var_0 gettagorigin("J_prop_" + var_5.script_parameters);
    var_9 = var_0 gettagangles("J_prop_" + var_5.script_parameters);
    var_5.origin = var_8;
    var_5.angles = var_9;
    var_5 linkto(var_0, "J_prop_" + var_5.script_parameters);
  }

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      var_1 = common_scripts\utility::array_remove(var_1, var_5);
    }
  }

  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_3 maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_prop_sim_gp");
}

tilt_props_barrels_x30() {
  var_0 = maps\_utility::spawn_anim_model("tilt_impact_30");
  var_1 = getEntArray("barrel_alpha", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::show_entity);
  var_2 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(var_0, "carrier_deck_tilt_barrel_alpha");
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];

  foreach(var_14 in var_1) {
    if(var_14.script_parameters == "1") {
      var_3 = common_scripts\utility::add_to_array(var_3, var_14);
    }

    if(var_14.script_parameters == "2") {
      var_4 = common_scripts\utility::add_to_array(var_4, var_14);
    }

    if(var_14.script_parameters == "3") {
      var_5 = common_scripts\utility::add_to_array(var_5, var_14);
    }

    if(var_14.script_parameters == "4") {
      var_6 = common_scripts\utility::add_to_array(var_6, var_14);
    }

    if(var_14.script_parameters == "5") {
      var_7 = common_scripts\utility::add_to_array(var_7, var_14);
    }

    if(var_14.script_parameters == "6") {
      var_8 = common_scripts\utility::add_to_array(var_8, var_14);
    }

    if(var_14.script_parameters == "7") {
      var_9 = common_scripts\utility::add_to_array(var_9, var_14);
    }

    if(var_14.script_parameters == "8") {
      var_10 = common_scripts\utility::add_to_array(var_10, var_14);
    }

    if(var_14.script_parameters == "9") {
      var_11 = common_scripts\utility::add_to_array(var_11, var_14);
    }

    if(var_14.script_parameters == "10") {
      var_12 = common_scripts\utility::add_to_array(var_12, var_14);
    }
  }

  thread x30_hookup(var_3, var_0);
  thread x30_hookup(var_4, var_0);
  thread x30_hookup(var_5, var_0);
  thread x30_hookup(var_6, var_0);
  thread x30_hookup(var_7, var_0);
  thread x30_hookup(var_8, var_0);
  thread x30_hookup(var_9, var_0);
  thread x30_hookup(var_10, var_0);
  thread x30_hookup(var_11, var_0);
  thread x30_hookup(var_12, var_0);
  common_scripts\utility::flag_wait("tilt_part_15");
  var_2 maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_barrel_alpha");
}

x30_hookup(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_0) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "mantle") {
      var_4 = var_6;
    }
  }

  if(isDefined(var_3)) {
    var_3 linkto(var_2);
  }

  if(isDefined(var_4)) {
    var_4 linkto(var_2);
  }

  var_8 = var_1 gettagorigin("J_prop_" + var_2.script_parameters);
  var_9 = var_1 gettagangles("J_prop_" + var_2.script_parameters);
  var_2.origin = var_8;
  var_2.angles = var_9;
  var_2 linkto(var_1, "J_prop_" + var_2.script_parameters);
}

tilt_props_barrels_x3(var_0, var_1) {
  var_2 = maps\_utility::spawn_anim_model("tilt_barrel_3x");
  var_3 = getEntArray(var_0, "targetname");
  var_4 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_4 maps\_anim::anim_first_frame_solo(var_2, var_1);
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];

  foreach(var_12 in var_3) {
    if(var_12.script_parameters == "1") {
      if(var_12.script_noteworthy == "item") {
        var_5 = var_12;
      } else {
        var_8 = var_12;
      }

      continue;
    }

    if(var_12.script_parameters == "2") {
      if(var_12.script_noteworthy == "item") {
        var_6 = var_12;
      } else {
        var_9 = var_12;
      }

      continue;
    }

    if(var_12.script_parameters == "3") {
      if(var_12.script_noteworthy == "item") {
        var_7 = var_12;
        continue;
      }

      var_10 = var_12;
    }
  }

  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_14 = var_2 gettagorigin("J_prop_1");
  var_15 = var_2 gettagangles("J_prop_1");
  var_5.origin = var_14;
  var_5.angles = var_15;
  var_5 linkto(var_2, "J_prop_1");
  var_16 = var_2 gettagorigin("J_prop_2");
  var_17 = var_2 gettagangles("J_prop_2");
  var_6.origin = var_16;
  var_6.angles = var_17;
  var_6 linkto(var_2, "J_prop_2");
  var_18 = var_2 gettagorigin("J_prop_3");
  var_19 = var_2 gettagangles("J_prop_3");
  var_7.origin = var_18;
  var_7.angles = var_19;
  var_7 linkto(var_2, "J_prop_3");
  common_scripts\utility::flag_wait("tilt_part_23");
  var_4 maps\_anim::anim_single_solo(var_2, var_1);
}

tilt_props_odin_jet() {
  var_0 = getEntArray("odin_jet_1", "targetname");
  var_1 = getEntArray("odin_jet_2", "targetname");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  foreach(var_11 in var_0) {
    if(var_11.script_noteworthy == "clip") {
      var_2 = var_11;
    }

    if(var_11.script_noteworthy == "clip_l") {
      var_3 = var_11;
    }

    if(var_11.script_noteworthy == "clip_r") {
      var_4 = var_11;
    }

    if(var_11.script_noteworthy == "item") {
      var_5 = var_11;
    }
  }

  foreach(var_11 in var_1) {
    if(var_11.script_noteworthy == "clip") {
      var_6 = var_11;
    }

    if(var_11.script_noteworthy == "clip_l") {
      var_7 = var_11;
    }

    if(var_11.script_noteworthy == "clip_r") {
      var_8 = var_11;
    }

    if(var_11.script_noteworthy == "item") {
      var_9 = var_11;
    }
  }

  if(isDefined(var_2)) {
    var_2 movez(4096, 0.05);
    var_3 movez(4096, 0.05);
    var_4 movez(4096, 0.05);
    common_scripts\utility::waitframe();
    var_2 delete();
    var_3 delete();
    var_4 delete();
  }

  if(isDefined(var_6)) {
    var_6 delete();
    var_7 delete();
    var_8 delete();
  }

  var_5.animname = "sliding_jet";
  var_5 maps\_anim::setanimtree();
  var_9.animname = "sliding_jet";
  var_9 maps\_anim::setanimtree();
  var_15 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_15 maps\_anim::anim_first_frame_solo(var_5, "carrier_deck_tilt_f18_a");
  var_15 maps\_anim::anim_first_frame_solo(var_9, "carrier_deck_tilt_f18_b");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_15 thread maps\_anim::anim_single_solo(var_5, "carrier_deck_tilt_f18_a");
  var_15 maps\_anim::anim_single_solo(var_9, "carrier_deck_tilt_f18_b");
  var_5 delete();
  var_9 delete();
}

tilt_props_aircraft() {
  var_0 = common_scripts\utility::getstruct("deck_run_struct", "targetname");
  var_1 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  level.tilt_osprey_1 = getent("tilt_osprey_1", "targetname");
  level.tilt_osprey_1 maps\_utility::hide_entity();
  level.tilt_osprey_1 thread tilt_osprey_clip();
  level.exploding_heli thread tilt_exp_heli_clip();
  level.sliding_jet1 = maps\carrier_code::setup_jet_and_clip("sliding_jet1", 800, "start_main_odin_strike", "jet1_done");
  level.sliding_jet2 = maps\carrier_code::setup_jet_and_clip("sliding_jet2", 800, "tilt_part_2", "jet2_done");
  level.sliding_jet3 = maps\carrier_code::setup_jet_and_clip("sliding_jet3", 800, "start_main_odin_strike", "jet3_done");
  level.sliding_jet11 = maps\carrier_code::setup_jet_and_clip("sliding_jet11", 800, "tilt_part_35", "jet11_done");
  level.sliding_jet12 = maps\carrier_code::setup_jet_and_clip("sliding_jet12", 800, "tilt_part_23", "jet12_done");
  level.sliding_jet20 = maps\carrier_code::setup_jet_and_clip("sliding_jet20");
  level.sliding_jet21 = maps\carrier_code::setup_jet_and_clip("sliding_jet21");
  level.sliding_jet22 = maps\carrier_code::setup_jet_and_clip("sliding_jet22");
  common_scripts\utility::waitframe();
  level.exploding_heli thread maps\carrier_fx::handle_exploding_heli_fx("tilt_part_35");
  level.exploding_heli thread tilt_anim_solo("exploding_heli", "carrier_deck_tilt_shawk_explosion", "tilt_part_35", "deck_tilt_animnode", undefined, undefined, undefined, undefined, "e_heli_done", "heavy_3s");
  level.sliding_jet1 thread maps\carrier_fx::handle_jet1_fx("start_main_odin_strike");
  level.sliding_jet2 thread maps\carrier_fx::handle_jet2_fx("hesh_trigger_1");
  level.sliding_jet3 thread maps\carrier_fx::handle_jet3_fx("start_main_odin_strike");
  level.sliding_jet11 thread maps\carrier_fx::handle_jet11_fx("tilt_part_35");
  level.sliding_jet12 thread maps\carrier_fx::handle_jet12_fx("tilt_part_23");
  level.sliding_jet1 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_c", "start_main_odin_strike", "deck_tilt_animnode", undefined, "scn_carr_tilt_f18_c", undefined, undefined, "jet1_done", "heavy_3s");
  level.sliding_jet2 thread tilt_anim_solo("sliding_jet", "carrier_tilt_jet1", "hesh_trigger_1", "deck_tilt_animnode", undefined, "scn_carr_tilt_jet1", undefined, undefined, undefined, "heavy_3s");
  level.sliding_jet3 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_d", "start_main_odin_strike", "deck_tilt_animnode", 2.0, "carr_jet_slide", undefined, undefined, "jet3_done", "heavy_3s");
  level.sliding_jet11 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_e", "tilt_part_35", "deck_tilt_animnode", 1.0, "scn_carr_mig29a", undefined, undefined, "jet11_done", "heavy_3s");
  level.sliding_jet12 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_f", "tilt_part_23", "deck_tilt_animnode", 9.5, "carr_jet_slide", undefined, undefined, "jet12_done", "heavy_3s");
  level.sliding_jet20 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_g", "exfil_go", "deck_tilt_animnode", undefined, undefined, undefined, undefined);
  level.sliding_jet21 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_h", "exfil_go", "deck_tilt_animnode", undefined, undefined, undefined, undefined);
  level.sliding_jet22 thread tilt_anim_solo("sliding_jet", "carrier_deck_tilt_f18_i", "exfil_go", "deck_tilt_animnode", undefined, undefined, undefined, undefined);

  if(level.start_point != "deck_victory" && level.start_point != "deck_tilt" && level.start_point != "outro") {
    common_scripts\utility::flag_wait("defend_sparrow_start");
  }

  level.tilt_osprey_1 thread maps\carrier_fx::handle_sliding_osprey_fx("tilt_part_15");
  level.tilt_osprey_1 thread tilt_anim_solo("tilt_osprey", "carrier_deck_tilt_osprey", "tilt_part_15", "deck_tilt_animnode", 1.1, "carr_sliding_04", undefined, undefined, "osprey_done", "carrier_plane_slide");
  level.tilt_osprey_1 maps\_utility::show_entity();
  common_scripts\utility::flag_wait("hesh_trigger_1");
  level.sliding_jet2 waittillmatch("single anim", "slow_down");
  level notify("jet2_done");
}

tilt_osprey_clip() {
  var_0 = getent("tilt_osprey_clip", "targetname");
  var_1 = getent("tilt_osprey_left_engine_clip", "targetname");
  var_2 = getent("tilt_osprey_right_engine_clip", "targetname");
  var_0 linkto(self, "body_animate_jnt");
  var_1 linkto(self, "j_pivot_le");
  var_2 linkto(self, "j_pivot_ri");
  var_0 thread player_hit_detect(800, "tilt_part_15", "osprey_done");
  var_1 thread player_hit_detect(800, "tilt_part_15", "osprey_done");
  var_2 thread player_hit_detect(800, "tilt_part_15", "osprey_done");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_0 maps\_utility::show_entity();
  var_1 maps\_utility::show_entity();
  var_2 maps\_utility::show_entity();
}

tilt_exp_heli_clip() {
  var_0 = getent("e_heli_clip_body", "targetname");
  var_1 = getent("e_heli_clip_nose", "targetname");
  var_2 = getent("e_heli_clip_tail", "targetname");
  var_3 = getent("e_heli_clip_tail_rotor", "targetname");
  var_4 = getent("e_heli_clip_rotor", "targetname");
  var_5 = getent("e_heli_clip_rotor_blade", "targetname");
  var_6 = getent("e_heli_clip_door", "targetname");
  var_0 linkto(self, "j_body");
  var_1 linkto(self, "j_nose");
  var_2 linkto(self, "j_tail");
  var_3 linkto(self, "j_tail_rotor");
  var_4 linkto(self, "j_rotor");
  var_5 linkto(self, "j_rotor_blade");
  var_6 linkto(self, "j_door");
  var_0 thread player_hit_detect(800, "tilt_part_35", "e_heli_done");
  var_1 thread player_hit_detect(800, "tilt_part_35", "e_heli_done");
  var_2 thread player_hit_detect(800, "tilt_part_35", "e_heli_done");
  var_3 thread player_hit_detect(800, "tilt_part_35", "e_heli_done");
  var_4 thread player_hit_detect(2500, "tilt_part_35", "e_heli_done");
  var_5 thread player_hit_detect(50, "tilt_part_35", "e_heli_done");
  var_6 thread player_hit_detect(75, "tilt_part_35", "e_heli_done");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_0 maps\_utility::show_entity();
  var_1 maps\_utility::show_entity();
  var_2 maps\_utility::show_entity();
  var_3 maps\_utility::show_entity();
  var_4 maps\_utility::show_entity();
  var_5 maps\_utility::show_entity();
  var_6 maps\_utility::show_entity();
}

tilt_props_tugger() {
  var_0 = getent("deck_tilt_tugger_1", "targetname");
  var_0.animname = "tilt_tugger";
  var_0 maps\_anim::setanimtree();
  var_0 maps\_utility::show_entity();
  var_1 = getent("deck_tilt_tugger_1_clip", "targetname");
  var_1 maps\_utility::show_entity();
  var_2 = getent("deck_tilt_tugger_1_mantle", "targetname");
  var_2 show();
  var_1 linkto(var_0);
  var_2 linkto(var_0);
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_3 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 thread player_hit_detect(300);
  var_3 maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_tugger1");
  var_1 notify("done_moving");
}

tilt_props_tugger_vault() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = getEntArray("large_tugger3", "targetname");
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_2.animname = "tilt_tugger";
  var_2 maps\_anim::setanimtree();
  level.hesh_tugger = var_2;
  var_3 linkto(var_2);
  level.hesh_tugger_clip = var_3;
  var_4 delete();
  thread vault_pick_anim();
  var_0 maps\_anim::anim_first_frame_solo(var_2, "carrier_deck_tilt_slide_tugger1");
  common_scripts\utility::flag_wait("hesh_trigger_1");
  var_0 thread maps\_anim::anim_single_solo(var_2, "carrier_deck_tilt_slide_tugger1");
}

tilt_props_tugger3() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = getEntArray("large_tugger2", "targetname");
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_3 linkto(var_2);
  var_4 linkto(var_2);
  var_2.animname = "tilt_tugger";
  var_2 maps\_anim::setanimtree();
  var_0 maps\_anim::anim_first_frame_solo(var_2, "carrier_deck_tilt_tugger3");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_0 maps\_anim::anim_single_solo(var_2, "carrier_deck_tilt_tugger3");
}

tilt_props_tugger4() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = getEntArray("large_tugger4", "targetname");
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.script_noteworthy == "item") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "clip") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_3 linkto(var_2);
  var_4 linkto(var_2);
  var_2.animname = "tilt_tugger";
  var_2 maps\_anim::setanimtree();
  var_0 maps\_anim::anim_first_frame_solo(var_2, "carrier_deck_tilt_tugger4");
  common_scripts\utility::flag_wait("tilt_part_23");
  var_0 maps\_anim::anim_single_solo(var_2, "carrier_deck_tilt_tugger4");
}

tilt_props_large() {
  var_0 = common_scripts\utility::getstruct("deck_run_struct", "targetname");
  var_1 = [];
  var_2 = getEntArray("barrel_small2", "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_deck_tilt_barrel_pallet_slide_a", "tilt_part_1", "deck_tilt_animnode", 0.25, "carr_barrels_roll", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_6 = getEntArray("barrel_small3", "targetname");

  foreach(var_4 in var_6) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_deck_tilt_barrel_pallet_slide_b", "tilt_part_2", "deck_tilt_animnode", 1.2, "carr_metal_fall_04", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_9 = getEntArray("barrel_med1a", "targetname");

  foreach(var_4 in var_9) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_deck_tilt_barrel_pallet_slide_c1", "tilt_part_30", "deck_tilt_animnode", undefined, "scn_tilt_misc_debris_02", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_12 = getEntArray("barrel_med1b", "targetname");

  foreach(var_4 in var_12) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_deck_tilt_barrel_pallet_slide_c2", "tilt_part_30", "deck_tilt_animnode", undefined, "scn_tilt_misc_debris_03", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_15 = getEntArray("barrel_med2a", "targetname");

  foreach(var_4 in var_15) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_barrel_pallet_slide_b1", "tilt_part_40", undefined, undefined, "scn_tilt_misc_debris_04", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_18 = getEntArray("barrel_med2b", "targetname");

  foreach(var_4 in var_18) {
    if(var_4.script_noteworthy == "item") {
      var_4 thread tilt_anim_solo("barrels", "carrier_barrel_pallet_slide_b2", "tilt_part_40", undefined, undefined, "carr_metal_fall_03", undefined, 1);
      continue;
    }

    var_1 = common_scripts\utility::array_add(var_1, var_4);
  }

  var_21 = getent("forklift", "targetname");
  var_21 thread tilt_anim_solo("forklift", "carrier_exfil_takeoff_forklift", "exfil_go", undefined, undefined, "scn_tilt_misc_debris_05", undefined, undefined);
  common_scripts\utility::flag_wait("tilt_part_1");
  maps\_utility::array_delete(var_1);
}

test_connect_paths() {
  var_0 = getEntArray("sliding_transport_cart_01", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "clip") {
      common_scripts\utility::flag_wait("tilt_part_2");
      var_2 connectpaths();
    }
  }
}

tilt_props_medium() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = getEntArray("sliding_cart_01b", "targetname");

  foreach(var_3 in var_1) {
    var_3 movey(-512, 0.05);
  }

  var_5 = getEntArray("sliding_crate_01b", "targetname");

  foreach(var_3 in var_5) {
    var_3 movex(256, 0.05);
    var_3 movey(384, 0.05);
  }

  var_8 = getEntArray("sliding_crate_03a", "targetname");

  foreach(var_3 in var_8) {
    var_3 movey(160, 0.05);
  }

  var_11 = getEntArray("sliding_barrel_01a", "targetname");

  foreach(var_3 in var_11) {
    var_3 movey(244, 0.05);
  }

  var_14 = getEntArray("sliding_barrel_01b", "targetname");

  foreach(var_3 in var_14) {
    var_3 movey(244, 0.05);
  }

  var_17 = getEntArray("sliding_barrel_01c", "targetname");

  foreach(var_3 in var_17) {
    var_3 movey(244, 0.05);
  }

  wait 0.15;
  var_1 = maps\_utility::spawn_anim_model("generic_slide");
  var_1 thread tilt_anim_gen_prop_raven("sliding_cart_01b", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_15", 0, 1, 45);
  var_20 = maps\_utility::spawn_anim_model("generic_slide");
  var_20 thread tilt_anim_gen_prop_raven("sliding_transport_cart_01", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_2", 0.25, 1, 45);
  thread test_connect_paths();
  var_5 = maps\_utility::spawn_anim_model("generic_slide");
  var_5 thread tilt_anim_gen_prop_raven("sliding_crate_01b", "J_prop_1", "carrier_prop_deck_slide_slow", "tilt_part_2", 1.0, 1, 15);
  var_8 = maps\_utility::spawn_anim_model("generic_slide");
  var_8 thread tilt_anim_gen_prop_raven("sliding_crate_03a", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_2", 4.0, 1, 15);
  var_11 = maps\_utility::spawn_anim_model("generic_slide");
  var_11 thread tilt_anim_gen_prop_raven("sliding_barrel_01a", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_1", 2.5, 1, 10);
  var_14 = maps\_utility::spawn_anim_model("generic_slide");
  var_14 thread tilt_anim_gen_prop_raven("sliding_barrel_01b", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_1", 2.75, 1, 10);
  var_17 = maps\_utility::spawn_anim_model("generic_slide");
  var_17 thread tilt_anim_gen_prop_raven("sliding_barrel_01c", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_1", 3.2, 1, 10);
  var_21 = maps\_utility::spawn_anim_model("generic_slide");
  var_21 thread tilt_anim_gen_prop_raven("sliding_barrel_01d", "J_prop_1", "carrier_prop_deck_slide_full", "tilt_part_2", 1.15, 1, 10);
  thread tilt_props_jet11_cart();
  var_22 = maps\_utility::spawn_anim_model("tilt_cart");
  var_23 = getEntArray("sliding_cart_01a", "targetname");
  var_24 = [];
  var_25 = [];
  var_26 = [];

  foreach(var_28 in var_23) {
    if(var_28.script_noteworthy == "item") {
      var_24 = var_28;
      continue;
    }

    if(var_28.script_noteworthy == "clip") {
      var_25 = var_28;
      continue;
    }

    var_26 = var_28;
  }

  var_25 linkto(var_24);
  var_26 linkto(var_24);
  var_0 maps\_anim::anim_first_frame_solo(var_22, "carrier_deck_tilt_rollercart_a");
  var_24 linkto(var_22, "j_prop_2");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  wait 1.25;
  var_0 maps\_anim::anim_single_solo(var_22, "carrier_deck_tilt_rollercart_a");
}

tilt_props_jet11_cart() {
  var_0 = getEntArray("jet11_cart", "targetname");
  var_1 = getEntArray("jet11_missile_rack", "targetname");
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  foreach(var_9 in var_0) {
    if(var_9.script_noteworthy == "item") {
      var_2 = var_9;
      continue;
    }

    if(var_9.script_noteworthy == "clip") {
      var_3 = var_9;
      continue;
    }

    var_4 = var_9;
  }

  var_3 linkto(var_2);
  var_4 linkto(var_2);

  foreach(var_9 in var_1) {
    if(var_9.script_noteworthy == "item") {
      var_5 = var_9;
      continue;
    }

    if(var_9.script_noteworthy == "clip") {
      var_6 = var_9;
    }
  }

  var_6 linkto(var_5);
  var_13 = maps\_utility::spawn_anim_model("tilt_cart");
  var_14 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_14 maps\_anim::anim_first_frame_solo(var_13, "carrier_deck_tilt_missile_cart1");
  var_15 = var_13 gettagorigin("J_prop_1");
  var_16 = var_13 gettagangles("J_prop_1");
  var_17 = var_13 gettagorigin("J_prop_2");
  var_18 = var_13 gettagangles("J_prop_2");
  common_scripts\utility::waitframe();
  var_2.origin = var_15;
  var_2.angles = var_16;
  var_5.origin = var_17;
  var_5.angles = var_18;
  var_2 linkto(var_13, "J_prop_1");
  var_5 linkto(var_13, "J_prop_2");
  common_scripts\utility::flag_wait("tilt_part_35");
  wait 1.0;
  var_14 maps\_anim::anim_single_solo(var_13, "carrier_deck_tilt_missile_cart1");
  var_5 unlink();
  var_2 unlink();
  var_13 delete();
}

tilt_props_odin_phys() {
  var_0 = getEntArray("odin_phys_objects", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_0 = getEntArray("odin_phys_objects_2", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "clip") {
      var_2 delete();
      continue;
    }

    var_3 = randomintrange(1000, 2000);
    var_4 = randomintrange(-1000, 1000);
    var_5 = randomintrange(8000, 10000);
    var_2 physicslaunchclient(var_2.origin + (0, 0, -2), (var_3, var_4, var_5));
  }
}

tilt_front_deck_impact() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_anim_model("tilt_deck1");
  var_1[1] = maps\_utility::spawn_anim_model("tilt_deck2");
  var_1[2] = maps\_utility::spawn_anim_model("tilt_deck3");
  var_0 maps\_anim::anim_single(var_1, "carrier_exfil_deck_sim");
}

tilt_exfil() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("deck_tilt_heli");
  level.exfil_chopper = var_1;
  maps\_utility::delaythread(0.15, maps\_vehicle::gopath, var_1);
  var_2 = getent("exfil_player_clip", "targetname");
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkto(var_1);
  var_3 = var_1 common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_1 gettagorigin("tag_light_cargo01");
  var_3.angles = var_1 gettagangles("tag_light_cargo01");
  var_3 linkto(var_1);
  playFXOnTag(common_scripts\utility::getfx("aircraft_light_cockpit_white_300"), var_3, "tag_origin");
  thread tilt_exfil_player();
  thread maps\carrier_audio::aud_carr_exfil_heli(var_1);
  var_1.path_gobbler = 1;
  var_1.animname = "exfil_silenthawk";
  common_scripts\utility::flag_wait("exfil_silenthawk_approach");
  var_1 maps\_utility::vehicle_detachfrompath();
  var_0 maps\_anim::anim_single_solo(var_1, "carrier_exfil_flyin_silenthawk");
  var_0 thread maps\_anim::anim_loop_solo(var_1, "carrier_exfil_first_idle_silenthawk", "stop_loop");
  common_scripts\utility::flag_wait("ally_at_silenthawk");
  var_0 maps\_anim::anim_reach_solo(level.hesh, "carrier_exfil_getin");
  var_0 notify("stop_loop");
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_exfil_getin");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "carrier_exfil_getin");
  var_1 waittillmatch("single anim", "knockdown_player");
  common_scripts\utility::exploder(7100);
  thread tilt_player_rog_stumble();
  level.hesh waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("player_at_silenthawk")) {
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "carrier_exfil_idle", "stop_loop");
    var_0 thread maps\_anim::anim_loop_solo(var_1, "carrier_exfil_idle", "stop_loop");
  }

  common_scripts\utility::flag_wait("player_at_silenthawk");
  var_0 notify("stop_loop");
  common_scripts\utility::flag_set("obj_exfil_complete");
  thread maps\carrier_audio::aud_play_exfil_music();
  common_scripts\utility::flag_set("exfil_go");
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_exfil_takeoff");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "carrier_exfil_takeoff");
  wait 0.5;
  thread tilt_exfil_planes();
  var_1 waittillmatch("single anim", "queue_rog");
  level.player playrumbleonentity("heavy_3s");
  screenshake(level.player.origin, 3, 2, 2, 2.5, 0, 2.0, 256, 8, 15, 12, 5.0);
  thread maps\carrier_code::rod_of_god_carrier_front();
  thread tilt_front_deck_impact();
  wait 8.85;
  thread maps\carrier_code::set_black_fade(1.0, 3);
  wait 3;
  maps\_utility::nextmission();
}

tilt_exfil_props() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  thread maps\carrier_code::generic_prop_raven_anim(var_0, "tilt_cart", "carrier_exfil_takeoff_carts", "exfil_rog_cart_1", "exfil_rog_cart_2", 1, "exfil_go");
  var_1 = getEntArray("exfil_rog_barrels_1", "targetname");

  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "item") {
      var_3 thread tilt_anim_solo("barrels", "carrier_exfil_takeoff_barrel1", "exfil_go", "deck_tilt_animnode", undefined, undefined, undefined, undefined);
      continue;
    }

    var_3 delete();
  }

  var_5 = getEntArray("exfil_rog_barrels_2", "targetname");

  foreach(var_3 in var_5) {
    if(var_3.script_noteworthy == "item") {
      var_3 thread tilt_anim_solo("barrels", "carrier_exfil_takeoff_barrel2", "exfil_go", "deck_tilt_animnode", undefined, undefined, undefined, undefined);
      continue;
    }

    var_3 delete();
  }
}

tilt_exfil_planes() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("exfil_bg_heli");
  thread maps\carrier_audio::aud_carr_exfil_bg_heli(var_0);
  var_1 = getEntArray("exfil_c17", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::show_entity);

  foreach(var_3 in var_1) {
    var_4 = randomfloatrange(13.25, 14.5);
    var_5 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3 moveto(var_5.origin, var_4);
  }

  wait 3;
  var_7 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("exfil_jets");
}

tilt_exfil_player() {
  level endon("player_failed");
  common_scripts\utility::flag_wait_all("player_can_exfil", "player_at_silenthawk");
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_1 = maps\_utility::spawn_anim_model("player_legs_rig");
  var_0 hide();
  var_1 hide();
  var_0 linkto(level.exfil_chopper, "tag_doorgun_player");
  var_1 linkto(level.exfil_chopper, "tag_doorgun_player");
  var_2 = [var_0, var_1];
  level.exfil_chopper thread maps\_anim::anim_single(var_2, "carrier_exfil_takeoff", "tag_doorgun_player");
  level.player enableinvulnerability();
  level.player playerlinktoblend(var_0, "tag_player", 0.5);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowsprint(0);
  wait 0.5;
  var_0 show();
  var_1 show();
  level.player playerlinktodelta(var_0, "tag_player", 1, 10, 10, 15, 10);
}

bg_rog_hit(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 thread bg_rog_impact();
}

bg_rog_impact(var_0, var_1) {
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), self, "tag_explode_base");
  wait 4.0;
}

rog_flash(var_0, var_1, var_2) {
  var_3 = level.lvl_visionset;
  var_4 = "carrier_rog";

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_5 = var_0 / (var_1 / 0.05);
  var_6 = 0;
  maps\_utility::vision_set_fog_changes(var_4, var_1);
  wait(var_1);
  maps\_utility::vision_set_fog_changes(var_3, var_2);
}

tilt_anim_gen_prop_raven(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getEntArray(var_0, "targetname");
  var_8 = undefined;
  var_9 = undefined;
  maps\_utility::ent_flag_init("tilt_debris_fall");
  var_10 = getEntArray("carrier_edge_volume", "targetname");

  foreach(var_12 in var_7) {
    if(var_12.script_noteworthy == "item") {
      var_8 = var_12;
    }

    if(var_12.script_noteworthy == "mantle") {
      var_7 = common_scripts\utility::array_remove(var_7, var_12);
      var_12 delete();
    }
  }

  self.origin = var_8.origin;
  self.angles = (0, 0, 0);
  var_8 linkto(self, var_1);

  if(isDefined(var_5)) {
    foreach(var_12 in var_7) {
      if(var_12.script_noteworthy == "clip") {
        var_9 = var_12;
      }
    }

    var_9 linkto(var_8);
  }

  common_scripts\utility::flag_wait(var_3);

  if(isDefined(var_4)) {
    wait(var_4);
  }

  if(isDefined(var_6)) {
    thread player_hit_detect(var_6);
  }

  thread maps\_anim::anim_single_solo(self, var_2);

  while(!maps\_utility::ent_flag("tilt_debris_fall")) {
    foreach(var_17 in var_10) {
      if(self istouching(var_17)) {
        maps\_utility::ent_flag_set("tilt_debris_fall");
      }
    }

    wait 0.05;
  }

  self notify("falling");
  maps\_anim::anim_single_solo(self, "carrier_prop_deck_slide_fall");
  self delete();
  var_8 delete();
}

tilt_anim_solo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.animname = var_0;
  maps\_anim::setanimtree();

  if(isDefined(var_3)) {
    var_10 = common_scripts\utility::getstruct(var_3, "targetname");
  } else {
    var_10 = common_scripts\utility::spawn_tag_origin();
  }

  var_10 thread maps\_anim::anim_first_frame_solo(self, var_1);
  common_scripts\utility::flag_wait(var_2);

  if(isDefined(var_4)) {
    wait(var_4);
  }

  var_10 thread maps\_anim::anim_single_solo(self, var_1);

  if(isDefined(var_9)) {
    self playrumbleonentity(var_9);
  }

  if(isDefined(var_5)) {
    if(isDefined(var_6)) {
      wait(var_6);
    }

    maps\_utility::play_sound_on_entity(var_5);
  }

  self waittillmatch("single anim", "end");

  if(isDefined(var_8)) {
    level notify(var_8);
  }

  if(!isDefined(var_3)) {
    var_10 delete();
  }

  if(isDefined(var_7)) {
    self delete();
  }
}

player_hit_detect(var_0, var_1, var_2) {
  self endon("falling");

  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isDefined(var_1)) {
    common_scripts\utility::flag_wait(var_1);
  }

  for(;;) {
    self waittill("player_pushed", var_3, var_4);

    if(isplayer(var_3)) {
      if(var_4[0] > 5 || var_4[1] > 5) {
        level.player dodamage(var_0, self.origin, self);
        level.player pushplayervector((25, 10, 0));
        common_scripts\utility::flag_set("stop_dmg_check");
        return;
      }
    }

    wait 0.05;
  }
}

gravity_shift() {
  var_0 = 0.25;
  var_1 = -0.9;

  for(var_2 = 0; var_2 < 13; var_2++) {
    setphysicsgravitydir((var_0, 0.0, var_1));
    var_0 = var_0 + 0.05;
    var_1 = var_1 + 0.01;
    wait 3;
  }
}

handle_fire_damage() {
  var_0 = getEntArray("deck_tilt_hurt", "targetname");
  common_scripts\utility::array_thread(var_0, ::fire_damage);
}

fire_damage() {
  level endon("player_at_silenthawk");

  for(;;) {
    if(level.player istouching(self)) {
      level.player dodamage(3, level.player.origin);
      wait 0.5;
    }

    common_scripts\utility::waitframe();
  }
}