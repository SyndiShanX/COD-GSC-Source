/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1870.gsc
*************************************************/

_id_D2EB(var_0) {
  self[[level._id_3D1E[var_0]._id_D12B]]();
}

_id_F9EE(var_0) {
  self[[level._id_3D1E[var_0]._id_F9B2]]();
}

_id_667E() {
  return self getplayerdata("cp", "coopCareerStats", "currency");
}

_id_666A() {
  return self getplayerdata("cp", "alienSession", "currency");
}

_id_667D() {
  return self._id_9C61;
}

_id_ED80() {
  _id_D337(0);
}

_id_6788() {
  var_0 = getdvarint("#x3e08356938ca32843", 0);

  if(var_0 != 0) {
    return var_0;
  }

  if(isDefined(level._id_11049)) {
    if(level._id_11049 >= 3 && level._id_11049 <= 5) {
      return 5000;
    } else if(level._id_11049 >= 6 && level._id_11049 <= 10) {
      return 10000;
    } else if(level._id_11049 >= 11 && level._id_11049 <= 15) {
      return 20000;
    } else if(level._id_11049 >= 16 && level._id_11049 <= 21) {
      return 35000;
    } else if(level._id_11049 >= 21) {
      return 50000;
    }
  }

  if(isDefined(level._id_E6BE)) {
    return level._id_E6BE;
  }

  return 0;
}

_id_107B7(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1.0;
  _id_D337(var_0);
}

_id_D343(var_0) {
  self setplayerdata("cp", "coopCareerStats", "currency", int(var_0));
}

_id_D337(var_0) {
  if(level.gametype != "cp_pvpve") {
    self setplayerdata("cp", "alienSession", "currency", int(var_0));
    _id_5530("currency", int(var_0), 1);
  }
}

_id_6F28(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(scripts\cp\utility::_id_8941() && !istrue(var_5)) {
    return;
  }
  if(scripts\cp\utility::_id_86C9()) {
    return;
  }
  if(var_0 <= 0) {
    return;
  }
  if(!istrue(var_3)) {
    var_0 = int(var_0 * _id_0946::_id_BBF2());
    var_0 = _id_072C::_id_C936(var_0, 5);
  }

  var_7 = scripts\cp\utility::_id_6875("zombie_point_scalar", self.team);
  var_0 = var_0 * var_7;

  if(isDefined(level._id_414B)) {
    var_0 = [[level._id_414B]](self, var_0);
  }

  var_8 = _id_666A();
  var_9 = _id_667D();
  var_10 = var_8 + var_0;
  var_10 = min(var_10, var_9);

  if(!isDefined(self._id_F35F)) {
    self._id_F35F = var_0;
  }

  if(_id_8706(var_4)) {
    self._id_F35F = self._id_F35F + (var_10 - var_8);
    self notify("consumable_charge", var_0 * 0.5);
  }

  level notify("currency_changed");
  _id_5530("currencytotal", int(self._id_F35F), 1);

  if(scripts\cp\utility::_id_871A()) {
    _id_D337(var_10);

    if(!istrue(var_6)) {
      thread _id_0756::_id_CC13(var_0, 1);
    }
  } else {
    _id_D337(var_10);

    if(!istrue(var_6)) {
      thread _id_0756::_id_CC13(var_0, 1);
    }

    return;
  }

  if(isDefined(level._id_FB8A)) {
    [[level._id_FB8A]](self, var_0);
  }

  var_11 = 30000;
  var_12 = gettime();

  if(var_10 >= var_9) {
    if(!isDefined(self._id_A473)) {
      self._id_A473 = var_12 + var_11;
    } else if(var_12 < self._id_A473) {
      return;
    }
    if(!level.gameended) {
      scripts\cp\utility::_id_D5E9("maxmoney", &"COOP_GAME_PLAY/MONEY_MAX", 4);
      self._id_A473 = var_12 + var_11;
    }
  }

  if(_id_8706(var_4)) {
    thread scripts\cp\utility::_id_1049("player_earned_money", var_0);
  }

  self notify("currency_earned", var_0);
}

