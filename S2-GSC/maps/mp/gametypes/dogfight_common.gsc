/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dogfight_common.gsc
*************************************************/

dogfightinit() {
  level.isdogfight = 1;
  if(!1) {
    level.var_5A74 = 1;
    level.var_5A6F = 0;
  }

  level.var_2FAB = 1;
  level.disabledivisionstats = 1;
  level.var_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  lib_02EF::rvn_audio_include_additional_soundtablefilenames("soundtables/mp_dogfight.csv");
}

ondogfightended() {
  level waittill("game_ended");
  dogfight_end();
}

ondogfightstart() {
  load_vfx();
  maps\mp\gametypes\dogfight_common_aud::init_dogfight_audio();
  if(1) {
    maps\mp\gametypes\dogfight_scorestreaks::init_dogfight_killstreaks();
  }

  if(!isDefined(level.dogfightalliesspawner)) {
    level.dogfightalliesspawner = "p47_attacker_dogfight";
  }

  if(!isDefined(level.dogfightaxisspawner)) {
    level.dogfightaxisspawner = "p47_defender_dogfight";
  }

  if(!isDefined(level.dogfightminimap)) {
    level.dogfightminimap = "compass_map_mp_dogfight_wb";
  }

  if(isDefined(level.dogfighthardboundary) && isDefined(level.dogfightsoftboundary)) {
    level.dogfighthardboundarystruct = common_scripts\utility::func_46B5(level.dogfighthardboundary, "targetname");
    level.dogfightsoftboundarystruct = common_scripts\utility::func_46B5(level.dogfightsoftboundary, "targetname");
  } else if(isDefined(level.dogfightcenter)) {
    if(function_0296(level.dogfightcenter)) {
      setup_boundaries_with_origin(level.dogfightcenter);
    } else {
      var_00 = common_scripts\utility::func_46B5(level.dogfightcenter, "targetname");
      setup_boundaries_with_origin(var_00.var_0116);
    }
  } else {
    setup_boundaries_with_origin((0, 0, 0));
  }

  if(isDefined(level.dogfightspawnmin) && isDefined(level.dogfightspawnmax)) {
    level.dogfightspawnminstruct = common_scripts\utility::func_46B5(level.dogfightspawnmin, "targetname");
    level.dogfightspawnmaxstruct = common_scripts\utility::func_46B5(level.dogfightspawnmax, "targetname");
  } else {
    setup_spawns_with_hard_boundary();
  }

  if(isDefined(level.dogfightformationspawn)) {
    level.dogfightformationspawnstruct = common_scripts\utility::func_46B5(level.dogfightformationspawn, "targetname");
  } else {
    setup_formation_spawn_struct();
  }

  if(!isDefined(level.dogfightformationspawnbaseyaw)) {
    level.dogfightformationspawnbaseyaw = 0;
  }

  if(!isDefined(level.dogfightformationspawnrandomyaw)) {
    level.dogfightformationspawnrandomyaw = 90;
  }

  var_01 = getdvarint("2043", 0);
  level.dogfighthealthscale = float(getdvarint("scr_player_maxhealth", 100)) / float(100);
  level.dogfighthealthregenscale = float(getdvarint("scr_player_healthregentime", 4)) / float(4);
  level.dogfightshowui = var_01 == 0;
  level.dogfightfriendlyfireenabled = getdvarint("scr_team_fftype", 0);
  if(function_0371()) {
    setDvar("fd_enable_fbw", !var_01);
  } else {
    setDvar("fd_enable_fbw", getdvarint("scr_enable_flybywire", 1));
  }

  func_31E6(get_dogfight_boundary_center(0), level.dogfightminimap);
  thread ondogfightended();
}

update_map_center(param_00) {
  level.var_5FEB = param_00;
  setmapcenter(level.var_5FEB);
}

setup_minimap(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = 0;
    var_03 = 0.5;
    var_02 = get_dogfight_boundary_radius(0);
    var_04 = var_02 * var_03;
    var_05 = var_02 + var_04;
    var_06 = getEntArray("minimap_corner", "targetname");
    var_07 = param_00[0] - var_05;
    var_08 = param_00[1] - var_05;
    var_09 = var_05 + param_00[0];
    var_0A = var_05 + param_00[1];
    var_06[0].var_0116 = (var_07, var_08, param_00[2]);
    var_06[1].var_0116 = (var_09, var_0A, param_00[2]);
    maps\mp\_compass::func_8A2F(param_01);
  }
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
}

get_formation_spawn_info_with_angle(param_00) {
  var_01 = level.dogfightformationspawnstruct.var_0116 + (0, 0, level.dogfightformationspawnstruct.var_00BD * 0.5);
  var_02 = (0, param_00, 0);
  var_03 = (1, 0, 0);
  var_04 = rotatevector(var_03, var_02);
  var_05 = level.dogfightformationspawnstruct.var_014F;
  var_06 = (var_04[0] * var_05, var_04[1] * var_05, var_04[2] * var_05);
  var_07 = var_01 + var_06;
  var_08 = vectortoangles(var_01 - var_07);
  var_09 = var_01 - var_06;
  var_0A = vectortoangles(var_01 - var_09);
  return [var_07, var_08, var_09, var_0A];
}

configure_formation_spawn() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = 0;
  var_05 = 0;
  var_06 = level.dogfightformationspawnbaseyaw;
  for(var_07 = 0; var_07 < 5; var_07++) {
    if(level.dogfightformationspawnrandomyaw > 0) {
      var_06 = level.dogfightformationspawnbaseyaw + randomfloatrange(-1 * level.dogfightformationspawnrandomyaw, level.dogfightformationspawnrandomyaw);
    }

    var_08 = get_formation_spawn_info_with_angle(var_06);
    var_00 = var_08[0];
    var_01 = var_08[1];
    var_02 = var_08[2];
    var_03 = var_08[3];
    var_04 = is_spawn_valid(var_00, var_01, 0);
    var_05 = is_spawn_valid(var_02, var_03, 0);
    if(var_04 && var_05) {
      break;
    }
  }

  level.defender_formation_reference_org = var_00;
  level.defender_formation_reference_angles = var_01;
  level.attacker_formation_reference_org = var_02;
  level.attacker_formation_reference_angles = var_03;
  var_09 = (0, var_06, 0);
  level.formation_nodes_offset[0] = (0, 0, 0);
  for(var_07 = 1; var_07 < 9; var_07++) {
    var_0A = level.formation_nodes[var_07].var_0116 - level.formation_nodes[0].var_0116;
    level.formation_nodes_offset[var_07] = rotatevector(var_0A, var_09);
  }
}

ongameend() {
  level waittill("game_ended");
  function_03C6(0, 2, 3, 1);
  foreach(var_01 in level.var_744A) {
    var_01 setclientdvars("ui_raid_hide_fighter", "1");
    var_01.firstfighterspawn = undefined;
    var_01 dogfighthideboundaryoverlay();
    var_01 maps\mp\_utility::func_3E8E(1);
  }
}

ongameexit() {
  level waittill("exitLevel_called");
  function_03C6(100, 187.5, 284.09, 143.75);
  setDvar("1145", 1);
}

monitordogfightafk() {
  level endon("game_ended");
  self endon("disconnect");
  maps\mp\_utility::func_3FA5("prematch_done");
  self.lastinputtime = gettime();
  wait 0.05;
  for(;;) {
    if(!isDefined(self.var_260C) && self.var_260C) {
      var_00 = self method_86D4();
      var_01 = self method_86D5();
      var_02 = var_00[0] != 0 || var_00[1] != 0 || var_01[0] != 0 || var_01[1] != 0;
      if(self attackButtonPressed() || self adsButtonPressed() || var_02) {
        self.lastinputtime = gettime();
      } else if(gettime() - self.lastinputtime >= 75000) {
        kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
        level thread maps\mp\gametypes\_gamelogic::func_A11E();
      }
    }

    wait 0.05;
  }
}

