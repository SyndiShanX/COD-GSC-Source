/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_bomber.gsc
**********************************************/

runbomberfirstframesetup() {
  lib_02EF::rvn_audio_include_additional_soundtablefilenames("soundtables/mp_raid_wb_bomber.csv");
  thread maps\mp\mp_raid_wb_bomber_aud::func_F9();
}

precache_anims() {
  precachempanim("mp_usa_bomber_b17_death_forward");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_left");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_right");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_up");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_nose_dive");
  precachempanim("mp_raids_husky_usa_thunderbolt_graveyard_spiral_down");
}

load_vfx() {
  level.var_611["fighter_dmg_low_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_start");
  level.var_611["fighter_dmg_med_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_med_start");
  level.var_611["fighter_dmg_hvy_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_hvy_start");
  level.var_611["fighter_dmg_low_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_whitsmk");
  level.var_611["fighter_dmg_medium_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_smk");
  level.var_611["fighter_dmg_high_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_firesmk");
  level.var_611["fighter_dmg_high_stop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_stop");
  level.var_611["bomber_dmg_low_loop"] = loadfx("vfx/map/mp_raid_bomber/husky_damage_state_1");
  level.var_611["bomber_dmg_medium_loop"] = loadfx("vfx/map/mp_raid_bomber/husky_damage_state_3");
  level.var_611["bomber_dmg_high_loop"] = loadfx("vfx/map/mp_raid_bomber/husky_damage_state_2");
  level.var_611["bomber_dmg_high_stop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_stop");
  level.var_611["flak_gun_explosion"] = loadfx("vfx/scorestreaks/ss_flak_explosion_dlc2");
}

b17_turret_cleanup(param_00) {
  foreach(var_02 in param_00.turretarray) {
    var_02.var_378F delete();
  }
}

cleanup_all_turrets() {
  level.match_ended = 1;
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    if(isDefined(level.b17_array)) {
      foreach(var_01 in level.b17_array) {
        var_01 notify("match_end");
        b17_turret_cleanup(var_01);
      }
    }
  }

  if(isDefined(level.pp_array)) {
    foreach(var_04 in level.pp_array) {
      if(isDefined(var_04)) {
        var_04 notify("match_end");
        var_04 vehicle_scripts\_fighter_mp::destroyturrets();
      }
    }
  }
}

plane_damage_sound_callback(param_00) {}

on_host_migration_end() {
  level waittill("host_migration_end");
  if(isDefined(level.var_744A)) {
    foreach(var_01 in level.var_744A) {
      if(isalive(var_01)) {
        if(1) {
          var_01.occupied_plane spawn_fighter_vfx_states();
        }
      }
    }
  }

  setDvar("fd_pause_update", 0);
}

func_4ACC(param_00) {
  level endon("game_ended");
  level endon("bomberObjectiveComplete");
  for(;;) {
    level waittill("host_migration_begin");
    setDvar("fd_pause_update", 1);
    level thread on_host_migration_end();
    bomber_set_dvars();
    var_01 = isDefined(param_00);
    if(!var_01) {
      param_00 = (0, 0, 0);
    }

    update_map_center(param_00);
    function_0021();
    thread create_bomber_clouds();
    func_89D5();
    if(isDefined(level.var_744A)) {
      foreach(var_03 in level.var_744A) {
        if(isalive(var_03)) {
          var_03 setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");
          var_03 thread watch_boundary(var_03.occupied_plane);
          var_03 thread func_4A35();
          var_03 thread p47_watch_for_player_switch(var_03.occupied_plane);
          var_03.occupied_plane thread watch_fighter_collision();
          if(isbot(var_03) || function_01EF(var_03)) {
            var_03 thread bot_planeflythink(var_03.occupied_plane);
          }

          if(1) {
            if(!isDefined(var_03.onhostmigrationbeginfunc)) {
              var_03.onhostmigrationbeginfunc = ::onhostmigrationbegin;
            }
          }
        }
      }
    }

    var_05 = maps\mp\gametypes\_hostmigration::func_A782();
  }
}

bomber_set_dvars() {
  setdvarifuninitialized("allies_spawn_fighters", 1);
  setDvar("1145", 3);
  setDvar("4350", 1);
  setDvar("bot_FlightDynamicsModeEnabled", 1);
  setDvar("bg_turretIgnoreAttachedEnt", 0);
  setDvar("1979", 0);
  setdvarifuninitialized("p47_maxhealth", 240);
  setdvarifuninitialized("b17_maxhealth", -21536);
  if(getdvarint("fighter_vs_fighter_mode") == 1) {
    setdvarifuninitialized("move_bombers", 0);
  } else {
    setdvarifuninitialized("move_bombers", 1);
  }

  setdvarifuninitialized("fighter_firing_mode", 0);
  if(getdvarint("fighter_firing_mode") == 1) {
    level.vehicleweapon_fire_mode = "SCRIPT";
    return;
  }

  level.vehicleweapon_fire_mode = "CODE";
}

bomber_reset_dvars() {
  setDvar("4350", 0);
  setDvar("bot_FlightDynamicsModeEnabled", 0);
  setDvar("bg_turretIgnoreAttachedEnt", 1);
  setDvar("1979", 1);
}

fighter_set_perks(param_00) {
  param_00 maps\mp\_utility::func_5E4();
}

fighter_clear_perks(param_00) {}

end_bomber_objective() {
  bomber_reset_dvars();
  foreach(var_01 in level.var_744A) {
    var_01.fighterspawningfunc = undefined;
  }

  level.var_297F = level.old_customplaydamagesound;
  level.nobotscorestreaks = 0;
  level.var_5A77 = 5000;
  level.disabledivisionskills = level.prevdisabledivisionskills;
  level.disabledivisionpassives = level.prevdisabledivisionpassives;
  level.var_4C1E = 0;
  level.disableplayerdamageimpactfx = undefined;
}

load_formation_nodes() {
  var_00 = common_scripts\utility::func_46B7("formation_node", "targetname");
  if(var_00.size == 0) {
    return;
  }

  foreach(var_02 in var_00) {
    var_03 = int(var_02.var_8260);
    level.formation_nodes[var_03] = var_02;
  }

  for(var_05 = 0; var_05 < 6; var_05++) {
    if(var_05 == 0) {
      level.defender_formation_reference_org = (25000 + level.var_5FEB[0], level.var_5FEB[1], level.var_5FEB[2]);
      level.attacker_formation_reference_org = (-25000 + level.var_5FEB[0], level.var_5FEB[1], level.var_5FEB[2]);
      level.defender_formation_late_spawn_ref_org = (19500 + level.var_5FEB[0], level.var_5FEB[1], level.var_5FEB[2]);
      level.attacker_formation_late_spawn_ref_org = (-19500 + level.var_5FEB[0], level.var_5FEB[1], level.var_5FEB[2]);
      continue;
    }

    var_06 = level.formation_nodes[var_05].var_116 - level.formation_nodes[0].var_116;
    level.formation_nodes_offset[var_05] = var_06;
  }
}

setup_minimap(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = 0;
    var_03 = 0.5;
    if(1) {
      var_02 = 27000;
    } else {
      var_02 = 32000;
    }

    var_04 = var_02 * var_03;
    var_05 = var_02 + var_04;
    var_06 = getEntArray("minimap_corner", "targetname");
    var_07 = param_00[0] - var_05;
    var_08 = param_00[1] - var_05;
    var_09 = var_05 + param_00[0];
    var_0A = var_05 + param_00[1];
    var_06[0].var_116 = (var_07, var_08, param_00[2]);
    var_06[1].var_116 = (var_09, var_0A, param_00[2]);
    maps\mp\_compass::func_8A2F(param_01);
  }
}

run_bomber_objective(param_00, param_01) {
  var_02 = isDefined(param_00);
  if(!var_02) {
    param_00 = (0, 0, 0);
  }

  level.bomber_start_time = gettime();
  level.prevdisabledivisionskills = level.disabledivisionskills;
  level.disabledivisionskills = 1;
  level.prevdisabledivisionpassives = level.disabledivisionpassives;
  level.disabledivisionpassives = 1;
  level.disableplayerdamageimpactfx = 1;
  level.var_4C1E = 1;
  level.flak_in_progress = 0;
  level.flak_scorestreak_id = 0;
  level.fighters_in_progress = 0;
  level.defender_formation_index = 0;
  level.attacker_formation_index = 0;
  level.defender_spawn_angles = (0, 0, 0);
  level.attacker_spawn_angles = (0, 0, 0);
  level.defender_formation_reference_org = (0, 0, 0);
  level.attacker_formation_reference_org = (0, 0, 0);
  level.defender_formation_late_spawn_ref_org = (0, 0, 0);
  level.attacker_formation_late_spawn_ref_org = (0, 0, 0);
  level.formation_nodes = [];
  level.formation_nodes_offset = [];
  level.numfighterkillsrequired = int(lib_0501::func_4647("deathmatch_scoreLimit"));
  setDvar("fd_pause_update", 0);
  level thread func_4ACC(param_00);
  bomber_set_dvars();
  foreach(var_04 in level.var_744A) {
    var_04.fighterspawningfunc = ::get_random_spawn_origin_angles;
  }

  level.old_customplaydamagesound = level.var_297F;
  level.var_297F = ::plane_damage_sound_callback;
  level.nobotscorestreaks = 1;
  level.var_5A77 = 0;
  level.bot_spawnagents_func = ::bot_spawnagents;
  function_0021();
  thread create_bomber_clouds();
  level.var_6465["velocityscaler"] = 1.5;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0.75;
  if(isDefined(level.var_744A)) {
    foreach(var_04 in level.var_744A) {
      if(isDefined(var_04)) {
        var_04 setscriptmotionblurparams(1.5, 0, 1);
      }
    }
  }

  level.old_mapcenter_bomber = level.var_5FEB;
  setup_minimap(param_00, param_01);
  lib_04F8::func_7CCF();
  lib_04F4::deleteboundarytriggers();
  maps\mp\_special_weapons::remove_all_special_weaps();
  foreach(var_04 in level.var_744A) {
    var_04 method_86CB();
  }

  func_89D5();
  setup_bomber_turrets();
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    thread bot_spawnagents();
  }

  lib_0503::func_5282();
  position_vehicles(param_00);
  update_map_center(param_00);
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    thread update_bomber_average_origin_wrapper();
  }

  thread create_bomber_cluster_origin();
  load_formation_nodes();
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    thread camera_shake_loop();
  }

  func_1E8D();
  level.var_17EF = 0;
  level.pp_array = [];
  if(isDefined(level.var_744A)) {
    foreach(var_04 in level.var_744A) {
      if(isalive(var_04)) {
        player_spawn_helper(var_04, 1);
        continue;
      }

      var_04 setclientomnvar("ui_hide_hud", 0);
      var_04 method_8323();
      var_04 maps\mp\_utility::func_3E8E(0);
      var_04 setclientdvars("ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");
    }
  }

  thread func_6B6C();
  thread watch_for_player_spawn();
  wait 0.05;
  thread watch_for_game_end();
  thread watch_for_level_exit();
  thread func_31BF();
}

func_6B6C() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    create_bomber_clouds_for_player(var_00);
    var_00 setscriptmotionblurparams(1.5, 0, 1);
    var_00.fighterspawningfunc = ::get_random_spawn_origin_angles;
  }
}

watch_for_game_end() {
  level waittill("game_ended");
  foreach(var_01 in level.var_744A) {
    var_01 setclientdvars("ui_raid_hide_fighter", "1", "ui_raid_hide_scorestreaks", "1");
    var_01.firstfighterspawn = undefined;
    var_01 set_in_bounds();
    var_02 = var_01 method_85E2();
    var_01 maps\mp\_utility::func_3E8E(1);
    if(isDefined(var_02)) {
      var_02 setCanDamage(0);
    }
  }
}

watch_for_level_exit() {
  level waittill("exitLevel_called");
  setDvar("1145", 1);
}

position_vehicles(param_00) {
  var_01 = 1;
  var_02 = getEntArray("bomber_combat_box" + var_01, "targetname");
  foreach(var_04 in var_02) {
    var_04.var_116 = param_00;
    var_04 method_8400();
  }

  var_06 = getent("p47_defender_dogfight", "targetname");
  var_07 = getent("p47_attacker_dogfight", "targetname");
  var_06 method_8400();
  var_07 method_8400();
}

camera_shake_loop() {
  level endon("game_ended");
  var_00 = 0.1;
  for(;;) {
    if(isDefined(level.b17_cluster_ent)) {
      var_01 = [];
      var_02 = [];
      foreach(var_04 in level.var_744A) {
        if(isDefined(var_04.b17) && isalive(var_04)) {
          if(var_04 playerads() > 0.5) {
            var_02 = common_scripts\utility::func_F6F(var_02, var_04);
            continue;
          }

          var_01 = common_scripts\utility::func_F6F(var_01, var_04);
        }
      }

      if(var_01.size > 0) {
        earthquake(0.08, var_00, level.b17_cluster_ent.var_116, 20000, var_01);
      }

      if(var_02.size > 0) {
        earthquake(0.06, var_00, level.b17_cluster_ent.var_116, 20000, var_02);
      }
    }

    wait(var_00);
  }
}

create_bomber_clouds() {
  level thread common_scripts\_exploder::func_88E(10);
}

create_bomber_clouds_for_player(param_00) {
  level thread common_scripts\_exploder::func_88E(10, param_00);
}

stop_bomber_clouds() {
  level thread common_scripts\_exploder::func_2A6D(10, undefined, 1);
}