_id_8706(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
    case "bonus":
    case "crafted":
    case "carpenter":
    case "magicboxRefund":
    case "pillage":
    case "atm":
    case "nuke":
      return 0;
    default:
      return 1;
  }

  return 1;
}

_id_ED93(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::_id_8941()) {
    return;
  }
  var_4 = _id_666A();
  var_5 = max(0, var_4 - var_0);
  var_6 = int(var_4 - var_5);

  if(getDvar("#x3a30c33efc8281eb1") != "zombie") {
    _id_D337(var_5);
    return;
  }

  if(isDefined(level._id_33F2)) {
    [[level._id_33F2]](self, var_2, var_3);
  }

  if(scripts\cp\utility::_id_8580("next_purchase_free") && var_0 >= 1 && var_2 != "atm" && var_2 != "laststand" && var_2 != "bleedoutPenalty") {
    scripts\cp\utility::_id_A689("next_purchase_free");
  } else {
    _id_D337(var_5);
  }

  if(var_6 < 1) {
    return;
  }
  if(isDefined(var_2)) {
    _id_0705::_id_FBCB(var_6, var_2);
  }

  _id_5530("currencyspent", var_6);

  if(scripts\cp\utility::_id_8580("door_buy_refund") && var_0 > 0) {
    if(var_2 != "atm" && var_2 != "laststand" && var_2 != "bleedoutPenalty") {
      _id_6F28(int(var_6 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::_id_A689("door_buy_refund");
    }
  }

  if(_id_0737::_id_DAAF(var_2)) {
    self notify("consumable_charge", var_0 * 0.07);
  }

  if(isDefined(var_1) && var_1) {
    return;
  }
}

_id_B4C5(var_0, var_1) {
  if(scripts\cp\utility::_id_8941()) {
    return 1;
  }

  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "atm" && var_1 != "laststand" && var_1 != "bleedoutPenalty") {
    if(scripts\cp\utility::_id_8580("next_purchase_free")) {
      var_0 = 0;
    }
  }

  var_2 = _id_666A();
  return var_2 >= var_0;
}

_id_F723(var_0) {
  if(_id_B4C5(var_0)) {
    _id_ED93(var_0);
    return 1;
  } else
    return 0;
}

_id_86F6(var_0) {
  var_1 = undefined;
  var_1 = strtok(var_0, "_")[0];
  var_2 = level._id_3AA5[var_0]._id_F981;
  var_3 = _id_6689();
  return var_3 >= var_2;
}

_id_B576() {
  level._id_1105F = undefined;
  _id_D34E(0);
  _id_D34C(0);
}

_id_D4E4(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_7, var_6 in level.players) {
    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && !isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1);
      continue;
    }
  }
}

_id_D12A() {
  _id_AE68();
  _id_5532();
  thread _id_552E();
}

_id_AE68() {
  level._id_5538 = [];
  var_0 = "cp/cp_eog_tracking_types.csv";
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    level._id_5538[var_1] = _func_0222(var_0, 0, var_1, 1);
    var_1++;
  }
}

_id_552E() {
  self endon("disconnect");
  wait 0.5;
  var_0 = self getentitynumber();
  var_1 = "unknownPlayer";

  if(isDefined(self.name)) {
    var_1 = self.name;
  }

  if(self _meth_8684()) {
    if(_id_75C8(var_1)) {
      var_1 = _id_C38F(var_1);
    }
  }

  var_2 = 8;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self setplayerdata("cp", "EoGPlayer", var_3, "connected", 0);
  }

  foreach(var_5 in level.players) {
    var_5 _id_C5B3(var_0);
    var_5 setplayerdata("cp", "EoGPlayer", var_0, "connected", 1);
    var_5 setplayerdata("cp", "EoGPlayer", var_0, "name", var_1);
    var_5 setplayerdata("common", "round", "totalXp", 0);
  }

  var_7 = [0, 0, 0, 0];

  foreach(var_9 in level.players) {
    var_10 = var_9 getentitynumber();
    var_7[int(var_10)] = 1;

    if(var_9 == self) {
      continue;
    }
    var_0 = var_9 getentitynumber();
    var_11 = var_9 getplayerdata("cp", "EoGPlayer", var_0, "connected");
    self setplayerdata("cp", "EoGPlayer", var_0, "connected", var_11);

    for(var_3 = 0; var_3 < level._id_5538.size; var_3++) {
      var_12 = var_9 getplayerdata("cp", "EoGPlayer", var_0, level._id_5538[var_3]);

      if(level._id_5538[var_3] != "currency" && getDvar("#x3a30c33efc8281eb1") != "cp_pvpve") {
        self setplayerdata("cp", "EoGPlayer", var_0, level._id_5538[var_3], var_12);
      }
    }
  }

  foreach(var_16, var_15 in var_7) {
    if(!var_15) {
      _id_C5B3(var_16);
    }
  }
}

