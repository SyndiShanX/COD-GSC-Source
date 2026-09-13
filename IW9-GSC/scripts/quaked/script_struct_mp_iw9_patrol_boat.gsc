/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_patrol_boat.gsc
***************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_patrol_boat", ::_id_29E4F7F70CA401CD);
}

_id_29E4F7F70CA401CD() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_patrol_boat") && scripts\engine\utility::getStructArray("rallyPointArmoredBoat", "targetname").size == 0) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::_id_A9F9F7C43BC42523;
  callbacks["delete"] = ::_id_CA15FC21EFE0FE30;
  callbacks["enterEnd"] = ::_id_856261B9790625F4;
  callbacks["exitEnd"] = ::_id_2815D461CA70AD30;
  callbacks["exitExternalTurret"] = ::_id_9F3F1229CC69710E;

  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsabandonedtimeout(0)) {
    callbacks["onStartRiding"] = ::_id_7C412BAFA5521937;
    callbacks["onEndRiding"] = ::_id_C3AA4B60C1E04C3A;
  }

  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_patrol_boat", callbacks);
}

_id_A9F9F7C43BC42523(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_patrol_boat", spawndata, _id_EE8DA5624236DC89);
  _id_42691F43DB8E6783 = _id_79BE42CA62B707DF();
  frontturret = _id_48F6DE7CCB60B042(vehicle, "iw9_mg_patrol_boat_front_mp", "veh9_mil_sea_armored_patrol_boat_turret", _id_42691F43DB8E6783.tag, _id_42691F43DB8E6783.tagoffset, _id_42691F43DB8E6783._id_7862C7C7ADE2B42E);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, frontturret, makeweapon("iw9_mg_patrol_boat_front_mp"));
  _id_42691F43DB8E6783 = _id_2D2C1E3CC60D4363();
  _id_536A5C2E42582B98 = _id_48F6DE7CCB60B042(vehicle, "iw9_mg_patrol_boat_back_mp", "veh9_mil_sea_armored_patrol_boat_turret", _id_42691F43DB8E6783.tag, _id_42691F43DB8E6783.tagoffset, _id_42691F43DB8E6783._id_7862C7C7ADE2B42E);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, _id_536A5C2E42582B98, makeweapon("iw9_mg_patrol_boat_back_mp"));
  return vehicle;
}

_id_79BE42CA62B707DF() {
  _id_42691F43DB8E6783 = spawnStruct();
  _id_42691F43DB8E6783.tag = "tag_turret_front";
  _id_42691F43DB8E6783.tagoffset = (0, 0, 0);
  _id_42691F43DB8E6783._id_7862C7C7ADE2B42E = (138, 0, 16.5);
  return _id_42691F43DB8E6783;
}

_id_2D2C1E3CC60D4363() {
  _id_42691F43DB8E6783 = spawnStruct();
  _id_42691F43DB8E6783.tag = "tag_turret_back";
  _id_42691F43DB8E6783.tagoffset = (0, 0, 0);
  _id_42691F43DB8E6783._id_7862C7C7ADE2B42E = (-100, 0, 6.9);
  return _id_42691F43DB8E6783;
}

_id_48F6DE7CCB60B042(vehicle, turret_weapon, _id_076BA9E808A42F81, _id_7FD2FB13F979337C, _id_F7C8FC384585FA86, _id_721F077D971E21D5) {
  turret = spawnturret("misc_turret", vehicle gettagorigin(_id_7FD2FB13F979337C), turret_weapon, 0);
  turret linkTo(vehicle, _id_7FD2FB13F979337C, _id_F7C8FC384585FA86, (0, 0, 0));
  turret setModel(_id_076BA9E808A42F81);
  turret makeunusable();
  turret setmode("sentry_offline");
  turret setdefaultdroppitch(30);
  turret setturretmodechangewait(1);
  _id_963953C3478BF4FE = turret gettagorigin("j_trigger");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "createHint"))
    turret.useobject = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "createHint")]](_id_963953C3478BF4FE, "HINT_BUTTON", undefined, &"VEHICLES_HINTS/USE_TURRET", -1, "duration_none", "show", 75, undefined, 75);

  turret.useobject linkTo(turret, "j_trigger");
  turret thread _id_C9DE15B664D15414(turret.useobject, vehicle, turret_weapon, _id_7FD2FB13F979337C);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  turret.maxhealth = 400;
  turret.health = turret.maxhealth;
  turret._id_9F925F5509626DF1 = _id_721F077D971E21D5;
  return turret;
}

