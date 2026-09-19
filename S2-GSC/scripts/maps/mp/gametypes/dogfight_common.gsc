/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dogfight_common.gsc
*********************************************************/

dogfightinit() {
  level.isdogfight = 1;

  if(!1) {
    level._id_5A74 = 1;
    level._id_5A6F = 0;
  }

  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  _id_02EF::rvn_audio_include_additional_soundtablefilenames("soundtables/mp_dogfight.csv");
}

ondogfightended() {
  level waittill("game_ended");
  dogfight_end();
}

ondogfightstart() {
  load_vfx();
  maps\mp\gametypes\dogfight_common_aud::init_dogfight_audio();

  if(1)
    maps\mp\gametypes\dogfight_scorestreaks::init_dogfight_killstreaks();

  if(!isDefined(level.dogfightalliesspawner))
    level.dogfightalliesspawner = "p47_attacker_dogfight";

  if(!isDefined(level.dogfightaxisspawner))
    level.dogfightaxisspawner = "p47_defender_dogfight";

  if(!isDefined(level.dogfightminimap))
    level.dogfightminimap = "compass_map_mp_dogfight_wb";

  if(isDefined(level.dogfighthardboundary) && isDefined(level.dogfightsoftboundary)) {
    level.dogfighthardboundarystruct = common_scripts\utility::_id_46B5(level.dogfighthardboundary, "targetname");
    level.dogfightsoftboundarystruct = common_scripts\utility::_id_46B5(level.dogfightsoftboundary, "targetname");
  } else if(isDefined(level.dogfightcenter)) {
    if(_func_296(level.dogfightcenter))
      setup_boundaries_with_origin(level.dogfightcenter);
    else {
      var_0 = common_scripts\utility::_id_46B5(level.dogfightcenter, "targetname");
      setup_boundaries_with_origin(var_0.origin);
    }
  } else
    setup_boundaries_with_origin((0, 0, 0));

  if(isDefined(level.dogfightspawnmin) && isDefined(level.dogfightspawnmax)) {
    level.dogfightspawnminstruct = common_scripts\utility::_id_46B5(level.dogfightspawnmin, "targetname");
    level.dogfightspawnmaxstruct = common_scripts\utility::_id_46B5(level.dogfightspawnmax, "targetname");
  } else
    setup_spawns_with_hard_boundary();

  if(isDefined(level.dogfightformationspawn))
    level.dogfightformationspawnstruct = common_scripts\utility::_id_46B5(level.dogfightformationspawn, "targetname");
  else
    setup_formation_spawn_struct();

  if(!isDefined(level.dogfightformationspawnbaseyaw))
    level.dogfightformationspawnbaseyaw = 0;

  if(!isDefined(level.dogfightformationspawnrandomyaw))
    level.dogfightformationspawnrandomyaw = 90;

  var_1 = getdvarint("2043", 0);
  level.dogfighthealthscale = _func_0AD(getdvarint("scr_player_maxhealth", 100)) / _func_0AD(100);
  level.dogfighthealthregenscale = _func_0AD(getdvarint("scr_player_healthregentime", 4)) / _func_0AD(4);
  level.dogfightshowui = var_1 == 0;
  level.dogfightfriendlyfireenabled = getdvarint("scr_team_fftype", 0);

  if(_func_371())
    setDvar("fd_enable_fbw", !var_1);
  else
    setDvar("fd_enable_fbw", getdvarint("scr_enable_flybywire", 1));

  _id_31E6(get_dogfight_boundary_center(0), level.dogfightminimap);
  thread ondogfightended();
}

update_map_center(var_0) {
  level._id_5FEB = var_0;
  _func_136(level._id_5FEB);
}

setup_minimap(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = 0;
    var_3 = 0.5;
    var_2 = get_dogfight_boundary_radius(0);
    var_4 = var_2 * var_3;
    var_5 = var_2 + var_4;
    var_6 = getEntArray("minimap_corner", "targetname");
    var_7 = var_0[0] - var_5;
    var_8 = var_0[1] - var_5;
    var_9 = var_5 + var_0[0];
    var_10 = var_5 + var_0[1];
    var_6[0].origin = (var_7, var_8, var_0[2]);
    var_6[1].origin = (var_9, var_10, var_0[2]);
    _id_0472::_id_8A2F(var_1);
  }
}

load_formation_nodes() {
  var_0 = common_scripts\utility::_id_46B7("formation_node", "targetname");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = int(var_2._id_8260);
    level.formation_nodes[var_3] = var_2;
  }
}

get_formation_spawn_info_with_angle(var_0) {
  var_1 = level.dogfightformationspawnstruct.origin + (0, 0, level.dogfightformationspawnstruct._id_00BD * 0.5);
  var_2 = (0, var_0, 0);
  var_3 = (1, 0, 0);
  var_4 = _func_112(var_3, var_2);
  var_5 = level.dogfightformationspawnstruct.radius;
  var_6 = (var_4[0] * var_5, var_4[1] * var_5, var_4[2] * var_5);
  var_7 = var_1 + var_6;
  var_8 = vectortoangles(var_1 - var_7);
  var_9 = var_1 - var_6;
  var_10 = vectortoangles(var_1 - var_9);
  return [var_7, var_8, var_9, var_10];
}

configure_formation_spawn() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;
  var_5 = 0;
  var_6 = level.dogfightformationspawnbaseyaw;

  for(var_7 = 0; var_7 < 5; var_7++) {
    if(level.dogfightformationspawnrandomyaw > 0)
      var_6 = level.dogfightformationspawnbaseyaw + _func_0A5(-1 * level.dogfightformationspawnrandomyaw, level.dogfightformationspawnrandomyaw);

    [var_0, var_1, var_2, var_3] = get_formation_spawn_info_with_angle(var_6);
    var_4 = is_spawn_valid(var_0, var_1, 0);
    var_5 = is_spawn_valid(var_2, var_3, 0);

    if(var_4 && var_5) {
      break;
    }
  }

  level.defender_formation_reference_org = var_0;
  level.defender_formation_reference_angles = var_1;
  level.attacker_formation_reference_org = var_2;
  level.attacker_formation_reference_angles = var_3;
  var_9 = (0, var_6, 0);
  level.formation_nodes_offset[0] = (0, 0, 0);

  for(var_7 = 1; var_7 < 9; var_7++) {
    var_10 = level.formation_nodes[var_7].origin - level.formation_nodes[0].origin;
    level.formation_nodes_offset[var_7] = _func_112(var_10, var_9);
  }
}

ongameend() {
  level waittill("game_ended");
  _func_3C6(0, 2, 3, 1);

  foreach(var_1 in level.players) {
    var_1 setclientdvars("ui_raid_hide_fighter", "1");
    var_1.firstfighterspawn = undefined;
    var_1 dogfighthideboundaryoverlay();
    var_1 maps\mp\_utility::freezecontrolswrapper(1);
  }
}

ongameexit() {
  level waittill("exitLevel_called");
  _func_3C6(100, 187.5, 284.09, 143.75);
  setDvar("1145", 1);
}

monitordogfightafk() {
  level endon("game_ended");
  self endon("disconnect");
  maps\mp\_utility::gameflagwait("prematch_done");
  self.lastinputtime = gettime();
  waitframe();

  for(;;) {
    if(!(isDefined(self.controlsfrozen) && self.controlsfrozen)) {
      var_0 = self _meth_86D4();
      var_1 = self _meth_86D5();
      var_2 = var_0[0] != 0 || var_0[1] != 0 || var_1[0] != 0 || var_1[1] != 0;

      if(self _meth_8342() || self _meth_8343() || var_2)
        self.lastinputtime = gettime();
      else if(gettime() - self.lastinputtime >= 75000) {
        _func_134(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
        level thread maps\mp\gametypes\_gamelogic::_id_A11E();
      }
    }

    waitframe();
  }
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 _meth_866F(1.5, 0, 1);
    var_0.fighterspawningfunc = ::get_random_spawn_origin_angles;
    var_0 thread monitordogfightafk();
  }
}

onteamswitch(var_0) {
  self notify("end_p47_switch_team_watcher");
  self endon("end_p47_switch_team_watcher");
  var_1 = self;
  var_2 = var_1.team;
  var_3 = var_1 common_scripts\utility::_id_A716("joined_team", "joined_spectators", "disconnect");

  if(var_3 == "joined_team" || var_3 == "joined_spectators")
    var_2 = var_1.team;

  var_4 = game["defenders"];

  if(var_2 == game["defenders"])
    var_4 = game["attackers"];

  foreach(var_6 in level.players) {
    var_7 = var_6 _meth_85E2();

    if(var_6.team == var_4 && isDefined(var_0))
      var_0 remove_target_on_death(var_6);

    if(isDefined(var_7))
      var_7 remove_target_on_death(var_1);
  }

  var_1 clearagenticonsforplayer();

  if(var_3 != "death")
    delete_plane(var_0);

  if(isDefined(var_1))
    var_1 setclientdvars("ui_raid_hide_fighter", "1");
}

onhostmigrationend() {
  level waittill("host_migration_end");

  if(isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(isalive(var_1)) {
        if(!isDefined(var_1.occupied_plane)) {
          dogfight_kill_player(var_1, (0, 0, 0));
          continue;
        }

        if(1)
          var_1.occupied_plane spawn_fighter_vfx_states();
      }
    }
  }

  _func_3C6(100, 187.5, 284.09, 143.75);
}

