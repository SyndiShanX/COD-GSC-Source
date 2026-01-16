/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_exfil.gsc
*****************************************************/

start() {
  iprintln("Exfil");
  maps\black_ice_util::player_start("player_start_exfil");
  var_0 = ["struct_ally_start_exfil_01", "struct_ally_start_exfil_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  level.player setclienttriggeraudiozone("blackice_exfil_int", 2);
  level._command.door_out thread maps\black_ice_util::open_door(90, 1);
  thread maps\black_ice_command::command_light_change();
  thread maps\black_ice_audio::blackice_exfil_music();
  common_scripts\utility::exploder("fx_command_interior");
  thread maps\black_ice_refinery::util_refinery_stack_cleanup();
  thread maps\black_ice_util::black_ice_geyser2_pulse();
  setsaveddvar("r_snowAmbientColor", (0.01, 0.01, 0.01));
  thread shrink_pdeck_lights();
}

main() {
  common_scripts\utility::array_call(level._exfil.debris, ::show);
  level.player setclienttriggeraudiozone("blackice_exfil_int", 2);
  thread event_pipe_explosions();
  var_0 = getent("brush_pipe_run_blocker", "targetname");

  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 delete();
  }

  var_1 = maps\_utility::spawn_anim_model("exfil_oilrig");
  var_1 thread retarget_rig();
  var_2 = maps\_utility::spawn_anim_model("exfil_lifeboat1");
  var_3 = maps\_utility::spawn_anim_model("exfil_lifeboat2");
  var_4 = maps\_utility::spawn_anim_model("exfil_lifeboat3");
  var_5 = maps\_utility::spawn_anim_model("exfil_lifeboat4");
  var_6 = maps\_utility::spawn_anim_model("exfil_lifeboat5");
  var_7 = maps\_utility::spawn_anim_model("exfil_lifeboat6");
  var_8 = maps\_utility::spawn_anim_model("exfil_lifeboat7");
  var_9 = maps\_utility::spawn_anim_model("exfil_lifeboat8");
  var_10 = maps\_utility::spawn_anim_model("exfil_lifeboat9");
  var_11 = maps\_utility::spawn_anim_model("exfil_lifeboat10");
  var_12 = maps\_utility::spawn_anim_model("exfil_lifeboat11");
  var_13 = maps\_utility::spawn_anim_model("exfil_lifeboat12");
  var_14 = maps\_utility::spawn_anim_model("exfil_lifeboat13");
  var_15 = maps\_utility::spawn_anim_model("exfil_lifeboat14");
  var_16 = maps\_utility::spawn_anim_model("exfil_lifeboat15");
  var_17 = maps\_utility::spawn_anim_model("exfil_lifeboat16");
  var_18 = maps\_utility::spawn_anim_model("exfil_lifeboat17");
  var_19 = maps\_utility::spawn_anim_model("exfil_lifeboat18");
  var_20 = maps\_utility::spawn_anim_model("exfil_lifeboat19");
  var_21 = maps\_utility::spawn_anim_model("exfil_lifeboat20");
  var_22 = maps\_utility::spawn_anim_model("player_legs_exfil");
  var_1 hide();
  var_22 hide();
  thread maps\black_ice_fx::exfil_oilrig_preboom_fx(var_1);
  var_23 = level._exfil.struct;
  var_24 = common_scripts\utility::spawn_tag_origin();
  var_24.origin = var_23.origin;
  var_24.angles = var_23.angles;
  var_25 = common_scripts\utility::getstruct("vignette_exfil_runout", "script_noteworthy");
  common_scripts\utility::flag_set("flag_stop_fire_tower_sfx_logic");
  thread player_sprint();
  thread ally_sprint();
  thread dialog_main();
  thread player_heat_fx();
  thread exfil_slomo();
  thread exfil_heli(var_23);
  thread exfil_random_quaker();
  thread exfil_deck_explosions();
  thread exfil_hall_explosions();
  thread maps\black_ice_util::rotatelights("light_spinner_h", "light_spin_h", "yaw");
  thread maps\black_ice_util::rotatelights("light_spinner_v", "light_spin_v", "pitch");
  thread maps\black_ice_util::rotatelights("light_spinner_v2", "light_spin_v2", "pitch");
  thread exfil_light_burst();
  thread exfil_steam_burst();
  thread exfil_hall_light_flicker();
  thread exfil_engine_fires();
  thread exfil_yellow_alarms();
  thread flyout_lights();
  thread exfil_dof();
  thread exfil_vision_bump();
  thread exfil_mblur_changes();
  var_26 = level._allies;
  common_scripts\utility::array_thread(var_26, maps\_utility::set_goal_radius, 8);
  thread exfil_anims_cornering(var_25, var_23, var_26, 1);
  thread exfil_anims_cornering(var_25, var_23, var_26, 0);
  level waittill("notify_start_ladder_chase");
  common_scripts\utility::flag_set("flag_ladder_chase");
  maps\black_ice_util::setup_player_for_animated_sequence(0, undefined, undefined, undefined, 1, 1);
  level.player_rig hide();
  var_27 = [level.player_rig, var_1, var_22, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21];
  var_26 = common_scripts\utility::array_combine(var_26, level._exfil_heli);
  var_26 = common_scripts\utility::array_combine(var_27, var_26);

  foreach(var_29 in var_26)
  var_29 linkto(var_24);

  var_26 = common_scripts\utility::array_add(var_26, var_1);
  var_24 thread maps\_anim::anim_single(var_26, "ladder_chase");
  var_24 thread exfil_teleport(var_1);
  var_31 = [var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21];

  foreach(var_33 in var_31)
  thread maps\black_ice_fx::fx_exfil_lifeboat_wake(var_33);

  thread ladder_chase_explosion_fx();
  thread player_explosion_reaction();
  thread ladder_player_jumpcheck();
  thread player_dropgun_before_jump();
  rubberband_ladder_chase(var_26);

  if(level.jump_distance_allowed == 0 || common_scripts\utility::flag("flag_ladder_jumpfail_nojump")) {
    var_35 = 1.0;

    while(var_35 > 0.0) {
      if(common_scripts\utility::flag("flag_ladder_autojump")) {
        common_scripts\utility::flag_set("flag_jumped_too_late");
        break;
      }

      var_35 = var_35 - level.timestep;
      wait(level.timestep);
    }

    common_scripts\utility::flag_set("flag_ladder_jumpfail_nojump");
  }

  if(common_scripts\utility::flag("flag_jumped_too_late")) {
    level.player thread maps\black_ice_audio::sfx_blackice_fail_fall();
    thread maps\black_ice_fx::exfil_player_view_smoke_particles();
    var_36 = maps\_utility::spawn_anim_model("player_rig");
    var_36 hide();
    var_37 = 0.8;
    var_24 thread maps\_anim::anim_single_solo(var_36, "exfil_fail");
    level.player playerlinktoblend(var_36, "tag_player", var_37);
    level.player notify("notify_player_animated_sequence_restrictions");
    wait(var_37);
    var_36 show();
    level waittill("notify_player_hit_ice");
    var_38 = maps\_hud_util::create_client_overlay("black", 0, level.player);
    var_38 fadeovertime(0.01);
    var_38.alpha = 1;
    var_38.foreground = 0;
    wait 1.2;
    setdvar("ui_deadquote", & "BLACK_ICE_EXFIL_LATE");
    thread maps\_utility::missionfailedwrapper();
  } else if(common_scripts\utility::flag("flag_ladder_jumpfail_nojump")) {
    setdvar("ui_deadquote", & "BLACK_ICE_EXFIL_NOJUMP");
    player_fail_rigexplode();
  } else {
    maps\_utility::autosave_by_name("exfil_end");
    level notify("player_ladder_success");
    common_scripts\utility::flag_set("flag_teleport_rig");
    thread maps\black_ice_fx::exfil_player_view_smoke_particles();
    thread player_view_shake();
    thread player_unhide_arms_with_notetrack();
    var_37 = get_blendtime_from_notetrack(level.player_rig, level.scr_anim["player_rig"]["ladder_chase"], "end_blend", 1.0);
    level.player playerlinktoblend(level.player_rig, "tag_player", var_37);
    level.player notify("notify_player_animated_sequence_restrictions");
    wait(var_37);
    var_22 show();
    ambientplay("ambient_blackice_outside_lr", 2);
    level waittill("notify_flyout_fade_to_black");
    wait 2;
    var_38 = maps\_hud_util::create_client_overlay("black", 0, level.player);
    level.player setclienttriggeraudiozone("blackice_end", 2.6);
    var_38 fadeovertime(2.6);
    var_38.alpha = 1;
    var_38.foreground = 0;
    wait 2.5;
    maps\_utility::nextmission();
  }
}

