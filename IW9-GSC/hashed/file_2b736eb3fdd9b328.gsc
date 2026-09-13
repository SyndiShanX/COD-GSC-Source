/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2b736eb3fdd9b328.gsc
***********************************************/

_id_A9E26388B8DC22B3() {
  level._id_AD58C9C70A5DB5BB = [];
  scripts\mp\flags::gameflaginit("vehicle_patrol_paths_selected", 0);
  level._id_5731A15ECC971A53 = getdvarint("dvar_71A6A8A8255B301F", 30);
  _id_E8F728E3350D6B62 = 1;

  for(;;) {
    _id_F1A894F81AD453AF = scripts\engine\utility::getStructArray("vehiclePatrol_" + _id_E8F728E3350D6B62, "script_noteworthy");

    if(_id_F1A894F81AD453AF.size == 0) {
      break;
    }

    level._id_AD58C9C70A5DB5BB[level._id_AD58C9C70A5DB5BB.size] = _id_48814951E916AF89::_id_09EDCF99159ABB0B(_id_F1A894F81AD453AF[0], 1);
    _id_E8F728E3350D6B62++;
  }

  _id_7BB5DAF93766FB3D();
}

_id_7BB5DAF93766FB3D() {
  level._id_F2C3218EC87BA30F = [];

  switch (level.mapname) {
    case "mp_saba":
    case "mp_saba_pm":
    case "mp_saba2":
      groups = [[0], [1], [2, 3, 4], [5, 6, 7], [5, 8, 9], [10]];

      foreach(group in groups) {
        _id_A82AF88AA7F18B2C = 0;

        foreach(_id_80EF668C09FFB70F in group) {
          if(isDefined(level._id_F2C3218EC87BA30F[_id_80EF668C09FFB70F])) {
            _id_A82AF88AA7F18B2C = 1;
            break;
          }
        }

        if(_id_A82AF88AA7F18B2C) {
          continue;
        }
        _id_62E50AD3144802A8 = scripts\engine\utility::random(group);

        if(isDefined(level._id_AD58C9C70A5DB5BB[_id_62E50AD3144802A8]))
          level._id_F2C3218EC87BA30F[_id_62E50AD3144802A8] = 1;
      }

      break;
    default:
      foreach(_id_E8F728E3350D6B62, _id_305797971B8E8DBA in level._id_AD58C9C70A5DB5BB)
      level._id_F2C3218EC87BA30F[_id_E8F728E3350D6B62] = 1;

      break;
  }

  level._id_9E7ADB59A0CB3E3D = [];

  foreach(_id_AC0E594AC96AA3A8, pathstruct in level._id_AD58C9C70A5DB5BB) {
    if(!isDefined(level._id_F2C3218EC87BA30F[_id_AC0E594AC96AA3A8]))
      level._id_9E7ADB59A0CB3E3D[level._id_9E7ADB59A0CB3E3D.size] = pathstruct;
  }

  scripts\mp\flags::gameflagset("vehicle_patrol_paths_selected");
}

_id_CBAE2BD62D2E7086() {
  foreach(_id_E8F728E3350D6B62, value in level._id_F2C3218EC87BA30F)
  _id_8263F9488230C012(level._id_AD58C9C70A5DB5BB[_id_E8F728E3350D6B62], _id_E8F728E3350D6B62, "veh9_techo_rebel_armor");

  _id_F228E29AE46B2FE6 = 0;

  if(!_id_F228E29AE46B2FE6)
    level._id_AD58C9C70A5DB5BB = undefined;
  else {
    foreach(_id_E8F728E3350D6B62, _id_305797971B8E8DBA in level._id_AD58C9C70A5DB5BB)
    _id_305797971B8E8DBA.spawned = isDefined(level._id_F2C3218EC87BA30F[_id_E8F728E3350D6B62]);
  }
}

