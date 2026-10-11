/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_vehicles.gsc
***************************************************/

#using script_439d01e25d19543b;
#using scripts\common\utility;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#namespace br_vehicles;

function brvehiclesinit() {
  level.modecontrolledvehiclespawningonly = 1;
  var_6fc423af9a153f6b = getdvarint(@ "hash_bb06b4f8c704366b", 1);
  vehiclesbuffer = getdvarint(@ "scr_br_dynamic_spawn_veh_buffer", 24);
  level.br_totalvehiclesmax = 128 - vehiclesbuffer;
  level.br_totalvehiclesspawned = 0;
  level.br_helosmax = getdvarint(@ "hash_389f02283326428e", 3);
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level.br_vehtargetnametoref = [];
  level.br_vehtargetnametoref["atv_spawn"] = "atv";
  level.br_vehtargetnametoref["littlebird_spawn"] = "little_bird";
  level.br_vehtargetnametoref["tacrover_spawn"] = "tac_rover";
  level.br_vehtargetnametoref["jltv_spawn"] = "veh9_jltv";
  level.br_vehtargetnametoref["sedan_hatchback_1985_spawn"] = "veh9_sedan_hatchback_1985";
  level.br_vehtargetnametoref["suv_1996_spawn"] = "veh9_suv_1996";
  level.br_vehtargetnametoref["mil_cargo_truck_spawn"] = "veh9_mil_cargo_truck";
  level.br_vehtargetnametoref["hummer_spawn"] = "veh9_hummer";
  level.br_vehtargetnametoref["overland_2016_spawn"] = "veh9_overland_2016";
  level.br_vehtargetnametoref["utv_spawn"] = "veh9_utv";
  level.br_vehtargetnametoref["acv_6x6_spawn"] = "veh9_acv_6x6";
  level.br_vehtargetnametoref["pwc_spawn"] = "veh9_pwc";
  level.br_vehtargetnametoref["civ_lnd_dirt_bike_spawn"] = "veh9_civ_lnd_dirt_bike";
  level.br_vehtargetnametoref["research_vessel_spawn"] = "veh_jup_research_vessel";
  level.br_vehtargetnametoref["jup_orav_spawn"] = "veh_jup_orav";
  level.br_vehtargetnametoref["jup_razorback_spawn"] = "veh_jup_razorback";
  level.br_vehtargetnametoref["techo_rebel_spawn"] = "veh9_techo_rebel_armor";
  level.br_vehtargetnametoref["jup_polaris_utv_spawn"] = "veh_jup_polaris_utv";
  function_ebf775f8fdd1d098();

  if(istrue(var_6fc423af9a153f6b)) {
    level.br_vehtargetnametoref["rhib_spawn"] = "veh9_rhib";
    level.br_vehtargetnametoref["patrol_boat_spawn"] = "veh9_patrol_boat";
  }

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    if(getdvarint(@ "hash_81e631c248118cd6", 1) != 1) {
      level.br_vehtargetnametoref["palfa_spawn"] = "veh9_palfa";
    }

    level.br_vehtargetnametoref["jltv_mg_spawn"] = "veh9_jltv_mg";
  }

  scripts\mp\gametypes\br_circle::registercirclecallbacks(1, &dangercircletick, &function_1a1709943670772a);
  function_f2f0d979611c9bdb();
  level thread function_10bd49da0d1d0e99();
  function_c3fe673ce43bb311("little_bird", 5.5);
  function_c3fe673ce43bb311("veh9_palfa", 4.5);

  level thread mychangeswatcher();
}

function private function_f2f0d979611c9bdb() {
  level.var_2cd1dac048ce018 = [];

  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_67de886abb1a6fe3)) {
    foreach(vehicleentry in level.gametypebundle.var_67de886abb1a6fe3) {
      level.var_2cd1dac048ce018[vehicleentry.var_f7a73a78711ebde5] = vehicleentry.var_81fb9913371aaaa1;
    }
  }
}

function function_ec5f666d56372630(vehicleref) {
  if(!getdvarint(@ "scr_ssc_enabled", 0)) {
    return 0;
  }

  if(!array_contains(level.br_vehtargetnametoref, vehicleref)) {
    return 0;
  }

  if(getdvarint(@ "hash_befa7ffc4484488a", 0)) {
    return 1;
  }

  return default_to(level.var_2cd1dac048ce018[vehicleref], 0);
}

function function_10bd49da0d1d0e99() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("POIs_initialized");
  vehiclerefs = ["atv", "little_bird", "tac_rover", "veh9_jltv", "veh9_sedan_hatchback_1985", "veh9_suv_1996", "veh9_mil_cargo_truck", "veh9_hummer", "veh9_overland_2016", "veh9_utv", "veh9_acv_6x6", "veh9_pwc", "veh9_rhib", "veh9_patrol_boat", "veh9_palfa", "veh9_jltv_mg", "veh_jup_razorback", "veh_jup_orav", "veh_jup_research_vessel", "veh9_techo_rebel_armor", "veh_jup_polaris_utv"];

  foreach(vehicleref in vehiclerefs) {
    if([[getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](vehicleref)) {
      if(function_ec5f666d56372630(vehicleref)) {
        scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517(vehicleref, &function_5a6b4f3358f3e3cc);
        scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e(vehicleref, &function_cb75d1e034823cb5);
        scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd(vehicleref, &function_fb0db2fc84df7793);
      }
    }
  }
}

