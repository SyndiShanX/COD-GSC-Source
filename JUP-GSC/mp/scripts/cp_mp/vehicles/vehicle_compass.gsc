/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_compass.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace vehicle_compass;

function vehicle_compass_registerinstance(vehicle) {
  leveldata = vehicle_compass_getleveldata();
  leveldata.instances[vehicle getentitynumber()] = vehicle;
  vehicle_compass_show(vehicle);
}

function vehicle_compass_deregisterinstance(vehicle) {
  leveldata = vehicle_compass_getleveldata();
  leveldata.instances[vehicle getentitynumber()] = undefined;
}

function vehicle_compass_instanceisregistered(vehicle) {
  leveldata = vehicle_compass_getleveldata();
  return isDefined(leveldata.instances[vehicle getentitynumber()]) && leveldata.instances[vehicle getentitynumber()] == vehicle;
}

function vehicle_compass_updatevisibilityforplayer(vehicle, player, var_6ecb77fd1f27c667) {
  leveldata = vehicle_compass_getleveldata();

  if(!leveldata.visibilityisscriptcontrolled) {
    return;
  }

  if(!isDefined(vehicle)) {
    return;
  }

  if(!vehicle_compass_instanceisregistered(vehicle)) {
    if(!istrue(var_6ecb77fd1f27c667)) {
      assertmsg("<dev string:x1c>");
    }

    return;
  }

  if(!vehicle_compass_shouldbevisibletoplayer(vehicle, player)) {
    vehicle vehicleshowonminimapforclient(player, 0);
    return;
  }

  vehicle vehicleshowonminimapforclient(player, 1);
}

function vehicle_compass_updatevisibilityforallplayers(vehicle, var_6ecb77fd1f27c667) {
  leveldata = vehicle_compass_getleveldata();

  if(!leveldata.visibilityisscriptcontrolled) {
    return;
  }

  if(!vehicle_compass_instanceisregistered(vehicle)) {
    if(!istrue(var_6ecb77fd1f27c667)) {
      assertmsg("<dev string:x6e>");
    }

    return;
  }

  foreach(player in level.players) {
    vehicle_compass_updatevisibilityforplayer(vehicle, player);
  }
}

function vehicle_compass_updateallvisibilityforplayer(player) {
  leveldata = vehicle_compass_getleveldata();

  if(!istrue(leveldata.visibilityisscriptcontrolled)) {
    return;
  }

  foreach(instance in leveldata.instances) {
    vehicle_compass_updatevisibilityforplayer(instance, player);
  }
}

function vehicle_compass_shouldbevisibletoplayer(vehicle, player) {
  if(issharedfuncdefined("vehicle_compass", "shouldBeVisibleToPlayer")) {
    shouldbevisibletoplayer = [[getsharedfunc("vehicle_compass", "shouldBeVisibleToPlayer")]](vehicle, player);

    if(isDefined(shouldbevisibletoplayer)) {
      return shouldbevisibletoplayer;
    }
  }

  return 1;
}

function vehicle_compass_show(vehicle) {
  leveldata = vehicle_compass_getleveldata();

  if(leveldata.visibilityisscriptcontrolled) {
    vehicle vehicleshowonminimap(1);
  }

  if(isDefined(leveldata.instances[vehicle getentitynumber()])) {
    if(level.teambased) {
      vehicle_compass_setteamfriendlyto(vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(vehicle));
    } else {
      vehicle_compass_setplayerfriendlyto(vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getplayerfriendlyto(vehicle));
    }

    vehicle_compass_updatevisibilityforallplayers(vehicle, 1);
  }
}

function vehicle_compass_hide(vehicle) {
  leveldata = vehicle_compass_getleveldata();
  leveldata.instances[vehicle getentitynumber()] = undefined;

  if(leveldata.visibilityisscriptcontrolled) {
    vehicle vehicleshowonminimap(0);
  }
}

function vehicle_compass_setteamfriendlyto(vehicle, team) {
  if(iscp()) {
    var_1e5f7ff00358bc18 = isDefined(vehicle.riders) && vehicle.riders.size > 0 || isDefined(vehicle.runningtovehicle) && vehicle.runningtovehicle.size > 0;

    if(!isDefined(team) || team == "neutral" || istrue(vehicle.isempty) && !var_1e5f7ff00358bc18) {
      team = "none";
    }
  } else if(!isDefined(team) || team == "neutral") {
    team = "none";
  }

  vehicle setvehicleteam(team);
}

function vehicle_compass_setplayerfriendlyto(vehicle, player) {
  vehicle setentityowner(undefined);
}

function vehicle_compass_init() {
  assertex(isDefined(level.vehicle), "<dev string:xc4>");
  assertex(!isDefined(level.vehicle.compass), "<dev string:xfc>");
  leveldata = spawnStruct();
  level.vehicle.compass = leveldata;
  leveldata.instances = [];
  runleanthreadmode = 0;

  if(issharedfuncdefined("game", "runLeanThreadMode")) {
    runleanthreadmode = [[getsharedfunc("game", "runLeanThreadMode")]]();
  }

  leveldata.visibilityisscriptcontrolled = !runleanthreadmode || getdvarint(@ "hash_61d6ab22f59b15a6", 0) > 0;

  if(issharedfuncdefined("vehicle_compass", "init")) {
    [[getsharedfunc("vehicle_compass", "init")]]();
  }
}

function vehicle_compass_getleveldata() {
  assertex(isDefined(level.vehicle.compass), "<dev string:x132>");
  return level.vehicle.compass;
}

function vehicle_compass_friendlystatuschangedcallback(vehicle, var_965ea26e6eb230b9, var_52312180ef1940be) {
  leveldata = vehicle_compass_getleveldata();
  isregistered = isDefined(leveldata.instances[vehicle getentitynumber()]) && leveldata.instances[vehicle getentitynumber()] == vehicle;

  if(!isregistered) {
    return;
  }

  if(level.teambased) {
    vehicle_compass_setteamfriendlyto(vehicle, var_52312180ef1940be);
  } else {
    vehicle_compass_setplayerfriendlyto(vehicle, var_52312180ef1940be);
  }

  vehicle_compass_updatevisibilityforallplayers(vehicle);
}

function vehicle_compass_playerjoinedteamcallback(player) {
  if(!level.teambased) {
    return;
  }

  vehicle_compass_updateallvisibilityforplayer(player);
}

function vehicle_compass_playerspawnedcallback() {
  vehicle_compass_updateallvisibilityforplayer(self);
}