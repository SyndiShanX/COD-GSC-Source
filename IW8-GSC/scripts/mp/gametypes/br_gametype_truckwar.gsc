/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_truckwar.gsc
*********************************************************/

function init() {
  thread enemy_claymore_watchfortrigger();
  thread enemy_clear_scrambler();
  thread enemy_aggro_at_closest_player();
  thread enemy_ai_enter_alert_due_to_grenade_explode();
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 20);
  level.ref_12CB4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.dialog_wait_ready_civ = 0;
  level.ref_13ECD = getdvarint("scr_truckwar_circleMoving", 1) == 1;
  level.ref_13ED1 = getdvarint("scr_truckwar_useDefaultCircleSizes", 1) == 1;
  level.ref_13EC3 = 15;
  var_0 = getDvar("scr_truckwar_circleSizeOverride", "101600 42500 30200 20300 14000 10000 5000 0");

  if(var_0 != "") {
    level.ref_13ECF = [];
    var_1 = strtok(var_0, " ");

    foreach(var_3 in var_1) {
      level.ref_13ECF[level.ref_13ECF.size] = float(var_3);
    }
  }

  var_5 = getDvar("scr_truckwar_circleCloseTimeOverride", "270 220 170 110 70 50 50 50");

  if(var_5 != "") {
    level.ref_13EC2 = [];
    var_6 = strtok(var_5, " ");

    foreach(var_3 in var_6) {
      level.ref_13EC2[level.ref_13EC2.size] = float(var_3);
    }
  }

  var_9 = getDvar("scr_truckwar_circleDelayTimeOverride", "220 90 75 60 60 45 30 20");

  if(var_9 != "") {
    level.ref_13EC7 = [];
    var_10 = strtok(var_9, " ");

    foreach(var_3 in var_10) {
      level.ref_13EC7[level.ref_13EC7.size] = float(var_3);
    }
  }

  level.ref_13ED0 = getdvarfloat("scr_truckwar_circleStartRadius", 50000);
  level.ref_13ECA = getdvarfloat("scr_truckwar_circleInnerSize", 40000);
  level.ref_13ECB = getdvarfloat("scr_truckwar_circleMinSize", 10000);
  level.ref_13EBF = getdvarfloat("scr_truckwar_circleCloseMinTime", 30);
  level.ref_13EC0 = getdvarfloat("scr_truckwar_circleCloseTime", 220);
  level.ref_13EC1 = getdvarfloat("scr_truckwar_circleCloseTimeChange", 40);
  level.ref_13EC5 = getdvarfloat("scr_truckwar_circleDelayTime", 60);
  level.ref_13EC6 = getdvarfloat("scr_truckwar_circleDelayTimeChange", 10);
  level.ref_13EC4 = getdvarfloat("scr_truckwar_circleDelayMinTime", 10);
  level.ref_13ECE = getdvarint("scr_truckwar_circleOutOfBoundsPadding", 1);
  level.ref_13EC9 = getdvarfloat("scr_truckwar_circleInitialDelayTime", 60);
  level.ref_13EC8 = getdvarfloat("scr_truckwar_circleInitialCloseTime", 330);
  level.ref_13ECC = getdvarfloat("scr_truckwar_circleMoveDist", 1);

  if(level.ref_13ECD) {
    setDvar("scr_br_moving_circle_enabled", 1);
    level.decoyassists = &brmini_initdialog;
  }

  stoppingpower_givehcrdata(level);
}

function enemy_claymore_watchfortrigger() {
  if(getdvarint("scr_brtruck_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("vehicleSpawns");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("c130PlaneLine");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
}

function enemy_clear_scrambler() {
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &enemy_goto_struct_on_spawn);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onStartGameType", &onstartgametype);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerKilledSpawn", &ref_125F7);
  scripts\mp\gametypes\br_gametypes::ref_12B11("markPlayerAsEliminatedOnKilled", &ref_11B16);
  scripts\mp\gametypes\br_gametypes::ref_12B11("mayConsiderPlayerDead", &ref_11B80);
  scripts\mp\gametypes\br_gametypes::ref_12B11("isTeamEliminated", &validate_and_activate_stations);
  scripts\mp\gametypes\br_gametypes::ref_12B11("infilSequence", &manage_fakebody_hides);
  waittillframeend();
  scripts\mp\flags::gameflaginit("use_truck_respawn", 0);
  level.ontimelimit = &enemy_fallback_logic;
  level.ref_11C7A = &ref_125F7;
  enemies_validate_life();
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
  level.ref_1385F = 0;

  if(level.ref_13ECD) {
    thread enemy_damage_monitoring();
  }

  thread ref_13DF8();
}

function enemy_aggro_at_closest_player() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["vehicle_under_attack"] = "truckwars_armored_vehicle_under_attack";
  game["dialog"]["vehicle_spawn_disabled"] = "truckwars_armored_vehicle_spawn_disabled";
  game["dialog"]["vehicle_spawn_enabled"] = "truckwars_armored_vehicle_spawn_enabled";
  game["dialog"]["vehicle_destroyed"] = "truckwars_armor_vehicle_destroyed";
  game["dialog"]["vehicle_spawn_over"] = "truckwars_disable_vehicle_respawn";
  game["dialog"]["mode_intro"] = "truckwars_intro_armored_vehicle";
}

function enemies_validate_life() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12C11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("me_electrical_box_street_01", 1);
}

function enemy_ai_enter_alert_due_to_grenade_explode() {
  level._effect["light_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

function onstartgametype() {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start)) {
    level.debug_vault_assault_retrieve_saw_obj_start = [];
  }

  level.debug_vault_assault_retrieve_saw_obj_start[level.debug_vault_assault_retrieve_saw_obj_start.size] = scripts\mp\gametypes\br_circle::init_safehouse_gunshop((-32000, 53750, 2266), 16000);
  initspawns();
  thread trace_to_eye_weight();
  thread ref_1338B();
}

function enemy_goto_struct_on_spawn(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!istrue(self.pers["streamSyncComplete"])) {
    self waittill("player_active");
  }

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_truckwar_prematch_welcome");
  self waittill("do_welcome_splashes");
  wait 2;
  scripts\mp\hud_message::showsplash("br_gametype_truckwar_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mode_intro", self, 0);

  while(!self isonground()) {
    waitframe();
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
}

function enemy_fallback_logic() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function ref_11B80(var_0) {
  return true;
}

function ref_11B16() {
  return true;
}

function vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.showheadicon = 1;
  return var_1;
}

function registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();
  level.vehicleinfo[var_0] = var_3;
}

function vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_2, var_1);
}

function ref_14266(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var_2, var_1);
}

function vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var_2, var_1);
}

function ref_14263(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_mg", var_2, var_1);
}

function vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var_2, var_1);
}

function vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var_2, var_1);
}

function ref_14267(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("motorcycle", var_2, var_1);
}

function trace_to_eye_weight() {
  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  if(getdvarint("scr_allow_vehicle_cargo_truck_mg", 1) == 1) {
    registervehicletype("cargo_truck_mg", &_calloutmarkerping_isdropcrate::get_health_multiplier_relic_mythic, &ref_14263);
  }

  if(getdvarint("scr_allow_vehicle_little_bird", 1) == 1) {
    registervehicletype("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, &vehiclespawn_littlebird);
  }

  if(getdvarint("scr_allow_vehicle_little_bird_mg", 1) == 1) {
    registervehicletype("little_bird_mg", &_calloutmarkerping_poolidisdanger::x1stash_detectplayers, &ref_14266);
  }

  if(getdvarint("scr_allow_vehicle_atv", 1) == 1) {
    registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  }

  if(getdvarint("scr_allow_vehicle_jeep", 1) == 1) {
    registervehicletype("jeep", &scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, &vehiclespawn_jeep);
  }

  if(getdvarint("scr_allow_vehicle_tac_rover", 1) == 1) {
    registervehicletype("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, &vehiclespawn_tacrover);
  }

  if(getdvarint("scr_allow_vehicle_motorcycle", 1) == 1) {
    registervehicletype("motorcycle", &_calloutmarkerping_poolidisentity::ref_11D5E, &ref_14267);
  }

  level waittill("prematch_fade_done");
  wait 2;
}

function cargo_truck_mg_reenter() {
  level.vehiclespawnlocs = [];
  level.ref_13ACF = [];

  foreach(var_1 in level.vehicleinfo) {
    switch (var_1.refname) {
      case "cargo_truck_mg":
        var_1.vehiclespawns = run_spawn_module_till_kill_trig("cargo_truck_mg", "mkilo_physics_mg");
        break;
    }

    foreach(var_3 in var_1.vehiclespawns) {
      var_4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var_4] = var_3;
      level.vehiclespawnlocs[var_4].refname = var_1.refname;
    }
  }

  scripts\mp\gametypes\br_vehicles::ref_13E0C(level.vehiclespawnlocs);

  if(false) {
    foreach(var_8 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var_8.origin, var_8.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);

  if(false) {
    for(var_10 = 0; var_10 < level.vehiclespawnlocs.size; var_10++) {
      var_8 = level.vehiclespawnlocs[var_10];
      thread scripts\mp\utility\debug::drawline(var_8.origin + (0, 0, 1500), var_8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  var_11 = 0;

  foreach(var_13 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_13, "players").size == 0) {
      continue;
    }

    while(var_11 < level.vehiclespawnlocs.size) {
      var_8 = level.vehiclespawnlocs[var_11];

      if(isDefined(var_8)) {
        if(var_8.refname == "cargo_truck_mg") {
          level.ref_13ACF[var_13] = var_8;
          var_11++;
          break;
        }
      }

      var_11++;
    }
  }

  scripts\mp\flags::gameflagset("trucks_spawn_complete");
}

function ref_136AA() {
  var_0 = [];

  foreach(var_2 in level.ref_13ACF) {
    var_3 = level.vehicleinfo[var_2.refname];
    var_4 = [[var_3.spawncallback]](var_2);
    var_0 = var_4;
  }

  level.ref_13ACE = var_0;
  var_6 = getdvarint("scr_truckwar_max_vehicle_count", 120);
  var_7 = var_6 - var_0.size;

  for(var_8 = 0; var_8 < level.vehiclespawnlocs.size && var_7 > 0; var_8++) {
    var_2 = level.vehiclespawnlocs[var_8];

    if(isDefined(var_2)) {
      if(var_2.targetname == "motorcycle_spawn") {
        var_3 = level.vehicleinfo["motorcycle"];
        var_4 = [[var_3.spawncallback]](var_2);
        var_7--;
        var_8++;
        continue;
      }

      if(var_2.refname != "cargo_truck_mg") {
        var_3 = level.vehicleinfo[var_2.refname];
        var_4 = [[var_3.spawncallback]](var_2);
        var_7--;
      }
    }
  }
}

function cargo_truck_mg_removegunnerdamagemod() {
  var_0 = level.ref_13ACE;
  level.ref_13ACE = [];
  level.ref_13AA7 = [];
  level.ref_13ACD = [];
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_3, "players").size == 0) {
      continue;
    }

    var_4 = var_0[var_1];
    thrownoffhand(var_4, var_3);
    var_1++;
  }
}

function thrownoffhand(var_0, var_1, var_2) {
  level.ref_13ACE[var_1] = var_0;
  level.ref_13AA7[var_1] = 1;
  thread ref_14505(level, var_0);
  thread ref_14506(level, var_0);
  thread ref_11ECF(level, var_0);
  thread ref_11ED0(level, var_0);
  thread ref_11ED1(level, var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, var_1);
  var_0 setscriptablepartstate("objective", "on");
  var_3 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var_0.health);
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var_0.maxhealth);

    if(istrue(var_2) && getdvarint("scr_truckwar_truck_replacement_respawn", 1) == 1 && !istrue(level.ref_13DF4)) {
      if(istrue(var_5.delay_enter_combat_after_investigating_grenade)) {
        var_5.setspawnpoint = undefined;
        thread playerrespawn(var_5);
      }
    }
  }

  ref_1402C(var_1);
}

