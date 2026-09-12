/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vehicles.gsc
************************************************/

function brvehiclesinit() {
  level.modecontrolledvehiclespawningonly = 1;
  level.ignorevehicletypeinstancelimit = 1;
  var_0 = getdvarint("scr_br_dynamic_spawn_veh_buffer", 24);
  level.br_totalvehiclesmax = 128 - var_0;
  level.br_totalvehiclesspawned = 0;
  level.br_helosmax = getdvarint("scr_br_helos_max", 3);
  level.defuse_spawners = getdvarint("scr_br_truck_max", -1);
  level.defuse_nag = getdvarint("scr_br_dauntless_max", -1);
  level.define_trial_mission_init_func = getdvarint("scr_br_bomber_max", -1);
  level.br_vehtargetnametoref = [];
  level.br_vehtargetnametoref["atv_spawn"] = "atv";
  level.br_vehtargetnametoref["cargotruck_spawn"] = "cargo_truck";
  level.br_vehtargetnametoref["cargotrucksusp_spawn"] = "cargo_truck_susp";
  level.br_vehtargetnametoref["cargotruckmg_spawn"] = "cargo_truck_mg";
  level.br_vehtargetnametoref["cargotrucksuspaa_spawn"] = "cargo_truck_susp_aa";
  level.br_vehtargetnametoref["copcar_spawn"] = "cop_car";
  level.br_vehtargetnametoref["hoopty_spawn"] = "hoopty";
  level.br_vehtargetnametoref["hooptytruck_spawn"] = "hoopty_truck";
  level.br_vehtargetnametoref["jeep_spawn"] = "jeep";
  level.br_vehtargetnametoref["largetransport_spawn"] = "large_transport";
  level.br_vehtargetnametoref["littlebird_spawn"] = "little_bird";
  level.br_vehtargetnametoref["littlebirdmg_spawn"] = "little_bird_mg";
  level.br_vehtargetnametoref["veh_a10fd"] = "veh_a10fd";
  level.br_vehtargetnametoref["veh_bt"] = "veh_bt";
  level.br_vehtargetnametoref["mediumtransport_spawn"] = "medium_transport";
  level.br_vehtargetnametoref["motorcycle_spawn"] = "motorcycle";
  level.br_vehtargetnametoref["openjeep_spawn"] = "open_jeep";
  level.br_vehtargetnametoref["open_jeep_carpoc_spawn"] = "open_jeep_carpoc";
  level.br_vehtargetnametoref["pickuptruck_spawn"] = "pickup_truck";
  level.br_vehtargetnametoref["tacrover_spawn"] = "tac_rover";
  level.br_vehtargetnametoref["technical_spawn"] = "technical";
  level.br_vehtargetnametoref["van_spawn"] = "van";
  level.br_vehtargetnametoref["convoytruck_spawn"] = "convoy_truck";
  level.br_vehtargetnametoref["veh_indigo"] = "veh_indigo";
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

function brvehiclesonstartgametype() {
  setupvehiclespawnvolumes();
  brvehiclesreset();
}

function setupvehiclespawnvolumes() {
  var_0 = "vehicle_volume";

  if(getdvarint("scr_br_veh_vol_simple", 1)) {
    var_0 = "vehicle_volume_simplified";
  }

  level.brvehspawnvols = getEntArray(var_0, "script_noteworthy");

  foreach(var_2 in level.brvehspawnvols) {
    initvehiclespawnvolume(var_2);
  }

  level.br_vehicleallspawns = [];
  level.br_vehiclealwaysspawns = [];
  level.br_helospawns = [];
  level.deletex1stashhud = [];
  level.defend_death_counter = [];
  level.debug_warpplayer_monitor = [];
  var_4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(var_6 in var_4.databyref) {
    var_7 = [[var_6.getspawnstructscallback]]();

    if(isDefined(level.play_nag_players_hvt_callouts)) {
      var_7 = [[level.play_nag_players_hvt_callouts]](var_7);
    }

    if(isDefined(level.filtervehiclespawnstructsmapfunc)) {
      var_7 = [[level.filtervehiclespawnstructsmapfunc]](var_14, var_7);
    }

    ref_13E0C(var_7);
    hudcoststring(var_7, "atv_spawn", "atv", "motorcycle_spawn", "motorcycle", "motorcycle_spawn_percent");
    hudcoststring(var_7, "cargotruck_spawn", "cargo_truck", "cargotrucksusp_spawn", "cargo_truck_susp", "cargotrucksusp_spawn_percent");
    hudcoststring(var_7, "cargotrucksusp_spawn", "cargo_truck_susp", "cargotrucksuspaa_spawn", "cargo_truck_susp_aa", "cargotrucksuspaa_spawn_percent");
    hudcoststring(var_7, "jeep_spawn", "jeep", "openjeep_spawn", "open_jeep", "openjeep_spawn_percent");
    hudcoststring(var_7, "veh_bt", "veh_bt", "veh_a10fd", "veh_a10fd", "bt_to_a10fd_spawn_percent");
    hudcoststring(var_7, "cargotrucksuspaa_spawn", "cargo_truck_susp_aa", "openjeep_spawn", "open_jeep", "cargotruckaa_to_openjeep_conv_percent");
    hudcoststring(var_7, "jeep_spawn", "jeep", "open_jeep_carpoc_spawn", "open_jeep_carpoc", "jeep_to_armoredsuv_spawn_percent");
    hudcoststring(var_7, "openjeep_spawn", "open_jeep", "open_jeep_carpoc_spawn", "open_jeep_carpoc", "openjeep_to_armoredsuv_spawn_percent");
    level.br_vehicleallspawns = scripts\engine\utility::array_combine_unique(level.br_vehicleallspawns, var_7);

    foreach(var_9 in var_7) {
      if(isDefined(var_9.script_priority) && var_9.script_priority > 0 && (level.defuse_spawners < 0 || !tv_station_fastrope_two_infil_start_targetname_array(var_9))) {
        var_10 = level.br_vehiclealwaysspawns.size;
        level.br_vehiclealwaysspawns[var_10] = var_9;
        continue;
      }

      if(isDefined(var_9.targetname) && (var_9.targetname == "littlebird_spawn" || var_9.targetname == "littlebirdmg_spawn")) {
        level.br_helospawns[level.br_helospawns.size] = var_9;
        continue;
      }

      if(level.defuse_spawners >= 0 && tv_station_fastrope_two_infil_start_targetname_array(var_9)) {
        level.deletex1stashhud[level.deletex1stashhud.size] = var_9;
        continue;
      }

      if(level.defuse_nag >= 0 && uid(var_9)) {
        level.defend_death_counter[level.defend_death_counter.size] = var_9;
        continue;
      }

      if(level.define_trial_mission_init_func >= 0 && tutorial_intro(var_9)) {
        level.debug_warpplayer_monitor[level.debug_warpplayer_monitor.size] = var_9;
        continue;
      }

      foreach(var_2 in level.brvehspawnvols) {
        if(ispointinvolume(var_9.origin, var_2)) {
          var_10 = var_2.vehiclespawns.size;
          var_2.vehiclespawns[var_10] = var_9;
          break;
        }
      }
    }
  }
}

function initvehiclespawnvolume(var_0) {
  var_0.vehiclespawns = [];
  var_0.vehiclesspawned = 0;

  switch (level.mapname) {
    case "mp_donetsk":
    case "mp_kstenod":
    case "mp_don3":
      assignvehicleminimumsforvolume(var_0);
      break;
    case "mp_don4":
      cargo_truck_mg_mp_ondeathrespawncallback(var_0);
      break;
    case "mp_wz_island":
      cargo_truck_mg_mp_spawncallback(var_0);
      break;
  }
}

function cargo_truck_mg_mp_spawncallback(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "ag_center":
      var_0.minvehicles = 2;
      break;
    case "airfield":
      var_0.minvehicles = 1;
      break;
    case "airfield_bomber":
      var_0.minvehicles = 1;
      break;
    case "airstrip":
      var_0.minvehicles = 0;
      break;
    case "airstrip_bomber":
      var_0.minvehicles = 1;
      break;
    case "arsenal":
      var_0.minvehicles = 1;
      break;
    case "beachhead":
      var_0.minvehicles = 1;
      break;
    case "caldera":
      var_0.minvehicles = 1;
      break;
    case "capital":
      var_0.minvehicles = 3;
      break;
    case "docks":
      var_0.minvehicles = 1;
      break;
    case "mines":
      var_0.minvehicles = 1;
      break;
    case "ruins":
      var_0.minvehicles = 1;
      break;
    case "subpen":
      var_0.minvehicles = 2;
      break;
    case "village":
      var_0.minvehicles = 1;
      break;
    case "lagoon":
      var_0.minvehicles = 1;
      break;
    case "radiostation":
      var_0.minvehicles = 3;
      break;
    case "resort":
      var_0.minvehicles = 1;
      break;
  }
}

