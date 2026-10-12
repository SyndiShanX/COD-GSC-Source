/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_tracking.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace vehicle_tracking;

function _spawnVehicle(spawndata, faildata) {
  function_3a040ff591c32b5c(spawndata);

  if(!istrue(spawndata.startsuspended)) {
    if(!canspawnVehicle()) {
      if(isDefined(faildata)) {
        faildata.fail = "total_limit_exceeded";
      }

      if(istrue(level.debugvehiclespawns)) {
        println("<dev string:x1c>" + spawndata.modelname + "<dev string:x49>" + level.vehiclecount + "<dev string:x63>" + level.maxvehiclecount);
      }

      if(level.var_6fc6b49b8704877f) {
        logprint("[VEHICLE_TRACKING] Failed to spawn the vehicle [" + spawndata.targetname + "] because the spawn limit [" + level.maxvehiclecount + "] has been reached.");
      }

      return undefined;
    }
  }

  vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback);

  if(!isDefined(vehicle)) {
    if(isDefined(faildata)) {
      faildata.fail = "code";
    }

    if(istrue(level.debugvehiclespawns)) {
      println("<dev string:x80>" + spawndata.modelname);
    }

    if(level.var_6fc6b49b8704877f) {
      logprint("[VEHICLE_TRACKING] Failed to spawn the vehicle [" + spawndata.targetname + "] because of a code error.");
    }

    return undefined;
  }

  vehicle.spawndata = spawndata;
  level.vehiclecount++;
  return vehicle;
}

function _spawnhelicopter(owner, origin, angles, type, modelname) {
  faildata = spawnStruct();
  spawndata = spawnStruct();
  spawndata.modelname = modelname;
  spawndata.vehicletype = type;
  spawndata.origin = origin;
  spawndata.angles = angles;
  spawndata.owner = owner;

  if(!canspawnVehicle()) {
    if(isDefined(faildata)) {
      faildata.fail = "total_limit_exceeded";
    }

    return undefined;
  }

  vehicle = spawnhelicopter(spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname);

  if(!isDefined(vehicle)) {
    if(isDefined(faildata)) {
      faildata.fail = "code";
    }

    return undefined;
  }

  level.vehiclecount++;
  return vehicle;
}

function _deletevehicle(vehicle) {
  if(!isDefined(vehicle)) {
    return;
  }

  vehicle notify("vehicle_deleted");
  level.vehiclecount--;

  if(isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances[vehicle.vehiclename]) && isDefined(level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()])) {
    vehicle_tracking_deregisterinstance(vehicle);
  }

  function_d21abb198361e610(vehicle);
  vehicle delete();
  return 1;
}

function function_d21abb198361e610(vehicle) {
  if(!isDefined(vehicle.linkedchildren)) {
    return;
  }

  foreach(scriptable in vehicle.linkedchildren) {
    if(!isDefined(scriptable)) {
      continue;
    }

    if(isDefined(scriptable.type) && scripts\engine\utility::issharedfuncdefined(scriptable.type, "delete") && scriptable[[scripts\engine\utility::getsharedfunc(scriptable.type, "delete")]]()) {
      continue;
    }

    scriptable notify("death");
    scriptable script_func("deregisterScriptable");

    if(scriptable getscriptableisreserved()) {
      scriptable freescriptable();
      continue;
    }

    part = scriptable function_ec5f4851431f3382();

    if(scriptable getscriptableparthasstate(part, "hidden")) {
      scriptable setscriptablepartstate(part, "hidden");
    }
  }
}

function canspawnVehicle() {
  return level.vehiclecount < level.maxvehiclecount;
}

function getvehiclecount() {
  return level.vehiclecount;
}

function reservevehicle(count) {
  if(canspawnVehicle()) {
    if(!isDefined(count)) {
      level.vehiclecount++;
      return true;
    }

    availablevehicles = level.maxvehiclecount - level.vehiclecount;

    if(count <= availablevehicles) {
      level.vehiclecount += count;
      return true;
    }
  }

  return false;
}

function clearvehiclereservation(count) {
  if(!isDefined(count)) {
    count = 1;
  }

  level.vehiclecount -= count;

  if(level.vehiclecount < 0) {
    scripts\engine\utility::error("<dev string:xba>");
  }

  level.vehiclecount = int(max(0, level.vehiclecount));
}

function getvehiclespawndata(vehicle) {
  return vehicle.spawndata;
}