function brvehiclesonstartgametype() {
  if(getdvarint(@ "hash_6cce831ff331c183", 0)) {
    level thread function_1c7a4c53fa428606();
    return;
  }

  setupvehiclespawnvolumes();
  brvehiclesreset();
}

function setupvehiclespawnvolumes() {
  volume_sets = "vehicle_volume";

  if(getdvarint(@ "hash_2cbc9c033fdea714", 1)) {
    volume_sets = "vehicle_volume_simplified";
  }

  level.brvehspawnvols = getEntArray(volume_sets, "script_noteworthy");

  foreach(vol in level.brvehspawnvols) {
    initvehiclespawnvolume(vol);
  }

  level.br_vehicleallspawns = [];
  level.br_vehiclealwaysspawns = [];
  level.br_helospawns = [];
  level.var_b54c13ad1bd00973 = [];
  var_7164111ed75798cc = vehicle_spawn_getleveldata();

  foreach(refname in level.br_vehtargetnametoref) {
    vehiclespawnstructs = function_b08e7e3a0b14f76f(refname);

    if(isDefined(level.filtervehiclespawnstructsfunc)) {
      vehiclespawnstructs = [[level.filtervehiclespawnstructsfunc]](vehiclespawnstructs);
    }

    if(isDefined(level.var_20b5ab3069c073e2)) {
      vehiclespawnstructs = [[level.var_20b5ab3069c073e2]](refname, vehiclespawnstructs);
    }

    level.var_b54c13ad1bd00973[refname] = vehiclespawnstructs;
    level.br_vehicleallspawns = array_combine_unique(level.br_vehicleallspawns, vehiclespawnstructs);

    foreach(spawnpoint in vehiclespawnstructs) {
      if(getdvarint(@ "hash_6cce831ff331c183", 0) > 0) {
        function_d96e7d92cdd79f9e(spawnpoint);
      }

      if(isDefined(spawnpoint.script_priority) && spawnpoint.script_priority > 0) {
        arraysize = level.br_vehiclealwaysspawns.size;
        level.br_vehiclealwaysspawns[arraysize] = spawnpoint;
        continue;
      }

      if(isDefined(spawnpoint.targetname) && spawnpoint.targetname == "littlebird_spawn") {
        level.br_helospawns[level.br_helospawns.size] = spawnpoint;
        continue;
      }

      foreach(vol in level.brvehspawnvols) {
        if(ispointinvolume(spawnpoint.origin, vol)) {
          arraysize = vol.vehiclespawns.size;
          vol.vehiclespawns[arraysize] = spawnpoint;
          break;
        }
      }
    }
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    println("<dev string:x1c>" + level.br_vehicleallspawns.size);
    var_7164111ed75798cc = vehicle_spawn_getleveldata();
    println("<dev string:x4d>" + level.br_vehiclealwaysspawns.size + "<dev string:x6b>");

    foreach(spawnpoint in level.br_vehiclealwaysspawns) {
      refname = level.br_vehtargetnametoref[spawnpoint.targetname];
      println("<dev string:x89>" + refname + "<dev string:x90>" + spawnpoint.origin);
    }

    totalspawnpoints = 0;
    var_9ee3f0d2d796f396 = 0;

    foreach(vol in level.brvehspawnvols) {
      println("<dev string:x98>" + vol.targetname);
      numspawnpoints = vol.vehiclespawns.size;
      minreq = vol.minvehicles;

      if(numspawnpoints > 0 || minreq > 0) {
        println("<dev string:xbd>" + numspawnpoints + "<dev string:xc6>" + minreq);
      }

      totalspawnpoints += numspawnpoints;
      var_9ee3f0d2d796f396 += minreq;
    }

    println("<dev string:xea>" + totalspawnpoints);
    println("<dev string:x10a>" + var_9ee3f0d2d796f396);
  }
}

function initvehiclespawnvolume(vol) {
  vol.vehiclespawns = [];
  vol.vehiclesspawned = 0;
  assignvehicleminimumsforvolume(vol);
}

function assignvehicleminimumsforvolume(vol) {
  assert(isDefined(vol.targetname));
  vol.minvehicles = 0;

  switch (vol.targetname) {
    case #"hash_3c20c20dc3935d6f":
      vol.minvehicles = 2;
      break;
    case #"hash_f48a166c03bb39c1":
      vol.minvehicles = 2;
      break;
    case #"hash_2c5efc9850d0cbb5":
      vol.minvehicles = 4;
      break;
    case #"hash_6058392aebff0469":
      vol.minvehicles = 1;
      break;
    case #"hash_9c5e8152de8ef99":
      vol.minvehicles = 4;
      break;
    case #"hash_663b0900ff0e81c7":
      vol.minvehicles = 1;
      break;
    case #"hash_959ab3efc8aa213":
      vol.minvehicles = 0;
      break;
    case #"hash_2e0fe9d434d05e53":
      vol.minvehicles = 1;
      break;
    case #"hash_209449a3db12c20f":
      vol.minvehicles = 3;
      break;
    case #"hash_da04b46361bbb6a6":
      vol.minvehicles = 2;
      break;
    case #"hash_37e94b17102ea1b":
      vol.minvehicles = 3;
      break;
    case #"hash_5f22fd847b75bb06":
      vol.minvehicles = 2;
      break;
    case #"hash_b445759ac0026f01":
      vol.minvehicles = 2;
      break;
    case #"hash_a86d6bdba8e7b140":
      vol.minvehicles = 1;
      break;
    case #"hash_118da067c85a311d":
      vol.minvehicles = 1;
      break;
    case #"hash_e534fd8ec73eafb4":
      vol.minvehicles = 1;
      break;
    case #"hash_426f768afb41bbcd":
      vol.minvehicles = 1;
      break;
    case #"hash_2094a957c0515134":
      vol.minvehicles = 2;
      break;
    case #"hash_c0087eafd38b4fed":
      vol.minvehicles = 1;
      break;
    case #"hash_f18542c5ad2a1020":
      vol.minvehicles = 1;
      break;
  }
}

function emptyallvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  foreach(var_e5cd5ce5ee8dc6c9 in level.vehicle.instances) {
    foreach(vehicle in var_e5cd5ce5ee8dc6c9) {
      if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle)) {
        vehicle_occupancy_ejectalloccupants(vehicle);
      }
    }
  }
}

function deleteextantvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_cancelpendingrespawns();

  foreach(var_e5cd5ce5ee8dc6c9 in level.vehicle.instances) {
    foreach(vehicle in var_e5cd5ce5ee8dc6c9) {
      scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);
      vehicle.dontspawnhusk = 1;
      level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
    }
  }
}

function tryspawnavehicle(refname, locstruct, volname, faildata) {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("vehicleSpawns")) {
    return;
  }

  if((refname == "little_bird" || refname == "little_bird_mg") && scripts\mp\gametypes\br_gametypes::isfeaturedisabled("littleBirdSpawns")) {
    return;
  }

  if(refname == "veh9_overland_2016" && distancesquared(locstruct.origin, (19290, -23687, 1123)) < 250000) {
    return;
  }

  if(refname == "atv" && distancesquared(locstruct.origin, (-19928, -48860, 207)) < 250000) {
    return;
  }

  if(refname == "veh9_pwc" && distancesquared(locstruct.origin, (-7168, 29580, 120)) < 250000) {
    return;
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeatureenabled("gasVehicleSpawns")) {
    if(!scripts\mp\gametypes\br_circle::ispointwithininitialdangercircle(locstruct.origin)) {
      return;
    }
  }

  if(vehicle_spawn_canspawnVehicle(refname)) {
    newvehicle = spawnavehicle(refname, locstruct, faildata);

    if(isDefined(newvehicle)) {
      println("<dev string:x12d>" + refname + "<dev string:x148>" + volname + "<dev string:x90>" + locstruct.origin + "<dev string:x157>");
      return newvehicle;
    }
  }

  return undefined;
}

function spawnavehicle(refname, locstruct, faildata) {
  spawnorigin = locstruct.origin;
  spawnangles = locstruct.angles;

  if(!isDefined(spawnangles)) {
    spawnangles = (0, randomfloat(360), 0);
  }

  spawndata = spawnStruct();
  spawndata.origin = spawnorigin;
  spawndata.angles = spawnangles;
  spawndata.spawntype = "GAME_MODE";
  newvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(refname, spawndata, faildata);

  if(isDefined(newvehicle)) {
    scripts\mp\gametypes\br_analytics::branalytics_vehiclespawned(newvehicle, refname);
  }

  return newvehicle;
}