_id_8263F9488230C012(_id_305797971B8E8DBA, _id_E8F728E3350D6B62, vehicletype) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1(vehicletype)) {
    return;
  }
  _id_305797971B8E8DBA.direction = scripts\engine\utility::cointoss() * 2 - 1;
  _id_305797971B8E8DBA.index = randomint(_id_305797971B8E8DBA.path.size);
  _id_82CD8D2BC3998D62 = _id_305797971B8E8DBA.path[_id_305797971B8E8DBA.index];

  if(isDefined(level._id_A22353E84020888D)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_305797971B8E8DBA.path.size - 1; _id_AC0E594AC96AA3A8++) {
      _id_305797971B8E8DBA.index = (_id_305797971B8E8DBA.index + 1) % _id_305797971B8E8DBA.path.size;
      _id_82CD8D2BC3998D62 = _id_305797971B8E8DBA.path[_id_305797971B8E8DBA.index];
      _id_67E2C244A6E8D0BF = sortbydistance(level._id_A22353E84020888D, _id_82CD8D2BC3998D62.origin)[0];

      if(distance(_id_67E2C244A6E8D0BF.origin, _id_82CD8D2BC3998D62.origin) > 4000) {
        break;
      }
    }
  }

  _id_C5E7FCE963586EC0 = _id_82CD8D2BC3998D62.origin;
  vehicle = _id_3BDD3D9028BADA3F(_id_C5E7FCE963586EC0, _id_82CD8D2BC3998D62.angles, _id_305797971B8E8DBA.direction, vehicletype, _id_E8F728E3350D6B62);

  if(!isDefined(vehicle)) {
    return;
  }
  if(_id_48814951E916AF89::_id_8B178E05801F2DAF(_id_305797971B8E8DBA.path)) {
    foreach(rider in vehicle.riders)
    _id_48814951E916AF89::_id_C9B9FE3F7F739586(rider);
  }

  if(!isDefined(level._id_A22353E84020888D))
    level._id_A22353E84020888D = [];

  level._id_A22353E84020888D[level._id_A22353E84020888D.size] = _id_82CD8D2BC3998D62;
  vehicle _id_4BAC13D511590220::_id_1DA2C31423C2676A(level._id_5731A15ECC971A53);
  vehicle _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  vehicle _meth_77320E794D35465A("p2p", "goalThreshold", level._id_5731A15ECC971A53 * 4);
  vehicle _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  vehicle _meth_77320E794D35465A("p2p", "stuckTime", 4.0);
  vehicle._id_305797971B8E8DBA = _id_305797971B8E8DBA;
  vehicle thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(_id_305797971B8E8DBA, level._id_5731A15ECC971A53, ::_id_8667FF5C61E579ED);
  vehicle thread _id_205A864C4DDDC0EA(_id_305797971B8E8DBA);
}

_id_3BDD3D9028BADA3F(origin, angles, direction, vehicletype, _id_E8F728E3350D6B62) {
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin);

  if(!_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_171F90B9C4C76D44)) {
    return;
  }
  _id_8E5A9B658FA525ED = _id_48814951E916AF89::_id_BED4C95709497A6C(origin, undefined, _id_171F90B9C4C76D44);
  team = _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC(_id_8E5A9B658FA525ED);
  _id_B4D3F717373AF2BB = _id_1C47017BA325709A::_id_236A093E8A0EC040(vehicletype);
  spawners = _id_1C47017BA325709A::_id_F260B1CEF943F1AB(vehicletype, 5, _id_B4D3F717373AF2BB, origin, _id_171F90B9C4C76D44, "medium", undefined, _id_8E5A9B658FA525ED);
  riders = _id_1C47017BA325709A::_id_4AD6C25D6754F697(spawners, 5, undefined, "medium", "vehiclePatrol", "patrol_" + _id_E8F728E3350D6B62, team, undefined, vehicletype);

  if(!isDefined(riders) || riders.size == 0) {
    return;
  }
  foreach(rider in riders)
  rider._id_C7845D939C783CEF = 1;

  spawndata = spawnStruct();
  spawndata.origin = origin;
  spawndata.angles = scripts\engine\utility::ter_op(direction > 0, angles, angles + (0, 180, 0));
  spawndata.spawntype = "GAME_MODE";
  spawndata.team = team;
  spawndata.showheadicon = 1;
  spawndata._id_F16652E1462A3739 = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicletype, spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle)) {
    return;
  }
  vehicle._id_EB504FC7E1CFEB4C = getdvarint("dvar_9E4FFF9024BD3A06", 1);
  waitframe();
  vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);

  if(isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = vehicle;

  return vehicle;
}