create_bomber_cluster_origin() {
  level endon("game_ended");
  level.b17_cluster_ent = lib_0502::raid_spawn_tag_origin();
  var_00 = gettime();
  if(getdvarint("fighter_vs_fighter_mode") == 1) {
    level.b17_cluster_ent.var_116 = level.var_5FEB;
  } else {
    var_01 = maps\mp\_utility::func_442E(level.b17_array);
    level.b17_cluster_ent.var_116 = var_01;
  }

  if(getdvarint("move_bombers", 1) == 1) {
    foreach(var_03 in level.b17_array) {
      var_04 = var_03.var_116 - level.b17_cluster_ent.var_116;
      var_03.cluster_offset = var_04;
    }

    var_06 = 0;
    var_07 = 0;
    var_08 = -20536;
    var_09 = 1500;
    var_0A = level.bomber_x_offset;
    var_0B = level.bomber_y_offset;
    for(;;) {
      if(level.b17_array.size <= 0) {
        break;
      }

      if(gettime() > var_00) {
        update_map_center((level.b17_cluster_ent.var_116[0], level.b17_cluster_ent.var_116[1], level.b17_cluster_ent.var_116[2]));
        var_00 = gettime() + 5000;
      }

      if(var_06 > 6.28312) {
        var_06 = 0;
      }

      var_07 = var_06;
      var_06 = var_06 + 6.28312 / var_09;
      var_06 = var_06 * 57.29638;
      var_0C = 2 / 3 - cos(2 * var_06);
      var_0D = var_08 * var_0C * cos(var_06);
      var_0E = var_08 * var_0C * sin(2 * var_06) / 2;
      var_0F = level.b17_cluster_ent.var_116;
      var_10 = (var_0D, var_0E, level.b17_cluster_ent.var_116[2]);
      level.b17_cluster_ent moveto(var_10, 0.1);
      var_11 = vectornormalize(var_10 - var_0F);
      var_12 = vectortoangles(var_11);
      level.b17_cluster_ent rotateto(var_12, 0.1);
      var_06 = var_06 * 0.01745311;
      wait(0.1);
    }

    return;
  }

  foreach(var_03 in level.b17_array) {
    var_04 = var_03.var_116 - level.b17_cluster_ent.var_116;
    var_03.cluster_offset = var_04;
  }

  for(;;) {
    level.b17_array = common_scripts\utility::func_FA0(level.b17_array);
    if(level.b17_array.size <= 0) {
      break;
    }

    wait(0.1);
  }
}

update_bomber_average_origin() {
  level endon("game_ended");
  for(;;) {
    level.b17_array = common_scripts\utility::func_FA0(level.b17_array);
    if(level.b17_array.size <= 0) {
      break;
    }

    var_00 = maps\mp\_utility::func_442E(level.b17_array);
    level.b17_avg_target_ui.var_116 = var_00;
    wait 0.05;
  }
}

update_bomber_average_origin_wrapper() {
  level.b17_avg_target_ui = common_scripts\utility::func_8FFC();
  level.b17_avg_target_ui method_805B();
  update_bomber_average_origin();
  level.b17_avg_target_ui delete();
}

func_7F89() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_04F4::func_863D("allies_C", "active", 5);
  level waittill("intelComplete");
  lib_04F4::func_863D("allies_C", "inactive");
}

func_1E8D() {
  level.var_28D8 = "original";
  level.var_1E8C = [];
  level.var_1E8C["original"] = spawnStruct();
  level.var_1E8C["original"].var_9164 = 65;
  level.var_1E8C["original"].var_A10 = 45;
}

add_target_icon(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isPlayer(param_00)) {
    return;
  }

  var_06 = self;
  var_07 = param_00.alignx;
  if(common_scripts\utility::func_562E(param_00.firstfighterspawn)) {
    maps\mp\gametypes\_hostmigration::func_A6F5(3);
  }

  if(isDefined(param_05)) {
    if(common_scripts\utility::func_562E(param_00.firstfighterspawn)) {
      param_05 = param_05 - 3;
    }

    if(param_05 > 0) {
      maps\mp\gametypes\_hostmigration::func_A6F5(param_05);
    }
  }

  if(!isDefined(self) || !isalive(param_00) || var_06 != self || var_07 != param_00.alignx || lib_0502::func_5845(self) && !fighter_is_alive()) {
    return;
  }

  var_08 = "dogfight_target_diamond";
  var_09 = "tag_origin";
  var_0A = 12500;
  var_0B = 15900;
  param_00 luinotifyeventextraplayer(&"target_add_icon", 8, self, 1, var_09, var_08, var_0A, var_0B, 0, 0.8);
  param_00 luinotifyeventextraplayer(&"target_set_alpha_fade_when_close", 3, self, 1, 1);
  if(common_scripts\utility::func_562E(param_03)) {
    param_00 luinotifyeventextraplayer(&"target_set_swatch", 4, self, 1, "HUD", "friendlyTeam");
  } else {
    param_00 luinotifyeventextraplayer(&"target_set_swatch", 4, self, 1, "HUD", "enemyTeam");
  }

  if(common_scripts\utility::func_562E(param_02)) {
    param_00 luinotifyeventextraplayer(&"target_set_world_offset", 5, self, 1, 0, 0, 300);
  }

  if(common_scripts\utility::func_562E(param_01)) {
    param_00 luinotifyeventextraplayer(&"target_set_scale", 3, self, 1, 2);
  } else {
    param_00 luinotifyeventextraplayer(&"target_set_scale", 3, self, 1, 1.5);
  }

  param_00 luinotifyeventextraplayer(&"target_set_alignment", 4, self, 1, "center", "middle");
  if(common_scripts\utility::func_562E(param_04)) {
    param_00 luinotifyeventextraplayer(&"target_set_clamp", 3, self, 1, 1);
  }

  self notify("dogfight_target_added");
}

remove_target_on_death(param_00) {
  if(isDefined(param_00) && isPlayer(param_00)) {
    param_00 luinotifyeventextraplayer(&"target_remove_all", 1, self);
  }

  if(isDefined(self) && !function_0279(self)) {}
}

spawn_player_p47(param_00) {
  if(!isDefined(level.defender_pp_spawner)) {
    level.defender_pp_spawner = getent("p47_defender_dogfight", "targetname");
  }

  if(!isDefined(level.attacker_pp_spawner)) {
    level.attacker_pp_spawner = getent("p47_attacker_dogfight", "targetname");
  }

  var_01 = undefined;
  if(param_00.var_1A7 == game["defenders"]) {
    var_01 = level.defender_pp_spawner;
  } else {
    var_01 = level.attacker_pp_spawner;
  }

  var_02 = lib_0503::func_2838(var_01, param_00.var_1A7, 1, 0, 0, param_00);
  var_02.var_1A7 = param_00.var_1A7;
  var_03 = undefined;
  if(var_02.var_1A7 == "allies") {
    var_03 = "group_allies";
  } else {
    var_03 = "group_axis";
  }

  var_02 makeentitysentient(var_02.var_1A7);
  var_02 setthreatbiasgroup(var_03);
  param_00 setthreatbiasgroup(var_03);
  level.pp_array = common_scripts\utility::func_F6F(level.pp_array, var_02);
  return var_02;
}

func_31BF() {
  thread func_4A1D();
  thread func_99BF();
}

spawn_fighter_vfx_states() {
  var_00 = self;
  var_01 = "TAG_ORIGIN";
  var_02 = spawnStruct();
  var_02.health_threshold_frac = 0.75;
  var_02.vfx_tag = var_01;
  var_02.vfx_in = common_scripts\utility::func_44F5("fighter_dmg_low_start");
  var_02.vfx_in_length = 0.5;
  var_02.vfx_loop = common_scripts\utility::func_44F5("fighter_dmg_low_loop");
  var_02.vfx_out = common_scripts\utility::func_44F5("fighter_dmg_high_stop");
  var_03 = spawnStruct();
  var_03.health_threshold_frac = 0.4;
  var_03.vfx_tag = var_01;
  var_03.vfx_in = common_scripts\utility::func_44F5("fighter_dmg_med_start");
  var_03.vfx_in_length = 0.5;
  var_03.vfx_loop = common_scripts\utility::func_44F5("fighter_dmg_medium_loop");
  var_03.vfx_out = common_scripts\utility::func_44F5("fighter_dmg_high_stop");
  var_04 = spawnStruct();
  var_04.health_threshold_frac = 0.15;
  var_04.vfx_tag = var_01;
  var_04.vfx_in = common_scripts\utility::func_44F5("fighter_dmg_hvy_start");
  var_04.vfx_in_length = 0.5;
  var_04.vfx_loop = common_scripts\utility::func_44F5("fighter_dmg_high_loop");
  var_04.vfx_out = common_scripts\utility::func_44F5("fighter_dmg_high_stop");
  var_05 = [var_02, var_03, var_04];
  var_00 thread common_damage_state_fx_watcher(var_05, 1);
}

onhostmigrationbegin() {
  if(!isDefined(self) || !isDefined(self.occupied_plane)) {
    return;
  }

  if(isDefined(self.occupied_plane.vfx_obj_list)) {
    foreach(var_01 in self.occupied_plane.vfx_obj_list) {
      if(!function_0279(var_01)) {
        var_01 delete();
      }
    }

    self.occupied_plane.vfx_obj_list = [];
  }

  if(isDefined(self.onhostmigrationbegin)) {
    self.onhostmigrationbegin = undefined;
  }
}

spawn_bomber_vfx_states() {
  var_00 = self;
  var_01 = ["Tag_fx_l_01", "Tag_fx_r_01"];
  if(randomint(100) < 50) {
    var_01 = ["Tag_fx_l_02", "Tag_fx_r_02"];
  }

  var_02 = spawnStruct();
  var_02.health_threshold_frac = 0.75;
  var_02.vfx_tag = var_01;
  var_02.vfx_in = undefined;
  var_02.vfx_in_length = undefined;
  var_02.vfx_loop = common_scripts\utility::func_44F5("bomber_dmg_low_loop");
  var_02.vfx_out = common_scripts\utility::func_44F5("bomber_dmg_high_stop");
  var_03 = spawnStruct();
  var_03.health_threshold_frac = 0.5;
  var_03.vfx_tag = var_01;
  var_03.vfx_in = undefined;
  var_03.vfx_in_length = undefined;
  var_03.vfx_loop = common_scripts\utility::func_44F5("bomber_dmg_medium_loop");
  var_03.vfx_out = common_scripts\utility::func_44F5("bomber_dmg_high_stop");
  var_04 = spawnStruct();
  var_04.health_threshold_frac = 0.25;
  var_04.vfx_tag = var_01;
  var_04.vfx_in = undefined;
  var_04.vfx_in_length = undefined;
  var_04.vfx_loop = common_scripts\utility::func_44F5("bomber_dmg_high_loop");
  var_04.vfx_out = common_scripts\utility::func_44F5("bomber_dmg_high_stop");
  var_05 = [var_02, var_03, var_04];
  var_00 thread common_damage_state_fx_watcher(var_05, 1);
}

random_point_on_sphere(param_00, param_01) {
  var_02 = 6.28312 * randomfloat(1);
  var_03 = randomfloatrange(1.099546, 2.042014);
  var_04 = param_01;
  var_02 = var_02 * 57.29638;
  var_03 = var_03 * 57.29638;
  var_05 = var_04 * sin(var_03) * cos(var_02);
  var_06 = var_04 * sin(var_03) * sin(var_02);
  var_07 = var_04 * cos(var_03);
  return param_00 + (var_05, var_06, var_07);
}

random_point_on_cylinder(param_00, param_01) {
  var_02 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  var_03 = param_00 + param_01 * var_02;
  var_03 = var_03 + (0, 0, randomfloatrange(-7000, 7000));
  return var_03;
}

is_spawn_targeted(param_00) {
  foreach(var_02 in level.var_744A) {
    if(!isDefined(var_02) || !maps\mp\_utility::func_57A0(var_02)) {
      continue;
    }

    if(var_02 == self || level.var_984D && var_02.var_1A7 == self.var_1A7) {
      continue;
    }

    if(distancesquared(param_00, var_02.var_116) < 20250000) {
      return 1;
    }

    var_03 = param_00 - var_02.var_116;
    var_04 = anglesToForward(var_02.occupied_plane.var_1D);
    var_05 = vectordot(var_03, var_04);
    if(var_05 <= 0) {
      continue;
    }

    var_03 = vectornormalize(var_03);
    var_04 = vectornormalize(var_04);
    var_05 = vectordot(var_03, var_04);
    if(var_05 < 0.9961947) {
      continue;
    }

    var_06 = var_02.var_116;
    var_07 = param_00;
    if(bullettracepassed(param_00, var_02.var_116, 0, self)) {
      return 1;
    }
  }

  return 0;
}

is_spawn_valid(param_00, param_01) {
  return !is_spawn_targeted(param_00);
}

get_random_spawn_origin_angles() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = 0;
  if(gettime() - level.bomber_start_time < 8000) {
    var_03 = 1;
  }

  if(var_03 && level.formation_nodes_offset.size > 0) {
    if(self.var_1A7 == game["defenders"]) {
      if(level.defender_formation_index == 0) {
        var_01 = level.defender_formation_late_spawn_ref_org;
        var_02 = vectortoangles(level.var_5FEB - var_01);
        level.defender_spawn_angles = var_02;
      } else {
        var_04 = level.formation_nodes_offset[level.defender_formation_index];
        var_01 = level.defender_formation_late_spawn_ref_org + var_04;
        var_02 = level.defender_spawn_angles;
      }

      level.defender_formation_index++;
      if(level.defender_formation_index >= 6) {
        level.defender_formation_index = 0;
      }
    } else {
      if(level.attacker_formation_index == 0) {
        var_01 = level.attacker_formation_late_spawn_ref_org;
        var_02 = vectortoangles(level.var_5FEB - var_01);
        level.attacker_spawn_angles = var_02;
      } else {
        var_04 = level.formation_nodes_offset[level.attacker_formation_index];
        var_01 = level.attacker_formation_late_spawn_ref_org + (-1 * var_04[0], var_04[1], var_04[2]);
        var_02 = level.attacker_spawn_angles;
      }

      level.attacker_formation_index++;
      if(level.attacker_formation_index >= 6) {
        level.attacker_formation_index = 0;
      }
    }
  } else {
    var_05 = 0;
    var_01 = undefined;
    var_02 = undefined;
    for(var_06 = 0; var_06 < 5; var_06++) {
      if(0) {
        var_00 = randomfloatrange(25000, 29000);
        var_01 = random_point_on_sphere(level.var_5FEB, var_00);
      } else {
        var_00 = randomfloatrange(20500, 21000);
        var_01 = random_point_on_cylinder(level.var_5FEB, var_00);
      }

      var_07 = level.var_5FEB - var_01;
      var_02 = vectortoangles(var_07);
      var_02 = (0, var_02[1], 0);
      var_05 = is_spawn_valid(var_01, var_02);
      if(var_05) {
        break;
      }
    }
  }

  if(var_02[1] == 180) {
    var_02 = (var_02[0], var_02[1] + 0.1, var_02[2]);
  }

  var_02 = (angleclamp180(var_02[0]), angleclamp180(var_02[1]), angleclamp180(var_02[2]));
  return [var_01, var_02];
}