function cargo_truck_mg_mp_ondeathrespawncallback(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "boneyard":
      var_0.minvehicles = 2;
      break;
    case "summit":
      var_0.minvehicles = 2;
      break;
    case "summit_helipad":
      var_0.minvehicles = 1;
      break;
    case "downtown":
      var_0.minvehicles = 4;
      break;
    case "downtownpark":
      var_0.minvehicles = 1;
      break;
    case "farm":
      var_0.minvehicles = 4;
      break;
    case "gulag":
      var_0.minvehicles = 1;
      break;
    case "hospital":
      var_0.minvehicles = 0;
      break;
    case "junkyard":
      var_0.minvehicles = 1;
      break;
    case "layover":
      var_0.minvehicles = 3;
      break;
    case "lumber":
      var_0.minvehicles = 2;
      break;
    case "militarybase":
      var_0.minvehicles = 3;
      break;
    case "port":
      var_0.minvehicles = 2;
      break;
    case "quarry":
      var_0.minvehicles = 2;
      break;
    case "stadium":
      var_0.minvehicles = 1;
      break;
    case "storagewars":
      var_0.minvehicles = 1;
      break;
    case "super":
      var_0.minvehicles = 1;
      break;
    case "torez":
      var_0.minvehicles = 1;
      break;
    case "transit":
      var_0.minvehicles = 2;
      break;
    case "tvstation":
      var_0.minvehicles = 1;
      break;
    case "duga":
      var_0.minvehicles = 1;
      break;
    case "abandoned":
      var_0.minvehicles = 1;
      break;
    case "test_zone":
      var_0.minvehicles = 1;
      break;
  }
}