function ref_14505(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  var_0.ref_1441F = 0;
  var_0.ref_14421 = 0;
  var_0.ref_14420 = 0;
  var_2 = getdvarfloat("scr_truckwar_gas_warning_close", 15);
  var_3 = getdvarfloat("scr_truckwar_gas_warning_medium", 30);
  var_4 = getdvarfloat("scr_truckwar_gas_warning_far", 45);
  var_5 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_7 in var_5) {
    var_7 scripts\engine\utility::ent_flag_init("respawn_vehicle_in_gas");
  }

  while(isDefined(var_0)) {
    if(istrue(var_0.stop_pressure_sensor)) {
      waitframe();
      continue;
    }

    if(istrue(level.group_unset_jugg_standstill)) {
      if(!var_0.ref_1441F && getgamewinnerprop(var_0.origin, var_2)) {
        showsplashtoteam(var_1, "br_gametype_truckwar_gas_is_approaching_close");
        var_0.ref_1441F = 1;
        var_0.ref_14421 = 1;
        var_0.ref_14420 = 1;
      } else if(!var_0.ref_14421 && getgamewinnerprop(var_0.origin, var_3)) {
        showsplashtoteam(var_1, "br_gametype_truckwar_gas_is_approaching_medium");
        var_0.ref_14421 = 1;
        var_0.ref_14420 = 1;
      } else if(!var_0.ref_14420 && getgamewinnerprop(var_0.origin, var_4)) {
        showsplashtoteam(var_1, "br_gametype_truckwar_gas_is_approaching_far");
        var_0.ref_14420 = 1;
      }
    } else {
      var_0.ref_1441F = 0;
      var_0.ref_14421 = 0;
      var_0.ref_14420 = 0;
    }

    var_9 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var_10 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var_11 = getdvarint("scr_truckwar_force_in_gas", 0) == 1;

    if(var_11 || distance2dsquared(var_9, var_0.origin) > var_10 * var_10) {
      thread midpos();

      if(level.ref_13AA7[var_1] == 1) {
        level.ref_13AA7[var_1] = 0;
        var_5 = scripts\mp\utility\teams::getteamdata(var_1, "players");

        foreach(var_7 in var_5) {
          var_7 scripts\engine\utility::ent_flag_set("respawn_vehicle_in_gas");
        }

        showsplashtoteam(var_1, "br_gametype_truckwar_vehicle_spawn_disabled");
        level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_disabled", 0, var_5, undefined);
        level thread[[level.updategameevents]]();
      }
    } else if(level.ref_13AA7[var_1] == 0) {
      var_0 notify("vehicle_gas_exit");
      var_0.ref_128AD = 0;
      level.ref_13AA7[var_1] = 1;
      var_5 = scripts\mp\utility\teams::getteamdata(var_1, "players");

      foreach(var_7 in var_5) {
        var_7 scripts\engine\utility::ent_flag_clear("respawn_vehicle_in_gas");
      }

      showsplashtoteam(var_1, "br_gametype_truckwar_vehicle_spawn_enabled");
      level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_enabled", 0, var_5, undefined);
      level thread[[level.updategameevents]]();
    }

    waitframe();
  }
}

function midpos() {
  self endon("death");
  self endon("vehicle_gas_exit");

  if(istrue(self.ref_128AD)) {
    return;
  }

  self.ref_128AD = 1;
  var_0 = getdvarfloat("scr_truckwar_vehicle_gas_dps", 0.05);
  var_1 = self.maxhealth * var_0;

  while(isDefined(self)) {
    wait 1;
    self dodamage(var_1, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  }
}

function ref_14506(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  var_0.ref_120B3 = 0;
  var_2 = getdvarfloat("scr_truckwar_oob_empty_window", 15);
  var_3 = getdvarfloat("scr_truckwar_oob_kill_time", 5);
  var_4 = var_0.isempty;
  var_5 = 0;
  var_6 = undefined;

  for(;;) {
    if(!var_4 && var_0.isempty) {
      var_6 = gettime() + var_2 * 1000;
    }

    var_4 = var_0.isempty;

    if(isDefined(var_6) && gettime() < var_6 || var_5) {
      var_7 = 0;
      var_8 = undefined;

      foreach(var_10 in level.outofboundstriggers) {
        if(var_0 istouching(var_10)) {
          var_0.ref_120B3 += level.framedurationseconds;
          var_7 = 1;
          var_8 = var_10;
          break;
        }
      }

      var_5 = var_7;

      if(!var_7) {
        var_0.ref_120B3 -= level.framedurationseconds;
      }

      var_0.ref_120B3 = clamp(var_0.ref_120B3, 0, var_3);

      if(var_0.ref_120B3 == var_3) {
        var_0 dodamage(999999, var_0.origin, var_8, var_8, "MOD_TRIGGER_HURT");
      }
    }

    waitframe();
  }
}

function ref_11ECF(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  var_2 = getdvarfloat("scr_truckwar_damage_taken_window", 5) * 1000;
  var_3 = undefined;

  while(isDefined(var_0)) {
    var_0 waittill("damage_taken", var_4);
    var_0.lastdamagedtime = gettime();
    thread connected_search_node(var_0);
    var_5 = scripts\mp\utility\teams::getteamdata(var_1, "players");

    foreach(var_7 in var_5) {
      var_7 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var_0.health);
      var_7 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var_0.maxhealth);
    }

    if(isDefined(var_3) && var_3 + var_2 > gettime()) {
      continue;
    }

    var_3 = gettime();
    var_5 = scripts\mp\utility\teams::getteamdata(var_1, "players");
    showsplashtoteam(var_1, "br_gametype_truckwar_vehicle_under_attack");
    level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_under_attack", 0, var_5, undefined);

    foreach(var_7 in var_5) {
      if(!istrue(var_7.ref_13DF3)) {
        var_10 = game["music"]["br_truck_attacked"].size;
        var_11 = randomint(var_10);
        var_7 setplayermusicstate(game["music"]["br_truck_attacked"][var_11]);
        var_7.ref_13DF3 = 1;
      }
    }
    LOC_0000016b:
  }
}

function connected_search_node(var_0) {
  self endon("death");
  self notify("blockHealing");
  self endon("blockHealing");
  self.showquestobjicontoplayer = 1;
  ref_1402C(var_0);
  var_1 = getdvarfloat("scr_truckwar_repair_damage_ignore", 15);
  wait var_1;
  self.showquestobjicontoplayer = 0;
  ref_1402C(var_0);
}

function ref_11ED1(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");

  while(isDefined(var_0)) {
    var_0 waittill("upgrade_message", var_2);

    if(var_2 != "trophy_ammo_used") {
      var_3 = rotatetowithpause(var_2);
      showsplashtoteam(var_1, var_3);
    }

    ref_1402C(var_1);
  }
}

function rotatetowithpause(var_0) {
  switch (var_0) {
    case "armor_upgraded":
      return "br_gametype_truckwar_vehicle_armor_upgraded";
    case "trophy_activated":
      return "br_gametype_truckwar_vehicle_trophy_activated";
    case "uav_activated":
      return "br_gametype_truckwar_vehicle_portable_radar_activated";
    case "barrel_activated":
      return "br_gametype_truckwar_vehicle_barrel_upgraded";
    case "trophy_no_ammo":
      return "br_gametype_truckwar_vehicle_trophy_no_ammo";
    case "trophy_ammo_refill":
      return "br_gametype_truckwar_vehicle_trophy_refilled";
  }
}

function ref_11ED0(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_4 in var_2) {
    var_4 scripts\engine\utility::ent_flag_init("respawn_vehicle_death");
  }

  var_0 waittill("death");
  level.ref_13AA7[var_1] = 0;
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_4 in var_2) {
    var_4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", 0);
    var_4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", 1);
    var_4 scripts\engine\utility::ent_flag_set("respawn_vehicle_death");
  }

  showsplashtoteam(var_1, "br_gametype_truckwar_vehicle_destroyed");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_destroyed", 0, var_2, undefined);
  level thread[[level.updategameevents]]();
  ref_1402C(var_1);
}

