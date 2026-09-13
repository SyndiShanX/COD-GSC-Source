/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest.gsc
*******************************************************/

_id_FB7271D5EE18B98D(data) {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::scavengerlootcacheused);
  level._id_CF05AFB32024800A = spawnStruct();
  level._id_CF05AFB32024800A.time = getdvarint("dvar_5802E08D3A73518F", 300);
  level._id_CF05AFB32024800A._id_697B16D5E1CB65E3 = getdvarint("dvar_1EAF2EF86C1344E8", 3);
  level._id_CF05AFB32024800A._id_76FBB523B032ED22 = getdvarint("dvar_40502E1CCC8AFEE2", 10000);
  level._id_CF05AFB32024800A._id_5E8448F4B9E71CB4 = getdvarint("dvar_6CF95A3CC8A2C6BC", 0);
  level._id_CF05AFB32024800A._id_B90DC65A569F4825 = getdvarint("dvar_0A438440CE7CE72C", 4000);
  level._id_CF05AFB32024800A._id_7F34783FC18F8A33 = getdvarint("dvar_8CE4DAAF96793442", 2000);
  level._id_CF05AFB32024800A._id_37143A4776FD671A = getdvarint("dvar_DAB0E9A1525B9075", 30);
  game["dialog"]["mission_scav_accept"] = "mission_mission_scav_accept";
  game["dialog"]["mission_scav_success"] = "mission_mission_scav_success";
  data.funcs["onInit"] = ::_id_591E6AB6447B07BE;
  data.funcs["onTeamAssigned"] = ::_id_F6F80C11D5D8EAF5;
  data.funcs["onCancel"] = ::_id_942D13E23C7F1D0E;
  data.funcs["circleTick"] = ::_id_A33BD2C069408596;
  data.funcs["onPlayerTearDown"] = ::_id_F9CA547E3935949D;
  data.funcs["onPlayerAssimilated"] = ::_id_24684569878C3021;
  _id_876794C543D6E89D();
}

_id_591E6AB6447B07BE() {
  if(!isDefined(self._id_3B1ED2AB5FEE3E31))
    return _id_549AB791FA91C7AC();

  if(!isDefined(level._id_CF05AFB32024800A._id_4570D7C903293186) && isDefined(level._id_5DBCAA3F26F4C1AB))
    level._id_CF05AFB32024800A._id_5DBCAA3F26F4C1AB = level._id_5DBCAA3F26F4C1AB;

  return 1;
}

_id_876794C543D6E89D() {
  game["dialog"]["scavenger_missionstart"] = "scvn_wzan_msst";
  game["dialog"]["scavenger_onesecured"] = "scvn_wzan_nscr";
  game["dialog"]["scavenger_twosecured"] = "scvn_wzan_wscr";
  game["dialog"]["scavenger_missioncomplete"] = "scvn_wzan_mssc";
  game["dialog"]["scavenger_almosttimeout"] = "gncn_wzan_mstw";
  game["dialog"]["scavenger_failed"] = "gncn_wzan_msfl";
  game["dialog"]["scavenger_timeout"] = "gncn_wzan_msto";
}

_id_549AB791FA91C7AC() {
  if(!isDefined(self._id_3B1ED2AB5FEE3E31))
    self._id_3B1ED2AB5FEE3E31 = [];

  if(!isDefined(self._id_003BB6053DB23449))
    self._id_003BB6053DB23449 = 0;

  _id_5680465E80D5127C = _id_9F225E14BFF0629F();

  if(!isDefined(_id_5680465E80D5127C))
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_CF05AFB32024800A._id_697B16D5E1CB65E3; _id_AC0E594AC96AA3A8++) {
    self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8] = spawnStruct();
    self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8]._id_2076A994E0E7C929 = _id_5680465E80D5127C[_id_AC0E594AC96AA3A8];
    self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8]._id_3B991F00E2E091E4 = 0;

    if(!isDefined(self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8]._id_2076A994E0E7C929)) {
      self._id_3B1ED2AB5FEE3E31 = undefined;
      return 0;
    }

    disablelootspawnpoint(self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8]._id_2076A994E0E7C929.index);
  }

  return 1;
}

