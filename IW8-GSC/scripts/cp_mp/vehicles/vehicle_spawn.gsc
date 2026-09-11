/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_spawn.gsc
****************************************************/

function vehicle_spawn_getleveldataforvehicle(var0, var1) {
  var2 = vehicle_spawn_getleveldata();
  var3 = var2.databyref[var0];

  if(!isDefined(var3) && istrue(var1)) {
    var3 = spawnStruct();
    var2.databyref[var0] = var3;
    var3.ref = var0;
    var3.maxinstancecount = 0;
    var3.priority = 50;
    var3.getspawnstructscallback = undefined;
    var3.spawncallback = undefined;
    var3.canspawncallback = undefined;
    var3.clearancecheckradius = undefined;
    var3.clearancecheckheight = undefined;
    var3.clearancecheckoffsetz = undefined;
    var3.clearancecheckminradius = undefined;
    var3.ref_13b83 = undefined;
    var3.ref_12ca1 = undefined;
    var3.ref_13b84 = undefined;
  }

  return var3;
}

function vehicle_spawn_canspawnVehicle(var0, var1, var2, var3) {
  var4 = vehicle_spawn_getleveldata();

  if(vehicle_spawn_getinstancecount() < var4.maxinstancecount) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "canSpawnVehicle")]](var0)) {
      if(isDefined(var0)) {
        if(!scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_instancesarelimited(var0) || !scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_atinstancelimit(var0, var1, var2)) {
          var5 = vehicle_spawn_getleveldataforvehicle(var0);

          if(isDefined(var5)) {
            if(istrue(level.ignorevehicletypeinstancelimit) || !isDefined(var5.maxinstancecount) || vehicle_spawn_getinstancecountforref(var0) < var5.maxinstancecount) {
              if(isDefined(var5.canspawncallback)) {
                return [[var5.canspawncallback]](var1, var2, var3, var0);
              } else {
                return 1;
              }
            }
          }
        }
      }
    }
  }

  return 0;
}

function vehicle_spawn_spawnVehicle(var0, var1, var2) {
  var3 = vehicle_spawn_getleveldataforvehicle(var0);

  if(vehicle_spawn_iscodevehicletest()) {
    var4 = scripts\cp_mp\utility\game_utility::getmapname();
    var5 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var0);

    if(var5.size > 0) {
      return;
    }

    if(var0 == "tac_rover") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (44455, -12715, 108);
        var1.angles = (360, 315, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (45735, -12397, 121);
        var1.angles = (0, 358, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (29480, 33349, 589);
        var1.angles = (0, 202, 0);
      }
    } else if(var0 == "large_transport") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (20845, -12233, -57);
        var1.angles = (7, 81, 0);
      } else if(var4 == "mp_farms2_gw") {
        return;
      } else if(var4 == "mp_quarry2") {
        return;
      }
    } else if(var0 == "apc_russian") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (20845, -12233, -57);
        var1.angles = (7, 81, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (44559, -12331, 87);
        var1.angles = (0, 11, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (29135, 33754, 605);
        var1.angles = (0, 7, 0);
      }
    } else if(var0 == "atv") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (22421, -13456, -48);
        var1.angles = (13, 36, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (45202, -11294, 149);
        var1.angles = (0, 283, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (29250, 35115, 616);
        var1.angles = (0, 321, 0);
      }
    } else if(var0 == "technical") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (22742, -12693, -56);
        var1.angles = (360, 315, 0);
      } else if(var4 == "mp_farms2_gw") {
        return;
      } else if(var4 == "mp_quarry2") {
        return;
      }
    } else if(var0 == "light_tank") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (22787, -13503, -56);
        var1.angles = (3, 269, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (45259, -12740, 63);
        var1.angles = (0, 274, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (32524, 34558, 599);
        var1.angles = (0, 107, 0);
      }
    } else if(var0 == "little_bird" || var0 == "little_bird_mg") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (21108, -12603, 100);
        var1.angles = (6, 353, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (46478, -12482, 400);
        var1.angles = (0, 84, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (28735, 34000, 767);
        var1.angles = (0, 80, 0);
      }
    } else if(var0 == "cargo_truck" || var0 == "cargo_truck_mg") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (23503, -12799, -56);
        var1.angles = (6, 359, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (45644, -11370, 160);
        var1.angles = (0, 80, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (29280, 35546, 626);
        var1.angles = (0, 148, 0);
      }
    } else if(var0 == "jeep") {
      if(var4 == "mp_downtown_gw") {
        var1.origin = (22781, -14070, -56);
        var1.angles = (5, 86, 0);
      } else if(var4 == "mp_farms2_gw") {
        var1.origin = (46119, -11995, 168);
        var1.angles = (0, 4, 0);
      } else if(var4 == "mp_quarry2") {
        var1.origin = (30351, 34420, 593);
        var1.angles = (0, 31, 0);
      }
    } else {
      return;
    }
  }

  var6 = [[var3.spawncallback]](var1, var2);

  if(isDefined(var6)) {
    vehicle_spawn_registerinstance(var6);
  }

  return var6;
}