function run_spawn_module_till_kill_trig(var_0, var_1) {
  if(level.mapname != "mp_br_mechanics") {
    return revive_icon_color_keep(var_0, var_1);
  }

  var_2 = level.teamnamelist.size;
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_5, "players").size > 0) {
      var_3++;
    }
  }

  var_2 = var_3;
  var_7 = 360 / var_2;
  var_8 = (0, 0, 100);

  if(level.mapname == "mp_br_mechanics") {
    var_8 = (0, 0, 100);
    var_9 = 5000;
  } else {
    var_9 = (4000, 10000, 100);
    var_9 = 40000;
  }

  var_10 = scripts\engine\trace::create_default_contents(1);
  var_11 = [];

  for(var_12 = 0; var_12 < var_3; var_12++) {
    var_13 = var_12 * var_8;
    var_14 = anglesToForward((0, var_13, 0));
    var_15 = var_9 + var_14 * var_9;
    var_16 = scripts\engine\utility::drop_to_ground(var_15, 10000, -20000, undefined, var_10);
    var_15 = (var_15[0], var_15[1], var_16[2] + 200);
    var_17 = spawnStruct();
    var_17.origin = var_15;
    var_18 = (0, 0, 0);
    var_17.angles = vectortoangles(var_14 * -1);
    var_17.targetname = var_1;
    var_17.vehicletype = var_2;
    var_11 = var_17;
  }

  return var_11;
}

function revive_icon_color_keep(var_0, var_1) {
  var_2 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var_2.size, (-2533.7, 54787.8, 934.125));
  }

  GscBinSkip0(0x2e, var_2.size, (-2533.7, 54787.8, 934.125));
}

function remove_hover_direction_and_try_issue_retreat(var_0, var_1) {
  var_2 = [];
  var_3 = 3;
  var_4 = 360 / var_3;
  var_5 = (0, 0, 100);
  var_6 = 1000;

  for(var_7 = 0; var_7 < var_3; var_7++) {
    var_8 = var_7 * var_4;
    var_9 = anglesToForward((0, var_8, 0));
    var_10 = var_5 + var_9 * var_6;
    var_11 = spawnStruct();
    var_11.origin = var_10;
    var_12 = (0, 0, 0);
    var_11.angles = vectortoangles(var_9 * -1);
    var_11.targetname = var_0;
    var_11.vehicletype = var_1;
    var_2 = var_11;
  }

  return var_2;
}

function validate_and_activate_stations(var_0) {
  if(!isDefined(level.ref_13AA7)) {
    return false;
  }

  return scripts\mp\utility\teams::getteamdata(var_0, "aliveCount") == 0 && (!istrue(level.ref_13AA7[var_0]) || istrue(level.ref_13DF4));
}

function ref_125F7(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("use_truck_respawn")) {
    return false;
  }

  thread playerrespawn(var_0.victim, 0, var_0);
  var_0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, var_1);
  return true;
}

function playerrespawn(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_auto_win");
  self notify("playerRespawn");
  self endon("playerRespawn");

  if(istrue(level.gameended)) {
    return;
  }

  if(istrue(level.ref_13DF4) || validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13DC2();
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var_3 = level.checkpoint_objective_id;

  if(istrue(var_0)) {
    var_3 = 0;
  }

  var_4 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 5);

  if(var_3 < var_4) {
    var_3 = var_4;
  }

  if(level.ref_12CB4 != 0) {
    var_3 = 0;
  }

  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread kioskfixupproneplayers(var_3);
  var_5 = var_3 - var_4;
  var_6 = var_3 - var_5;
  var_7 = var_3 - getdvarfloat("scr_bmo_respawn_intermission_time", 5);
  thread patchfix(var_7);
  var_8 = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", var_5);

  if(var_8 != "respawn_vehicle_death") {
    thread ref_1400C();
    var_8 = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", var_6);
  }

  self notify("stop_updatePrestreamRespawn");

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13132();
  } else if(scripts\engine\utility::ent_flag("respawn_vehicle_in_gas")) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(79);
  }

  while(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && !scripts\engine\utility::ent_flag("respawn_vehicle_death") && !level.ref_13AA7[self.team] || scripts\cp_mp\utility\player_utility::isusingremote()) {
    waitframe();
  }

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13132();
  }

  if(validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var_1, var_2);
    thread scripts\mp\gametypes\br_spectate::ref_13DC2();
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    return;
  }

  var_9 = getspawnpoint();
  var_10 = scripts\mp\gametypes\br_gulag::ref_1263E(var_9);
  var_11 = level.ref_13ACE[self.team].origin;

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ED();
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.force_players_out_of_vehicle = [];
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && isDefined(level.ref_124E7)) {
    var_9 = scripts\engine\utility::getStruct(level.ref_124E7, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_9, 1, var_10, 1, undefined, 0, 0, 1);
  var_12 = vectortoangles(var_11 - var_10);
  self setplayerangles(var_12);
  self notify("respawn_view_set");
  scripts\mp\gametypes\br::ref_13F21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");

  if(isDefined(level.ref_13ACE[self.team])) {
    var_11 = level.ref_13ACE[self.team].origin;
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", level.ref_13ACE[self.team].health);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", level.ref_13ACE[self.team].maxhealth);
  }

  level thread scripts\mp\gametypes\br_quest_util::ref_140B1(var_11, "revive");
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  ref_1402C(self.team);
}

function kioskfixupproneplayers(var_0) {
  self endon("disconnect");
  waitframe();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
}

function patchfix(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(validate_and_activate_stations(self.team) || !level.ref_13AA7[self.team]) {
    return;
  }

  var_1 = 1;
  thread fadeoutin();
  wait var_1 - 0.25;
  scripts\mp\gametypes\br::ending_fade_in();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  wait 0.25;

  if(validate_and_activate_stations(self.team) || !level.ref_13AA7[self.team]) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252B();
    var_2 = getspawnpoint();
    scripts\mp\gametypes\br_spectate::ref_1252A();
    scripts\mp\gametypes\br::spawnintermission(var_2.origin, var_2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  var_0 = scripts\engine\utility::ref_143B5("spawned_player", "respawn_vehicle_in_gas", "gulag_auto_win");

  if(var_0 == "spawned_player" || var_0 == "respawn_vehicle_in_gas") {
    self waittill("respawn_view_set");
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  }

  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_1400C() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");
  self endon("respawn_vehicle_death");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var_0 = getspawnpoint();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var_0 = getspawnpoint();
        var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
      }
    } else {
      var_0 = getspawnpoint();
      var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
    }

    wait 1;
  }
}

function initspawns() {
  level.ref_1365E = getdvarfloat("scr_spawn_height", 2500);
}