_id_C5B3(var_0) {
  for(var_1 = 0; var_1 < level._id_5538.size; var_1++) {
    if(level._id_5538[var_1] == "name") {
      self setplayerdata("cp", "EoGPlayer", var_0, level._id_5538[var_1], "");
      continue;
    }

    self setplayerdata("cp", "EoGPlayer", var_0, level._id_5538[var_1], 0);
  }
}

_id_5532() {
  if(!isDefined(level._id_5535)) {
    level._id_5535 = ["kills", "headShots", "downs", "revives"];
  }

  _id_38CF();

  for(var_0 = 0; var_0 < level._id_5535.size; var_0++) {
    var_1 = int(_id_6484(level._id_5535[var_0]));
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var_0, var_1);
  }
}

_id_38CF() {
  for(var_0 = 0; var_0 < 7; var_0++) {
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var_0, 99);
  }
}

_id_6484(var_0) {
  return _func_0222("cp/cp_eog_tracking_types.csv", 1, var_0, 0);
}

_id_5534(var_0) {
  if(_id_0726::_id_60B9()) {
    return;
  }
  var_1 = var_0 getentitynumber();
  _id_D4E4("EoGPlayer", var_1, "connected", 0);
}

_id_5530(var_0, var_1, var_2) {
  var_3 = self getentitynumber();
  var_4 = var_1;

  if(!isDefined(var_2) || !var_2) {
    var_5 = self getplayerdata("cp", "EoGPlayer", var_3, var_0);

    if(isDefined(var_5)) {
      var_4 = int(var_5) + int(var_1);
    }
  }

  _id_F732(var_0, var_4, 1);
  _id_D4E4("EoGPlayer", var_3, var_0, var_4);

  if(isDefined(level._id_5536)) {
    _id_FB68(var_0, var_4);
  }
}

_id_FB68(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_5536.size; var_2++) {
    if(level._id_5536[var_2]._id_C189 == var_0) {
      level._id_5536[var_2]._id_4134 = var_1;
    }
  }
}

_id_552F(var_0, var_1) {
  var_2 = self getentitynumber();
  _id_D4E4("EoGPlayer", var_2, var_0, var_1);
}

_id_F732(var_0, var_1, var_2) {
  var_3 = _id_657C(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  _id_911C(var_3, var_1, var_2);
}

_id_911C(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_3 = var_1;
  } else {
    var_4 = self getplayerdata("cp", "alienSession", var_0);
    var_3 = var_4 + var_1;
  }

  self setplayerdata("cp", "alienSession", var_0, var_3);
}

_id_10DCC() {
  self._id_B011 = [];

  foreach(var_3, var_1 in level._id_3A5E) {
    if(strtok(var_3, "_")[0] == "weapon") {
      var_2 = _id_6383(var_3);
      self._id_B011[var_2] = 1;
    }
  }

  thread _id_B64A();
}

_id_6383(var_0) {
  var_1 = "";
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  var_3 = strtok(var_2, "_");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 == "weapon" && var_4 == 0) {
      continue;
    }
    if(var_5 == "zm") {
      var_1 = var_1 + "zm";
      break;
    }

    if(var_4 < var_3.size - 1) {
      var_1 = var_1 + (var_5 + "_");
      continue;
    }

    var_1 = var_1 + var_5;
    break;
  }

  if(var_1 == "") {
    return "none";
  }

  return var_1;
}