function vehicle_spawn_deregisterinstance(var0, var1) {
  var2 = vehicle_spawn_getleveldata();

  if(isDefined(var2.instancesbyref[var0])) {
    var2.instancesbyref[var0][var1] = undefined;
    return;
  }
}

function vehicle_spawn_removespawnstructswithflag(var0, var1) {
  if(getdvarint("scr_forceVehicleSpawn", 0) == 1) {
    return var0;
  }

  var2 = 1 >> var1 - 1;
  var3 = [];

  foreach(var5 in var0) {
    if(isDefined(var5.spawnflags) && var5.spawnflags &var2) {
      continue;
    }

    var3 = var5;
  }

  return var3;
}

function vehicle_spawn_gamemodesupportsrespawn() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "gameModeSupportsRespawn")]]();
}

function vehicle_spawn_init() {
  var0 = spawnStruct();
  level.vehicle.spawn = var0;
  var0.maxinstancecount = 128;
  var0.databyref = [];
  var0.instancesbyref = [];
  var0.spawnfromstructsdelayornotify = 5;
  var0.ref_12ca2 = getdvarint("scr_respawnVehicleDelayOverride", 0);
  var0.argshave = getdvarint("scr_abandonedVehicleTimeoutOverride", 0);
  var0.ref_12ca1 = getdvarint("scr_respawnVehicleDelay", 60);
  var0.areplayersnear = getdvarint("scr_abandonedVehicleTimeout", 30);
  vehicle_spawn_initspawnclearance();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "init")]]();
  vehicle_spawn_initlate();
}

function vehicle_spawn_initlate() {
  thread vehicle_spawn_spawnfromstructs();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_spawn", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "initLate")]]();
    return;
  }
}

function vehicle_spawn_spawnfromstructs() {
  if(istrue(level.modecontrolledvehiclespawningonly)) {
    return;
  }

  var0 = vehicle_spawn_getleveldata();

  if(isstring(var0.spawnfromstructsdelayornotify)) {
    level waittill(var0.spawnfromstructsdelayornotify);
  } else {
    wait var0.spawnfromstructsdelayornotify;
  }

  var1 = [];

  foreach(var3 in var0.databyref) {
    if(isDefined(var3.getspawnstructscallback)) {
      var3.priority = clamp(var3.priority, 0, 100);
      var1 = var3;
    }
  }

  if(var1.size > 0) {
    if(var1.size > 1) {
      var1 = scripts\engine\utility::array_sort_with_func(var1, &vehicle_spawn_spawnfromstructscomparefunc);
    }

    var5 = isDefined(scripts\cp_mp\utility\game_utility::getlocaleid());

    if(vehicle_spawn_iscodevehicletest()) {
      var5 = 0;
    }

    foreach(var3 in var1) {
      var7 = [[var3.getspawnstructscallback]]();

      foreach(var9 in var7) {
        if(var5) {
          if(!isDefined(var9.script_noteworthy) || isDefined(var9.script_noteworthy) && var9.script_noteworthy != level.localeid) {
            continue;
          }
        }

        if(vehicle_spawn_canspawnVehicle(var3.ref)) {
          var10 = spawnStruct();
          var10.origin = var9.origin;
          var10.angles = var9.angles;
          var10.spawntype = "LEVEL";
          var11 = spawnStruct();
          var12 = vehicle_spawn_spawnVehicle(var3.ref, var10, var11);

          if(isDefined(var12)) {}

          continue;
        }

        break;
      }
    }

    return;
  }
}

