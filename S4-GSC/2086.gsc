/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2086.gsc
*************************************************/

init() {
  loadweaponranktable();
  var_0 = getdvarint("#x3d4b34b03f860fb63", 1);
  addglobalweaponrankxpmultiplier(var_0, "online_mp_weapon_xpscale");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      if(level.weaponxpenabled) {
        var_1 = getdvarint("#x3b7dac4a1488a8d02");
        var_2 = var_0 getprivatepartysize() > 1;

        if(var_2) {
          var_0 _id_1188(var_1, "online_mp_party_weapon_xpscale");
        }
      }
    }
  }
}

loadweaponranktable() {
  level._id_10DC3 = spawnStruct();
  level._id_10DC3._id_C027 = [];
  var_0 = 0;

  for(;;) {
    var_1 = int(tablelookuprownum("mp/weaponRankTable.csv", 0, var_0));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_2 = spawnStruct();
    level._id_10DC3._id_C027[var_0] = var_2;
    var_2._id_9F49 = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 1));
    var_2._id_10FDC = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 2));
    var_2._id_9CC1 = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 3));
    var_0++;
  }

  level._id_10DC3.maxrank = var_0 - 1;
  level._id_10DC3._id_9CBF = [];
  var_1 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = tablelookupbyrow("mp/statstable.csv", var_3, 4);
    var_5 = tablelookupbyrow("mp/statstable.csv", var_3, 42);

    if(!isDefined(var_4) || var_4 == "" || !isDefined(var_5) || var_5 == "") {
      continue;
    }
    var_5 = int(var_5);
    level._id_10DC3._id_9CBF[var_4] = var_5;
  }
}

_id_6C70(var_0) {
  var_1 = _id_6C71(var_0);
  var_2 = _id_6E82(var_1);
  return var_2;
}

_id_6C71(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  switch (var_1) {
    case "mp":
      var_2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_0, "mpXP");
      return var_2;
    case "cp":
      var_3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_0, "cpXP");
      return var_3;
    case "all":
      var_2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_0, "mpXP");
      var_3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_0, "cpXP");
      return var_2 + var_3;
  }
}

_id_89A9(var_0) {
  var_1 = _id_6C71(var_0);
  var_2 = _id_6E7A(var_0);
  return var_1 >= var_2;
}

_id_10DD2(var_0) {
  return 1;
}

_id_10D9D(var_0) {
  if(!isDefined(level._id_10DC3._id_9CBF[var_0])) {
    return 0;
  }

  var_1 = level._id_10DC3._id_9CBF[var_0] > 0;
  return var_1;
}

_id_6E7A(var_0) {
  var_1 = _id_6B4D(var_0);
  return _id_6E83(var_1);
}

_id_6E82(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  for(var_1 = _id_6B4C() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= _id_6E84(var_1)) {
      return var_1;
    }
  }

  return var_1;
}

_id_6B4D(var_0) {
  return level._id_10DC3._id_9CBF[var_0];
}

_id_6B4C() {
  return level._id_10DC3.maxrank;
}

_id_6E84(var_0) {
  return level._id_10DC3._id_C027[var_0]._id_9F49;
}

_id_6E85(var_0) {
  return level._id_10DC3._id_C027[var_0]._id_10FDC;
}

_id_6E83(var_0) {
  return level._id_10DC3._id_C027[var_0]._id_9CC1;
}

_id_6FD1(var_0, var_1, var_2) {
  if(isai(self) || !isPlayer(self) || !isDefined(var_2) || var_2 == 0 || !level.weaponxpenabled) {
    return;
  }
  var_3 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(!self _meth_81C8(var_3, "weapon")) {
    return;
  }
  if(!_id_10D9D(var_3)) {
    return;
  }
  var_4 = _id_C328(var_1);

  if(var_4 != var_1) {
    var_1 = var_4;
    var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  if(var_2 < 0) {
    return;
  }
  var_5 = var_2;
  var_2 = var_2 * _id_6E87(var_0);
  var_2 = int(var_2);
  var_6 = _id_6C71(var_3, "mp");
  var_7 = _id_6C71(var_3, "cp");
  var_8 = var_6 + var_7;
  var_9 = _id_6E82(var_8);
  var_10 = _id_6E7A(var_3);
  var_11 = var_10 - var_7;
  var_12 = var_6 + var_2;

  if(var_12 > var_11) {
    var_12 = var_11;
  }

  var_13 = var_12 + var_7;
  var_14 = _id_6B4D(var_3);
  var_15 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_3, "prestige");
  var_16 = int(min(_id_6E82(var_13), var_14));
  _id_07A9::_id_976C(var_0, var_15, var_16, var_2, var_1);

  if(var_9 < var_16) {
    var_17 = "weapon_rank_up_0_4";

    if(var_16 >= 15) {
      var_17 = "weapon_rank_up_15_plus";
    } else if(var_16 >= 10) {
      var_17 = "weapon_rank_up_10_14";
    } else if(var_16 >= 5) {
      var_17 = "weapon_rank_up_5_9";
    }

    var_18 = scripts\mp\rank::getscoreinfovalue(var_17);
    scripts\mp\rank::giverankxp(var_17, var_18);
  }

  return var_2;
}