spawn_fighter(param_00, param_01) {
  var_02 = undefined;
  if(param_01) {
    param_00 setclientdvar("vehCam_chaseFD_camStartMode", 1);
    var_02 = 5000;
  } else {
    param_00 setclientdvar("vehCam_chaseFD_camStartMode", 0);
    var_02 = 750;
  }

  param_00 setclientdvar("vehCam_chaseFD_camStartLerpDuration", var_02);
  param_00 fighter_ui_hide();
  if(param_01 && isbot(param_00)) {
    param_00 maps\mp\_utility::func_3E8E(0);
  }

  var_03 = spawn_player_p47(param_00);
  var_03.var_FB = getdvarint("p47_maxhealth");
  var_03.var_BC = var_03.var_FB;
  var_03 setCanDamage(1);
  var_03.var_29B5 = ::fighter_damage_callback;
  var_03 method_8511();
  if(!level.flak_in_progress || !isDefined(param_00.flak_scorestreak_id) || param_00.flak_scorestreak_id != level.flak_scorestreak_id) {
    param_00.hasdiedtoflak = undefined;
  }

  param_00.var_28D8 = "original";
  if(!isDefined(param_00.firstfighterspawn)) {
    param_00.firstfighterspawn = 1;
  } else {
    param_00.firstfighterspawn = 0;
  }

  var_03.occupied_player = param_00;
  param_00.occupied_plane = var_03;
  var_04 = undefined;
  if(function_01EF(param_00)) {
    param_00.var_CE = 1;
    var_03.var_CE = 1;
  }

  var_05 = undefined;
  if(param_01) {
    if(var_02 == 5000) {
      var_05 = var_02 + 500 / 1000;
    }

    var_06 = (0, 0, 0);
    if(1) {
      var_06 = (0, 0, randomfloatrange(-50, 50));
    }

    if(param_00.var_1A7 == game["defenders"]) {
      if(level.defender_formation_index == 0) {
        var_04 = level.defender_formation_reference_org + var_06;
        var_07 = vectortoangles(level.var_5FEB - var_04);
        level.defender_spawn_angles = var_07;
      } else {
        var_08 = level.formation_nodes_offset[level.defender_formation_index];
        var_04 = level.defender_formation_reference_org + var_08 + var_06;
        var_07 = level.defender_spawn_angles;
      }

      level.defender_formation_index++;
      if(level.defender_formation_index >= 6) {
        level.defender_formation_index = 0;
      }
    } else {
      if(level.attacker_formation_index == 0) {
        var_04 = level.attacker_formation_reference_org + var_06;
        var_07 = vectortoangles(level.var_5FEB - var_04);
        level.attacker_spawn_angles = var_07;
      } else {
        var_08 = level.formation_nodes_offset[level.attacker_formation_index];
        var_04 = level.attacker_formation_reference_org + (-1 * var_08[0], var_08[1], var_08[2]) + var_06;
        var_07 = level.attacker_spawn_angles;
      }

      level.attacker_formation_index++;
      if(level.attacker_formation_index >= 6) {
        level.attacker_formation_index = 0;
      }
    }
  } else if(isDefined(param_01.fighterspawnorigin) && isDefined(param_01.fighterspawnangles)) {
    var_05 = param_01.fighterspawnorigin;
    var_07 = param_01.fighterspawnangles;
  } else {
    var_09 = param_01 get_random_spawn_origin_angles();
    var_04 = var_09[0];
    var_07 = var_09[1];
  }

  if(var_07[1] == 180) {
    var_07 = (var_07[0], var_07[1] + 0.1, var_07[2]);
  }

  var_07 = (angleclamp180(var_07[0]), angleclamp180(var_07[1]), angleclamp180(var_07[2]));
  param_00 setangles(var_07);
  var_03 method_8279(var_04, var_07);
  if(function_01EF(param_00)) {
    param_00.var_9 = &"RAIDS_DOGFIGHT_AGENTNAME";
    if(param_00.var_A == game["attackers"]) {
      foreach(var_0B in level.var_744A) {
        if(var_0B.var_1A7 == game["defenders"]) {
          var_03 thread add_target_icon(var_0B, 0, 1, 0, undefined, var_05);
        }
      }
    }
  }

  var_03 setclientowner(param_00);
  param_00 mountvehiclesafe(var_03);
  param_00 disableusability();
  var_0D = "turretweapon_usa_fighter_thunderbolt_player_mp";
  if(param_00.var_1A7 == game["defenders"]) {
    var_0D = "turretweapon_ger_fighter_bf109_player_mp";
  }

  var_03 vehicle_scripts\_fighter_mp::func_51FB(var_0D);
  var_03 thread func_4A31(1, param_00);
  var_03 lib_0378::func_8D74("aud_figher_spawn");
  param_00 thread func_4A35();
  param_00 thread watch_boundary(var_03);
  if(isbot(param_00) || function_01EF(param_00)) {
    if(param_01) {
      param_00.informationtransition = 1;
    }

    param_00 thread bot_planeflythink(var_03);
  }

  param_00 thread p47_watch_for_player_switch(var_03);
  var_03 thread watch_fighter_collision();
  if(1) {
    var_03 spawn_fighter_vfx_states();
    if(!isDefined(param_00.onhostmigrationbeginfunc)) {
      param_00.onhostmigrationbeginfunc = ::onhostmigrationbegin;
    }
  }

  param_00 thread spawn_client_fighter_fx(var_03);
  if(param_00.var_1A7 == game["defenders"]) {
    if(isDefined(param_00.b17)) {
      param_00.b17.var_744A[param_00 getentitynumber()] = undefined;
      param_00.b17.var_744A = common_scripts\utility::func_FA0(param_00.b17.var_744A);
      param_00.b17 = undefined;
    }

    foreach(var_0B in level.var_744A) {
      var_0F = var_0B method_85E2();
      if(var_0B.var_1A7 == game["attackers"] && isDefined(var_0F) && var_0F fighter_is_alive()) {
        var_0F thread add_target_icon(param_00, 0, 1, 0, undefined, var_05);
      }

      if(var_0B.var_1A7 == game["attackers"]) {
        var_03 thread add_target_icon(var_0B, 0, 1, 0, undefined, var_05);
      }
    }

    if(isDefined(level.var_A4E)) {
      foreach(var_12 in level.var_A4E) {
        var_0F = var_12 method_85E2();
        if(isDefined(var_0F) && var_12.var_A == game["attackers"]) {
          var_0F thread add_target_icon(param_00, 0, 1, 0, undefined, var_05);
        }
      }
    }
  } else if(isPlayer(param_00)) {
    foreach(var_0B in level.var_744A) {
      var_0F = var_0B method_85E2();
      if(var_0B.var_1A7 == game["defenders"] && isDefined(var_0F) && var_0F fighter_is_alive()) {
        var_0F thread add_target_icon(param_00, 0, 1, 0, undefined, var_05);
      }

      if(var_0B.var_1A7 == game["defenders"]) {
        var_03 thread add_target_icon(var_0B, 0, 1, 0, undefined, var_05);
      }
    }
  }

  if(isDefined(level.b17_avg_target_ui)) {
    level.b17_avg_target_ui thread add_target_icon(param_00, 1, 0, 1, 1, var_05);
  }

  var_03 thread show_plane();
  param_00 thread allow_controls_after_trans(var_03, var_02, param_01);
}

fighter_ui_hide() {
  self method_8322();
  if(!function_01EF(self)) {
    maps\mp\_utility::func_3E8E(1);
    self setclientdvars("ui_raid_hide_fighter", "1", "ui_force_dont_draw_fighter_names", "1", "cg_drawVehicleCrosshair", "0");
  }

  self.ignoreboundary = 1;
}

fighter_ui_fade_up() {
  self method_8323();
  if(!function_01EF(self)) {
    self setclientomnvar("ui_hide_hud", 0);
    maps\mp\_utility::func_3E8E(0);
    self setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");
  }

  self.ignoreboundary = 0;
}

allow_controls_after_trans(param_00, param_01, param_02) {
  self endon("disconnect");
  if(param_01 == 5000) {
    param_01 = param_01 + 500;
  }

  common_scripts\utility::func_A70D(param_01 / 1000, self, "death", param_00, "death");
  if(param_02) {
    self.informationtransition = 0;
  }

  fighter_ui_fade_up();
}

show_plane() {
  self endon("death");
  self endon("disconnect");
  wait(0.1);
  self method_805B();
}

mountvehiclesafe(param_00) {
  if(isDefined(self.var_117)) {
    self setentityowner(undefined);
  }

  self method_80F3(param_00);
}

spawn_client_fighter_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    if(getdvarint("fighter_vs_fighter_mode") != 1) {
      if(var_01.var_1A7 == game["defenders"]) {
        playfxontagforclients(level.var_611["mp_raid_bomber_spawn_cloud"], param_00, "TAG_BODY", var_01);
      }

      wait 0.05;
    }

    playfxontagforclients(level.var_611["mp_raid_bomber_throttle_fighter"], param_00, "TAG_BODY", var_01);
  }
}

remove_client_fighter_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    if(getdvarint("fighter_vs_fighter_mode") != 1) {
      if(var_01.var_1A7 == game["defenders"]) {
        function_0294(level.var_611["mp_raid_bomber_spawn_cloud"], param_00, "TAG_BODY", var_01);
      }

      wait 0.05;
    }

    function_0294(level.var_611["mp_raid_bomber_throttle_fighter"], param_00, "TAG_BODY", var_01);
  }
}

spawn_client_bomber_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    playfxontagforclients(level.var_611["mp_raid_bomber_b17_throttle_flying"], param_00, "tag_origin", var_01);
  }
}

remove_client_bomber_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    function_0294(level.var_611["mp_raid_bomber_b17_throttle_flying"], param_00, "tag_origin", var_01);
  }
}

spawn_attacker(param_00) {
  param_00 notify("disable_spawn_protection");
  param_00.var_4B97 = undefined;
  param_00 b17playermountunoccupiedturret();
  param_00 thread spawn_client_bomber_fx(param_00.b17);
  foreach(var_02 in level.var_744A) {
    var_03 = var_02 method_85E2();
    if(var_02.var_1A7 == game["defenders"] && isDefined(var_03) && var_03 fighter_is_alive()) {
      var_03 thread add_target_icon(param_00, 0, 1, 0);
    }
  }

  param_00 thread bomber_watch_for_player_switch();
  param_00 setclientdvars("ui_raid_hide_fighter", "1");
}

watch_for_player_spawn() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    thread player_spawn_helper(var_00);
  }
}

should_attacker_spawn_in_fighter(param_00) {
  if(getdvarint("fighter_vs_fighter_mode") == 1) {
    return 1;
  }

  if(function_01EF(param_00)) {
    return 1;
  }

  if(getdvarint("allies_spawn_fighters") == 1 && common_scripts\utility::func_562E(param_00.didspawninb17) || level.b17_array.size < 6) {
    return 1;
  }

  return 0;
}

player_spawn_helper(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = 1;
  param_00 setdemigod(1);
  param_00 method_805C();
  if(1) {
    param_00 setclientdvar("cg_altimeterRange", 28000);
  } else {
    param_00 setclientdvar("cg_altimeterRange", -25536);
  }

  param_00 setclientdvar("cg_altimeterCenter", level.var_5FEB[2]);
  param_00.var_4D13 = 1;
  param_00.hideshieldmodels = 1;
  if(isbot(param_00) || function_01EF(param_00)) {
    param_00.var_100 = 576000000;
  }

  if(param_00.var_1A7 == game["defenders"]) {
    thread spawn_fighter(param_00, param_01);
    if(isPlayer(param_00) && !isbot(param_00)) {
      param_00 maps\mp\gametypes\_class::func_4773(param_00.var_1A7, param_00.var_2319);
      fighter_set_perks(param_00);
      param_00 maps\mp\killstreaks\_killstreaks::func_A16E();
      param_00 setclientdvar("ui_raid_hide_scorestreaks", 0);
      thread maps\mp\gametypes\_raid_bomber_scorestreaks::fighter_scorestreak_watcher(param_00);
    }
  } else if(should_attacker_spawn_in_fighter(param_00)) {
    thread spawn_fighter(param_00, param_01);
    if(isPlayer(param_00) && !isbot(param_00)) {
      param_00 maps\mp\gametypes\_class::func_4773(param_00.var_1A7, param_00.var_2319);
      fighter_set_perks(param_00);
      param_00 maps\mp\killstreaks\_killstreaks::func_A16E();
      param_00 setclientdvar("ui_raid_hide_scorestreaks", 0);
      thread maps\mp\gametypes\_raid_bomber_scorestreaks::fighter_scorestreak_watcher(param_00);
    }
  } else {
    thread spawn_attacker(param_00);
    var_02 = param_00.b17.var_BC / param_00.b17.var_FB;
  }

  param_00 setclientomnvar("ui_raid_vehicle_health_percent", var_02);
}

watch_for_boundary_death() {
  self notify("watch_boundary_death");
  self endon("disconnect");
  self endon("watch_boundary_death");
  self waittill("death");
  lib_04F4::func_7480(0);
  self setclientomnvar("ui_raid_boundary_timer", 0);
  self setclientomnvar("ui_raid_boundary_type", -1);
}

update_map_center(param_00) {
  level.var_5FEB = param_00;
  if(isDefined(level.var_50A7)) {
    foreach(var_02 in level.var_50A7) {
      var_02.var_116 = level.var_5FEB;
    }
  }

  lib_02F0::rv_audio_update_entnotify_origin(level.var_5FEB);
  maps\mp\gametypes\_music_and_dialog::end_game_music_ent_origin_update(level.var_5FEB);
  setmapcenter(level.var_5FEB);
}

is_plane_outside_boundary() {
  var_00 = distancesquared(self.var_116, level.var_5FEB);
  var_01 = distance2dsquared(self.var_116, level.var_5FEB);
  if(0) {
    if(var_00 >= 2025000000) {
      return 1;
    }

    if(0) {
      if(var_00 > 1024000000 && var_00 <= 2025000000 && !common_scripts\utility::func_AA4A(self.var_116, self.var_1D, level.var_5FEB, cos(32.5))) {
        return 1;
      }
    } else if(var_00 > 1024000000 && var_00 <= 2025000000) {
      return 1;
    }

    if(abs(self.var_116[2] - level.var_5FEB[2]) > 20000) {
      return 1;
    }

    return 0;
  }

  var_02 = abs(self.var_116[2] - level.var_5FEB[2]);
  if(var_01 >= 729000000) {
    return 1;
  }

  if(var_02 >= 14000) {
    return 1;
  }

  if(0) {
    if(((var_02 > 10000 && var_02 < 14000) || var_01 > 484000000 && var_01 < 729000000) && !common_scripts\utility::func_AA4A(self.var_116, self.var_1D, level.var_5FEB, cos(32.5))) {
      return 1;
    }
  } else if((var_02 > 10000 && var_02 < 14000) || var_01 > 484000000 && var_01 < 729000000) {
    return 1;
  }

  return 0;
}