function getspawnpoint(var_0) {
  if(!isDefined(self.ref_12AB3)) {
    self.ref_12AB3 = spawnStruct();
    return pre_race(istrue(var_0));
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    var_1 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(var_3 in level.teamnamelist) {
        if(var_3 != self.team) {
          self playsoundtoteam("tactical_spawn", var_3);
        }
      }
    }

    var_5 = self.setspawnpoint.playerspawnpos;
    var_6 = scripts\engine\trace::create_default_contents(1);
    var_7 = scripts\engine\utility::drop_to_ground(var_5, 10000, -20000, undefined, var_6);
    var_5 = (var_5[0], var_5[1], var_7[2]);
    var_5 += (0, 0, 1) * level.endsuperdisableweaponbr.ref_1365E[self.team];

    if(getdvarint("scr_brtdm_spawn_debug") == 1) {
      thread scripts\mp\utility\debug::drawline(var_5, var_7, 15, (1, 1, 0));
    }

    self.ref_12AB3.origin = var_5;
    self.ref_12AB3.angles = self.setspawnpoint.playerspawnangles;
    self.ref_12AB3.lifeid = self.lifeid;
    self.ref_12AB3.time = gettime();
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
  } else if(self.ref_12AB3.team != self.team || self.ref_12AB3.lifeid != self.lifeid || istrue(self.ref_12AB3.updateclientmatchdata)) {
    return pre_race(istrue(var_0));
  }

  return self.ref_12AB3;
}

function pre_race(var_0) {
  var_1 = level.ref_13ACE[self.team].origin;
  var_2 = scripts\engine\trace::create_default_contents(1);
  var_3 = scripts\engine\trace::ray_trace(var_1 + (0, 0, 10000), var_1 - (0, 0, 20000), undefined, var_2)["position"];
  var_1 = (var_1[0], var_1[1], var_3[2] + level.ref_1365E);

  if(istrue(level.ref_13ECD) && getdvarint("scr_truckwar_respawn_lookahead", 1) == 1) {
    if(istrue(level.group_unset_jugg_standstill)) {
      var_4 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      var_5 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var_6 = var_4 - var_1;
      var_7 = distance2d(var_4, var_1);

      if(var_7 > var_5) {
        var_8 = vectorNormalize(var_6);
        var_9 = 0;
        var_10 = 0;

        if(level.br_circle.circleindex == 0) {
          var_11 = level.br_level.br_circleradii[level.br_circle.circleindex];
          var_9 = var_11 - var_5;
        } else {
          var_12 = level.br_level.default_class_chosen[level.br_circle.circleindex];
          var_9 = distance2d(var_4, var_12);
        }

        var_13 = level.br_level.br_circleclosetimes[level.br_circle.circleindex + 1];
        var_14 = var_9 / var_13;
        var_15 = var_14 * getdvarfloat("scr_truckwar_respawn_lookahead_time", 10);
        var_1 += var_8 * var_15;
        var_16 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        var_17 = scripts\mp\gametypes\br_circle::getdangercircleradius();

        if(distance2dsquared(var_1, var_16) > var_17 * var_17) {
          var_18 = vectorNormalize(var_1 - var_16);
          var_1 = var_16 + var_18 * var_17 * 0.99;
        }
      }
    }
  }

  self.ref_12AB3.origin = var_1;
  self.ref_12AB3.angles = level.ref_13ACE[self.team].angles;
  self.ref_12AB3.time = gettime();
  self.ref_12AB3.team = self.team;
  self.ref_12AB3.index = -1;
  self.ref_12AB3.lifeid = self.lifeid;
  self.ref_12AB3.updateclientmatchdata = var_0;
  return self.ref_12AB3;
}

function ref_144F4() {
  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  var_0 = 1;

  for(;;) {
    waitframe();

    if(getdvarint("scr_truckwar_mark_spawn", 0) != 0) {
      var_1 = 1000;
      radiusdamage(level.ref_13ACE["axis"].origin, 1000, var_1, var_1);
    }
  }
}

function beacon() {
  if(!isDefined(level.ref_13DF9)) {
    level.ref_13DF9 = [];
  }

  level.ref_13DF9[level.ref_13DF9.size] = level.players[0].origin;

  foreach(var_1 in level.ref_13DF9) {}
}

#using_animtree("");