_id_F6F80C11D5D8EAF5() {
  self.category = "scavenger";
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("scavenger", self.teams[0]);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  player _id_64ACB6CE534155B7::uiobjectivesetparameter(0);

  time = level._id_CF05AFB32024800A.time;
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time, 0);
  thread _id_01E6E0E374F59D3D();

  if(!isDefined(self._id_3B1ED2AB5FEE3E31)) {
    if(!_id_549AB791FA91C7AC())
      return 0;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_CF05AFB32024800A._id_697B16D5E1CB65E3; _id_AC0E594AC96AA3A8++) {
    _id_B038ED928EC17A81 = self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8]._id_2076A994E0E7C929;
    self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8].cacheentity = spawnscavengerlootcache(_id_B038ED928EC17A81.origin, _id_B038ED928EC17A81.angles);
    self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8] _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current", self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8].cacheentity.origin + (0, 0, 65));
    objective_removeallfrommask(self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8].objectiveiconid);
    objective_addteamtomask(self._id_3B1ED2AB5FEE3E31[_id_AC0E594AC96AA3A8].objectiveiconid, self.teams[0]);
  }

  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_scavenger_quest_start_team");
  _id_E9CFAB9C8A63533C("scavenger_missionstart", self.teams[0]);
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(self.teams[0], self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex("scavenger"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_scav_accept", self.teams[0], 1);
}

_id_A33BD2C069408596(_id_819EDACDACB810E4, _id_52D59C928EB97C81) {
  if(istrue(self._id_DF2A5E89C3BBA966)) {
    return;
  }
  foreach(_id_B038ED928EC17A81 in self._id_3B1ED2AB5FEE3E31) {
    if(!istrue(_id_B038ED928EC17A81._id_3B991F00E2E091E4) && isDefined(_id_B038ED928EC17A81.cacheentity)) {
      if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_B038ED928EC17A81.cacheentity.origin)) {
        if(!isDefined(_id_B038ED928EC17A81.cacheentity._id_ECAB0C87ADBF2D21))
          _id_B038ED928EC17A81.cacheentity._id_ECAB0C87ADBF2D21 = gettime() + scripts\engine\utility::_id_A5B14435E3229BED(level._id_CF05AFB32024800A._id_37143A4776FD671A);

        if(gettime() >= _id_B038ED928EC17A81.cacheentity._id_ECAB0C87ADBF2D21) {
          self._id_DF2A5E89C3BBA966 = 1;
          params = spawnStruct();
          params.intvar = 0;
          _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_scavenger_quest_timer_expired", params);
          _id_E9CFAB9C8A63533C("scavenger_timeout", self.teams[0]);
          level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.teams[0], 1);
          thread _id_810BBEDED8D1A801(0);
          return;
        }
      }
    }
  }
}

_id_F9CA547E3935949D(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(_id_8A04AA0E0755E7E3, level._id_41F4BC9EE8C7C9C6.defaultfilter))
      thread _id_942D13E23C7F1D0E(_id_8A04AA0E0755E7E3);
    else {
      hidescavengerhudfromplayer(player);

      foreach(_id_B038ED928EC17A81 in self._id_3B1ED2AB5FEE3E31)
      _id_B038ED928EC17A81.cacheentity disablescriptableplayeruse(player);
    }
  }
}

_id_24684569878C3021(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(self._id_3B1ED2AB5FEE3E31)) {
    return;
  }
  if(_id_EB06B338608EF354 == self.teams[0]) {
    _id_017E600057C2CF45(player);
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(self._id_003BB6053DB23449);

    foreach(_id_B038ED928EC17A81 in self._id_3B1ED2AB5FEE3E31)
    _id_B038ED928EC17A81.cacheentity enablescriptableplayeruse(player);
  }
}

_id_942D13E23C7F1D0E(team) {
  if(istrue(self.teams[0] == team)) {
    _id_810BBEDED8D1A801(0);
    _id_E9CFAB9C8A63533C("scavenger_failed", team);
  }
}

_id_810BBEDED8D1A801(success) {
  self notify("task_ended");
  self.ended = 1;
  deletescavengerhud();
  wait 1.0;
  _id_8ED931D61F597107();
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));
}

