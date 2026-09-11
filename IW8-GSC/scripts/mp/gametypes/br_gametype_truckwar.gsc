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
  level.ref_12cb4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.dialog_wait_ready_civ = 0;
  level.ref_13ecd = getdvarint("scr_truckwar_circleMoving", 1) == 1;
  level.ref_13ed1 = getdvarint("scr_truckwar_useDefaultCircleSizes", 1) == 1;
  level.ref_13ec3 = 15;
  var0 = getDvar("scr_truckwar_circleSizeOverride", "101600 42500 30200 20300 14000 10000 5000 0");

  if(var0 != "") {
    level.ref_13ecf = [];
    var1 = strtok(var0, " ");

    foreach(var3 in var1) {
      level.ref_13ecf[level.ref_13ecf.size] = float(var3);
    }
  }

  var5 = getDvar("scr_truckwar_circleCloseTimeOverride", "270 220 170 110 70 50 50 50");

  if(var5 != "") {
    level.ref_13ec2 = [];
    var6 = strtok(var5, " ");

    foreach(var3 in var6) {
      level.ref_13ec2[level.ref_13ec2.size] = float(var3);
    }
  }

  var9 = getDvar("scr_truckwar_circleDelayTimeOverride", "220 90 75 60 60 45 30 20");

  if(var9 != "") {
    level.ref_13ec7 = [];
    var10 = strtok(var9, " ");

    foreach(var3 in var10) {
      level.ref_13ec7[level.ref_13ec7.size] = float(var3);
    }
  }

  level.ref_13ed0 = getdvarfloat("scr_truckwar_circleStartRadius", 50000);
  level.ref_13eca = getdvarfloat("scr_truckwar_circleInnerSize", 40000);
  level.ref_13ecb = getdvarfloat("scr_truckwar_circleMinSize", 10000);
  level.ref_13ebf = getdvarfloat("scr_truckwar_circleCloseMinTime", 30);
  level.ref_13ec0 = getdvarfloat("scr_truckwar_circleCloseTime", 220);
  level.ref_13ec1 = getdvarfloat("scr_truckwar_circleCloseTimeChange", 40);
  level.ref_13ec5 = getdvarfloat("scr_truckwar_circleDelayTime", 60);
  level.ref_13ec6 = getdvarfloat("scr_truckwar_circleDelayTimeChange", 10);
  level.ref_13ec4 = getdvarfloat("scr_truckwar_circleDelayMinTime", 10);
  level.ref_13ece = getdvarint("scr_truckwar_circleOutOfBoundsPadding", 1);
  level.ref_13ec9 = getdvarfloat("scr_truckwar_circleInitialDelayTime", 60);
  level.ref_13ec8 = getdvarfloat("scr_truckwar_circleInitialCloseTime", 330);
  level.ref_13ecc = getdvarfloat("scr_truckwar_circleMoveDist", 1);

  if(level.ref_13ecd) {
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
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &enemy_goto_struct_on_spawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onStartGameType", &onstartgametype);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &ref_125f7);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &ref_11b80);
  scripts\mp\gametypes\br_gametypes::ref_12b11("isTeamEliminated", &validate_and_activate_stations);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  waittillframeend();
  scripts\mp\flags::gameflaginit("use_truck_respawn", 0);
  level.ontimelimit = &enemy_fallback_logic;
  level.ref_11c7a = &ref_125f7;
  enemies_validate_life();
  level.ref_140d9 = [];
  level.ref_140d9[0] = "assassination";
  level.ref_140d9[1] = "domination";
  level.ref_140d9[2] = "scavenger";
  level.ref_1385f = 0;

  if(level.ref_13ecd) {
    thread enemy_damage_monitoring();
  }

  thread ref_13df8();
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
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("me_electrical_box_street_01", 1);
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
  thread ref_1338b();
}

function enemy_goto_struct_on_spawn(var0) {
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

function ref_11b80(var0) {
  return true;
}

function ref_11b16() {
  return true;
}

function vehiclespawn_getspawndata(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.showheadicon = 1;
  return var1;
}

function registervehicletype(var0, var1, var2) {
  var3 = spawnStruct();
  var3.refname = var0;
  var3.spawncallback = var2;
  var3.vehiclespawns = [[var1]]();
  level.vehicleinfo[var0] = var3;
}

function vehiclespawn_littlebird(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var2, var1);
}

function ref_14266(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var2, var1);
}

function vehiclespawn_jeep(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var2, var1);
}

function ref_14263(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_mg", var2, var1);
}

function vehiclespawn_atv(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var2, var1);
}

function vehiclespawn_tacrover(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var2, var1);
}

function ref_14267(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("motorcycle", var2, var1);
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
    registervehicletype("motorcycle", &_calloutmarkerping_poolidisentity::ref_11d5e, &ref_14267);
  }

  level waittill("prematch_fade_done");
  wait 2;
}

