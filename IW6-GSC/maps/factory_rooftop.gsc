/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_rooftop.gsc
*****************************************************/

start() {
  level.player maps\factory_util::move_player_to_start_point("playerstart_rooftop");
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "rooftop_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "rooftop_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "rooftop_start_charlie");
  common_scripts\utility::flag_set("ambush_escape_clear");
  common_scripts\utility::flag_set("spawn_loading_dock_vehicles");
  thread rooftop_heli();
  maps\factory_util::safe_trigger_by_targetname("ambush_escape_allies_rooftop");
  thread maps\factory_fx::rooftop_wind_gusts();
  thread rooftop_door_breach();
  thread maps\factory_chase::chase_ally_vehicle_setup();
  thread maps\factory_intro::train_cleanup();
}

main() {
  thread kill_backtrackers();
  thread rooftop_fan_spin();
  maps\_utility::autosave_by_name("rooftop");

  foreach(var_1 in level.squad)
  var_1.no_pistol_switch = 1;

  thread rooftop_win();
  level waittill("rooftop_door_kicked");
  thread rooftop_enemy_cleanup();
  thread rooftop_ally_movement_setup();
  thread rooftop_enemy_retreating();
  thread maps\factory_chase::car_chase_intro_car_crash_setup();
  thread rooftop_staircase_threatbias();
  level.squad["ALLY_ALPHA"] maps\_utility::enable_ai_color();
  level.squad["ALLY_BRAVO"] maps\_utility::enable_ai_color();
  level.squad["ALLY_CHARLIE"] maps\_utility::enable_ai_color();
  level waittill("rooftop_enemies_cleared");
}

section_

section_flag_init() {
  common_scripts\utility::flag_init("rooftop_complete");
  common_scripts\utility::flag_init("player_jumping");
  common_scripts\utility::flag_init("rooftop_heli_unloaded");
  common_scripts\utility::flag_init("rooftop_heli_okay_to_depart");
  common_scripts\utility::flag_init("rooftop_breach_alpha_in_position");
  common_scripts\utility::flag_init("rooftop_breach_charlie_in_position");
  common_scripts\utility::flag_init("spotlight_off");
  common_scripts\utility::flag_init("rooftop_door_open");
}

rooftop_fan_spin() {
  level endon("rooftop_complete");
  var_0 = getent("rooftop_fan", "targetname");

  for(;;) {
    var_0 rotatepitch(360, 10);
    wait 10;
  }
}