onhostmigration(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_begin");
    _func_3C6(0, 2, 3, 1);
    level thread onhostmigrationend();
    bomber_set_dvars();
    update_map_center(var_0);
    _id_89D5();

    if(isDefined(level.players)) {
      foreach(var_2 in level.players) {
        if(isalive(var_2)) {
          if(level.dogfightshowui)
            var_2 setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");

          var_2 thread watch_boundary(var_2.occupied_plane);
          var_2 thread _id_4A35();

          if(level.teambased)
            var_2 thread onteamswitch(var_2.occupied_plane);

          var_2.occupied_plane thread watch_fighter_collision();

          if(isbot(var_2) || _func_1EF(var_2))
            var_2 thread bot_planeflythink(var_2.occupied_plane);

          if(1) {
            if(!isDefined(var_2.onhostmigrationbeginfunc))
              var_2.onhostmigrationbeginfunc = ::onhostmigrationbegin;
          }
        }
      }
    }

    var_4 = maps\mp\gametypes\_hostmigration::_id_A782();
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

fighter_set_perks(var_0) {
  var_0 maps\mp\_utility::_id_05E4();
}

dogfight_kill_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 setclientdvar("ui_raid_hide_fighter", 1);
  var_0 _meth_84C0(0);
  var_0 _meth_8059(99999, var_1, var_2, var_3, var_4, var_5, var_6);
}

dogfight_prematch_wait(var_0, var_1) {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3)) {
        var_3 maps\mp\_utility::freezecontrolswrapper(0);
        var_3.ignoreboundary = 0;
      }
    }
  }

  if(isDefined(var_1)) {
    wait 0.5;
    setup_minimap(var_0, var_1);
  }
}

dogfight_wait_for_match_timer(var_0, var_1) {
  level endon("game_ended");
  _func_3C6(0, 2, 3, 1);
  level waittill("match_start_timer_beginning");
  setup_minimap(var_0, var_1);
  wait(level._id_7692 - 3);
  _func_3C6(100, 187.5, 284.09, 143.75);
}

_id_31E6(var_0, var_1) {
  validate_boundaries();
  level.prevdisabledivisionskills = level.disabledivisionskills;
  level.disabledivisionskills = 1;
  level.prevdisabledivisionpassives = level.disabledivisionpassives;
  level.disabledivisionpassives = 1;
  level._id_4C1E = 1;
  level.flak_in_progress = 0;
  level.flak_scorestreak_id = 0;
  level.fighters_in_progress = 0;
  level.disableplayerdamageimpactfx = 1;

  if(level.teambased) {
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

  if(level._id_7691 > 0) {
    thread dogfight_wait_for_match_timer(var_0, var_1);
    thread dogfight_prematch_wait();
  } else
    thread dogfight_prematch_wait(var_0, var_1);

  level thread onhostmigration(var_0);
  bomber_set_dvars();

  foreach(var_3 in level.players)
  var_3.fighterspawningfunc = ::get_random_spawn_origin_angles;

  level.old_customplaydamagesound = level._id_297F;
  level._id_297F = ::plane_damage_sound_callback;
  level.nobotscorestreaks = 1;
  level._id_5A77 = 0;
  level._id_6465["velocityscaler"] = 1.5;
  level._id_6465["cameraRotationInfluence"] = 0;
  level._id_6465["cameraTranslationInfluence"] = 0.75;
  level.bot_spawnagents_func = ::bot_spawnagents;

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3))
        var_3 _meth_866F(1.5, 0, 1);
    }
  }

  spawner_fog_enable();
  _id_89D5();
  update_map_center(var_0);

  if(level.teambased) {
    load_formation_nodes();
    configure_formation_spawn();
  }

  _id_1E8D();
  level._id_17EF = 0;
  level.pp_array = [];
  thread onplayerconnect();
  thread watch_for_player_spawn();
  thread ongameend();
  thread ongameexit();
}

dogfight_end() {
  bomber_reset_dvars();

  foreach(var_1 in level.players)
  var_1.fighterspawningfunc = undefined;

  level._id_297F = level.old_customplaydamagesound;
  level._id_4C1E = 0;
  level.nobotscorestreaks = 0;
  level._id_5A77 = 5000;
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
    self waittill("veh_collision", var_0, var_1, var_2, var_3);

    if(isDefined(var_2)) {
      if(var_2 _meth_8564() == "plane")
        var_2 _meth_8059(getdvarint("p47_maxhealth") + 1, var_3, self);

      self _meth_8059(getdvarint("p47_maxhealth") + 1, var_3, var_2);
    } else {
      self.forcenodeathanim = 1;
      self _meth_8059(getdvarint("p47_maxhealth") + 1, var_3, var_2);
    }

    waitframe();
  }
}

_id_1E8D() {
  level._id_28D8 = "original";
  level._id_1E8C = [];
  level._id_1E8C["original"] = spawnStruct();
  level._id_1E8C["original"]._id_9164 = 65;
  level._id_1E8C["original"]._id_0A10 = 45;
}

precache_anims() {
  _func_162("mp_raids_husky_usa_thunderbolt_crash_left");
  _func_162("mp_raids_husky_usa_thunderbolt_crash_right");
  _func_162("mp_raids_husky_usa_thunderbolt_crash_up");
  _func_162("mp_raids_husky_usa_thunderbolt_crash_nose_dive");
  _func_162("mp_raids_husky_usa_thunderbolt_graveyard_spiral_down");
}