_id_C328(var_0) {
  switch (var_0) {
    case "kill":
      var_0 = "kill_weapon";
      break;
    case "challenge":
      var_0 = "weapon_challenge";
      break;
  }

  return var_0;
}

addglobalweaponrankxpmultiplier(var_0, var_1) {
  level _id_1188(var_0, var_1);
}

_id_6A75() {
  return level _id_6E86();
}

_id_6C40() {
  if(self _meth_8754()) {
    return _func_040E();
  }

  return 1.0;
}

_id_1188(var_0, var_1) {
  if(!isDefined(self._id_10DC4)) {
    self._id_10DC4 = [];
  }

  if(isDefined(self._id_10DC4[var_1])) {
    self._id_10DC4[var_1] = max(self._id_10DC4[var_1], var_0);
  } else {
    self._id_10DC4[var_1] = var_0;
  }
}

_id_6E86() {
  if(!isDefined(self._id_10DC4)) {
    return 1.0;
  }

  var_0 = 1.0;

  foreach(var_2 in self._id_10DC4) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

_id_C4CA(var_0) {
  level _id_C540(var_0);
}

_id_C540(var_0) {
  if(!isDefined(self._id_10DC4)) {
    return;
  }
  if(!isDefined(self._id_10DC4[var_0])) {
    return;
  }
  self._id_C02A[var_0] = undefined;
}

_id_6E87(var_0) {
  var_1 = _id_6E86();
  var_2 = _id_6A75();
  var_3 = _id_6A67();
  var_4 = _id_6C40();
  var_5 = scripts\mp\rank::getintensityxpmultiplier();
  var_6 = scripts\mp\rank::getmapxpmultiplier();
  var_7 = getweaponclassweaponxpmultiplier(var_0);
  var_8 = scripts\engine\utility::ter_op(_func_0478(self), 1.1, 1.0);
  var_9 = 1.0;
  var_10 = _func_047A(self, 1);

  if(isDefined(scripts\engine\utility::_id_1BAB(var_10, self)) && var_10.size > 1) {
    var_9 = var_9 * 1.25;
  }

  var_11 = var_1 * var_2 * var_3 * var_4 * var_5 * var_6 * var_9 * var_8 * var_7;
  return var_11;
}

getweaponclassweaponxpmultiplier(var_0) {
  var_1 = 1.0;

  if(!isDefined(var_0)) {
    return var_1;
  }

  var_2 = _id_07BC::getweaponclassenum(var_0);

  switch (var_2) {
    case 4:
      var_1 = 1.2;
  }

  if(isDefined(var_0.basename)) {
    if(issubstr(var_0.basename, "aromeo99")) {
      var_1 = 1.8;
    } else if(issubstr(var_0.basename, "moscar")) {
      var_1 = 1.7;
    }
  }

  return var_1;
}

_id_6A67() {
  if(!isDefined(level._id_60FB)) {
    level._id_60FB = float(_func_0222("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 19));
  }

  return level._id_60FB;
}

_id_6A63() {
  if(!isDefined(level._id_60F4)) {
    level._id_60F4 = int(_func_0222("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 20));
  }

  return level._id_60F4;
}

_id_6A64() {
  if(!isDefined(level._id_60F5)) {
    var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit"));

    if(var_0 == 0) {
      var_0 = 900;
    }

    var_1 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_winlimit"));

    if(var_1 > 0) {
      var_0 = var_0 * (var_1 * 2 - 1);
    }

    level._id_60F5 = _id_6A63() / 60 * (var_0 / 60);
  }

  return level._id_60F5;
}