rooftop_pipes_cleanup() {
  common_scripts\utility::flag_wait("player_off_roof");
  var_0 = getEntArray("pipe_shootable", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

rooftop_enemy_waves() {
  common_scripts\utility::flag_wait("player_near_rooftop_door");
  thread rooftop_enemy_surprised();
  rooftop_enemy_wave_1();
  thread rooftop_enemy_wave_2_upper();
  thread rooftop_enemy_wave_2_lower();
  thread rooftop_parking_lot_enemies();
  waittillframeend;
  rooftop_enemies_wait_to_attack();
  rooftop_last_guys_rush();
  level.player.threatbias = 0;
}

rooftop_enemy_wave_1() {
  var_0 = getEntArray("rooftop_enemy_spawner_wave_1", "targetname");

  foreach(var_2 in var_0)
  var_2 maps\_utility::spawn_ai(1);
}

rooftop_enemy_wave_2_upper() {
  level endon("player_went_lower_path");
  maps\_utility::trigger_wait_targetname("rooftop_upper_wave_2_trigger");
  level notify("player_went_upper_path");
  var_0 = getent("rooftop_wave_2_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
}

rooftop_enemy_wave_2_lower() {
  level endon("player_went_upper_path");
  maps\_utility::trigger_wait_targetname("rooftop_wave_2_trigger");
  level notify("player_went_lower_path");
  var_0 = getent("rooftop_upper_wave_2_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  var_0 = getent("rooftop_enemy_fan_spawner_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
}

rooftop_parking_lot_enemies() {
  level waittill("rooftop_enemies_cleared");
  thread maps\factory_parking_lot::parking_lot_blockade_vehicle_1("blockade_vehicle_1");
  var_0 = getEntArray("parking_lot_wave_1", "targetname");
  maps\_spawner::flood_spawner_scripted(var_0);
  level waittill("here_comes_the_truck");

  foreach(var_2 in var_0)
  var_2 notify("stop current floodspawner");
}

rooftop_enemies_wait_to_attack() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.dontevershoot = 1;

  level waittill("rooftop_door_kicked");
  wait 1;

  foreach(var_2 in var_0)
  var_2.dontevershoot = undefined;
}

rooftop_last_guys_rush() {
  for(;;) {
    var_0 = maps\_utility::get_living_ai_array("rooftop_enemy", "script_noteworthy");

    if(var_0.size <= 2) {
      maps\factory_util::safe_trigger_by_targetname("rooftop_r_ally_move_410");
      maps\factory_util::safe_trigger_by_targetname("p_b_ally_move_600");
      level notify("rooftop_enemies_cleared");
      break;
    }

    wait 0.25;
  }
}

rooftop_enemy_retreating() {
  maps\_utility::trigger_wait_targetname("rooftop_ally_move_406");
  var_0 = getent("rooftop_section_1", "targetname");
  badplace_brush("rooftop_section_1", -1, var_0, "axis");
  maps\_utility::trigger_wait_targetname("rooftop_ally_move_408");
  var_0 = getent("rooftop_section_2", "targetname");
  badplace_brush("rooftop_section_2", -1, var_0, "axis");
  level waittill("rooftop_complete");
  badplace_delete("rooftop_section_1");
  badplace_delete("rooftop_section_2");
}

rooftop_enemy_door_kicker() {
  wait 2;
  var_0 = maps\_utility::spawn_targetname("rooftop_enemy_spawner_door_kicker");
  var_0.ignoreme = 1;
  var_0.attackeraccuracy = 100;
  var_0.health = 1;
  var_0.animname = "enemy";
  var_1 = getent("door_kicker_node", "targetname");
  var_1 thread maps\_anim::anim_single_run_solo(var_0, "rooftop_enemy_door_kick");
  thread maps\factory_audio::sfx_kicking_door_sound();
  wait 2.1;
  var_2 = getent("rooftop_enemy_door_blocker", "targetname");
  var_2 connectpaths();
  var_2 notsolid();
  thread rooftop_ally_doorway_blocker();
  var_3 = getent("rooftop_enemy_door", "targetname");
  var_3 rotateto(var_3.angles - (0, 175, 0), 0.3, 0, 0.1);
  var_0.ignoreme = 0;
  level.squad["ALLY_CHARLIE"].favoriteenemy = var_0;
  wait 0.3;
  var_3 rotateto(var_3.angles + (0, 20, 0), 0.7, 0, 0.1);
}

rooftop_staircase_threatbias() {
  level endon("rooftop_complete");
  createthreatbiasgroup("squad");
  maps\_utility::trigger_wait_targetname("rooftop_stair_flank_trigger");
  level.player.threatbias = -2000;

  foreach(var_1 in level.squad)
  var_1 setthreatbiasgroup("squad");

  setthreatbias("axis", "squad", 1500);
}

rooftop_ally_movement_setup() {
  level endon("rooftop_enemies_cleared");
  thread allies_jump_off_roof();

  foreach(var_1 in level.squad) {
    var_1.fixednodesaferadius = 128;
    var_1.suppressionwait = 4200;
  }

  rooftop_ally_movement("rooftop_section_1", "rooftop_ally_move_404");
  wait 2;
  rooftop_ally_movement("rooftop_section_2", "rooftop_ally_move_406");
  var_3 = getent("rooftop_wave_2_trigger", "targetname");
  common_scripts\utility::flag_set("factory_rooftop_wind_gust_moment");
  maps\factory_util::safe_trigger_by_targetname("rooftop_wave_2_trigger");
  wait 2;
  rooftop_ally_movement("rooftop_section_3", "rooftop_ally_move_408");
  common_scripts\utility::flag_wait("rooftop_heli_unloaded");
  rooftop_ally_movement("rooftop_section_4", "rooftop_ally_move_409");
  wait 1;
  rooftop_ally_movement("rooftop_section_5", "rooftop_ally_move_410");
  wait 1;
  rooftop_ally_movement("rooftop_section_6", "p_b_ally_move_600");
  maps\factory_util::safe_trigger_by_targetname("rooftop_r_ally_move_411");
  common_scripts\utility::flag_set("rooftop_heli_okay_to_depart");
  common_scripts\utility::flag_set("factory_rooftop_wind_gust_moment");
  level notify("rooftop_enemies_cleared");
}

rooftop_ally_doorway_blocker() {
  maps\_utility::trigger_wait_targetname("doorway_block_trigger");
  level.squad["ALLY_BRAVO"].ignoreall = 1;
  level.squad["ALLY_BRAVO"] clearenemy();
  var_0 = getent("rooftop_enemy_door_blocker", "targetname");
  var_0 solid();
  var_0 disconnectpaths();
  wait 2;
  level.squad["ALLY_BRAVO"].ignoreall = 0;
}

allies_jump_off_roof() {
  level waittill("rooftop_enemies_cleared");
  level.squad["ALLY_ALPHA"] thread ally_vignette_traversal("ally_alpha_jump_node", "factory_rooftop_jumpoff_ally01");
  level.squad["ALLY_CHARLIE"] thread ally_vignette_traversal("ally_charlie_jump_node", "factory_rooftop_jumpoff_ally03");
  maps\factory_util::safe_trigger_by_targetname("rooftop_r_ally_move_411");
  maps\_utility::wait_for_flag_or_timeout("player_near_rooftop_end", 30);
  common_scripts\utility::flag_set("rooftop_heli_okay_to_depart");
  level.squad["ALLY_BRAVO"] ally_vignette_traversal("ally_bravo_jump_node", "factory_rooftop_jumpoff_ally02");

  foreach(var_1 in level.squad)
  var_1 thread ally_color_node_hack();

  maps\factory_util::safe_trigger_by_targetname("r_ally_move_600");
}

ally_color_node_hack() {
  while(!common_scripts\utility::flag("allies_in_loading_dock")) {
    if(isDefined(self.color_node) && isalive(self.color_node.owner)) {
      self pushplayer(1);
      self setgoalpos(self.color_node.origin);
    }

    wait 1;
  }
}

ally_vignette_traversal(var_0, var_1) {
  level endon("deleting_echo");
  maps\_utility::disable_pain();
  self.ignoresuppression = 1;
  var_2 = getent(var_0, "script_noteworthy");
  var_2 maps\_anim::anim_reach_solo(self, var_1);
  var_2 maps\_anim::anim_single_run_solo(self, var_1);
  maps\_utility::enable_ai_color();
}

rooftop_ally_movement(var_0, var_1) {
  level endon("rooftop_enemies_cleared");
  var_2 = getent(var_0, "targetname");
  var_2 maps\_utility::waittill_volume_dead_or_dying();
  var_3 = getent(var_1, "targetname");
  maps\factory_util::safe_trigger_by_targetname(var_1);
  waittillframeend;

  if(isDefined(var_3))
    var_3 delete();
}

rooftop_door_breach() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_surprise();
    var_1 pushplayer(0);
  }

  var_3 = [];
  var_3[var_3.size] = level.squad["ALLY_ALPHA"];
  var_3[var_3.size] = level.squad["ALLY_CHARLIE"];
  var_4 = getent("rooftop_breach_door", "targetname");
  var_4.animname = "rooftop_breach_door";
  var_4 maps\_utility::assign_animtree();
  var_5 = getent("rooftop_breach_node", "script_noteworthy");
  var_5 thread rooftop_breach_alpha_get_ready();
  var_5 thread rooftop_breach_charlie_get_ready();
  thread rooftop_door_breach_sight_check();
  common_scripts\utility::flag_wait_all("rooftop_breach_alpha_in_position", "rooftop_breach_charlie_in_position", "player_near_rooftop_door");
  thread rooftop_enemy_waves();
  thread rooftop_dialog();
  wait 0.75;
  var_5 notify("stop_idle");
  level notify("door_kick_start");
  common_scripts\utility::flag_set("rooftop_door_open");
  var_3[var_3.size] = var_4;
  var_5 thread maps\_anim::anim_single(var_3, "rooftop_breach");
  waittillframeend;
  thread rooftop_enemy_door_kicker();
  wait 3.6;
  level notify("rooftop_door_kicked");
  var_6 = getent("rooftop_door_clip", "targetname");
  var_6 connectpaths();
  wait 0.3;
  maps\_utility::activate_trigger("rooftop_go_trigger", "targetname");
  var_6 delete();
  wait 1;

  foreach(var_1 in level.squad)
  var_1 maps\_utility::enable_surprise();

  maps\_utility::battlechatter_on();
}

rooftop_door_breach_sight_check() {
  level endon("player_near_rooftop_door");
  var_0 = getent("rooftop_door_lookat_check", "targetname");

  while(!level.player maps\_utility::player_looking_at(var_0.origin))
    wait 0.1;

  common_scripts\utility::flag_set("player_near_rooftop_door");
}

rooftop_breach_alpha_get_ready() {
  var_0 = [];
  var_0[var_0.size] = level.squad["ALLY_ALPHA"];
  maps\_anim::anim_reach_and_approach(var_0, "rooftop_breach_idle");
  thread maps\_anim::anim_loop(var_0, "rooftop_breach_idle", "stop_idle");
  common_scripts\utility::flag_set("rooftop_breach_alpha_in_position");
}

rooftop_breach_charlie_get_ready() {
  var_0 = [];
  var_0[var_0.size] = level.squad["ALLY_CHARLIE"];
  maps\_anim::anim_reach_and_approach(var_0, "rooftop_breach_idle");
  thread maps\_anim::anim_loop(var_0, "rooftop_breach_idle", "stop_idle");
  common_scripts\utility::flag_set("rooftop_breach_charlie_in_position");
}

rooftop_enemy_surprised() {
  var_0 = maps\_utility::spawn_targetname("door_breach_enemy_01");
  var_0 endon("damage");
  level waittill("rooftop_door_kicked");

  if(isalive(var_0)) {
    var_0.animname = "enemy";
    var_0 thread maps\_anim::anim_single_solo(var_0, "exposed_idle_reactB");
    var_0.allowdeath = 1;
    wait 1.5;
  }

  if(isalive(var_0)) {
    var_0.attackeraccuracy = 100;
    level.squad["ALLY_CHARLIE"].favoriteenemy = var_0;
  }
}

rooftop_enemy_breach_kill(var_0, var_1) {
  var_2 = maps\_utility::spawn_targetname(var_0);
  var_2.animname = "enemy";
  var_2 endon("damage");
  level waittill("rooftop_door_kicked");
  wait 0.25;

  if(isalive(var_2)) {
    var_2 maps\_anim::anim_single_solo(var_2, var_1);
    var_2 maps\_vignette_util::vignette_actor_kill();
  }
}

rooftop_dialog() {
  thread rooftop_enemy_dialog();
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_okayweremovingon");
  level waittill("door_breach_dialog");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_onetwothree");
  wait 2;

  if(!common_scripts\utility::flag("spotlight_off"))
    level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_stayoutofthe");

  common_scripts\utility::flag_wait("factory_rooftop_wind_gust_moment");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_moveandshootdo");
  level waittill("rooftop_enemies_cleared");
  wait 1;
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_rgs_parkinglot");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_ourrv");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_whereareyou");
  maps\_utility::smart_radio_dialogue("factory_diz_oneminute");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_donthaveaminute");
  var_0 = ["factory_bkr_cmoncmon", "factory_bkr_comeon"];
  level.squad["ALLY_ALPHA"] thread maps\factory_util::nag_line_generator(undefined, "player_off_roof", undefined, 4);
}