function assignvehicleminimumsforvolume(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "boneyard":
      var_0.minvehicles = 2;
      break;
    case "dam":
      var_0.minvehicles = 2;
      break;
    case "downtown":
      var_0.minvehicles = 4;
      break;
    case "downtownpark":
      var_0.minvehicles = 1;
      break;
    case "farm":
      var_0.minvehicles = 4;
      break;
    case "gulag":
      var_0.minvehicles = 1;
      break;
    case "hospital":
      var_0.minvehicles = 0;
      break;
    case "junkyard":
      var_0.minvehicles = 1;
      break;
    case "layover":
      var_0.minvehicles = 3;
      break;
    case "lumber":
      var_0.minvehicles = 2;
      break;
    case "militarybase":
      var_0.minvehicles = 3;
      break;
    case "port":
      var_0.minvehicles = 2;
      break;
    case "quarry":
      var_0.minvehicles = 2;
      break;
    case "stadium":
      var_0.minvehicles = 1;
      break;
    case "storagewars":
      var_0.minvehicles = 1;
      break;
    case "super":
      var_0.minvehicles = 1;
      break;
    case "torez":
      var_0.minvehicles = 1;
      break;
    case "transit":
      var_0.minvehicles = 2;
      break;
    case "tvstation":
      var_0.minvehicles = 1;
      break;
    case "test_zone":
      var_0.minvehicles = 1;
      break;
  }
}

function emptyallvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  foreach(var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DE(var_3)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_3);
      }
    }
  }
}

function deleteextantvehicles(var_0) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_spawn::ref_14212();
  level.suppressvehicleexplosion = 1;

  foreach(var_2 in level.vehicle.instances) {
    var_3 = scripts\mp\vehicles\damage::get_death_callback(var_7);

    foreach(var_5 in var_2) {
      if(isDefined(var_0) && scripts\engine\utility::array_contains(var_0, var_5)) {
        continue;
      }

      scripts\cp_mp\vehicles\vehicle_spawn::ref_14219(var_5);
      var_5[[var_3]](undefined);
    }
  }

  level.suppressvehicleexplosion = 0;
}