function cargo_truck_mg_reenter() {
  level.vehiclespawnlocs = [];
  level.ref_13acf = [];

  foreach(var1 in level.vehicleinfo) {
    switch (var1.refname) {
      case "cargo_truck_mg":
        var1.vehiclespawns = run_spawn_module_till_kill_trig("cargo_truck_mg", "mkilo_physics_mg");
        break;
    }

    foreach(var3 in var1.vehiclespawns) {
      var4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var4] = var3;
      level.vehiclespawnlocs[var4].refname = var1.refname;
    }
  }

  scripts\mp\gametypes\br_vehicles::ref_13e0c(level.vehiclespawnlocs);

  if(false) {
    foreach(var8 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var8.origin, var8.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);

  if(false) {
    for(var10 = 0; var10 < level.vehiclespawnlocs.size; var10++) {
      var8 = level.vehiclespawnlocs[var10];
      thread scripts\mp\utility\debug::drawline(var8.origin + (0, 0, 1500), var8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  var11 = 0;

  foreach(var13 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var13, "players").size == 0) {
      continue;
    }

    while(var11 < level.vehiclespawnlocs.size) {
      var8 = level.vehiclespawnlocs[var11];

      if(isDefined(var8)) {
        if(var8.refname == "cargo_truck_mg") {
          level.ref_13acf[var13] = var8;
          var11++;
          break;
        }
      }

      var11++;
    }
  }

  scripts\mp\flags::gameflagset("trucks_spawn_complete");
}

function ref_136aa() {
  var0 = [];

  foreach(var2 in level.ref_13acf) {
    var3 = level.vehicleinfo[var2.refname];
    var4 = [[var3.spawncallback]](var2);
    var0 = var4;
  }

  level.ref_13ace = var0;
  var6 = getdvarint("scr_truckwar_max_vehicle_count", 120);
  var7 = var6 - var0.size;

  for(var8 = 0; var8 < level.vehiclespawnlocs.size && var7 > 0; var8++) {
    var2 = level.vehiclespawnlocs[var8];

    if(isDefined(var2)) {
      if(var2.targetname == "motorcycle_spawn") {
        var3 = level.vehicleinfo["motorcycle"];
        var4 = [[var3.spawncallback]](var2);
        var7--;
        var8++;
        continue;
      }

      if(var2.refname != "cargo_truck_mg") {
        var3 = level.vehicleinfo[var2.refname];
        var4 = [[var3.spawncallback]](var2);
        var7--;
      }
    }
  }
}

function cargo_truck_mg_removegunnerdamagemod() {
  var0 = level.ref_13ace;
  level.ref_13ace = [];
  level.ref_13aa7 = [];
  level.ref_13acd = [];
  var1 = 0;

  foreach(var3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var3, "players").size == 0) {
      continue;
    }

    var4 = var0[var1];
    thrownoffhand(var4, var3);
    var1++;
  }
}

function thrownoffhand(var0, var1, var2) {
  level.ref_13ace[var1] = var0;
  level.ref_13aa7[var1] = 1;
  thread ref_14505(level, var0);
  thread ref_14506(level, var0);
  thread ref_11ecf(level, var0);
  thread ref_11ed0(level, var0);
  thread ref_11ed1(level, var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var0, var1);
  var0 setscriptablepartstate("objective", "on");
  var3 = scripts\mp\utility\teams::getteamdata(var1, "players");

  foreach(var5 in var3) {
    var5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var0.health);
    var5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var0.maxhealth);

    if(istrue(var2) && getdvarint("scr_truckwar_truck_replacement_respawn", 1) == 1 && !istrue(level.ref_13df4)) {
      if(istrue(var5.delay_enter_combat_after_investigating_grenade)) {
        var5.setspawnpoint = undefined;
        thread playerrespawn(var5);
      }
    }
  }

  ref_1402c(var1);
}

function ref_14505(var0, var1) {
  var0 endon("death");
  level endon("game_ended");
  var0.ref_1441f = 0;
  var0.ref_14421 = 0;
  var0.ref_14420 = 0;
  var2 = getdvarfloat("scr_truckwar_gas_warning_close", 15);
  var3 = getdvarfloat("scr_truckwar_gas_warning_medium", 30);
  var4 = getdvarfloat("scr_truckwar_gas_warning_far", 45);
  var5 = scripts\mp\utility\teams::getteamdata(var1, "players");

  foreach(var7 in var5) {
    var7 scripts\engine\utility::ent_flag_init("respawn_vehicle_in_gas");
  }

  while(isDefined(var0)) {
    if(istrue(var0.stop_pressure_sensor)) {
      waitframe();
      continue;
    }

    if(istrue(level.group_unset_jugg_standstill)) {
      if(!var0.ref_1441f && getgamewinnerprop(var0.origin, var2)) {
        showsplashtoteam(var1, "br_gametype_truckwar_gas_is_approaching_close");
        var0.ref_1441f = 1;
        var0.ref_14421 = 1;
        var0.ref_14420 = 1;
      } else if(!var0.ref_14421 && getgamewinnerprop(var0.origin, var3)) {
        showsplashtoteam(var1, "br_gametype_truckwar_gas_is_approaching_medium");
        var0.ref_14421 = 1;
        var0.ref_14420 = 1;
      } else if(!var0.ref_14420 && getgamewinnerprop(var0.origin, var4)) {
        showsplashtoteam(var1, "br_gametype_truckwar_gas_is_approaching_far");
        var0.ref_14420 = 1;
      }
    } else {
      var0.ref_1441f = 0;
      var0.ref_14421 = 0;
      var0.ref_14420 = 0;
    }

    var9 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var10 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var11 = getdvarint("scr_truckwar_force_in_gas", 0) == 1;

    if(var11 || distance2dsquared(var9, var0.origin) > var10 * var10) {
      thread midpos();

      if(level.ref_13aa7[var1] == 1) {
        level.ref_13aa7[var1] = 0;
        var5 = scripts\mp\utility\teams::getteamdata(var1, "players");

        foreach(var7 in var5) {
          var7 scripts\engine\utility::ent_flag_set("respawn_vehicle_in_gas");
        }

        showsplashtoteam(var1, "br_gametype_truckwar_vehicle_spawn_disabled");
        level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_disabled", 0, var5, undefined);
        level thread[[level.updategameevents]]();
      }
    } else if(level.ref_13aa7[var1] == 0) {
      var0 notify("vehicle_gas_exit");
      var0.ref_128ad = 0;
      level.ref_13aa7[var1] = 1;
      var5 = scripts\mp\utility\teams::getteamdata(var1, "players");

      foreach(var7 in var5) {
        var7 scripts\engine\utility::ent_flag_clear("respawn_vehicle_in_gas");
      }

      showsplashtoteam(var1, "br_gametype_truckwar_vehicle_spawn_enabled");
      level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_enabled", 0, var5, undefined);
      level thread[[level.updategameevents]]();
    }

    waitframe();
  }
}

