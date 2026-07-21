/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_tracking.gsc
***********************************************/

_spawnVehicle(var_0, var_1) {
  if(!istrue(var_0.startsuspended)) {
    if(!canspawnVehicle()) {
      if(isDefined(var_1))
        var_1.fail = "_encstr_A91F15203FF451A18175D3E90C0BFF99509720D07BBD49";

      return undefined;
    }
  }

  var_2 = undefined;

  if(isDefined(var_0.initialvelocity))
    var_2 = spawnVehicle(var_0.modelname, var_0.targetname, var_0.vehicletype, var_0.origin, var_0.angles, var_0.owner, var_0.initialvelocity);
  else
    var_2 = spawnVehicle(var_0.modelname, var_0.targetname, var_0.vehicletype, var_0.origin, var_0.angles, var_0.owner);

  if(!isDefined(var_2)) {
    if(isDefined(var_1))
      var_1.fail = "_encstr_A91F15203FF451A18175D3E90C0BFF99509720D07BBD49";

    return undefined;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A19511CE05B81776718869D31843AEC7707827", "_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A19511CE05B81776718869D31843AEC7707827", "_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501")]](var_2);

  var_2.spawndata = var_0;
  level.vehiclecount++;
  var_0.cannotbesuspended = 1;

  if(!istrue(var_0.cannotbesuspended)) {
    if(istrue(var_0.startsuspended))
      _suspendvehicle(var_2);
    else
      thread watchvehiclesuspend(var_2, 3);
  } else
    vehiclecannotbesuspended(var_2, 1);

  return var_2;
}

_spawnhelicopter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_6 = spawnStruct();
  var_6.modelname = var_4;
  var_6.vehicletype = var_3;
  var_6.origin = var_1;
  var_6.angles = var_2;
  var_6.owner = var_0;

  if(!canspawnVehicle()) {
    if(isDefined(var_5))
      var_5.fail = "_encstr_A91F15203FF451A18175D3E90C0BFF99509720D07BBD49";

    return undefined;
  }

  var_7 = spawnhelicopter(var_6.owner, var_6.origin, var_6.angles, var_6.vehicletype, var_6.modelname);

  if(!isDefined(var_7)) {
    if(isDefined(var_5))
      var_5.fail = "_encstr_BD910503BF403F";

    return undefined;
  }

  level.vehiclecount++;
  return var_7;
}

_deletevehicle(var_0) {
  var_0 notify("_encstr_8DE710563D72F231B84D707969746FB39AD0");
  level.vehiclecount--;

  if(istrue(var_0.issuspended)) {
    level.suspendedvehiclecount--;
    level.suspendedvehicles[var_0 getentitynumber()] = undefined;
  }

  var_0 delete();
  return 1;
}

_suspendvehicle(var_0) {
  if(isDefined(var_0.cannotbesuspended))
    return 0;

  var_0 notify("_encstr_BD141B7DC8DC78A6ED89E6CB38CCA05FD550616F1B49B778D2F9DAA57A");

  if(!istrue(var_0.issuspended)) {
    var_0.issuspended = 1;
    level.suspendedvehiclecount++;
    level.suspendedvehicles[var_0 getentitynumber()] = var_0;

    if(!var_0 issuspendedvehicle())
      var_0 suspendvehicle();
  }

  return 1;
}

_wakeupvehicle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 3;

  if(!istrue(var_0.issuspended))
    return 1;

  var_0 notify("_encstr_BD141B7DC8DC78A6ED89E6CB38CCA05FD550616F1B49B778D2F9DAA57A");

  if(!canwakeupvehicle()) {
    if(istrue(var_1))
      thread queuevehiclewakeup(var_0, var_2, var_3);

    return 0;
  } else {
    var_0.issuspended = undefined;
    level.suspendedvehiclecount--;
    level.suspendedvehicles[var_0 getentitynumber()] = undefined;

    if(var_0 issuspendedvehicle())
      var_0 wakeupvehicle();

    if(istrue(var_2))
      thread watchvehiclesuspend(var_0, var_3);
  }

  return 1;
}

