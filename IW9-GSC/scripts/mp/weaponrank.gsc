/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weaponrank.gsc
***********************************************/

init() {
  loadweaponranktable();
  level._id_B883CC44C69244CA = getdvarint("dvar_53B03E37A92E4CE8", 1) == 1;
  level._id_4EA3E75E13F80DA0 = getdvarfloat("dvar_0CA4CE52FF089426", 0.2);
  _id_8215D55CE8CAEE38 = getdvarint("online_mp_weapon_xpscale", 1);
  addglobalweaponrankxpmultiplier(_id_8215D55CE8CAEE38, "online_mp_weapon_xpscale");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player)) {
      if(level.weaponxpenabled) {
        _id_69A07D6024AEB70B = getdvarint("online_mp_party_weapon_xpscale");
        _id_E2F208FF5491C24E = player getprivatepartysize() > 1;

        if(_id_E2F208FF5491C24E)
          player addweaponrankxpmultiplier(_id_69A07D6024AEB70B, "online_mp_party_weapon_xpscale");
      }
    }
  }
}

loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];
  _id_C5B5347389C6B7D6 = 0;

  for(;;) {
    _id_09DD5D9E57E7E36D = int(tablelookuprownum("mp/weaponRankTable.csv", 0, _id_C5B5347389C6B7D6));

    if(!isDefined(_id_09DD5D9E57E7E36D) || _id_09DD5D9E57E7E36D < 0) {
      break;
    }

    rankinfo = spawnStruct();
    level.weaponranktable.rankinfo[_id_C5B5347389C6B7D6] = rankinfo;
    rankinfo.minxp = int(tablelookupbyrow("mp/weaponRankTable.csv", _id_C5B5347389C6B7D6, 1));
    rankinfo.xptonextrank = int(tablelookupbyrow("mp/weaponRankTable.csv", _id_C5B5347389C6B7D6, 2));
    rankinfo.maxxp = int(tablelookupbyrow("mp/weaponRankTable.csv", _id_C5B5347389C6B7D6, 3));
    _id_C5B5347389C6B7D6++;
  }

  level.weaponranktable.maxrank = _id_C5B5347389C6B7D6 - 1;
  level.weaponranktable.maxweaponranks = [];
  _id_0D2CA933F911B449 = _id_2669878CF5A1B6BC::_id_A221D76594EF4E8B();

  if(isDefined(_id_0D2CA933F911B449)) {
    foreach(weaponname in _id_0D2CA933F911B449) {
      _id_255E0DF33FAE6D5A = _id_2669878CF5A1B6BC::_id_8477D8595E0364A7(weaponname, ["stat_89E9C01960F4C582", "stat_43130EF338EA52E3"]);

      if(isDefined(_id_255E0DF33FAE6D5A)) {
        _id_AB501F397D3CD312 = _id_255E0DF33FAE6D5A.ref;
        maxrank = _id_255E0DF33FAE6D5A.maxrank;

        if(!isDefined(_id_AB501F397D3CD312) || _id_AB501F397D3CD312 == "" || !isDefined(maxrank)) {
          continue;
        }
        maxrank = int(maxrank);
        level.weaponranktable.maxweaponranks[_id_AB501F397D3CD312] = maxrank;
      }
    }
  }
}

getplayerweaponrank(rootweapon) {
  _id_CC603E175ABFEF2D = getplayerweaponrankxp(rootweapon);
  _id_00AE17C5A8B1BC1B = getweaponrankforxp(_id_CC603E175ABFEF2D);
  return _id_00AE17C5A8B1BC1B;
}

getplayerweaponrankxp(rootweapon, type) {
  if(!isDefined(type))
    type = "all";

  switch (type) {
    case "mp":
      _id_D1B5160DD8525744 = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "mpXP");
      return _id_D1B5160DD8525744;
    case "cp":
      _id_5B21BD23ECD5520A = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "cpXP");
      return _id_5B21BD23ECD5520A;
    case "all":
      _id_D1B5160DD8525744 = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "mpXP");
      _id_5B21BD23ECD5520A = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "cpXP");
      return _id_D1B5160DD8525744 + _id_5B21BD23ECD5520A;
  }
}

isplayerweaponatmaxxp(rootweapon) {
  _id_1822F368857BC036 = getplayerweaponrankxp(rootweapon);
  maxxp = getweaponmaxrankxp(rootweapon);
  return _id_1822F368857BC036 >= maxxp;
}

weaponshouldgetxp(weapon) {
  _id_F486E79B42C6CBEC = getdvarint("dvar_39C5E2E95AE3C2E6", 1) == 1;

  if(!_id_F486E79B42C6CBEC && self.pers["rank"] < 3 && !getdvarint("force_challenges"))
    return 0;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  return weaponhasranks(_id_AB501F397D3CD312);
}