_id_8ED931D61F597107() {
  foreach(_id_B038ED928EC17A81 in self._id_3B1ED2AB5FEE3E31) {
    if(!istrue(_id_B038ED928EC17A81._id_3B991F00E2E091E4) && isDefined(_id_B038ED928EC17A81.cacheentity))
      _id_B038ED928EC17A81.cacheentity delete();
  }
}

_id_01E6E0E374F59D3D() {
  self endon("task_ended");
  level endon("game_ended");
  _id_0F1A9809EED7E8F0 = gettime();

  while(_id_0F1A9809EED7E8F0 < self.missiontime) {
    wait((self.missiontime - _id_0F1A9809EED7E8F0) / 1000.0);
    _id_0F1A9809EED7E8F0 = gettime();

    if(!istrue(self._id_1ADEC8CF65449059) && _id_0F1A9809EED7E8F0 >= self.missiontime * 0.67) {
      _id_E9CFAB9C8A63533C("scavenger_almosttimeout", self.teams[0]);
      self._id_1ADEC8CF65449059 = 1;
    }
  }

  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_scavenger_quest_timer_expired", params);
  _id_E9CFAB9C8A63533C("scavenger_timeout", self.teams[0]);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.teams[0], 1);
  thread _id_810BBEDED8D1A801(0);
}

_id_4C7A7DD83180DE41(_id_7A180981CE616EF4, _id_76045CF7C0669684, _id_AA9D61F3C51B6A77, _id_5D186451F21D7020, maxrange, _id_B1DC32F87ABAA507, _id_54EDA05E274DB345) {
  nodes = _id_7A180981CE616EF4;
  _id_5FAA3DB092440B70 = [];
  _id_72C980F7C0F679D7 = randomfloatrange(_id_B1DC32F87ABAA507, _id_54EDA05E274DB345);
  _id_FDC6EE1B91EBB7BF = undefined;

  if(!level.br_circle_disabled) {
    _id_527A7B84D978E792 = _id_58F20490049AF6AC::_id_60951B84C58915AB(_id_AA9D61F3C51B6A77);
    _id_FDC6EE1B91EBB7BF = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_527A7B84D978E792);
  }

  _id_06B50C4622758CC3 = undefined;
  _id_B88AA9CCEE86B6A3 = undefined;
  _id_6EA1418C4B1D7992 = undefined;

  foreach(_id_FE8F7703F6313ED4, node in _id_7A180981CE616EF4) {
    dist = abs(distance2d(_id_AA9D61F3C51B6A77, node.origin) - _id_72C980F7C0F679D7);

    if(!_id_A067541E078900A5(node, _id_AA9D61F3C51B6A77, dist, _id_5D186451F21D7020, maxrange, _id_FDC6EE1B91EBB7BF)) {
      continue;
    }
    if(!isDefined(_id_06B50C4622758CC3) || dist < _id_06B50C4622758CC3) {
      _id_06B50C4622758CC3 = dist;
      _id_B88AA9CCEE86B6A3 = node;
      _id_6EA1418C4B1D7992 = _id_FE8F7703F6313ED4;
    }
  }

  if(!isDefined(_id_B88AA9CCEE86B6A3))
    return undefined;

  _id_5FAA3DB092440B70[0] = _id_B88AA9CCEE86B6A3;
  _id_B88AA9CCEE86B6A3.inuse = 1;
  disablelootspawnpoint(_id_6EA1418C4B1D7992);

  if(_id_76045CF7C0669684 == 1)
    return _id_5FAA3DB092440B70;

  _id_DD557C73E4C85BC3 = _id_F469A8DCF7FFD6A8(_id_AA9D61F3C51B6A77, _id_B88AA9CCEE86B6A3.origin, _id_76045CF7C0669684);
  _id_5D384C5F9EB5FC55 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_76045CF7C0669684 - 1; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8 + 1;
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8] = spawnStruct();
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8].index = index;
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8].point = _id_DD557C73E4C85BC3[index];
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8]._id_06B50C4622758CC3 = undefined;
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8]._id_B88AA9CCEE86B6A3 = undefined;
    _id_5D384C5F9EB5FC55[_id_AC0E594AC96AA3A8]._id_6B64CC5A249331EF = undefined;
  }

  _id_CDF6A925ECDC141D = 100;

  foreach(_id_AE22245685C483AE in _id_5D384C5F9EB5FC55) {
    foreach(_id_FE8F7703F6313ED4, node in _id_7A180981CE616EF4) {
      dist = distance2d(_id_AE22245685C483AE.point, node.origin);

      if(!_id_A067541E078900A5(node, _id_AA9D61F3C51B6A77, dist, _id_5D186451F21D7020, maxrange, _id_FDC6EE1B91EBB7BF)) {
        continue;
      }
      if(!isDefined(_id_AE22245685C483AE._id_06B50C4622758CC3) || dist < _id_AE22245685C483AE._id_06B50C4622758CC3) {
        _id_AE22245685C483AE._id_06B50C4622758CC3 = dist;
        _id_AE22245685C483AE._id_B88AA9CCEE86B6A3 = node;
        _id_AE22245685C483AE._id_6B64CC5A249331EF = _id_FE8F7703F6313ED4;

        if(dist <= _id_CDF6A925ECDC141D) {
          break;
        }
      }
    }

    if(!isDefined(_id_AE22245685C483AE.index) || !isDefined(_id_AE22245685C483AE._id_B88AA9CCEE86B6A3))
      return undefined;

    _id_5FAA3DB092440B70[_id_AE22245685C483AE.index] = _id_AE22245685C483AE._id_B88AA9CCEE86B6A3;
    _id_AE22245685C483AE._id_B88AA9CCEE86B6A3.inuse = 1;
    disablelootspawnpoint(_id_AE22245685C483AE._id_6B64CC5A249331EF);
  }

  return _id_5FAA3DB092440B70;
}