func_6B6C() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 setscriptmotionblurparams(1.5, 0, 1);
    var_00.fighterspawningfunc = ::get_random_spawn_origin_angles;
    var_00 thread monitordogfightafk();
  }
}

onteamswitch(param_00) {
  self notify("end_p47_switch_team_watcher");
  self endon("end_p47_switch_team_watcher");
  var_01 = self;
  var_02 = var_01.var_01A7;
  var_03 = var_01 common_scripts\utility::func_A716("joined_team", "joined_spectators", "disconnect");
  if(var_03 == "joined_team" || var_03 == "joined_spectators") {
    var_02 = var_01.var_01A7;
  }

  var_04 = game["defenders"];
  if(var_02 == game["defenders"]) {
    var_04 = game["attackers"];
  }

  foreach(var_06 in level.var_744A) {
    var_07 = var_06 method_85E2();
    if(var_06.var_01A7 == var_04 && isDefined(param_00)) {
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
    var_01 setclientdvars("ui_raid_hide_fighter", "1");
  }
}

onhostmigrationend() {
  level waittill("host_migration_end");
  if(isDefined(level.var_744A)) {
    foreach(var_01 in level.var_744A) {
      if(isalive(var_01)) {
        if(!isDefined(var_01.occupied_plane)) {
          dogfight_kill_player(var_01, (0, 0, 0));
          continue;
        }

        if(1) {
          var_01.occupied_plane spawn_fighter_vfx_states();
        }
      }
    }
  }

  function_03C6(100, 187.5, 284.09, 143.75);
}

onhostmigration(param_00) {
  level endon("game_ended");
  for(;;) {
    level waittill("host_migration_begin");
    function_03C6(0, 2, 3, 1);
    level thread onhostmigrationend();
    bomber_set_dvars();
    update_map_center(param_00);
    func_89D5();
    if(isDefined(level.var_744A)) {
      foreach(var_02 in level.var_744A) {
        if(isalive(var_02)) {
          if(level.dogfightshowui) {
            var_02 setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");
          }

          var_02 thread watch_boundary(var_02.occupied_plane);
          var_02 thread func_4A35();
          if(level.var_984D) {
            var_02 thread onteamswitch(var_02.occupied_plane);
          }

          var_02.occupied_plane thread watch_fighter_collision();
          if(isbot(var_02) || function_01EF(var_02)) {
            var_02 thread bot_planeflythink(var_02.occupied_plane);
          }

          if(1) {
            if(!isDefined(var_02.onhostmigrationbeginfunc)) {
              var_02.onhostmigrationbeginfunc = ::onhostmigrationbegin;
            }
          }
        }
      }
    }

    var_04 = maps\mp\gametypes\_hostmigration::func_A782();
  }
}

bomber_set_dvars() {
  setdvarifuninitialized("allies_spawn_fighters", 1);
  setDvar("1145", 3);
  setDvar("4350", 1);
  setDvar("bot_FlightDynamicsModeEnabled", 1);
  setDvar("bg_turretIgnoreAttachedEnt", 0);
  setDvar("1979", 0);
  setdvarifuninitialized("p47_maxhealth", 240 * level.dogfighthealthscale);
  setdvarifuninitialized("fighter_firing_mode", 0);
}

bomber_reset_dvars() {
  setDvar("4350", 0);
  setDvar("bot_FlightDynamicsModeEnabled", 0);
  setDvar("bg_turretIgnoreAttachedEnt", 1);
  setDvar("1979", 1);
}

fighter_set_perks(param_00) {
  param_00 maps\mp\_utility::func_05E4();
}

dogfight_kill_player(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 setclientdvar("ui_raid_hide_fighter", 1);
  param_00 setdemigod(0);
  param_00 dodamage(99999, param_01, param_02, param_03, param_04, param_05, param_06);
}

dogfight_prematch_wait(param_00, param_01) {
  level endon("game_ended");
  maps\mp\_utility::func_3FA5("prematch_done");
  if(isDefined(level.var_744A)) {
    foreach(var_03 in level.var_744A) {
      if(isDefined(var_03)) {
        var_03 maps\mp\_utility::func_3E8E(0);
        var_03.ignoreboundary = 0;
      }
    }
  }

  if(isDefined(param_01)) {
    wait(0.5);
    setup_minimap(param_00, param_01);
  }
}

dogfight_wait_for_match_timer(param_00, param_01) {
  level endon("game_ended");
  function_03C6(0, 2, 3, 1);
  level waittill("match_start_timer_beginning");
  setup_minimap(param_00, param_01);
  wait(level.var_7692 - 3);
  function_03C6(100, 187.5, 284.09, 143.75);
}

func_31E6(param_00, param_01) {
  validate_boundaries();
  level.prevdisabledivisionskills = level.disabledivisionskills;
  level.disabledivisionskills = 1;
  level.prevdisabledivisionpassives = level.disabledivisionpassives;
  level.disabledivisionpassives = 1;
  level.var_4C1E = 1;
  level.flak_in_progress = 0;
  level.flak_scorestreak_id = 0;
  level.fighters_in_progress = 0;
  level.disableplayerdamageimpactfx = 1;
  if(level.var_984D) {
    level.defender_formation_index = 0;
    level.attacker_formation_index = 0;
    level.defender_spawn_angles = (0, 0, 0);
    level.attacker_spawn_angles = (0, 0, 0);
    level.defender_formation_reference_org = (0, 0, 0);
    level.attacker_formation_reference_org = (0, 0, 0);
    level.formation_nodes = [];
    level.formation_nodes_offset = [];
  }

  setDvar("fd_pause_update", 0);
  if(level.var_7691 > 0) {
    thread dogfight_wait_for_match_timer(param_00, param_01);
    thread dogfight_prematch_wait();
  } else {
    thread dogfight_prematch_wait(param_00, param_01);
  }

  level thread onhostmigration(param_00);
  bomber_set_dvars();
  foreach(var_03 in level.var_744A) {
    var_03.fighterspawningfunc = ::get_random_spawn_origin_angles;
  }

  level.old_customplaydamagesound = level.var_297F;
  level.var_297F = ::plane_damage_sound_callback;
  level.nobotscorestreaks = 1;
  level.var_5A77 = 0;
  level.var_6465["velocityscaler"] = 1.5;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0.75;
  level.bot_spawnagents_func = ::bot_spawnagents;
  if(isDefined(level.var_744A)) {
    foreach(var_03 in level.var_744A) {
      if(isDefined(var_03)) {
        var_03 setscriptmotionblurparams(1.5, 0, 1);
      }
    }
  }

  spawner_fog_enable();
  func_89D5();
  update_map_center(param_00);
  if(level.var_984D) {
    load_formation_nodes();
    configure_formation_spawn();
  }

  func_1E8D();
  level.var_17EF = 0;
  level.pp_array = [];
  thread func_6B6C();
  thread watch_for_player_spawn();
  thread ongameend();
  thread ongameexit();
}

dogfight_end() {
  bomber_reset_dvars();
  foreach(var_01 in level.var_744A) {
    var_01.fighterspawningfunc = undefined;
  }

  level.var_297F = level.old_customplaydamagesound;
  level.var_4C1E = 0;
  level.nobotscorestreaks = 0;
  level.var_5A77 = 5000;
  level.disabledivisionskills = level.prevdisabledivisionskills;
  level.disabledivisionpassives = level.prevdisabledivisionpassives;
  level.disableplayerdamageimpactfx = undefined;
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
    } else {
      self.forcenodeathanim = 1;
      self dodamage(getdvarint("p47_maxhealth") + 1, var_03, var_02);
    }

    wait 0.05;
  }
}

func_1E8D() {
  level.var_28D8 = "original";
  level.var_1E8C = [];
  level.var_1E8C["original"] = spawnStruct();
  level.var_1E8C["original"].var_9164 = 65;
  level.var_1E8C["original"].var_0A10 = 45;
}

