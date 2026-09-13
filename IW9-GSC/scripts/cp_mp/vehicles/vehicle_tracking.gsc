/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_tracking.gsc
*******************************************************/

_spawnVehicle(spawndata, _id_EE8DA5624236DC89) {
  if(!istrue(spawndata.startsuspended)) {
    if(!canspawnVehicle()) {
      if(isDefined(_id_EE8DA5624236DC89))
        _id_EE8DA5624236DC89.fail = "total_limit_exceeded";

      return undefined;
    }
  }

  vehicle = undefined;

  if(isDefined(spawndata.initialvelocity))
    vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata._id_0131EA86B569E731);
  else
    vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, undefined, spawndata._id_0131EA86B569E731);

  if(!isDefined(vehicle)) {
    if(isDefined(_id_EE8DA5624236DC89))
      _id_EE8DA5624236DC89.fail = "total_limit_exceeded";

    return undefined;
  }

  vehicle.spawndata = spawndata;
  level.vehiclecount++;
  return vehicle;
}

_spawnhelicopter(owner, origin, angles, type, modelname) {
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata = spawnStruct();
  spawndata.modelname = modelname;
  spawndata.vehicletype = type;
  spawndata.origin = origin;
  spawndata.angles = angles;
  spawndata.owner = owner;

  if(!canspawnVehicle()) {
    if(isDefined(_id_EE8DA5624236DC89))
      _id_EE8DA5624236DC89.fail = "total_limit_exceeded";

    return undefined;
  }

  vehicle = spawnhelicopter(spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname);

  if(!isDefined(vehicle)) {
    if(isDefined(_id_EE8DA5624236DC89))
      _id_EE8DA5624236DC89.fail = "code";

    return undefined;
  }

  level.vehiclecount++;
  return vehicle;
}

_deletevehicle(vehicle) {
  vehicle notify("vehicle_deleted");
  level.vehiclecount--;
  _id_D21ABB198361E610(vehicle);
  vehicle delete();
  return 1;
}

_id_D21ABB198361E610(vehicle) {
  if(!isDefined(vehicle._id_E478AC91AF0E92CB)) {
    return;
  }
  foreach(scriptable in vehicle._id_E478AC91AF0E92CB) {
    if(!isDefined(scriptable)) {
      continue;
    }
    if(isDefined(scriptable.type) && scripts\cp_mp\utility\script_utility::issharedfuncdefined(scriptable.type, "delete") && scriptable[[scripts\cp_mp\utility\script_utility::getsharedfunc(scriptable.type, "delete")]]()) {
      continue;
    }
    scriptable notify("death");
    scriptable scripts\engine\utility::script_func("deregisterScriptable");

    if(scriptable getscriptableisreserved()) {
      scriptable freescriptable();
      continue;
    }

    part = scriptable _meth_EC5F4851431F3382();

    if(scriptable getscriptableparthasstate(part, "hidden"))
      scriptable setscriptablepartstate(part, "hidden");
  }
}

canspawnVehicle() {
  return level.vehiclecount < level.maxvehiclecount;
}

getvehiclecount() {
  return level.vehiclecount;
}

reservevehicle(count) {
  if(canspawnVehicle()) {
    if(!isDefined(count)) {
      level.vehiclecount++;
      return 1;
    }

    _id_2505BA0EB2A7B5D5 = level.maxvehiclecount - level.vehiclecount;

    if(count <= _id_2505BA0EB2A7B5D5) {
      level.vehiclecount = level.vehiclecount + count;
      return 1;
    }
  }

  return 0;
}

clearvehiclereservation(count) {
  if(!isDefined(count))
    count = 1;

  level.vehiclecount = level.vehiclecount - count;
  level.vehiclecount = int(max(0, level.vehiclecount));
}

getvehiclespawndata(vehicle) {
  return vehicle.spawndata;
}