function midpos() {
  self endon("death");
  self endon("vehicle_gas_exit");

  if(istrue(self.ref_128ad)) {
    return;
  }

  self.ref_128ad = 1;
  var0 = getdvarfloat("scr_truckwar_vehicle_gas_dps", 0.05);
  var1 = self.maxhealth * var0;

  while(isDefined(self)) {
    wait 1;
    self dodamage(var1, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  }
}

function ref_14506(var0, var1) {
  var0 endon("death");
  level endon("game_ended");
  var0.ref_120b3 = 0;
  var2 = getdvarfloat("scr_truckwar_oob_empty_window", 15);
  var3 = getdvarfloat("scr_truckwar_oob_kill_time", 5);
  var4 = var0.isempty;
  var5 = 0;
  var6 = undefined;

  for(;;) {
    if(!var4 && var0.isempty) {
      var6 = gettime() + var2 * 1000;
    }

    var4 = var0.isempty;

    if(isDefined(var6) && gettime() < var6 || var5) {
      var7 = 0;
      var8 = undefined;

      foreach(var10 in level.outofboundstriggers) {
        if(var0 istouching(var10)) {
          var0.ref_120b3 += level.framedurationseconds;
          var7 = 1;
          var8 = var10;
          break;
        }
      }

      var5 = var7;

      if(!var7) {
        var0.ref_120b3 -= level.framedurationseconds;
      }

      var0.ref_120b3 = clamp(var0.ref_120b3, 0, var3);

      if(var0.ref_120b3 == var3) {
        var0 dodamage(999999, var0.origin, var8, var8, "MOD_TRIGGER_HURT");
      }
    }

    waitframe();
  }
}

function ref_11ecf(var0, var1) {
  var0 endon("death");
  level endon("game_ended");
  var2 = getdvarfloat("scr_truckwar_damage_taken_window", 5) * 1000;
  var3 = undefined;

  while(isDefined(var0)) {
    var0 waittill("damage_taken", var4);
    var0.lastdamagedtime = gettime();
    thread connected_search_node(var0);
    var5 = scripts\mp\utility\teams::getteamdata(var1, "players");

    foreach(var7 in var5) {
      var7 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var0.health);
      var7 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var0.maxhealth);
    }

    if(isDefined(var3) && var3 + var2 > gettime()) {
      continue;
    }

    var3 = gettime();
    var5 = scripts\mp\utility\teams::getteamdata(var1, "players");
    showsplashtoteam(var1, "br_gametype_truckwar_vehicle_under_attack");
    level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_under_attack", 0, var5, undefined);

    foreach(var7 in var5) {
      if(!istrue(var7.ref_13df3)) {
        var10 = game["music"]["br_truck_attacked"].size;
        var11 = randomint(var10);
        var7 setplayermusicstate(game["music"]["br_truck_attacked"][var11]);
        var7.ref_13df3 = 1;
      }
    }
    LOC_0000016b:
  }
}

function connected_search_node(var0) {
  self endon("death");
  self notify("blockHealing");
  self endon("blockHealing");
  self.showquestobjicontoplayer = 1;
  ref_1402c(var0);
  var1 = getdvarfloat("scr_truckwar_repair_damage_ignore", 15);
  wait var1;
  self.showquestobjicontoplayer = 0;
  ref_1402c(var0);
}

function ref_11ed1(var0, var1) {
  var0 endon("death");
  level endon("game_ended");

  while(isDefined(var0)) {
    var0 waittill("upgrade_message", var2);

    if(var2 != "trophy_ammo_used") {
      var3 = rotatetowithpause(var2);
      showsplashtoteam(var1, var3);
    }

    ref_1402c(var1);
  }
}

function rotatetowithpause(var0) {
  switch (var0) {
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

function ref_11ed0(var0, var1) {
  level endon("game_ended");
  var2 = scripts\mp\utility\teams::getteamdata(var1, "players");

  foreach(var4 in var2) {
    var4 scripts\engine\utility::ent_flag_init("respawn_vehicle_death");
  }

  var0 waittill("death");
  level.ref_13aa7[var1] = 0;
  var2 = scripts\mp\utility\teams::getteamdata(var1, "players");

  foreach(var4 in var2) {
    var4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", 0);
    var4 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", 1);
    var4 scripts\engine\utility::ent_flag_set("respawn_vehicle_death");
  }

  showsplashtoteam(var1, "br_gametype_truckwar_vehicle_destroyed");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_destroyed", 0, var2, undefined);
  level thread[[level.updategameevents]]();
  ref_1402c(var1);
}

function run_spawn_module_till_kill_trig(var0, var1) {
  if(level.mapname != "mp_br_mechanics") {
    return revive_icon_color_keep(var0, var1);
  }

  var2 = level.teamnamelist.size;
  var3 = 0;

  foreach(var5 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var5, "players").size > 0) {
      var3++;
    }
  }

  var2 = var3;
  var7 = 360 / var2;
  var8 = (0, 0, 100);

  if(level.mapname == "mp_br_mechanics") {
    var8 = (0, 0, 100);
    var9 = 5000;
  } else {
    var9 = (4000, 10000, 100);
    var9 = 40000;
  }

  var10 = scripts\engine\trace::create_default_contents(1);
  var11 = [];

  for(var12 = 0; var12 < var3; var12++) {
    var13 = var12 * var8;
    var14 = anglesToForward((0, var13, 0));
    var15 = var9 + var14 * var9;
    var16 = scripts\engine\utility::drop_to_ground(var15, 10000, -20000, undefined, var10);
    var15 = (var15[0], var15[1], var16[2] + 200);
    var17 = spawnStruct();
    var17.origin = var15;
    var18 = (0, 0, 0);
    var17.angles = vectortoangles(var14 * -1);
    var17.targetname = var1;
    var17.vehicletype = var2;
    var11 = var17;
  }

  return var11;
}

function revive_icon_color_keep(var0, var1) {
  var2 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var2.size, (-2533.7, 54787.8, 934.125));
  }

  GscBinSkip0(0x2e, var2.size, (-2533.7, 54787.8, 934.125));
}

function remove_hover_direction_and_try_issue_retreat(var0, var1) {
  var2 = [];
  var3 = 3;
  var4 = 360 / var3;
  var5 = (0, 0, 100);
  var6 = 1000;

  for(var7 = 0; var7 < var3; var7++) {
    var8 = var7 * var4;
    var9 = anglesToForward((0, var8, 0));
    var10 = var5 + var9 * var6;
    var11 = spawnStruct();
    var11.origin = var10;
    var12 = (0, 0, 0);
    var11.angles = vectortoangles(var9 * -1);
    var11.targetname = var0;
    var11.vehicletype = var1;
    var2 = var11;
  }

  return var2;
}