function spawninitialvehicles() {
  var_7164111ed75798cc = vehicle_spawn_getleveldata();

  if(getdvarint(@ "hash_6cce831ff331c183", 0)) {
    return;
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    println("<dev string:x15c>");
    println("<dev string:x175>");
  }

  var_96eb15d5230a7b6e = 0;
  usedspawns = [];
  unusedspawns = level.br_vehicleallspawns;

  level.var_f44c6f8a04520f44 = [];
  level.var_991ab87ce5e247eb = [];

  var_d23016d6d9981605 = array_randomize(level.br_vehiclealwaysspawns);

  foreach(spawnpoint in var_d23016d6d9981605) {
    faildata = spawnStruct();
    refname = level.br_vehtargetnametoref[spawnpoint.targetname];

    if(function_ec5f666d56372630(refname)) {
      continue;
    }

    newvehicle = tryspawnavehicle(refname, spawnpoint, "alwaysSpawn", faildata);

    if(isDefined(newvehicle)) {
      level.br_totalvehiclesspawned++;
      usedspawns[usedspawns.size] = spawnpoint;

      if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
        line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (0, 1, 0), 1, 1, 20000);

        if(isDefined(level.var_991ab87ce5e247eb[refname])) {
          level.var_991ab87ce5e247eb[refname]++;
        } else {
          level.var_991ab87ce5e247eb[refname] = 1;
        }

        println("<dev string:x89>" + refname + "<dev string:x194>" + newvehicle.origin);
      }

      var_1d035a86ea1b5e63 = 0;

      foreach(vol in level.brvehspawnvols) {
        if(ispointinvolume(spawnpoint.origin, vol)) {
          vol.vehiclesspawned++;
          var_1d035a86ea1b5e63 = 1;
          break;
        }
      }

      if(!var_1d035a86ea1b5e63) {
        if(isDefined(level.var_f44c6f8a04520f44[refname])) {
          level.var_f44c6f8a04520f44[refname]++;
        } else {
          level.var_f44c6f8a04520f44[refname] = 1;
        }
      }

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
      continue;
    }

    var_96eb15d5230a7b6e++;
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    foreach(vol in level.brvehspawnvols) {
      println("<dev string:x1a5>" + vol.targetname);
    }

    println("<dev string:x1d1>");

    foreach(refname, data in var_7164111ed75798cc.databyref) {
      if(isDefined(level.var_f44c6f8a04520f44[refname]) && level.var_f44c6f8a04520f44[refname] > 0) {
        println("<dev string:x89>" + refname + "<dev string:x200>" + level.var_f44c6f8a04520f44[refname] + "<dev string:x206>");
      }
    }

    println("<dev string:x226>" + var_96eb15d5230a7b6e);
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    println("<dev string:x252>");
  }

  var_82e084d0cb9a7f40 = 0;

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_60c2c2b7cea6e920 = array_randomize(level.brvehspawnvols);

    foreach(vol in var_60c2c2b7cea6e920) {
      println("<dev string:x26e>" + vol.targetname + "<dev string:x2a5>" + vol.minvehicles + "<dev string:x2ab>");
      var_b243344e26fc2116 = vol.minvehicles;

      if(isDefined(var_b243344e26fc2116) && var_b243344e26fc2116 > 0) {
        if(var_b243344e26fc2116 > vol.vehiclespawns.size) {
          println("<dev string:x2b0>" + vol.targetname + "<dev string:x2d7>" + var_b243344e26fc2116 + "<dev string:x2e2>" + vol.vehiclespawns.size + "<dev string:x2fb>");
        }

        if(vol.vehiclesspawned < var_b243344e26fc2116 && vol.vehiclespawns.size > 0) {
          randomspawns = array_remove_array(array_randomize(vol.vehiclespawns), usedspawns);

          for(spawnindex = 0; vol.vehiclesspawned < var_b243344e26fc2116 && spawnindex < randomspawns.size; spawnindex++) {
            faildata = spawnStruct();
            spawnpoint = randomspawns[spawnindex];
            refname = level.br_vehtargetnametoref[spawnpoint.targetname];

            if(function_ec5f666d56372630(refname)) {
              continue;
            }

            newvehicle = tryspawnavehicle(refname, spawnpoint, vol.targetname, faildata);

            if(!isDefined(newvehicle)) {
              var_82e084d0cb9a7f40++;
              println("<dev string:x300>" + vol.targetname + "<dev string:x320>" + spawnpoint.origin + "<dev string:x2ab>");
              continue;
            }

            level.br_totalvehiclesspawned++;
            usedspawns[usedspawns.size] = spawnpoint;
            vol.vehiclesspawned++;

            if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
              line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (0, 1, 1), 1, 1, 20000);

              if(isDefined(level.var_991ab87ce5e247eb[refname])) {
                level.var_991ab87ce5e247eb[refname]++;
              } else {
                level.var_991ab87ce5e247eb[refname] = 1;
              }

              println("<dev string:x89>" + refname + "<dev string:x194>" + newvehicle.origin);
            }

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
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    println("<dev string:x33b>");
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_56b381327050bc62 = 0;
    var_5c969801281b9666 = array_remove_array(array_randomize(level.br_helospawns), usedspawns);

    foreach(spawnpoint in var_5c969801281b9666) {
      faildata = spawnStruct();
      refname = level.br_vehtargetnametoref[spawnpoint.targetname];

      if(function_ec5f666d56372630(refname)) {
        continue;
      }

      newvehicle = tryspawnavehicle(refname, spawnpoint, "heloSpawn", faildata);

      if(isDefined(newvehicle)) {
        level.br_totalvehiclesspawned++;
        usedspawns[usedspawns.size] = spawnpoint;

        if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
          line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (1, 1, 1), 1, 1, 20000);

          if(isDefined(level.var_991ab87ce5e247eb[refname])) {
            level.var_991ab87ce5e247eb[refname]++;
          } else {
            level.var_991ab87ce5e247eb[refname] = 1;
          }

          println("<dev string:x89>" + refname + "<dev string:x194>" + newvehicle.origin);
        }

        var_56b381327050bc62++;

        if(var_56b381327050bc62 >= level.br_helosmax) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }

    if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
      println("<dev string:x354>" + var_56b381327050bc62 + "<dev string:x360>");
    }
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax && scripts\mp\poi::poi_issystemactive()) {
    function_9856ad860555f8b9();
    unusedspawns = array_remove_array(unusedspawns, usedspawns);

    foreach(refname, spawns in level.var_b54c13ad1bd00973) {
      if(!isDefined(level.var_a5791492570c75fc) || !isDefined(level.var_a5791492570c75fc[refname])) {
        continue;
      }

      if(function_ec5f666d56372630(refname)) {
        continue;
      }

      spawns = array_randomize(spawns);

      for(i = 0; i < level.var_a5791492570c75fc[refname]; i++) {
        spawnpoint = spawns[i];

        if(!isDefined(spawnpoint)) {
          break;
        }

        newvehicle = tryspawnavehicle(refname, spawnpoint, "globalMinSpawns", spawnStruct());

        if(!isDefined(newvehicle)) {
          continue;
        }

        level.br_totalvehiclesspawned++;
        usedspawns[usedspawns.size] = spawnpoint;

        if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
          line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (0, 1, 1), 1, 1, 20000);

          if(isDefined(level.var_991ab87ce5e247eb[refname])) {
            level.var_991ab87ce5e247eb[refname]++;
          } else {
            level.var_991ab87ce5e247eb[refname] = 1;
          }

          println("<dev string:x89>" + refname + "<dev string:x194>" + newvehicle.origin);
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }

    unusedspawns = array_remove_array(unusedspawns, usedspawns);

    foreach(spawn in unusedspawns) {
      poi = scripts\mp\poi::poi_findpoioriginisin(spawn.origin);
      subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(spawn.origin, poi);

      if(isDefined(subarea)) {
        if(!isDefined(subarea.vehiclespawnpoints)) {
          subarea.vehiclespawnpoints = [];
        }

        subarea.vehiclespawnpoints[subarea.vehiclespawnpoints.size] = spawn;
      }
    }

    foreach(poi in level.poi) {
      foreach(subarea in poi["subAreas"]) {
        if(!isDefined(subarea.minvehicles) || subarea.minvehicles <= 0 || !isDefined(subarea.vehiclespawnpoints) || subarea.vehiclespawnpoints.size == 0) {
          subarea.vehiclespawnpoints = undefined;
          continue;
        }

        spawns = array_randomize(subarea.vehiclespawnpoints);

        for(i = 0; subarea.spawnedvehicles < subarea.minvehicles && i < spawns.size; i++) {
          spawnpoint = spawns[i];
          faildata = spawnStruct();
          refname = level.br_vehtargetnametoref[spawnpoint.targetname];

          if(function_ec5f666d56372630(refname)) {
            i++;
            continue;
          }

          newvehicle = tryspawnavehicle(refname, spawnpoint, "subAreaSpawns", faildata);

          if(isDefined(newvehicle)) {
            level.br_totalvehiclesspawned++;
            usedspawns[usedspawns.size] = spawnpoint;
            subarea.spawnedvehicles++;

            if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
              line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (0, 1, 1), 1, 1, 20000);

              if(isDefined(level.var_991ab87ce5e247eb[refname])) {
                level.var_991ab87ce5e247eb[refname]++;
              } else {
                level.var_991ab87ce5e247eb[refname] = 1;
              }

              println("<dev string:x89>" + refname + "<dev string:x194>" + newvehicle.origin);
            }

            if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
              break;
            }

            waitframe();
          }
        }

        subarea.vehiclespawnpoints = undefined;

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }
      }

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }
    }
  }

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    println("<dev string:x36a>");
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    randomspawns = 0;
    unusedspawns = array_remove_array(unusedspawns, usedspawns);
    unusedspawns = array_randomize(unusedspawns);

    foreach(spawnpoint in unusedspawns) {
      refname = level.br_vehtargetnametoref[spawnpoint.targetname];

      if(!isDefined(refname)) {
        continue;
      }

      if(function_ec5f666d56372630(refname)) {
        continue;
      }

      while(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
        wait 1;
      }

      faildata = spawnStruct();
      newvehicle = tryspawnavehicle(refname, spawnpoint, "randomSpawns", faildata);
      level.br_totalvehiclesspawned++;

      if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
        line(newvehicle.origin, newvehicle.origin + (0, 0, 4096), (1, 0, 0), 1, 1, 20000);

        if(isDefined(level.var_991ab87ce5e247eb[refname])) {
          level.var_991ab87ce5e247eb[refname]++;
        } else {
          level.var_991ab87ce5e247eb[refname] = 1;
        }

        println("<dev string:x89>" + refname + "<dev string:x385>" + newvehicle.origin);
      }

      randomspawns++;

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
    }

    if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
      println("<dev string:x354>" + randomspawns + "<dev string:x39d>");
    }
  }

  var_f2eab7e1ddeedf9a = 0;

  if(getdvarint(@ "hash_be81410131fa95bf", 0)) {
    foreach(vol in level.brvehspawnvols) {
      println("<dev string:x3b1>" + vol.targetname);
      numspawnpoints = vol.vehiclespawns.size;
      minreq = vol.minvehicles;

      if(minreq > 0 && minreq > vol.vehiclesspawned) {
        unfilled = minreq - vol.vehiclesspawned;
        println("<dev string:x3db>" + unfilled + "<dev string:x3e7>");
        var_f2eab7e1ddeedf9a += unfilled;
      }
    }

    println("<dev string:x406>" + var_82e084d0cb9a7f40);
    println("<dev string:x42f>");

    foreach(refname, data in var_7164111ed75798cc.databyref) {
      spawncount = 0;

      if(isDefined(level.var_991ab87ce5e247eb[refname])) {
        spawncount = level.var_991ab87ce5e247eb[refname];
      }

      println("<dev string:x89>" + refname + "<dev string:x200>" + spawncount);
    }
  }

  var_e158d1582d080cc6 = var_96eb15d5230a7b6e + var_82e084d0cb9a7f40;

  println("<dev string:x468>" + level.br_totalvehiclesspawned);
  println("<dev string:x49a>" + var_e158d1582d080cc6);

  if(var_f2eab7e1ddeedf9a > 0) {
    println("<dev string:x4d1>" + var_f2eab7e1ddeedf9a);
  }
}