rooftop_enemy_dialog() {
  var_0 = maps\_utility::get_living_ai_array("rooftop_enemy", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2.animname = "enemy";

  var_2 = common_scripts\utility::random(var_0);
  var_2 maps\_utility::smart_dialogue("factory_gs1_beenspotted");
  var_2 = common_scripts\utility::random(var_0);
  var_2 maps\_utility::smart_dialogue("factory_gs1_takepositions");
  var_2 = common_scripts\utility::random(var_0);
  var_2 maps\_utility::smart_dialogue("factory_gs1_getacharge");
}

rooftop_win() {
  maps\_utility::trigger_wait_targetname("start_chase_sequence_trigger");
  level notify("rooftop_complete");
}

rooftop_enemy_cleanup() {
  maps\_utility::trigger_wait_targetname("start_chase_sequence_trigger");
  var_0 = maps\_utility::get_living_ai_array("rooftop_enemy", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.magic_bullet_shield))
      var_2 maps\_utility::stop_magic_bullet_shield();

    var_2 delete();
  }
}

rooftop_heli() {
  thread maps\factory_audio::rooftop_heli_distant_idle_sfx();
  common_scripts\utility::flag_wait("spawn_loading_dock_vehicles");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("rooftop_heli");
  var_0 maps\_vehicle::godon();
  var_0 sethoverparams(0, 0, 0);
  var_0 vehicle_turnengineoff();
  var_0 hidepart("door_L", "vehicle_nh90");
  var_0 hidepart("door_R", "vehicle_nh90");
  var_0 hidepart("door_L_handle", "vehicle_nh90");
  var_0 hidepart("door_R_handle", "vehicle_nh90");
  common_scripts\utility::flag_wait("ambush_escape_clear");
  var_0 thread spotlight_hitbox();
  var_0 thread maps\factory_audio::rooftop_heli_engine_sfx();
  wait 2;

  if(maps\_utility::is_gen4())
    var_0 thread maps\factory_util::god_rays_from_moving_source(var_0, "tag_flash", "ambush_escape_clear", "spotlight_off", "factory_rooftop_floodlight", "factory_rooftop");

  var_0 sethoverparams(16, 10, 3);
  var_0 thread maps\factory_fx::fx_roof_heli_spotlight();
  var_0 thread maps\factory_audio::rooftop_heli_speaker_vo_sfx();
  common_scripts\utility::flag_set("music_chase_start");
  var_0 thread spotlight_heli_target_think();
  var_0 thread spotlight_heli_spotlight_off();
  var_0 waittill("rooftop_heli_unload");
  var_1 = getent("heli_spotlight_fastrope_target", "targetname");
  var_0 setturrettargetent(var_1, (0, 0, 0));
  wait 12;
  var_0 thread spotlight_heli_target_think();
  common_scripts\utility::flag_set("rooftop_heli_unloaded");
  common_scripts\utility::flag_wait("rooftop_heli_okay_to_depart");
  common_scripts\utility::flag_set("rooftop_heli_depart");
  common_scripts\utility::flag_set("spotlight_off");
}