queuevehiclewakeup(var_0, var_1, var_2) {
  var_0 endon("_encstr_8DE710563D72F231B84D707969746FB39AD0");
  var_0 endon("_encstr_BD141B7DC8DC78A6ED89E6CB38CCA05FD550616F1B49B778D2F9DAA57A");

  for(;;) {
    if(canwakeupvehicle()) {
      thread _wakeupvehicle(var_0, undefined, var_1, var_2);
      return;
    }

    waitframe();
  }
}

watchvehiclesuspend(var_0, var_1) {
  var_0 endon("_encstr_8DE710563D72F231B84D707969746FB39AD0");
  var_0 endon("_encstr_BD141B7DC8DC78A6ED89E6CB38CCA05FD550616F1B49B778D2F9DAA57A");

  if(isDefined(var_1))
    wait(var_1);

  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;

  for(;;) {
    wait 0.05;

    if(!var_0 vehiclecanbesuspended()) {
      return;
    }
    if(isDefined(var_2))
      var_3 = var_2;

    var_2 = var_0 vehicle_getspeed();

    if(isDefined(var_3) && abs(var_2 - var_3) / 0.05 > 3) {
      var_4 = 0;
      continue;
    }

    var_4 = var_4 + 0.05;

    if(var_4 >= 3) {
      thread _suspendvehicle(var_0);
      return;
    }
  }
}

vehiclecannotbesuspended(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_0.cannotbesuspended))
      var_0.cannotbesuspended = 0;

    var_0.cannotbesuspended++;

    if(istrue(var_0.issuspended))
      return _wakeupvehicle(var_0, var_2, 0);
  } else {
    if(!isDefined(var_0.cannotbesuspended)) {
      return;
    }
    var_0.cannotbesuspended--;

    if(var_0.cannotbesuspended == 0)
      var_0.cannotbesuspended = undefined;

    if(!isDefined(var_0.cannotbesuspended))
      thread watchvehiclesuspend(var_0);
  }

  return 1;
}

canspawnVehicle() {
  return level.vehiclecount - level.suspendedvehiclecount < level.maxvehiclecount;
}

canwakeupvehicle() {
  return canspawnVehicle();
}

vehiclecanbesuspended() {
  return !isDefined(self.cannotbesuspended);
}

_issuspendedvehicle() {
  return istrue(self.issuspended);
}

getvehiclecount() {
  return level.vehiclecount;
}

getsuspendedvehiclecount() {
  return level.suspendedvehiclecount;
}

reservevehicle(var_0) {
  if(canspawnVehicle()) {
    if(!isDefined(var_0)) {
      level.vehiclecount++;
      return 1;
    }

    var_1 = level.maxvehiclecount - (level.vehiclecount - level.suspendedvehiclecount);

    if(var_0 <= var_1) {
      level.vehiclecount = level.vehiclecount + var_0;
      return 1;
    }
  }

  return 0;
}

clearvehiclereservation(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  level.vehiclecount = level.vehiclecount - var_0;
  level.vehiclecount = int(max(0, level.vehiclecount));
}

getvehiclespawndata(var_0) {
  return var_0.spawndata;
}

copyvehiclespawndata(var_0, var_1) {
  var_1.modelname = var_0.modelname;
  var_1.targetname = var_0.targetname;
  var_1.vehicletype = var_0.vehicletype;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.owner = var_0.owner;
  var_1.initialvelocity = var_0.initialvelocity;
  var_1.cannotbesuspended = var_0.cannotbesuspended;
  var_1.startsuspended = var_0.startsuspended;
  var_1.spawntype = var_0.spawntype;
  var_1.team = var_0.team;
  var_1.usealtmodel = var_0.usealtmodel;
}

vehicle_tracking_registerinstance(var_0, var_1, var_2) {
  vehicle_tracking_deregisterinstance(var_0);
  level.vehicle.instances[var_0.vehiclename][var_0 getentitynumber()] = var_0;
  var_0.vehicleowner = undefined;

  if(isDefined(var_1))
    var_0.vehicleowner = var_1;

  var_0.vehicleteam = undefined;

  if(isDefined(var_2))
    var_0.vehicleteam = var_2;
}