is_plane_outside_hard_boundary() {
  var_00 = distance2dsquared(self.var_116, level.var_5FEB);
  var_01 = abs(self.var_116[2] - level.var_5FEB[2]);
  if(var_00 >= 729000000) {
    return 1;
  }

  if(var_01 >= 14000) {
    return 1;
  }

  return 0;
}

set_out_of_bounds(param_00) {
  lib_04F4::func_7480(1);
  if(1) {
    self setclientomnvar("ui_raid_boundary_timer", param_00);
    self setclientomnvar("ui_raid_boundary_type", 0);
    return;
  }

  self setclientomnvar("ui_raid_boundary_timer", 0);
  self setclientomnvar("ui_raid_boundary_type", 3);
}

set_in_bounds() {
  lib_04F4::func_7480(0);
  self setclientomnvar("ui_raid_boundary_timer", 0);
  self setclientomnvar("ui_raid_boundary_type", -1);
}

get_flak_fx_for_direction(param_00) {
  if(param_00 == "forward") {
    return level.var_611["mp_raid_bomber_flak_rnr"];
  } else if(param_00 == "right") {
    return level.var_611["mp_raid_bomber_flak_right_rnr"];
  } else if(param_00 == "left") {
    return level.var_611["mp_raid_bomber_flak_left_rnr"];
  } else if(param_00 == "back") {
    return level.var_611["mp_raid_bomber_flak_return_rnr"];
  }
}

watch_boundary(param_00) {
  self notify("boundaryWatch");
  self endon("deathSentence");
  self endon("death");
  self endon("disconnect");
  self endon("boundaryWatch");
  level endon("game_ended");
  if(function_01EF(self)) {
    return;
  }

  thread watch_for_boundary_death();
  var_01 = gettime();
  var_02 = undefined;
  self.var_8D0 = 7000;
  var_03 = gettime();
  var_04 = undefined;
  if(param_00 is_plane_outside_hard_boundary() && !isDefined(level.var_4E09)) {}

  if(!common_scripts\utility::func_AA4A(param_00.var_116, param_00.var_1D, level.var_5FEB, cos(30)) && !isDefined(level.var_4E09)) {}

  for(;;) {
    if(common_scripts\utility::func_562E(self.ignoreboundary) || isDefined(level.var_4E09)) {
      wait 0.05;
      continue;
    }

    if(param_00 is_plane_outside_boundary()) {
      var_05 = 0;
      if(1) {
        var_05 = param_00 is_plane_outside_hard_boundary();
      }

      if(!common_scripts\utility::func_562E(var_02)) {
        var_02 = 1;
        set_out_of_bounds(var_01 + 7000);
        var_03 = gettime();
      }

      if(var_03 <= gettime()) {
        var_06 = vectornormalize(param_00.var_116 - level.var_5FEB);
        var_07 = vectornormalize(param_00.var_1D);
        var_08 = vectornormalize(rotatevectorinverted(var_06, param_00.var_1D));
        var_09 = function_01E3(var_08[1], var_08[0]);
        var_06 = undefined;
        if(var_09 < -45 && var_09 > -135) {
          var_06 = "right";
        } else if(var_09 > 45 && var_09 < 135) {
          var_06 = "left";
        } else if(var_09 >= -45 && var_09 <= 45) {
          var_06 = "forward";
        } else {
          var_06 = "back";
        }

        if(isDefined(var_04)) {
          stopFXOnTag(get_flak_fx_for_direction(var_04), param_00, "tag_origin");
        }

        playFXOnTag(get_flak_fx_for_direction(var_06), param_00, "tag_origin");
        var_04 = var_06;
        var_03 = gettime() + randomintrange(600, 800);
      }

      var_0A = 0;
      if(1) {
        var_0A = gettime() - var_01 > 7000;
      }

      if(var_0A || var_05) {
        if(common_scripts\utility::func_562E(var_02)) {
          set_in_bounds();
        }

        plane_boundary_blowup(param_00);
        return;
      }
    } else {
      if(common_scripts\utility::func_562E(var_02)) {
        var_02 = 0;
        set_in_bounds();
        if(isDefined(var_04)) {
          stopFXOnTag(get_flak_fx_for_direction(var_04), param_00, "tag_origin");
        }
      }

      var_01 = gettime();
    }

    wait 0.05;
  }
}

plane_boundary_blowup(param_00) {
  var_01 = self;
  var_01.var_2AB1 = 1;
  var_01 lib_04F4::func_747F();
  param_00 dodamage(param_00.var_FB * 10, param_00.var_116, undefined, undefined, "MOD_EXPLOSIVE");
}

get_vehicleweapon_fire_mode() {
  return level.vehicleweapon_fire_mode;
}

func_4A31(param_00, param_01) {
  self notify("handle_p47_50cals");
  self endon("handle_p47_50cals");
  self endon("death");
  param_01 endon("death");
  if(common_scripts\utility::func_562E(param_00)) {
    while(!isDefined(level.var_D10)) {
      wait 0.05;
    }
  }

  lib_0378::func_8D74("p47_turret_plr");
  var_02 = 0;
  var_03 = randomintrange(20, 40);
  var_04 = var_03 + randomintrange(10, 20);
  var_05 = [];
  if(get_vehicleweapon_fire_mode() == "SCRIPT") {
    param_01 method_8322();
    var_05[0] = common_scripts\utility::func_44F5("p47_muzzle01");
    var_05[1] = common_scripts\utility::func_44F5("p47_muzzle02");
    if(isDefined(param_00) && param_00) {
      var_05[0] = common_scripts\utility::func_44F5("p47_muzzle01_ext_vel");
      var_05[1] = common_scripts\utility::func_44F5("p47_muzzle02_ext_vel");
    }
  }

  var_06 = 0;
  var_07 = 8;
  var_08 = 3;
  var_09 = 2;
  var_0A = 0;
  self.var_2651 = 0;
  var_0B = 15;
  var_0C = 0.1;
  var_0D = 2;
  var_0E = 0;
  var_0F = undefined;
  var_10 = 0;
  var_11 = getdvarfloat("cg_fov");
  var_12 = 0.1;
  while(isDefined(self)) {
    var_13 = 0;
    var_13 = isDefined(self.var_830A) && self.var_830A;
    if(!var_13 && isDefined(param_00) && param_00) {
      var_13 = param_01 attackButtonPressed();
      if(self.var_2651) {
        var_13 = 0;
      } else if(var_13) {
        if(1) {
          var_0A = var_0A + var_12;
          if(var_0A >= var_07) {
            var_0A = var_07;
            self.var_2651 = 1;
            if(get_vehicleweapon_fire_mode() == "CODE") {
              param_01 method_8322();
            }
          }
        }
      }
    }

    if(var_13) {
      if(get_vehicleweapon_fire_mode() == "SCRIPT") {
        if(!var_10) {
          param_01 playrumblelooponentity("steady_rumble");
          var_10 = 1;
        }

        var_02++;
        var_14 = common_scripts\utility::func_627D(var_02, var_05.size);
        playFXOnTag(var_05[var_14], self, "TAG_ORIGIN");
        var_15 = function_0280(self.var_615C[var_14]);
        if(isDefined(var_15)) {
          var_16 = param_01 getEye();
          var_17 = param_01 geteyeangles();
          var_18 = anglesToForward(var_17);
          var_19 = self gettagorigin("prop");
          var_1A = distance(var_19, var_16) * 1.1;
          var_1B = var_16 + var_18 * var_1A;
          var_1C = 25000;
          var_1D = var_1B + var_18 * var_1C;
          magicbullet(var_15, var_1B, var_1D, param_01, undefined, undefined, 1);
        }
      }
    } else {
      if(get_vehicleweapon_fire_mode() == "SCRIPT") {
        if(var_10) {
          param_01 stoprumble("steady_rumble");
          var_10 = 0;
        }
      }

      if(1) {
        if(self.var_2651) {
          var_0A = var_0A - var_12 * var_08;
          if(var_0A <= 0) {
            var_0A = 0;
            self.var_2651 = 0;
            if(get_vehicleweapon_fire_mode() == "CODE") {
              param_01 method_8323();
            }
          }
        } else {
          var_0A = max(var_0A - var_12 * var_09, 0);
        }
      }
    }

    var_1E = 0;
    if(var_13) {
      var_1E = randomfloatrange(0.0025, 0.005) * common_scripts\utility::func_98E7(common_scripts\utility::func_24A6(), 1, -1);
    }

    if(1) {
      var_1F = clamp(var_0A / var_07 + var_1E, 0, 1);
      param_01 setclientomnvar("ui_raid_vehicle_overheat_percent", var_1F);
    }

    wait(var_12);
  }
}

func_4A35() {
  self notify("fighter_fov");
  self endon("disconnect");
  self endon("death");
  self endon("fighter_fov");
  if(function_01EF(self)) {
    return;
  }

  var_00 = getdvarfloat("cg_fov");
  var_01 = level.var_1E8C[self.var_28D8].var_A10 / var_00;
  var_02 = level.var_1E8C[self.var_28D8].var_9164 / var_00;
  self method_8036(var_02, 0.1);
  self.var_28FB = var_02;
  var_03 = 0.4;
  var_04 = 1;
  self method_8036(var_02, var_04);
  for(;;) {
    if(!isDefined(self) || function_0279(self)) {
      break;
    }

    var_05 = self adsButtonPressed();
    if(var_05) {
      var_01 = level.var_1E8C[self.var_28D8].var_A10 / var_00;
      var_02 = level.var_1E8C[self.var_28D8].var_9164 / var_00;
      self method_8036(var_01, var_03);
      self.var_28FB = var_01;
      self.var_6F1F = 1;
      while(var_05) {
        wait 0.05;
        var_05 = self adsButtonPressed();
      }

      self method_8036(var_02, var_04);
      self.var_28FB = var_02;
      self.var_6F1F = 0;
    }

    wait 0.05;
  }
}

hide_all_bombers() {
  var_00 = 1;
  for(;;) {
    var_01 = getEntArray("bomber_combat_box" + var_00, "targetname");
    if(var_01.size == 0) {
      break;
    }

    foreach(var_03 in var_01) {
      var_03 method_80B1();
      var_03 method_805C();
    }

    var_00++;
  }
}

func_4A1D() {
  if(getdvarint("fighter_vs_fighter_mode") == 1) {
    return;
  }

  level.var_611D = [];
  level.var_611D[level.var_611D.size] = (0, 0, 0);
  level.var_611C = [];
  level.var_611C[level.var_611C.size] = (0, 0, 0);
  level.var_611F = [];
  level.var_611F[level.var_611F.size] = (0, 0, 0);
  var_00 = [];
  var_00[0] = -1;
  var_00[1] = 1;
  var_01 = 1;
  var_02 = [];
  var_02[1] = 1;
  var_02[4] = 1;
  var_02[7] = 1;
  var_02[8] = 1;
  var_02[11] = 1;
  for(;;) {
    var_03 = getEntArray("bomber_combat_box" + var_01, "targetname");
    if(var_03.size == 0) {
      break;
    }

    if(isDefined(var_02[var_01])) {
      level.var_611C[var_01] = (0, 0, 0);
      level.var_611F[var_01] = (0, 0, 0);
      level.var_611D[var_01] = (0, 0, 0);
    } else {
      level.var_611C[var_01] = (0, randomfloat((0, 200, 50)[1]), randomfloat((0, 200, 50)[2]));
      level.var_611F[var_01] = (0, var_00[randomint(2)] * randomfloatrange(0.8, 1.2), var_00[randomint(2)] * randomfloatrange(0.8, 1.2)) * (0, 0.5, 1);
      level.var_611D[var_01] = (0, sin(level.var_611C[var_01][1]) * (0, 200, 50)[1], sin(level.var_611C[var_01][1]) * (0, 200, 50)[2]);
    }

    foreach(var_05 in var_03) {
      if(isDefined(var_05.var_164)) {
        continue;
      }

      if(isDefined(var_05.var_81EF)) {
        var_06 = var_05 common_scripts\utility::func_41EC();
        if(isDefined(var_06)) {
          var_06 linkto(var_05);
        }
      }

      if(!isDefined(var_05.var_522C)) {
        var_05 func_51FC();
      }

      var_05.var_611E = var_01;
    }

    var_01++;
  }

  var_08 = "b17_ambient_fire_root";
  while(!isDefined(level.var_CF1)) {
    wait(0.1);
  }

  var_09 = 0.3;
  for(;;) {
    for(var_0A = 1; var_0A < var_01; var_0A++) {
      if(!isDefined(var_02[var_0A])) {
        level.var_611C[var_0A] = level.var_611C[var_0A] + level.var_611F[var_0A];
        level.var_611D[var_0A] = (0, sin(level.var_611C[var_0A][1]) * (0, 200, 50)[1], sin(level.var_611C[var_0A][1]) * (0, 200, 50)[2]);
      }
    }

    foreach(var_05 in level.var_CF1[var_08].var_8E0) {
      if(isDefined(var_05) && isDefined(var_05.var_852) && var_05 bomber_is_alive()) {
        var_05.var_852 = var_05.var_852 + var_05.var_6484;
        var_05.var_851 = var_05.var_851 + var_05.var_6473;
        if(isDefined(var_05.var_18A7)) {
          var_05 moveto(level.var_611D[var_05.var_611E] + level.b17_cluster_ent.var_116 + var_05.cluster_offset + (sin(var_05.var_852[0]) * var_05.var_18A7[0], sin(var_05.var_852[1]) * var_05.var_18A7[1], sin(var_05.var_852[2]) * var_05.var_18A7[2]), var_09);
          var_05 rotateto(level.b17_cluster_ent.var_1D + (0, 0, sin(var_05.var_851[2]) * var_05.var_18A3[2]), var_09);
          continue;
        }

        var_05 moveto(level.var_611D[var_05.var_611E] + level.b17_cluster_ent.var_116 + var_05.cluster_offset + (sin(var_05.var_852[0]) * (120, 230, 200)[0], sin(var_05.var_852[1]) * (120, 230, 200)[1], sin(var_05.var_852[2]) * (120, 230, 200)[2]), var_09);
        var_05 rotateto(level.b17_cluster_ent.var_1D + (0, 0, sin(var_05.var_851[2]) * (0, 0, 2)[2]), var_09);
      }
    }

    wait(var_09);
  }
}