spotlight_heli_spotlight_off() {
  self waittill("rooftop_spotlight_off");
  common_scripts\utility::flag_set("spotlight_off");
  stopFXOnTag(level._effect["spotlight_model_factory"], self, "tag_flash");
  stopFXOnTag(level._effect["factory_spotlight_nomodel"], self, "tag_flash");
  wait 1.5;
  common_scripts\utility::flag_set("rooftop_heli_okay_to_depart");
}

spotlight_heli_target_think() {
  self endon("rooftop_spotlight_off");
  self endon("rooftop_heli_unload");
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = 0;
  var_2 = 16;
  var_3 = 0;
  var_4 = 16;
  var_5 = 0;
  var_6 = 16;
  self setturrettargetent(var_0, (0, 0, 0));
  vehicle_scripts\_attack_heli::heli_default_target_setup();

  for(;;) {
    var_7 = randomintrange(var_1, var_2);
    var_8 = randomintrange(var_3, var_4);
    var_9 = randomintrange(var_5, var_6);

    if(common_scripts\utility::cointoss())
      var_8 = var_8 * -1;

    if(common_scripts\utility::cointoss())
      var_9 = var_9 * -1;

    if(common_scripts\utility::cointoss())
      var_7 = var_7 * -1;

    var_10 = spotlight_heli_target_choice();
    var_0.origin = var_10.origin + (var_7, var_8, var_9);
    wait(randomfloatrange(0.01, 0.1));
  }
}