function validate_and_activate_stations(var0) {
  if(!isDefined(level.ref_13aa7)) {
    return false;
  }

  return scripts\mp\utility\teams::getteamdata(var0, "aliveCount") == 0 && (!istrue(level.ref_13aa7[var0]) || istrue(level.ref_13df4));
}

function ref_125f7(var0, var1) {
  if(!scripts\mp\flags::gameflag("use_truck_respawn")) {
    return false;
  }

  thread playerrespawn(var0.victim, 0, var0);
  var0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(var0, var1);
  return true;
}

function playerrespawn(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_auto_win");
  self notify("playerRespawn");
  self endon("playerRespawn");

  if(istrue(level.gameended)) {
    return;
  }

  if(istrue(level.ref_13df4) || validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13dc2();
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var3 = level.checkpoint_objective_id;

  if(istrue(var0)) {
    var3 = 0;
  }

  var4 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 5);

  if(var3 < var4) {
    var3 = var4;
  }

  if(level.ref_12cb4 != 0) {
    var3 = 0;
  }

  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread kioskfixupproneplayers(var3);
  var5 = var3 - var4;
  var6 = var3 - var5;
  var7 = var3 - getdvarfloat("scr_bmo_respawn_intermission_time", 5);
  thread patchfix(var7);
  var8 = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", var5);

  if(var8 != "respawn_vehicle_death") {
    thread ref_1400c();
    var8 = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", var6);
  }

  self notify("stop_updatePrestreamRespawn");

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13132();
  } else if(scripts\engine\utility::ent_flag("respawn_vehicle_in_gas")) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(79);
  }

  while(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && !scripts\engine\utility::ent_flag("respawn_vehicle_death") && !level.ref_13aa7[self.team] || scripts\cp_mp\utility\player_utility::isusingremote()) {
    waitframe();
  }

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::ref_13132();
  }

  if(validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var1, var2);
    thread scripts\mp\gametypes\br_spectate::ref_13dc2();
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    return;
  }

  var9 = getspawnpoint();
  var10 = scripts\mp\gametypes\br_gulag::ref_1263e(var9);
  var11 = level.ref_13ace[self.team].origin;

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.force_players_out_of_vehicle = [];
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && isDefined(level.ref_124e7)) {
    var9 = scripts\engine\utility::getStruct(level.ref_124e7, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var9, 1, var10, 1, undefined, 0, 0, 1);
  var12 = vectortoangles(var11 - var10);
  self setplayerangles(var12);
  self notify("respawn_view_set");
  scripts\mp\gametypes\br::ref_13f21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");

  if(isDefined(level.ref_13ace[self.team])) {
    var11 = level.ref_13ace[self.team].origin;
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", level.ref_13ace[self.team].health);
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", level.ref_13ace[self.team].maxhealth);
  }

  level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var11, "revive");
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  ref_1402c(self.team);
}

function kioskfixupproneplayers(var0) {
  self endon("disconnect");
  waitframe();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var0 * 1000));
}

function patchfix(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  if(validate_and_activate_stations(self.team) || !level.ref_13aa7[self.team]) {
    return;
  }

  var1 = 1;
  thread fadeoutin();
  wait var1 - 0.25;
  scripts\mp\gametypes\br::ending_fade_in();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  wait 0.25;

  if(validate_and_activate_stations(self.team) || !level.ref_13aa7[self.team]) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252b();
    var2 = getspawnpoint();
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(var2.origin, var2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  var0 = scripts\engine\utility::ref_143b5("spawned_player", "respawn_vehicle_in_gas", "gulag_auto_win");

  if(var0 == "spawned_player" || var0 == "respawn_vehicle_in_gas") {
    self waittill("respawn_view_set");
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  }

  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_1400c() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");
  self endon("respawn_vehicle_death");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var0 = getspawnpoint();
      var1 = gettime();

      if(var1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var0 = getspawnpoint();
        var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
      }
    } else {
      var0 = getspawnpoint();
      var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
    }

    wait 1;
  }
}

function initspawns() {
  level.ref_1365e = getdvarfloat("scr_spawn_height", 2500);
}

function getspawnpoint(var0) {
  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
    return pre_race(istrue(var0));
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    var1 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(var3 in level.teamnamelist) {
        if(var3 != self.team) {
          self playsoundtoteam("tactical_spawn", var3);
        }
      }
    }

    var5 = self.setspawnpoint.playerspawnpos;
    var6 = scripts\engine\trace::create_default_contents(1);
    var7 = scripts\engine\utility::drop_to_ground(var5, 10000, -20000, undefined, var6);
    var5 = (var5[0], var5[1], var7[2]);
    var5 += (0, 0, 1) * level.endsuperdisableweaponbr.ref_1365e[self.team];

    if(getdvarint("scr_brtdm_spawn_debug") == 1) {
      thread scripts\mp\utility\debug::drawline(var5, var7, 15, (1, 1, 0));
    }

    self.ref_12ab3.origin = var5;
    self.ref_12ab3.angles = self.setspawnpoint.playerspawnangles;
    self.ref_12ab3.lifeid = self.lifeid;
    self.ref_12ab3.time = gettime();
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
  } else if(self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid || istrue(self.ref_12ab3.updateclientmatchdata)) {
    return pre_race(istrue(var0));
  }

  return self.ref_12ab3;
}