function tryspawnavehicle(var_0, var_1, var_2, var_3) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("vehicleSpawns")) {
    return;
  }

  if((var_0 == "little_bird" || var_0 == "little_bird_mg") && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("littleBirdSpawns")) {
    return;
  }

  if((var_0 == "cargo_truck" || var_0 == "cargo_truck_mg") && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("truckSpawns")) {
    return;
  }

  if(var_0 == "jeep" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("jeepSpawns")) {
    return;
  }

  if(var_0 == "tac_rover" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("tacRoverSpawns")) {
    return;
  }

  if(var_0 == "atv" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("atvSpawns")) {
    return;
  }

  if(var_0 == "motorcycle" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("motorcycleSpawns")) {
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(var_0, undefined, undefined, var_1)) {
    var_4 = spawnavehicle(var_0, var_1, var_3);

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

function spawnavehicle(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;

  if(!isDefined(var_4)) {
    var_4 = (0, randomfloat(360), 0);
  }

  var_5 = spawnStruct();
  var_5.origin = var_3;
  var_5.angles = var_4;
  var_5.spawntype = "GAME_MODE";
  var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var_0, var_5, var_2);

  if(isDefined(var_6)) {
    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("postSpawnVehicle")) {
      scripts\mp\gametypes\br_gametypes::ref_12E05("postSpawnVehicle", var_6, var_0);
    }

    scripts\mp\gametypes\br_analytics::dialog_monitor_shieldstow(var_6, var_0);

    if(var_0 == "little_bird" || var_0 == "little_bird_mg") {
      var_6.isheli = 1;
    }

    if(!isDefined(var_6.unique_id)) {
      var_6 scripts\engine\flags::assign_unique_id();
    }
  }

  return var_6;
}