weaponhasranks(_id_AB501F397D3CD312) {
  if(!isDefined(level.weaponranktable.maxweaponranks[_id_AB501F397D3CD312]))
    return 0;

  _id_77492B2ECBE850E2 = level.weaponranktable.maxweaponranks[_id_AB501F397D3CD312] > 0;
  return _id_77492B2ECBE850E2;
}

getweaponmaxrankxp(rootweapon) {
  maxrank = getmaxweaponrankforrootweapon(rootweapon);
  return getweaponrankinfomaxxp(maxrank);
}

getweaponrankforxp(_id_9F9DFAA0DD863910) {
  if(_id_9F9DFAA0DD863910 == 0)
    return 0;

  for(_id_C5B5347389C6B7D6 = getmaxweaponrank() - 1; _id_C5B5347389C6B7D6 >= 0; _id_C5B5347389C6B7D6--) {
    if(_id_9F9DFAA0DD863910 >= getweaponrankinfominxp(_id_C5B5347389C6B7D6))
      return _id_C5B5347389C6B7D6;
  }

  return _id_C5B5347389C6B7D6;
}

getmaxweaponrankforrootweapon(rootweapon) {
  return level.weaponranktable.maxweaponranks[rootweapon];
}

getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

getweaponrankinfominxp(_id_C5B5347389C6B7D6) {
  return level.weaponranktable.rankinfo[_id_C5B5347389C6B7D6].minxp;
}

getweaponrankinfoxptonextrank(_id_C5B5347389C6B7D6) {
  return level.weaponranktable.rankinfo[_id_C5B5347389C6B7D6].xptonextrank;
}

getweaponrankinfomaxxp(_id_C5B5347389C6B7D6) {
  return level.weaponranktable.rankinfo[_id_C5B5347389C6B7D6].maxxp;
}

giveplayerweaponxp(objweapon, type, xp) {
  if(isai(self) || !isPlayer(self) || !isDefined(xp) || xp == 0 || !level.weaponxpenabled) {
    return;
  }
  rootweapon = _id_2669878CF5A1B6BC::getweaponrootname(objweapon.basename);

  if(!self isitemunlocked(rootweapon, "weapon")) {
    return;
  }
  if(!weaponhasranks(rootweapon)) {
    return;
  }
  _id_26F853388D329915 = remapscoreeventforweapon(type);

  if(_id_26F853388D329915 != type) {
    type = _id_26F853388D329915;
    xp = scripts\mp\rank::_id_D06C3CBB904AE29B(type);
  }

  if(xp < 0) {
    return;
  }
  _id_DD7D0DDB84506614 = xp;
  xp = xp * getweaponrankxpmultipliertotal();
  xp = int(xp);
  _id_D6C1D2574E3947C7 = getplayerweaponrankxp(rootweapon, "mp");
  _id_6E5C89151ED6E249 = getplayerweaponrankxp(rootweapon, "cp");
  _id_D9E44A427EC4C8D9 = _id_D6C1D2574E3947C7 + _id_6E5C89151ED6E249;
  _id_A92627842B1B7644 = getweaponrankforxp(_id_D9E44A427EC4C8D9);
  maxxp = getweaponmaxrankxp(rootweapon);
  _id_BC811BEEC61533E0 = maxxp - _id_6E5C89151ED6E249;
  _id_CCC135D35F5BEBC8 = _id_D6C1D2574E3947C7 + xp;

  if(_id_CCC135D35F5BEBC8 > _id_BC811BEEC61533E0)
    _id_CCC135D35F5BEBC8 = _id_BC811BEEC61533E0;

  _id_02993EDF5241F55A = _id_CCC135D35F5BEBC8 + _id_6E5C89151ED6E249;
  maxrank = getmaxweaponrankforrootweapon(rootweapon);
  _id_814960839FF2DC12 = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "prestige");
  _id_EBFEBB497C5F0C29 = int(min(getweaponrankforxp(_id_02993EDF5241F55A), maxrank));
  scripts\mp\analyticslog::logevent_givempweaponxp(objweapon, _id_814960839FF2DC12, _id_EBFEBB497C5F0C29, xp, type);

  if(_id_A92627842B1B7644 < _id_EBFEBB497C5F0C29) {
    _id_9060BFFE66826B8C = "stat_E9AA6F742889A408";

    if(_id_EBFEBB497C5F0C29 >= 15)
      _id_9060BFFE66826B8C = "stat_DF87536A55018058";
    else if(_id_EBFEBB497C5F0C29 >= 10)
      _id_9060BFFE66826B8C = "stat_DB8B62B195E166E8";
    else if(_id_EBFEBB497C5F0C29 >= 5)
      _id_9060BFFE66826B8C = "stat_02235F7435F85418";

    _id_12239DCA1AEF95CD = scripts\mp\rank::_id_D06C3CBB904AE29B(_id_9060BFFE66826B8C);
    scripts\mp\rank::giverankxp(_id_9060BFFE66826B8C, _id_12239DCA1AEF95CD);
  }

  return xp;
}