_id_10DDA(var_0, var_1) {
  self setplayerdata("cp", var_0, var_1, "hits", 0);
  self setplayerdata("cp", var_0, var_1, "shots", 0);
  self setplayerdata("cp", var_0, var_1, "kills", 0);
}

_id_FBEB(var_0, var_1, var_2) {
  if(!_id_870B(var_0, var_2)) {
    return;
  }
  _id_FBEA("weaponStats", var_0, "hits", var_1);
  var_3 = "personal";

  if(isDefined(level._id_B01D)) {
    var_3 = level._id_B01D;
  }

  _id_072C::_id_FBA7(var_3, "shots_hit", var_1);
}

_id_870B(var_0, var_1) {
  if(var_0 == "none") {
    return 0;
  }

  if(var_1 == "MOD_MELEE") {
    return 0;
  }

  if(_id_A53A(var_0)) {
    return 0;
  }

  return 1;
}

_id_A53A(var_0) {
  switch (var_0) {
    case "iw7_golf_club_zm_pap2":
    case "iw7_golf_club_zm_pap1":
    case "iw7_golf_club_zm":
    case "iw7_two_headed_axe_zm_pap2":
    case "iw7_spiked_bat_zm_pap2":
    case "iw7_spiked_bat_zm_pap1":
    case "iw7_spiked_bat_zm":
    case "iw7_machete_zm_pap2":
    case "iw7_machete_zm_pap1":
    case "iw7_machete_zm":
    case "iw7_two_headed_axe_zm_pap1":
    case "iw7_two_headed_axe_zm":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
    default:
      return 0;
  }
}

_id_FBED(var_0, var_1) {
  if(!self._id_DAE7) {
    return;
  }
  _id_FBEA("weaponStats", var_0, "shots", var_1);
  var_2 = "personal";

  if(isDefined(level._id_B01D)) {
    var_2 = level._id_B01D;
  }

  _id_072C::_id_FBA7(var_2, "shots_fired", var_1);
}

_id_FBEC(var_0, var_1) {
  _id_FBEA("weaponStats", var_0, "kills", var_1);
}

_id_FBEA(var_0, var_1, var_2, var_3) {
  if(!isPlayer(self)) {
    return;
  }
  var_4 = _id_6383(var_1);

  if(!isDefined(var_4) || !isDefined(self._id_B011[var_4])) {
    return;
  }
  if(isDefined(level._id_10D1A)) {
    var_4 = [[level._id_10D1A]](var_4);
  }

  if(issubstr(var_4, "dlc")) {
    var_5 = strtok(var_4, "d");
    var_4 = var_5[0] + "DLC";
    var_5 = strtok(var_5[1], "c");
    var_4 = var_4 + var_5[1];
  }

  var_6 = int(self getplayerdata("cp", var_0, var_4, var_2));
  var_7 = var_6 + int(var_3);
  self setplayerdata("cp", var_0, var_4, var_2, var_7);
}

_id_B64A() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = undefined;

    if(isDefined(var_0)) {
      var_1 = getcompleteweaponname(var_0);
    }

    var_2 = 1;
    _id_FBED(var_1, var_2);
  }
}

_id_C022() {
  if(!isDefined(level._id_11045)) {
    level._id_11045 = "cp/zombies/rankTable.csv";
  }

  level._id_11044 = [];
  level._id_11031 = int(_func_0222(level._id_11045, 0, "maxrank", 1));

  for(var_0 = 0; var_0 <= level._id_11031; var_0++) {
    var_1 = _id_66F7(var_0);

    if(var_1 == "") {
      break;
    }

    if(!isDefined(level._id_11044[var_0])) {
      var_2 = spawnStruct();
      var_2._id_7C8C = var_0;
      var_2._id_C189 = var_1;
      var_2._id_991E = _id_654F(var_0);
      var_2._id_7C3B = _id_6500(var_0);
      var_2._id_F2EA = _id_67D3(var_0);
      var_2._id_10FD5 = [];
      var_2._id_10FD5["min"] = _id_65AA(var_0);
      var_2._id_10FD5["next"] = _id_65E9(var_0);
      var_2._id_10FD5["max"] = _id_6598(var_0);
      var_2.name = [];
      var_2.name["short"] = _id_6757(var_0);
      var_2.name["full"] = _id_64BA(var_0);
      var_2.name["ingame"] = _id_6512(var_0);
      level._id_11044[var_0] = var_2;
    }
  }
}