section_flag_inits() {
  common_scripts\utility::flag_init("flag_stop_fire_tower_sfx_logic");
  common_scripts\utility::flag_init("flag_exfil_end");
  common_scripts\utility::flag_init("flag_ladder_jump");
  common_scripts\utility::flag_init("flag_ladder_autojump");
  common_scripts\utility::flag_init("flag_ladder_jumpfail_nojump");
  common_scripts\utility::flag_init("flag_ladder_jumpcheck");
  common_scripts\utility::flag_init("flag_helo_swing");
  common_scripts\utility::flag_init("flag_baker_steam_react");
  common_scripts\utility::flag_init("flag_ladder_chase");
  common_scripts\utility::flag_init("flag_teleport_rig");
  common_scripts\utility::flag_init("flag_command_pipes_explosion");
  common_scripts\utility::flag_init("flag_player_dying_on_rig");
  common_scripts\utility::flag_init("flag_kick_player_to_death");
  common_scripts\utility::flag_init("flag_jumped_too_late");
}

section_precache() {
  precacheitem("freerunner");
}

section_post_inits() {
  level._exfil = spawnStruct();
  level.jump_distance_allowed = 1;
  level._exfil.struct = common_scripts\utility::getstruct("struct_exfil", "targetname");

  if(isDefined(level._exfil.struct)) {
    level._exfil.door = maps\black_ice_util::setup_door("model_exfil_door", "bulkhead_door", "jnt_door");
    var_0 = common_scripts\utility::array_combine(getEntArray("bridge_debris", "targetname"), getEntArray("mg_debris", "targetname"));
    common_scripts\utility::array_call(var_0, ::hide);
    level._exfil.debris = var_0;
  } else
    iprintln("black_ice_exfil.gsc: Warning - Exfil struct missing (compiled out?)");
}