remapscoreeventforweapon(event) {
  switch (event) {
    case "kill":
      event = "kill_weapon";
      break;
    case "challenge":
      event = "weapon_challenge";
      break;
  }

  return event;
}

addglobalweaponrankxpmultiplier(_id_98EA5AFB293A76A2, ref) {
  level addweaponrankxpmultiplier(_id_98EA5AFB293A76A2, ref);
}

getglobalweaponrankxpmultiplier() {
  return level getweaponrankxpmultiplier();
}

getplatformweaponrankxpmultiplier() {
  return 1.0;
}

_id_9C989CE157528A7E(objweapon) {
  if(!istrue(level._id_B883CC44C69244CA))
    return 1.0;

  if(!isDefined(objweapon))
    return 1.0;

  rootweapon = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);

  if(isDefined(rootweapon) && isDefined(level.weaponmapdata[rootweapon]) && istrue(level.weaponmapdata[rootweapon]._id_B883CC44C69244CA))
    return 1.0 + level._id_4EA3E75E13F80DA0;

  return 1.0;
}

addweaponrankxpmultiplier(_id_98EA5AFB293A76A2, ref) {
  if(!isDefined(self.weaponrankxpmultipliers))
    self.weaponrankxpmultipliers = [];

  if(isDefined(self.weaponrankxpmultipliers[ref]))
    self.weaponrankxpmultipliers[ref] = max(self.weaponrankxpmultipliers[ref], _id_98EA5AFB293A76A2);
  else
    self.weaponrankxpmultipliers[ref] = _id_98EA5AFB293A76A2;
}

_id_E45154FF0DFC8771(ref) {
  if(!isDefined(self.weaponrankxpmultipliers) || !isDefined(self.weaponrankxpmultipliers[ref]))
    return 1.0;

  return self.weaponrankxpmultipliers[ref];
}

getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers))
    return 1.0;

  _id_7662D3C556FCCB56 = 1.0;

  foreach(modifier in self.weaponrankxpmultipliers) {
    if(!isDefined(modifier)) {
      continue;
    }
    _id_7662D3C556FCCB56 = _id_7662D3C556FCCB56 * modifier;
  }

  return _id_7662D3C556FCCB56;
}

removeglobalweaponrankxpmultiplier(ref) {
  level removeweaponrankxpmultiplier(ref);
}

removeweaponrankxpmultiplier(ref) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return;
  }
  if(!isDefined(self.weaponrankxpmultipliers[ref])) {
    return;
  }
  self.rankxpmultipliers[ref] = undefined;
}

getweaponrankxpmultipliertotal(objweapon) {
  _id_39FBCC95C12E7F4D = getweaponrankxpmultiplier();
  _id_17ADAB2B5FACD077 = getglobalweaponrankxpmultiplier();
  _id_A37B5D08129F42C2 = getgametypeweaponxpmultiplier();
  _id_C75E49D88DF27EBB = getplatformweaponrankxpmultiplier();
  _id_C4843C7F58599A44 = _id_9C989CE157528A7E(objweapon);
  return _id_39FBCC95C12E7F4D * _id_17ADAB2B5FACD077 * _id_A37B5D08129F42C2 * _id_C75E49D88DF27EBB * _id_C4843C7F58599A44;
}

getgametypeweaponxpmultiplier() {
  _id_C264934852FA6FB8 = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_weapon_xp_scalar_override"), 0.0);

  if(_id_C264934852FA6FB8 > 0.0)
    return _id_C264934852FA6FB8;

  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    if(!isDefined(level.gametypeweaponxpmodifier))
      level.gametypeweaponxpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 19));

    return level.gametypeweaponxpmodifier;
  }

  return level._id_62F6F7640E4431E3._id_3C836934A83182A5;
}

getgametypekillsperhouravg() {
  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    if(!isDefined(level.gametypekillsperhouravg))
      level.gametypekillsperhouravg = int(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 20));

    return level.gametypekillsperhouravg;
  }

  return level._id_62F6F7640E4431E3._id_D98341B1A105C7AF;
}

getgametypekillspermatchmaximum() {
  if(!isDefined(level.gametypekillspermatchmax)) {
    timelimit = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit"));

    if(timelimit == 0)
      timelimit = 900;

    winlimit = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_winlimit"));

    if(winlimit > 0)
      timelimit = timelimit * (winlimit * 2 - 1);

    level.gametypekillspermatchmax = getgametypekillsperhouravg() / 60 * (timelimit / 60);
  }

  return level.gametypekillspermatchmax;
}