load_vfx() {
  level._effect["fighter_dmg_low_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_start");
  level._effect["fighter_dmg_med_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_med_start");
  level._effect["fighter_dmg_hvy_start"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_hvy_start");
  level._effect["fighter_dmg_low_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_whitsmk");
  level._effect["fighter_dmg_medium_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_smk");
  level._effect["fighter_dmg_high_loop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_lp_firesmk");
  level._effect["fighter_dmg_high_stop"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_dmg_stop");

  if(1)
    level._effect["flak_gun_explosion"] = loadfx("vfx/scorestreaks/ss_flak_explosion_dlc2");

  level._effect["mp_raid_bomber_throttle_fighter"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_throttle_fighter");
  level._effect["husky_p47_out_flak"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_out_flak");
  level._effect["mp_husky_fighter_wing_smk_sml"] = loadfx("vfx/map/mp_raid_husky_dlc2/mp_husky_fighter_wing_smk_sml");
  level._effect["smoketrail_aircraft_damage_7"] = loadfx("vfx/trail/smoketrail_aircraft_damage_7");
  level._effect["smoketrail_aircraft_damage_6"] = loadfx("vfx/trail/smoketrail_aircraft_damage_6");
  level._effect["smoketrail_aircraft_damage_5"] = loadfx("vfx/trail/smoketrail_aircraft_damage_5");
  level._effect["husky_p47_contrail_ext_vel_b"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_contrail_ext_vel_b");
  level._effect["husky_p47_contrail_ext_vel"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_p47_contrail_ext_vel");
  level._effect["mp_husky_fighter_blk_smk"] = loadfx("vfx/map/mp_raid_husky_dlc2/mp_husky_fighter_blk_smk");
  level._effect["mp_raid_fighter_bounds_death"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_bounds_death");
  level._effect["husky_fighter_cockpit_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_cockpit_01");
  level._effect["husky_plane_damage_trails"] = loadfx("vfx/trail/husky_plane_damage_trails");
  level._effect["smoketrail_aircraft_damage_3"] = loadfx("vfx/trail/smoketrail_aircraft_damage_3");
  level._effect["smoketrail_aircraft_damage_2"] = loadfx("vfx/trail/smoketrail_aircraft_damage_2");
  level._effect["husky_smoketrail_damage_1"] = loadfx("vfx/map/mp_raid_bomber/husky_smoketrail_damage_1");
  level._effect["husky_smoketrail_aircraft_damage_1"] = loadfx("vfx/map/mp_raid_bomber/husky_smoketrail_aircraft_damage_1");
  level._effect["mp_raid_bomber_speedup"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_speedup");
  level._effect["husky_fighter_fire_trail_03"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_trail_03");
  level._effect["husky_fighter_fire_spurt_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_spurt_01");
  level._effect["husky_fighter_explosion_small_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_small_01");
  level._effect["mp_raid_bomber_flak_script_single"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_script_single");
  level._effect["mp_raid_p47_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_p47_wing_evap");
  level._effect["mp_raid_bf109_tracer"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bf109_tracer");
  level._effect["husky_fighter_explosion_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_01");
  level._effect["husky_fighter_explosion_death_01"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_explosion_death_01");
  level._effect["husky_fighter_fire_trail_02"] = loadfx("vfx/map/mp_raid_husky_dlc2/husky_fighter_fire_trail_02");
  level._effect["mp_raid_bomber_flak_return_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_return_rnr");
  level._effect["mp_raid_bomber_flak_right_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_right_rnr");
  level._effect["mp_raid_bomber_flak_left_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_left_rnr");
  level._effect["mp_raid_fighter_spark_impact_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_spark_impact_rnr");
  level._effect["mp_raid_bomber_flak_rnr"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_flak_rnr");
  level._effect["ss_fighter_plane_death"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
  level._effect["mp_raid_fighter_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_wing_evap");
  level._effect["mp_raid_fighter_mzlflash_single"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_mzlflash_single");
  level._effect["mp_raid_fighter_impacts_lrg"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_impacts_lrg");
  level._effect["mp_raid_bomber_aa_flak_runner"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_bomber_aa_flak_runner");
  level._effect["bulge_cam_wisps"] = loadfx("vfx/map/bulge/bulge_cam_wisps");
  level._effect["bulge_dogfight_moon"] = loadfx("vfx/map/bulge/bulge_dogfight_moon");
  level._effect["bulge_dogfight_blur"] = loadfx("vfx/map/bulge/bulge_dogfight_blur");
  level._effect["flak_dogfight"] = loadfx("vfx/map/bulge/bulge_flak_explosion_near");
}

spawn_fighter_vfx_states() {
  var_0 = self;
  var_1 = "TAG_ORIGIN";
  var_2 = spawnStruct();
  var_2.health_threshold_frac = 0.75;
  var_2.vfx_tag = var_1;
  var_2.vfx_in = common_scripts\utility::_id_44F5("fighter_dmg_low_start");
  var_2.vfx_in_length = 0.5;
  var_2.vfx_loop = common_scripts\utility::_id_44F5("fighter_dmg_low_loop");
  var_2.vfx_out = common_scripts\utility::_id_44F5("fighter_dmg_high_stop");
  var_3 = spawnStruct();
  var_3.health_threshold_frac = 0.4;
  var_3.vfx_tag = var_1;
  var_3.vfx_in = common_scripts\utility::_id_44F5("fighter_dmg_med_start");
  var_3.vfx_in_length = 0.5;
  var_3.vfx_loop = common_scripts\utility::_id_44F5("fighter_dmg_medium_loop");
  var_3.vfx_out = common_scripts\utility::_id_44F5("fighter_dmg_high_stop");
  var_4 = spawnStruct();
  var_4.health_threshold_frac = 0.15;
  var_4.vfx_tag = var_1;
  var_4.vfx_in = common_scripts\utility::_id_44F5("fighter_dmg_hvy_start");
  var_4.vfx_in_length = 0.5;
  var_4.vfx_loop = common_scripts\utility::_id_44F5("fighter_dmg_high_loop");
  var_4.vfx_out = common_scripts\utility::_id_44F5("fighter_dmg_high_stop");
  var_5 = [var_2, var_3, var_4];
  var_0 thread common_damage_state_fx_watcher(var_5, 1);
}

onhostmigrationbegin() {
  if(!isDefined(self) || !isDefined(self.occupied_plane)) {
    return;
  }
  if(isDefined(self.occupied_plane.vfx_obj_list)) {
    foreach(var_1 in self.occupied_plane.vfx_obj_list) {
      if(!_func_279(var_1))
        var_1 delete();
    }

    self.occupied_plane.vfx_obj_list = [];
  }

  if(isDefined(self.onhostmigrationbegin))
    self.onhostmigrationbegin = undefined;
}

spawn_client_fighter_fx(var_0) {
  var_1 = self;

  if(isPlayer(var_1) && !isbot(var_1))
    _func_14D(level._effect["mp_raid_bomber_throttle_fighter"], var_0, "TAG_BODY", var_1);
}

remove_client_fighter_fx(var_0) {
  var_1 = self;

  if(isPlayer(var_1) && !isbot(var_1))
    _func_294(level._effect["mp_raid_bomber_throttle_fighter"], var_0, "TAG_BODY", var_1);
}

common_damage_state_fx_update_watcher(var_0, var_1) {
  self notify("damage_state_fx_update_watcher_" + int(var_0.health_threshold_frac * 100));
  self endon("damage_state_fx_update_watcher_" + int(var_0.health_threshold_frac * 100));
  self endon("disconnect");
  var_2 = self;

  if(!_func_0C0(var_0.vfx_tag))
    var_0.vfx_tag = [var_0.vfx_tag];

  self.vfx_obj_list = [];

  for(;;) {
    if(_func_279(var_2) || var_2.health <= var_1 || common_scripts\utility::_id_562E(level.match_ended)) {
      foreach(var_4 in self.vfx_obj_list) {
        if(!_func_279(var_4))
          var_4 delete();
      }

      break;
    }

    if(var_0._id_088A) {
      if(!var_0._id_552B) {
        var_0._id_552B = 1;

        if(isDefined(var_0.vfx_in)) {
          foreach(var_7 in var_0.vfx_tag)
          _func_147(var_0.vfx_in, var_2, var_7);

          wait(var_0.vfx_in_length);
        }

        foreach(var_7 in var_0.vfx_tag) {
          var_4 = _func_2A8(var_0.vfx_loop, var_2, var_7);
          setfxkillondelete(var_4, 1);
          _func_14C(var_4);
          self.vfx_obj_list[var_7] = var_4;
        }

        continue;
      }
    } else if(var_0._id_552B) {
      var_0._id_552B = 0;

      foreach(var_4 in self.vfx_obj_list)
      var_4 delete();

      if(isDefined(var_0.vfx_out)) {
        foreach(var_7 in var_0.vfx_tag)
        _func_147(var_0.vfx_out, var_2, var_7);
      }

      continue;
    }

    var_2 common_scripts\utility::_id_A732("health_update", "match_end");
    waittillframeend;
  }
}

common_damage_state_fx_watcher(var_0, var_1) {
  self notify("damage_state_fx_watcher");
  self endon("damage_state_fx_watcher");
  var_2 = self;
  var_3 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 endon("death");
  var_0 = common_scripts\utility::_id_0FA5(var_0, ::compare_health_threshold_frac);

  foreach(var_5 in var_0) {
    var_5._id_088A = 0;
    var_5._id_552B = 0;
    var_2 thread common_damage_state_fx_update_watcher(var_5, var_1);
  }

  var_2.damagevfxstates = var_0;

  for(;;) {
    var_7 = var_2.health / var_2.maxhealth;
    var_8 = -1;

    if(var_7 < var_0[0].health_threshold_frac) {
      for(var_9 = 0; var_9 < var_0.size; var_9++) {
        var_5 = var_0[var_9];
        var_10 = var_5.health_threshold_frac;
        var_11 = 0;

        if(var_9 < var_0.size - 1)
          var_11 = var_0[var_9 + 1].health_threshold_frac;

        if(var_7 < var_10 && var_7 >= var_11) {
          var_8 = var_9;

          if(var_3 != var_8)
            _id_0378::_id_8D74("aud_fighter_damage_state_change", var_8);

          var_3 = var_9;
          break;
        }
      }
    }

    for(var_9 = 0; var_9 < var_0.size; var_9++) {
      var_5 = var_0[var_9];
      var_5._id_088A = var_8 == var_9;
    }

    var_2 waittill("health_update");
  }
}

fighter_get_crash_animation(var_0, var_1) {
  var_2 = undefined;

  if(!1)
    return var_2;

  var_3 = get_dogfight_boundary_center(0);
  var_4 = get_dogfight_boundary_height(0) * 0.5;
  var_5 = var_3[2] - var_4;
  var_6 = var_3[2] + var_4;
  var_7 = ["mp_raids_husky_usa_thunderbolt_crash_right", "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down", "mp_raids_husky_usa_thunderbolt_crash_left", "mp_raids_husky_usa_thunderbolt_crash_nose_dive"];
  var_8 = [];

  foreach(var_10 in var_7) {
    var_11 = _func_083(fighter_get_crash_anim_ref(var_10), 0, 1);
    var_12 = _func_112(var_11, var_0.angles);
    var_13 = var_1 + var_12;
    var_14 = var_13[2] >= var_5;
    var_15 = var_13[2] <= var_6;
    var_16 = get_dogfight_boundary_radius(0);
    var_17 = var_16 * var_16;
    var_18 = _func_211(var_13, var_3) <= var_17;
    var_19 = 1;
    var_20 = 0.25;
    var_21 = var_1;

    for(var_22 = 1; var_22 <= 4; var_22++) {
      var_11 = _func_083(fighter_get_crash_anim_ref(var_10), 0, var_22 * var_20);
      var_12 = _func_112(var_11, var_0.angles);
      var_23 = var_1 + var_12;
      var_24 = bulletTrace(var_21, var_23, 0, var_0, 0, 0, 1, 1, 0, 0, 0);
      var_19 = var_19 && var_24["fraction"] == 1;

      if(!var_19) {
        break;
      }

      var_21 = var_23;
    }

    if(var_14 && var_15 && var_18 && var_19)
      var_8[var_8.size] = var_10;
  }

  if(var_8.size > 0)
    var_2 = common_scripts\utility::random(var_8);
  else {
    var_2 = "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down";
    var_0.forcenodeathanim = 1;
  }

  return var_2;
}

#using_animtree("dogfight");

fighter_get_crash_anim_ref(var_0) {
  if(var_0 == "mp_raids_husky_usa_thunderbolt_crash_right")
    return % mp_raids_husky_usa_thunderbolt_crash_right;

  if(var_0 == "mp_raids_husky_usa_thunderbolt_graveyard_spiral_down")
    return % mp_raids_husky_usa_thunderbolt_graveyard_spiral_down;

  if(var_0 == "mp_raids_husky_usa_thunderbolt_crash_left")
    return % mp_raids_husky_usa_thunderbolt_crash_left;

  if(var_0 == "mp_raids_husky_usa_thunderbolt_crash_up")
    return % mp_raids_husky_usa_thunderbolt_crash_up;

  if(var_0 == "mp_raids_husky_usa_thunderbolt_crash_nose_dive")
    return % mp_raids_husky_usa_thunderbolt_crash_nose_dive;

  return undefined;
}

fighter_crash_anim_notetrack_watch() {
  var_0 = self;
  var_0 endon("death");

  for(;;) {
    var_0 waittill("fighter_anim_notetrack", var_1);

    if(var_1 == "end") {
      break;
    }

    if(var_1 == "hide_plane")
      var_0 _meth_8511();
  }
}

fighter_death_anim_wait(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    var_1 endon("vehicle_dismount");
    var_0 waittillmatch("fighter_anim_notetrack", "end");
  } else
    var_1 waittill("vehicle_dismount");
}

add_target_icon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_6 = self;
  var_7 = var_0._id_002B;

  if(common_scripts\utility::_id_562E(var_0.firstfighterspawn))
    maps\mp\gametypes\_hostmigration::_id_A6F5(3);

  if(isDefined(var_5)) {
    if(common_scripts\utility::_id_562E(var_0.firstfighterspawn))
      var_5 = var_5 - 3;

    if(var_5 > 0)
      maps\mp\gametypes\_hostmigration::_id_A6F5(var_5);
  }

  if(!isDefined(self) || !isalive(var_0) || var_6 != self || var_7 != var_0._id_002B || isDefined(self._id_01C8) && !fighter_is_alive()) {
    return;
  }
  var_8 = "dogfight_target_diamond";
  var_9 = "tag_origin";
  var_10 = 12500;
  var_11 = 15900;
  var_0 _meth_866C(&"target_add_icon", 8, self, 1, var_9, var_8, var_10, var_11, 0, 0.8);
  var_0 _meth_866C(&"target_set_alpha_fade_when_close", 3, self, 1, 1);

  if(common_scripts\utility::_id_562E(var_3))
    var_0 _meth_866C(&"target_set_swatch", 4, self, 1, "HUD", "friendlyTeam");
  else
    var_0 _meth_866C(&"target_set_swatch", 4, self, 1, "HUD", "enemyTeam");

  if(common_scripts\utility::_id_562E(var_2))
    var_0 _meth_866C(&"target_set_world_offset", 5, self, 1, 0, 0, 300);

  if(common_scripts\utility::_id_562E(var_1))
    var_0 _meth_866C(&"target_set_scale", 3, self, 1, 2);
  else
    var_0 _meth_866C(&"target_set_scale", 3, self, 1, 1.5);

  var_0 _meth_866C(&"target_set_alignment", 4, self, 1, "center", "middle");

  if(common_scripts\utility::_id_562E(var_4))
    var_0 _meth_866C(&"target_set_clamp", 3, self, 1, 1);

  self notify("dogfight_target_added");
}

remove_target_on_death(var_0) {
  if(isDefined(var_0) && isPlayer(var_0))
    var_0 _meth_866C(&"target_remove_all", 1, self);
}

clearagenticonsforplayer() {
  if(isDefined(level._id_0A4E)) {
    foreach(var_1 in level._id_0A4E) {
      var_2 = var_1 _meth_85E2();

      if(isDefined(var_2))
        var_2 thread remove_target_on_death(self);
    }
  }
}

fighter_ui_hide() {
  self _meth_8322();

  if(!_func_1EF(self)) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self setclientdvars("ui_raid_hide_fighter", "1", "ui_force_dont_draw_fighter_names", "1", "cg_drawVehicleCrosshair", "0");
  }

  self.ignoreboundary = 1;
}

fighter_ui_fade_up() {
  self _meth_8323();

  if(!_func_1EF(self)) {
    self _meth_82FF("ui_hide_hud", 0);

    if(level.dogfightshowui)
      self setclientdvars("ui_raid_hide_fighter", "0", "ui_force_dont_draw_fighter_names", "0", "cg_drawVehicleCrosshair", "1");

    if(maps\mp\_utility::gameflag("prematch_done"))
      maps\mp\_utility::freezecontrolswrapper(0);
  }

  if(maps\mp\_utility::gameflag("prematch_done"))
    self.ignoreboundary = 0;
}

dogfightshowboundaryoverlay() {
  if(isDefined(self._id_1B68))
    self notify("cancelBoundaryOverlayHide");
  else {
    self._id_1B68 = _func_19B(self);
    self._id_1B68.x = 0;
    self._id_1B68.y = 0;
    self._id_1B68.sort = -5;
    self._id_1B68._id_00C6 = "fullscreen";
    self._id_1B68._id_01CA = "fullscreen";
    self._id_1B68 setshader("overlay_raid_boundary", 640, 480);
    self._id_1B68.hidewheninmenu = 1;
    self._id_1B68._id_0180 = 0;
    self._id_1B68.alpha = 0;
  }

  if(1)
    self._id_1B68 fadeovertime(0.15);

  self._id_1B68.alpha = 0.3;
}

dogfightshowboundarywarning() {
  self endon("death");
  self endon("disconnect");
  self _meth_82FF("ui_raid_boundary_type", 0);
  wait 0.15;
  self _meth_82FF("ui_raid_boundary_type", 3);
}

dogfighthideboundaryoverlay() {
  self endon("death");
  self endon("disconnect");
  self endon("cancelBoundaryOverlayHide");
  self notify("boundaryOverlayHide");

  if(!isDefined(self._id_1B68)) {
    return;
  }
  if(1) {
    self._id_1B68 fadeovertime(0.15);
    wait 0.15;
  }

  self._id_1B68.alpha = 0;
  self._id_1B68 destroy();
}

dogfighthideboundarywarning() {
  self _meth_82FF("ui_raid_boundary_type", -1);
}

dogfightwatchboundaryoverlay(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("boundaryOverlayHide");

  if(!isDefined(self._id_1B68)) {
    return;
  }
  for(;;) {
    var_1 = var_0 get_plane_vertical_soft_boundary_percent();
    var_2 = var_0 get_plane_horizontal_soft_boundary_percent();
    self._id_1B68.alpha = clamp(0.3 + max(var_1, var_2), 0.0, 1.0);
    waitframe();
  }
}

_id_A334() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("vehicle_mount", var_0);

    if(isDefined(var_0) && isDefined(var_0.team))
      common_scripts\utility::_id_5FA9(var_0.team);
  }
}

_id_A333() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("vehicle_dismount", var_0);
    self _meth_8135();
  }
}

mountvehiclesafe(var_0) {
  if(isDefined(self._id_0117))
    self _meth_8387(undefined);

  self _meth_80F3(var_0);
}

createvehicleinternal(var_0, var_1, var_2) {
  var_3 = var_0.targetname;

  if(!isDefined(var_3))
    var_3 = "UNDEFINED";

  var_4 = undefined;

  if(common_scripts\utility::_id_562E(var_0.use_original_classname))
    var_4 = var_0 _meth_8225();
  else if(isDefined(var_2) && isPlayer(var_2))
    var_4 = _func_1E0(var_0.model, var_3, var_0._id_01C8, var_0.origin, var_0.angles, var_2);
  else
    var_4 = _func_1E0(var_0.model, var_3, var_0._id_01C8, var_0.origin, var_0.angles);

  var_4._id_01C8 = var_0._id_01C8;
  var_4.maxhealth = 9000;
  var_4.health = 9000;
  var_4._id_006A = 0;
  var_4 _meth_82C3(0);

  if(isDefined(var_1)) {
    var_4 _meth_8253(var_1);
    var_4.team = var_1;
  } else {
    var_4 _meth_8253("axis");
    var_4.team = "axis";
  }

  var_4 thread _id_A334();
  var_4 thread _id_A333();
  var_4 makeusable();

  if(var_4.team == "axis") {
    if(!isDefined(level._id_148E))
      level._id_148E = [];

    level._id_148E = common_scripts\utility::_id_0F6F(level._id_148E, var_4);
  }

  return var_4;
}

cleanup_all_turrets() {
  level.match_ended = 1;

  if(isDefined(level.pp_array)) {
    foreach(var_1 in level.pp_array) {
      if(isDefined(var_1)) {
        var_1 notify("match_end");
        var_1 vehicle_scripts\_fighter_mp::destroyturrets();
      }
    }
  }
}

_id_4A31(var_0, var_1) {
  self notify("handle_p47_50cals");
  self endon("handle_p47_50cals");
  self endon("death");
  var_1 endon("death");
  _id_0378::_id_8D74("p47_turret_plr");
  var_2 = 0;
  var_3 = _func_0A4(20, 40);
  var_4 = var_3 + _func_0A4(10, 20);
  var_5 = [];
  var_6 = 0;
  var_7 = 8;
  var_8 = 3;
  var_9 = 2;
  var_10 = 0;
  self._id_2651 = 0;
  var_11 = 15;
  var_12 = 0.1;
  var_13 = 2.0;
  var_14 = 0;
  var_15 = undefined;
  var_16 = 0;
  var_17 = getdvarfloat("cg_fov");
  var_18 = 0.1;

  while(isDefined(self)) {
    var_19 = 0;
    var_19 = isDefined(self._id_830A) && self._id_830A;

    if(!var_19 && isDefined(var_0) && var_0) {
      var_19 = var_1 _meth_8342();

      if(self._id_2651)
        var_19 = 0;
      else if(var_19) {
        if(1) {
          var_10 = var_10 + var_18;

          if(var_10 >= var_7) {
            var_10 = var_7;
            self._id_2651 = 1;
            var_1 _meth_8322();
          }
        }
      }
    }

    if(!var_19) {
      if(1) {
        if(self._id_2651) {
          var_10 = var_10 - var_18 * var_8;

          if(var_10 <= 0) {
            var_10 = 0;
            self._id_2651 = 0;
            var_1 _meth_8323();
          }
        } else
          var_10 = max(var_10 - var_18 * var_9, 0);
      }
    }

    var_20 = 0.0;

    if(var_19)
      var_20 = _func_0A5(0.0025, 0.005) * common_scripts\utility::_id_98E7(common_scripts\utility::_id_24A6(), 1.0, -1.0);

    if(1) {
      var_21 = clamp(var_10 / var_7 + var_20, 0.0, 1.0);
      var_1 _meth_82FF("ui_raid_vehicle_overheat_percent", var_21);
    }

    wait(var_18);
  }
}

_id_4A35() {
  self notify("fighter_fov");
  self endon("disconnect");
  self endon("death");
  self endon("fighter_fov");

  if(_func_1EF(self)) {
    return;
  }
  var_0 = getdvarfloat("cg_fov");
  var_1 = level._id_1E8C[self._id_28D8]._id_0A10 / var_0;
  var_2 = level._id_1E8C[self._id_28D8]._id_9164 / var_0;
  self _meth_8036(var_2, 0.1);
  self._id_28FB = var_2;
  var_3 = 0.4;
  var_4 = 1;
  self _meth_8036(var_2, var_4);

  for(;;) {
    if(!isDefined(self) || _func_279(self)) {
      break;
    }

    var_5 = self _meth_8343();

    if(var_5) {
      var_1 = level._id_1E8C[self._id_28D8]._id_0A10 / var_0;
      var_2 = level._id_1E8C[self._id_28D8]._id_9164 / var_0;
      self _meth_8036(var_1, var_3);
      self._id_28FB = var_1;

      for(self._id_6F1F = 1; var_5; var_5 = self _meth_8343())
        waitframe();

      self _meth_8036(var_2, var_4);
      self._id_28FB = var_2;
      self._id_6F1F = 0;
    }

    waitframe();
  }
}

delete_plane(var_0) {
  if(isDefined(var_0)) {
    level.pp_array = common_scripts\utility::_id_0F93(level.pp_array, var_0);
    var_0 notify("health_update");
    var_0 vehicle_scripts\_fighter_mp::destroyturrets();
    var_0 delete();
  }
}

setup_spawns_with_hard_boundary() {
  if(!isDefined(level.dogfightspawnminstruct))
    level.dogfightspawnminstruct = spawnStruct();

  level.dogfightspawnminstruct._id_00BD = 14000;
  level.dogfightspawnminstruct.radius = 20500;
  var_0 = level.dogfighthardboundarystruct._id_00BD - level.dogfightspawnminstruct._id_00BD;
  level.dogfightspawnminstruct.origin = level.dogfighthardboundarystruct.origin + (0, 0, var_0 * 0.5);

  if(!isDefined(level.dogfightspawnmaxstruct))
    level.dogfightspawnmaxstruct = spawnStruct();

  level.dogfightspawnmaxstruct._id_00BD = 14000;
  level.dogfightspawnmaxstruct.radius = 21000;
  var_0 = level.dogfighthardboundarystruct._id_00BD - level.dogfightspawnmaxstruct._id_00BD;
  level.dogfightspawnmaxstruct.origin = level.dogfighthardboundarystruct.origin + (0, 0, var_0 * 0.5);
}

get_spawn_center() {
  return level.dogfightspawnmaxstruct.origin + (0, 0, level.dogfightspawnmaxstruct._id_00BD * 0.5);
}

get_spawn_radius(var_0) {
  var_1 = undefined;

  if(var_0)
    var_1 = level.dogfightspawnminstruct.radius;
  else
    var_1 = level.dogfightspawnmaxstruct.radius;

  return var_1;
}

get_spawn_height(var_0) {
  var_1 = undefined;

  if(var_0)
    var_1 = level.dogfightspawnminstruct._id_00BD;
  else
    var_1 = level.dogfightspawnmaxstruct._id_00BD;

  return var_1;
}

setup_formation_spawn_struct() {
  if(!isDefined(level.dogfightformationspawnstruct))
    level.dogfightformationspawnstruct = spawnStruct();

  var_0 = get_dogfight_boundary_center(0);
  level.dogfightformationspawnstruct.origin = var_0 - (0, 0, 50);
  level.dogfightformationspawnstruct._id_00BD = 100.0;
  level.dogfightformationspawnstruct.radius = 23000;
}

random_point_on_cylinder(var_0, var_1) {
  var_2 = vectorNormalize((_func_0A5(-1.0, 1.0), _func_0A5(-1.0, 1.0), 0));
  var_3 = var_0 + var_1 * var_2;
  var_4 = get_spawn_height(0) * 0.5;
  var_3 = var_3 + (0, 0, _func_0A5(var_4 * -1, var_4));
  return var_3;
}

get_formation_spawn_origin_angles(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = (0, 0, 0);

  if(level.dogfightformationspawnstruct._id_00BD > 0) {
    var_4 = level.dogfightformationspawnstruct._id_00BD * 0.5;
    var_3 = (0, 0, _func_0A5(-1 * var_4, var_4));
  }

  if(var_0 == game["defenders"]) {
    var_5 = level.formation_nodes_offset[level.defender_formation_index];
    var_1 = level.defender_formation_reference_org + var_5 + var_3;
    var_2 = level.defender_formation_reference_angles;
    level.defender_formation_index++;

    if(level.defender_formation_index >= 9)
      level.defender_formation_index = 0;
  } else {
    var_5 = level.formation_nodes_offset[level.attacker_formation_index];
    var_1 = level.attacker_formation_reference_org - var_5 + var_3;
    var_2 = level.attacker_formation_reference_angles;
    level.attacker_formation_index++;

    if(level.attacker_formation_index >= 9)
      level.attacker_formation_index = 0;
  }

  return [var_1, var_2];
}

is_spawn_targeted(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2) || !maps\mp\_utility::isreallyalive(var_2)) {
      continue;
    }
    if(var_2 == self || level.teambased && var_2.team == self.team) {
      continue;
    }
    if(distancesquared(var_0, var_2.origin) < 20250000)
      return 1;

    var_3 = var_0 - var_2.origin;
    var_4 = anglesToForward(var_2.occupied_plane.angles);
    var_5 = vectordot(var_3, var_4);

    if(var_5 <= 0) {
      continue;
    }
    var_3 = vectorNormalize(var_3);
    var_4 = vectorNormalize(var_4);
    var_5 = vectordot(var_3, var_4);

    if(var_5 < 0.996195) {
      continue;
    }
    if(_func_07E(var_0, var_2.origin, 0, self))
      return 1;
  }

  return 0;
}

is_spawn_valid(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = anglesToForward(var_1);
  var_5 = (var_4[0] * 2000, var_4[1] * 2000, var_4[2] * 2000);
  var_6 = var_0 + var_5;
  var_7 = bulletTrace(var_0, var_6, 0, undefined, 0, 0, 1, 1, 0, 0, 0);
  var_3 = var_7["fraction"] == 1;

  if(common_scripts\utility::_id_562E(var_2))
    var_3 = var_3 && !is_spawn_targeted(var_0);

  return var_3;
}

get_random_spawn_origin_angles() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = get_spawn_center();
  var_4 = _func_0A5(get_spawn_radius(1), get_spawn_radius(0));

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_1 = random_point_on_cylinder(var_3, var_4);
    var_6 = var_3 - var_1;
    var_2 = vectortoangles(var_6);
    var_2 = (0, var_2[1], 0);

    if(var_2[1] == 180.0)
      var_2 = (var_2[0], var_2[1] + 0.1, var_2[2]);

    var_2 = (_func_0DD(var_2[0]), _func_0DD(var_2[1]), _func_0DD(var_2[2]));
    var_0 = is_spawn_valid(var_1, var_2, 1);

    if(var_0) {
      break;
    }
  }

  return [var_1, var_2];
}

player_spawn_helper(var_0) {
  var_1 = 1.0;
  var_0 _meth_84C0(1);
  var_0 _meth_805C();
  var_0 setclientdvar("cg_altimeterRange", get_dogfight_boundary_height(0));
  var_2 = get_dogfight_boundary_center(0);
  var_0 setclientdvar("cg_altimeterCenter", var_2[2]);
  var_0._id_4D13 = 1;

  if(isbot(var_0) || _func_1EF(var_0))
    var_0._id_0100 = 576000000;

  thread spawn_fighter(var_0);

  if(isPlayer(var_0) && !isbot(var_0)) {
    var_0 maps\mp\gametypes\_class::_id_4773(var_0.team, var_0.class);
    fighter_set_perks(var_0);

    if(1)
      thread maps\mp\gametypes\dogfight_scorestreaks::fighter_scorestreak_watcher(var_0);
  }

  var_0 _meth_82FF("ui_raid_vehicle_health_percent", var_1);
}

allow_controls_after_trans(var_0, var_1, var_2) {
  self endon("disconnect");

  if(var_1 == 5000)
    var_1 = var_1 + 500;

  common_scripts\utility::_id_A70D(var_1 / 1000.0, self, "death", var_0, "death");

  if(var_2)
    self.informationtransition = 0;

  fighter_ui_fade_up();
}

spawner_fog_enable() {
  var_0 = _func_18E(level.dogfightalliesspawner, "targetname");
  var_0 _meth_8400();

  if(level.teambased) {
    var_1 = _func_18E(level.dogfightaxisspawner, "targetname");
    var_1 _meth_8400();
  }
}

get_spawner(var_0) {
  var_1 = undefined;

  if(!isDefined(level.attacker_pp_spawner))
    level.attacker_pp_spawner = _func_18E(level.dogfightalliesspawner, "targetname");

  if(!isDefined(level.defender_pp_spawner))
    level.defender_pp_spawner = _func_18E(level.dogfightaxisspawner, "targetname");

  var_1 = undefined;

  if(level.teambased) {
    if(var_0 == game["attackers"])
      var_1 = level.attacker_pp_spawner;
    else
      var_1 = level.defender_pp_spawner;
  } else
    var_1 = level.attacker_pp_spawner;

  return var_1;
}

get_turret_weapon_info(var_0) {
  var_1 = "turretweapon_usa_fighter_thunderbolt_player_mp";

  if(level.teambased && var_0 == "axis")
    var_1 = "turretweapon_ger_fighter_bf109_player_mp";

  return var_1;
}

spawn_player_p47(var_0) {
  var_1 = get_spawner(var_0.team);
  var_2 = createvehicleinternal(var_1, var_0.team, var_0);
  var_2.team = var_0.team;
  var_2 _meth_8134(var_2.team);

  if(level.teambased) {
    var_3 = undefined;

    if(var_2.team == "allies")
      var_3 = "group_allies";
    else
      var_3 = "group_axis";

    var_2 _meth_8173(var_3);
    var_0 _meth_8173(var_3);
  }

  level.pp_array = common_scripts\utility::_id_0F6F(level.pp_array, var_2);
  return var_2;
}

spawn_fighter(var_0) {
  var_1 = !maps\mp\_utility::gameflag("prematch_done") && level.teambased;
  var_2 = undefined;

  if(var_1) {
    var_0 setclientdvar("vehCam_chaseFD_camStartMode", 1);
    var_2 = 5000;
  } else {
    var_0 setclientdvar("vehCam_chaseFD_camStartMode", 0);
    var_2 = 750;
  }

  var_0 setclientdvar("vehCam_chaseFD_camStartLerpDuration", var_2);
  var_0 fighter_ui_hide();

  if(var_1 && isbot(var_0))
    var_0 maps\mp\_utility::freezecontrolswrapper(0);

  var_3 = spawn_player_p47(var_0);
  var_3.maxhealth = getdvarint("p47_maxhealth");
  var_3.health = var_3.maxhealth;
  var_3 _meth_82C3(1);
  var_3.damagecallback = ::fighter_damage_callback;
  var_3 _meth_8511();

  if(!level.flak_in_progress || (!isDefined(var_0.flak_scorestreak_id) || var_0.flak_scorestreak_id != level.flak_scorestreak_id))
    var_0.hasdiedtoflak = undefined;

  var_0._id_28D8 = "original";

  if(!isDefined(var_0.firstfighterspawn))
    var_0.firstfighterspawn = 1;
  else
    var_0.firstfighterspawn = 0;

  var_3.occupied_player = var_0;
  var_0.occupied_plane = var_3;
  var_4 = undefined;

  if(_func_1EF(var_0)) {
    var_0._id_00CE = 1;
    var_3._id_00CE = 1;
  }

  var_5 = undefined;

  if(var_1) {
    if(var_2 == 5000)
      var_5 = (var_2 + 500) / 1000.0;

    [var_4, var_7] = get_formation_spawn_origin_angles(var_0.team);
  } else if(isDefined(var_0.fighterspawnorigin) && isDefined(var_0.fighterspawnangles)) {
    var_4 = var_0.fighterspawnorigin;
    var_7 = var_0.fighterspawnangles;
  } else
    [var_4, var_7] = var_0 get_random_spawn_origin_angles();

  if(var_7[1] == 180.0)
    var_7 = (var_7[0], var_7[1] + 0.1, var_7[2]);

  var_7 = (_func_0DD(var_7[0]), _func_0DD(var_7[1]), _func_0DD(var_7[2]));
  var_0 _meth_833E(var_7);
  var_3 _meth_8279(var_4, var_7);

  if(_func_1EF(var_0)) {
    var_0._id_0009 = &"RAIDS_DOGFIGHT_AGENTNAME";

    foreach(var_10 in level.players) {
      if(!level.teambased || var_10.team == common_scripts\utility::_id_416F(var_0._id_000A))
        var_3 thread add_target_icon(var_10, 0, 1, 0, undefined, var_5);
    }
  }

  var_3 _meth_8384(var_0);
  var_0 mountvehiclesafe(var_3);
  var_0 _meth_8331();
  var_12 = get_turret_weapon_info(var_0.team);
  var_3 vehicle_scripts\_fighter_mp::_id_51FB(var_12);
  var_3 thread _id_4A31(1, var_0);
  var_3 _id_0378::_id_8D74("aud_figher_spawn");
  var_0 thread _id_4A35();
  var_0 thread watch_boundary(var_3);

  if(isbot(var_0) || _func_1EF(var_0)) {
    if(var_1)
      var_0.informationtransition = 1;

    var_0 thread bot_planeflythink(var_3);
  }

  if(level.teambased)
    var_0 thread onteamswitch(var_3);

  var_3 thread watch_fighter_collision();

  if(1) {
    var_3 spawn_fighter_vfx_states();

    if(!isDefined(var_0.onhostmigrationbeginfunc))
      var_0.onhostmigrationbeginfunc = ::onhostmigrationbegin;
  }

  var_0 thread spawn_client_fighter_fx(var_3);

  if(isPlayer(var_0)) {
    foreach(var_10 in level.players) {
      var_14 = var_10 _meth_85E2();

      if((!level.teambased || var_10.team == common_scripts\utility::_id_416F(var_0.team)) && isDefined(var_14) && var_14 fighter_is_alive())
        var_14 thread add_target_icon(var_0, 0, 1, 0, undefined, var_5);

      if(!level.teambased || var_10.team == common_scripts\utility::_id_416F(var_0.team))
        var_3 thread add_target_icon(var_10, 0, 1, 0, undefined, var_5);
    }

    if(isDefined(level._id_0A4E)) {
      foreach(var_17 in level._id_0A4E) {
        var_14 = var_17 _meth_85E2();

        if(isDefined(var_14) && (!level.teambased || var_17._id_000A == common_scripts\utility::_id_416F(var_0.team)))
          var_14 thread add_target_icon(var_0, 0, 1, 0, undefined, var_5);
      }
    }
  }

  var_3 thread show_plane();
  var_0 thread allow_controls_after_trans(var_3, var_2, var_1);
  var_0 dogfighthideboundaryoverlay();
  var_0 dogfighthideboundarywarning();
}

show_plane() {
  self endon("death");
  self endon("disconnect");
  wait 0.1;
  self _meth_805B();
}

watch_for_player_spawn() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread player_spawn_helper(var_0);
  }
}

set_boundary(var_0, var_1, var_2, var_3) {
  if(var_3) {
    if(!isDefined(level.dogfightsoftboundarystruct))
      level.dogfightsoftboundarystruct = spawnStruct();

    level.dogfightsoftboundarystruct.origin = var_0;
    level.dogfightsoftboundarystruct.radius = var_1;
    level.dogfightsoftboundarystruct._id_00BD = var_2;
  } else {
    if(!isDefined(level.dogfighthardboundarystruct))
      level.dogfighthardboundarystruct = spawnStruct();

    level.dogfighthardboundarystruct.origin = var_0;
    level.dogfighthardboundarystruct.radius = var_1;
    level.dogfighthardboundarystruct._id_00BD = var_2;
  }
}

setup_boundaries_with_origin(var_0) {
  set_boundary(var_0, 27000, 28000, 0);
  var_1 = 8000;
  set_boundary(var_0 + (0, 0, var_1 * 0.5), 22000, 20000, 1);
}

validate_boundaries() {
  var_0 = level.dogfighthardboundarystruct.origin + (0, 0, level.dogfighthardboundarystruct._id_00BD * 0.5);
  var_1 = level.dogfighthardboundarystruct.origin + (level.dogfighthardboundarystruct.radius, 0, 0);
  var_2 = 1073676289;
  var_3 = level.dogfighthardboundarystruct.origin;
  var_4 = var_3 + (0, 0, level.dogfighthardboundarystruct._id_00BD);
  var_5 = level.dogfightsoftboundarystruct.origin;
  var_6 = var_5 + (0, 0, level.dogfightsoftboundarystruct._id_00BD);
  var_7 = level.dogfighthardboundarystruct.origin + (0, 0, level.dogfighthardboundarystruct._id_00BD * 0.5);
  var_8 = level.dogfightsoftboundarystruct.origin + (0, 0, level.dogfightsoftboundarystruct._id_00BD * 0.5);
  var_9 = 0.0001;
  var_10 = level.dogfightspawnminstruct.origin;
  var_11 = var_10 + (0, 0, level.dogfightspawnminstruct._id_00BD);
  var_12 = level.dogfightspawnmaxstruct.origin;
  var_13 = var_12 + (0, 0, level.dogfightspawnmaxstruct._id_00BD);
  var_14 = level.dogfightspawnminstruct.origin + (0, 0, level.dogfightspawnminstruct._id_00BD * 0.5);
  var_15 = level.dogfightspawnmaxstruct.origin + (0, 0, level.dogfightspawnmaxstruct._id_00BD * 0.5);
}

get_dogfight_boundary_radius(var_0) {
  var_1 = undefined;

  if(var_0)
    var_1 = level.dogfightsoftboundarystruct.radius;
  else
    var_1 = level.dogfighthardboundarystruct.radius;

  return var_1;
}

get_dogfight_boundary_height(var_0) {
  var_1 = undefined;

  if(var_0)
    var_1 = level.dogfightsoftboundarystruct._id_00BD;
  else
    var_1 = level.dogfighthardboundarystruct._id_00BD;

  return var_1;
}

get_dogfight_boundary_center(var_0) {
  var_1 = undefined;

  if(var_0)
    var_1 = level.dogfighthardboundarystruct.origin + (0, 0, level.dogfighthardboundarystruct._id_00BD * 0.5);
  else
    var_1 = level.dogfightsoftboundarystruct.origin + (0, 0, level.dogfightsoftboundarystruct._id_00BD * 0.5);

  return var_1;
}

is_plane_outside_soft_boundary_radius() {
  var_0 = 0;
  var_1 = _func_211(self.origin, get_dogfight_boundary_center(1));
  var_2 = get_dogfight_boundary_radius(1);
  var_3 = var_2 * var_2;

  if(var_1 > var_3)
    var_0 = 1;

  return var_0;
}

is_plane_outside_soft_boundary_top() {
  var_0 = 0;
  var_1 = get_dogfight_boundary_center(1);
  var_2 = var_1[2] + get_dogfight_boundary_height(1) * 0.5;

  if(self.origin[2] > var_2)
    var_0 = 1;

  return var_0;
}

is_plane_outside_soft_boundary_bottom() {
  var_0 = 0;
  var_1 = get_dogfight_boundary_center(1);
  var_2 = var_1[2] - get_dogfight_boundary_height(1) * 0.5;

  if(self.origin[2] < var_2)
    var_0 = 1;

  return var_0;
}

get_plane_vertical_soft_boundary_percent() {
  var_0 = 0.0;

  if(is_plane_outside_soft_boundary_top() || is_plane_outside_soft_boundary_bottom()) {
    var_1 = get_dogfight_boundary_center(1);
    var_2 = _func_0AE(self.origin[2] - var_1[2]);
    var_3 = get_dogfight_boundary_height(1) * 0.5;
    var_4 = get_dogfight_boundary_height(0) * 0.5;
    var_0 = (var_2 - var_3) / (var_4 - var_3);
  }

  return var_0;
}

get_plane_horizontal_soft_boundary_percent() {
  var_0 = 0.0;

  if(is_plane_outside_soft_boundary_radius()) {
    var_1 = 0;
    var_2 = _func_211(self.origin, get_dogfight_boundary_center(1));
    var_3 = get_dogfight_boundary_radius(1);
    var_4 = var_3 * var_3;
    var_5 = get_dogfight_boundary_radius(0);
    var_6 = var_5 * var_5;
    var_0 = (var_2 - var_4) / (var_6 - var_4);
  }

  return var_0;
}

is_plane_outside_soft_boundary() {
  return is_plane_outside_soft_boundary_top() || is_plane_outside_soft_boundary_bottom() || is_plane_outside_soft_boundary_radius();
}

is_plane_outside_hard_boundary() {
  var_0 = get_dogfight_boundary_center(1);
  var_1 = _func_211(self.origin, var_0);
  var_2 = _func_0AE(self.origin[2] - var_0[2]);
  var_3 = get_dogfight_boundary_radius(0);
  var_4 = var_3 * var_3;

  if(var_1 >= var_4)
    return 1;

  if(var_2 >= get_dogfight_boundary_height(0) * 0.5)
    return 1;

  return 0;
}

play_boundary_flak() {
  var_0 = is_plane_outside_soft_boundary_radius() || is_plane_outside_soft_boundary_top();

  if(!isDefined(level.dogfightusebottomflak) || level.dogfightusebottomflak)
    var_0 = var_0 && is_plane_outside_soft_boundary_bottom();

  return var_0;
}

get_flak_fx_for_direction(var_0) {
  if(var_0 == "forward")
    return level._effect["mp_raid_bomber_flak_rnr"];
  else if(var_0 == "right")
    return level._effect["mp_raid_bomber_flak_right_rnr"];
  else if(var_0 == "left")
    return level._effect["mp_raid_bomber_flak_left_rnr"];
  else if(var_0 == "back")
    return level._effect["mp_raid_bomber_flak_return_rnr"];
}

watch_boundary(var_0) {
  self notify("boundaryWatch");
  self endon("deathSentence");
  self endon("death");
  self endon("disconnect");
  self endon("boundaryWatch");
  level endon("game_ended");

  if(_func_1EF(self)) {
    return;
  }
  var_1 = gettime();
  var_2 = undefined;
  var_3 = gettime();
  var_4 = undefined;
  var_5 = get_dogfight_boundary_center(0);

  if(var_0 is_plane_outside_hard_boundary() && !isDefined(level.hostmigrationtimer)) {}

  if(!common_scripts\utility::within_fov(var_0.origin, var_0.angles, var_5, _func_0A7(30)) && !isDefined(level.hostmigrationtimer)) {}

  for(;;) {
    if(common_scripts\utility::_id_562E(self.ignoreboundary) || isDefined(level.hostmigrationtimer)) {
      waitframe();
      continue;
    }

    if(var_0 is_plane_outside_soft_boundary()) {
      var_6 = var_0 is_plane_outside_hard_boundary();
      var_7 = play_boundary_flak();

      if(!common_scripts\utility::_id_562E(var_2)) {
        var_2 = 1;

        if(1) {
          dogfightshowboundaryoverlay();
          thread dogfightshowboundarywarning();
          thread dogfightwatchboundaryoverlay(var_0);
        }

        if(common_scripts\utility::_id_562E(var_7))
          var_3 = gettime();
      }

      if(common_scripts\utility::_id_562E(var_7) && var_3 <= gettime()) {
        var_8 = vectorNormalize(var_0.origin - var_5);
        var_9 = vectorNormalize(var_0.angles);
        var_10 = vectorNormalize(_func_234(var_8, var_0.angles));
        var_11 = _func_1E3(var_10[1], var_10[0]);
        var_8 = undefined;

        if(var_11 < -45 && var_11 > -135)
          var_8 = "right";
        else if(var_11 > 45 && var_11 < 135)
          var_8 = "left";
        else if(var_11 >= -45 && var_11 <= 45)
          var_8 = "forward";
        else
          var_8 = "back";

        if(isDefined(var_4))
          _func_148(get_flak_fx_for_direction(var_4), var_0, "tag_origin");

        _func_147(get_flak_fx_for_direction(var_8), var_0, "tag_origin");
        var_4 = var_8;
        var_3 = gettime() + _func_0A4(600, 800);
      }

      var_12 = 0;

      if(var_12 || var_6) {
        plane_boundary_blowup(var_0);
        dogfighthideboundarywarning();
        return;
      }
    } else {
      if(common_scripts\utility::_id_562E(var_2)) {
        var_2 = 0;

        if(1) {
          dogfighthideboundaryoverlay();
          dogfighthideboundarywarning();
        }

        if(isDefined(var_4))
          _func_148(get_flak_fx_for_direction(var_4), var_0, "tag_origin");
      }

      var_1 = gettime();
    }

    waitframe();
  }
}

plane_boundary_blowup(var_0) {
  var_1 = self;
  var_1._id_2AB1 = 1;
  var_0 _meth_8059(var_0.maxhealth * 10, var_0.origin, undefined, undefined, "MOD_EXPLOSIVE");
}

_id_89D5() {
  _func_0F8("group_allies");
  _func_0F8("group_axis");
}

common_health_regen(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = self.occupied_player;
  var_6 notify("common_health_regen");
  var_6 endon("death");
  var_6 endon("common_health_regen");
  wait(var_0);
  var_8 = var_2 * var_6.maxhealth / 100;
  var_8 = int(clamp(var_8, var_5, var_6.maxhealth));

  while(var_6.health > var_5 && var_6.health < var_6.maxhealth) {
    var_9 = 1;

    if(isDefined(var_4))
      var_9 = [[var_4]]();

    var_10 = int(clamp(var_8 * var_9, var_5, var_6.maxhealth));
    var_6.health = var_6.health + var_10;

    if(isDefined(var_7)) {
      var_11 = var_6.health / var_6.maxhealth;
      var_7.health = int(var_7.maxhealth * var_11);
    }

    var_6 common_clear_pending_assists(var_10);

    if(var_6.health >= var_6.maxhealth)
      var_6.health = var_6.maxhealth;

    var_6[[var_3]]();
    wait(var_1);
  }
}

compare_health_threshold_frac(var_0, var_1) {
  return var_0.health_threshold_frac > var_1.health_threshold_frac;
}

plane_damage_sound_callback(var_0) {
  return;
}

fighter_is_alive() {
  var_0 = self;

  if(var_0.health > 1)
    return 1;

  return 0;
}

fighter_on_health_update_func() {
  var_0 = self;
  var_1 = var_0.occupied_player;
  var_0 notify("health_update");

  if(isDefined(var_1)) {
    var_2 = var_0.health / var_0.maxhealth;
    var_1 _meth_82FF("ui_raid_vehicle_health_percent", var_2);
  }
}

fighter_calc_health_regen_mult() {
  var_0 = self;
  var_1 = var_0.occupied_player;
  var_2 = 1.0;

  if(isDefined(var_1) && isDefined(var_0._id_5B8A)) {
    var_3 = var_0._id_5B8A;
    var_4 = gettime();

    if(var_4 - var_3 > 10000)
      var_2 = 3;
  }

  return var_2;
}

fighter_play_crash_anim(var_0, var_1, var_2, var_3) {
  waitframe();

  if(var_3) {
    var_1 _meth_8278(var_2, "fighter_anim_notetrack");
    var_1 childthread fighter_crash_anim_notetrack_watch();
  } else {
    var_1 _meth_8276(var_2, undefined, 0, 0.01);
    var_1 _meth_84CA(1);
    var_1 _meth_8511();
    var_0 _meth_81E2(var_1, "tag_player", 0);
  }
}

fighter_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(isDefined(var_5) && var_5 == "killstreak_flak_gun_raids") {
    var_0.hasdiedtoflak = 1;
    var_0.flak_scorestreak_id = level.flak_scorestreak_id;
  }

  foreach(var_9 in level.players) {
    if(var_0 == var_9) {
      continue;
    }
    var_10 = var_9 _meth_85E2();

    if(isDefined(var_7))
      var_7 remove_target_on_death(var_9);

    if(isDefined(var_10))
      var_10 remove_target_on_death(var_0);
  }

  var_0 clearagenticonsforplayer();
  var_0 dogfighthideboundarywarning();

  if(isDefined(var_2) && level.dogfightshowui) {
    var_12 = "raid_fighter_killshot";
    var_2 _id_04C7::_id_A102(var_12);
  }

  var_13 = fighter_get_crash_animation(var_7, var_1);
  var_7 vehicle_scripts\_fighter_mp::deathcleanup();
  var_7 _meth_8511();
  var_14 = undefined;
  var_15 = 1.5;
  var_16 = 0;

  if(isDefined(var_13)) {
    var_14 = spawn("script_model", var_7.origin);
    var_14.angles = var_7.angles;
    var_14 setModel(var_7.model);
    var_16 = !var_7 is_plane_outside_hard_boundary() && !common_scripts\utility::_id_562E(var_7.forcenodeathanim);

    if(var_16) {
      var_17 = fighter_get_crash_anim_ref(var_13);
      var_18 = _func_065(var_17) + var_15;
      var_19 = int(var_18 * 1000);
      var_0 _meth_8601(var_19);
      var_0.onplayerkilledwaitfordeathduration = 1;
    } else
      var_15 = 2;

    thread fighter_play_crash_anim(var_0, var_14, var_13, var_16);
    var_7 _id_0378::_id_8D74("aud_fighter_start_death", var_14);
  }

  var_7.forcenodeathanim = 0;
  dogfight_kill_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_7 _meth_82C3(0);
  var_7 _meth_80B1();

  if(_func_1EF(var_0))
    var_0 _meth_8322();
  else
    var_0 maps\mp\_utility::freezecontrolswrapper(1);

  if(var_16) {
    if(_func_1EF(var_0))
      var_7 fighter_death_anim_wait(var_14);
    else {
      if(isDefined(var_14))
        var_0 _meth_81E2(var_14, "tag_player", 0);

      var_7 fighter_death_anim_wait(var_14);
    }
  }

  var_0 remove_client_fighter_fx(var_7);

  if(isDefined(var_14)) {
    var_20 = var_14 gettagorigin("TAG_AIM");
    var_7 _id_0378::_id_8D74("aud_fighter_final_explosion", var_20);

    if(!var_16)
      playFX(level._effect["mp_raid_fighter_bounds_death"], var_14 gettagorigin("prop"));

    var_14 _meth_8511();
    wait(var_15);

    if(isDefined(var_14))
      var_14 delete();
  }

  if(isPlayer(var_0) && isDefined(var_0.fighter_sshud))
    var_0.fighter_sshud destroy();

  if(common_scripts\utility::_id_562E(level.gameended))
    level waittill("mp_raid_dlc2_never");

  delete_plane(var_7);
}

fighter_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  var_13 = var_12.occupied_player;

  if(!var_12 fighter_is_alive()) {
    return;
  }
  if(isDefined(var_1.team) && level.teambased && var_12.team == var_1.team && !level.dogfightfriendlyfireenabled) {
    return;
  }
  if(var_4 == "MOD_CRUSH") {
    return;
  }
  if(common_scripts\utility::_id_562E(var_13._id_4B97)) {
    return;
  }
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  var_14 = var_1 _meth_85E2();

  if(isDefined(var_14) && var_14 != var_12)
    var_2 = var_2 * 0.1;

  var_15 = "raid_fighter";

  if(level.dogfightshowui)
    var_1 _id_04C7::_id_A102(var_15);

  var_12.health = var_12.health - int(var_2);
  var_12._id_5B8A = gettime();
  var_12 fighter_on_health_update_func();

  if(1 && level.dogfighthealthregenscale > 0 && var_12.health > 1)
    var_12 thread common_health_regen(2 * level.dogfighthealthregenscale, 0.25 * level.dogfighthealthregenscale, 0.1 * level.dogfighthealthregenscale, ::fighter_on_health_update_func, ::fighter_calc_health_regen_mult, 1);

  if(isDefined(var_13)) {
    var_16 = var_12.health / var_12.maxhealth;
    var_17 = int(var_13.maxhealth * var_16);
    var_13 _meth_8059(var_13.health - var_17, var_1.origin, var_1, var_0, var_4, var_5, var_8);
  }

  var_12 notify("damage", var_2, var_1, var_7, var_6, var_4);

  if(var_12.health <= 1) {
    var_12.health = 1;
    var_12 thread fighter_death(var_13, var_6, var_1, var_0, var_4, var_5, var_8);
  }
}

common_award_pending_assists(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.damageregistry) && var_2.damageregistry.size > 0) {
    var_3 = [];

    foreach(var_5 in var_2.damageregistry) {
      var_6 = var_5[0];
      var_7 = var_5[1];

      if(isDefined(var_0) && var_0 == var_6) {
        continue;
      }
      if(!isDefined(var_3[var_6]))
        var_3[var_6] = 0;

      var_3[var_6] = var_3[var_6] + var_7;
    }

    foreach(var_6, var_7 in var_3) {
      var_10 = undefined;

      foreach(var_12 in level.players) {
        var_13 = var_12 maps\mp\_utility::_id_4704();

        if(var_13 == var_6) {
          var_10 = var_12;
          break;
        }
      }

      var_15 = int(100 * var_7 / var_2.maxhealth);
      var_16 = "assist_low";

      if(var_15 >= 40 && var_15 < 60)
        var_16 = "assist_mid";
      else if(var_15 >= 60 && var_15 < 80)
        var_16 = "assist_high";
      else if(var_15 >= 80)
        var_16 = "assist_steal";

      var_10 thread _id_047A::_id_774E(var_1, var_16);
    }
  }
}