function stoppingpower_givehcrdata(var_0) {
  level.scr_animtree["ac130"] = #animtree;
  level.scr_anim["ac130"]["truck_drop"] = $mp_mkilo23_gunner_drop_acharlie130;
  level.scr_animname["ac130"]["truck_drop"] = "mp_mkilo23_gunner_drop_acharlie130";
  level.scr_anim["ac130"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_acharlie130_trimmed;
  level.scr_animname["ac130"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_acharlie130_trimmed";
  level.scr_animtree["parachute"] = #animtree;

  if(isDefined(var_0) && istrue(var_0)) {
    level.scr_anim["parachute"]["truck_drop"] = % mp_carpoc_suv_drop_parachute;
    level.scr_animname["parachute"]["truck_drop"] = "mp_carpoc_suv_drop_parachute";
  } else {
    level.scr_anim["parachute"]["truck_drop"] = % mp_mkilo23_gunner_drop_parachute;
    level.scr_animname["parachute"]["truck_drop"] = "mp_mkilo23_gunner_drop_parachute";
  }

  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &ref_121C2, "truck_drop");

  if(isDefined(var_0) && istrue(var_0)) {
    level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_carpoc_suv_drop_parachute_trimmed;
    level.scr_animname["parachute"]["truck_drop_trimmed"] = "mp_carpoc_suv_drop_parachute_trimmed";
  } else {
    level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_parachute_trimmed;
    level.scr_animname["parachute"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_parachute_trimmed";
  }

  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &ref_121C2, "truck_drop_trimmed");
  stoppingpower_loadoutchangeremovehcr();
}

function stoppingpower_loadoutchangeremovehcr() {
  level.scr_animtree["truck"] = #animtree;
  level.scr_anim["truck"]["truck_drop"] = $mp_mkilo23_gunner_drop_mkilo23;
  level.scr_anim["truck"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_mkilo23_trimmed;
}

function ref_13DE4(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(istrue(var_3), "truck_drop", "truck_drop_trimmed");
  var_0.animname = "truck";
  var_0.should_display_reinforcement_called_icon = 1;
  var_0 vehphys_forcekeyframedmotion();
  var_0 hide();
  var_5 = spawn("script_model", var_1);
  var_5.angles = var_2;
  var_5 setModel("tag_origin");
  var_6 = undefined;
  var_7 = spawn("script_model", var_1);
  var_7.angles = var_2;
  var_7.animname = "parachute";
  var_7 setModel("veh8_mil_lnd_bromeo_parachute");
  var_7 scripts\common\anim::setanimtree();
  var_7 unmarkkeyframedmover(1);
  var_7 hide();
  var_8 = undefined;

  if(istrue(var_3)) {
    var_8 = spawn("script_model", var_1);
    var_8.angles = var_2;
    var_8.animname = "ac130";
    var_8 setModel("veh8_mil_air_acharlie130_ks_carrier");
    var_8 scripts\common\anim::setanimtree();
    var_8 hide();
  }

  var_5.vehicle = var_0;
  var_5.parachute = var_7;
  var_5.carrier = var_8;
  var_5.objent = var_6;
  var_9 = gettime() + level.frameduration;
  var_5.endtime = gettime();
  var_5.vehicleendtime = var_9 + getanimlength(level.scr_anim["truck"][var_4]) * 1000;

  if(var_5.vehicleendtime > var_5.endtime) {
    var_5.endtime = var_5.vehicleendtime;
  }

  var_5.parachuteendtime = var_9 + getanimlength(level.scr_anim["parachute"][var_4]) * 1000;

  if(var_5.parachuteendtime > var_5.endtime) {
    var_5.endtime = var_5.parachuteendtime;
  }

  var_5.carrierendtime = var_9 + getanimlength(level.scr_anim["ac130"][var_4]) * 1000;

  if(var_5.carrierendtime > var_5.endtime) {
    var_5.endtime = var_5.carrierendtime;
  }

  thread ref_13DE5(var_5);
  return var_0;
}

function ref_13DE5(var_0) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, var_0);
  scripts\common\anim::anim_first_frame_solo(self.parachute, var_0);

  if(isDefined(self.carrier)) {
    scripts\common\anim::anim_first_frame_solo(self.carrier, var_0);
  }

  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    self.vehicle.stop_pressure_sensor = 1;
    thread scripts\common\anim::anim_single_solo(self.vehicle, var_0);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, var_0);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("iw8_cargotruck_drop_c130");
    self.carrier setscriptablepartstate("lights2", "on", 0);
    self.carrier setscriptablepartstate("contrails", "on", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, var_0);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime) {
      thread ref_13DE6(self.vehicle);
    }

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime) {
      self.parachute delete();
    }

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime) {
      self.carrier delete();
    }

    waitframe();
  }

  thread ref_13DE6(self.vehicle);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function ref_13DE6(var_0) {
  self.vehicle = undefined;

  if(isDefined(var_0)) {
    var_0 vehphys_setdefaultmotion();
    thread ref_13DE9();
    return;
  }
}

function ref_13DE9() {
  self endon("death");
  self physics_registerforcollisioncallback();
  waitframe();
  var_0 = gettime() + 5000;
  var_1 = undefined;
  var_2 = undefined;

  while(gettime() < var_0) {
    if(!isDefined(var_1)) {
      var_1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    } else {
      var_3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var_4 = (var_3 - var_1) / level.framedurationseconds;

      if(isDefined(var_2)) {
        if(var_2 - var_4 >= 300) {
          ref_13DE7(self.origin, self.angles);
          break;
        }
      }

      <
      error > = var_1;
      var_0 = var_2;
    }

    waitframe();
  }

  self physics_unregisterforcollisioncallback();
}

function ref_13DE7(var_0, var_1) {
  self.stop_pressure_sensor = 0;
  playFX(scripts\engine\utility::getfx("light_tank_land"), var_0, anglesToForward(var_1));
  playsoundatpos(var_0, "iw8_c130_drop_mkilo");
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("grenade_rumble", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

function ref_121C2(var_0) {
  var_0 playSound("iw8_c130_drop_mkilo_chute");
}

function showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_3 scripts\mp\hud_message::showsplash(var_1);
  }
}

function manage_fakebody_hides(var_0) {
  thread ref_13DF7(var_0);

  if(getdvarint("scr_truckwar_repair_station", 1) == 1) {
    thread toma_strike_watch_owner();
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  scripts\mp\deathicons::ref_12BFD();
  scripts\mp\flags::gameflaginit("trucks_spawn_complete", 0);
  thread cargo_truck_mg_reenter();
  scripts\mp\flags::gameflagwait("trucks_spawn_complete");

  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      var_2 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13F21(var_2);
    }

    var_2 setclientomnvar("ui_br_infil_started", 1);
    var_2 setclientomnvar("ui_br_infiled", 1);
    var_2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    thread ref_13919();
    LOC_000000d8:
  }

  wait 2;
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(var_2 in level.players) {
    var_2 playsoundtoplayer("tw_ac130_flyby", var_2, var_2);
  }

  wait 2;
  ref_136AA();
  cargo_truck_mg_removegunnerdamagemod();

  foreach(var_2 in level.players) {
    thread ref_12095();
    LOC_0000015c:
  }

  thread ref_144D7();
  scripts\mp\flags::gameflagset("use_truck_respawn");
}

function ref_13DF7(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclienttriggeraudiozone("donetsk_ext_ac130_infil", 1);
    var_3 = game["music"]["truckwars_infil"].size;
    var_4 = randomint(var_3);
    var_2 setplayermusicstate(game["music"]["truckwars_infil"][var_4]);
  }

  wait 3;

  foreach(var_2 in level.players) {
    var_2 playlocalsound("scr_br_infil_ac130_klaxon", undefined, undefined, 1);
  }

  wait 0.8;

  foreach(var_2 in level.players) {
    var_2 playlocalsound("scr_br_infil_jump_stinger", undefined, undefined, 1);
    var_2 clearclienttriggeraudiozone(3);
  }
}

function ref_13919() {
  var_0 = spawnStruct();
  var_0.origin = level.ref_13ACF[self.team].origin;
  var_0.height = getdvarint("scr_truckwar_initial_spawn_height", 3000);
  var_1 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
}

function ref_12095() {
  scripts\mp\gametypes\br_public::ref_126ED();

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13F21(self);
  }

  var_0 = level.ref_13ACE[self.team];

  if(!istrue(var_0.should_display_reinforcement_called_icon)) {
    thread ref_13DE4(level, var_0, var_0.origin, var_0.angles);
  }

  getspawnpoint(1);
  var_1 = anglesToForward((0, randomint(360), 0));
  var_2 = getdvarint("scr_truckwar_initial_spawn_offset", 500);
  var_3 = getdvarint("scr_truckwar_initial_spawn_height", 3000);
  var_4 = self.ref_12AB3.origin + var_1 * var_2 + (0, 0, 1) * var_3;
  var_5 = vectortoangles(self.ref_12AB3.origin - var_4);

  while(self isinexecutionattack() || self isinexecutionvictim()) {
    waitframe();
  }

  waitframe();
  self setOrigin(var_4, 1);
  self setplayerangles(var_5);
  thread scripts\mp\gametypes\br_c130::parachute(undefined, 0, undefined, 0);
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self notify("do_welcome_splashes");
}

