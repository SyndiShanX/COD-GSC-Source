/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_tracking.gsc
*******************************************************/

function _spawnVehicle(var0, var1) {
  if(!istrue(var0.startsuspended)) {
    if(!canspawnVehicle()) {
      if(isDefined(var1)) {
        var1.fail = "total_limit_exceeded";
      }

      return undefined;
    }
  }

  var2 = undefined;

  if(isDefined(var0.initialvelocity)) {
    var2 = spawnVehicle(var0.modelname, var0.targetname, var0.vehicletype, var0.origin, var0.angles, var0.owner, var0.initialvelocity);
  } else {
    var2 = spawnVehicle(var0.modelname, var0.targetname, var0.vehicletype, var0.origin, var0.angles, var0.owner);
  }

  if(!isDefined(var2)) {
    if(isDefined(var1)) {
      var1.fail = "total_limit_exceeded";
    }

    return undefined;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_tracking", "vehicle_spawned")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_tracking", "vehicle_spawned")]](var2);
  }

  var2.spawndata = var0;
  level.vehiclecount++;
  var0.cannotbesuspended = 1;

  if(!istrue(var0.cannotbesuspended)) {
    if(istrue(var0.startsuspended)) {
      _suspendvehicle(var2);
    } else {
      thread watchvehiclesuspend(var2, 3);
    }
  } else {
    vehiclecannotbesuspended(var2, 1);
  }

  return var2;
}

function _spawnhelicopter(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var6 = spawnStruct();
  var6.modelname = var4;
  var6.vehicletype = var3;
  var6.origin = var1;
  var6.angles = var2;
  var6.owner = var0;

  if(!canspawnVehicle()) {
    if(isDefined(var5)) {
      var5.fail = "total_limit_exceeded";
    }

    return undefined;
  }

  var7 = spawnhelicopter(var6.owner, var6.origin, var6.angles, var6.vehicletype, var6.modelname);

  if(!isDefined(var7)) {
    if(isDefined(var5)) {
      var5.fail = "code";
    }

    return undefined;
  }

  level.vehiclecount++;
  return var7;
}

function _deletevehicle(var0) {
  var0 notify("vehicle_deleted");
  level.vehiclecount--;

  if(istrue(var0.issuspended)) {
    level.suspendedvehiclecount--;
    level.suspendedvehicles[var0 getentitynumber()] = undefined;
  }

  var0 delete();
  return true;
}

function _suspendvehicle(var0) {
  if(isDefined(var0.cannotbesuspended)) {
    return false;
  }

  var0 notify("vehicle_wake_up_or_suspend");

  if(!istrue(var0.issuspended)) {
    var0.issuspended = 1;
    level.suspendedvehiclecount++;
    level.suspendedvehicles[var0 getentitynumber()] = var0;

    if(!var0 issuspendedvehicle()) {
      var0 suspendvehicle();
    }
  }

  return true;
}

function _wakeupvehicle(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 3;
  }

  if(!istrue(var0.issuspended)) {
    return true;
  }

  var0 notify("vehicle_wake_up_or_suspend");

  if(!canwakeupvehicle()) {
    if(istrue(var1)) {
      thread queuevehiclewakeup(var0, var2, var3);
    }

    return false;
  } else {
    var0.issuspended = undefined;
    level.suspendedvehiclecount--;
    level.suspendedvehicles[var0 getentitynumber()] = undefined;

    if(var0 issuspendedvehicle()) {
      var0 wakeupvehicle();
    }

    if(istrue(var2)) {
      thread watchvehiclesuspend(var0, var3);
    }
  }

  return true;
}

function queuevehiclewakeup(var0, var1, var2) {
  var0 endon("vehicle_deleted");
  var0 endon("vehicle_wake_up_or_suspend");

  for(;;) {
    if(canwakeupvehicle()) {
      thread _wakeupvehicle(var0, undefined, var1, var2);
      return;
    }

    waitframe();
  }
}