function pre_race(var0) {
  var1 = level.ref_13ace[self.team].origin;
  var2 = scripts\engine\trace::create_default_contents(1);
  var3 = scripts\engine\trace::ray_trace(var1 + (0, 0, 10000), var1 - (0, 0, 20000), undefined, var2)["position"];
  var1 = (var1[0], var1[1], var3[2] + level.ref_1365e);

  if(istrue(level.ref_13ecd) && getdvarint("scr_truckwar_respawn_lookahead", 1) == 1) {
    if(istrue(level.group_unset_jugg_standstill)) {
      var4 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      var5 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var6 = var4 - var1;
      var7 = distance2d(var4, var1);

      if(var7 > var5) {
        var8 = vectorNormalize(var6);
        var9 = 0;
        var10 = 0;

        if(level.br_circle.circleindex == 0) {
          var11 = level.br_level.br_circleradii[level.br_circle.circleindex];
          var9 = var11 - var5;
        } else {
          var12 = level.br_level.default_class_chosen[level.br_circle.circleindex];
          var9 = distance2d(var4, var12);
        }

        var13 = level.br_level.br_circleclosetimes[level.br_circle.circleindex + 1];
        var14 = var9 / var13;
        var15 = var14 * getdvarfloat("scr_truckwar_respawn_lookahead_time", 10);
        var1 += var8 * var15;
        var16 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        var17 = scripts\mp\gametypes\br_circle::getdangercircleradius();

        if(distance2dsquared(var1, var16) > var17 * var17) {
          var18 = vectorNormalize(var1 - var16);
          var1 = var16 + var18 * var17 * 0.99;
        }
      }
    }
  }

  self.ref_12ab3.origin = var1;
  self.ref_12ab3.angles = level.ref_13ace[self.team].angles;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  self.ref_12ab3.updateclientmatchdata = var0;
  return self.ref_12ab3;
}

function ref_144f4() {
  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  var0 = 1;

  for(;;) {
    waitframe();

    if(getdvarint("scr_truckwar_mark_spawn", 0) != 0) {
      var1 = 1000;
      radiusdamage(level.ref_13ace["axis"].origin, 1000, var1, var1);
    }
  }
}

function beacon() {
  if(!isDefined(level.ref_13df9)) {
    level.ref_13df9 = [];
  }

  level.ref_13df9[level.ref_13df9.size] = level.players[0].origin;

  foreach(var1 in level.ref_13df9) {}
}

#using_animtree("");

function stoppingpower_givehcrdata(var0) {
  level.scr_animtree["ac130"] = #animtree;
  level.scr_anim["ac130"]["truck_drop"] = $mp_mkilo23_gunner_drop_acharlie130;
  level.scr_animname["ac130"]["truck_drop"] = "mp_mkilo23_gunner_drop_acharlie130";
  level.scr_anim["ac130"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_acharlie130_trimmed;
  level.scr_animname["ac130"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_acharlie130_trimmed";
  level.scr_animtree["parachute"] = #animtree;

  if(isDefined(var0) && istrue(var0)) {
    level.scr_anim["parachute"]["truck_drop"] = % mp_carpoc_suv_drop_parachute;
    level.scr_animname["parachute"]["truck_drop"] = "mp_carpoc_suv_drop_parachute";
  } else {
    level.scr_anim["parachute"]["truck_drop"] = % mp_mkilo23_gunner_drop_parachute;
    level.scr_animname["parachute"]["truck_drop"] = "mp_mkilo23_gunner_drop_parachute";
  }

  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &ref_121c2, "truck_drop");

  if(isDefined(var0) && istrue(var0)) {
    level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_carpoc_suv_drop_parachute_trimmed;
    level.scr_animname["parachute"]["truck_drop_trimmed"] = "mp_carpoc_suv_drop_parachute_trimmed";
  } else {
    level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_parachute_trimmed;
    level.scr_animname["parachute"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_parachute_trimmed";
  }

  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", &ref_121c2, "truck_drop_trimmed");
  stoppingpower_loadoutchangeremovehcr();
}

function stoppingpower_loadoutchangeremovehcr() {
  level.scr_animtree["truck"] = #animtree;
  level.scr_anim["truck"]["truck_drop"] = $mp_mkilo23_gunner_drop_mkilo23;
  level.scr_anim["truck"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_mkilo23_trimmed;
}

function ref_13de4(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::ter_op(istrue(var3), "truck_drop", "truck_drop_trimmed");
  var0.animname = "truck";
  var0.should_display_reinforcement_called_icon = 1;
  var0 vehphys_forcekeyframedmotion();
  var0 hide();
  var5 = spawn("script_model", var1);
  var5.angles = var2;
  var5 setModel("tag_origin");
  var6 = undefined;
  var7 = spawn("script_model", var1);
  var7.angles = var2;
  var7.animname = "parachute";
  var7 setModel("veh8_mil_lnd_bromeo_parachute");
  var7 scripts\common\anim::setanimtree();
  var7 unmarkkeyframedmover(1);
  var7 hide();
  var8 = undefined;

  if(istrue(var3)) {
    var8 = spawn("script_model", var1);
    var8.angles = var2;
    var8.animname = "ac130";
    var8 setModel("veh8_mil_air_acharlie130_ks_carrier");
    var8 scripts\common\anim::setanimtree();
    var8 hide();
  }

  var5.vehicle = var0;
  var5.parachute = var7;
  var5.carrier = var8;
  var5.objent = var6;
  var9 = gettime() + level.frameduration;
  var5.endtime = gettime();
  var5.vehicleendtime = var9 + getanimlength(level.scr_anim["truck"][var4]) * 1000;

  if(var5.vehicleendtime > var5.endtime) {
    var5.endtime = var5.vehicleendtime;
  }

  var5.parachuteendtime = var9 + getanimlength(level.scr_anim["parachute"][var4]) * 1000;

  if(var5.parachuteendtime > var5.endtime) {
    var5.endtime = var5.parachuteendtime;
  }

  var5.carrierendtime = var9 + getanimlength(level.scr_anim["ac130"][var4]) * 1000;

  if(var5.carrierendtime > var5.endtime) {
    var5.endtime = var5.carrierendtime;
  }

  thread ref_13de5(var5);
  return var0;
}

function ref_13de5(var0) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, var0);
  scripts\common\anim::anim_first_frame_solo(self.parachute, var0);

  if(isDefined(self.carrier)) {
    scripts\common\anim::anim_first_frame_solo(self.carrier, var0);
  }

  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    self.vehicle.stop_pressure_sensor = 1;
    thread scripts\common\anim::anim_single_solo(self.vehicle, var0);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, var0);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("iw8_cargotruck_drop_c130");
    self.carrier setscriptablepartstate("lights2", "on", 0);
    self.carrier setscriptablepartstate("contrails", "on", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, var0);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime) {
      thread ref_13de6(self.vehicle);
    }

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime) {
      self.parachute delete();
    }

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime) {
      self.carrier delete();
    }

    waitframe();
  }

  thread ref_13de6(self.vehicle);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function ref_13de6(var0) {
  self.vehicle = undefined;

  if(isDefined(var0)) {
    var0 vehphys_setdefaultmotion();
    thread ref_13de9();
    return;
  }
}