common_clear_pending_assists(var_0) {
  var_1 = self;

  if(!isDefined(var_1.damageregistry)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in var_1.damageregistry) {
    var_5 = var_4[0];
    var_6 = var_4[1];

    if(var_0 <= 0) {
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
      continue;
    }

    if(var_6 >= var_0) {
      var_6 = var_6 - var_0;
      var_0 = 0;
      var_4[1] = var_6;
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
      continue;
    }

    var_0 = var_0 - var_6;
    var_6 = 0;
  }

  var_1.damageregistry = var_2;
}

common_update_pending_assists(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3.damageregistry))
    var_3.damageregistry = [];

  for(var_4 = var_3.damageregistry.size - 1; var_4 >= 0; var_4--) {
    var_5 = var_3.damageregistry[var_4];
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];

    if(var_6 == var_0 && var_2 - var_8 < 500) {
      var_9[2] = var_7 + var_1;
      return;
    }
  }

  var_3.damageregistry = common_scripts\utility::_id_0F6F(var_3.damageregistry, [var_0, var_1, var_2]);
}

bot_planeshootthink(var_0) {
  var_1 = self;
  var_2 = 0.15;
  var_3 = int(var_2 * 20);
  var_4 = 2;
  var_5 = 1.5;
  var_6 = 0;

  for(;;) {
    wait(var_2);

    if(!maps\mp\_utility::gameflag("prematch_done")) {
      continue;
    }
    if(!var_1 _meth_8648()) {
      continue;
    }
    foreach(var_8 in level.players) {
      if(!level.teambased || var_8.team != var_1.team) {
        var_1 _meth_8379(var_8, var_8.origin);

        if(isDefined(var_8.occupied_plane))
          var_1 _meth_8379(var_8.occupied_plane, var_8.occupied_plane.origin);
      }
    }

    var_10 = var_1._id_0088;

    if(!isDefined(var_10)) {
      continue;
    }
    if(distancesquared(var_10.origin, var_0.origin) > 256000000) {
      continue;
    }
    var_11 = vectorNormalize(var_10.origin - var_0.origin);
    var_12 = vectortoangles(var_11);
    var_13 = var_0.angles;
    var_14 = _func_0DD(var_12[1] - var_13[1]);
    var_15 = _func_0DD(var_12[0] - var_13[0]);

    if(_func_0AE(var_14) < 30 && _func_0AE(var_15) < 30)
      var_1 _meth_8380("attack", 1);

    var_6 = var_6 + var_2;

    if(var_6 >= var_4) {
      var_6 = 0;
      wait(var_5);
    }
  }
}