copyvehiclespawndata(from, to) {
  to.modelname = from.modelname;
  to._id_14CDE247AC3313A4 = from._id_14CDE247AC3313A4;
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

vehicle_tracking_registerinstance(vehicle, owner, team) {
  vehicle_tracking_deregisterinstance(vehicle);
  level.vehicle.instances[vehicle.vehiclename][vehicle getentitynumber()] = vehicle;
  vehicle.vehicleowner = undefined;

  if(isDefined(owner))
    vehicle.vehicleowner = owner;

  vehicle.vehicleteam = undefined;

  if(isDefined(team))
    vehicle.vehicleteam = team;
}

vehicle_tracking_deregisterinstance(vehicle) {
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

  if(level.vehicle.instances[vehicle.vehiclename].size <= 0)
    level.vehicle.instances[vehicle.vehiclename] = undefined;

  vehicle.vehicleowner = undefined;
  vehicle.vehicleteam = undefined;
}

vehicle_tracking_limitgameinstances(vehiclename, limit, message) {
  level.vehicle.instancelimits[vehiclename] = limit;
  level.vehicle.instancelimitmessages[vehiclename] = message;
}

_id_5C8408CB68649308(vehiclename, spawntype, limit) {
  if(!isDefined(level.vehicle._id_0EB26B962268635B[vehiclename]))
    level.vehicle._id_0EB26B962268635B[vehiclename] = [];

  level.vehicle._id_0EB26B962268635B[vehiclename][spawntype] = limit;
}

vehicle_tracking_limitownerinstances(vehiclename, limit, message) {
  level.vehicle.ownerinstancelimits[vehiclename] = limit;
  level.vehicle.ownerinstancelimitmessages[vehiclename] = message;
}

vehicle_tracking_limitteaminstances(vehiclename, limit, message) {
  level.vehicle.teaminstancelimits[vehiclename] = limit;
  level.vehicle.teaminstancelimitmessages[vehiclename] = message;
}

vehicle_tracking_atinstancelimit(vehiclename, owner, team, spawntype, _id_5BA9AF6ABAE862CA) {
  if(!isDefined(level.vehicle.instances[vehiclename]))
    return 0;

  _id_9804D2DE3C8F09C6 = level.vehicle.instancelimits[vehiclename];

  if(isDefined(_id_9804D2DE3C8F09C6)) {
    if(isDefined(level.vehicle.instances[vehiclename]) && level.vehicle.instances[vehiclename].size >= _id_9804D2DE3C8F09C6)
      return 1;
  }

  _id_8FE403544E073DB7 = undefined;
  _id_6536066694C661FB = undefined;

  if(isDefined(spawntype) && isDefined(level.vehicle._id_0EB26B962268635B) && isDefined(level.vehicle._id_0EB26B962268635B[vehiclename]) && isDefined(level.vehicle._id_0EB26B962268635B[vehiclename][spawntype])) {
    _id_8FE403544E073DB7 = level.vehicle._id_0EB26B962268635B[vehiclename][spawntype];
    _id_6536066694C661FB = 0;
  }

  _id_07493F9697366D2B = undefined;
  _id_A79D78866AC25C77 = undefined;

  if(isDefined(owner)) {
    _id_07493F9697366D2B = level.vehicle.ownerinstancelimits[vehiclename];
    _id_A79D78866AC25C77 = 0;
  }

  _id_3287DCCCC68557B3 = undefined;
  _id_652F47620AC4713F = undefined;

  if(isDefined(team)) {
    _id_3287DCCCC68557B3 = level.vehicle.teaminstancelimits[vehiclename];
    _id_652F47620AC4713F = 0;
  }

  if(!isDefined(_id_07493F9697366D2B) && !isDefined(_id_3287DCCCC68557B3) && !isDefined(_id_8FE403544E073DB7))
    return 0;

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(_id_07493F9697366D2B) && isDefined(instance.vehicleowner) && instance.vehicleowner == owner) {
      _id_A79D78866AC25C77++;

      if(_id_A79D78866AC25C77 >= _id_07493F9697366D2B)
        return 1;
    }

    if(isDefined(_id_3287DCCCC68557B3) && isDefined(instance.vehicleteam) && instance.vehicleteam == team) {
      _id_652F47620AC4713F++;

      if(_id_652F47620AC4713F >= _id_3287DCCCC68557B3)
        return 1;
    }

    if(isDefined(_id_8FE403544E073DB7) && isDefined(instance.spawndata) && isDefined(instance.spawndata.spawntype) && instance.spawndata.spawntype == spawntype) {
      _id_6536066694C661FB++;

      if(_id_6536066694C661FB >= _id_8FE403544E073DB7)
        return 1;
    }
  }

  return 0;
}

vehicle_tracking_getgameinstances(vehiclename) {
  if(!isDefined(level.vehicle.instances[vehiclename]))
    return [];

  return level.vehicle.instances[vehiclename];
}

vehicle_tracking_getownerinstances(vehiclename, owner) {
  if(!isDefined(level.vehicle.instances[vehiclename]))
    return [];

  instances = [];

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(instance.vehicleowner) && instance.vehicleowner == owner)
      instances[instances.size] = instance;
  }

  return instances;
}

vehicle_tracking_getteaminstances(vehiclename, team) {
  if(!isDefined(level.vehicle.instances[vehiclename]))
    return [];

  instances = [];

  foreach(instance in level.vehicle.instances[vehiclename]) {
    if(isDefined(instance.vehicleteam) && instance.vehicleteam == team)
      instances[instances.size] = instance;
  }

  return instances;
}

vehicle_tracking_getgameinstancesforall() {
  if(!isDefined(level.vehicle.instances))
    return [];

  instances = [];

  foreach(_id_E705B089592C075D in level.vehicle.instances) {
    foreach(instance in _id_E705B089592C075D)
    instances[instances.size] = instance;
  }

  return instances;
}

vehicle_tracking_instancesarelimited(vehiclename) {
  if(isDefined(level.vehicle.instancelimits[vehiclename]))
    return 1;

  if(isDefined(level.vehicle.ownerinstancelimits[vehiclename]))
    return 1;

  if(isDefined(level.vehicle.teaminstancelimits[vehiclename]))
    return 1;

  if(isDefined(level.vehicle._id_0EB26B962268635B[vehiclename]))
    return 1;

  return 0;
}

vehicle_tracking_init() {
  level.vehicle.instances = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle._id_0EB26B962268635B = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.maxvehiclecount = getdvarint("scr_maxvehiclecount", 128);
}