func_51FC() {
  if(getdvarint("move_bombers", 1) == 1) {
    self.var_522C = level.b17_cluster_ent.var_116 + self.cluster_offset;
    self.var_515C = level.b17_cluster_ent.var_1D;
  } else {
    self.var_522C = self.var_116;
    self.var_515C = self.var_1D;
  }

  if(!isDefined(self.var_6484)) {
    var_00 = undefined;
    var_01 = undefined;
    var_02 = undefined;
    if(common_scripts\utility::func_24A6()) {
      var_00 = 1;
    } else {
      var_00 = -1;
    }

    if(common_scripts\utility::func_24A6()) {
      var_01 = 1;
    } else {
      var_01 = -1;
    }

    if(common_scripts\utility::func_24A6()) {
      var_02 = 1;
    } else {
      var_02 = -1;
    }

    self.var_6484 = (var_00 * randomfloatrange(0.8, 1.2), var_01 * randomfloatrange(0.8, 1.2), var_02 * randomfloatrange(0.8, 1.2)) * (7.95, 7.75, 7.9);
    var_03 = undefined;
    if(common_scripts\utility::func_24A6()) {
      var_03 = 1;
    } else {
      var_03 = -1;
    }

    self.var_6473 = (0, 0, var_03 * randomfloatrange(0.8, 1.2)) * (1, 1, 2.4);
  }

  self.var_851 = (0, 0, 0);
  self.var_852 = (0, 0, 0);
  if(!isDefined(self.var_611E)) {
    self.var_611E = 0;
    if(!isDefined(level.var_611D)) {
      level.var_611D = [];
      level.var_611D[self.var_611E] = (0, 0, 0);
    }
  }

  if(issubstr(self.var_106, "b17")) {
    thread func_18A5(-1);
  }
}

func_18A5(param_00) {
  self notify("stop_bob_in_space");
  self endon("stop_bob_in_space");
  level endon("kill_ambient_bobs");
  self endon("death");
  if(!isDefined(param_00)) {
    param_00 = 16000;
  }

  if(!isDefined(self.var_522C)) {
    func_51FC();
  }

  self.var_18A4 = gettime() + param_00;
  var_01 = 0.3;
  while(self.var_18A4 > gettime() || param_00 == -1) {
    if(!bomber_is_alive()) {
      break;
    }

    self.var_852 = self.var_852 + self.var_6484;
    self.var_851 = self.var_851 + self.var_6473;
    if(isDefined(self.var_18A7)) {
      self moveto(level.var_611D[self.var_611E] + level.b17_cluster_ent.var_116 + self.cluster_offset + (sin(self.var_852[0]) * self.var_18A7[0], sin(self.var_852[1]) * self.var_18A7[1], sin(self.var_852[2]) * self.var_18A7[2]), var_01);
      self rotateto(level.b17_cluster_ent.var_1D + (0, 0, sin(self.var_851[2]) * self.var_18A3[2]), var_01);
      continue;
    }

    self moveto(level.var_611D[self.var_611E] + level.b17_cluster_ent.var_116 + self.cluster_offset + (sin(self.var_852[0]) * (120, 230, 200)[0], sin(self.var_852[1]) * (120, 230, 200)[1], sin(self.var_852[2]) * (120, 230, 200)[2]), var_01);
    self rotateto(level.b17_cluster_ent.var_1D + (0, 0, sin(self.var_851[2]) * (0, 0, 2)[2]), var_01);
    wait(var_01);
  }
}

func_99BF() {
  level endon("dogfight_done");
  if(!isDefined(level.var_D10)) {
    level.var_D10 = 0;
  }
}

add_player_turrets(param_00) {
  var_01 = [];
  var_01["0_top"] = [360, 360, 55, 20, "usa_bomber_b17_topturret", "TAG_TURRET_TOP"];
  var_01["1_belly"] = [360, 360, 10, 80, "usa_bomber_b17_ballturret_raid", "TAG_TURRET_BELLY"];
  if(0) {
    var_01["2_left"] = [75, 75, 45, 30, "usa_bomber_b17_waistgun", "TAG_TURRET_LEFT"];
    var_01["3_right"] = [75, 75, 45, 30, "usa_bomber_b17_waistgun", "TAG_TURRET_RIGHT"];
  }

  if(0) {
    var_01["4_back"] = [75, 75, 45, 45, "usa_bomber_b17_tailgun", "TAG_TURRET_BACK"];
    var_01["5_front"] = [75, 75, 45, 45, "npc_ger_mg42_bipod_turret_raid", "TAG_TURRET_FRONT"];
  }

  self.turretarray = [];
  self.var_744A = [];
  self.numoccupied = 0;
  var_02 = 0;
  foreach(var_04 in var_01) {
    var_05 = undefined;
    if(isDefined(var_04)) {
      var_05 = b17spawnturret("turretweapon_plane_gunner_turret_mp_raids", var_04[4], self gettagorigin(var_04[5]), self gettagangles(var_04[5]), var_04);
      var_05 method_8449(self, var_04[5]);
      var_05 setmode("manual");
      self.turretarray[var_02] = spawnStruct();
      self.turretarray[var_02].var_378F = var_05;
      self.turretarray[var_02].var_69A5 = 0;
      self.turretarray[var_02].turret_info = var_04;
      var_02++;
    }
  }
}

func_08FD(param_00) {
  if(!isDefined(level.var_CF1)) {
    level.var_CF1 = [];
  }

  if(!isDefined(level.var_CF1[param_00])) {
    var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
    level.var_CF1[param_00] = var_01;
    var_02 = var_01.var_116;
    var_01.var_116 = (0, 0, 0);
    var_01.var_9835 = getEntArray(var_01.var_1A2, "targetname");
    if(var_01.var_9835.size == 0) {
      var_01.var_9835 = common_scripts\utility::func_46B7(var_01.var_1A2, "targetname");
    }

    var_01.var_3BB7 = [];
    foreach(var_04 in var_01.var_9835) {
      var_04.var_116 = var_04.var_116 - var_02;
      if(!isDefined(var_01.var_3BB7[var_04.var_8260])) {
        var_01.var_3BB7[var_04.var_8260] = [];
      }

      var_01.var_3BB7[var_04.var_8260][var_01.var_3BB7[var_04.var_8260].size] = var_04;
    }
  }

  if(!isDefined(level.var_CF1[param_00].var_8E0)) {
    level.var_CF1[param_00].var_8E0 = [];
  }

  level.var_CF1[param_00].var_8E0[level.var_CF1[param_00].var_8E0.size] = self;
  self.var_3BB9 = 0;
}

func_14DE(param_00, param_01) {
  var_02 = anglesToForward(self.var_1D);
  var_03 = anglestoright(self.var_1D);
  var_04 = 0;
  for(;;) {
    wait(randomfloatrange(1, 3));
    if(!common_scripts\utility::func_24A6()) {
      continue;
    }

    var_05 = common_scripts\utility::func_7A33(level.pp_array);
    var_04 = gettime() + randomfloatrange(2, 4) * 1000;
    var_06 = distance2d(self.var_116, var_05.var_116);
    self notify("turret_sound_on");
    while(isDefined(var_05) && var_05.var_BC > 1 && var_04 > gettime() || var_06 < 7000) {
      var_07 = 0;
      var_08 = var_05.var_116 - self.var_116;
      var_08 = (var_08[0], var_08[1], 0);
      var_08 = vectornormalize(var_08);
      var_09 = vectordot(var_08, var_02);
      var_0A = vectordot(var_08, var_03);
      switch (param_01) {
        case "belly":
          if(var_05.var_116[2] < self.var_116[2]) {
            var_07 = 1;
          }
          break;

        case "top":
          if(var_05.var_116[2] > self.var_116[2] + 96) {
            var_07 = 1;
          }
          break;

        case "back":
          if(var_09 < -0.707) {
            var_07 = 1;
          }
          break;

        case "front":
          if(var_09 > 0.707) {
            var_07 = 1;
          }
          break;

        case "right":
          if(var_0A > 0.707 && var_09 <= 0.707 && var_09 >= -0.707) {
            var_07 = 1;
          }
          break;

        case "left":
          if(var_0A < -0.707 && var_09 <= 0.707 && var_09 >= -0.707) {
            var_07 = 1;
          }
          break;
      }

      if(var_06 > 768 && var_07) {
        var_0B = combineangles(param_00.var_1D, self.var_1D);
        foreach(var_11, var_0D in param_00.var_3BB7[param_01]) {
          var_0E = rotatevector(var_0D.var_116, var_0B) + self.var_116;
          var_0F = anglesToForward(var_05.var_1D) * var_05 method_8283() * 7;
          var_10 = vectornormalize(var_05.var_116 + var_0F - var_0E);
          var_10 = common_scripts\utility::func_7A60(var_10, 5);
          playFX(common_scripts\utility::func_44F5(var_0D.var_82EC), var_0E, var_10);
          var_05 notify("b17_attacking", self);
        }
      }

      wait 0.05;
      if(isDefined(var_05)) {
        var_06 = distance2dsquared(self.var_116, var_05.var_116);
      }
    }

    self notify("turret_sound_off");
  }
}

func_14C3(param_00) {
  self endon("death");
  var_01 = [];
  var_02 = ["belly", "top", "front", "back", "right", "left"];
  foreach(var_04 in var_02) {
    childthread func_14DE(param_00, var_04);
  }
}

func_3742() {
  self endon("death");
  self.var_1195 = 0;
  self.var_1194 = gettime() + 200;
  for(;;) {
    self waittill("b17_attacking", var_00);
    if((!common_scripts\utility::func_3794("is_dogfight_target") && level.var_14DC >= 2) || level.var_14DC >= 1 && !isDefined(level.var_7610.var_31E7) && level.var_7610.var_31E7 == self) {
      if(self.var_1194 < gettime()) {
        self.var_1194 = gettime() + 200;
        self.var_1195 = 0;
      }

      self.var_1195++;
      if(self.var_1195 * level.var_14DC > 5) {
        if(common_scripts\utility::func_AA4A(level.var_721C getEye(), level.var_721C geteyeangles(), self.var_116, 0.83)) {
          self notify("damage");
          wait(0.2);
          self.var_1195 = 0;
        }
      }
    }
  }
}

b17_turret_snd_loop() {
  self endon("death");
  var_00 = randomfloatrange(1, 1.3);
  for(;;) {
    self waittill("turret_sound_on");
    var_01 = "b17_stop_turret_" + lib_0378::func_8D86();
    self waittill("turret_sound_off");
    level notify(var_01);
  }
}

func_89BA(param_00) {
  level.var_9B7B = common_scripts\utility::func_46B5("tr_bomber_bounds", "targetname");
  if(!isDefined(level.var_8F6D)) {
    level.var_8F6D = [];
  }

  foreach(var_02 in level.var_CF1[param_00].var_8E0) {
    var_03 = level.var_9B7B.var_116 - var_02.var_116;
    var_04 = int(var_03[0] / 8000);
    var_05 = int(var_03[1] / 8000);
    if(!isDefined(level.var_8F6D[var_04])) {
      level.var_8F6D[var_04] = [];
    }

    if(!isDefined(level.var_8F6D[var_04][var_05])) {
      level.var_8F6D[var_04][var_05] = [];
    }

    level.var_8F6D[var_04][var_05][level.var_8F6D[var_04][var_05].size] = var_02;
  }
}

setup_bomber_ambient_return_fire() {
  thread func_99BF();
  thread func_3742();
}

setup_bomber_turrets() {
  var_00 = getEntArray("b17_ambient_tracer", "script_noteworthy");
  level.b17_array = var_00;
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    common_scripts\utility::func_FB2(var_00, ::func_08FD, "b17_ambient_fire_root");
    common_scripts\utility::func_FB2(var_00, ::add_player_turrets, "b17_ambient_fire_root");
    common_scripts\utility::func_FB2(var_00, ::b17_damage_setup);
    common_scripts\utility::func_FB2(var_00, ::vehicle_scripts\_usa_bomber_b17_mp::func_51FB);
    foreach(var_02 in var_00) {
      var_02 makeentitysentient("allies");
      var_02 setthreatbiasgroup("group_bombers");
      var_02 lib_0378::func_8D74("b17_plane_impacts");
      var_02 lib_0378::func_8D74("b17_death_sound");
      if(1) {
        var_02 spawn_bomber_vfx_states();
      }
    }

    return;
  }

  hide_all_bombers();
}

func_89D5() {
  createthreatbiasgroup("group_bombers");
  createthreatbiasgroup("group_allies");
  createthreatbiasgroup("group_axis");
  setthreatbias("group_axis", "group_bombers", 10000);
  setthreatbias("group_bombers", "group_axis", 10000);
}

common_award_pending_assists(param_00, param_01) {
  var_02 = self;
  if(isDefined(var_02.damageregistry) && var_02.damageregistry.size > 0) {
    var_03 = [];
    foreach(var_05 in var_02.damageregistry) {
      var_06 = var_05[0];
      var_07 = var_05[1];
      if(isDefined(param_00) && param_00 == var_06) {
        continue;
      }

      if(!isDefined(var_03[var_06])) {
        var_03[var_06] = 0;
      }

      var_03[var_06] = var_03[var_06] + var_07;
    }

    foreach(var_06, var_07 in var_03) {
      var_0A = undefined;
      foreach(var_0C in level.var_744A) {
        var_0D = var_0C maps\mp\_utility::func_4704();
        if(var_0D == var_06) {
          var_0A = var_0C;
          break;
        }
      }

      var_0F = int(100 * var_07 / var_02.var_FB);
      var_10 = "assist_low";
      if(var_0F >= 40 && var_0F < 60) {
        var_10 = "assist_mid";
      } else if(var_0F >= 60 && var_0F < 80) {
        var_10 = "assist_high";
      } else if(var_0F >= 80) {
        var_10 = "assist_steal";
      }

      var_0A thread maps\mp\_events::func_774E(param_01, var_10);
    }
  }
}

common_clear_pending_assists(param_00) {
  var_01 = self;
  if(!isDefined(var_01.damageregistry)) {
    return;
  }

  var_02 = [];
  foreach(var_04 in var_01.damageregistry) {
    var_05 = var_04[0];
    var_06 = var_04[1];
    if(param_00 <= 0) {
      var_02 = common_scripts\utility::func_F6F(var_02, var_04);
      continue;
    }

    if(var_06 >= param_00) {
      var_06 = var_06 - param_00;
      param_00 = 0;
      var_04[1] = var_06;
      var_02 = common_scripts\utility::func_F6F(var_02, var_04);
      continue;
    }

    param_00 = param_00 - var_06;
    var_06 = 0;
  }

  var_01.damageregistry = var_02;
}