function function_cb75d1e034823cb5(vehicleref, loc) {
  if(!isDefined(level.var_7cd5202feecd6d42)) {
    level.var_7cd5202feecd6d42 = [];
  }

  if(!isDefined(level.var_7cd5202feecd6d42[vehicleref])) {
    level.var_7cd5202feecd6d42[vehicleref] = [];
  }

  size = level.var_7cd5202feecd6d42[vehicleref].size;
  level.var_7cd5202feecd6d42[vehicleref][size] = loc;
  return loc;
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

function function_5e2ac14f881014b(loc, vehicleref) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicleref, spawndata);
}

function function_fb0db2fc84df7793(refname) {
  if(!getdvarint(@ "scr_ssc_enabled", 0)) {
    return;
  }

  if(!isDefined(level.var_7cd5202feecd6d42)) {
    return;
  }

  loclist = level.var_7cd5202feecd6d42[refname];

  if(!isDefined(loclist)) {
    return;
  }

  level endon("game_ended");

  foreach(loc in loclist) {
    if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
      println("<dev string:x507>" + refname);
      logprint("Error: SSC is trying to spawn a vehicle but the max limit has been reached - " + refname);
      return;
    }

    function_5e2ac14f881014b(loc, refname);
    level.br_totalvehiclesspawned++;
    waitframe();
  }
}