function vehicle_spawn_spawnfromstructscomparefunc(var0, var1) {
  return var0.priority >= var1.priority;
}

function vehicle_spawn_registerinstance(var0) {
  var1 = vehicle_spawn_getleveldata();

  if(!isDefined(var1.instancesbyref[var0.vehiclename])) {
    var1.instancesbyref[var0.vehiclename] = [];
  }

  var1.instancesbyref[var0.vehiclename][var0 getentitynumber()] = var0;
}

function vehicle_spawn_getleveldata() {
  return level.vehicle.spawn;
}

function vehicle_spawn_getinstancecount() {
  var0 = vehicle_spawn_getleveldata();
  var1 = 0;

  foreach(var3 in var0.instancesbyref) {
    var1 += var3.size;
  }

  return var1;
}

function vehicle_spawn_getinstancecountforref(var0) {
  var1 = vehicle_spawn_getleveldata();
  var2 = 0;

  if(isDefined(var1.instancesbyref[var0])) {
    var2 = var1.instancesbyref[var0].size;
  }

  return var2;
}

function vehicle_spawn_isvehiclespawnStruct() {
  var0 = self.targetname;

  if(isDefined(var0)) {
    switch (var0) {
      case "van_spawn":
      case "technical_spawn":
      case "tacrover_spawn":
      case "pickuptruck_spawn":
      case "mediumtransport_spawn":
      case "littlebird_spawn":
      case "lighttank_spawn":
      case "largetransport_spawn":
      case "jeep_spawn":
      case "hooptytruck_spawn":
      case "hoopty_spawn":
      case "copcar_spawn":
      case "cargotruck_spawn":
      case "atv_spawn":
      case "apcrussian_spawn":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function vehicle_spawn_initspawnclearance() {
  var0 = vehicle_spawn_getleveldata();
  var0.clearancecheckminradii = [];
}

function vehicle_spawn_checkspawnclearance(var0, var1, var2, var3, var4) {
  var5 = vehicle_spawn_getleveldata();
  var6 = 200;
  var7 = 200;
  var8 = vehicle_spawn_getleveldataforvehicle(var1);
  var9 = var8.clearancecheckminradius;

  if(!isDefined(var9)) {
    var9 = var5.clearancecheckminradii[var1];
  }

  if(isDefined(var8.clearancecheckradius)) {
    var6 = var8.clearancecheckradius;
  }

  if(isDefined(var8.clearancecheckheight)) {
    var7 = var8.clearancecheckheight;
  }

  if(isDefined(var4)) {
    var0 += (0, 0, var4);
  }

  var10 = (var6, var6, var7);
  var11 = var0 - var10;
  var12 = var0 + var10;
  var13 = var2;

  if(!isDefined(var13)) {
    var13 = physics_createcontents(["physicscontents_vehicle"]);
  }

  var14 = var3;

  if(!isDefined(var14)) {
    var14 = [];
    GscBinSkip0(0x2e, var14.size, scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("emp_drone"));
  }

  var15 = physics_aabbbroadphasequery(var11, var12, var13, var14);

  if(isDefined(var15) && var15.size > 0) {
    foreach(var17 in var15) {
      if(isDefined(var17.vehiclename)) {
        var18 = vehicle_spawn_getleveldataforvehicle(var17.vehiclename);
        var19 = undefined;

        if(isDefined(var18)) {
          var19 = var18.clearancecheckminradius;
        }

        if(!isDefined(var19)) {
          var19 = var5.clearancecheckminradii[var17.vehiclename];
        }

        if(!isDefined(var19)) {
          continue;
        }

        var20 = pow(var9 + var19, 2);

        if(isDefined(var20) && var20 < distance2dsquared(var17.origin, var0)) {
          continue;
        }

        return false;
      }
    }
  }

  return true;
}

function vehicle_spawn_setclearancecheckminradius(var0, var1) {
  var2 = vehicle_spawn_getleveldata();
  var3 = vehicle_spawn_getleveldataforvehicle(var0);

  if(isDefined(var3)) {
    var3.clearancecheckminradius = var1;
    return;
  }

  var2.clearancecheckminradii[var0] = var1;
}

function ref_1421c(var0, var1, var2) {
  level endon("game_ended");
  level endon("cancel_pending_vehicle_respawns");
  var3 = vehicle_spawn_getleveldataforvehicle(var0);

  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(var3.spawncallback)) {
    return;
  }

  var4 = vehicle_spawn_getleveldata();
  var5 = undefined;

  if(var4.ref_12ca2 != 0) {
    var5 = var4.ref_12ca2;
  } else if(isDefined(var3.ref_12ca1)) {
    var5 = var3.ref_12ca1;
  } else {
    var5 = var4.ref_12ca1;
  }

  if(var5 >= 1) {
    if(var5 >= 9999) {
      return undefined;
    }

    goto LOC_00000088;
  }

  var5 = 1;

  for(;;) {
    wait var5;

    if(vehicle_spawn_canspawnVehicle(var0)) {
      if(vehicle_spawn_checkspawnclearance(var1.origin, var0)) {
        var6 = vehicle_spawn_spawnVehicle(var0, var1, var2);

        if(!isDefined(var6)) {
          continue;
        }

        return var6;
      }
    }
  }
}

function ref_14219(var0) {
  var0.ondeathrespawn = undefined;
}

function ref_14212() {
  level notify("cancel_pending_vehicle_respawns");
}

function ref_14214() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout")]]();
}

function ref_1421d() {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(istrue(self.matchdata_level)) {
    return;
  }

  var0 = vehicle_spawn_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.arenavday)) {
    return;
  }

  self endon("death");
  self endon("stop_watching_abandoned");
  var1 = vehicle_spawn_getleveldata();
  var2 = undefined;

  if(var1.argshave != 0) {
    var2 = var1.argshave;
  } else if(isDefined(var0.areplayersnear)) {
    var2 = var0.areplayersnear;
  } else {
    var2 = var1.areplayersnear;
  }

  if(var2 >= 1) {
    if(var2 >= 9999) {
      return;
    }
  } else {
    var2 = 1;
  }

  wait var2;
  thread ref_14210();
}

