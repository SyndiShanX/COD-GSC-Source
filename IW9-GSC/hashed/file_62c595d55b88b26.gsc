/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_62c595d55b88b26.gsc
***********************************************/

_id_D32F459AB9F5E7AF() {
  _id_DD3A2D6940C2A0B7 = getscriptbundle("enum_2E2C8E9902BD7702");
  level._id_E3FCA817C22E740D = [];

  if(isDefined(_id_DD3A2D6940C2A0B7)) {
    if(isDefined(_id_DD3A2D6940C2A0B7._id_ED69FDC32E48C4EA)) {
      foreach(id, _id_F90358454413407F in _id_DD3A2D6940C2A0B7._id_ED69FDC32E48C4EA) {
        if(isnumber(id) && isDefined(_id_F90358454413407F)) {
          ref = _id_F90358454413407F._id_6627CD540343E11D;

          if(!isDefined(level._id_E3FCA817C22E740D[ref]))
            level._id_E3FCA817C22E740D[ref] = id;
          else {}
        }
      }
    } else {}
  } else {}

  level._id_BCF7BE5C24905AB9 = [];
  level._id_5477E9D7BBF824BF = [];
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["executionKills", "meleeKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_FA624B8C032AFCF7("assassin", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["assists"];
  params._id_47EF1080427D4D3A = 8.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("assists", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["killstreakKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_FA624B8C032AFCF7("bigguns", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["stoppingPowerKills", "bossAgentKills"];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 3; _id_AC0E594AC96AA3A8++) {
    params._id_F873B3D73F52ABBF[params._id_F873B3D73F52ABBF.size] = "tier" + _id_AC0E594AC96AA3A8 + "NormalAgentKills";
    params._id_F873B3D73F52ABBF[params._id_F873B3D73F52ABBF.size] = "tier" + _id_AC0E594AC96AA3A8 + "EliteAgentKills";
  }

  params._id_47EF1080427D4D3A = 16.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("breacher", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_F0496B6C16117C3F;
  params._id_FDE59C56D8B89B3B = ::_id_755FF55065755233;
  params._id_47EF1080427D4D3A = 13.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("commando", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["deadSilenceKills", "throwingKnifeKills", "killstreakCUAVAssists", "silencedKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_1EF76151D5FB5218("ghost", "killstreakCUAVAssists", 0.5);
  _id_FA624B8C032AFCF7("ghost", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["interrogations"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("interrogator", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["kills"];
  params._id_47EF1080427D4D3A = 18.0;
  params.floor = 1.0;
  params.scale = 2;
  _id_FA624B8C032AFCF7("killer", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["smokesUsed", "flashbangHits", "trophySystemHits", "empDroneHits", "gasHits", "stunHits", "decoyHits", "deployableCoverUsed", "shockStickHits"];
  params._id_47EF1080427D4D3A = 11.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_1EF76151D5FB5218("machinist", "decoyHits", 0.1);
  _id_1EF76151D5FB5218("machinist", "deployableCoverUsed", 0.1);
  _id_1EF76151D5FB5218("machinist", "shockStickHits", 0.1);
  _id_FA624B8C032AFCF7("machinist", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["headshots", "totalMultikills", "penetrationKills"];
  params._id_47EF1080427D4D3A = 9.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_FA624B8C032AFCF7("marksman", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["rescues", "kioskRevives"];
  params._id_47EF1080427D4D3A = 6.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_FA624B8C032AFCF7("medic", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_8D32528BF59F4D60;
  params._id_FDE59C56D8B89B3B = ::_id_A1D32055DF3B7000;
  params._id_F873B3D73F52ABBF = ["highestPurchaseCost"];
  params._id_47EF1080427D4D3A = 5000.0;
  params.floor = 20.0;
  params.scale = 2;
  _id_FA624B8C032AFCF7("moneybags", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["fragKills", "molotovKills", "launcherKills", "semtexKills", "thermiteKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("pyro", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_56C0AE4C11E6ECC3;
  params._id_FDE59C56D8B89B3B = ::_id_0C8209FBD2F8C013;
  params._id_47EF1080427D4D3A = 22.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("scavenger", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["reconDroneMarks", "killstreakUAVAssists", "killstreakAUAVAssists", "binocularMarks", "snapshotHits", "tacCamMarks"];
  params._id_47EF1080427D4D3A = 7.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("scout", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["longshotKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 1;
  _id_FA624B8C032AFCF7("sniper", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["munitionsBoxUsed", "armorBoxUsed"];
  params._id_47EF1080427D4D3A = 9.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("supplier", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["damageHealed", "gulagWins", "rescued", "revivedFromKiosk"];
  params._id_47EF1080427D4D3A = 59.0;
  params.floor = 1.0;
  params.scale = 2;
  _id_1EF76151D5FB5218("survivor", "damageHealed", 0.1);
  _id_FA624B8C032AFCF7("survivor", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B9D90F8E9BF917B0;
  params._id_FDE59C56D8B89B3B = ::_id_BD072F91EE4831B0;
  params._id_F873B3D73F52ABBF = ["blacksitesCaptured", "strongholdsCaptured"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("teamobjectives", params);
  params = spawnStruct();
  params._id_C0E23EEB5D47EC83 = ::_id_B13F6A12712EAA29;
  params._id_FDE59C56D8B89B3B = ::_id_3F5A0A838086D8DD;
  params._id_F873B3D73F52ABBF = ["claymoreKills", "c4Kills", "proximityMineKills"];
  params._id_47EF1080427D4D3A = 5.0;
  params.floor = 1.0;
  params.scale = 0;
  _id_FA624B8C032AFCF7("trapper", params);

  if(_id_5C6B989A6F25F7FA::can_play_ending()) {
    level._id_E3AC672A3513883F = ::_id_2CBDF94F9506AD4F;
    level._id_0C3EDD7B8C279A3E = ::_id_3E06F1C56DF58044;
  }
}

_id_FA624B8C032AFCF7(ref, _id_CD37CE775909957B) {
  _id_CD37CE775909957B.name = ref;
  level._id_BCF7BE5C24905AB9[ref] = _id_CD37CE775909957B;
}

_id_2CBDF94F9506AD4F() {
  level endon("game_ended");
  self endon("disconnect");

  foreach(_id_9C106D8742ED698F, _id_F90358454413407F in level._id_BCF7BE5C24905AB9) {
    if(isDefined(_id_F90358454413407F._id_F873B3D73F52ABBF) && _id_F90358454413407F._id_F873B3D73F52ABBF.size > 0) {
      foreach(_id_88421F8DBFE8EFE8 in _id_F90358454413407F._id_F873B3D73F52ABBF)
      scripts\mp\utility\stats::initpersstat(_id_88421F8DBFE8EFE8);
    }
  }
}

_id_1EF76151D5FB5218(_id_9C106D8742ED698F, _id_D0F001B1761FBF53, mod) {
  level._id_5477E9D7BBF824BF[_id_9C106D8742ED698F][_id_D0F001B1761FBF53] = mod;
}

_id_5417D27691D41344(_id_9C106D8742ED698F, _id_D0F001B1761FBF53) {
  if(!isDefined(level._id_5477E9D7BBF824BF) || !scripts\engine\utility::array_contains_key(level._id_5477E9D7BBF824BF, _id_9C106D8742ED698F) || !scripts\engine\utility::array_contains_key(level._id_5477E9D7BBF824BF[_id_9C106D8742ED698F], _id_D0F001B1761FBF53))
    return 1;

  return level._id_5477E9D7BBF824BF[_id_9C106D8742ED698F][_id_D0F001B1761FBF53];
}

_id_8D32528BF59F4D60(ref, params) {
  _id_2D25F333132CB770 = 0;

  if(isDefined(self.plundercount))
    _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.plundercount * _id_5417D27691D41344(ref, "plunderCount");

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(self.pers[param]))
        _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.pers[param] * _id_5417D27691D41344(ref, param);
    }
  }

  self._id_FB37DB009207FE1A[ref] = _id_2D25F333132CB770;
  self._id_769C9EDD0782E95D[ref] = _id_9BBBEFE6A0DEBD2B(ref, _id_2D25F333132CB770);
}

_id_56C0AE4C11E6ECC3(ref, params) {
  _id_2D25F333132CB770 = 0;

  if(isDefined(self.lootcachesopened))
    _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.lootcachesopened * _id_5417D27691D41344(ref, "lootCachesOpened");

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(self.pers[param]))
        _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.pers[param] * _id_5417D27691D41344(ref, param);
    }
  }

  self._id_FB37DB009207FE1A[ref] = _id_2D25F333132CB770;
  self._id_769C9EDD0782E95D[ref] = _id_9BBBEFE6A0DEBD2B(ref, _id_2D25F333132CB770);
}

_id_B9D90F8E9BF917B0(ref, params) {
  _id_2D25F333132CB770 = 0;

  if(isDefined(self.brmissionscompleted))
    _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.brmissionscompleted * _id_5417D27691D41344(ref, "brMissionsCompleted");

  if(isDefined(params)) {
    foreach(param in params) {
      if(isDefined(self.pers[param]))
        _id_2D25F333132CB770 = _id_2D25F333132CB770 + self.pers[param] * _id_5417D27691D41344(ref, param);
    }
  }

  self._id_FB37DB009207FE1A[ref] = _id_2D25F333132CB770;
  self._id_769C9EDD0782E95D[ref] = _id_9BBBEFE6A0DEBD2B(ref, _id_2D25F333132CB770);
}

_id_A72F9AE578E162E8(ref, params) {
  self._id_FB37DB009207FE1A[ref] = -1.0;
  self._id_769C9EDD0782E95D[ref] = -1.0;
}

_id_9BBBEFE6A0DEBD2B(ref, value) {
  data = level._id_BCF7BE5C24905AB9[ref];

  if(value < data.floor)
    return -1.0;
  else if(value > data._id_47EF1080427D4D3A)
    value = data._id_47EF1080427D4D3A;

  if(isDefined(data._id_47EF1080427D4D3A)) {
    if(isDefined(data._id_3C141DF65714D228))
      _id_3C141DF65714D228 = data._id_3C141DF65714D228;
    else if(isDefined(data.scale) && data.scale == 1)
      _id_3C141DF65714D228 = data._id_47EF1080427D4D3A * -0.1;
    else
      _id_3C141DF65714D228 = 0.0;

    value = float(value - _id_3C141DF65714D228) / float(data._id_47EF1080427D4D3A - _id_3C141DF65714D228);
  }

  if(isDefined(data.scale) && data.scale == 2)
    value = pow(value, 1.2);

  return value;
}

_id_B13F6A12712EAA29(ref, _id_B6988561FFD1F3AD) {
  _id_2D25F333132CB770 = 0;

  foreach(_id_2E62E8C3B2B312EC in _id_B6988561FFD1F3AD) {
    val = self.pers[_id_2E62E8C3B2B312EC];

    if(isDefined(val))
      _id_2D25F333132CB770 = _id_2D25F333132CB770 + val * _id_5417D27691D41344(ref, _id_2E62E8C3B2B312EC);
  }

  self._id_FB37DB009207FE1A[ref] = _id_2D25F333132CB770;
  self._id_769C9EDD0782E95D[ref] = _id_9BBBEFE6A0DEBD2B(ref, _id_2D25F333132CB770);
}

_id_F0496B6C16117C3F(ref, params) {
  _id_77F3CA6D2F0AAE12 = 0;
  _id_BB164E4DF36286B4 = ["pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills"];
  _id_4510B799408D140D = ["longshotKills", "pointBlankKills"];

  foreach(_id_7A2FA5A4563B3FEC in _id_BB164E4DF36286B4) {
    val = self.pers[_id_7A2FA5A4563B3FEC];

    if(isDefined(val))
      _id_77F3CA6D2F0AAE12 = _id_77F3CA6D2F0AAE12 + val;
  }

  foreach(_id_7A2FA5A4563B3FEC in _id_4510B799408D140D) {
    val = self.pers[_id_7A2FA5A4563B3FEC];

    if(isDefined(val))
      _id_77F3CA6D2F0AAE12 = _id_77F3CA6D2F0AAE12 - val;
  }

  self._id_FB37DB009207FE1A[ref] = _id_77F3CA6D2F0AAE12;
  self._id_769C9EDD0782E95D[ref] = _id_9BBBEFE6A0DEBD2B(ref, _id_77F3CA6D2F0AAE12);
}

_id_A1D32055DF3B7000(ref, params) {
  _id_272FBF55066E6EA0 = [];

  if(isDefined(self.plundercount))
    _id_272FBF55066E6EA0["plunderCount"] = self.plundercount;
  else
    _id_272FBF55066E6EA0["plunderCount"] = 0;

  return _id_A0C339EEAF1DADB5(ref, params, _id_272FBF55066E6EA0);
}

_id_0C8209FBD2F8C013(ref, params) {
  _id_272FBF55066E6EA0 = [];

  if(isDefined(self.lootcachesopened))
    _id_272FBF55066E6EA0["lootCachesOpened"] = self.lootcachesopened;
  else
    _id_272FBF55066E6EA0["lootCachesOpened"] = 0;

  return _id_A0C339EEAF1DADB5(ref, params, _id_272FBF55066E6EA0);
}

_id_BD072F91EE4831B0(ref, params) {
  _id_272FBF55066E6EA0 = [];

  if(isDefined(self.brmissionscompleted))
    _id_272FBF55066E6EA0["brMissionsCompleted"] = self.brmissionscompleted;
  else
    _id_272FBF55066E6EA0["brMissionsCompleted"] = 0;

  return _id_A0C339EEAF1DADB5(ref, params, _id_272FBF55066E6EA0);
}

_id_755FF55065755233(ref, params) {
  _id_77F3CA6D2F0AAE12 = 0;
  _id_BB164E4DF36286B4 = ["pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills"];
  _id_4510B799408D140D = ["longshotKills", "pointBlankKills"];

  foreach(_id_7A2FA5A4563B3FEC in _id_BB164E4DF36286B4) {
    val = self.pers[_id_7A2FA5A4563B3FEC];

    if(isDefined(val))
      _id_77F3CA6D2F0AAE12 = _id_77F3CA6D2F0AAE12 + val;
  }

  foreach(_id_7A2FA5A4563B3FEC in _id_4510B799408D140D) {
    val = self.pers[_id_7A2FA5A4563B3FEC];

    if(isDefined(val))
      _id_77F3CA6D2F0AAE12 = _id_77F3CA6D2F0AAE12 - val;
  }

  _id_272FBF55066E6EA0 = [];
  _id_272FBF55066E6EA0["midRangeKills"] = _id_77F3CA6D2F0AAE12;
  return _id_A0C339EEAF1DADB5(ref, params, _id_272FBF55066E6EA0);
}

_id_3F5A0A838086D8DD(ref, params) {
  return _id_A0C339EEAF1DADB5(ref, params);
}

_id_A0C339EEAF1DADB5(ref, _id_B894EFC634F2A9D8, _id_272FBF55066E6EA0) {
  data = spawnStruct();
  data.ref = ref;
  data._id_D924EF641D26EA9B = [];
  _id_2D25F333132CB770 = 0;

  if(isDefined(_id_B894EFC634F2A9D8)) {
    foreach(_id_D0F001B1761FBF53 in _id_B894EFC634F2A9D8) {
      value = 0;
      _id_86A1D4655BEA5502 = 0;

      if(isDefined(self.pers[_id_D0F001B1761FBF53])) {
        value = self.pers[_id_D0F001B1761FBF53];
        _id_86A1D4655BEA5502 = value * _id_5417D27691D41344(ref, _id_D0F001B1761FBF53);
        _id_2D25F333132CB770 = _id_2D25F333132CB770 + _id_86A1D4655BEA5502;
      }

      data._id_D924EF641D26EA9B[_id_D0F001B1761FBF53][0] = value;
      data._id_D924EF641D26EA9B[_id_D0F001B1761FBF53][1] = _id_86A1D4655BEA5502;
    }
  }

  if(isDefined(_id_272FBF55066E6EA0)) {
    foreach(_id_D0F001B1761FBF53, value in _id_272FBF55066E6EA0) {
      if(isDefined(value)) {
        _id_86A1D4655BEA5502 = value * _id_5417D27691D41344(ref, _id_D0F001B1761FBF53);
        _id_2D25F333132CB770 = _id_2D25F333132CB770 + _id_86A1D4655BEA5502;
        data._id_D924EF641D26EA9B[_id_D0F001B1761FBF53][0] = value;
        data._id_D924EF641D26EA9B[_id_D0F001B1761FBF53][1] = _id_86A1D4655BEA5502;
      }
    }
  }

  data.value = _id_2D25F333132CB770;
  data._id_DCF6B3BAF1D56570 = _id_9BBBEFE6A0DEBD2B(ref, _id_2D25F333132CB770);
  return data;
}

_id_97113D2008E3D1F6() {
  accolades = [];

  foreach(ref, _id_F90358454413407F in level._id_BCF7BE5C24905AB9) {
    data = self[[_id_F90358454413407F._id_FDE59C56D8B89B3B]](ref, _id_F90358454413407F._id_F873B3D73F52ABBF);
    _id_1384D9221443F717 = spawnStruct();
    _id_1384D9221443F717.ref = ref;
    value = 0;
    _id_DCF6B3BAF1D56570 = 0;

    if(isDefined(data.value))
      value = max(data.value, value);

    if(isDefined(data._id_DCF6B3BAF1D56570))
      _id_DCF6B3BAF1D56570 = max(data._id_DCF6B3BAF1D56570, _id_DCF6B3BAF1D56570);

    _id_1384D9221443F717.value = value;
    _id_1384D9221443F717._id_DCF6B3BAF1D56570 = _id_DCF6B3BAF1D56570;
    _id_9659C2342B30AD90 = [];

    foreach(_id_EEFC75B18C870027, _id_F90358454413407F in data._id_D924EF641D26EA9B) {
      _id_2287F0525564DE07 = 0;
      _id_882E5FFB508915F1 = 0;

      if(isDefined(_id_F90358454413407F) && _id_F90358454413407F.size >= 2) {
        if(isDefined(_id_F90358454413407F[0]))
          _id_2287F0525564DE07 = max(0, _id_F90358454413407F[0]);

        if(isDefined(_id_F90358454413407F[1]))
          _id_882E5FFB508915F1 = max(0, _id_F90358454413407F[1]);
      }

      _id_9659C2342B30AD90[_id_9659C2342B30AD90.size] = ["stat", _id_EEFC75B18C870027, "value", _id_2287F0525564DE07, "scaledvalue", _id_882E5FFB508915F1];
    }

    _id_1384D9221443F717.stats = _id_9659C2342B30AD90;
    accolades[accolades.size] = _id_1384D9221443F717;
  }

  return accolades;
}

_id_3E06F1C56DF58044() {
  data = _id_97113D2008E3D1F6();

  foreach(_id_9C106D8742ED698F in data)
  self dlog_recordplayerevent("dlog_event_br_accolade_data", ["stats", _id_9C106D8742ED698F.stats, "accolade", _id_9C106D8742ED698F.ref, "value", _id_9C106D8742ED698F.value, "scaledvalue", _id_9C106D8742ED698F._id_DCF6B3BAF1D56570]);
}

_id_74497A0F417E329F(winners) {
  winners = scripts\engine\utility::array_removeundefined(winners);

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }
    player._id_AE06891211AF23BA = undefined;
    player._id_AE7B07FF9D949509 = [];
    player._id_FB37DB009207FE1A = [];
    player._id_769C9EDD0782E95D = [];
  }

  foreach(ref, _id_F90358454413407F in level._id_BCF7BE5C24905AB9) {
    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }
      player[[_id_F90358454413407F._id_C0E23EEB5D47EC83]](ref, _id_F90358454413407F._id_F873B3D73F52ABBF);
    }
  }

  foreach(ref, _id_F90358454413407F in level._id_BCF7BE5C24905AB9) {
    _id_EC1019CFF3D1C77F = 0;
    bestplayer = undefined;

    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }
      if(player._id_FB37DB009207FE1A[ref] > _id_EC1019CFF3D1C77F && player._id_769C9EDD0782E95D[ref] >= 0) {
        bestplayer = player;
        _id_EC1019CFF3D1C77F = player._id_FB37DB009207FE1A[ref];
      }
    }

    foreach(player in winners) {
      if(!isPlayer(player)) {
        continue;
      }
      if(player._id_769C9EDD0782E95D[ref] >= 0 && player._id_FB37DB009207FE1A[ref] == _id_EC1019CFF3D1C77F)
        player._id_AE7B07FF9D949509[player._id_AE7B07FF9D949509.size] = ref;
    }
  }

  _id_E722466D58C00CC1 = [];

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }
    _id_3513C54632ECB882 = -1;
    _id_0402228B4154EDAC = undefined;

    foreach(ref in player._id_AE7B07FF9D949509) {
      if(scripts\engine\utility::array_contains(_id_E722466D58C00CC1, ref)) {
        continue;
      }
      if(player._id_769C9EDD0782E95D[ref] > _id_3513C54632ECB882) {
        _id_3513C54632ECB882 = player._id_769C9EDD0782E95D[ref];
        _id_0402228B4154EDAC = ref;
      }
    }

    if(isDefined(_id_0402228B4154EDAC)) {
      player._id_AE06891211AF23BA = _id_0402228B4154EDAC;
      _id_E722466D58C00CC1[_id_E722466D58C00CC1.size] = _id_0402228B4154EDAC;
    }
  }

  _id_CF83385F8A939F54 = ["survivor", "scout", "scavenger", "ghost"];
  _id_CF83385F8A939F54 = scripts\engine\utility::array_randomize(_id_CF83385F8A939F54);
  _id_CF83385F8A939F54 = scripts\engine\utility::array_combine(_id_CF83385F8A939F54, ["killer", "breacher", "moneybags"]);

  for(_id_AC0E594AC96AA3A8 = _id_CF83385F8A939F54.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    _id_AD43CA064F182C3E = _id_CF83385F8A939F54[_id_AC0E594AC96AA3A8];

    if(scripts\engine\utility::array_contains(_id_E722466D58C00CC1, _id_AD43CA064F182C3E))
      _id_CF83385F8A939F54 = scripts\engine\utility::array_remove_index(_id_CF83385F8A939F54, _id_AC0E594AC96AA3A8);
  }

  _id_44D5A2614EED724E = 0;

  foreach(player in winners) {
    if(!isPlayer(player)) {
      continue;
    }
    _id_3E04FA138EC067F5 = 0;

    if(!isDefined(player._id_AE06891211AF23BA)) {
      player._id_AE06891211AF23BA = _id_CF83385F8A939F54[_id_44D5A2614EED724E];
      _id_3E04FA138EC067F5 = 1;
      _id_44D5A2614EED724E++;
      _id_E722466D58C00CC1[_id_E722466D58C00CC1.size] = _id_CF83385F8A939F54[_id_44D5A2614EED724E];
    }

    _id_688F5BEEE0172BBB = player._id_FB37DB009207FE1A[player._id_AE06891211AF23BA];
    _id_86A1D4655BEA5502 = player._id_769C9EDD0782E95D[player._id_AE06891211AF23BA];

    if(!isDefined(_id_688F5BEEE0172BBB))
      _id_688F5BEEE0172BBB = 0;

    if(!isDefined(_id_86A1D4655BEA5502))
      _id_86A1D4655BEA5502 = 0;

    player dlog_recordplayerevent("dlog_event_br_winner_accolade_data", ["accolade", player._id_AE06891211AF23BA, "is_participation_trophy", _id_3E04FA138EC067F5, "value", float(_id_688F5BEEE0172BBB), "scaled_value", float(_id_86A1D4655BEA5502)]);
    player._id_AE7B07FF9D949509 = undefined;
    player._id_FB37DB009207FE1A = undefined;
    player._id_769C9EDD0782E95D = undefined;
  }
}

_id_8C70E1B5FB997D3A(winners) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < winners.size; _id_AC0E594AC96AA3A8++) {
    if(isPlayer(winners[_id_AC0E594AC96AA3A8]))
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_95416C93789582A9(winners, index) {
  for(_id_08E5AA8521F3435E = (index + 1) % winners.size; _id_08E5AA8521F3435E != index; _id_08E5AA8521F3435E = (index + 1) % winners.size) {
    if(isPlayer(winners[_id_08E5AA8521F3435E]))
      return _id_08E5AA8521F3435E;
  }

  return _id_08E5AA8521F3435E;
}

_id_05864D7EEAC0E9AC(winners, _id_7FA848E5B3BBC437, _id_ECB33625634B60D3) {
  level._id_6B11625ABE5346B0 = [];

  if(_id_ECB33625634B60D3 != "") {
    if(isDefined(level._id_BCF7BE5C24905AB9[_id_ECB33625634B60D3])) {
      foreach(winner in winners) {
        if(!isPlayer(winner) || winner _meth_8420670EAFC8D391()) {
          continue;
        }
        _id_16A81C74CE61860E = spawnStruct();
        _id_16A81C74CE61860E.ref = _id_ECB33625634B60D3;
        _id_16A81C74CE61860E.player = winner;
        level._id_6B11625ABE5346B0[level._id_6B11625ABE5346B0.size] = _id_16A81C74CE61860E;
      }

      return;
    }
  }

  switch (_id_7FA848E5B3BBC437) {
    case 0:
      return;
    case 1:
      foreach(player in winners) {
        if(!isPlayer(player) || player _meth_8420670EAFC8D391()) {
          continue;
        }
        _id_16A81C74CE61860E = spawnStruct();
        _id_16A81C74CE61860E.ref = player._id_AE06891211AF23BA;
        _id_16A81C74CE61860E.player = player;
        level._id_6B11625ABE5346B0[level._id_6B11625ABE5346B0.size] = _id_16A81C74CE61860E;
      }

      break;
    case 2:
      _id_362F690D4CBFC6F3 = scripts\engine\utility::array_randomize(level._id_BCF7BE5C24905AB9);
      _id_1A76078D68FFCF56 = _id_8C70E1B5FB997D3A(winners);

      if(isDefined(_id_1A76078D68FFCF56)) {
        foreach(ref, _id_F90358454413407F in _id_362F690D4CBFC6F3) {
          _id_16A81C74CE61860E = spawnStruct();
          _id_16A81C74CE61860E.ref = ref;
          _id_16A81C74CE61860E.player = winners[_id_1A76078D68FFCF56];
          _id_1A76078D68FFCF56 = _id_95416C93789582A9(winners, _id_1A76078D68FFCF56);
          level._id_6B11625ABE5346B0[level._id_6B11625ABE5346B0.size] = _id_16A81C74CE61860E;
        }
      }

      break;
    case 3:
      _id_81B900917CA1358E = scripts\engine\utility::array_randomize(level._id_BCF7BE5C24905AB9);
      index = 0;

      foreach(player in winners) {
        if(!isPlayer(player) || player _meth_8420670EAFC8D391()) {
          continue;
        }
        _id_16A81C74CE61860E = spawnStruct();
        _id_16A81C74CE61860E.ref = _func_5162A2AAAD39B2C7(_id_81B900917CA1358E, index);
        _id_16A81C74CE61860E.player = player;
        level._id_6B11625ABE5346B0[level._id_6B11625ABE5346B0.size] = _id_16A81C74CE61860E;
        index++;
      }

      break;
    default:
      return;
  }
}