function copyvehiclespawndata(from, to) {
  to.modelname = from.modelname;
  to.skinoverride = from.skinoverride;
  to.targetname = from.targetname;
  to.vehicletype = from.vehicletype;
  to.origin = from.origin;
  to.angles = from.angles;
  to.originalorigin = from.originalorigin;
  to.originalangles = from.originalangles;
  to.owner = from.owner;
  to.initialvelocity = from.initialvelocity;
  to.cannotbesuspended = from.cannotbesuspended;
  to.startsuspended = from.startsuspended;
  to.spawntype = from.spawntype;
  to.team = from.team;
  to.ref = from.ref;
}

function vehicle_tracking_registerinstance(vehicle, owner, team, var_699ac4a9c9e9f0ec) {
  assertex(isDefined(level.vehicle), "<dev string:x100>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x145>");
  assertex(isDefined(vehicle.vehiclename), "<dev string:x193>");
  vehicle_tracking_deregisterinstance(vehicle);
  level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()] = vehicle;
  vehicle.vehicleowner = owner;
  vehicle.vehicleteam = team;
  vehicle.var_699ac4a9c9e9f0ec = var_699ac4a9c9e9f0ec;

  if(!istrue(var_699ac4a9c9e9f0ec)) {
    level.vehicle.var_3af6263662b92655[vehicle getentitynumber()] = vehicle;
  }
}

function vehicle_tracking_deregisterinstance(vehicle) {
  assertex(isDefined(vehicle.vehiclename), "<dev string:x1da>");

  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.instances)) {
    return;
  }

  if(!isDefined(level.vehicle.instances[vehicle.vehiclename])) {
    return;
  }

  level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()] = undefined;
  level.vehicle.var_3af6263662b92655[vehicle getentitynumber()] = undefined;

  if(level.vehicle.instances[vehicle.vehiclename].size <= 0) {
    level.vehicle.instances[vehicle.vehiclename] = undefined;
  }

  vehicle.vehicleowner = undefined;
  vehicle.vehicleteam = undefined;
  vehicle.var_699ac4a9c9e9f0ec = undefined;
}

function vehicle_tracking_limitgameinstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "<dev string:x223>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x26a>");
  level.vehicle.instancelimits[vehiclename] = limit;
  level.vehicle.instancelimitmessages[vehiclename] = message;
}

function function_5c8408cb68649308(vehiclename, spawntype, limit) {
  assertex(isDefined(level.vehicle), "<dev string:x223>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x26a>");

  if(!isDefined(level.vehicle.spawntypeinstancelimits[vehiclename])) {
    level.vehicle.spawntypeinstancelimits[vehiclename] = [];
  }

  level.vehicle.spawntypeinstancelimits[vehiclename][spawntype] = limit;
}

function vehicle_tracking_limitownerinstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "<dev string:x2ba>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x302>");
  level.vehicle.ownerinstancelimits[vehiclename] = limit;
  level.vehicle.ownerinstancelimitmessages[vehiclename] = message;
}

function vehicle_tracking_limitteaminstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "<dev string:x353>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x39a>");
  level.vehicle.teaminstancelimits[vehiclename] = limit;
  level.vehicle.teaminstancelimitmessages[vehiclename] = message;
}

function vehicle_tracking_atinstancelimit(vehiclename, owner, team, spawntype, sendmessage) {
  assertex(isDefined(level.vehicle), "<dev string:x3ea>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x42e>");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return false;
  }

  gamelimit = level.vehicle.instancelimits[vehiclename];

  if(isDefined(gamelimit)) {
    if(isDefined(level.vehicle.instances[vehiclename]) && level.vehicle.instances[vehiclename].size >= gamelimit) {
      return true;
    }
  }

  spawntypelimit = undefined;
  spawntypecount = undefined;

  if(isDefined(spawntype) && isDefined(level.vehicle.spawntypeinstancelimits) && isDefined(level.vehicle.spawntypeinstancelimits[vehiclename]) && isDefined(level.vehicle.spawntypeinstancelimits[vehiclename][spawntype])) {
    spawntypelimit = level.vehicle.spawntypeinstancelimits[vehiclename][spawntype];
    spawntypecount = 0;
  }

  ownerlimit = undefined;
  ownercount = undefined;

  if(isDefined(owner)) {
    ownerlimit = level.vehicle.ownerinstancelimits[vehiclename];
    ownercount = 0;
  }

  teamlimit = undefined;
  teamcount = undefined;

  if(isDefined(team)) {
    teamlimit = level.vehicle.teaminstancelimits[vehiclename];
    teamcount = 0;
  }

  if(!isDefined(ownerlimit) && !isDefined(teamlimit) && !isDefined(spawntypelimit)) {
    return false;
  }

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(ownerlimit) && isDefined(instance.vehicleowner) && instance.vehicleowner == owner) {
      ownercount++;

      if(ownercount >= ownerlimit) {
        return true;
      }
    }

    if(isDefined(teamlimit) && isDefined(instance.vehicleteam) && instance.vehicleteam == team) {
      teamcount++;

      if(teamcount >= teamlimit) {
        return true;
      }
    }

    if(isDefined(spawntypelimit) && isDefined(instance.spawndata) && isDefined(instance.spawndata.spawntype) && instance.spawndata.spawntype == spawntype) {
      spawntypecount++;

      if(spawntypecount >= spawntypelimit) {
        return true;
      }
    }
  }

  return false;
}