thermal_disables_spotlight(var_0, var_1) {
  var_0 endon("rooftop_spotlight_off");
  level endon("spotlight_off");

  for(;;) {
    if(level.player.thermal == 1) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  for(;;) {
    for(;;) {
      if(level.player.thermal == 1) {
        break;
      }

      common_scripts\utility::waitframe();
    }

    killfxontag(level._effect["spotlight_model_factory"], self, "tag_flash");
    playFXOnTag(level._effect["factory_spotlight_nomodel"], self, "tag_flash");

    for(;;) {
      if(level.player.thermal == 0) {
        break;
      }

      common_scripts\utility::waitframe();
    }

    killfxontag(level._effect["factory_spotlight_nomodel"], self, "tag_flash");
    playFXOnTag(level._effect["spotlight_model_factory"], self, "tag_flash");
  }
}

spotlight_heli_target_choice() {
  var_0 = level.squad;

  if(!common_scripts\utility::flag("rooftop_player_in_room"))
    var_0[var_0.size] = level.player;

  var_1 = common_scripts\utility::getclosest(self.origin, var_0, 50000);
  return var_1;
}

spotlight_hitbox() {
  self endon("rooftop_spotlight_off");
  var_0 = getent("rooftop_spotlight_hitbox", "targetname");
  var_0.origin = self gettagorigin("tag_flash");
  var_0 linkto(self, "tag_flash");
  var_0 setCanDamage(1);
  var_0 hide();
  var_1 = 0;
  var_0.health = 100000;

  for(;;) {
    var_0 waittill("damage", var_2, var_3);

    if(var_3 == level.player) {
      var_1++;

      if(var_1 == 2) {
        break;
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("spotlight_off");
  var_4 = level.squad;
  var_4[var_4.size] = level.player;

  foreach(var_6 in var_4)
  var_6.attackeraccuracy = 0.6;

  thread maps\factory_audio::rooftop_heli_speaker_destroy();
  thread spotlight_destroyed_fx();
  common_scripts\utility::flag_clear("ambush_thermal_flashed");
  wait 0.25;

  if(common_scripts\utility::flag("rooftop_door_open"))
    level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_spotlightsouthitem");

  self notify("rooftop_spotlight_off");
}

spotlight_destroyed_fx() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    playFX(level._effect["welding_sparks_funner"], self gettagorigin("tag_flash"));
    wait 1;
  }
}

kill_backtrackers() {
  level endon("rooftop_complete");
  maps\_utility::trigger_wait_targetname("ambush_backtrack_warning_trigger");
  thread maps\_utility::smart_radio_dialogue("factory_mrk_adamgetbackhere");
  maps\_utility::trigger_wait_targetname("ambush_escape_backtrack_trigger");
  level notify("new_quote_string");
  setdvar("ui_deadquote", & "FACTORY_FAIL_BACKTRACKING");
  playFX(level._effect["101ton_bomb"], level.player.origin);
  level.player kill();
  maps\_utility::missionfailedwrapper();
}