bot_planeflythink(var_0) {
  var_1 = self;
  var_1 notify("bot_fly_think");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("bot_fly_think");
  var_0 endon("death");
  var_1 childthread bot_planeshootthink(var_0);
  var_2 = 0.25;

  for(;;) {
    wait(var_2);

    if(!maps\mp\_utility::gameflag("prematch_done")) {
      continue;
    }
    var_3 = undefined;
    var_4 = var_1._id_0088;
    var_5 = get_dogfight_boundary_center(0);

    if(isDefined(var_4)) {
      var_3 = var_4.origin;
      var_6 = get_dogfight_boundary_radius(1);
      var_7 = var_6 * var_6;

      if(isDefined(var_5) && distancesquared(var_4.origin, var_5) >= var_7)
        var_3 = var_5;
    } else
      var_3 = var_5;

    if(!isDefined(var_3)) {
      continue;
    }
    var_8 = vectorNormalize(var_3 - var_0.origin);
    var_9 = 9437184;

    if(_func_1EF(var_1) && isDefined(var_4))
      var_9 = 0;

    if(var_9 > 0 && distancesquared(var_0.origin, var_3) < var_9)
      var_8 = var_8 * -1;

    var_10 = vectortoangles(var_8);
    var_11 = var_10[1];
    var_12 = var_10[0];

    if(level.teambased && common_scripts\utility::_id_562E(var_1.informationtransition) && isDefined(level.defender_spawn_angles) && isDefined(level.attacker_spawn_angles)) {
      if(var_1.team == game["defenders"]) {
        var_11 = level.defender_spawn_angles[1];
        var_12 = level.defender_spawn_angles[0];
      } else {
        var_11 = level.attacker_spawn_angles[1];
        var_12 = level.attacker_spawn_angles[0];
      }
    }

    var_1 _meth_8355(var_11, var_2, 1, 1, 1, var_12);
  }
}