function vehicle_tracking_getgameinstances(vehiclename) {
  assertex(isDefined(level.vehicle), "<dev string:x47b>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x4c0>");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return [];
  }

  return level.vehicle.instances[vehiclename];
}

function vehicle_tracking_getownerinstances(vehiclename, owner) {
  assertex(isDefined(level.vehicle), "<dev string:x50e>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x554>");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return [];
  }

  instances = [];

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(instance.vehicleowner) && instance.vehicleowner == owner) {
      instances[instances.size] = instance;
    }
  }

  return instances;
}

function vehicle_tracking_getteaminstances(vehiclename, team) {
  assertex(isDefined(level.vehicle), "<dev string:x5a3>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x5e8>");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return [];
  }

  instances = [];

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(instance.vehicleteam) && instance.vehicleteam == team) {
      instances[instances.size] = instance;
    }
  }

  return instances;
}

function vehicle_tracking_getgameinstancesforall() {
  assertex(isDefined(level.vehicle), "<dev string:x636>");

  if(!isDefined(level.vehicle.instances)) {
    return [];
  }

  instances = [];

  foreach(instancearr in level.vehicle.instances) {
    foreach(instance in instancearr) {
      instances[instances.size] = instance;
    }
  }

  return instances;
}

function vehicle_tracking_instancesarelimited(vehiclename) {
  assertex(isDefined(level.vehicle), "<dev string:x681>");
  assertex(isDefined(level.vehicle.instances), "<dev string:x6c9>");

  if(isDefined(level.vehicle.instancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.ownerinstancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.teaminstancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.spawntypeinstancelimits[vehiclename])) {
    return true;
  }

  return false;
}

function function_59e95ab1ae37120a() {
  assertex(isDefined(level.vehicle), "<dev string:x71a>");
  assertex(isDefined(level.vehicle.var_3af6263662b92655), "<dev string:x755>");
  return level.vehicle.var_3af6263662b92655;
}

function vehicle_tracking_init() {
  assertex(isDefined(level.vehicle), "<dev string:x799>");
  assertex(!isDefined(level.vehicle.instances), "<dev string:x7d2>");
  level.vehicle.instances = [];
  level.vehicle.var_3af6263662b92655 = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle.spawntypeinstancelimits = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.maxvehiclecount = getdvarint(@ "hash_a473574b4e4333d0", 128);
  level.var_6fc6b49b8704877f = getdvarint(@ "hash_c9b6891700ca109", 0);
  level utility::flag_set("vehicle_tracking_initialized");
}

function validatespawndata(spawndata) {
  if(!isDefined(spawndata)) {
    thread error("<dev string:x809>");
    return 0;
  }

  if(!isDefined(spawndata.origin)) {
    thread error("<dev string:x827>");
    return 0;
  }

  if(!isDefined(spawndata.angles)) {
    thread error("<dev string:x84c>");
    return 0;
  }

  return 1;
}

function function_3a040ff591c32b5c(spawndata) {
  if(!validatespawndata(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread error("<dev string:x871>");
    return 0;
  }

  if(!isDefined(spawndata.targetname)) {
    thread error("<dev string:x89b>");
    return 0;
  }

  return 1;
}

function function_298430b99bada795(spawndata) {
  if(!validatespawndata(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.owner)) {
    thread error("<dev string:x8c4>");
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread error("<dev string:x871>");
    return 0;
  }

  if(!isDefined(spawndata.modelname)) {
    thread error("<dev string:x8e8>");
    return 0;
  }

  return 1;
}

# /