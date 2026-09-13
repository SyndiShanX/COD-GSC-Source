/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_compass.gsc
******************************************************/

vehicle_compass_registerinstance(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();
  _id_962A30A9BB8C0F09.instances[vehicle getentitynumber()] = vehicle;
  vehicle_compass_show(vehicle);
}

vehicle_compass_deregisterinstance(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();
  _id_962A30A9BB8C0F09.instances[vehicle getentitynumber()] = undefined;
}

vehicle_compass_instanceisregistered(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();
  return isDefined(_id_962A30A9BB8C0F09.instances[vehicle getentitynumber()]) && _id_962A30A9BB8C0F09.instances[vehicle getentitynumber()] == vehicle;
}

vehicle_compass_updatevisibilityforplayer(vehicle, player, _id_6ECB77FD1F27C667) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();

  if(!_id_962A30A9BB8C0F09.visibilityisscriptcontrolled) {
    return;
  }
  if(!vehicle_compass_instanceisregistered(vehicle)) {
    if(!istrue(_id_6ECB77FD1F27C667)) {}
  } else {
    if(!vehicle_compass_shouldbevisibletoplayer(vehicle, player)) {
      vehicle vehicleshowonminimapforclient(player, 0);
      return;
    }

    vehicle vehicleshowonminimapforclient(player, 1);
  }
}

vehicle_compass_updatevisibilityforallplayers(vehicle, _id_6ECB77FD1F27C667) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();

  if(!_id_962A30A9BB8C0F09.visibilityisscriptcontrolled) {
    return;
  }
  if(!vehicle_compass_instanceisregistered(vehicle)) {
    if(!istrue(_id_6ECB77FD1F27C667)) {}

    return;
  }

  foreach(player in level.players)
  vehicle_compass_updatevisibilityforplayer(vehicle, player);
}

vehicle_compass_updateallvisibilityforplayer(player) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();

  if(!istrue(_id_962A30A9BB8C0F09.visibilityisscriptcontrolled)) {
    return;
  }
  foreach(instance in _id_962A30A9BB8C0F09.instances)
  vehicle_compass_updatevisibilityforplayer(instance, player);
}

vehicle_compass_shouldbevisibletoplayer(vehicle, player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "shouldBeVisibleToPlayer")) {
    _id_B152AAEF134979F3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "shouldBeVisibleToPlayer")]](vehicle, player);

    if(isDefined(_id_B152AAEF134979F3))
      return _id_B152AAEF134979F3;
  }

  return 1;
}

vehicle_compass_show(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();

  if(_id_962A30A9BB8C0F09.visibilityisscriptcontrolled)
    vehicle vehicleshowonminimap(1);

  if(isDefined(_id_962A30A9BB8C0F09.instances[vehicle getentitynumber()])) {
    if(level.teambased)
      vehicle_compass_setteamfriendlyto(vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(vehicle));
    else
      vehicle_compass_setplayerfriendlyto(vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getplayerfriendlyto(vehicle));

    vehicle_compass_updatevisibilityforallplayers(vehicle, 1);
  }
}

vehicle_compass_hide(vehicle) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();
  _id_962A30A9BB8C0F09.instances[vehicle getentitynumber()] = undefined;

  if(_id_962A30A9BB8C0F09.visibilityisscriptcontrolled)
    vehicle vehicleshowonminimap(0);
}

vehicle_compass_setteamfriendlyto(vehicle, team) {
  if(!isDefined(team) || team == "neutral")
    team = "none";

  vehicle setvehicleteam(team);
}

vehicle_compass_setplayerfriendlyto(vehicle, player) {
  vehicle setentityowner(undefined);
}

vehicle_compass_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.compass = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.instances = [];
  runleanthreadmode = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "runLeanThreadMode"))
    runleanthreadmode = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "runLeanThreadMode")]]();

  _id_962A30A9BB8C0F09.visibilityisscriptcontrolled = !runleanthreadmode || getdvarint("dvar_61D6AB22F59B15A6", 0) > 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "init")]]();
}

vehicle_compass_getleveldata() {
  return level.vehicle.compass;
}

vehicle_compass_friendlystatuschangedcallback(vehicle, _id_965EA26E6EB230B9, _id_52312180EF1940BE) {
  _id_962A30A9BB8C0F09 = vehicle_compass_getleveldata();
  isregistered = isDefined(_id_962A30A9BB8C0F09.instances[vehicle getentitynumber()]) && _id_962A30A9BB8C0F09.instances[vehicle getentitynumber()] == vehicle;

  if(!isregistered) {
    return;
  }
  if(level.teambased)
    vehicle_compass_setteamfriendlyto(vehicle, _id_52312180EF1940BE);
  else
    vehicle_compass_setplayerfriendlyto(vehicle, _id_52312180EF1940BE);

  vehicle_compass_updatevisibilityforallplayers(vehicle);
}

vehicle_compass_playerjoinedteamcallback(player) {
  if(!level.teambased) {
    return;
  }
  vehicle_compass_updateallvisibilityforplayer(player);
}

vehicle_compass_playerspawnedcallback() {
  vehicle_compass_updateallvisibilityforplayer(self);
}