precache_anims() {
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_left");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_right");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_up");
  precachempanim("mp_raids_husky_usa_thunderbolt_crash_nose_dive");
  precachempanim("mp_raids_husky_usa_thunderbolt_graveyard_spiral_down");
}

load_vfx() {
  level.var_0611["fighter_dmg_low_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_start");
  level.var_0611["fighter_dmg_med_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_med_start");
  level.var_0611["fighter_dmg_hvy_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_hvy_start");
  level.var_0611["fighter_dmg_low_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_whitsmk");
  level.var_0611["fighter_dmg_medium_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_smk");
  level.var_0611["fighter_dmg_high_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_firesmk");
  level.var_0611["fighter_dmg_high_stop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_stop");
  if(1) {
    level.var_0611["flak_gun_explosion"] = loadfx("vfx/scorestreaks/ss_flak_explosion_dlc2");
  }

  level.var_0611["mp_raid_bomber_throttle_fighter"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_throttle_fighter");
  level.var_0611["husky_p47_out_flak"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_out_flak");
  level.var_0611["mp_husky_fighter_wing_smk_sml"] = loadfx("vfx/map/mp_raid_husky_dlc2/mp_husky_fighter_wing_smk_sml");
  level.var_0611["smoketrail_aircraft_damage_7"] = loadfx("vfx/trail/smoketrail_aircraft_damage_7");
  level.var_0611["smoketrail_aircraft_damage_6"] = loadfx("vfx/trail/smoketrail_aircraft_damage_6");
  level.var_0611["smoketrail_aircraft_damage_5"] = loadfx("vfx/trail/smoketrail_aircraft_damage_5");
  level.var_0611["husky_p47_contrail_ext_vel_b"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_contrail_ext_vel_b");
  level.var_0611["husky_p47_contrail_ext_vel"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_contrail_ext_vel");
  level.var_0611["mp_husky_fighter_blk_smk"] = loadfx("vfx/map/mp_raid_husky_dlc2/mp_husky_fighter_blk_smk");
  level.var_0611["mp_raid_fighter_bounds_death"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_bounds_death");
  level.var_0611["husky_fighter_cockpit_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_cockpit_01");
  level.var_0611["husky_plane_damage_trails"] = loadfx("vfx/trail/husky_plane_damage_trails");
  level.var_0611["smoketrail_aircraft_damage_3"] = loadfx("vfx/trail/smoketrail_aircraft_damage_3");
  level.var_0611["smoketrail_aircraft_damage_2"] = loadfx("vfx/trail/smoketrail_aircraft_damage_2");
  level.var_0611["husky_smoketrail_damage_1"] = loadfx("vfx/map/mp_raid_bomber/husky_smoketrail_damage_1");
  level.var_0611["husky_smoketrail_aircraft_damage_1"] = loadfx("vfx/map/mp_raid_bomber/husky_smoketrail_aircraft_damage_1");
  level.var_0611["mp_raid_bomber_speedup"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_speedup");
  level.var_0611["husky_fighter_fire_trail_03"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_trail_03");
  level.var_0611["husky_fighter_fire_spurt_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_spurt_01");
  level.var_0611["husky_fighter_explosion_small_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_small_01");
  level.var_0611["mp_raid_bomber_flak_script_single"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_script_single");
  level.var_0611["mp_raid_p47_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_p47_wing_evap");
  level.var_0611["mp_raid_bf109_tracer"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bf109_tracer");
  level.var_0611["husky_fighter_explosion_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_01");
  level.var_0611["husky_fighter_explosion_death_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_death_01");
  level.var_0611["husky_fighter_fire_trail_02"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_trail_02");
  level.var_0611["mp_raid_bomber_flak_return_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_return_rnr");
  level.var_0611["mp_raid_bomber_flak_right_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_right_rnr");
  level.var_0611["mp_raid_bomber_flak_left_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_left_rnr");
  level.var_0611["mp_raid_fighter_spark_impact_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_spark_impact_rnr");
  level.var_0611["mp_raid_bomber_flak_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_rnr");
  level.var_0611["ss_fighter_plane_death"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
  level.var_0611["mp_raid_fighter_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_wing_evap");
  level.var_0611["mp_raid_fighter_mzlflash_single"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_mzlflash_single");
  level.var_0611["mp_raid_fighter_impacts_lrg"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_impacts_lrg");
  level.var_0611["mp_raid_bomber_aa_flak_runner"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_aa_flak_runner");
  level.var_0611["bulge_cam_wisps"] = loadfx("vfx/map/bulge/bulge_cam_wisps");
  level.var_0611["bulge_dogfight_moon"] = loadfx("vfx/map/bulge/bulge_dogfight_moon");
  level.var_0611["bulge_dogfight_blur"] = loadfx("vfx/map/bulge/bulge_dogfight_blur");
  level.var_0611["flak_dogfight"] = loadfx("vfx/map/bulge/bulge_flak_explosion_near");
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

spawn_client_fighter_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    playfxontagforclients(level.var_0611["mp_raid_bomber_throttle_fighter"], param_00, "TAG_BODY", var_01);
  }
}

remove_client_fighter_fx(param_00) {
  var_01 = self;
  if(isPlayer(var_01) && !isbot(var_01)) {
    function_0294(level.var_0611["mp_raid_bomber_throttle_fighter"], param_00, "TAG_BODY", var_01);
  }
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
    if(function_0279(var_02) || var_02.var_00BC <= param_01 || common_scripts\utility::func_562E(level.match_ended)) {
      foreach(var_04 in self.vfx_obj_list) {
        if(!function_0279(var_04)) {
          var_04 delete();
        }
      }

      break;
    }

    if(param_00.var_088A) {
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
  param_00 = common_scripts\utility::func_0FA5(param_00, ::compare_health_threshold_frac);
  foreach(var_05 in param_00) {
    var_05.var_088A = 0;
    var_05.var_552B = 0;
    var_02 thread common_damage_state_fx_update_watcher(var_05, param_01);
  }

  var_02.damagevfxstates = param_00;
  for(;;) {
    var_07 = var_02.var_00BC / var_02.var_00FB;
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
      var_05.var_088A = var_08 == var_09;
    }

    var_02 waittill("health_update");
  }
}

fighter_get_crash_animation(param_00, param_01) {
  var_02 = undefined;
  if(!1) {
    return var_02;
  }

  var_03 = get_dogfight_boundary_center(0);
  var_04 = get_dogfight_boundary_height(0) * 0.5;
  var_05 = var_03[2] - var_04;
  var_06 = var_03[2] + var_04;
  var_07 = ["mp_raids_husky_usa_thunderbolt_crash_right", "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down", "mp_raids_husky_usa_thunderbolt_crash_left", "mp_raids_husky_usa_thunderbolt_crash_nose_dive"];
  var_08 = [];
  foreach(var_0A in var_07) {
    var_0B = getmovedelta(fighter_get_crash_anim_ref(var_0A), 0, 1);
    var_0C = rotatevector(var_0B, param_00.var_001D);
    var_0D = param_01 + var_0C;
    var_0E = var_0D[2] >= var_05;
    var_0F = var_0D[2] <= var_06;
    var_10 = get_dogfight_boundary_radius(0);
    var_11 = var_10 * var_10;
    var_12 = distance2dsquared(var_0D, var_03) <= var_11;
    var_13 = 1;
    var_14 = 0.25;
    var_15 = param_01;
    for(var_16 = 1; var_16 <= 4; var_16++) {
      var_0B = getmovedelta(fighter_get_crash_anim_ref(var_0A), 0, var_16 * var_14);
      var_0C = rotatevector(var_0B, param_00.var_001D);
      var_17 = param_01 + var_0C;
      var_18 = bulletTrace(var_15, var_17, 0, param_00, 0, 0, 1, 1, 0, 0, 0);
      var_13 = var_13 && var_18["fraction"] == 1;
      if(!var_13) {
        break;
      }

      var_15 = var_17;
    }

    if(var_0E && var_0F && var_12 && var_13) {
      var_08[var_08.size] = var_0A;
    }
  }

  if(var_08.size > 0) {
    var_02 = common_scripts\utility::func_7A33(var_08);
  } else {
    var_02 = "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down";
    param_00.forcenodeathanim = 1;
  }

  return var_02;
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

fighter_death_anim_wait(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    var_01 endon("vehicle_dismount");
    param_00 waittillmatch("end", "fighter_anim_notetrack");
    return;
  }

  var_01 waittill("vehicle_dismount");
}

add_target_icon(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isPlayer(param_00)) {
    return;
  }

  var_06 = self;
  var_07 = param_00.var_002B;
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

  if(!isDefined(self) || !isalive(param_00) || var_06 != self || var_07 != param_00.var_002B || isDefined(self.var_01C8) && !fighter_is_alive()) {
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
}

clearagenticonsforplayer() {
  if(isDefined(level.var_0A4E)) {
    foreach(var_01 in level.var_0A4E) {
      var_02 = var_01 method_85E2();
      if(isDefined(var_02)) {
        var_02 thread remove_target_on_death(self);
      }
    }
  }
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
    if(level.dogfightshowui) {
      self setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");
    }

    if(maps\mp\_utility::func_3FA0("prematch_done")) {
      maps\mp\_utility::func_3E8E(0);
    }
  }

  if(maps\mp\_utility::func_3FA0("prematch_done")) {
    self.ignoreboundary = 0;
  }
}

dogfightshowboundaryoverlay() {
  if(isDefined(self.var_1B68)) {
    self notify("cancelBoundaryOverlayHide");
  } else {
    self.var_1B68 = newclienthudelem(self);
    self.var_1B68.var_01D3 = 0;
    self.var_1B68.var_01D7 = 0;
    self.var_1B68.var_0184 = -5;
    self.var_1B68.var_00C6 = "fullscreen";
    self.var_1B68.var_01CA = "fullscreen";
    self.var_1B68 setshader("overlay_raid_boundary", 640, 480);
    self.var_1B68.var_00C2 = 1;
    self.var_1B68.var_0180 = 0;
    self.var_1B68.var_0018 = 0;
  }

  if(1) {
    self.var_1B68 fadeovertime(0.15);
  }

  self.var_1B68.var_0018 = 0.3;
}

dogfightshowboundarywarning() {
  self endon("death");
  self endon("disconnect");
  self setclientomnvar("ui_raid_boundary_type", 0);
  wait(0.15);
  self setclientomnvar("ui_raid_boundary_type", 3);
}

dogfighthideboundaryoverlay() {
  self endon("death");
  self endon("disconnect");
  self endon("cancelBoundaryOverlayHide");
  self notify("boundaryOverlayHide");
  if(!isDefined(self.var_1B68)) {
    return;
  }

  if(1) {
    self.var_1B68 fadeovertime(0.15);
    wait(0.15);
  }

  self.var_1B68.var_0018 = 0;
  self.var_1B68 destroy();
}

dogfighthideboundarywarning() {
  self setclientomnvar("ui_raid_boundary_type", -1);
}

dogfightwatchboundaryoverlay(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("boundaryOverlayHide");
  if(!isDefined(self.var_1B68)) {
    return;
  }

  for(;;) {
    var_01 = param_00 get_plane_vertical_soft_boundary_percent();
    var_02 = param_00 get_plane_horizontal_soft_boundary_percent();
    self.var_1B68.var_0018 = clamp(0.3 + max(var_01, var_02), 0, 1);
    wait 0.05;
  }
}

func_A334() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("vehicle_mount", var_00);
    if(isDefined(var_00) && isDefined(var_00.var_01A7)) {
      common_scripts\utility::func_5FA9(var_00.var_01A7);
    }
  }
}

func_A333() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("vehicle_dismount", var_00);
    self freeentitysentient();
  }
}

mountvehiclesafe(param_00) {
  if(isDefined(self.var_0117)) {
    self setentityowner(undefined);
  }

  self method_80F3(param_00);
}

createvehicleinternal(param_00, param_01, param_02) {
  var_03 = param_00.var_01A5;
  if(!isDefined(var_03)) {
    var_03 = "UNDEFINED";
  }

  var_04 = undefined;
  if(common_scripts\utility::func_562E(param_00.use_original_classname)) {
    var_04 = param_00 method_8225();
  } else if(isDefined(param_02) && isPlayer(param_02)) {
    var_04 = function_01E0(param_00.var_0106, var_03, param_00.var_01C8, param_00.var_0116, param_00.var_001D, param_02);
  } else {
    var_04 = function_01E0(param_00.var_0106, var_03, param_00.var_01C8, param_00.var_0116, param_00.var_001D);
  }

  var_04.var_01C8 = param_00.var_01C8;
  var_04.var_00FB = 9000;
  var_04.var_00BC = 9000;
  var_04.var_006A = 0;
  var_04 setCanDamage(0);
  if(isDefined(param_01)) {
    var_04 method_8253(param_01);
    var_04.var_01A7 = param_01;
  } else {
    var_04 method_8253("axis");
    var_04.var_01A7 = "axis";
  }

  var_04 thread func_A334();
  var_04 thread func_A333();
  var_04 makeusable();
  if(var_04.var_01A7 == "axis") {
    if(!isDefined(level.var_148E)) {
      level.var_148E = [];
    }

    level.var_148E = common_scripts\utility::func_0F6F(level.var_148E, var_04);
  }

  return var_04;
}

cleanup_all_turrets() {
  level.match_ended = 1;
  if(isDefined(level.pp_array)) {
    foreach(var_01 in level.pp_array) {
      if(isDefined(var_01)) {
        var_01 notify("match_end");
        var_01 vehicle_scripts\_fighter_mp::destroyturrets();
      }
    }
  }
}

func_4A31(param_00, param_01) {
  self notify("handle_p47_50cals");
  self endon("handle_p47_50cals");
  self endon("death");
  param_01 endon("death");
  lib_0378::func_8D74("p47_turret_plr");
  var_02 = 0;
  var_03 = randomintrange(20, 40);
  var_04 = var_03 + randomintrange(10, 20);
  var_05 = [];
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
            param_01 method_8322();
          }
        }
      }
    }

    if(!var_13) {
      if(1) {
        if(self.var_2651) {
          var_0A = var_0A - var_12 * var_08;
          if(var_0A <= 0) {
            var_0A = 0;
            self.var_2651 = 0;
            param_01 method_8323();
          }
        } else {
          var_0A = max(var_0A - var_12 * var_09, 0);
        }
      }
    }

    var_14 = 0;
    if(var_13) {
      var_14 = randomfloatrange(0.0025, 0.005) * common_scripts\utility::func_98E7(common_scripts\utility::func_24A6(), 1, -1);
    }

    if(1) {
      var_15 = clamp(var_0A / var_07 + var_14, 0, 1);
      param_01 setclientomnvar("ui_raid_vehicle_overheat_percent", var_15);
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
  var_01 = level.var_1E8C[self.var_28D8].var_0A10 / var_00;
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
      var_01 = level.var_1E8C[self.var_28D8].var_0A10 / var_00;
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

delete_plane(param_00) {
  if(isDefined(param_00)) {
    level.pp_array = common_scripts\utility::func_0F93(level.pp_array, param_00);
    param_00 notify("health_update");
    param_00 vehicle_scripts\_fighter_mp::destroyturrets();
    param_00 delete();
  }
}

setup_spawns_with_hard_boundary() {
  if(!isDefined(level.dogfightspawnminstruct)) {
    level.dogfightspawnminstruct = spawnStruct();
  }

  level.dogfightspawnminstruct.var_00BD = 14000;
  level.dogfightspawnminstruct.var_014F = 20500;
  var_00 = level.dogfighthardboundarystruct.var_00BD - level.dogfightspawnminstruct.var_00BD;
  level.dogfightspawnminstruct.var_0116 = level.dogfighthardboundarystruct.var_0116 + (0, 0, var_00 * 0.5);
  if(!isDefined(level.dogfightspawnmaxstruct)) {
    level.dogfightspawnmaxstruct = spawnStruct();
  }

  level.dogfightspawnmaxstruct.var_00BD = 14000;
  level.dogfightspawnmaxstruct.var_014F = 21000;
  var_00 = level.dogfighthardboundarystruct.var_00BD - level.dogfightspawnmaxstruct.var_00BD;
  level.dogfightspawnmaxstruct.var_0116 = level.dogfighthardboundarystruct.var_0116 + (0, 0, var_00 * 0.5);
}

get_spawn_center() {
  return level.dogfightspawnmaxstruct.var_0116 + (0, 0, level.dogfightspawnmaxstruct.var_00BD * 0.5);
}

get_spawn_radius(param_00) {
  var_01 = undefined;
  if(param_00) {
    var_01 = level.dogfightspawnminstruct.var_014F;
  } else {
    var_01 = level.dogfightspawnmaxstruct.var_014F;
  }

  return var_01;
}

get_spawn_height(param_00) {
  var_01 = undefined;
  if(param_00) {
    var_01 = level.dogfightspawnminstruct.var_00BD;
  } else {
    var_01 = level.dogfightspawnmaxstruct.var_00BD;
  }

  return var_01;
}

setup_formation_spawn_struct() {
  if(!isDefined(level.dogfightformationspawnstruct)) {
    level.dogfightformationspawnstruct = spawnStruct();
  }

  var_00 = get_dogfight_boundary_center(0);
  level.dogfightformationspawnstruct.var_0116 = var_00 - (0, 0, 50);
  level.dogfightformationspawnstruct.var_00BD = 100;
  level.dogfightformationspawnstruct.var_014F = 23000;
}

random_point_on_cylinder(param_00, param_01) {
  var_02 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  var_03 = param_00 + param_01 * var_02;
  var_04 = get_spawn_height(0) * 0.5;
  var_03 = var_03 + (0, 0, randomfloatrange(var_04 * -1, var_04));
  return var_03;
}

get_formation_spawn_origin_angles(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = (0, 0, 0);
  if(level.dogfightformationspawnstruct.var_00BD > 0) {
    var_04 = level.dogfightformationspawnstruct.var_00BD * 0.5;
    var_03 = (0, 0, randomfloatrange(-1 * var_04, var_04));
  }

  if(param_00 == game["defenders"]) {
    var_05 = level.formation_nodes_offset[level.defender_formation_index];
    var_01 = level.defender_formation_reference_org + var_05 + var_03;
    var_02 = level.defender_formation_reference_angles;
    level.defender_formation_index++;
    if(level.defender_formation_index >= 9) {
      level.defender_formation_index = 0;
    }
  } else {
    var_05 = level.formation_nodes_offset[level.attacker_formation_index];
    var_01 = level.attacker_formation_reference_org - var_05 + var_03;
    var_02 = level.attacker_formation_reference_angles;
    level.attacker_formation_index++;
    if(level.attacker_formation_index >= 9) {
      level.attacker_formation_index = 0;
    }
  }

  return [var_01, var_02];
}

is_spawn_targeted(param_00) {
  foreach(var_02 in level.var_744A) {
    if(!isDefined(var_02) || !maps\mp\_utility::func_57A0(var_02)) {
      continue;
    }

    if(var_02 == self || level.var_984D && var_02.var_01A7 == self.var_01A7) {
      continue;
    }

    if(distancesquared(param_00, var_02.var_0116) < 20250000) {
      return 1;
    }

    var_03 = param_00 - var_02.var_0116;
    var_04 = anglesToForward(var_02.occupied_plane.var_001D);
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

    if(bullettracepassed(param_00, var_02.var_0116, 0, self)) {
      return 1;
    }
  }

  return 0;
}

is_spawn_valid(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = anglesToForward(param_01);
  var_05 = (var_04[0] * 2000, var_04[1] * 2000, var_04[2] * 2000);
  var_06 = param_00 + var_05;
  var_07 = bulletTrace(param_00, var_06, 0, undefined, 0, 0, 1, 1, 0, 0, 0);
  var_03 = var_07["fraction"] == 1;
  if(common_scripts\utility::func_562E(param_02)) {
    var_03 = var_03 && !is_spawn_targeted(param_00);
  }

  return var_03;
}

get_random_spawn_origin_angles() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = get_spawn_center();
  var_04 = randomfloatrange(get_spawn_radius(1), get_spawn_radius(0));
  for(var_05 = 0; var_05 < 5; var_05++) {
    var_01 = random_point_on_cylinder(var_03, var_04);
    var_06 = var_03 - var_01;
    var_02 = vectortoangles(var_06);
    var_02 = (0, var_02[1], 0);
    if(var_02[1] == 180) {
      var_02 = (var_02[0], var_02[1] + 0.1, var_02[2]);
    }

    var_02 = (angleclamp180(var_02[0]), angleclamp180(var_02[1]), angleclamp180(var_02[2]));
    var_00 = is_spawn_valid(var_01, var_02, 1);
    if(var_00) {
      break;
    }
  }

  return [var_01, var_02];
}

player_spawn_helper(param_00) {
  var_01 = 1;
  param_00 setdemigod(1);
  param_00 method_805C();
  param_00 setclientdvar("cg_altimeterRange", get_dogfight_boundary_height(0));
  var_02 = get_dogfight_boundary_center(0);
  param_00 setclientdvar("cg_altimeterCenter", var_02[2]);
  param_00.var_4D13 = 1;
  if(isbot(param_00) || function_01EF(param_00)) {
    param_00.var_0100 = 576000000;
  }

  thread spawn_fighter(param_00);
  if(isPlayer(param_00) && !isbot(param_00)) {
    param_00 maps\mp\gametypes\_class::func_4773(param_00.var_01A7, param_00.var_2319);
    fighter_set_perks(param_00);
    if(1) {
      thread maps\mp\gametypes\dogfight_scorestreaks::fighter_scorestreak_watcher(param_00);
    }
  }

  param_00 setclientomnvar("ui_raid_vehicle_health_percent", var_01);
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

spawner_fog_enable() {
  var_00 = getent(level.dogfightalliesspawner, "targetname");
  var_00 method_8400();
  if(level.var_984D) {
    var_01 = getent(level.dogfightaxisspawner, "targetname");
    var_01 method_8400();
  }
}

get_spawner(param_00) {
  var_01 = undefined;
  if(!isDefined(level.attacker_pp_spawner)) {
    level.attacker_pp_spawner = getent(level.dogfightalliesspawner, "targetname");
  }

  if(!isDefined(level.defender_pp_spawner)) {
    level.defender_pp_spawner = getent(level.dogfightaxisspawner, "targetname");
  }

  var_01 = undefined;
  if(level.var_984D) {
    if(param_00 == game["attackers"]) {
      var_01 = level.attacker_pp_spawner;
    } else {
      var_01 = level.defender_pp_spawner;
    }
  } else {
    var_01 = level.attacker_pp_spawner;
  }

  return var_01;
}

get_turret_weapon_info(param_00) {
  var_01 = "turretweapon_usa_fighter_thunderbolt_player_mp";
  if(level.var_984D && param_00 == "axis") {
    var_01 = "turretweapon_ger_fighter_bf109_player_mp";
  }

  return var_01;
}

spawn_player_p47(param_00) {
  var_01 = get_spawner(param_00.var_01A7);
  var_02 = createvehicleinternal(var_01, param_00.var_01A7, param_00);
  var_02.var_01A7 = param_00.var_01A7;
  var_02 makeentitysentient(var_02.var_01A7);
  if(level.var_984D) {
    var_03 = undefined;
    if(var_02.var_01A7 == "allies") {
      var_03 = "group_allies";
    } else {
      var_03 = "group_axis";
    }

    var_02 setthreatbiasgroup(var_03);
    param_00 setthreatbiasgroup(var_03);
  }

  level.pp_array = common_scripts\utility::func_0F6F(level.pp_array, var_03);
  return var_03;
}

spawn_fighter(param_00) {
  var_01 = !maps\mp\_utility::func_3FA0("prematch_done") && level.var_984D;
  var_02 = undefined;
  if(var_01) {
    param_00 setclientdvar("vehCam_chaseFD_camStartMode", 1);
    var_02 = 5000;
  } else {
    param_00 setclientdvar("vehCam_chaseFD_camStartMode", 0);
    var_02 = 750;
  }

  param_00 setclientdvar("vehCam_chaseFD_camStartLerpDuration", var_02);
  param_00 fighter_ui_hide();
  if(var_01 && isbot(param_00)) {
    param_00 maps\mp\_utility::func_3E8E(0);
  }

  var_03 = spawn_player_p47(param_00);
  var_03.var_00FB = getdvarint("p47_maxhealth");
  var_03.var_00BC = var_03.var_00FB;
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
    param_00.var_00CE = 1;
    var_03.var_00CE = 1;
  }

  var_05 = undefined;
  if(var_01) {
    if(var_02 == 5000) {
      var_05 = var_02 + 500 / 1000;
    }

    var_06 = get_formation_spawn_origin_angles(param_00.var_01A7);
    var_04 = var_06[0];
    var_07 = var_06[1];
  } else if(isDefined(var_01.fighterspawnorigin) && isDefined(var_01.fighterspawnangles)) {
    var_05 = var_01.fighterspawnorigin;
    var_07 = var_01.fighterspawnangles;
  } else {
    var_08 = var_01 get_random_spawn_origin_angles();
    var_04 = var_08[0];
    var_07 = var_08[1];
  }

  if(var_07[1] == 180) {
    var_07 = (var_07[0], var_07[1] + 0.1, var_07[2]);
  }

  var_07 = (angleclamp180(var_07[0]), angleclamp180(var_07[1]), angleclamp180(var_07[2]));
  param_00 setangles(var_07);
  var_03 method_8279(var_04, var_07);
  if(function_01EF(param_00)) {
    param_00.var_0009 = &"RAIDS_DOGFIGHT_AGENTNAME";
    foreach(var_0A in level.var_744A) {
      if(!level.var_984D || var_0A.var_01A7 == common_scripts\utility::func_416F(param_00.var_000A)) {
        var_03 thread add_target_icon(var_0A, 0, 1, 0, undefined, var_05);
      }
    }
  }

  var_03 setclientowner(param_00);
  param_00 mountvehiclesafe(var_03);
  param_00 disableusability();
  var_0C = get_turret_weapon_info(param_00.var_01A7);
  var_03 vehicle_scripts\_fighter_mp::func_51FB(var_0C);
  var_03 thread func_4A31(1, param_00);
  var_03 lib_0378::func_8D74("aud_figher_spawn");
  param_00 thread func_4A35();
  param_00 thread watch_boundary(var_03);
  if(isbot(param_00) || function_01EF(param_00)) {
    if(var_01) {
      param_00.informationtransition = 1;
    }

    param_00 thread bot_planeflythink(var_03);
  }

  if(level.var_984D) {
    param_00 thread onteamswitch(var_03);
  }

  var_03 thread watch_fighter_collision();
  if(1) {
    var_03 spawn_fighter_vfx_states();
    if(!isDefined(param_00.onhostmigrationbeginfunc)) {
      param_00.onhostmigrationbeginfunc = ::onhostmigrationbegin;
    }
  }

  param_00 thread spawn_client_fighter_fx(var_03);
  if(isPlayer(param_00)) {
    foreach(var_0A in level.var_744A) {
      var_0E = var_0A method_85E2();
      if((!level.var_984D || var_0A.var_01A7 == common_scripts\utility::func_416F(param_00.var_01A7)) && isDefined(var_0E) && var_0E fighter_is_alive()) {
        var_0E thread add_target_icon(param_00, 0, 1, 0, undefined, var_05);
      }

      if(!level.var_984D || var_0A.var_01A7 == common_scripts\utility::func_416F(param_00.var_01A7)) {
        var_03 thread add_target_icon(var_0A, 0, 1, 0, undefined, var_05);
      }
    }

    if(isDefined(level.var_0A4E)) {
      foreach(var_11 in level.var_0A4E) {
        var_0E = var_11 method_85E2();
        if(isDefined(var_0E) && !level.var_984D || var_11.var_000A == common_scripts\utility::func_416F(param_00.var_01A7)) {
          var_0E thread add_target_icon(param_00, 0, 1, 0, undefined, var_05);
        }
      }
    }
  }

  var_03 thread show_plane();
  param_00 thread allow_controls_after_trans(var_03, var_02, var_01);
  param_00 dogfighthideboundaryoverlay();
  param_00 dogfighthideboundarywarning();
}

show_plane() {
  self endon("death");
  self endon("disconnect");
  wait(0.1);
  self method_805B();
}

watch_for_player_spawn() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    thread player_spawn_helper(var_00);
  }
}

set_boundary(param_00, param_01, param_02, param_03) {
  if(param_03) {
    if(!isDefined(level.dogfightsoftboundarystruct)) {
      level.dogfightsoftboundarystruct = spawnStruct();
    }

    level.dogfightsoftboundarystruct.var_0116 = param_00;
    level.dogfightsoftboundarystruct.var_014F = param_01;
    level.dogfightsoftboundarystruct.var_00BD = param_02;
    return;
  }

  if(!isDefined(level.dogfighthardboundarystruct)) {
    level.dogfighthardboundarystruct = spawnStruct();
  }

  level.dogfighthardboundarystruct.var_0116 = param_00;
  level.dogfighthardboundarystruct.var_014F = param_01;
  level.dogfighthardboundarystruct.var_00BD = param_02;
}

setup_boundaries_with_origin(param_00) {
  set_boundary(param_00, 27000, 28000, 0);
  var_01 = 8000;
  set_boundary(param_00 + (0, 0, var_01 * 0.5), 22000, 20000, 1);
}

validate_boundaries() {
  var_00 = level.dogfighthardboundarystruct.var_0116 + (0, 0, level.dogfighthardboundarystruct.var_00BD * 0.5);
  var_01 = level.dogfighthardboundarystruct.var_0116 + (level.dogfighthardboundarystruct.var_014F, 0, 0);
  var_02 = 1073676289;
  var_03 = level.dogfighthardboundarystruct.var_0116;
  var_04 = var_03 + (0, 0, level.dogfighthardboundarystruct.var_00BD);
  var_05 = level.dogfightsoftboundarystruct.var_0116;
  var_06 = var_05 + (0, 0, level.dogfightsoftboundarystruct.var_00BD);
  var_07 = level.dogfighthardboundarystruct.var_0116 + (0, 0, level.dogfighthardboundarystruct.var_00BD * 0.5);
  var_08 = level.dogfightsoftboundarystruct.var_0116 + (0, 0, level.dogfightsoftboundarystruct.var_00BD * 0.5);
  var_09 = 0.0001;
  var_0A = level.dogfightspawnminstruct.var_0116;
  var_0B = var_0A + (0, 0, level.dogfightspawnminstruct.var_00BD);
  var_0C = level.dogfightspawnmaxstruct.var_0116;
  var_0D = var_0C + (0, 0, level.dogfightspawnmaxstruct.var_00BD);
  var_0E = level.dogfightspawnminstruct.var_0116 + (0, 0, level.dogfightspawnminstruct.var_00BD * 0.5);
  var_0F = level.dogfightspawnmaxstruct.var_0116 + (0, 0, level.dogfightspawnmaxstruct.var_00BD * 0.5);
}

get_dogfight_boundary_radius(param_00) {
  var_01 = undefined;
  if(param_00) {
    var_01 = level.dogfightsoftboundarystruct.var_014F;
  } else {
    var_01 = level.dogfighthardboundarystruct.var_014F;
  }

  return var_01;
}

get_dogfight_boundary_height(param_00) {
  var_01 = undefined;
  if(param_00) {
    var_01 = level.dogfightsoftboundarystruct.var_00BD;
  } else {
    var_01 = level.dogfighthardboundarystruct.var_00BD;
  }

  return var_01;
}

get_dogfight_boundary_center(param_00) {
  var_01 = undefined;
  if(param_00) {
    var_01 = level.dogfighthardboundarystruct.var_0116 + (0, 0, level.dogfighthardboundarystruct.var_00BD * 0.5);
  } else {
    var_01 = level.dogfightsoftboundarystruct.var_0116 + (0, 0, level.dogfightsoftboundarystruct.var_00BD * 0.5);
  }

  return var_01;
}

is_plane_outside_soft_boundary_radius() {
  var_00 = 0;
  var_01 = distance2dsquared(self.var_0116, get_dogfight_boundary_center(1));
  var_02 = get_dogfight_boundary_radius(1);
  var_03 = var_02 * var_02;
  if(var_01 > var_03) {
    var_00 = 1;
  }

  return var_00;
}

is_plane_outside_soft_boundary_top() {
  var_00 = 0;
  var_01 = get_dogfight_boundary_center(1);
  var_02 = var_01[2] + get_dogfight_boundary_height(1) * 0.5;
  if(self.var_0116[2] > var_02) {
    var_00 = 1;
  }

  return var_00;
}

is_plane_outside_soft_boundary_bottom() {
  var_00 = 0;
  var_01 = get_dogfight_boundary_center(1);
  var_02 = var_01[2] - get_dogfight_boundary_height(1) * 0.5;
  if(self.var_0116[2] < var_02) {
    var_00 = 1;
  }

  return var_00;
}

get_plane_vertical_soft_boundary_percent() {
  var_00 = 0;
  if(is_plane_outside_soft_boundary_top() || is_plane_outside_soft_boundary_bottom()) {
    var_01 = get_dogfight_boundary_center(1);
    var_02 = abs(self.var_0116[2] - var_01[2]);
    var_03 = get_dogfight_boundary_height(1) * 0.5;
    var_04 = get_dogfight_boundary_height(0) * 0.5;
    var_00 = var_02 - var_03 / var_04 - var_03;
  }

  return var_00;
}

get_plane_horizontal_soft_boundary_percent() {
  var_00 = 0;
  if(is_plane_outside_soft_boundary_radius()) {
    var_01 = 0;
    var_02 = distance2dsquared(self.var_0116, get_dogfight_boundary_center(1));
    var_03 = get_dogfight_boundary_radius(1);
    var_04 = var_03 * var_03;
    var_05 = get_dogfight_boundary_radius(0);
    var_06 = var_05 * var_05;
    var_00 = var_02 - var_04 / var_06 - var_04;
  }

  return var_00;
}

is_plane_outside_soft_boundary() {
  return is_plane_outside_soft_boundary_top() || is_plane_outside_soft_boundary_bottom() || is_plane_outside_soft_boundary_radius();
}

is_plane_outside_hard_boundary() {
  var_00 = get_dogfight_boundary_center(1);
  var_01 = distance2dsquared(self.var_0116, var_00);
  var_02 = abs(self.var_0116[2] - var_00[2]);
  var_03 = get_dogfight_boundary_radius(0);
  var_04 = var_03 * var_03;
  if(var_01 >= var_04) {
    return 1;
  }

  if(var_02 >= get_dogfight_boundary_height(0) * 0.5) {
    return 1;
  }

  return 0;
}

play_boundary_flak() {
  var_00 = is_plane_outside_soft_boundary_radius() || is_plane_outside_soft_boundary_top();
  if(!isDefined(level.dogfightusebottomflak) || level.dogfightusebottomflak) {
    var_00 = var_00 && is_plane_outside_soft_boundary_bottom();
  }

  return var_00;
}

get_flak_fx_for_direction(param_00) {
  if(param_00 == "forward") {
    return level.var_0611["mp_raid_bomber_flak_rnr"];
  } else if(param_00 == "right") {
    return level.var_0611["mp_raid_bomber_flak_right_rnr"];
  } else if(param_00 == "left") {
    return level.var_0611["mp_raid_bomber_flak_left_rnr"];
  } else if(param_00 == "back") {
    return level.var_0611["mp_raid_bomber_flak_return_rnr"];
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

  var_01 = gettime();
  var_02 = undefined;
  var_03 = gettime();
  var_04 = undefined;
  var_05 = get_dogfight_boundary_center(0);
  if(param_00 is_plane_outside_hard_boundary() && !isDefined(level.var_4E09)) {}

  if(!common_scripts\utility::func_AA4A(param_00.var_0116, param_00.var_001D, var_05, cos(30)) && !isDefined(level.var_4E09)) {}

  for(;;) {
    if(common_scripts\utility::func_562E(self.ignoreboundary) || isDefined(level.var_4E09)) {
      wait 0.05;
      continue;
    }

    if(param_00 is_plane_outside_soft_boundary()) {
      var_06 = param_00 is_plane_outside_hard_boundary();
      var_07 = play_boundary_flak();
      if(!common_scripts\utility::func_562E(var_02)) {
        var_02 = 1;
        if(1) {
          dogfightshowboundaryoverlay();
          thread dogfightshowboundarywarning();
          thread dogfightwatchboundaryoverlay(param_00);
        }

        if(common_scripts\utility::func_562E(var_07)) {
          var_03 = gettime();
        }
      }

      if(common_scripts\utility::func_562E(var_07) && var_03 <= gettime()) {
        var_08 = vectornormalize(param_00.var_0116 - var_05);
        var_09 = vectornormalize(param_00.var_001D);
        var_0A = vectornormalize(rotatevectorinverted(var_08, param_00.var_001D));
        var_0B = function_01E3(var_0A[1], var_0A[0]);
        var_08 = undefined;
        if(var_0B < -45 && var_0B > -135) {
          var_08 = "right";
        } else if(var_0B > 45 && var_0B < 135) {
          var_08 = "left";
        } else if(var_0B >= -45 && var_0B <= 45) {
          var_08 = "forward";
        } else {
          var_08 = "back";
        }

        if(isDefined(var_04)) {
          stopFXOnTag(get_flak_fx_for_direction(var_04), param_00, "tag_origin");
        }

        playFXOnTag(get_flak_fx_for_direction(var_08), param_00, "tag_origin");
        var_04 = var_08;
        var_03 = gettime() + randomintrange(600, 800);
      }

      var_0C = 0;
      if(var_0C || var_0A) {
        plane_boundary_blowup(var_04);
        dogfighthideboundarywarning();
        return;
      }
    } else {
      if(common_scripts\utility::func_562E(var_08)) {
        var_08 = 0;
        if(1) {
          dogfighthideboundaryoverlay();
          dogfighthideboundarywarning();
        }

        if(isDefined(var_0A)) {
          stopFXOnTag(get_flak_fx_for_direction(var_0A), var_06, "tag_origin");
        }
      }

      var_07 = gettime();
    }

    wait 0.05;
  }
}

plane_boundary_blowup(param_00) {
  var_01 = self;
  var_01.var_2AB1 = 1;
  param_00 dodamage(param_00.var_00FB * 10, param_00.var_0116, undefined, undefined, "MOD_EXPLOSIVE");
}

func_89D5() {
  createthreatbiasgroup("group_allies");
  createthreatbiasgroup("group_axis");
}

common_health_regen(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = self;
  var_07 = self.occupied_player;
  var_06 notify("common_health_regen");
  var_06 endon("death");
  var_06 endon("common_health_regen");
  wait(param_00);
  var_08 = param_02 * var_06.var_00FB / 100;
  var_08 = int(clamp(var_08, param_05, var_06.var_00FB));
  while(var_06.var_00BC > param_05 && var_06.var_00BC < var_06.var_00FB) {
    var_09 = 1;
    if(isDefined(param_04)) {
      var_09 = [[param_04]]();
    }

    var_0A = int(clamp(var_08 * var_09, param_05, var_06.var_00FB));
    var_06.var_00BC = var_06.var_00BC + var_0A;
    if(isDefined(var_07)) {
      var_0B = var_06.var_00BC / var_06.var_00FB;
      var_07.var_00BC = int(var_07.var_00FB * var_0B);
    }

    var_06 common_clear_pending_assists(var_0A);
    if(var_06.var_00BC >= var_06.var_00FB) {
      var_06.var_00BC = var_06.var_00FB;
    }

    var_06[[param_03]]();
    wait(param_01);
  }
}

compare_health_threshold_frac(param_00, param_01) {
  return param_00.health_threshold_frac > param_01.health_threshold_frac;
}

plane_damage_sound_callback(param_00) {}

fighter_is_alive() {
  var_00 = self;
  if(var_00.var_00BC > 1) {
    return 1;
  }

  return 0;
}

fighter_on_health_update_func() {
  var_00 = self;
  var_01 = var_00.occupied_player;
  var_00 notify("health_update");
  if(isDefined(var_01)) {
    var_02 = var_00.var_00BC / var_00.var_00FB;
    var_01 setclientomnvar("ui_raid_vehicle_health_percent", var_02);
  }
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
  param_00 dogfighthideboundarywarning();
  if(isDefined(param_02) && level.dogfightshowui) {
    var_0C = "raid_fighter_killshot";
    param_02 maps\mp\gametypes\_damagefeedback::func_A102(var_0C);
  }

  var_0D = fighter_get_crash_animation(var_07, param_01);
  var_07 vehicle_scripts\_fighter_mp::deathcleanup();
  var_07 method_8511();
  var_0E = undefined;
  var_0F = 1.5;
  var_10 = 0;
  if(isDefined(var_0D)) {
    var_0E = spawn("script_model", var_07.var_0116);
    var_0E.var_001D = var_07.var_001D;
    var_0E setModel(var_07.var_0106);
    var_10 = !var_07 is_plane_outside_hard_boundary() && !common_scripts\utility::func_562E(var_07.forcenodeathanim);
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

  var_07.forcenodeathanim = 0;
  dogfight_kill_player(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
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
      playFX(level.var_0611["mp_raid_fighter_bounds_death"], var_0E gettagorigin("prop"));
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

  if(isDefined(param_01.var_01A7) && level.var_984D && var_0C.var_01A7 == param_01.var_01A7 && !level.dogfightfriendlyfireenabled) {
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
  if(level.dogfightshowui) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102(var_0F);
  }

  var_0C.var_00BC = var_0C.var_00BC - int(param_02);
  var_0C.var_5B8A = gettime();
  var_0C fighter_on_health_update_func();
  if(1 && level.dogfighthealthregenscale > 0 && var_0C.var_00BC > 1) {
    var_0C thread common_health_regen(2 * level.dogfighthealthregenscale, 0.25 * level.dogfighthealthregenscale, 0.1 * level.dogfighthealthregenscale, ::fighter_on_health_update_func, ::fighter_calc_health_regen_mult, 1);
  }

  if(isDefined(var_0D)) {
    var_10 = var_0C.var_00BC / var_0C.var_00FB;
    var_11 = int(var_0D.var_00FB * var_10);
    var_0D dodamage(var_0D.var_00BC - var_11, param_01.var_0116, param_01, param_00, param_04, param_05, param_08);
  }

  var_0C notify("damage", param_02, param_01, param_07, param_06, param_04);
  if(var_0C.var_00BC <= 1) {
    var_0C.var_00BC = 1;
    var_0C thread fighter_death(var_0D, param_06, param_01, param_00, param_04, param_05, param_08);
  }
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

      var_0F = int(100 * var_07 / var_02.var_00FB);
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
      var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
      continue;
    }

    if(var_06 >= param_00) {
      var_06 = var_06 - param_00;
      param_00 = 0;
      var_04[1] = var_06;
      var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
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

  for(var_04 = var_03.damageregistry.size - 1; var_04 >= 0; var_04--) {
    var_05 = var_03.damageregistry[var_04];
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_08 = var_05[2];
    if(var_06 == param_00 && param_02 - var_08 < 500) {
      var_09[2] = var_07 + param_01;
      return;
    }
  }

  var_03.damageregistry = common_scripts\utility::func_0F6F(var_03.damageregistry, [param_00, param_01, param_02]);
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
    if(!maps\mp\_utility::func_3FA0("prematch_done")) {
      continue;
    }

    if(!var_01 method_8648()) {
      continue;
    }

    foreach(var_08 in level.var_744A) {
      if(!level.var_984D || var_08.var_01A7 != var_01.var_01A7) {
        var_01 method_8379(var_08, var_08.var_0116);
        if(isDefined(var_08.occupied_plane)) {
          var_01 method_8379(var_08.occupied_plane, var_08.occupied_plane.var_0116);
        }
      }
    }

    var_0A = var_01.var_0088;
    if(!isDefined(var_0A)) {
      continue;
    }

    if(distancesquared(var_0A.var_0116, param_00.var_0116) > 256000000) {
      continue;
    }

    var_0B = vectornormalize(var_0A.var_0116 - param_00.var_0116);
    var_0C = vectortoangles(var_0B);
    var_0D = param_00.var_001D;
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
    if(!maps\mp\_utility::func_3FA0("prematch_done")) {
      continue;
    }

    var_03 = undefined;
    var_04 = var_01.var_0088;
    var_05 = get_dogfight_boundary_center(0);
    if(isDefined(var_04)) {
      var_03 = var_04.var_0116;
      var_06 = get_dogfight_boundary_radius(1);
      var_07 = var_06 * var_06;
      if(isDefined(var_05) && distancesquared(var_04.var_0116, var_05) >= var_07) {
        var_03 = var_05;
      }
    } else {
      var_03 = var_05;
    }

    if(!isDefined(var_03)) {
      continue;
    }

    var_08 = vectornormalize(var_03 - param_00.var_0116);
    var_09 = 9437184;
    if(function_01EF(var_01) && isDefined(var_04)) {
      var_09 = 0;
    }

    if(var_09 > 0 && distancesquared(param_00.var_0116, var_03) < var_09) {
      var_08 = var_08 * -1;
    }

    var_0A = vectortoangles(var_08);
    var_0B = var_0A[1];
    var_0C = var_0A[0];
    if(level.var_984D && common_scripts\utility::func_562E(var_01.informationtransition) && isDefined(level.defender_spawn_angles) && isDefined(level.attacker_spawn_angles)) {
      if(var_01.var_01A7 == game["defenders"]) {
        var_0B = level.defender_spawn_angles[1];
        var_0C = level.defender_spawn_angles[0];
      } else {
        var_0B = level.attacker_spawn_angles[1];
        var_0C = level.attacker_spawn_angles[0];
      }
    }

    var_01 botsetscriptmove(var_0B, var_02, 1, 1, 1, var_0C);
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
    maps\mp\agents\_agent_utility::func_83FE(param_02.var_01A7, param_02);
  }

  var_07.var_00FB = 100;
  var_07.var_00BC = var_07.var_00FB;
  var_07.var_0109 = "Agent";
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
  maps\mp\agents\_agents::func_0A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  if(self.var_00BC <= 0) {
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
  level.var_0A41[var_00] = [];
  level.var_0A41[var_00]["spawn"] = ::agent_spawn;
  level.var_0A41[var_00]["think"] = ::agent_think;
  level.var_0A41[var_00]["on_killed"] = ::agent_killed;
  level.var_0A41[var_00]["on_damaged"] = ::agent_damage;
  level.var_0A41[var_00]["on_damaged_finished"] = ::func_0A40;
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
    level.bomberescortfighteragents[level.bomberescortfighteragents.size] = [[level.var_0A4D]](var_00, var_03, undefined, var_01, var_02, self, 0, 0, "recruit");
  }
}