function toma_strike_watch_owner() {
  var_0 = [];

  if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
    _setdomflagiconinfo("waypoint_repair_station_idle", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_idle", 0);
    _setdomflagiconinfo("waypoint_repair_station_in_use", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_in_use", 0);
  }

  if(getdvarint("scr_truckwar_repair_disable_fire", 0) != 1) {
    var_1 = getdvarint("scr_truckwar_repair_distsq_fire", 90000);
    var_2 = relic_steelballs_stump();

    foreach(var_4 in var_2) {
      var_5 = init_track(var_4, sqrt(var_1));
      var_5.ref_12C35 = var_1;
      var_0 = var_5;
    }
  }

  var_1 = getdvarint("scr_truckwar_repair_distsq_gas", 90000);
  var_2 = remaphardpointorder();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5.ref_12C35 = var_1;
    var_0 = var_5;
  }

  var_1 = getdvarint("scr_truckwar_repair_distsq_north", 90000);
  var_2 = reset_use_trigger();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5.ref_12C35 = var_1;
    var_0 = var_5;
  }

  var_1 = getdvarint("scr_truckwar_repair_distsq_south", 90000);
  var_2 = rooftop_objective();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5.ref_12C35 = var_1;
    var_0 = var_5;
  }

  level.ref_12C36 = var_0;
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.waypointcolors[var_0] = var_2;
  level.waypointbgtype[var_0] = var_1;
  level.waypointstring[var_0] = var_3;
  level.waypointshader[var_0] = var_4;
  level.waypointpulses[var_0] = var_5;
}

function init_track(var_0, var_1) {
  var_2 = undefined;

  if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
    var_3 = spawn("trigger_radius", var_0, 0, int(var_1), int(var_1));
    var_2 = scripts\mp\gametypes\obj_dom::setupobjective(var_3);
    var_2.pinobj = 0;
    var_2 scripts\mp\gameobjects::allowuse("none");
    var_2.flagmodel hide();
    scripts\mp\objidpoolmanager::update_objective_position(var_2.objidnum, var_2.curorigin + (0, 0, 60));
    function_0421(var_2.objidnum, 1);
    var_2 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
    getbnetigrbattlepassxpmultiplier(var_2.objidnum, 2000, 2500);
  } else {
    var_2 = easepower("truckwar_repair_station", var_0, (0, 0, 1));
  }

  var_2.inuse = 0;
  var_2.trial_target_flip = 0;
  return var_2;
}

function relic_steelballs_stump() {
  var_0 = [];

  if(level.mapname == "mp_br_mechanics") {
    GscBinSkip0(0x2e, var_0.size, (1850, -50, 0));
  }

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var_0.size, (-18964, -22238, -165));
  }

  GscBinSkip0(0x2e, var_0.size, (-18964, -22238, -165));
}

function remaphardpointorder() {
  var_0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var_0.size, (-30563, 3055, -232));
  }

  GscBinSkip0(0x2e, var_0.size, (-30563, 3055, -232));
}

function reset_use_trigger() {
  var_0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var_0.size, (15625, 36254, 1510));
  }

  GscBinSkip0(0x2e, var_0.size, (15625, 36254, 1510));
}

function rooftop_objective() {
  var_0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var_0.size, (18940, -24914, -199));
  }

  GscBinSkip0(0x2e, var_0.size, (18940, -24914, -199));
}

function ref_144D7() {
  if(getdvarint("scr_truckwar_repair_station", 1) == 0) {
    return;
  }

  var_0 = getdvarfloat("scr_truckwar_repair_percent", 0.025);
  var_1 = getdvarfloat("scr_truckwar_repair_interval", 1);

  for(;;) {
    foreach(var_3 in level.ref_12C36) {
      var_3.ref_14073 = 0;
    }

    foreach(var_17, var_6 in level.ref_13ACE) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_7 = istrue(var_6.showquestobjicontoall);
      var_8 = 0;

      foreach(var_3 in level.ref_12C36) {
        var_10 = distancesquared(var_6.origin, scripts\engine\utility::ter_op(isDefined(var_3.origin), var_3.origin, var_3.curorigin));

        if(var_10 < var_3.ref_12C35) {
          ref_11B13(var_3);
          var_3.ref_14073 = 1;
          var_8 = 1;

          if(istrue(var_6.showquestobjicontoplayer)) {
            continue;
          }

          if(var_6.health == var_6.maxhealth) {
            continue;
          }

          var_6.showquestobjicontoall = 1;

          if(!var_7) {
            ref_1402C(var_17);
          }

          var_11 = int(var_0 * var_6.maxhealth);
          var_6 scripts\cp_mp\vehicles\vehicle_damage::ref_1413C(var_11);
          var_6 playsoundtoteam("iw8_tw_truck_repair_lp", var_17, undefined, var_6);
          var_12 = scripts\mp\utility\teams::getteamdata(var_17, "players");

          foreach(var_14 in var_12) {
            if(getdvarint("scr_truckwar_repair_show_player_feedback", 0) == 1) {
              var_14 scripts\mp\damagefeedback::hudicontype("truckheal");
            }

            var_14 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var_6.health);
            var_14 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var_6.maxhealth);
          }

          break;
        }
      }

      if(var_7 && !var_8) {
        var_6.showquestobjicontoall = 0;
        ref_1402C(var_17);
      }
    }

    foreach(var_3 in level.ref_12C36) {
      if(!var_3.ref_14073) {
        ref_11B0E(var_3);
      }
    }

    wait var_1;
  }
}

function ref_11B13() {
  self.trial_target_flip = self.inuse;
  self.inuse = 1;

  if(self.inuse != self.trial_target_flip) {
    if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_in_use");
      return;
    }

    return;
  }
}

function ref_11B0E() {
  self.trial_target_flip = self.inuse;
  self.inuse = 0;

  if(self.inuse != self.trial_target_flip) {
    if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
      return;
    }

    return;
  }
}

function ref_1338B() {
  level endon("game_ended");
  var_0 = getdvarint("scr_truckwar_respawn_circle_disable", 5);
  level.ref_13DF4 = 0;
  level waittill("infils_ready");

  if(var_0 > level.br_level.br_circleclosetimes.size - 1) {
    var_0 = level.br_level.br_circleclosetimes.size - 1;
  }

  var_1 = 0;

  for(var_2 = 0; var_2 < var_0 - 1; var_2++) {
    var_1 += level.br_level.br_circleclosetimes[var_2];
    var_1 += level.br_level.br_circledelaytimes[var_2];
  }

  var_3 = gettime() + var_1 * 1000;
  setomnvar("ui_gulag_timer", int(var_3));

  for(;;) {
    level waittill("br_circle_set", var_4);

    if(var_4 == var_0) {
      foreach(var_6 in level.players) {
        var_6 scripts\mp\hud_message::showsplash("br_gametype_truckwar_vehicle_spawn_over");
      }

      level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_over", 0);
      level.ref_13DF4 = 1;
      setomnvar("ui_gulag_timer", 0);
      break;
    }
  }
}