function ref_13de9() {
  self endon("death");
  self physics_registerforcollisioncallback();
  waitframe();
  var0 = gettime() + 5000;
  var1 = undefined;
  var2 = undefined;

  while(gettime() < var0) {
    if(!isDefined(var1)) {
      var1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    } else {
      var3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var4 = (var3 - var1) / level.framedurationseconds;

      if(isDefined(var2)) {
        if(var2 - var4 >= 300) {
          ref_13de7(self.origin, self.angles);
          break;
        }
      }

      <
      error > = var1;
      var0 = var2;
    }

    waitframe();
  }

  self physics_unregisterforcollisioncallback();
}

function ref_13de7(var0, var1) {
  self.stop_pressure_sensor = 0;
  playFX(scripts\engine\utility::getfx("light_tank_land"), var0, anglesToForward(var1));
  playsoundatpos(var0, "iw8_c130_drop_mkilo");
  earthquake(0.3, 0.7, var0, 800);
  playrumbleonposition("grenade_rumble", var0);
  physicsexplosionsphere(var0, 800, 400, 0.5);
}

function ref_121c2(var0) {
  var0 playSound("iw8_c130_drop_mkilo_chute");
}

function showsplashtoteam(var0, var1) {
  foreach(var3 in level.teamdata[var0]["players"]) {
    var3 scripts\mp\hud_message::showsplash(var1);
  }
}

function manage_fakebody_hides(var0) {
  thread ref_13df7(var0);

  if(getdvarint("scr_truckwar_repair_station", 1) == 1) {
    thread toma_strike_watch_owner();
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  scripts\mp\deathicons::ref_12bfd();
  scripts\mp\flags::gameflaginit("trucks_spawn_complete", 0);
  thread cargo_truck_mg_reenter();
  scripts\mp\flags::gameflagwait("trucks_spawn_complete");

  foreach(var2 in level.players) {
    if(!isalive(var2)) {
      var2 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var2.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var2);
    }

    var2 setclientomnvar("ui_br_infil_started", 1);
    var2 setclientomnvar("ui_br_infiled", 1);
    var2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    thread ref_13919();
    LOC_000000d8:
  }

  wait 2;
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(var2 in level.players) {
    var2 playsoundtoplayer("tw_ac130_flyby", var2, var2);
  }

  wait 2;
  ref_136aa();
  cargo_truck_mg_removegunnerdamagemod();

  foreach(var2 in level.players) {
    thread ref_12095();
    LOC_0000015c:
  }

  thread ref_144d7();
  scripts\mp\flags::gameflagset("use_truck_respawn");
}

function ref_13df7(var0) {
  foreach(var2 in level.players) {
    var2 setclienttriggeraudiozone("donetsk_ext_ac130_infil", 1);
    var3 = game["music"]["truckwars_infil"].size;
    var4 = randomint(var3);
    var2 setplayermusicstate(game["music"]["truckwars_infil"][var4]);
  }

  wait 3;

  foreach(var2 in level.players) {
    var2 playlocalsound("scr_br_infil_ac130_klaxon", undefined, undefined, 1);
  }

  wait 0.8;

  foreach(var2 in level.players) {
    var2 playlocalsound("scr_br_infil_jump_stinger", undefined, undefined, 1);
    var2 clearclienttriggeraudiozone(3);
  }
}

function ref_13919() {
  var0 = spawnStruct();
  var0.origin = level.ref_13acf[self.team].origin;
  var0.height = getdvarint("scr_truckwar_initial_spawn_height", 3000);
  var1 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
}

function ref_12095() {
  scripts\mp\gametypes\br_public::ref_126ed();

  if(!isalive(self)) {
    scripts\mp\playerlogic::spawnplayer(0);
  }

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  var0 = level.ref_13ace[self.team];

  if(!istrue(var0.should_display_reinforcement_called_icon)) {
    thread ref_13de4(level, var0, var0.origin, var0.angles);
  }

  getspawnpoint(1);
  var1 = anglesToForward((0, randomint(360), 0));
  var2 = getdvarint("scr_truckwar_initial_spawn_offset", 500);
  var3 = getdvarint("scr_truckwar_initial_spawn_height", 3000);
  var4 = self.ref_12ab3.origin + var1 * var2 + (0, 0, 1) * var3;
  var5 = vectortoangles(self.ref_12ab3.origin - var4);

  while(self isinexecutionattack() || self isinexecutionvictim()) {
    waitframe();
  }

  waitframe();
  self setOrigin(var4, 1);
  self setplayerangles(var5);
  thread scripts\mp\gametypes\br_c130::parachute(undefined, 0, undefined, 0);
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self notify("do_welcome_splashes");
}