function ref_1421a() {
  self notify("stop_watching_abandoned");
}

function ref_14210() {
  ref_1421a();
  self.matchdata_level = 1;
  var0 = vehicle_spawn_getleveldataforvehicle(self.vehiclename);
  self thread[[var0.arenavday]]();
}

function ref_14211() {
  var0 = scripts\cp_mp\vehicles\vehicle_damage::ref_14152();

  if(var0 != "heavy") {
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414b(self);

    if(isDefined(var1)) {
      self.health = int(min(var1, self.health));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
    }

    scripts\cp_mp\vehicles\vehicle_damage::ref_14177("heavy", var0);
    return;
  }
}

function vehicle_spawn_iscodevehicletest() {
  var0 = level.codevehicletest;

  if(!isDefined(var0)) {
    var0 = getdvarint("scr_codeVehicleTest", 0) == 1;

    if(var0 && vehicle_spawn_iscodevehicletestlevel()) {
      var0 = 1;
    } else {
      var0 = 0;
    }

    level.codevehicletest = var0;
  }

  return var0;
}

function vehicle_spawn_iscodevehicletestlevel() {
  var0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var0) {
    case "mp_farms2_gw":
    case "mp_downtown_gw":
    case "mp_quarry2":
      return 1;
    default:
      return 0;
  }
}

function ref_14215() {}