common_update_pending_assists(param_00, param_01, param_02) {
  var_03 = self;
  if(!isDefined(var_03.damageregistry)) {
    var_03.damageregistry = [];
  }

  var_04 = var_03.damageregistry.size - 1;
  while(var_04 >= 0) {
    var_05 = var_03.damageregistry[var_04];
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_08 = var_05[2];
    if(var_06 == param_00 && param_02 - var_08 < 500) {
      var_09[2] = var_07 + param_01;
      return;
    }

    var_05--;
  }

  var_04.damageregistry = common_scripts\utility::func_F6F(var_04.damageregistry, [param_01, param_02, var_03]);
}

fighter_calc_health_regen_mult() {
  var_00 = self;
  var_01 = var_00.occupied_player;
  var_02 = 1;
  if(isDefined(var_01) && isDefined(var_00.var_5B8A)) {
    var_03 = var_00.var_5B8A;
    var_04 = gettime();
    if(var_04 - var_03 > 10000) {
      var_02 = 3;
    }
  }

  return var_02;
}

common_health_regen(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = self;
  var_07 = self.occupied_player;
  var_06 notify("common_health_regen");
  var_06 endon("death");
  var_06 endon("common_health_regen");
  wait(param_00);
  var_08 = param_02 * var_06.var_FB / 100;
  var_08 = int(clamp(var_08, param_05, var_06.var_FB));
  while(var_06.var_BC > param_05 && var_06.var_BC < var_06.var_FB) {
    var_09 = 1;
    if(isDefined(param_04)) {
      var_09 = [[param_04]]();
    }

    var_0A = int(clamp(var_08 * var_09, param_05, var_06.var_FB));
    var_06.var_BC = var_06.var_BC + var_0A;
    if(isDefined(var_07)) {
      var_0B = var_06.var_BC / var_06.var_FB;
      var_07.var_BC = int(var_07.var_FB * var_0B);
    }

    var_06 common_clear_pending_assists(var_0A);
    if(var_06.var_BC >= var_06.var_FB) {
      var_06.var_BC = var_06.var_FB;
    }

    var_06[[param_03]]();
    wait(param_01);
  }
}

compare_health_threshold_frac(param_00, param_01) {
  return param_00.health_threshold_frac > param_01.health_threshold_frac;
}

common_damage_state_fx_update_watcher(param_00, param_01) {
  self notify("damage_state_fx_update_watcher_" + int(param_00.health_threshold_frac * 100));
  self endon("damage_state_fx_update_watcher_" + int(param_00.health_threshold_frac * 100));
  self endon("disconnect");
  var_02 = self;
  if(!isarray(param_00.vfx_tag)) {
    param_00.vfx_tag = [param_00.vfx_tag];
  }

  self.vfx_obj_list = [];
  for(;;) {
    if(function_0279(var_02) || var_02.var_BC <= param_01 || common_scripts\utility::func_562E(level.match_ended)) {
      foreach(var_04 in self.vfx_obj_list) {
        if(!function_0279(var_04)) {
          var_04 delete();
        }
      }

      break;
    }

    if(param_00.var_88A) {
      if(!param_00.var_552B) {
        param_00.var_552B = 1;
        if(isDefined(param_00.vfx_in)) {
          foreach(var_07 in param_00.vfx_tag) {
            playFXOnTag(param_00.vfx_in, var_02, var_07);
          }

          wait(param_00.vfx_in_length);
        }

        foreach(var_07 in param_00.vfx_tag) {
          var_04 = spawnlinkedfx(param_00.vfx_loop, var_02, var_07);
          function_014E(var_04, 1);
          triggerfx(var_04);
          self.vfx_obj_list[var_07] = var_04;
        }

        continue;
      }
    } else if(param_00.var_552B) {
      param_00.var_552B = 0;
      foreach(var_04 in self.vfx_obj_list) {
        var_04 delete();
      }

      if(isDefined(param_00.vfx_out)) {
        foreach(var_07 in param_00.vfx_tag) {
          playFXOnTag(param_00.vfx_out, var_02, var_07);
        }
      }

      continue;
    }

    var_02 common_scripts\utility::func_A732("health_update", "match_end");
    waittillframeend;
  }
}

common_damage_state_fx_watcher(param_00, param_01) {
  self notify("damage_state_fx_watcher");
  self endon("damage_state_fx_watcher");
  var_02 = self;
  var_03 = 0;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 endon("death");
  param_00 = common_scripts\utility::func_FA5(param_00, ::compare_health_threshold_frac);
  foreach(var_05 in param_00) {
    var_05.var_88A = 0;
    var_05.var_552B = 0;
    var_02 thread common_damage_state_fx_update_watcher(var_05, param_01);
  }

  var_02.damagevfxstates = param_00;
  for(;;) {
    var_07 = var_02.var_BC / var_02.var_FB;
    var_08 = -1;
    if(var_07 < param_00[0].health_threshold_frac) {
      for(var_09 = 0; var_09 < param_00.size; var_09++) {
        var_05 = param_00[var_09];
        var_0A = var_05.health_threshold_frac;
        var_0B = 0;
        if(var_09 < param_00.size - 1) {
          var_0B = param_00[var_09 + 1].health_threshold_frac;
        }

        if(var_07 < var_0A && var_07 >= var_0B) {
          var_08 = var_09;
          if(var_03 != var_08) {
            lib_0378::func_8D74("aud_fighter_damage_state_change", var_08);
          }

          var_03 = var_09;
          break;
        }
      }
    }

    for(var_09 = 0; var_09 < param_00.size; var_09++) {
      var_05 = param_00[var_09];
      var_05.var_88A = var_08 == var_09;
    }

    var_02 waittill("health_update");
  }
}

fighter_is_alive() {
  var_00 = self;
  if(var_00.var_BC > 1) {
    return 1;
  }

  return 0;
}

fighter_on_health_update_func() {
  var_00 = self;
  var_01 = var_00.occupied_player;
  var_00 notify("health_update");
  if(isDefined(var_01)) {
    var_02 = var_00.var_BC / var_00.var_FB;
    var_01 setclientomnvar("ui_raid_vehicle_health_percent", var_02);
  }
}

fighter_death_anim_wait(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    var_01 endon("vehicle_dismount");
    param_00 waittillmatch("end", "fighter_anim_notetrack");
    return;
  }

  var_01 waittill("vehicle_dismount");
}

fighter_get_crash_animation() {
  if(!1) {
    return undefined;
  }

  var_00 = ["mp_raids_husky_usa_thunderbolt_crash_right", "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down", "mp_raids_husky_usa_thunderbolt_crash_left", "mp_raids_husky_usa_thunderbolt_crash_nose_dive", undefined];
  return common_scripts\utility::func_7A33(var_00);
}

fighter_get_crash_anim_ref(param_00) {
  if(param_00 == "mp_raids_husky_usa_thunderbolt_crash_right") {
    return % mp_raids_husky_usa_thunderbolt_crash_right;
  }

  if(param_00 == "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down") {
    return % mp_raids_husky_usa_thunderbolt_graveyard_spiral_down;
  }

  if(param_00 == "mp_raids_husky_usa_thunderbolt_crash_left") {
    return % mp_raids_husky_usa_thunderbolt_crash_left;
  }

  if(param_00 == "mp_raids_husky_usa_thunderbolt_crash_up") {
    return % mp_raids_husky_usa_thunderbolt_crash_up;
  }

  if(param_00 == "mp_raids_husky_usa_thunderbolt_crash_nose_dive") {
    return % mp_raids_husky_usa_thunderbolt_crash_nose_dive;
  }

  return undefined;
}

fighter_crash_anim_notetrack_watch() {
  var_00 = self;
  var_00 endon("death");
  for(;;) {
    var_00 waittill("fighter_anim_notetrack", var_01);
    if(var_01 == "end") {
      break;
    }

    if(var_01 == "hide_plane") {
      var_00 method_8511();
    }
  }
}

fighter_play_crash_anim(param_00, param_01, param_02, param_03) {
  wait 0.05;
  if(param_03) {
    param_01 method_8278(param_02, "fighter_anim_notetrack");
    param_01 childthread fighter_crash_anim_notetrack_watch();
    return;
  }

  param_01 scriptmodelplayanim(param_02, undefined, 0, 0.01);
  param_01 scriptmodelpauseanim(1);
  param_01 method_8511();
  param_00 method_81E2(param_01, "tag_player", 0);
}

fighter_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  if(isDefined(level.alliedfightersdowned) && isDefined(level.axisfightersdowned)) {
    if(param_00.var_1A7 == game["attackers"]) {
      level.alliedfightersdowned++;
    } else if(param_00.var_1A7 == game["defenders"]) {
      level.axisfightersdowned++;
    }
  }

  if(isDefined(level.var_7919)) {
    thread[[level.var_7919]]("fighter_deathmatch", "death", param_00.var_1A7);
  }

  if(isDefined(param_05) && param_05 == "killstreak_flak_gun_raids") {
    param_00.hasdiedtoflak = 1;
    param_00.flak_scorestreak_id = level.flak_scorestreak_id;
  }

  foreach(var_09 in level.var_744A) {
    if(param_00 == var_09) {
      continue;
    }

    var_0A = var_09 method_85E2();
    if(isDefined(var_07)) {
      var_07 remove_target_on_death(var_09);
    }

    if(isDefined(var_0A)) {
      var_0A remove_target_on_death(param_00);
    }
  }

  param_00 clearagenticonsforplayer();
  if(getdvarint("fighter_vs_fighter_mode") == 1) {
    if(isDefined(level.fighters_downed) && !function_01EF(param_00)) {
      level.fighters_downed++;
      if(isDefined(level.last_fighter_downed_time) && level.last_fighter_downed_time == gettime()) {
        waittillframeend;
      }

      level.last_fighter_downed_time = gettime();
      level notify("fighter_downed", param_00.var_1A7);
      wait 0.05;
      if(level.fighters_downed >= 20) {
        if(issubstr(maps\mp\_utility::func_4571(), "_wb_")) {
          level thread maps\mp\gametypes\_gamelogic::func_3E1A();
        } else {
          level notify("bomber_objective_complete");
        }
      }
    }
  }

  if(isDefined(param_02)) {
    var_0C = "raid_fighter_killshot";
    param_02 maps\mp\gametypes\_damagefeedback::func_A102(var_0C);
  }

  var_0D = fighter_get_crash_animation();
  var_07 vehicle_scripts\_fighter_mp::deathcleanup();
  var_07 method_8511();
  var_0E = undefined;
  var_0F = 1.5;
  var_10 = 0;
  if(isDefined(var_0D)) {
    var_0E = spawn("script_model", var_07.var_116);
    var_0E.var_1D = var_07.var_1D;
    var_0E setModel(var_07.var_106);
    var_10 = !var_07 is_plane_outside_hard_boundary();
    if(var_10) {
      var_11 = fighter_get_crash_anim_ref(var_0D);
      var_12 = getanimlength(var_11) + var_0F;
      var_13 = int(var_12 * 1000);
      param_00 method_8601(var_13);
      param_00.onplayerkilledwaitfordeathduration = 1;
    } else {
      var_0F = 2;
    }

    thread fighter_play_crash_anim(param_00, var_0E, var_0D, var_10);
    var_07 lib_0378::func_8D74("aud_fighter_start_death", var_0E);
  }

  param_00 setclientdvar("ui_raid_hide_fighter", 1);
  param_00 setdemigod(0);
  param_00 dodamage(99999, param_01, param_02, param_03, param_04, param_05, param_06);
  if(!isbot(param_00) && !function_01EF(param_00)) {
    fighter_clear_perks(param_00);
  }

  var_07 setCanDamage(0);
  var_07 method_80B1();
  if(function_01EF(param_00)) {
    param_00 method_8322();
  } else {
    param_00 maps\mp\_utility::func_3E8E(1);
  }

  if(var_10) {
    if(function_01EF(param_00)) {
      var_07 fighter_death_anim_wait(var_0E);
    } else {
      if(isDefined(var_0E)) {
        param_00 method_81E2(var_0E, "tag_player", 0);
      }

      var_07 fighter_death_anim_wait(var_0E);
    }
  }

  param_00 remove_client_fighter_fx(var_07);
  if(isDefined(var_0E)) {
    var_14 = var_0E gettagorigin("TAG_AIM");
    var_07 lib_0378::func_8D74("aud_fighter_final_explosion", var_14);
    if(!var_10) {
      playFX(level.var_611["mp_raid_fighter_bounds_death"], var_0E gettagorigin("prop"));
    }

    var_0E method_8511();
    wait(var_0F);
    if(isDefined(var_0E)) {
      var_0E delete();
    }
  }

  if(isPlayer(param_00) && isDefined(param_00.fighter_sshud)) {
    param_00.fighter_sshud destroy();
  }

  if(common_scripts\utility::func_562E(level.var_3F9D)) {
    level waittill("mp_raid_dlc2_never");
  }

  delete_plane(var_07);
}