function toma_strike_watch_owner() {
  var0 = [];

  if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
    _setdomflagiconinfo("waypoint_repair_station_idle", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_idle", 0);
    _setdomflagiconinfo("waypoint_repair_station_in_use", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_in_use", 0);
  }

  if(getdvarint("scr_truckwar_repair_disable_fire", 0) != 1) {
    var1 = getdvarint("scr_truckwar_repair_distsq_fire", 90000);
    var2 = relic_steelballs_stump();

    foreach(var4 in var2) {
      var5 = init_track(var4, sqrt(var1));
      var5.ref_12c35 = var1;
      var0 = var5;
    }
  }

  var1 = getdvarint("scr_truckwar_repair_distsq_gas", 90000);
  var2 = remaphardpointorder();

  foreach(var4 in var2) {
    var5 = init_track(var4, sqrt(var1));
    var5.ref_12c35 = var1;
    var0 = var5;
  }

  var1 = getdvarint("scr_truckwar_repair_distsq_north", 90000);
  var2 = reset_use_trigger();

  foreach(var4 in var2) {
    var5 = init_track(var4, sqrt(var1));
    var5.ref_12c35 = var1;
    var0 = var5;
  }

  var1 = getdvarint("scr_truckwar_repair_distsq_south", 90000);
  var2 = rooftop_objective();

  foreach(var4 in var2) {
    var5 = init_track(var4, sqrt(var1));
    var5.ref_12c35 = var1;
    var0 = var5;
  }

  level.ref_12c36 = var0;
}

function _setdomflagiconinfo(var0, var1, var2, var3, var4, var5) {
  level.waypointcolors[var0] = var2;
  level.waypointbgtype[var0] = var1;
  level.waypointstring[var0] = var3;
  level.waypointshader[var0] = var4;
  level.waypointpulses[var0] = var5;
}

function init_track(var0, var1) {
  var2 = undefined;

  if(getdvarint("scr_truckwar_repair_station_objective", 1) == 1) {
    var3 = spawn("trigger_radius", var0, 0, int(var1), int(var1));
    var2 = scripts\mp\gametypes\obj_dom::setupobjective(var3);
    var2.pinobj = 0;
    var2 scripts\mp\gameobjects::allowuse("none");
    var2.flagmodel hide();
    scripts\mp\objidpoolmanager::update_objective_position(var2.objidnum, var2.curorigin + (0, 0, 60));
    function_0421(var2.objidnum, 1);
    var2 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
    getbnetigrbattlepassxpmultiplier(var2.objidnum, 2000, 2500);
  } else {
    var2 = easepower("truckwar_repair_station", var0, (0, 0, 1));
  }

  var2.inuse = 0;
  var2.trial_target_flip = 0;
  return var2;
}

function relic_steelballs_stump() {
  var0 = [];

  if(level.mapname == "mp_br_mechanics") {
    GscBinSkip0(0x2e, var0.size, (1850, -50, 0));
  }

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var0.size, (-18964, -22238, -165));
  }

  GscBinSkip0(0x2e, var0.size, (-18964, -22238, -165));
}

function remaphardpointorder() {
  var0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var0.size, (-30563, 3055, -232));
  }

  GscBinSkip0(0x2e, var0.size, (-30563, 3055, -232));
}

function reset_use_trigger() {
  var0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var0.size, (15625, 36254, 1510));
  }

  GscBinSkip0(0x2e, var0.size, (15625, 36254, 1510));
}

function rooftop_objective() {
  var0 = [];

  if(level.mapname == "mp_don4") {
    GscBinSkip0(0x2e, var0.size, (18940, -24914, -199));
  }

  GscBinSkip0(0x2e, var0.size, (18940, -24914, -199));
}

function ref_144d7() {
  if(getdvarint("scr_truckwar_repair_station", 1) == 0) {
    return;
  }

  var0 = getdvarfloat("scr_truckwar_repair_percent", 0.025);
  var1 = getdvarfloat("scr_truckwar_repair_interval", 1);

  for(;;) {
    foreach(var3 in level.ref_12c36) {
      var3.ref_14073 = 0;
    }

    foreach(var17, var6 in level.ref_13ace) {
      if(!isDefined(var6)) {
        continue;
      }

      var7 = istrue(var6.showquestobjicontoall);
      var8 = 0;

      foreach(var3 in level.ref_12c36) {
        var10 = distancesquared(var6.origin, scripts\engine\utility::ter_op(isDefined(var3.origin), var3.origin, var3.curorigin));

        if(var10 < var3.ref_12c35) {
          ref_11b13(var3);
          var3.ref_14073 = 1;
          var8 = 1;

          if(istrue(var6.showquestobjicontoplayer)) {
            continue;
          }

          if(var6.health == var6.maxhealth) {
            continue;
          }

          var6.showquestobjicontoall = 1;

          if(!var7) {
            ref_1402c(var17);
          }

          var11 = int(var0 * var6.maxhealth);
          var6 scripts\cp_mp\vehicles\vehicle_damage::ref_1413c(var11);
          var6 playsoundtoteam("iw8_tw_truck_repair_lp", var17, undefined, var6);
          var12 = scripts\mp\utility\teams::getteamdata(var17, "players");

          foreach(var14 in var12) {
            if(getdvarint("scr_truckwar_repair_show_player_feedback", 0) == 1) {
              var14 scripts\mp\damagefeedback::hudicontype("truckheal");
            }

            var14 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var6.health);
            var14 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var6.maxhealth);
          }

          break;
        }
      }

      if(var7 && !var8) {
        var6.showquestobjicontoall = 0;
        ref_1402c(var17);
      }
    }

    foreach(var3 in level.ref_12c36) {
      if(!var3.ref_14073) {
        ref_11b0e(var3);
      }
    }

    wait var1;
  }
}

function ref_11b13() {
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

function ref_11b0e() {
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

function ref_1338b() {
  level endon("game_ended");
  var0 = getdvarint("scr_truckwar_respawn_circle_disable", 5);
  level.ref_13df4 = 0;
  level waittill("infils_ready");

  if(var0 > level.br_level.br_circleclosetimes.size - 1) {
    var0 = level.br_level.br_circleclosetimes.size - 1;
  }

  var1 = 0;

  for(var2 = 0; var2 < var0 - 1; var2++) {
    var1 += level.br_level.br_circleclosetimes[var2];
    var1 += level.br_level.br_circledelaytimes[var2];
  }

  var3 = gettime() + var1 * 1000;
  setomnvar("ui_gulag_timer", int(var3));

  for(;;) {
    level waittill("br_circle_set", var4);

    if(var4 == var0) {
      foreach(var6 in level.players) {
        var6 scripts\mp\hud_message::showsplash("br_gametype_truckwar_vehicle_spawn_over");
      }

      level thread scripts\mp\gametypes\br_public::brleaderdialog("vehicle_spawn_over", 0);
      level.ref_13df4 = 1;
      setomnvar("ui_gulag_timer", 0);
      break;
    }
  }
}

function ref_1402c(var0) {
  var1 = level.ref_13ace[var0];
  var2 = 0;

  if(isDefined(var1) && !istrue(var1.isdestroyed)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var1, "armor")) {
      var2 = 1;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var1, "uav")) {
      var2 += 2;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var1, "barrel")) {
      var2 += 4;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var1, "trophy")) {
      var2 += 8;
      var2 += var1.ref_13ddf << 4;
    }
  }

  if(!isDefined(var1) || istrue(var1.isdestroyed)) {
    var2 += 64;
  } else if(istrue(var1.showquestobjicontoplayer)) {
    var2 += 128;
  } else if(istrue(var1.showquestobjicontoall)) {
    var2 += 256;
  }

  var3 = scripts\mp\utility\teams::getteamdata(var0, "players");

  foreach(var5 in var3) {
    var5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var2);
  }
}