function function_cd9f2fe51c02d74e() {
  if(!getdvarint(@ "scr_ssc_enabled", 0)) {
    return;
  }

  if(!isDefined(level.var_7cd5202feecd6d42)) {
    return;
  }

  foreach(refname, loclist in level.var_7cd5202feecd6d42) {
    function_fb0db2fc84df7793(refname);
  }
}

function function_9856ad860555f8b9() {
  table = level.var_9fab40ed3326f8b;

  if(!isDefined(table)) {
    return;
  }

  numrows = tablelookupgetnumrows(table);

  for(i = 0; i < numrows; i++) {
    poiname = tablelookupbyrow(table, i, 0);
    var_71ad22c5d093d90b = tolower(tablelookupbyrow(table, i, 1));
    minvehicles = int(tablelookupbyrow(table, i, 6));

    if(isDefined(level.poi[poiname]) && isDefined(level.poi[poiname]["subAreas"]) && isDefined(level.poi[poiname]["subAreas"][var_71ad22c5d093d90b])) {
      var_fb65b3577da146b0 = spawnStruct();
      var_fb65b3577da146b0.minvehicles = minvehicles;
      var_fb65b3577da146b0.spawnedvehicles = 0;
      level.poi[poiname]["subAreas"][var_71ad22c5d093d90b].minvehicles = minvehicles;
      level.poi[poiname]["subAreas"][var_71ad22c5d093d90b].spawnedvehicles = 0;
      continue;
    }

    if(poiname == "minVehicleSpawns") {
      vehicleref = tablelookupbyrow(table, i, 1);
      vehiclespawns = int(tablelookupbyrow(table, i, 2));

      if(!isDefined(level.var_a5791492570c75fc)) {
        level.var_a5791492570c75fc = [];
      }

      level.var_a5791492570c75fc[vehicleref] = vehiclespawns;
    }
  }
}

function brvehiclespawnvolreset() {
  level.br_totalvehiclesspawned = 0;
  var_7164111ed75798cc = vehicle_spawn_getleveldata();

  foreach(vol in level.brvehspawnvols) {
    vol.vehiclesspawned = 0;
  }
}

function waitforvehiclestodeletethenspawninitial() {
  level endon("game_ended");
  level notify("br_vehiclesWaitForDelete");
  level endon("br_vehiclesWaitForDelete");
  waitframe();
  waittillframeend();
  function_cd9f2fe51c02d74e();

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("spawnInitialVehicles")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("spawnInitialVehicles");
  } else {
    spawninitialvehicles();
  }

  function_ee64ebb471957dc7();
}

function brvehiclesreset() {
  emptyallvehicles();
  deleteextantvehicles();
  brvehiclespawnvolreset();
  level thread waitforvehiclestodeletethenspawninitial();
}

function brvehicleonprematchstarted() {
  if(getdvarint(@ "hash_6cce831ff331c183", 0)) {
    return;
  }

  wait 1.5;

  if(!istrue(level.shouldinitvehicles)) {
    return;
  }

  vehicle_interact_allowvehicleuseglobal(0);
  brvehiclesreset();
  namespace_acc3d8ec1f00ce29::spawnpalfa();
  scripts\mp\gametypes\br_gametype_dmz::function_b52f35a3ff450ecd();
  vehicle_interact_allowvehicleuseglobal(1);
}

function function_c3fe673ce43bb311(vehicleref, defaultpct) {
  if(!isDefined(level.var_aed9c28063f339cd)) {
    level.var_aed9c28063f339cd = [];
  }

  value = getdvarfloat(hashcat(@ "hash_20c93b9a1bf4d35d", vehicleref, "_pct"), defaultpct);
  level.var_aed9c28063f339cd[vehicleref] = value * 0.01;
}

function function_4e336cd994097306(vehicle, defaultdamage) {
  damageamount = defaultdamage;
  damagepct = level.var_aed9c28063f339cd[vehicle.vehiclename];

  if(isDefined(damagepct) && damagepct > 0) {
    damageamount = vehicle.maxhealth * damagepct;
  }

  return damageamount;
}