fighter_damage_callback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  var_0D = var_0C.occupied_player;
  if(!var_0C fighter_is_alive()) {
    return;
  }

  if(isDefined(param_01.var_1A7) && var_0C.var_1A7 == param_01.var_1A7) {
    return;
  }

  if(param_04 == "MOD_CRUSH") {
    return;
  }

  if(common_scripts\utility::func_562E(var_0D.var_4B97)) {
    return;
  }

  if(isDefined(level.var_4E09)) {
    return;
  }

  var_0E = param_01 method_85E2();
  if(isDefined(var_0E) && var_0E != var_0C) {
    param_02 = param_02 * 0.1;
  }

  var_0F = "raid_fighter";
  param_01 maps\mp\gametypes\_damagefeedback::func_A102(var_0F);
  var_0C.var_BC = var_0C.var_BC - int(param_02);
  var_0C.var_5B8A = gettime();
  var_0C fighter_on_health_update_func();
  if(1 && var_0C.var_BC > 1) {
    var_0C thread common_health_regen(2, 0.25, 0.1, ::fighter_on_health_update_func, ::fighter_calc_health_regen_mult, 1);
  }

  if(isDefined(var_0D)) {
    var_10 = var_0C.var_BC / var_0C.var_FB;
    var_11 = int(var_0D.var_FB * var_10);
    var_0D dodamage(var_0D.var_BC - var_11, param_01.var_116, param_01, param_00, param_04, param_05, param_08);
  }

  var_0C notify("damage", param_02, param_01, param_07, param_06, param_04);
  if(var_0C.var_BC <= 1) {
    lib_0503::clear_player_target(var_0D);
    var_0C.var_BC = 1;
    var_0C thread fighter_death(var_0D, param_06, param_01, param_00, param_04, param_05, param_08);
    if(isPlayer(param_01)) {
      level thread maps\mp\gametypes\_rank::func_1457("raids_dogfight_kill", param_01, param_05, var_0D, param_04, param_00);
      return;
    }

    return;
  }

  if(isPlayer(param_01)) {
    var_12 = anglesToForward(var_0D.var_1D);
    var_12 = vectornormalize(var_12);
    var_13 = param_01.var_116 - self.var_116;
    var_13 = vectornormalize(var_13);
    var_14 = vectordot(var_12, var_13);
    if(var_14 < 0) {
      if(isDefined(level.var_7919)) {
        thread[[level.var_7919]]("fighter_deathmatch", "onsix", var_0D);
        return;
      }

      return;
    }
  }
}

clearagenticonsforplayer() {
  if(isDefined(level.var_A4E)) {
    foreach(var_01 in level.var_A4E) {
      var_02 = var_01 method_85E2();
      if(isDefined(var_02)) {
        var_02 thread remove_target_on_death(self);
      }
    }
  }
}

b17_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  var_0C notify("b17_death_sound");
  var_0C method_8278("mp_usa_bomber_b17_death_forward", "b17_anim_notetrack");
  var_0C waittillmatch("end", "b17_anim_notetrack");
  playFX(level.var_611["b17_death_detonate"], var_0C.var_116, anglesToForward(var_0C.var_1D), (0, 0, 1));
  b17_turret_cleanup(var_0C);
  if(isDefined(var_0C.var_744A)) {
    foreach(var_0E in var_0C.var_744A) {
      if(isDefined(var_0E)) {
        var_0E.didspawninb17 = 1;
        var_0E setdemigod(0);
        if(isDefined(param_01) && isDefined(param_00)) {
          var_0E dodamage(var_0E.var_BC + 1, param_06, param_01, param_00, param_04, param_05, param_08);
        } else {
          var_0E dodamage(var_0E.var_BC + 1, param_06, undefined, undefined, param_04, param_05, param_08);
        }

        if(isDefined(var_0E.bomber_sshud)) {
          var_0E.bomber_sshud destroy();
        }

        foreach(var_10 in level.var_744A) {
          var_11 = var_10 method_85E2();
          if(var_10.var_1A7 == game["defenders"] && isDefined(var_11)) {
            var_11 remove_target_on_death(var_0E);
          }
        }
      }
    }
  }

  foreach(var_15 in var_0C getlinkedchildren()) {
    if(isDefined(var_15.var_8F4E) && var_15.var_8F4E == "sndentity") {
      var_15 method_863F();
      continue;
    }

    if(isDefined(var_15.var_3A) && var_15.var_3A == "script_brushmodel") {
      var_15 delete();
    }
  }

  var_0C delete();
  level.b17_array = common_scripts\utility::func_FA0(level.b17_array);
  level notify("bomber_destroyed");
  if(isDefined(level.num_bombers)) {
    level.num_bombers--;
  }

  if(level.b17_array.size <= 0) {
    if(issubstr(maps\mp\_utility::func_4571(), "_wb_")) {
      level thread maps\mp\gametypes\_gamelogic::func_3E1A();
    } else {
      level notify("bomber_objective_complete");
    }

    level.var_17EF = 1;
  }
}

bomber_is_alive() {
  var_00 = self;
  if(var_00.var_BC > 1) {
    return 1;
  }

  return 0;
}

b17_on_health_update_func() {
  var_00 = self;
  if(isDefined(var_00.var_744A)) {
    foreach(var_02 in var_00.var_744A) {
      if(isDefined(var_02)) {
        var_03 = var_00.var_BC / var_00.var_FB;
        var_02 setclientomnvar("ui_raid_vehicle_health_percent", var_03);
      }
    }
  }

  var_00 vehicle_scripts\_usa_bomber_b17_mp::b17_check_health_and_remove_fx();
}

b17_get_health_regen_multiplier() {
  var_00 = self;
  if(common_scripts\utility::func_562E(var_00.repairscorestreakenabled)) {
    return 15;
  }

  return 1;
}

b17_damage_callback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(!var_0C bomber_is_alive()) {
    return;
  }

  if(isDefined(param_01.var_1A7) && var_0C.var_1A7 == param_01.var_1A7) {
    return;
  }

  if(param_04 == "MOD_CRUSH") {
    return;
  }

  var_0D = "standard";
  var_0C.var_BC = var_0C.var_BC - param_02;
  var_0C b17_on_health_update_func();
  var_0C notify("health_update");
  if(1 && var_0C.var_BC > 1) {
    var_0C thread common_health_regen(2, 0.25, 0.1, ::b17_on_health_update_func, ::b17_get_health_regen_multiplier, 1);
  }

  param_01 maps\mp\gametypes\_damagefeedback::func_A102(var_0D);
  lib_0503::bomber_healthbar_update(param_01, var_0C);
  var_0C notify("damage", param_02, param_01, param_07, param_06, param_04);
  var_0E = undefined;
  if(isPlayer(param_01) || isbot(var_0E)) {
    var_0E = param_01 maps\mp\_utility::func_4704();
  }

  if(var_0C.var_BC <= 1) {
    foreach(var_10 in var_0C.var_744A) {
      common_award_pending_assists(var_0E, var_10);
    }

    if(isDefined(level.var_7919)) {
      thread[[level.var_7919]]("fighter_deathmatch", "death");
    }

    var_0C.var_BC = 1;
    var_0C thread b17_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    return;
  }

  level notify("bomber_damage");
  if(isDefined(var_0E)) {
    common_update_pending_assists(var_0E, param_02, gettime());
  }
}

b17_is_dead() {
  return self.var_BC <= 1;
}

b17_damage_setup() {
  var_00 = self;
  var_00 setdamagecallbackon(1);
  var_00.var_29B5 = ::b17_damage_callback;
  var_00 setCanDamage(1);
  var_00.var_1A7 = game["attackers"];
  var_00.var_FB = getdvarint("b17_maxhealth");
  var_00.var_BC = var_00.var_FB;
}

delete_plane(param_00) {
  if(isDefined(param_00)) {
    level.pp_array = common_scripts\utility::func_F93(level.pp_array, param_00);
    param_00 notify("health_update");
    param_00 vehicle_scripts\_fighter_mp::destroyturrets();
    param_00 delete();
  }
}

bomber_watch_for_player_switch() {
  self notify("end_bomber_switch_team_watcher");
  self endon("end_bomber_switch_team_watcher");
  var_00 = self;
  var_01 = var_00 common_scripts\utility::func_A716("joined_team", "joined_spectators", "disconnect");
  foreach(var_03 in level.var_744A) {
    var_04 = var_03 method_85E2();
    if(var_03.var_1A7 == game["defenders"] && isDefined(var_04)) {
      var_04 remove_target_on_death(var_00);
    }
  }
}

p47_watch_for_player_switch(param_00) {
  self notify("end_p47_switch_team_watcher");
  self endon("end_p47_switch_team_watcher");
  var_01 = self;
  var_02 = var_01.var_1A7;
  var_03 = var_01 common_scripts\utility::func_A716("joined_team", "joined_spectators", "disconnect");
  if(isDefined(level.b17_avg_target_ui)) {
    level.b17_avg_target_ui remove_target_on_death(var_01);
  }

  if(var_03 == "joined_team" || var_03 == "joined_spectators") {
    var_02 = var_01.var_1A7;
  }

  var_04 = game["defenders"];
  if(var_02 == game["defenders"]) {
    var_04 = game["attackers"];
  }

  foreach(var_06 in level.var_744A) {
    var_07 = var_06 method_85E2();
    if(var_06.var_1A7 == var_04 && isDefined(param_00)) {
      param_00 remove_target_on_death(var_06);
    }

    if(isDefined(var_07)) {
      var_07 remove_target_on_death(var_01);
    }
  }

  var_01 clearagenticonsforplayer();
  if(var_03 != "death") {
    delete_plane(param_00);
  }

  if(isDefined(var_01)) {
    var_01 setclientdvars("ui_raid_hide_fighter", "1", "ui_raid_hide_scorestreaks", "1");
  }
}

watch_fighter_collision() {
  self notify("watchFighterCollision");
  self endon("watchFighterCollision");
  self.occupied_player endon("death");
  self.occupied_player endon("disconnect");
  for(;;) {
    self waittill("veh_collision", var_00, var_01, var_02, var_03);
    if(isDefined(var_02)) {
      if(var_02 method_8564() == "plane") {
        var_02 dodamage(getdvarint("p47_maxhealth") + 1, var_03, self);
      }

      self dodamage(getdvarint("p47_maxhealth") + 1, var_03, var_02);
    }

    wait 0.05;
  }
}

b17initturrets() {
  var_00 = common_scripts\utility::func_46B7("b17_parent", "targetname");
  var_01 = [];
  var_01["turret_top"] = [360, 360, 45, 10, "usa_bomber_b17_ballturret_raid"];
  var_01["turret_bottom"] = [360, 360, 10, 45, "usa_bomber_b17_ballturret_raid"];
  var_01["turret_rear"] = [75, 75, 45, 45, "usa_bomber_b17_ballturret_raid"];
  var_01["turret_front"] = [75, 75, 45, 45, "usa_bomber_b17_ballturret_raid"];
  foreach(var_03 in var_00) {
    var_04 = getEntArray(var_03.var_1A2, "targetname");
    var_05 = common_scripts\utility::func_46B7(var_03.var_1A2, "targetname");
    var_03.turretarray = [];
    var_03.numoccupied = 0;
    foreach(var_07 in var_04) {
      if(isDefined(var_07.var_165) && var_07.var_165 == "b17_turret_use") {
        var_03.usetrigger = var_07;
        var_03.usetrigger sethintstring("Press and hold to enter turrets");
      }

      if(isDefined(var_07.var_165) && var_07.var_165 == "b17_turret") {
        var_03.turretarray[var_07.var_81E1] = spawnStruct();
        var_03.turretarray[var_07.var_81E1].var_378F = var_07;
        var_03.turretarray[var_07.var_81E1].var_69A5 = 0;
      }
    }

    foreach(var_0A in var_05) {
      if(isDefined(var_0A.var_165) && issubstr(var_0A.var_165, "turret")) {
        var_0B = b17spawnturret("turretweapon_plane_gunner_turret_mp_raids", var_01[var_0A.var_165][4], var_0A.var_116, var_0A.var_1D, var_01[var_0A.var_165]);
        var_03.turretarray[var_0A.var_81E1] = spawnStruct();
        var_03.turretarray[var_0A.var_81E1].var_378F = var_0B;
        var_03.turretarray[var_0A.var_81E1].var_69A5 = 0;
      }
    }

    var_03 thread b17watchturretuse();
  }
}

b17watchturretuse() {
  for(;;) {
    self.usetrigger waittill("trigger", var_00);
    var_01 = self.turretarray[0];
    var_00 set_turret_user_nameplate(var_01);
    var_01 useby(var_00);
    var_00.currentturretindex = 0;
    var_00 common_scripts\utility::func_601();
    var_00 thread b17watchturretswitch(self.turretarray);
  }
}

b17_compare_func(param_00, param_01) {
  return param_00.numoccupied < param_01.numoccupied;
}

b17_getoccupantsbitfield(param_00) {
  var_01 = 0;
  var_02 = 2;
  foreach(var_04 in param_00.var_744A) {
    if(isDefined(var_04)) {
      var_05 = 1;
      if(var_04 == self) {
        var_05 = 2;
      }

      var_01 = var_01 | var_05 << var_04.currentturretindex * var_02;
    }
  }

  return var_01;
}

b17_updateclientturretoccupants(param_00) {
  foreach(var_02 in param_00.var_744A) {
    if(isDefined(var_02)) {}
  }
}

b17playermountunoccupiedturret() {
  var_00 = [];
  var_00 = maps\mp\_utility::array_combine_no_dupes(var_00, level.b17_array);
  var_01 = -1;
  var_02 = undefined;
  var_00 = common_scripts\utility::func_FA5(var_00, ::b17_compare_func);
  foreach(var_04 in var_00) {
    for(var_05 = 0; var_05 < var_04.turretarray.size; var_05++) {
      if(isDefined(var_04.turretarray[var_05].var_378F) && var_04.turretarray[var_05].var_69A5 == 0) {
        var_01 = var_05;
        var_02 = var_04;
        break;
      }
    }

    if(isDefined(var_02) && var_04 bomber_is_alive()) {
      break;
    }
  }

  self playerlinkto(var_02, var_02.turretarray[var_01].turret_info[5], 1, var_02.turretarray[var_01].turret_info[1], var_02.turretarray[var_01].turret_info[0], var_02.turretarray[var_01].turret_info[2], var_02.turretarray[var_01].turret_info[3]);
  var_02.numoccupied = var_02.numoccupied + 1;
  set_turret_user_nameplate(var_02.turretarray[var_01].var_378F);
  var_02.turretarray[var_01].var_378F useby(self);
  self.currentturretindex = var_01;
  self.b17 = var_02;
  self.b17.turretarray[self.currentturretindex].var_69A5 = 1;
  if(!isDefined(var_02.var_744A)) {
    var_02.var_744A = [];
  }

  var_02.var_744A[self getentitynumber()] = self;
  b17_updateclientturretoccupants(var_02);
  common_scripts\utility::func_601();
  thread func_A893(var_02);
  if(0) {
    thread b17watchturretswitch(var_02.turretarray);
    return;
  }

  if(1) {
    thread b17watchturretswitchtoggle(var_02.turretarray);
    return;
  }

  thread b17watchturretswitchdirect(var_02.turretarray);
}

func_A893(param_00) {
  param_00 endon("death");
  common_scripts\utility::func_A732("death", "disconnect");
  thread remove_client_bomber_fx(param_00);
  param_00.turretarray[self.currentturretindex].var_69A5 = 0;
  param_00.turretarray[self.currentturretindex].var_378F clear_turret_user_nameplate();
  param_00.var_744A = common_scripts\utility::func_F93(param_00.var_744A, self);
  param_00.numoccupied = param_00.numoccupied - 1;
}