_id_66F7(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 1);
}

_id_65AA(var_0) {
  return int(_func_0222(level._id_11045, 0, var_0, 2));
}

_id_6598(var_0) {
  return int(_func_0222(level._id_11045, 0, var_0, 7));
}

_id_65E9(var_0) {
  return int(_func_0222(level._id_11045, 0, var_0, 3));
}

_id_654F(var_0) {
  return int(_func_0222(level._id_11045, 0, var_0, 14));
}

_id_6757(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 4);
}

_id_64BA(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 5);
}

_id_6512(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 17);
}

_id_6500(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 6);
}

_id_67D3(var_0) {
  return int(_func_0222(level._id_11045, 0, var_0, 19));
}

_id_6779(var_0) {
  return _func_0222(level._id_11045, 0, var_0, 8);
}

_id_6689() {
  return self getplayerdata("cp", "progression", "playerLevel", "rank");
}

_id_669E() {
  return self getplayerdata("cp", "progression", "playerLevel", "xp");
}

_id_6686() {
  return self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

_id_668F() {
  return self getplayerdata("cp", "alienSession", "experience");
}

_id_D34E(var_0) {
  self setplayerdata("cp", "alienSession", "experience", var_0);
}

_id_6F33(var_0) {
  var_1 = _id_668F();
  var_2 = var_0 + var_1;
  _id_D34E(var_2);
}

_id_668E() {
  return self getplayerdata("cp", "alienSession", "shots");
}

_id_D34D(var_0) {
  self setplayerdata("cp", "alienSession", "shots", var_0);
}

_id_6F32(var_0) {
  var_1 = _id_668E();
  var_2 = var_0 + var_1;
  _id_D34D(var_2);
}

_id_D34C(var_0) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(var_0));
}

_id_668D() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

_id_FBB1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = _id_668D();
  var_2 = var_0 + var_1;
  _id_D34C(var_2);
}

_id_D34A(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", var_0);
}

_id_D359(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", var_0);

  if(isDefined(self._id_F389)) {
    self setplayerdata("common", "round", "totalXp", self._id_F389);
  }
}

