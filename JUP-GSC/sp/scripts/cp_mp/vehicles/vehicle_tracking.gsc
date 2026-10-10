/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\vehicles\vehicle_tracking.gsc
**********************************************************/

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

      if(istrue(level.var_4e89ea3291f12198)) {
        println("<dev string:x1c>" + spawndata.modelname + "<dev string:x46>" + level.vehiclecount + "<dev string:x5d>" + level.maxvehiclecount);
      }

      return undefined;
    }
  }

  vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.var_131ea86b569e731);

  if(!isDefined(vehicle)) {
    if(isDefined(faildata)) {
      faildata.fail = "total_limit_exceeded";
    }

    if(istrue(level.var_4e89ea3291f12198)) {
      println("<dev string:x77>" + spawndata.modelname);
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
    scripts\engine\utility::error("<dev string:xae>");
  }

  level.vehiclecount = int(max(0, level.vehiclecount));
}

function getvehiclespawndata(vehicle) {
  return vehicle.spawndata;
}

function copyvehiclespawndata(from, to) {
  to.modelname = from.modelname;
  to.var_14cde247ac3313a4 = from.var_14cde247ac3313a4;
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

function vehicle_tracking_registerinstance(vehicle, owner, team) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_registerInstance() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_registerInstance() called before vehicle_tracking_init().");
  assertex(isDefined(vehicle.vehiclename), "vehicle_tracking_registerInstance() called with an invalid vehicle.");
  vehicle_tracking_deregisterinstance(vehicle);
  level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()] = vehicle;
  vehicle.vehicleowner = owner;
  vehicle.vehicleteam = team;
}

function vehicle_tracking_deregisterinstance(vehicle) {
  assertex(isDefined(vehicle.vehiclename), "vehicle_tracking_deregisterInstance() called with an invalid vehicle.");

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

  if(level.vehicle.instances[vehicle.vehiclename].size <= 0) {
    level.vehicle.instances[vehicle.vehiclename] = undefined;
  }

  vehicle.vehicleowner = undefined;
  vehicle.vehicleteam = undefined;
}

function vehicle_tracking_limitgameinstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_limitGameInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_limitGameInstances() called before vehicle_tracking_init().");
  level.vehicle.instancelimits[vehiclename] = limit;
  level.vehicle.instancelimitmessages[vehiclename] = message;
}

function function_5c8408cb68649308(vehiclename, spawntype, limit) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_limitGameInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_limitGameInstances() called before vehicle_tracking_init().");

  if(!isDefined(level.vehicle.var_eb26b962268635b[vehiclename])) {
    level.vehicle.var_eb26b962268635b[vehiclename] = [];
  }

  level.vehicle.var_eb26b962268635b[vehiclename][spawntype] = limit;
}

function vehicle_tracking_limitownerinstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_limitOwnerInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_limitOwnerInstances() called before vehicle_tracking_init().");
  level.vehicle.ownerinstancelimits[vehiclename] = limit;
  level.vehicle.ownerinstancelimitmessages[vehiclename] = message;
}

function vehicle_tracking_limitteaminstances(vehiclename, limit, message) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_limitTeamInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_limitTeamInstances() called before vehicle_tracking_init().");
  level.vehicle.teaminstancelimits[vehiclename] = limit;
  level.vehicle.teaminstancelimitmessages[vehiclename] = message;
}

function vehicle_tracking_atinstancelimit(vehiclename, owner, team, spawntype, sendmessage) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_atInstanceLimit() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_atInstanceLimit() called before vehicle_tracking_init().");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return false;
  }

  gamelimit = level.vehicle.instancelimits[vehiclename];

  if(isDefined(gamelimit)) {
    if(isDefined(level.vehicle.instances[vehiclename]) && level.vehicle.instances[vehiclename].size >= gamelimit) {
      return true;
    }
  }

  var_8fe403544e073db7 = undefined;
  var_6536066694c661fb = undefined;

  if(isDefined(spawntype) && isDefined(level.vehicle.var_eb26b962268635b) && isDefined(level.vehicle.var_eb26b962268635b[vehiclename]) && isDefined(level.vehicle.var_eb26b962268635b[vehiclename][spawntype])) {
    var_8fe403544e073db7 = level.vehicle.var_eb26b962268635b[vehiclename][spawntype];
    var_6536066694c661fb = 0;
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

  if(!isDefined(ownerlimit) && !isDefined(teamlimit) && !isDefined(var_8fe403544e073db7)) {
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

    if(isDefined(var_8fe403544e073db7) && isDefined(instance.spawndata) && isDefined(instance.spawndata.spawntype) && instance.spawndata.spawntype == spawntype) {
      var_6536066694c661fb++;

      if(var_6536066694c661fb >= var_8fe403544e073db7) {
        return true;
      }
    }
  }

  return false;
}

function vehicle_tracking_getgameinstances(vehiclename) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_getGameInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_getGameInstances() called before vehicle_tracking_init().");

  if(!isDefined(level.vehicle.instances[vehiclename])) {
    return [];
  }

  return level.vehicle.instances[vehiclename];
}

function vehicle_tracking_getownerinstances(vehiclename, owner) {
  assertex(isDefined(level.vehicle), "vehicle_tracking_getOwnerInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_getOwnerInstances() called before vehicle_tracking_init().");

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
  assertex(isDefined(level.vehicle), "vehicle_tracking_getTeamInstances() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_getTeamInstances() called before vehicle_tracking_init().");

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
  assertex(isDefined(level.vehicle), "vehicle_tracking_getGameInstancesForAll() called before vehicle_init().");

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
  assertex(isDefined(level.vehicle), "vehicle_tracking_instancesAreLimited() called before vehicle_init().");
  assertex(isDefined(level.vehicle.instances), "vehicle_tracking_instancesAreLimited() called before vehicle_tracking_init().");

  if(isDefined(level.vehicle.instancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.ownerinstancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.teaminstancelimits[vehiclename])) {
    return true;
  }

  if(isDefined(level.vehicle.var_eb26b962268635b[vehiclename])) {
    return true;
  }

  return false;
}

function vehicle_tracking_init() {
  assertex(isDefined(level.vehicle), "vehicle_tracking_init() called before vehicle_init().");
  assertex(!isDefined(level.vehicle.instances), "vehicle_tracking_init() should only be called once.");
  level.vehicle.instances = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle.var_eb26b962268635b = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.maxvehiclecount = getdvarint(@ "hash_a473574b4e4333d0", 128);
}

function validatespawndata(spawndata) {
  if(!isDefined(spawndata)) {
    thread error("<dev string:xf1>");
    return 0;
  }

  if(!isDefined(spawndata.origin)) {
    thread error("<dev string:x10c>");
    return 0;
  }

  if(!isDefined(spawndata.angles)) {
    thread error("<dev string:x12e>");
    return 0;
  }

  return 1;
}

function function_3a040ff591c32b5c(spawndata) {
  if(!validatespawndata(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread error("<dev string:x150>");
    return 0;
  }

  if(!isDefined(spawndata.targetname)) {
    thread error("<dev string:x177>");
    return 0;
  }

  return 1;
}

function function_298430b99bada795(spawndata) {
  if(!validatespawndata(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.owner)) {
    thread error("<dev string:x19d>");
    return 0;
  }

  if(!isDefined(spawndata.vehicletype)) {
    thread error("<dev string:x150>");
    return 0;
  }

  if(!isDefined(spawndata.modelname)) {
    thread error("<dev string:x1be>");
    return 0;
  }

  return 1;
}

# /