_id_C9DE15B664D15414(_id_EF5D5141FDB51174, vehicle, turretweapon, _id_7FD2FB13F979337C) {
  self endon("kill_turret");
  level endon("game_ended");

  foreach(player in level.players)
  _id_EF5D5141FDB51174 enableplayeruse(player);

  thread _id_0E1AAFDF0A17A411(_id_EF5D5141FDB51174);

  for(;;) {
    _id_EF5D5141FDB51174 waittill("trigger", player);

    if(istrue(self.inuse)) {
      continue;
    }
    if(player isonladder() || !player isonground() || player ismantling() || istrue(player.isjuggernaut) || istrue(player._id_859654E0445A36D9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("VEHICLES/CANNOT_ENTER_TURRET");

      continue;
    }

    self.inuse = 1;
    _id_EF5D5141FDB51174 _meth_DFB78B3E724AD620(0);
    vehicle scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_hidecashbag(vehicle, undefined, player);
    player _meth_5847240C0F9900F2(0);
    weapon = undefined;

    if(turretweapon == "iw9_mg_patrol_boat_front_mp")
      weapon = "iw9_mg_patrol_boat_front_mp";
    else
      weapon = "iw9_mg_patrol_boat_back_mp";

    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deleteseatcorpse(vehicle, _id_7FD2FB13F979337C, 1);
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_D2D9C09551D91164(vehicle, player);
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, weapon);
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, scripts\engine\utility::ter_op(istrue(turret._id_ECC491F42AACEAF4), 850, 2200));
    turret._id_ECC491F42AACEAF4 = 1;
    scripts\cp_mp\vehicles\vehicle::_id_160EF1C877C69AB1(player, vehicle, self, _id_7FD2FB13F979337C);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, weapon);
    scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onentervehicle(vehicle, player);
    turret thread _id_3F2282EB0126C0C0(player);
    turret thread _id_7B4C271E2969F029(player, vehicle);
    turret thread _id_919347C984DC1CED(player, vehicle);
    turret thread _id_9D875E9CD4A8B235(player, vehicle);
  }
}

_id_0E1AAFDF0A17A411(useobj) {
  if(isDefined(self))
    self endon("kill_turret");

  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    useobj enableplayeruse(player);
  }
}

_id_7B4C271E2969F029(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");
  _id_71982E9B7E15C211 = 10000;

  if(isDefined(self.moving_platform))
    _id_71982E9B7E15C211 = 10000;

  for(;;) {
    if(player isinexecutionvictim() || distancesquared(self.origin, player.origin) >= _id_71982E9B7E15C211) {
      thread _id_9F3F1229CC69710E(player, vehicle);
      break;
    }

    waitframe();
  }
}

_id_919347C984DC1CED(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");

  while(player useButtonPressed())
    waitframe();

  for(;;) {
    if(player useButtonPressed()) {
      thread _id_9F3F1229CC69710E(player, vehicle);
      break;
    }

    waitframe();
  }
}

_id_9D875E9CD4A8B235(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");
  thread _id_9F3F1229CC69710E(player, vehicle);
}

_id_3F2282EB0126C0C0(player) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self.lastuserangles = player getplayerangles();
    waitframe();
  }
}

_id_9F3F1229CC69710E(player, vehicle) {
  self.inuse = 0;

  if(isDefined(player)) {
    player notify("end_turret_use");
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_showcashbag(vehicle, undefined, player);
    player _meth_5847240C0F9900F2(1);
  }

  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onexitvehicle(vehicle, player);
  scripts\cp_mp\vehicles\vehicle::_id_4D2324450A951B2B(player, vehicle);
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
  self.useobject _meth_DFB78B3E724AD620(1);

  if(isDefined(player)) {
    player enableturretdismount();
    player controlturretoff(self);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, self.objweapon.basename, spawnStruct(), 0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_5211953231A09ED5(vehicle, player);
  }

  self.owner = undefined;
  self setotherent(undefined);
  self setentityowner(undefined);

  if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive()) {
    player _meth_0A055801DA45D769(rotatevector(self._id_9F925F5509626DF1 + (randomfloatrange(-15, 20), randomfloatrange(-15, 20), 0), vehicle.angles) + vehicle.origin, vehicle);
    player setplayerangles(self.lastuserangles);
    thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
  }
}

_id_C1A88F4CA33E1836() {
  foreach(turret in scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(self)) {
    turret notify("kill_turret");

    if(isDefined(turret.owner))
      turret thread _id_9F3F1229CC69710E(turret.owner, self);

    scripts\cp_mp\vehicles\vehicle::vehicle_deregisterturret(self, turret.objweapon);
    turret.useobject delete();
    turret delete();
  }
}

_id_CA15FC21EFE0FE30(vehicle) {
  _id_C1A88F4CA33E1836();
}

_id_7C412BAFA5521937(player) {
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
}

_id_C3AA4B60C1E04C3A(player) {
  thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
}

_id_856261B9790625F4(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_43C2C433B8B9B12D(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);

  if(!istrue(data.success) || istrue(data.playerdisconnect) || !isDefined(player) || !istrue(vehicle.israllypointvehicle)) {
    return;
  }
  foreach(_id_B212D40302E8388D in level.players) {
    if(istrue(vehicle.revealed) || scripts\engine\utility::is_equal(_id_B212D40302E8388D.team, vehicle.team))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, _id_B212D40302E8388D);
  }

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, _id_F85572CD5F6117C6);

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, player);
}

_id_2815D461CA70AD30(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_857BF4201A249A99(vehicle, seatid, _id_7558F98F3236963D, player, data);

  if(!istrue(data.success) || istrue(data.playerdisconnect) || !isDefined(player) || !istrue(vehicle.israllypointvehicle)) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
}