_id_A067541E078900A5(node, origin, dist, _id_5D186451F21D7020, maxrange, _id_FDC6EE1B91EBB7BF) {
  if(istrue(node.inuse))
    return 0;

  if(dist < _id_5D186451F21D7020 || dist > maxrange)
    return 0;

  if(_id_4948CDF739393D2D::_id_F0201365C368CF88(node.origin))
    return 0;

  if(_id_C096A9A3D859CFCE(node.origin))
    return 0;

  if(!level.br_circle_disabled) {
    _id_E1384FF4A85E24E6 = _id_58F20490049AF6AC::_id_60951B84C58915AB(node.origin);
    _id_28DEB7FF62E281D3 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_E1384FF4A85E24E6);

    if(_id_28DEB7FF62E281D3 < _id_FDC6EE1B91EBB7BF)
      return 0;

    _id_42F65B4B53C1F5D4 = dist / 190;
    _id_28DEB7FF62E281D3 = _id_28DEB7FF62E281D3 - _id_42F65B4B53C1F5D4;

    if(_id_28DEB7FF62E281D3 < 30)
      return 0;
  }

  return 1;
}

_id_C096A9A3D859CFCE(_id_CCD641F9100F73F8) {
  if(isDefined(level._id_CF05AFB32024800A._id_5DBCAA3F26F4C1AB) && level._id_CF05AFB32024800A._id_5DBCAA3F26F4C1AB.size > 0) {
    foreach(_id_C799AC677C489061 in level._id_CF05AFB32024800A._id_5DBCAA3F26F4C1AB) {
      if(ispointinvolume(_id_CCD641F9100F73F8, _id_C799AC677C489061))
        return 1;
    }
  }

  return 0;
}