function ref_1402C(var_0) {
  var_1 = level.ref_13ACE[var_0];
  var_2 = 0;

  if(isDefined(var_1) && !istrue(var_1.isdestroyed)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_1, "armor")) {
      var_2 = 1;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_1, "uav")) {
      var_2 += 2;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_1, "barrel")) {
      var_2 += 4;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_1, "trophy")) {
      var_2 += 8;
      var_2 += var_1.ref_13DDF << 4;
    }
  }

  if(!isDefined(var_1) || istrue(var_1.isdestroyed)) {
    var_2 += 64;
  } else if(istrue(var_1.showquestobjicontoplayer)) {
    var_2 += 128;
  } else if(istrue(var_1.showquestobjicontoall)) {
    var_2 += 256;
  }

  var_3 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var_2);
  }
}

function brmini_initdialog() {
  var_0 = level.ref_13ED0;
  level.br_level.br_circleclosetimes = [level.ref_13EC8];
  level.br_level.br_circledelaytimes = [level.ref_13EC9];
  level.br_level.default_player_connect_black_screen = [1];
  var_1 = level.br_level.br_circleminimapradii;
  var_2 = scripts\engine\utility::ter_op(isDefined(level.ref_13ECF), level.ref_13ECF, level.br_level.br_circleradii);

  if(level.ref_13ED1) {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [var_1[0]];
    level.br_level.br_circleradii = [var_2[0], var_2[var_2.size - 1]];
  } else {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [int(var_0 / 2)];
    level.br_level.br_circleradii = [var_0, var_0];
  }

  setDvar("scr_br_moving_circle_count", level.ref_13EC3);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = level.ref_13EC0;
  var_8 = level.ref_13EC5;

  for(var_9 = 1; var_9 < level.ref_13EC3; var_9++) {
    if(level.ref_13ED1) {
      var_10 = scripts\engine\utility::ter_op(var_9 + 1 < var_2.size - 1, var_2[var_9], var_2[var_2.size - 2]);
      var_11 = scripts\engine\utility::ter_op(var_9 + 1 < var_1.size - 1, var_1[var_9], var_1[var_1.size - 2]);
      var_3 = var_10;
      var_6 = var_11;
    } else {
      var_3 = 57300;
      var_6 = 10500;
    }

    if(isDefined(level.ref_13EC2)) {
      var_12 = scripts\engine\utility::ter_op(level.ref_13EC2.size <= var_9, level.ref_13EC2.size - 1, var_9);
      var_7 = level.ref_13EC2[var_12];
    } else {
      var_7 = max(level.ref_13EBF, var_7 - level.ref_13EC1);
    }

    if(isDefined(level.ref_13EC7)) {
      var_12 = scripts\engine\utility::ter_op(level.ref_13EC7.size <= var_9, level.ref_13EC7.size - 1, var_9);
      var_8 = level.ref_13EC7[var_12];
    } else {
      var_8 = max(level.ref_13EC4, var_8 - level.ref_13EC6);
    }

    var_4 = var_7;
    var_5 = var_8;
  }

  scripts\mp\gametypes\br_circle::open_teleport_room_door(var_3, var_4, var_5, var_6);
}

function enemy_damage_monitoring() {
  level endon("game_ended");
  var_0 = getdvarint("scr_truckwar_initial_circle_variance", 10000);
  var_1 = randomfloatrange(var_0 * -1, var_0);
  var_2 = randomfloatrange(var_0 * -1, var_0);
  level.br_level.default_class_chosen[0] = level.br_level.br_mapcenter + (var_1, var_2, 0);
  level.br_level.default_class_chosen[1] = level.br_level.br_mapcenter + (var_1, var_2, 0);

  if(getdvarint("scr_truckwar_circle_precalc", 1) == 1) {
    for(var_3 = 2; var_3 < level.br_level.default_class_chosen.size - 1; var_3++) {
      enemy_failsafe_ifonedidntspawn(var_3);
    }

    return;
  }

  for(;;) {
    level waittill("br_circle_set");
    enemy_failsafe_ifonedidntspawn();
  }
}

function enemy_failsafe_ifonedidntspawn(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.br_circle.circleindex + 1;
  }

  if(level.br_level.default_class_chosen.size <= var_0 || !istrue(level.ref_13ECD)) {
    return;
  }

  var_1 = level.br_level.default_class_chosen[var_0];
  var_2 = level.br_level.br_circleradii[var_0 - 1] * level.ref_13ECC;
  var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_1, var_2, 0.8, 1, 1, 0, 1);
  var_4 = vectorNormalize(var_3 - var_1) * var_2;
  var_5 = var_1 + var_4;
  var_6 = getdvarint("scr_truckwar_circle_padding", 10000);
  var_7 = vectorNormalize(level.br_level.br_mapcenter - var_5);

  while(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_5, 1)) {
    var_5 += var_7 * var_6;
  }

  level.br_level.default_class_chosen[var_0 + 1] = var_5;
}

function enemy_close_in_on_player(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = level.ref_13ECE;
  var_3 = var_0[0] < var_1[0][0] * var_2 && var_0[0] > var_1[1][0] * var_2 && var_0[1] < var_1[0][1] * var_2 && var_0[1] > var_1[1][1] * var_2;
  return var_3;
}

function getgamewinnerprop(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_4 = var_2 - var_0;
  var_5 = distance2d(var_2, var_0);

  if(var_5 < var_3) {
    return 0;
  }

  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = level.br_level.br_circleclosetimes[level.br_circle.circleindex];

  if(level.br_circle.circleindex > 0) {
    var_13 = level.br_level.default_class_chosen[level.br_circle.circleindex];
    var_6 = distance2d(var_2, var_13);
    var_7 = vectorNormalize(var_2 - var_13);
  }

  var_8 = var_6 / var_12;
  var_14 = level.br_level.br_circleradii[level.br_circle.circleindex];
  var_9 = var_14 - var_3;
  var_10 = vectorNormalize(var_4);
  var_11 = var_9 / var_12;
  var_15 = var_0 + var_7 * -1 * var_1 * var_8 + var_10 * -1 * var_1 * var_11;
  return _calloutmarkerping_handleluinotify_enemyrepinged::ref_127DA(var_15);
}

function ref_13DF8() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_truck_wars");
}