_id_205A864C4DDDC0EA(_id_305797971B8E8DBA) {
  self endon("death");

  while(!isDefined(self._id_FE321E008E65C319))
    waitframe();

  self._id_D833F36F7BB5BF66 = self.origin;
  self._id_84FB7053AB953427 = gettime();
  self._id_3D3DBB75643CCE31 = 1;
  _id_1F328B9BEBD73213 = gettime();
  lasthealth = self.health;

  foreach(rider in self.riders)
  thread _id_9EC2524E968C9EB2(rider, rider == self._id_FE321E008E65C319);

  while(!istrue(self._id_05B28EB17C0B5497)) {
    if(isDefined(self._id_3D3DBB75643CCE31) && self._id_3D3DBB75643CCE31 <= 0 || lasthealth - self.health > 25) {
      thread _id_AB0EE2215EB51DD5("combat");
      return;
    }

    if(gettime() - _id_1F328B9BEBD73213 > 3000.0) {
      _id_1F328B9BEBD73213 = gettime();
      lasthealth = self.health;
    }

    if(distancesquared(self.origin, self._id_D833F36F7BB5BF66) > 22500) {
      self._id_84FB7053AB953427 = gettime();
      self._id_D833F36F7BB5BF66 = self.origin;
    } else if(gettime() - self._id_84FB7053AB953427 > 12000 || isDefined(self._id_76A498119F4D69BC) && _id_1174ABEDBEFE9ADA::_id_26879895DB23C779(self._id_76A498119F4D69BC))
      _id_8667FF5C61E579ED();

    waitframe();
  }
}

_id_9EC2524E968C9EB2(rider, _id_17915DB3DE174953) {
  self endon("death");
  self endon("unloaded");
  rider waittill("death");

  if(!isDefined(self) || !isDefined(self._id_3D3DBB75643CCE31)) {
    return;
  }
  self._id_3D3DBB75643CCE31 = self._id_3D3DBB75643CCE31 - scripts\engine\utility::ter_op(_id_17915DB3DE174953, 2, 1);
}

_id_8667FF5C61E579ED() {
  if(isDefined(self._id_9C986F0FA4FCE8EA) && gettime() - self._id_9C986F0FA4FCE8EA > 10000) {
    thread _id_AB0EE2215EB51DD5();
    return;
  }

  self._id_9C986F0FA4FCE8EA = gettime();
  self._id_84FB7053AB953427 = gettime();
  self._id_D833F36F7BB5BF66 = self.origin;
  self._id_305797971B8E8DBA.direction = self._id_305797971B8E8DBA.direction * -1;
  _id_4BAC13D511590220::_id_E8730CC0C5EAC096(self._id_305797971B8E8DBA);
  thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(self._id_305797971B8E8DBA, level._id_5731A15ECC971A53, ::_id_8667FF5C61E579ED);
}

_id_865676E356A22103() {
  return distancesquared(self.origin, getclosestpointonnavmesh(self.origin)) < 10000;
}

_id_AB0EE2215EB51DD5(exittype) {
  self._id_9C986F0FA4FCE8EA = undefined;
  self._id_84FB7053AB953427 = undefined;
  self._id_D833F36F7BB5BF66 = undefined;
  self._id_305797971B8E8DBA = undefined;
  self._id_3D3DBB75643CCE31 = undefined;
  self._id_05B28EB17C0B5497 = 1;
  self notify("newFollowPath");

  if(!_id_865676E356A22103()) {
    self.burndowntime = 4;
    scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
    return;
  }

  self endon("death");
  _id_24E4405CF93F20ED::_id_7D8F81A94DC08A15(1, exittype);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}