dialog_main() {
  maps\_utility::trigger_wait_targetname("trig_exfil_dialog_radiobravo");
  dialog_radiobravo();
  maps\_utility::trigger_wait_targetname("trig_exfil_dialog_seehelo");
  dialog_seehelo();
  level waittill("notify_exfil_dialog_1");
  dialog_explode();
  level waittill("notify_exfil_dialog_2");
}

dialog_radiobravo() {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_bravowereheadingto");
  wait 0.1;
  maps\_utility::smart_radio_dialogue("black_ice_diz_copywellgetas");
}

dialog_seehelo() {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_theretheyaremove");
}

dialog_explode() {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_shitbravo");
  wait 1.3;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_gogogowe");
}

dialog_jump() {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_jump");
}

exfil_slomo() {
  level waittill("notify_exfil_start_slomo");
  setslowmotion(1.0, 0.5, 3.0);
  level waittill("notify_exfil_end_slomo");
  setslowmotion(0.5, 1.0, 3.0);
}

ladder_chase_explosion_fx() {
  common_scripts\utility::exploder("exfil_vignette_explosion");
  thread maps\black_ice_audio::sfx_blackice_engine_dist_explo();
  wait 3.0;
  common_scripts\utility::exploder("exfil_vignette_explosion_perif_c");
  earthquake(0.3, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  wait 0.8;
  common_scripts\utility::exploder("exfil_vignette_explosion_perif_d");
  earthquake(0.2, 1, level.player.origin, 3000);
  level.player playrumbleonentity("damage_light");
}

player_explosion_reaction() {
  var_0 = common_scripts\utility::getstruct("struct_exfil_explosion_damage", "targetname");
  var_1 = distance(level.player.origin, var_0.origin);
  player_speed_reaction_distance(750, 1100, var_1);
  player_viewkick_distance(var_0, 30, 750, 1200, var_1);
  player_quake_distance(0.7, 0.8, 750, 1300, var_1);
  player_quake_distance(0.3, 3.0, 750, 1300, var_1);
  player_rumble_distance(var_1, "grenade_rumble", 850, "damage_light", 1200);
  player_push_distance((1, 0, 0), 200, 0.35, 750, 1100, var_1);

  if(var_1 < 1000) {
    level.player shellshock("blackice_nosound", 3.0);
    level.player allowsprint(0);
    level.player disableweapons();
    level.player hideviewmodel();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
  }
}

player_pipe_explosion_reaction() {
  var_0 = common_scripts\utility::getstruct("struct_exfil_pipe_explosion", "targetname");
  var_1 = distance(level.player.origin, var_0.origin);
  player_viewkick_distance(var_0, 15, 650, 900, var_1);
  player_quake_distance(0.4, 0.8, 650, 900, var_1);
  player_quake_distance(0.15, 3.0, 650, 900, var_1);
  player_rumble_distance(var_1, "grenade_rumble", 800, "damage_light", 1000);
}

player_speed_reaction_distance(var_0, var_1, var_2) {
  var_3 = maps\black_ice_util::normalize_value(var_0, var_1, var_2);
  thread player_stunned_speed_blender(var_3);
}

player_quake_distance(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < var_3) {
    var_5 = maps\black_ice_util::normalize_value(var_2, var_3, var_4);
    var_6 = maps\black_ice_util::factor_value_min_max(var_0, 0, var_5);
    earthquake(var_6, var_1, level.player.origin, 3000);
  }
}

player_viewkick_distance(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < var_3) {
    var_5 = maps\black_ice_util::normalize_value(var_2, var_3, var_4);
    var_6 = int(maps\black_ice_util::factor_value_min_max(var_1, 0, var_5));
    level.player viewkick(var_6, var_0.origin);
  }
}

player_rumble_distance(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 < var_2)
    level.player playrumbleonentity(var_1);
  else if(var_0 < var_4)
    level.player playrumbleonentity(var_3);
}

player_push_distance(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5 < var_4) {
    var_6 = maps\black_ice_util::normalize_value(var_3, var_4, var_5);
    var_7 = maps\black_ice_util::factor_value_min_max(var_1, 0, var_6);
    thread maps\black_ice_util::push_player_impulse(var_0, var_7, var_2);
  }
}

player_unhide_arms_with_notetrack() {
  level waittill("notify_player_unhide_arms");
  level.player_rig show();
}