_id_D349(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", var_0);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

_id_66EB(var_0) {
  var_1 = 0;

  if(var_0 >= level._id_11044[level._id_11031]._id_10FD5["max"]) {
    return level._id_11031;
  }

  if(isDefined(level._id_11044)) {
    for(var_2 = 0; var_2 < level._id_11044.size; var_2++) {
      if(var_0 >= level._id_11044[var_2]._id_10FD5["min"]) {
        if(var_0 < level._id_11044[var_2]._id_10FD5["max"]) {
          var_1 = level._id_11044[var_2]._id_7C8C;
          break;
        }
      }
    }
  }

  return var_1;
}

_id_6723(var_0, var_1) {
  return int(var_1 * _id_6550(var_0) * _id_684C(var_0));
}

_id_6550(var_0) {
  if(isDefined(var_0._id_10FD9)) {
    return var_0._id_10FD9;
  } else {
    return 1;
  }
}

_id_106C9(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait(var_1);
  _id_6F38(var_0);
}

_id_684C(var_0) {
  if(isDefined(var_0._id_10D0E) && istrue(var_0._id_8D5A)) {
    var_0._id_8D5A = 0;
    return var_0._id_10D0E;
  } else
    return 1;
}

_id_6F38(var_0, var_1) {
  var_0 = _id_6723(self, var_0);

  if(isDefined(self._id_F389)) {
    self._id_F389 = self._id_F389 + var_0;
  }

  thread _id_6F33(var_0);
  var_2 = 0;
  var_3 = _id_6689();
  var_4 = _id_669E();
  var_5 = var_4 + var_0;
  _id_D359(var_5);

  if(istrue(var_1) && var_0 > 0 && !scripts\cp\utility::_id_871A()) {
    self setclientomnvar("zom_xp_reward", var_0);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  var_6 = _id_66EB(var_5);

  if(var_6 > var_3) {
    if(var_6 == level._id_11031 + 1) {
      var_2 = 1;
    }

    _id_D34A(var_6);

    if(var_2 == 0) {
      var_7 = var_6 + 1;
      var_8 = _id_6779(var_6);
      self notify("ranked_up", var_6);
      _id_FBB1();
    }

    _id_BD59(var_6);
  }
}

_id_BD59(var_0) {
  _id_0741::_id_BD77("mt_prestige_1");

  if(var_0 >= 40) {
    _id_0741::_id_BD77("mt_prestige_2");
  }

  if(var_0 >= 60) {
    _id_0741::_id_BD77("mt_prestige_3");
  }

  if(var_0 >= 80) {
    _id_0741::_id_BD77("mt_prestige_4");
  }

  if(var_0 >= 100) {
    _id_0741::_id_BD77("mt_prestige_5");
  }

  if(var_0 >= 120) {
    _id_0741::_id_BD77("mt_prestige_6");
  }

  if(var_0 >= 140) {
    _id_0741::_id_BD77("mt_prestige_7");
  }

  if(var_0 >= 160) {
    _id_0741::_id_BD77("mt_prestige_8");
  }

  if(var_0 >= 180) {
    _id_0741::_id_BD77("mt_prestige_9");
  }

  if(var_0 >= 200) {
    _id_0741::_id_BD77("mt_prestige_10");
  }
}

_id_7D93(var_0, var_1, var_2) {
  var_3 = self getplayerdata("cp", var_0, var_1);
  var_4 = var_3 + var_2;
  self setplayerdata("cp", var_0, var_1, var_4);
}

_id_7D92(var_0, var_1) {
  _id_7D93("alienSession", var_0, var_1);
}

_id_64ED() {
  return _id_6320("hivesDestroyed");
}

_id_6320(var_0) {
  return self getplayerdata("cp", "alienSession", var_0);
}

_id_D140(var_0, var_1) {
  self setplayerdata("cp", "alienSession", var_0, var_1);
}

_id_FB5A(var_0) {
  if(isDefined(level._id_FB5B)) {
    var_0[[level._id_FB5B]]();
  } else {
    var_0 _id_072C::_id_FBA7(_id_072C::_id_67C3(), "team_support_deploy");
  }
}

_id_FB79(var_0) {
  foreach(var_2 in level.players) {
    var_2 _id_911C("challengesAttempted", 1);

    if(var_0) {
      var_2 _id_911C("challengesCompleted", 1);
    }
  }
}

_id_FB7B(var_0) {
  foreach(var_2 in level.players) {
    var_2 _id_911C("waveNum", var_0, 1);
  }
}

_id_FB7A(var_0, var_1) {
  var_2 = _id_6547(var_1);

  foreach(var_4 in var_0) {
    var_4 _id_911C("escapedRank" + var_2, 1, 1);
    var_4 _id_911C("hits", 1, 1);
  }
}

_id_FB37(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(scripts\cp\utility::_id_86EC(var_0)) {
    var_1 _id_911C("trapKills", 1);
  }
}

_id_C1F3(var_0) {
  level._id_5608 = var_0;
}

_id_6547(var_0) {
  for(var_1 = 0; var_1 < level._id_5608.size - 1; var_1++) {
    if(var_0 >= level._id_5608[var_1] && var_0 < level._id_5608[var_1 + 1]) {
      return var_1;
    }
  }
}

_id_75C8(var_0) {
  return issubstr(var_0, "[") && issubstr(var_0, "]");
}

_id_C38F(var_0) {
  var_1 = strtok(var_0, "]");
  return var_1[1];
}

_id_C1E2() {
  var_0 = [];
  var_1["kills"] = "kills";
  var_1["deployables"] = "deployables";
  var_1["drillplants"] = "drillPlants";
  var_1["revives"] = "revives";
  var_1["downs"] = "downed";
  var_1["drillrestarts"] = "repairs";
  var_1["score"] = "score";
  var_1["currencyspent"] = "currencySpent";
  var_1["currencytotal"] = "currencyTotal";
  var_1["hivesdestroyed"] = "hivesDestroyed";
  var_1["waveNum"] = "waveNum";
  level._id_5533 = var_1;
}

_id_657C(var_0) {
  return level._id_5533[var_0];
}

_id_B2F0() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    _id_911C("time", 1);
  }
}