b17spawnturret(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnturret("misc_turret", param_02, param_00, 0);
  var_05 setModel(param_01);
  var_05 setdefaultdroppitchyaw(0, 0);
  if(isDefined(param_03)) {
    var_05.var_1D = param_03;
  }

  var_05.var_1A7 = game["attackers"];
  var_05.var_BC = 99999;
  var_05.var_FB = 1000;
  var_05.var_6A = 0;
  var_05.var_94B9 = 0;
  var_05.var_94BB = 0;
  var_05 setCanDamage(0);
  var_05 setCanRadiusDamage(0);
  var_05 setmode("sentry_manual");
  var_05 method_8151(param_04[0]);
  var_05 method_8150(param_04[1]);
  var_05 method_8152(param_04[2]);
  var_05 method_8153(param_04[3]);
  var_05 method_80FB(0);
  var_05.var_7C29 = 0;
  return var_05;
}

bot_planeshootthink(param_00) {
  var_01 = self;
  var_02 = 0.15;
  var_03 = int(var_02 * 20);
  var_04 = 2;
  var_05 = 1.5;
  var_06 = 0;
  for(;;) {
    wait(var_02);
    if(!var_01 method_8648()) {
      continue;
    }

    foreach(var_08 in level.var_744A) {
      if(var_08.var_1A7 != var_01.var_1A7) {
        var_01 method_8379(var_08, var_08.var_116);
        if(isDefined(var_08.occupied_plane)) {
          var_01 method_8379(var_08.occupied_plane, var_08.occupied_plane.var_116);
        }

        if(isDefined(var_08.b17)) {
          var_01 method_8379(var_08.b17, var_08.b17.var_116);
        }
      }
    }

    var_0A = var_01.var_88;
    if(!isDefined(var_0A)) {
      continue;
    }

    if(distancesquared(var_0A.var_116, param_00.var_116) > 256000000) {
      continue;
    }

    var_0B = vectornormalize(var_0A.var_116 - param_00.var_116);
    var_0C = vectortoangles(var_0B);
    var_0D = param_00.var_1D;
    var_0E = angleclamp180(var_0C[1] - var_0D[1]);
    var_0F = angleclamp180(var_0C[0] - var_0D[0]);
    if(abs(var_0E) < 30 && abs(var_0F) < 30) {
      var_01 botpressbutton("attack", 1);
    }

    var_06 = var_06 + var_02;
    if(var_06 >= var_04) {
      var_06 = 0;
      wait(var_05);
    }
  }
}

bot_planeflythink(param_00) {
  var_01 = self;
  var_01 notify("bot_fly_think");
  var_01 endon("death");
  var_01 endon("disconnect");
  var_01 endon("bot_fly_think");
  param_00 endon("death");
  var_01 childthread bot_planeshootthink(param_00);
  var_02 = 0.25;
  for(;;) {
    wait(var_02);
    var_03 = undefined;
    var_04 = var_01.var_88;
    var_05 = level.var_5FEB;
    if(isDefined(var_04)) {
      var_03 = var_04.var_116;
      var_06 = undefined;
      if(0) {
        var_06 = 1024000000;
      } else {
        var_06 = 484000000;
      }

      if(isDefined(var_05) && distancesquared(var_04.var_116, var_05) >= var_06) {
        var_03 = var_05;
      }
    } else {
      var_03 = var_05;
    }

    if(!isDefined(var_03)) {
      continue;
    }

    var_07 = vectornormalize(var_03 - param_00.var_116);
    var_08 = 9437184;
    if(function_01EF(var_01) && isDefined(var_04)) {
      var_08 = 0;
    }

    if(var_08 > 0 && distancesquared(param_00.var_116, var_03) < var_08) {
      var_07 = var_07 * -1;
    }

    var_09 = vectortoangles(var_07);
    var_0A = var_09[1];
    var_0B = var_09[0];
    if(common_scripts\utility::func_562E(var_01.informationtransition) && isDefined(level.defender_spawn_angles) && isDefined(level.attacker_spawn_angles)) {
      if(var_01.var_1A7 == game["defenders"]) {
        var_0A = level.defender_spawn_angles[1];
        var_0B = level.defender_spawn_angles[0];
      } else {
        var_0A = level.attacker_spawn_angles[1];
        var_0B = level.attacker_spawn_angles[0];
      }
    }

    var_01 botsetscriptmove(var_0A, var_02, 1, 1, 1, var_0B);
  }
}

get_anglesdiff(param_00, param_01) {
  var_02 = angleclamp180(param_00[0] - param_01[0]);
  var_03 = angleclamp180(param_00[1] - param_01[1]);
  return [var_02, var_03];
}

bot_turretswitchthink() {
  var_00 = self;
  var_01 = self.b17;
  var_02 = 1;
  var_03 = int(var_02 * 20);
  var_04 = var_01.turretarray[0].var_378F;
  var_05 = var_01.turretarray[1].var_378F;
  var_06 = undefined;
  var_07 = undefined;
  if(0) {
    var_06 = var_01.turretarray[2].var_378F;
    var_07 = var_01.turretarray[3].var_378F;
  }

  if(0) {}

  var_08 = 30;
  var_09 = 15;
  var_0A = undefined;
  for(;;) {
    var_0B = var_00.var_88;
    if(!isDefined(var_0B)) {
      wait(var_02);
      continue;
    }

    if(isDefined(var_0A)) {
      if(!isDefined(self.currentturret) || self.currentturret != var_0A) {
        if(1) {
          self notify("toggle_bomber_turret");
        } else if(var_0A == var_04) {
          self notify("cycle_turret_top");
        } else if(var_0A == var_05) {
          self notify("cycle_turret_belly");
        } else if(var_0A == var_06) {
          self notify("cycle_turret_left");
        } else if(var_0A == var_07) {
          self notify("cycle_turret_right");
        }
      }
    }

    wait(var_02);
    var_0B = var_00.var_88;
    if(!isDefined(var_0B)) {
      continue;
    }

    var_0A = undefined;
    if(0) {
      var_0C = vectornormalize(var_0B.var_116 - var_06.var_116);
      var_0D = vectortoangles(var_0C);
      var_0E = get_anglesdiff(var_0D, var_06.var_1D);
      if(abs(var_0E[1]) < var_08) {
        var_0A = var_06;
        continue;
      }

      var_0F = vectornormalize(var_0B.var_116 - var_07.var_116);
      var_10 = vectortoangles(var_0F);
      var_11 = get_anglesdiff(var_10, var_07.var_1D);
      if(abs(var_11[1]) < var_08) {
        var_0A = var_07;
        continue;
      }
    }

    var_12 = vectornormalize(var_0B.var_116 - var_04.var_116);
    var_13 = vectortoangles(var_12);
    var_14 = get_anglesdiff(var_13, var_04.var_1D);
    if(var_14[0] < var_09) {
      var_0A = var_04;
      continue;
    }

    var_0A = var_05;
  }
}

agent_spawn(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  if(!isDefined(param_00)) {
    param_00 = (0, 0, 0);
  }

  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  if(!common_scripts\utility::func_562E(var_07.var_565F)) {
    var_07 method_838F(param_00, param_01);
    var_07 method_83D6(0);
  }

  if(isDefined(param_02)) {
    maps\mp\agents\_agent_utility::func_83FE(param_02.var_1A7, param_02);
  }

  var_07.var_FB = 100;
  var_07.var_BC = var_07.var_FB;
  var_07.var_109 = "Agent";
  var_07.var_565F = 1;
  var_07.var_4B60 = 0;
  var_07 thread agent_think();
}

agent_think() {
  var_00 = self;
  thread player_spawn_helper(var_00);
}

agent_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  func_0A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_0A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  maps\mp\agents\_agents::func_A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  if(self.var_BC <= 0) {
    agent_killed(param_00, param_01, param_02, param_04, param_05, param_07, param_08, param_09);
  }
}

agent_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_npc_kill", param_01, param_04, self, param_03, param_00);
  if(isDefined(level.var_6A75)) {
    [[level.var_6A75]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  if(self.var_565F) {
    self.var_4B60 = 1;
    var_09 = self method_85E2();
    if(isDefined(var_09)) {
      self method_80F4();
    }
  }
}

bot_spawnagents() {
  var_00 = "bomberEscortFighterAgents";
  level.var_A41[var_00] = [];
  level.var_A41[var_00]["spawn"] = ::agent_spawn;
  level.var_A41[var_00]["think"] = ::agent_think;
  level.var_A41[var_00]["on_killed"] = ::agent_killed;
  level.var_A41[var_00]["on_damaged"] = ::agent_damage;
  level.var_A41[var_00]["on_damaged_finished"] = ::func_0A40;
  var_01 = (0, 0, 0);
  var_02 = (0, 0, 0);
  var_03 = game["attackers"];
  if(!isDefined(level.bomberescortfighteragents)) {
    level.bomberescortfighteragents = [];
  }

  var_04 = 3;
  foreach(var_06 in level.bomberescortfighteragents) {
    if(var_06.var_565F && var_06.var_4B60) {
      var_06 thread agent_spawn();
      var_04--;
    }
  }

  for(var_08 = 0; var_08 < var_04; var_08++) {
    level.bomberescortfighteragents[level.bomberescortfighteragents.size] = [[level.var_A4D]](var_00, var_03, undefined, var_01, var_02, self, 0, 0, "recruit");
  }
}

b17watchturretswitch(param_00) {
  self endon("death");
  self notifyonplayercommand("cycle_turret_clockwise", "+actionslot 2");
  self notifyonplayercommand("cycle_turret_counter", "+actionslot 1");
  for(;;) {
    var_01 = common_scripts\utility::func_A715("cycle_turret_clockwise", "cycle_turret_counter");
    thread b17switchturret(param_00, var_01);
    wait 0.05;
  }
}

b17watchturretswitchdirect(param_00) {
  self endon("death");
  if(isbot(self)) {
    childthread bot_turretswitchthink();
  } else if(isPlayer(self)) {
    self notifyonplayercommand("cycle_turret_top", "+actionslot 1");
    self notifyonplayercommand("cycle_turret_belly", "+actionslot 2");
    self notifyonplayercommand("cycle_turret_left", "+actionslot 3");
    self notifyonplayercommand("cycle_turret_right", "+actionslot 4");
  }

  for(;;) {
    var_01 = common_scripts\utility::func_A715("cycle_turret_top", "cycle_turret_belly", "cycle_turret_left", "cycle_turret_right");
    thread b17switchturretdirect(param_00, var_01);
    wait 0.05;
  }
}

b17watchturretswitchtoggle(param_00) {
  self endon("death");
  if(isbot(self)) {
    childthread bot_turretswitchthink();
  } else if(isPlayer(self)) {
    self notifyonplayercommand("toggle_bomber_turret", "+weapnext");
  }

  for(;;) {
    self waittill("toggle_bomber_turret");
    thread b17switchturrettoggle(param_00);
    wait 0.05;
  }
}

turret_switch_fade() {
  var_00 = newclienthudelem(self);
  var_00.maxsightdistsqrd = 0;
  var_00.var_1D7 = 0;
  var_00.var_C6 = "fullscreen";
  var_00.var_1CA = "fullscreen";
  var_00 setshader("black", 640, 480);
  var_00.var_18 = 0;
  var_00 fadeovertime(0.25);
  var_00.var_18 = 1;
  common_scripts\utility::func_A71B(0.25, "death");
  self notify("turret_switch");
  var_01 = var_00.var_18 * 0.25;
  var_00 fadeovertime(var_01);
  var_00.var_18 = 0;
  wait(var_01);
  var_00 destroy();
}

switch_to_turret(param_00, param_01) {
  self.b17 endon("death");
  param_00[self.currentturretindex].var_69A5 = 0;
  self.currentturretindex = param_01;
  self.currentturret = param_00[self.currentturretindex];
  b17_updateclientturretoccupants(self.b17);
  thread turret_switch_fade();
  self waittill("turret_switch");
  common_scripts\utility::func_615();
  self method_85E9();
  common_scripts\utility::func_601();
  self playerlinkto(self.b17, param_00[self.currentturretindex].turret_info[5], 1, param_00[self.currentturretindex].turret_info[1], param_00[self.currentturretindex].turret_info[0], param_00[self.currentturretindex].turret_info[2], param_00[self.currentturretindex].turret_info[3]);
  set_turret_user_nameplate(param_00[self.currentturretindex].var_378F);
  param_00[self.currentturretindex].var_378F useby(self);
  param_00[self.currentturretindex].var_69A5 = 1;
  wait 0.05;
}

b17switchturret(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  var_03 = self.currentturretindex;
  for(;;) {
    if(var_02 >= param_00.size) {
      return;
    }

    if(var_03 != self.currentturretindex && param_00[var_03].var_69A5 == 0) {
      break;
    } else if(param_01 == "cycle_turret_clockwise") {
      var_03++;
      if(var_03 >= param_00.size) {
        var_03 = 0;
      }
    } else {
      var_03--;
      if(var_03 < 0) {
        var_03 = param_00.size - 1;
      }
    }

    var_02++;
  }

  if(var_03 != self.currentturretindex) {
    switch_to_turret(param_00, var_03);
  }
}

b17switchturretdirect(param_00, param_01) {
  self endon("death");
  var_02 = self.currentturretindex;
  if(param_01 == "cycle_turret_top") {
    var_02 = 0;
  } else if(param_01 == "cycle_turret_belly") {
    var_02 = 1;
  } else if(param_01 == "cycle_turret_left") {
    var_02 = 2;
  } else if(param_01 == "cycle_turret_right") {
    var_02 = 3;
  }

  if(param_00[var_02].var_69A5) {
    return;
  }

  if(var_02 != self.currentturretindex) {
    switch_to_turret(param_00, var_02);
  }
}

b17switchturrettoggle(param_00) {
  self endon("death");
  var_01 = self.currentturretindex;
  if(var_01 == 0) {
    var_01 = 1;
  } else {
    var_01 = 0;
  }

  if(param_00[var_01].var_69A5) {
    return;
  }

  if(var_01 != self.currentturretindex) {
    switch_to_turret(param_00, var_01);
  }
}

clear_turret_user_nameplate() {
  self setclientowner(undefined);
}

set_turret_user_nameplate(param_00) {
  var_01 = self method_85E3();
  if(isDefined(var_01)) {
    var_01 clear_turret_user_nameplate();
  }

  param_00 setclientowner(self);
}