player_view_shake() {
  var_0 = 1.0;
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = 3.5;
  var_4 = 0.15;
  var_5 = 0.22;
  var_6 = 0.07;
  maps\black_ice_util::player_view_shake_blender(var_0, 0.02, var_4);

  while(!common_scripts\utility::flag("flag_helo_swing")) {
    earthquake(var_4, 0.2, level.player.origin, 100000.0);
    wait(level.timestep);
  }

  maps\black_ice_util::player_view_shake_blender(var_1, var_4, var_5);
  maps\black_ice_util::player_view_shake_blender(var_2, var_5, var_5);
  maps\black_ice_util::player_view_shake_blender(var_3, var_5, var_6);

  for(;;) {
    earthquake(var_6, 0.2, level.player.origin, 100000.0);
    wait(level.timestep);
  }
}

exfil_teleport(var_0) {
  level endon("notify_exfil_fail");
  var_1 = common_scripts\utility::getstruct("struct_exfil_teleport", "targetname");
  level waittill("notify_exfil_player_teleport");
  common_scripts\utility::exploder("flyout_water_fx");

  if(common_scripts\utility::flag("flag_teleport_rig")) {
    self.origin = var_1.origin;
    self.angles = var_1.angles;
    wait 0.05;
    var_0 show();
  }
}