function function_a3c6f2c2714ee754() {
  vehicles = [];
  var_cc3563f7aefb3492 = level.vehicle.instances["little_bird"];
  var_400701c211c2a6c2 = level.vehicle.instances["veh9_palfa"];
  vehicles = array_combine(var_cc3563f7aefb3492, var_400701c211c2a6c2);
  return vehicles;
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("vehiclesGasDamage")) {
    return;
  }

  blades_radius = 160;
  rotor_radius = 36;
  damage_amount = 100;
  defaultdamage = getdvarfloat(@ "hash_b89033584b879669", damage_amount);
  helis = function_a3c6f2c2714ee754();

  if(isDefined(helis)) {
    foreach(heli in helis) {
      if(istrue(heli.var_651325c15c273cba)) {
        continue;
      }

      var_13d5b2ac0e7c768b = 0;
      vehicleorigin = heli.origin;
      var_24135b85b8e536b8 = distance2d(dangercircleorigin, vehicleorigin);

      if(var_24135b85b8e536b8 + blades_radius > dangercircleradius) {
        var_13d5b2ac0e7c768b = 1;
      } else {
        rotororigin = heli gettagorigin("tail_rotor_jnt");
        var_24135b85b8e536b8 = distance2d(dangercircleorigin, rotororigin);

        if(var_24135b85b8e536b8 + rotor_radius > dangercircleradius) {
          var_13d5b2ac0e7c768b = 1;
        }
      }

      if(var_13d5b2ac0e7c768b) {
        damageamount = function_4e336cd994097306(heli, defaultdamage);
        heli dodamage(damageamount, vehicleorigin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }
}

function function_1a1709943670772a() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances) || !istrue(level.var_2df69b8e552238b6)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("vehiclesGasDamage")) {
    return;
  }

  blades_radius = 160;
  damage_amount = 100;
  defaultdamage = getdvarfloat(@ "hash_b89033584b879669", damage_amount);
  helis = function_a3c6f2c2714ee754();

  if(isDefined(helis)) {
    foreach(heli in helis) {
      if(istrue(heli.var_651325c15c273cba)) {
        continue;
      }

      if(!scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(heli.origin, blades_radius) && !scripts\mp\gametypes\br_circle_util::function_d30c8f0e5abea93b(heli.origin, 0)) {
        damageamount = function_4e336cd994097306(heli, defaultdamage);
        heli dodamage(damageamount, heli.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }
}

function function_b5a8e76fbf49784a(vehicleref) {
  bit = level.vehicleenum[vehicleref];

  if(isDefined(bit)) {
    setomnvarbit("ui_br_vehicles_spawned", bit, 1);
  }
}

function function_ebf775f8fdd1d098() {
  level.vehicleenum = [];
  var_2cc549a811db0b3b = getscriptbundle("vehicleenum:" + "iw9_vehicle_enum");

  if(!isDefined(var_2cc549a811db0b3b)) {
    return [];
  }

  foreach(id, var_87a2ffa83754b065 in var_2cc549a811db0b3b.vehicle_list) {
    if(!isnumber(id)) {
      continue;
    }

    if(!isDefined(var_87a2ffa83754b065)) {
      continue;
    }

    vehicleref = var_87a2ffa83754b065.vehicle;

    if(!isDefined(vehicleref)) {
      continue;
    }

    level.vehicleenum[vehicleref] = id;
  }
}

function function_ee64ebb471957dc7() {
  if(level.vehicleenum.size > 0) {
    foreach(vehicleref, var_e5cd5ce5ee8dc6c9 in level.vehicle.instances) {
      function_b5a8e76fbf49784a(vehicleref);
    }
  }
}

function function_1c7a4c53fa428606() {
  level endon("<dev string:x558>");

  while(level.players.size < 1) {
    wait 1;
  }

  var_a25d74cbd44ff62 = [];
  player = level.players[0];
  player notifyonplayercommand("<dev string:x566>", "<dev string:x573>");
  player notifyonplayercommand("<dev string:x57c>", "<dev string:x58e>");
  player notifyonplayercommand("<dev string:x598>", "<dev string:x5a6>");
  player notifyonplayercommand("<dev string:x5b3>", "<dev string:x5c7>");
  player notifyonplayercommand("<dev string:x5d3>", "<dev string:x5e3>");
  player notifyonplayercommand("<dev string:x5f5>", "<dev string:x603>");
  player waittill_any_return_6("<dev string:x566>", "<dev string:x57c>", "<dev string:x598>", "<dev string:x5b3>", "<dev string:x5f5>", "<dev string:x5d3>");
  setupvehiclespawnvolumes();
  wait 0.5;
  iprintlnbold("<dev string:x612>");

  while(true) {
    note = player waittill_any_return_6("<dev string:x566>", "<dev string:x57c>", "<dev string:x598>", "<dev string:x5b3>", "<dev string:x5f5>", "<dev string:x5d3>");

    if(note == "<dev string:x5d3>") {
      if(var_a25d74cbd44ff62.size > 0) {
        start = player getvieworigin();
        angles = player getplayerangles();
        fwd = anglesToForward(angles);
        end = start + fwd * 8000;
        endpos = physicstrace(start, end);
        bestdistsq = 65536;
        var_aa61357de4bb54ed = undefined;

        for(index = 0; index < var_a25d74cbd44ff62.size; index++) {
          distsq = distancesquared(var_a25d74cbd44ff62[index].origin, endpos);

          if(distsq < bestdistsq) {
            var_aa61357de4bb54ed = index;
          }
        }

        if(isDefined(var_aa61357de4bb54ed)) {
          var_a25d74cbd44ff62[var_aa61357de4bb54ed] delete();
          var_a25d74cbd44ff62 = array_remove_index(var_a25d74cbd44ff62, var_aa61357de4bb54ed);
          iprintlnbold("<dev string:x636>" + var_a25d74cbd44ff62.size + "<dev string:x655>");
        } else {
          iprintlnbold("<dev string:x663>" + endpos);
        }
      }

      continue;
    }

    if(note == "<dev string:x5f5>") {
      println("<dev string:x689>");
      offset = (0, 0, 0);
      filepath = "<dev string:x6a3>" + level.script + "<dev string:x6ba>";
      var_5e43fe5ed10e5799 = openfile(filepath, "<dev string:x6cc>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x6d5>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x6e1>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x6eb>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x6f0>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x70e>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x72d>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x73c>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x741>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x6eb>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x74d>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x76b>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x7a0>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x7de>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x7eb>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x7f2>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x80d>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x873>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x8dc>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x945>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x9a9>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:xa0d>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:xa76>");
      fprintln(var_5e43fe5ed10e5799, "<dev string:x73c>");
      entnum = 1;

      foreach(entry in var_a25d74cbd44ff62) {
        fprintln(var_5e43fe5ed10e5799, "<dev string:xa7d>" + entnum);
        fprintln(var_5e43fe5ed10e5799, "<dev string:x6eb>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xa88>" + "<dev string:xa97>" + entry.angles[0] + "<dev string:xa9c>" + entry.angles[1] + "<dev string:xa9c>" + entry.angles[2] + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xaa1>" + "<dev string:xa97>" + entry.origin[0] + offset[0] + "<dev string:xa9c>" + entry.origin[1] + offset[1] + "<dev string:xa9c>" + entry.origin[2] + offset[2] + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xab0>" + "<dev string:xa97>" + entry.script_classname + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xac2>" + "<dev string:xa97>" + entry.script_model + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xad0>" + "<dev string:xa97>" + entry.targetname + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xae3>" + "<dev string:xa97>" + entry.vehicletype + "<dev string:xa97>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xaf7>" + "<dev string:xb06>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:xb11>" + "<dev string:xb20>");
        fprintln(var_5e43fe5ed10e5799, "<dev string:x73c>");
        entnum++;
      }

      closefile(var_5e43fe5ed10e5799);
      iprintlnbold("<dev string:xb2a>" + var_a25d74cbd44ff62.size + "<dev string:xb46>" + filepath);
      continue;
    }

    start = player getvieworigin();
    angles = player getplayerangles();
    fwd = anglesToForward(angles);
    end = start + fwd * 8000;
    endpos = physicstrace(start, end);

    if(endpos != end) {
      endpos += (0, 0, 16);
      entry = spawn("<dev string:xb5d>", endpos);
      entry.origin = endpos;
      entry.angles = (0, angles[1], 0);
      entry.targetname = note;

      switch (note) {
        case #"hash_5b97d59c5aa200ba":
          entry.script_classname = "<dev string:xb6d>";
          entry.vehicletype = "<dev string:xb89>";
          entry.script_model = "<dev string:xba8>";
          break;
        case #"hash_9fae9f2b4d8960b5":
          entry.script_classname = "<dev string:xbc7>";
          entry.vehicletype = "<dev string:xbe4>";
          entry.script_model = "<dev string:xbf9>";
          break;
        case #"hash_8d97f13aa572972d":
          entry.script_classname = "<dev string:xc1b>";
          entry.vehicletype = "<dev string:xc34>";
          entry.script_model = "<dev string:xc48>";
          break;
        case #"hash_5976269dab51a932":
          entry.script_classname = "<dev string:xc6e>";
          entry.vehicletype = "<dev string:xc8d>";
          entry.script_model = "<dev string:xca1>";
          break;
      }

      entry setModel(entry.script_model);
      var_a25d74cbd44ff62[var_a25d74cbd44ff62.size] = entry;
      iprintlnbold(note + "<dev string:xcc4>" + var_a25d74cbd44ff62.size + "<dev string:x2ab>");
      function_d96e7d92cdd79f9e(entry);
    }
  }
}

function function_d96e7d92cdd79f9e(spawnpoint) {
  linecolor = (1, 0, 0);

  if(isstruct(spawnpoint)) {
    script_model = undefined;

    switch (spawnpoint.targetname) {
      case #"hash_5b97d59c5aa200ba":
        script_model = "<dev string:xcd9>";
        linecolor = (1, 1, 1);
        break;
      case #"hash_9fae9f2b4d8960b5":
        script_model = "<dev string:xcf7>";
        linecolor = (0, 1, 0);
        break;
      case #"hash_8d97f13aa572972d":
        script_model = "<dev string:xd15>";
        linecolor = (1, 1, 0);
        break;
      case #"hash_5976269dab51a932":
        script_model = "<dev string:xd32>";
        linecolor = (1, 0, 0);
        break;
    }

    if(isDefined(script_model)) {
      placeholder = spawn("<dev string:xb5d>", spawnpoint.origin);
      placeholder.origin = spawnpoint.origin;
      placeholder.angles = spawnpoint.angles;
      placeholder setModel(script_model);
      wait 0.1;
    }
  } else {
    switch (spawnpoint.targetname) {
      case #"hash_5b97d59c5aa200ba":
        linecolor = (1, 1, 1);
        break;
      case #"hash_9fae9f2b4d8960b5":
        linecolor = (0, 1, 0);
        break;
      case #"hash_8d97f13aa572972d":
        linecolor = (1, 1, 0);
        break;
      case #"hash_5976269dab51a932":
        linecolor = (1, 0, 0);
        break;
    }
  }

  line(spawnpoint.origin, spawnpoint.origin + (0, 0, 4096), linecolor, 1, 1, 200000);
}

function mychangeswatcher() {
  while(true) {
    level waittill("<dev string:xd51>");
    vehicle_interact_allowvehicleuseglobal(0);
    vehicle_interact_allowvehicleuseglobal(1);
  }
}

# /