function watchvehiclesuspend(var0, var1) {
  var0 endon("vehicle_deleted");
  var0 endon("vehicle_wake_up_or_suspend");

  if(isDefined(var1)) {
    wait var1;
  }

  var2 = undefined;
  var3 = undefined;
  var4 = 0;

  for(;;) {
    wait 0.05;

    if(!vehiclecanbesuspended(var0)) {
      return;
    }

    if(isDefined(var2)) {
      var3 = var2;
    }

    var2 = var0 vehicle_getspeed();

    if(isDefined(var3) && abs(var2 - var3) / 0.05 > 3) {
      var4 = 0;
      continue;
    }

    var4 += 0.05;

    if(var4 >= 3) {
      thread _suspendvehicle(var0);
      return;
    }
  }
}

function vehiclecannotbesuspended(var0, var1, var2) {
  if(var1) {
    if(!isDefined(var0.cannotbesuspended)) {
      var0.cannotbesuspended = 0;
    }

    var0.cannotbesuspended++;

    if(istrue(var0.issuspended)) {
      return _wakeupvehicle(var0, var2, 0);
    }
  } else {
    if(!isDefined(var0.cannotbesuspended)) {
      return;
    }

    var0.cannotbesuspended--;

    if(var0.cannotbesuspended == 0) {
      var0.cannotbesuspended = undefined;
    }

    if(!isDefined(var0.cannotbesuspended)) {
      thread watchvehiclesuspend(var0);
    }
  }

  return 1;
}

function canspawnVehicle() {
  return level.vehiclecount - level.suspendedvehiclecount < level.maxvehiclecount;
}

function canwakeupvehicle() {
  return canspawnVehicle();
}

function vehiclecanbesuspended() {
  return !isDefined(self.cannotbesuspended);
}

function _issuspendedvehicle() {
  return istrue(self.issuspended);
}

function getvehiclecount() {
  return level.vehiclecount;
}

function getsuspendedvehiclecount() {
  return level.suspendedvehiclecount;
}

function reservevehicle(var0) {
  if(canspawnVehicle()) {
    if(!isDefined(var0)) {
      level.vehiclecount++;
      return true;
    }

    var1 = level.maxvehiclecount - level.vehiclecount - level.suspendedvehiclecount;

    if(var0 <= var1) {
      level.vehiclecount += var0;
      return true;
    }
  }

  return false;
}

function clearvehiclereservation(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  level.vehiclecount -= var0;
  level.vehiclecount = int(max(0, level.vehiclecount));
}

function getvehiclespawndata(var0) {
  return var0.spawndata;
}

function copyvehiclespawndata(var0, var1) {
  var1.modelname = var0.modelname;
  var1.targetname = var0.targetname;
  var1.vehicletype = var0.vehicletype;
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.owner = var0.owner;
  var1.initialvelocity = var0.initialvelocity;
  var1.cannotbesuspended = var0.cannotbesuspended;
  var1.startsuspended = var0.startsuspended;
  var1.spawntype = var0.spawntype;
  var1.team = var0.team;
  var1.usealtmodel = var0.usealtmodel;
}

function vehicle_tracking_registerinstance(var0, var1, var2) {
  vehicle_tracking_deregisterinstance(var0);
  level.vehicle.instances[var0.vehiclename][var0 getentitynumber()] = var0;
  var0.vehicleowner = undefined;

  if(isDefined(var1)) {
    var0.vehicleowner = var1;
  }

  var0.vehicleteam = undefined;

  if(isDefined(var2)) {
    var0.vehicleteam = var2;
    return;
  }
}

function vehicle_tracking_deregisterinstance(var0) {
  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.instances)) {
    return;
  }

  if(!isDefined(level.vehicle.instances[var0.vehiclename])) {
    return;
  }

  level.vehicle.instances[var0.vehiclename][var0 getentitynumber()] = undefined;

  if(level.vehicle.instances[var0.vehiclename].size <= 0) {
    level.vehicle.instances[var0.vehiclename] = undefined;
  }

  var0.vehicleowner = undefined;
  var0.vehicleteam = undefined;
}