agent_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!common_scripts\utility::_id_562E(var_7._id_565F)) {
    var_7 _meth_838F(var_0, var_1);
    var_7 _meth_83D6(0);
  }

  if(isDefined(var_2))
    maps\mp\agents\_agent_utility::_id_83FE(var_2.team, var_2);

  var_7.maxhealth = 100;
  var_7.health = var_7.maxhealth;
  var_7.name = "Agent";
  var_7._id_565F = 1;
  var_7._id_4B60 = 0;
  var_7 thread agent_think();
}

agent_think() {
  var_0 = self;
  thread player_spawn_helper(var_0);
}

agent_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  maps\mp\agents\_agents::_id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(self.health <= 0)
    agent_killed(var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
}

agent_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level thread maps\mp\gametypes\_rank::_id_1457("raids_npc_kill", var_1, var_4, self, var_3, var_0);

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(self._id_565F) {
    self._id_4B60 = 1;
    var_9 = self _meth_85E2();

    if(isDefined(var_9))
      self _meth_80F4();
  }
}

bot_spawnagents() {
  var_0 = "bomberEscortFighterAgents";
  level._id_0A41[var_0] = [];
  level._id_0A41[var_0]["spawn"] = ::agent_spawn;
  level._id_0A41[var_0]["think"] = ::agent_think;
  level._id_0A41[var_0]["on_killed"] = ::agent_killed;
  level._id_0A41[var_0]["on_damaged"] = ::agent_damage;
  level._id_0A41[var_0]["on_damaged_finished"] = ::_id_0A40;
  var_1 = (0, 0, 0);
  var_2 = (0, 0, 0);
  var_3 = game["attackers"];

  if(!isDefined(level.bomberescortfighteragents))
    level.bomberescortfighteragents = [];

  var_4 = 3;

  foreach(var_6 in level.bomberescortfighteragents) {
    if(var_6._id_565F && var_6._id_4B60) {
      var_6 thread agent_spawn();
      var_4--;
    }
  }

  for(var_8 = 0; var_8 < var_4; var_8++)
    level.bomberescortfighteragents[level.bomberescortfighteragents.size] = [[level._id_0A4D]](var_0, var_3, undefined, var_1, var_2, self, 0, 0, "recruit");
}