_id_F469A8DCF7FFD6A8(_id_D948C61DFDB971CB, point1, _id_0DB715BCDE296BEC) {
  points = [];
  points[0] = point1;
  radius = distance2d(_id_D948C61DFDB971CB, point1);
  _id_1394E0357BBB97D1 = 360 / _id_0DB715BCDE296BEC;
  _id_0423B19ADA56F4AD = [];
  _id_0423B19ADA56F4AD[0] = (point1[0] - _id_D948C61DFDB971CB[0], point1[1] - _id_D948C61DFDB971CB[1], 0);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_0DB715BCDE296BEC; _id_AC0E594AC96AA3A8++) {
    _id_575EDCD098B792A8 = points[_id_AC0E594AC96AA3A8 - 1];
    _id_088A81F800FB7B0D = _id_575EDCD098B792A8[0] - _id_D948C61DFDB971CB[0];
    _id_7B6B14E76B61F63E = _id_575EDCD098B792A8[1] - _id_D948C61DFDB971CB[1];
    x = _id_088A81F800FB7B0D * cos(_id_1394E0357BBB97D1) - _id_7B6B14E76B61F63E * sin(_id_1394E0357BBB97D1);
    y = _id_7B6B14E76B61F63E * cos(_id_1394E0357BBB97D1) + _id_088A81F800FB7B0D * sin(_id_1394E0357BBB97D1);
    _id_0423B19ADA56F4AD[_id_0423B19ADA56F4AD.size] = (x, y, 0);
    x = x + _id_D948C61DFDB971CB[0];
    y = y + _id_D948C61DFDB971CB[1];
    points[points.size] = (x, y, 0);
  }

  return points;
}

_id_9F225E14BFF0629F() {
  locations = getunusedlootcachepoints(self.tablet.origin, level._id_CF05AFB32024800A._id_76FBB523B032ED22, level._id_CF05AFB32024800A._id_5E8448F4B9E71CB4, 1);

  if(locations.size <= level._id_CF05AFB32024800A._id_697B16D5E1CB65E3)
    return undefined;

  return _id_4C7A7DD83180DE41(locations, level._id_CF05AFB32024800A._id_697B16D5E1CB65E3, self.tablet.origin, level._id_CF05AFB32024800A._id_5E8448F4B9E71CB4, level._id_CF05AFB32024800A._id_76FBB523B032ED22, level._id_CF05AFB32024800A._id_7F34783FC18F8A33, level._id_CF05AFB32024800A._id_B90DC65A569F4825);
}

_id_017E600057C2CF45(player) {
  foreach(_id_18FBB9618444B836 in self._id_3B1ED2AB5FEE3E31) {
    if(isDefined(_id_18FBB9618444B836.objectiveiconid))
      _id_18FBB9618444B836 _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
  }

  player _id_64ACB6CE534155B7::uiobjectiveshow("scavenger");
}

hidescavengerhudfromplayer(player) {
  foreach(_id_18FBB9618444B836 in self._id_3B1ED2AB5FEE3E31) {
    if(isDefined(_id_18FBB9618444B836.objectiveiconid))
      _id_18FBB9618444B836 _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  }

  player _id_64ACB6CE534155B7::uiobjectivehide();
}

deletescavengerhud() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  hidescavengerhudfromplayer(player);

  foreach(_id_18FBB9618444B836 in self._id_3B1ED2AB5FEE3E31) {
    if(isDefined(_id_18FBB9618444B836.objectiveiconid))
      _id_18FBB9618444B836 _id_64ACB6CE534155B7::deletequestobjicon();
  }
}

_id_F46A4DEEFD8CEAF4(volume) {
  if(!isDefined(level._id_5DBCAA3F26F4C1AB))
    level._id_5DBCAA3F26F4C1AB = [];

  if(isDefined(volume))
    level._id_5DBCAA3F26F4C1AB = scripts\engine\utility::array_add(level._id_5DBCAA3F26F4C1AB, volume);
}

spawnscavengerlootcache(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6) {
  cacheentity = spawn("script_model", _id_7E05C139FBBD8374);
  _id_7F599ACCB72658D1 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players")[0];
  cacheentity.angles = _id_5B9C864B21207FF6;
  cacheentity setotherent(_id_7F599ACCB72658D1);
  cacheentity setModel("military_loot_crate_01_br_scavenger_01");
  cacheentity setscriptablepartstate("body", "scavenger_closed");
  cacheentity._id_B8EBE3F71A08AB40 = self;

  foreach(player in level.players) {
    if(player != _id_7F599ACCB72658D1 && (_id_7F599ACCB72658D1.team == "none" || player.team != _id_7F599ACCB72658D1.team))
      cacheentity disablescriptableplayeruse(player);
  }

  return cacheentity;
}