function spawninitialvehicles() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  level.br_totalvehiclesspawned = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = level.br_vehicleallspawns;
  var_4 = scripts\engine\utility::array_randomize(level.br_vehiclealwaysspawns);

  foreach(var_6 in var_4) {
    var_7 = spawnStruct();
    var_8 = level.br_vehtargetnametoref[var_6.targetname];
    var_9 = tryspawnavehicle(var_8, var_6, "alwaysSpawn", var_7);

    if(isDefined(var_9)) {
      level.br_totalvehiclesspawned++;
      var_2 = var_6;
      var_10 = 0;

      foreach(var_12 in level.brvehspawnvols) {
        if(ispointinvolume(var_6.origin, var_12)) {
          var_12.vehiclesspawned++;
          var_10 = 1;
          break;
        }
      }

      if(var_10) {}

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
      continue;
    }

    <
    error > ++;
  }

  var_1 = undefined;
  var_6 = undefined;
  var_19 = 0;

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_20 = scripts\engine\utility::array_randomize(level.brvehspawnvols);

    foreach(var_12 in var_20) {
      var_22 = var_12.minvehicles;

      if(isDefined(var_22) && var_22 > 0) {
        if(var_22 > var_12.vehiclespawns.size) {}

        if(var_12.vehiclesspawned < var_22 && var_12.vehiclespawns.size > 0) {
          var_23 = scripts\engine\utility::array_randomize(var_12.vehiclespawns);

          for(var_24 = 0; var_12.vehiclesspawned < var_22 && var_24 < var_23.size; var_24++) {
            var_3 = spawnStruct();
            var_2 = var_23[var_24];
            var_4 = level.br_vehtargetnametoref[var_2.targetname];
            var_5 = tryspawnavehicle(var_4, var_2, var_12.targetname, var_3);

            if(!isDefined(var_5)) {
              var_19++;
              continue;
            }

            level.br_totalvehiclesspawned++; <
            error > = var_2;
            var_12.vehiclesspawned++;

            if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
              break;
            }

            waitframe();
          }

          if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
            break;
          }
        }
      }
    }

    var_19 = undefined;
    var_12 = undefined;
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_26 = 0;
    var_27 = scripts\engine\utility::array_randomize(level.br_helospawns);

    foreach(var_0 in var_27) {
      var_1 = spawnStruct();
      var_2 = level.br_vehtargetnametoref[var_0.targetname];
      var_3 = tryspawnavehicle(var_2, var_0, "heloSpawn", var_1);

      if(isDefined(var_3)) {
        level.br_totalvehiclesspawned++; <
        error > = var_0;
        var_26++;

        if(var_26 >= level.br_helosmax) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_spawners > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_30 = 0;
    var_31 = scripts\engine\utility::array_randomize(level.deletex1stashhud);

    foreach(var_0 in var_31) {
      var_1 = spawnStruct();
      var_2 = level.br_vehtargetnametoref[var_0.targetname];
      var_3 = tryspawnavehicle(var_2, var_0, "truckSpawn", var_1);

      if(isDefined(var_3)) {
        level.br_totalvehiclesspawned++; <
        error > = var_0;
        var_30++;

        if(var_30 >= level.defuse_spawners) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_nag > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_34 = 0;
    var_35 = scripts\engine\utility::array_randomize(level.defend_death_counter);

    foreach(var_0 in var_35) {
      var_1 = spawnStruct();
      var_2 = level.br_vehtargetnametoref[var_0.targetname];
      var_3 = tryspawnavehicle(var_2, var_0, "veh_a10fd", var_1);

      if(isDefined(var_3)) {
        level.br_totalvehiclesspawned++; <
        error > = var_0;
        var_34++;

        if(var_34 >= level.defuse_nag) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.define_trial_mission_init_func > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_38 = 0;
    var_39 = scripts\engine\utility::array_randomize(level.debug_warpplayer_monitor);

    foreach(var_0 in var_39) {
      var_1 = spawnStruct();
      var_2 = level.br_vehtargetnametoref[var_0.targetname];
      var_3 = tryspawnavehicle(var_2, var_0, "veh_bt", var_1);

      if(isDefined(var_3)) {
        level.br_totalvehiclesspawned++; <
        error > = var_0;
        var_38++;

        if(var_38 >= level.define_trial_mission_init_func) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_spawners >= 0) {
    <
    error > = scripts\engine\utility::array_remove_array( < error > , level.deletex1stashhud);
  }

  if(level.defuse_nag >= 0) {
    <
    error > = scripts\engine\utility::array_remove_array( < error > , level.defend_death_counter);
  }

  if(level.define_trial_mission_init_func >= 0) {
    <
    error > = scripts\engine\utility::array_remove_array( < error > , level.debug_warpplayer_monitor);
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_23 = 0; <
    error > = scripts\engine\utility::array_remove_array( < error > , < error > ); <
    error > = scripts\engine\utility::array_randomize( < error > );

    foreach(var_0 in < error > ) {
      var_2 = level.br_vehtargetnametoref[var_0.targetname];

      while(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
        wait 1;
      }

      var_1 = spawnStruct();
      var_3 = tryspawnavehicle(var_2, var_0, "randomSpawns", var_1);

      if(isDefined(var_3)) {
        level.br_totalvehiclesspawned++;
        var_23++;

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  var_44 = 0;
  var_52 = < error > +var_5;

  if(var_44 > 0) {
    return;
  }
}

function brvehiclespawnvolreset() {
  level.br_totalvehiclesspawned = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(var_2 in level.brvehspawnvols) {
    var_2.vehiclesspawned = 0;
  }
}

function waitforvehiclestodeletethenspawninitial() {
  level endon("game_ended");
  level notify("br_vehiclesWaitForDelete");
  level endon("br_vehiclesWaitForDelete");
  waitframe();
  waittillframeend();

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("spawnInitialVehicles")) {
    scripts\mp\gametypes\br_gametypes::ref_12E05("spawnInitialVehicles");
    return;
  }

  spawninitialvehicles();
}

function brvehiclesreset() {
  emptyallvehicles();
  deleteextantvehicles();
  brvehiclespawnvolreset();
  thread waitforvehiclestodeletethenspawninitial();
  level notify("br_vehiclesReset");
}

function brvehicleonprematchstarted() {
  wait 1.5;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(0);
  brvehiclesreset();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(1);
}

function enemy_monitor_reload() {
  var_0 = scripts\engine\utility::array_combine(level.vehicle.instances["little_bird"], level.vehicle.instances["little_bird_mg"]);
  return var_0;
}

function enemy_molotov_launch() {
  var_0 = scripts\engine\utility::array_combine(level.vehicle.instances["veh_a10fd"], level.vehicle.instances["veh_bt"]);
  return var_0;
}

function dangercircletick(var_0, var_1) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  var_2 = 160;
  var_3 = 36;
  var_4 = 100;
  var_5 = getdvarfloat("scr_br_heli_circle_damage_tick", var_4);
  var_6 = enemy_monitor_reload();

  if(isDefined(var_6)) {
    foreach(var_8 in var_6) {
      var_9 = 0;
      var_10 = var_8.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 + var_2 > var_1) {
        var_9 = 1;
      } else {
        var_12 = var_8 gettagorigin("tail_rotor_jnt");
        var_11 = distance2d(var_0, var_12);

        if(var_11 + var_3 > var_1) {
          var_9 = 1;
        }
      }

      if(var_9) {
        var_8 dodamage(var_5, var_10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }

  var_14 = getdvarint("scr_br_aircraft_circle_damage_tick", 85);

  if(isDefined(level.vehicle.instances["veh_a10fd"])) {
    foreach(var_16 in level.vehicle.instances["veh_a10fd"]) {
      var_17 = 0;
      var_10 = var_16.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 > var_1) {
        var_17 = 1;
      }

      if(var_17) {
        var_16 dodamage(var_14, var_10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }

  var_19 = getdvarint("scr_br_bomber_circle_damage_tick", 100);

  if(isDefined(level.vehicle.instances["veh_bt"])) {
    foreach(var_21 in level.vehicle.instances["veh_bt"]) {
      var_22 = 0;
      var_10 = var_21.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 > var_1) {
        var_22 = 1;
      }

      if(var_22) {
        var_21 dodamage(var_19, var_10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }

    return;
  }
}

function hudcoststring(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarfloat(var_5, 0);

  if(var_6 == 0) {
    return;
  }

  var_6 = clamp(var_6, 0, 100) / 100;
  var_7 = [];

  foreach(var_9 in var_0) {
    if(vars_update(var_9, var_1, var_2)) {
      var_7 = var_9;
    }
  }

  var_7 = scripts\engine\utility::array_randomize(var_7);
  var_11 = floor(var_7.size * var_6);

  for(var_12 = 0; var_12 < var_7.size && var_12 < var_11; var_12++) {
    var_7[var_12].targetname = var_3;
    var_7[var_12].refname = var_4;
  }
}

function vars_update(var_0, var_1, var_2) {
  if(isDefined(var_0.targetname) && var_0.targetname == var_1) {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == var_2) {
    return true;
  }

  return false;
}

function ref_13E0C(var_0) {
  var_1 = getdvarfloat("lb_mg_spawn_percent", 0);

  if(var_1 == 0) {
    return;
  }

  var_1 = clamp(var_1, 0, 100) / 100;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(update_bomb_vest_controller(var_4)) {
      var_2 = var_4;
    }
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_6 = floor(var_2.size * var_1);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_4 = var_2[var_7];
    var_4.targetname = "littlebirdmg_spawn";
    var_4.refname = "little_bird_mg";
  }
}

function update_bomb_vest_controller(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "littlebird_spawn") {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == "little_bird") {
    return true;
  }

  return false;
}

function tv_station_fastrope_two_infil_start_targetname_array(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "cargotruck_spawn") {
    return true;
  }

  if(isDefined(var_0.targetname) && var_0.targetname == "cargotruckmg_spawn") {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == "cargo_truck") {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == "cargo_truck_mg") {
    return true;
  }

  return false;
}

function uid(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "veh_a10fd") {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == "veh_a10fd") {
    return true;
  }

  return false;
}

function tutorial_intro(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "veh_bt") {
    return true;
  }

  if(isDefined(var_0.refname) && var_0.refname == "veh_bt") {
    return true;
  }

  return false;
}