vehicle_tracking_deregisterinstance(var_0) {
  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.instances)) {
    return;
  }
  if(!isDefined(level.vehicle.instances[var_0.vehiclename])) {
    return;
  }
  level.vehicle.instances[var_0.vehiclename][var_0 getentitynumber()] = undefined;

  if(level.vehicle.instances[var_0.vehiclename].size <= 0)
    level.vehicle.instances[var_0.vehiclename] = undefined;

  var_0.vehicleowner = undefined;
  var_0.vehicleteam = undefined;
}

vehicle_tracking_limitgameinstances(var_0, var_1, var_2) {
  level.vehicle.instancelimits[var_0] = var_1;
  level.vehicle.instancelimitmessages[var_0] = var_2;
}

vehicle_tracking_limitownerinstances(var_0, var_1, var_2) {
  level.vehicle.ownerinstancelimits[var_0] = var_1;
  level.vehicle.ownerinstancelimitmessages[var_0] = var_2;
}

vehicle_tracking_limitteaminstances(var_0, var_1, var_2) {
  level.vehicle.teaminstancelimits[var_0] = var_1;
  level.vehicle.teaminstancelimitmessages[var_0] = var_2;
}

vehicle_tracking_atinstancelimit(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.instances[var_0]))
    return 0;

  var_4 = level.vehicle.instancelimits[var_0];

  if(isDefined(var_4)) {
    if(isDefined(level.vehicle.instances[var_0]) && level.vehicle.instances[var_0].size >= var_4)
      return 1;
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_5 = level.vehicle.ownerinstancelimits[var_0];
    var_6 = 0;
  }

  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_2)) {
    var_7 = level.vehicle.teaminstancelimits[var_0];
    var_8 = 0;
  }

  if(!isDefined(var_5) && !isDefined(var_7))
    return 0;

  foreach(var_10 in level.vehicle.instances[var_0]) {
    if(isDefined(var_5) && isDefined(var_10.vehicleowner) && var_10.vehicleowner == var_1) {
      var_6++;

      if(var_6 >= var_5)
        return 1;
    }

    if(isDefined(var_7) && isDefined(var_10.vehicleteam) && var_10.vehicleteam == var_2) {
      var_8++;

      if(var_8 >= var_7)
        return 1;
    }
  }

  return 0;
}

vehicle_tracking_getgameinstances(var_0) {
  if(!isDefined(level.vehicle.instances[var_0]))
    return [];

  return level.vehicle.instances[var_0];
}

vehicle_tracking_getownerinstances(var_0, var_1) {
  if(!isDefined(level.vehicle.instances[var_0]))
    return [];

  var_2 = [];

  foreach(var_4 in level.vehicle.instances[var_0]) {
    if(isDefined(var_4.vehicleowner) && var_4.vehicleowner == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

vehicle_tracking_getteaminstances(var_0, var_1) {
  if(!isDefined(level.vehicle.instances[var_0]))
    return [];

  var_2 = [];

  foreach(var_4 in level.vehicle.instances[var_0]) {
    if(isDefined(var_4.vehicleteam) && var_4.vehicleteam == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

vehicle_tracking_getgameinstancesforall() {
  if(!isDefined(level.vehicle.instances))
    return [];

  var_0 = [];

  foreach(var_2 in level.vehicle.instances) {
    foreach(var_4 in var_2)
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

vehicle_tracking_instancesarelimited(var_0) {
  if(isDefined(level.vehicle.instancelimits[var_0]))
    return 1;

  if(isDefined(level.vehicle.ownerinstancelimits[var_0]))
    return 1;

  if(isDefined(level.vehicle.teaminstancelimits[var_0]))
    return 1;

  return 0;
}

vehicle_tracking_init() {
  level.vehicle.instances = [];
  level.vehicle.instancelimits = [];
  level.vehicle.ownerinstancelimits = [];
  level.vehicle.teaminstancelimits = [];
  level.vehicle.instancelimitmessages = [];
  level.vehicle.ownerinstancelimitmessages = [];
  level.vehicle.teaminstancelimitmessages = [];
  level.vehiclecount = 0;
  level.suspendedvehiclecount = 0;
  level.maxvehiclecount = getdvarint("_encstr_A99914DE0BA386AB2EFB31A012C46F38579368556EC3", 128);
  level.suspendedvehicles = [];
}