scavengerlootcacheused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipLootPickup", instance))) {
    return;
  }
  if(state == "scavenger_closed" && isDefined(instance.entity)) {
    _id_B8EBE3F71A08AB40 = instance.entity._id_B8EBE3F71A08AB40;

    if(player.team != _id_B8EBE3F71A08AB40.teams[0]) {
      player iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    instance setscriptablepartstate("body", "scavenger_opening");
    _id_C0858ACEEA4BB7D9 = getdvarint("dvar_28B9017071772839", 30);
    instance.entity scripts\engine\utility::_id_AD9433AAB9FCDF04(_id_C0858ACEEA4BB7D9, "death_or_disconnect", ::delete);
    items = getscriptablelootcachecontents(instance, _id_B8EBE3F71A08AB40._id_003BB6053DB23449);

    if(isDefined(items)) {
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = spawnStruct();
      _id_CB4FAD49263E20C4.origin = instance.origin;
      _id_CB4FAD49263E20C4.angles = instance.angles;
      _id_CB4FAD49263E20C4.itemsdropped = 0;
      _id_605079299D001231 = _id_CB4FAD49263E20C4 _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, items, 1);

      foreach(item in _id_605079299D001231)
      item.team = player.team;
    }

    players = scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40.teams[0], "players");
    _id_B8EBE3F71A08AB40._id_003BB6053DB23449++;

    if(_id_B8EBE3F71A08AB40._id_003BB6053DB23449 < level._id_CF05AFB32024800A._id_697B16D5E1CB65E3) {
      _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_B8EBE3F71A08AB40.teams[0], player, 7, _id_64ACB6CE534155B7::getquestindex("scavenger"));
      _id_8FF7906AC676E086 = undefined;

      if(_id_B8EBE3F71A08AB40._id_003BB6053DB23449 == 1)
        _id_E9CFAB9C8A63533C("scavenger_onesecured", _id_B8EBE3F71A08AB40.teams[0]);
      else if(_id_B8EBE3F71A08AB40._id_003BB6053DB23449 == 2)
        _id_E9CFAB9C8A63533C("scavenger_twosecured", _id_B8EBE3F71A08AB40.teams[0]);

      foreach(_id_18FBB9618444B836 in _id_B8EBE3F71A08AB40._id_3B1ED2AB5FEE3E31) {
        if(_id_18FBB9618444B836.cacheentity == instance.entity)
          _id_8FF7906AC676E086 = _id_18FBB9618444B836;
      }

      _id_8FF7906AC676E086._id_3B991F00E2E091E4 = 1;
      _id_8FF7906AC676E086 _id_64ACB6CE534155B7::deletequestobjicon();
      _id_8FF7906AC676E086.objectiveiconid = undefined;
    } else {
      _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_B8EBE3F71A08AB40.teams[0], player, 8, _id_64ACB6CE534155B7::getquestindex("scavenger"));
      _id_E9CFAB9C8A63533C("scavenger_missioncomplete", _id_B8EBE3F71A08AB40.teams[0]);
      rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("scavenger", _id_B8EBE3F71A08AB40.teams[0], instance);

      if(!_id_2CEDCC356F1B9FC8::istutorial()) {
        if(isDefined(rewards) && isDefined(rewards["plunder"]))
          _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_scavenger_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("scavenger"), rewards["plunder"], _id_B8EBE3F71A08AB40.teams[0]);

        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_scav_success", _id_B8EBE3F71A08AB40.teams[0], 1, 1);
      }

      _id_B8EBE3F71A08AB40 thread _id_810BBEDED8D1A801(1);
    }

    foreach(player in players)
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(_id_B8EBE3F71A08AB40._id_003BB6053DB23449);

    _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_E2AA45E2C6B5DEC1(_id_B8EBE3F71A08AB40._id_003BB6053DB23449);

    if(!isDefined(instance.origin))
      scripts\mp\utility\script::demoforcesre("IW9-638849: player.origin = " + player.origin + ", cacheState = " + state);

    level notify("lootcache_opened_kill_callout" + instance.origin);
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

_id_E9CFAB9C8A63533C(dialog, team) {
  _id_668B93C688B30136 = game["dialog"][dialog];
  _id_2CEDCC356F1B9FC8::brleaderdialogteam(dialog, team, 1, 0, undefined, "dx_br_dmzc_");
}