function vehicle_tracking_limitgameinstances(var0, var1, var2) {
  level.vehicle.instancelimits[var0] = var1;
  level.vehicle.instancelimitmessages[var0] = var2;
}

function vehicle_tracking_limitownerinstances(var0, var1, var2) {
  level.vehicle.ownerinstancelimits[var0] = var1;
  level.vehicle.ownerinstancelimitmessages[var0] = var2;
}

function vehicle_tracking_limitteaminstances(var0, var1, var2) {
  level.vehicle.teaminstancelimits[var0] = var1;
  level.vehicle.teaminstancelimitmessages[var0] = var2;
}

function vehicle_tracking_atinstancelimit(var0, var1, var2, var3) {
  if(!isDefined(level.vehicle.instances[var0])) {
    return false;
  }

  var4 = level.vehicle.instancelimits[var0];

  if(isDefined(var4)) {
    if(isDefined(level.vehicle.instances[var0]) && level.vehicle.instances[var0].size >= var4) {
      return true;
    }
  }

  var5 = undefined;
  var6 = undefined;

  if(isDefined(var1)) {
    var5 = level.vehicle.ownerinstancelimits[var0];
    var6 = 0;
  }

  var7 = undefined;
  var8 = undefined;

  if(isDefined(var2)) {
    var7 = level.vehicle.teaminstancelimits[var0];
    var8 = 0;
  }

  if(!isDefined(var5) && !isDefined(var7)) {
    return false;
  }

  foreach(var10 in level.vehicle.instances[var0]) {
    if(isDefined(var5) && isDefined(var10.vehicleowner) && var10.vehicleowner == var1) {
      var6++;

      if(var6 >= var5) {
        return true;
      }
    }

    if(isDefined(var7) && isDefined(var10.vehicleteam) && var10.vehicleteam == var2) {
      var8++;

      if(var8 >= var7) {
        return true;
      }
    }
  }

  return false;
}

function vehicle_tracking_getgameinstances(var0) {
  if(!isDefined(level.vehicle.instances[var0])) {
    return [];
  }

  return level.vehicle.instances[var0];
}

function vehicle_tracking_getownerinstances(var0, var1) {
  if(!isDefined(level.vehicle.instances[var0])) {
    return [];
  }

  var2 = [];

  foreach(var4 in level.vehicle.instances[var0]) {
    if(isDefined(var4.vehicleowner) && var4.vehicleowner == var1) {
      var2 = var4;
    }
  }

  return var2;
}

function vehicle_tracking_getteaminstances(var0, var1) {
  if(!isDefined(level.vehicle.instances[var0])) {
    return [];
  }

  var2 = [];

  foreach(var4 in level.vehicle.instances[var0]) {
    if(isDefined(var4.vehicleteam) && var4.vehicleteam == var1) {
      var2 = var4;
    }
  }

  return var2;
}

function vehicle_tracking_getgameinstancesforall() {
  if(!isDefined(level.vehicle.instances)) {
    return [];
  }

  var0 = [];

  foreach(var2 in level.vehicle.instances) {
    foreach(var4 in var2) {
      var0 = var4;
    }
  }

  return var0;
}

function vehicle_tracking_instancesarelimited(var0) {
  if(isDefined(level.vehicle.instancelimits[var0])) {
    return true;
  }

  if(isDefined(level.vehicle.ownerinstancelimits[var0])) {
    return true;
  }

  if(isDefined(level.vehicle.teaminstancelimits[var0])) {
    return true;
  }

  return false;
}

function vehicle_tracking_init() {
  level.vehicle.instances = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.suspendedvehiclecount = 0;
  level.maxvehiclecount = getdvarint("scr_maxVehicleCount", 128);
  level.suspendedvehicles = [];
}