function brmini_initdialog() {
  var0 = level.ref_13ed0;
  level.br_level.br_circleclosetimes = [level.ref_13ec8];
  level.br_level.br_circledelaytimes = [level.ref_13ec9];
  level.br_level.default_player_connect_black_screen = [1];
  var1 = level.br_level.br_circleminimapradii;
  var2 = scripts\engine\utility::ter_op(isDefined(level.ref_13ecf), level.ref_13ecf, level.br_level.br_circleradii);

  if(level.ref_13ed1) {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [var1[0]];
    level.br_level.br_circleradii = [var2[0], var2[var2.size - 1]];
  } else {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [int(var0 / 2)];
    level.br_level.br_circleradii = [var0, var0];
  }

  setDvar("scr_br_moving_circle_count", level.ref_13ec3);
  var3 = [];
  var4 = [];
  var5 = [];
  var6 = [];
  var7 = level.ref_13ec0;
  var8 = level.ref_13ec5;

  for(var9 = 1; var9 < level.ref_13ec3; var9++) {
    if(level.ref_13ed1) {
      var10 = scripts\engine\utility::ter_op(var9 + 1 < var2.size - 1, var2[var9], var2[var2.size - 2]);
      var11 = scripts\engine\utility::ter_op(var9 + 1 < var1.size - 1, var1[var9], var1[var1.size - 2]);
      var3 = var10;
      var6 = var11;
    } else {
      var3 = 57300;
      var6 = 10500;
    }

    if(isDefined(level.ref_13ec2)) {
      var12 = scripts\engine\utility::ter_op(level.ref_13ec2.size <= var9, level.ref_13ec2.size - 1, var9);
      var7 = level.ref_13ec2[var12];
    } else {
      var7 = max(level.ref_13ebf, var7 - level.ref_13ec1);
    }

    if(isDefined(level.ref_13ec7)) {
      var12 = scripts\engine\utility::ter_op(level.ref_13ec7.size <= var9, level.ref_13ec7.size - 1, var9);
      var8 = level.ref_13ec7[var12];
    } else {
      var8 = max(level.ref_13ec4, var8 - level.ref_13ec6);
    }

    var4 = var7;
    var5 = var8;
  }

  scripts\mp\gametypes\br_circle::open_teleport_room_door(var3, var4, var5, var6);
}

function enemy_damage_monitoring() {
  level endon("game_ended");
  var0 = getdvarint("scr_truckwar_initial_circle_variance", 10000);
  var1 = randomfloatrange(var0 * -1, var0);
  var2 = randomfloatrange(var0 * -1, var0);
  level.br_level.default_class_chosen[0] = level.br_level.br_mapcenter + (var1, var2, 0);
  level.br_level.default_class_chosen[1] = level.br_level.br_mapcenter + (var1, var2, 0);

  if(getdvarint("scr_truckwar_circle_precalc", 1) == 1) {
    for(var3 = 2; var3 < level.br_level.default_class_chosen.size - 1; var3++) {
      enemy_failsafe_ifonedidntspawn(var3);
    }

    return;
  }

  for(;;) {
    level waittill("br_circle_set");
    enemy_failsafe_ifonedidntspawn();
  }
}

function enemy_failsafe_ifonedidntspawn(var0) {
  if(!isDefined(var0)) {
    var0 = level.br_circle.circleindex + 1;
  }

  if(level.br_level.default_class_chosen.size <= var0 || !istrue(level.ref_13ecd)) {
    return;
  }

  var1 = level.br_level.default_class_chosen[var0];
  var2 = level.br_level.br_circleradii[var0 - 1] * level.ref_13ecc;
  var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var1, var2, 0.8, 1, 1, 0, 1);
  var4 = vectorNormalize(var3 - var1) * var2;
  var5 = var1 + var4;
  var6 = getdvarint("scr_truckwar_circle_padding", 10000);
  var7 = vectorNormalize(level.br_level.br_mapcenter - var5);

  while(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var5, 1)) {
    var5 += var7 * var6;
  }

  level.br_level.default_class_chosen[var0 + 1] = var5;
}

function enemy_close_in_on_player(var0) {
  var1 = level.br_level.br_mapbounds;
  var2 = level.ref_13ece;
  var3 = var0[0] < var1[0][0] * var2 && var0[0] > var1[1][0] * var2 && var0[1] < var1[0][1] * var2 && var0[1] > var1[1][1] * var2;
  return var3;
}

function getgamewinnerprop(var0, var1) {
  var2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var4 = var2 - var0;
  var5 = distance2d(var2, var0);

  if(var5 < var3) {
    return 0;
  }

  var6 = 0;
  var7 = (0, 0, 0);
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = 0;
  var12 = level.br_level.br_circleclosetimes[level.br_circle.circleindex];

  if(level.br_circle.circleindex > 0) {
    var13 = level.br_level.default_class_chosen[level.br_circle.circleindex];
    var6 = distance2d(var2, var13);
    var7 = vectorNormalize(var2 - var13);
  }

  var8 = var6 / var12;
  var14 = level.br_level.br_circleradii[level.br_circle.circleindex];
  var9 = var14 - var3;
  var10 = vectorNormalize(var4);
  var11 = var9 / var12;
  var15 = var0 + var7 * -1 * var1 * var8 + var10 * -1 * var1 * var11;
  return _calloutmarkerping_handleluinotify_enemyrepinged::ref_127da(var15);
}

function ref_13df8() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_truck_wars");
}