exfil_deck_explosions() {
  maps\_utility::trigger_wait_targetname("trig_exfil_explode_1");
  level.player playSound("scn_blackice_exfil_explo04");
  common_scripts\utility::exploder("exfil_vignette_explosion_perif_a");
  earthquake(0.3, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  maps\_utility::trigger_wait_targetname("trig_exfil_explode_2");
  common_scripts\utility::exploder("exfil_vignette_explosion_perif_b");
  earthquake(0.3, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  wait 1.2;
  common_scripts\utility::exploder("exfil_vignette_explosion_perif_e");
  earthquake(0.3, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
}

exfil_random_quaker() {
  var_0 = 0.05;
  var_1 = 0.26;
  var_2 = 0.7;
  var_3 = 1.3;
  var_4 = 0.3;
  var_5 = 1.3;

  while(!common_scripts\utility::flag("flag_ladder_jump")) {
    var_6 = randomfloatrange(var_0, var_1);
    var_7 = randomfloatrange(var_4, var_5);
    var_8 = randomfloatrange(var_2, var_3);
    earthquake(var_6, var_8, level.player.origin, 3000);
    wait(var_7);
  }
}

exfil_hall_explosions() {
  maps\_utility::trigger_wait_targetname("trig_command_quake_1");
  earthquake(0.4, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  maps\_utility::trigger_wait_targetname("trig_command_quake_2");
  level.player playSound("scn_blackice_exfil_explo02");
  earthquake(0.5, 1.8, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  wait 1.3;
  common_scripts\utility::exploder("exfil_light_1");
  wait 1.0;
  common_scripts\utility::exploder("exfil_light_2");
  level.player playSound("scn_blackice_exfil_explo03");
}

exfil_light_burst() {
  thread maps\black_ice_anim::runout_group1();
  thread maps\black_ice_anim::runout_group2();
  var_0 = getent("escape_emergency_1", "targetname");
  var_0 setlightintensity(1.6);
  maps\_utility::trigger_wait_targetname("trig_exfil_light_burst");
  common_scripts\utility::exploder("exfil_light_3");
  level.player playSound("scn_blackice_exfil_explo01");
  earthquake(0.3, 1.1, level.player.origin, 2000);
  level.player playrumbleonentity("damage_heavy");
  var_0 setlightintensity(2);
  var_0 maps\black_ice_util::flicker(0.9, 0.5);
}

exfil_steam_burst() {
  thread maps\black_ice_anim::runout_group3();
  level waittill("notify_exfil_steam_burst");
  earthquake(0.35, 1.3, level.player.origin, 2000);
  level.player playrumbleonentity("grenade_rumble");
  common_scripts\utility::exploder("exfil_steam_burst");
  maps\_utility::stop_exploder("fx_command_interior");
}

exfil_hall_light_flicker() {
  var_0 = getEntArray("escape_emergency_3", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(1.5);
    var_2 thread maps\black_ice_util::flicker(0.9, 0.5);
  }
}

exfil_engine_fires() {
  common_scripts\utility::exploder("exfil_hall_ambfx");
  common_scripts\utility::exploder("exfil_engine_fire");
}

exfil_yellow_alarms() {}

player_sprint() {
  setsaveddvar("player_sprintUnlimited", "1");
  level.player disableoffhandweapons();
  maps\_utility::player_speed_percent(90, 1);
}

ally_sprint() {
  common_scripts\utility::array_thread(level._allies, ::ally_sprint_setup);
  level._allies[1] thread ally_rubber_banding_solo(level._allies[0]);
  level._allies[0] thread ally_rubber_banding_solo(level.player);
  level.player player_rubber_banding_solo(level._allies[0]);
  level waittill("notify_stop_rubber_banding");
  common_scripts\utility::array_thread(level._allies, ::ally_sprint_end);
}

ally_sprint_setup() {
  maps\_utility::disable_cqbwalk();
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.usechokepoints = 0;
  maps\_utility::enable_sprint();
  maps\black_ice_util::ignore_everything();
  maps\_utility::set_run_anim("DRS_sprint");
}

ally_sprint_end() {
  self.disablearrivals = 0;
  self.disableexits = 0;
  self.usechokepoints = 1;
  maps\_utility::disable_sprint();
  maps\black_ice_util::unignore_everything();
  maps\_utility::clear_run_anim();
}

exfil_anims_cornering(var_0, var_1, var_2, var_3) {
  if(var_3 == 0 && level.start_point != "exfil")
    var_2[var_3] waittill("notify_command_end_done");

  var_0 maps\_anim::anim_reach_solo(var_2[var_3], "exfil_corner_cut");
  var_0 maps\_anim::anim_single_solo(var_2[var_3], "exfil_corner_cut", undefined, 0.1);
  var_0 maps\_anim::anim_reach_solo(var_2[var_3], "exfil_steam_react");
  level notify("notify_stop_rubber_banding");

  if(var_3 == 0) {
    thread rubberband_near_ally_steam_reaction_runout(var_2, var_3);
    var_0 maps\_anim::anim_single_solo(var_2[var_3], "exfil_steam_react");
  } else {
    thread rubberband_far_ally_steam_reaction_runout(var_2);
    var_0 thread maps\_anim::anim_single_solo(var_2[var_3], "exfil_steam_react");
    var_0 maps\_anim::anim_single_solo(level._exfil.door, "shoulder_door");
  }
}

rubberband_near_ally_steam_reaction_runout(var_0, var_1) {
  common_scripts\utility::flag_set("flag_baker_steam_react");
  var_2 = 80;
  var_3 = 180;
  var_4 = 320;
  var_5 = 625;
  var_6 = 1.1;
  var_7 = 0.8;
  var_8 = 210;
  var_9 = 180;
  var_10 = 110;
  var_11 = 0;

  while(!common_scripts\utility::flag("flag_ladder_chase")) {
    var_12 = distance(var_0[0].origin, var_0[1].origin);
    var_13 = distance(level.player.origin, var_0[1].origin);
    var_11 = var_13 - var_12;

    if(var_11 > var_3) {
      var_14 = maps\black_ice_util::normalize_value(var_3, var_4, var_11);
      var_15 = maps\black_ice_util::factor_value_min_max(var_9, var_8, var_14);
      var_16 = maps\black_ice_util::factor_value_min_max(1, var_7, var_14);
    } else {
      var_14 = maps\black_ice_util::normalize_value(var_2, var_3, var_11);
      var_15 = maps\black_ice_util::factor_value_min_max(var_10, var_9, var_14);
      var_16 = maps\black_ice_util::factor_value_min_max(var_6, 1, var_14);
    }

    setsaveddvar("g_speed", var_15);
    maps\_anim::anim_set_rate_single(var_0[0], "exfil_steam_react", var_16);

    if(var_11 > var_5) {
      setdvar("ui_deadquote", & "BLACK_ICE_SPRINT_ESCAPE");
      player_fail_rigexplode();
    }

    wait(level.timestep);
  }
}

rubberband_far_ally_steam_reaction_runout(var_0) {
  wait 0.1;
  var_1 = 0.005;
  common_scripts\utility::flag_wait("flag_baker_steam_react");

  while(!common_scripts\utility::flag("flag_ladder_chase")) {
    var_2 = var_0[0] getanimtime(level.scr_anim["ally1"]["exfil_steam_react"]);
    var_3 = var_0[1] getanimtime(level.scr_anim["ally2"]["exfil_steam_react"]);
    var_4 = abs(var_3 - var_2);

    if(var_4 > var_1) {
      if(var_3 > var_2)
        var_3 = var_3 - var_1;
      else
        var_3 = var_3 + var_1;
    } else
      var_3 = var_2;

    var_0[1] setanimtime(level.scr_anim["ally2"]["exfil_steam_react"], var_3);
    level._exfil.door setanimtime(level.scr_anim["bulkhead_door"]["shoulder_door"], var_3);
    wait(level.timestep);
  }
}

ally_rubber_banding_solo(var_0) {
  level endon("notify_stop_rubber_banding");
  var_1 = 0.8;
  var_2 = 2.0;
  var_3 = 384;

  for(;;) {
    var_4 = distance(self.origin, var_0.origin);

    if(var_4 > var_3)
      var_4 = var_3;
    else if(var_4 < 0)
      var_4 = 0;

    var_5 = var_4 / var_3;
    var_6 = var_2 - (var_2 - var_1) * var_5;
    self.moveplaybackrate = var_6;

    if(self.moveplaybackrate > 1.2)
      self.moveplaybackrate = 1.2;

    wait 0.05;
  }
}

player_rubber_banding_solo(var_0) {
  level endon("notify_stop_rubber_banding");
  var_1 = 210;
  var_2 = 110;
  var_3 = 384;
  var_4 = 650;

  for(;;) {
    var_5 = distance(self.origin, var_0.origin);

    if(var_5 > var_4) {
      setdvar("ui_deadquote", & "BLACK_ICE_FOLLOW_ALLIES");
      thread player_fail_rigexplode();
    } else if(var_5 > var_3)
      var_5 = var_3;
    else if(var_5 < 0)
      var_5 = 0;

    var_6 = var_5 / var_3;
    var_7 = var_2 - (var_2 - var_1) * var_6;
    setsaveddvar("g_speed", var_7);
    wait 0.05;
  }
}

exfil_heli(var_0) {
  maps\_utility::trigger_wait_targetname("trig_exfil_heli_start");
  common_scripts\utility::exploder("pipedeck_exfil_fx");
  thread fires();
  var_1 = maps\_utility::spawn_anim_model("exfil_helo");
  level.heli = var_1;
  var_2 = maps\_utility::spawn_anim_model("exfil_ladder");
  thread exfil_heli_spotlight();
  level._exfil_heli = [var_1, var_2];
  thread maps\black_ice_audio::sfx_blackice_exfil_heli();
  var_0 thread maps\_anim::anim_single(level._exfil_heli, "idle");
  common_scripts\utility::exploder("pipedeck_giant_smoke_for_exfil");
  maps\black_ice_fx::exfil_heli_smoke_fx_01();
}

exfil_heli_spotlight() {
  playFXOnTag(level._effect["heli_spotlight"], level.heli, "tag_flash");
  level waittill("notify_helo_spotlight_off");
  stopFXOnTag(level._effect["heli_spotlight"], level.heli, "tag_flash");
}

fires() {
  var_0 = ["exfil_fire"];
  var_1 = common_scripts\utility::getstructarray("struct_exfil_fires", "targetname");

  foreach(var_3 in var_1)
  playFX(common_scripts\utility::getfx(common_scripts\utility::random(var_0)), var_3.origin + (0, 0, -200));
}

rubberband_ladder_chase(var_0) {
  level endon("notify_exfil_fail");
  var_1 = 100000;
  var_2 = 60000.0;
  var_3 = -90000.0;
  var_4 = 0.8;
  var_5 = 1.2;
  var_6 = 0.0;
  var_7 = 0.0;
  var_8 = 0.0;
  var_9 = 0.0;

  while(!common_scripts\utility::flag("flag_ladder_jump") && !common_scripts\utility::flag("flag_ladder_autojump") && !common_scripts\utility::flag("flag_ladder_jumpfail_nojump")) {
    var_10 = level.player_max_speed;
    var_11 = level.player_min_speed;
    var_7 = distancesquared(level.player_rig.origin, level._allies[1].origin);
    var_8 = distancesquared(level.player getEye(), level._allies[1].origin);
    var_6 = var_8 - var_7;
    var_12 = maps\black_ice_util::normalize_value(var_3, var_2, var_6);
    var_9 = maps\black_ice_util::factor_value_min_max(var_11, var_10, var_12);
    var_13 = maps\black_ice_util::factor_value_min_max(var_5, var_4, var_12);
    setsaveddvar("g_speed", var_9);
    maps\_anim::anim_set_rate(var_0, "ladder_chase", var_13);

    if(var_6 < var_1)
      level.jump_distance_allowed = 1;
    else
      level.jump_distance_allowed = 0;

    wait(level.timestep);
  }

  maps\_anim::anim_set_rate(var_0, "ladder_chase", 1);
  return var_6;
}

player_dropgun_before_jump() {
  level waittill("flag_player_drop_gun");
  thread maps\black_ice_audio::blackice_exfil_stinger_music();
  level.player.disablereload = 1;
  level.player giveweapon("freerunner");
  level.player switchtoweapon("freerunner");
  level.player disableweaponswitch();
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("ui_hidemap", 1);
}

test_viewmodel_anim(var_0) {
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 maps\_utility::assign_animtree(var_0);
  level.player playersetgroundreferenceent(var_2);
  var_1 thread maps\_anim::anim_single_solo(var_1, var_0);
  var_2 maps\_anim::anim_single_solo(var_2, var_0);
  level.player playersetgroundreferenceent(undefined);
  var_2 delete();
  var_1 delete();
}

ladder_player_jumpcheck() {
  level endon("flag_player_dying_on_rig");
  var_0 = 0;
  var_1 = 0;
  var_2 = 2576;
  var_3 = 0;
  var_4 = maps\_utility::spawn_anim_model("player_rig");
  var_4 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  var_4 maps\_anim::anim_first_frame_solo(var_4, "jump_arms");
  level.jumparms = var_4;
  var_5 = maps\_utility::spawn_anim_model("cam_shake");
  var_5.origin = level.player.origin;
  var_5.angles = level.player.angles;
  var_5 linkto(level.player);

  while(!common_scripts\utility::flag("flag_ladder_jump")) {
    if(level.player jumpbuttonpressed()) {
      if(var_0)
        var_1 = 1;
      else
        var_0 = 1;
    } else {
      if(var_1)
        var_1 = 0;

      if(var_0)
        var_0 = 0;
    }

    if(common_scripts\utility::flag("flag_ladder_jumpcheck") && var_3 < 10 && var_0 && !var_1 || common_scripts\utility::flag("flag_ladder_autojump")) {
      common_scripts\utility::flag_set("flag_ladder_jump");
      var_5 unlink();
      level.player playersetgroundreferenceent(var_5);
      level.player playrumbleonentity("pistol_fire");

      if(level.jump_distance_allowed == 1) {
        thread maps\black_ice_audio::sfx_exfil_outro();
        var_5 thread maps\_anim::anim_single_solo(var_5, "jump_shake");
        var_4 maps\_anim::anim_single_solo(var_4, "jump_arms");
      } else {}

      var_4 delete();
    }

    var_3 = level.player.origin[2] - var_2;
    wait(level.timestep);
  }
}

player_heat_fx() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0.origin = level.player.origin;
  var_0 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  var_1 = 0;
  level waittill("flag_vision_exfil_deck");

  for(;;) {
    if(common_scripts\utility::flag("flag_vision_exfil_deck")) {
      if(var_1 != 1) {
        player_heat_fx_start(var_0);
        var_1 = 1;
      }

      earthquake(0.05, 0.2, level.player.origin, 128);
    } else if(var_1 == 1) {
      player_heat_fx_end(var_0);
      var_1 = 0;
    }

    wait(level.timestep);
  }
}

player_heat_fx_start(var_0) {
  maps\_art::dof_enable_script(0, 0, 4, 0, 777, 1.49, 0);
  level.player setviewmodeldepthoffield(0.0, 13.26);
}

player_heat_fx_end(var_0) {
  maps\_art::dof_disable_script(0);
  level.player setviewmodeldepthoffield(0.0, 0.0);
}

player_stunned_speed_blender(var_0) {
  var_1 = 220;
  var_2 = 100;
  var_3 = 80;
  var_4 = 20;
  var_5 = 180;
  var_6 = 50;
  var_7 = 1.0;
  var_8 = 1.2;
  var_9 = 4.0;
  var_10 = getdvarfloat("g_speed");
  var_11 = maps\black_ice_util::factor_value_min_max(var_4, var_6, var_0);
  var_12 = maps\black_ice_util::factor_value_min_max(var_3, var_5, var_0);
  player_lerp_speed(var_10, var_10, var_11, var_12, var_7);
  wait(var_8);
  thread player_stun_return_weapons_sprint(0.0);
  player_lerp_speed(var_11, var_12, var_2, var_1, var_9);
}

player_stun_return_weapons_sprint(var_0) {
  wait(var_0);
  level.player showviewmodel();
  level.player allowsprint(1);
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
}

player_lerp_speed(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4;

  for(;;) {
    var_6 = maps\black_ice_util::normalize_value(0, var_4, var_5);
    var_7 = maps\black_ice_util::factor_value_min_max(var_2, var_0, var_6);
    var_8 = maps\black_ice_util::factor_value_min_max(var_3, var_1, var_6);
    level.player_min_speed = var_7;
    level.player_max_speed = var_8;
    wait(level.timestep);
    var_5 = var_5 - level.timestep;

    if(var_5 < 0) {
      break;
    }
  }

  level.player_min_speed = var_2;
  level.player_max_speed = var_3;
}

player_fail_rigexplode() {
  if(!common_scripts\utility::flag("flag_player_dying_on_rig"))
    common_scripts\utility::flag_set("flag_player_dying_on_rig");
  else
    return;

  if(isDefined(level.jumparms))
    level.jumparms delete();

  var_0 = maps\_utility::spawn_anim_model("exfil_viewexplosion_source");
  var_0 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 0);
  maps\_utility::vision_set_fog_changes("black_ice_exfil_explosive_death", 1.3);
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("ui_hidemap", 1);
  level.player hideviewmodel();
  level.player disableweapons();
  earthquake(0.6, 0.9, level.player.origin, 3000);
  level.player shellshock("blackice_nosound", 1.25);
  level.player playrumbleonentity("grenade_rumble");
  level.player thread maps\_gameskill::blood_splat_on_screen("right");
  level.player thread maps\black_ice_audio::sfx_blackice_fail_explo();
  playFXOnTag(common_scripts\utility::getfx("exfil_view_explosion"), var_0, "tag_splode_1");
  level.player allowsprint(0);
  wait 0.65;
  earthquake(0.5, 0.7, level.player.origin, 3000);
  level.player shellshock("blackice_nosound", 0.75);
  level.player playrumbleonentity("damage_light");
  level.player thread maps\_gameskill::blood_splat_on_screen("left");
  playFXOnTag(common_scripts\utility::getfx("exfil_view_explosion"), var_0, "tag_splode_2");
  wait 0.8;
  thread player_viewkicker(var_0);
  earthquake(0.7, 2.0, level.player.origin, 3000);
  level.player shellshock("blackice_nosound", 3.0);
  level.player shellshock("slowview", 5000);
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  playFXOnTag(common_scripts\utility::getfx("exfil_view_explosion"), var_0, "tag_splode_3");
  wait 0.3;
  var_1 = level.player getstance();

  if(var_1 == "stand") {
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(var_1 == "crouch") {
    level.player allowstand(0);
    level.player allowprone(0);
  } else {
    level.player allowstand(0);
    level.player allowcrouch(0);
  }

  var_2 = common_scripts\utility::spawn_tag_origin();
  level.player playerlinkto(var_2, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_3 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_3 fadeovertime(0.2);
  var_3.alpha = 1;
  var_3.foreground = 0;
  wait 1.5;
  thread maps\_utility::missionfailedwrapper();
}

player_viewkicker(var_0) {
  thread player_viewkicker_timer();

  while(!common_scripts\utility::flag("flag_kick_player_to_death")) {
    level.player playrumbleonentity("grenade_rumble");
    wait 0.1;
  }
}

player_viewkicker_timer() {
  wait 0.45;
  common_scripts\utility::flag_set("flag_kick_player_to_death");
}

notetrack_slowmo_start(var_0) {}

get_blendtime_from_notetrack(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_1);
  var_5 = getnotetracktimes(var_1, var_2);
  var_6 = var_0 getanimtime(var_1);
  var_7 = (var_5[0] - var_6) * var_4;

  if(var_7 > var_3)
    var_7 = var_3;

  return var_7;
}

open_exfil_door() {
  var_0 = level._exfil.door;
  var_0.angles = var_0.original_angles;
  maps\_utility::trigger_wait_targetname("trig_exfil_door_open");
  var_0 maps\black_ice_util::open_door(120, 0.6);
}

notetrack_grab_shake(var_0) {
  level.player playrumbleonentity("grenade_rumble");
}

notetrack_shockwave_shake(var_0) {
  earthquake(0.3, 1.0, level.player.origin, 2048);
  level.player playrumbleonentity("grenade_rumble");
}

event_pipe_explosions() {
  var_0 = maps\black_ice_util::setup_tag_anim_rig("pipe_explosion4", "pipedeck_explosion4_rig");
  var_0.anim_node maps\_anim::anim_first_frame_solo(var_0, "pipes_explode");
  common_scripts\utility::flag_wait("flag_command_pipes_explosion");
  playFX(level._effect["explosion_oiltank_lg"], var_0.origin + (-75, 0, 0));
  level.player playSound("scn_blackice_exfil_pipes");
  level.player setclienttriggeraudiozone("blackice_exfil_ext", 2);
  thread maps\black_ice_audio::sfx_exfil_stop_alarm();
  player_pipe_explosion_reaction();
  var_0.anim_node maps\_anim::anim_single_solo(var_0, "pipes_explode");
  maps\_utility::stop_exploder("exfil_hall_ambfx");
  maps\_utility::stop_exploder("exfil_light_1");
  maps\_utility::stop_exploder("exfil_light_2");
  maps\_utility::stop_exploder("exfil_light_3");
  maps\_utility::stop_exploder("exfil_engine_fire");
}

exfil_vision_bump() {
  level waittill("notify_sphere_hit_ground");
  wait 1.1;
  maps\black_ice_util::vision_hit_transition("black_ice_rig_explode", "black_ice_flyout", 1.0, 0.3, 1.6);
}

exfil_dof() {
  level waittill("flag_teleport_rig");
  maps\_art::sunflare_changes("flyout", 0.1);
  setsaveddvar("r_snowAmbientColor", (0.025, 0.025, 0.025));
  maps\_art::dof_enable_script(0, 62, 4, 73, 1380, 2, 0.25);
  level waittill("flag_helo_swing");
  maps\_art::dof_enable_script(1, 62, 4, 3848, 4000, 0, 6);
}

exfil_rimlight() {
  level waittill("flag_teleport_rig");
}

flyout_lights() {
  var_0 = getEntArray("flyout_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2 setlightcolor((1, 0.501961, 0));
    var_2 setlightintensity(2);
    var_2 thread maps\black_ice_util::flicker(undefined, undefined, undefined, 2);
  }
}

retarget_rig() {
  self retargetscriptmodellighting(getent("rig_lighttarget", "targetname"));
}

exfil_mblur_changes() {
  common_scripts\utility::flag_wait("flag_teleport_rig");

  if(maps\_utility::is_gen4() && !level.ps4) {
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbCameraRotationInfluence", 0.07);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.15);
    setsaveddvar("r_mbModelVelocityScalar", 0.03);
    setsaveddvar("r_mbStaticVelocityScalar", 0.01);
    setsaveddvar("r_mbViewModelEnable", 1);
    setsaveddvar("r_mbViewModelVelocityScalar", 0.004);
  }
}

shrink_pdeck_lights() {
  var_0 = getEntArray("lights_pipedeck_a", "targetname");
  var_1 = getEntArray("lights_pipedeck_b", "targetname");
  var_2 = getEntArray("lights_pipedeck_c", "targetname");

  foreach(var_4 in var_0)
  var_4 setlightradius(12);

  foreach(var_4 in var_1)
  var_4 setlightradius(12);

  foreach(var_4 in var_2)
  var_4 setlightradius(12);
}