_id_C13B(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::_id_8891(var_0, var_1, var_2, var_3)) {
    _id_7DDD(var_3);
    var_3 _id_5530("headShots", 1);
  }

  var_3 _id_7DDE(var_3);
  var_3 _id_5530("kills", 1);
  var_3 _id_0705::_id_9723("zombie_death", 1, [var_3._id_399D], [var_3._id_399D], [var_3._id_399D]);
}

_id_7DE4(var_0) {
  if(isDefined(var_0._id_10CA1)) {
    _id_7DE7(var_0, "Total_Waves", level._id_10C9F - var_0._id_10CA1);
  } else {
    _id_7DE7(var_0, "Total_Waves", level._id_10C9F);
  }
}

_id_7DE3(var_0) {
  _id_7DE7(var_0, "Total_Score", var_0._id_CBDD);
}

_id_7DE1(var_0) {
  _id_7DE7(var_0, "Shots_Fired", 1);
}

_id_7DE2(var_0) {
  _id_7DE7(var_0, "Shots_on_Target", 1);
}

_id_7DDC(var_0) {
  _id_7DE7(var_0, "Explosive_Kills", 1);
}

_id_7DDA(var_0) {
  _id_7DE7(var_0, "Doors_Opened", 1);
}

_id_7DDF(var_0) {
  _id_7DE7(var_0, "Perks_Used", 1);
}

_id_7DDE(var_0) {
  _id_7DE7(var_0, "Kills", 1);

  if(_id_DAED()) {
    _id_FCA4(var_0, "Kills", 1, level.script, level.players.size, 1);
  }
}

_id_7DDD(var_0) {
  var_0 _id_7DE7(var_0, "Headshot_Kills", 1);

  if(_id_DAED()) {
    _id_FCA4(var_0, "Headshots", 1, level.script, level.players.size, 1);
  }
}

_id_7DE0(var_0) {
  var_0 _id_7DE7(var_0, "Revives", 1);

  if(_id_DAED()) {
    _id_FCA4(var_0, "Revives", 1, level.script, level.players.size, 1);
  }
}

_id_7DDB(var_0) {
  var_0 _id_7DE7(var_0, "Downs", 1);

  if(_id_DAED()) {
    _id_FCA4(var_0, "Downs", 1, level.script, level.players.size, 1);
  }
}

_id_5206() {
  level._id_9133 = 1;
}

_id_DAED() {
  return istrue(level._id_9133);
}

_id_FBB3(var_0, var_1) {
  foreach(var_3 in level.players) {
    _id_FBAB(var_3, var_0, var_1, level.players.size);
  }
}

_id_FBAB(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_871A()) {
    _id_FC8C(var_0, "Highest_Wave", var_1);
    _id_342F(var_0, var_1, "Highest_Wave", level.script, var_2);
    _id_FCA4(var_0, "Rounds", var_1, level.script, var_2, 1);
  }
}

_id_7DE7(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_0 getplayerdata("cp", "coopCareerStats", var_1);
  var_4 = var_3 + var_2;
  var_0 setplayerdata("cp", "coopCareerStats", var_1, int(var_4));
}

_id_FC8C(var_0, var_1, var_2) {
  var_3 = var_0 getplayerdata("cp", "coopCareerStats", var_1);

  if(var_2 > var_3) {
    var_0 setplayerdata("cp", "coopCareerStats", var_1, var_2);
  }
}

_id_FB74(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2);

  if(var_1 > var_5) {
    var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
  }
}

_id_342F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_id_DAED()) {
    var_6 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2);

    if(!istrue(var_5)) {
      if(var_1 > var_6) {
        var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
      }
    } else if(var_1 < var_6)
      var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
  }
}

_id_FCA4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_id_DAED()) {
    if(!isDefined(var_5)) {
      var_5 = 1;
    }

    var_6 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1);
    var_2 = var_6 + var_5;

    if(var_2 > var_6) {
      var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1, var_2);
    }
  }
}