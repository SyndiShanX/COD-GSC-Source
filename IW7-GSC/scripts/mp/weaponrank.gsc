/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\weaponrank.gsc
*********************************************/

init() {
  loadweaponranktable();
  var_0 = getdvarint("online_mp_weapon_xpscale", 1);
  addglobalweaponrankxpmultiplier(var_0, "online_mp_weapon_xpscale");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isai(var_0)) {
      if(var_0 scripts\mp\utility::rankingenabled()) {
        var_1 = getdvarint("online_mp_party_weapon_xpscale");
        var_2 = var_0 func_85BE() > 1;
        if(var_2) {
          var_0 addweaponrankxpmultiplier(var_1, "online_mp_party_weapon_xpscale");
        }
      }
    }
  }
}

loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];
  var_0 = 0;
  for(;;) {
    var_1 = int(tablelookuprownum("mp\weaponRankTable.csv", 0, var_0));
    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_2 = spawnStruct();
    level.weaponranktable.rankinfo[var_0] = var_2;
    var_2.minxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 1));
    var_2.xptonextrank = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 2));
    var_2.maxxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 3));
    var_0++;
  }

  level.weaponranktable.maxrank = var_0 - 1;
  level.weaponranktable.maxweaponranks = [];
  var_3 = 1;
  for(;;) {
    var_1 = int(tablelookuprownum("mp\statstable.csv", 0, var_3));
    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_4 = tablelookupbyrow("mp\statstable.csv", var_1, 4);
    var_5 = tablelookupbyrow("mp\statstable.csv", var_1, 42);
    if(!isDefined(var_4) || var_4 == "" || !isDefined(var_5) || var_5 == "") {} else {
      var_5 = int(var_5);
      level.weaponranktable.maxweaponranks[var_4] = var_5;
    }

    var_3++;
  }
}

getplayerweaponrank(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponrankforxp(var_1);
  return var_2;
}

getplayerweaponrankxp(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  switch (var_1) {
    case "mp":
      var_2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_0, "mpXP");
      return var_2;

    case "cp":
      var_3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_1, "cpXP");
      return var_3;

    case "all":
      var_2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_2, "mpXP");
      var_3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_1, "cpXP");
      return var_2 + var_3;
  }
}

isplayerweaponatmaxxp(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponmaxrankxp(var_0);
  return var_1 >= var_2;
}

func_13CCA(var_0) {
  if(!self isitemunlocked("cac", "feature")) {
    return 0;
  }

  var_1 = scripts\mp\utility::getweaponrootname(var_0);
  return func_13C97(var_1);
}

func_13C97(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0])) {
    return 0;
  }

  return level.weaponranktable.maxweaponranks[var_0] > 0;
}

getweaponmaxrankxp(var_0) {
  var_1 = getmaxweaponrankforrootweapon(var_0);
  return getweaponrankinfomaxxp(var_1);
}

getweaponrankforxp(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  for(var_1 = getmaxweaponrank() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= getweaponrankinfominxp(var_1)) {
      return var_1;
    }
  }

  return var_1;
}

func_7FA6(var_0) {
  var_1 = scripts\mp\utility::getweaponrootname(var_0);
  return getmaxweaponrankforrootweapon(var_1);
}

getmaxweaponrankforrootweapon(var_0) {
  return level.weaponranktable.maxweaponranks[var_0];
}

getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

getweaponrankinfominxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

playlocalsound(var_0) {
  return level.weaponranktable.rankinfo[var_0].xptonextrank;
}

getweaponrankinfomaxxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
}

func_8394(var_0, var_1, var_2) {
  if(isai(self) || !isPlayer(self) || !isDefined(var_2) || var_2 == 0 || !scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_3 = scripts\mp\utility::getweaponrootname(var_0);
  if(!self isitemunlocked(var_3, "weapon")) {
    return;
  }

  if(!func_13C97(var_3)) {
    return;
  }

  var_4 = remapscoreeventforweapon(var_1);
  if(var_4 != var_1) {
    var_1 = var_4;
    var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  if(var_2 < 0) {
    return;
  }

  var_5 = var_2;
  var_2 = var_2 * func_8233();
  var_2 = int(var_2);
  if(var_2 > getweaponmaxrankxp(var_3)) {
    return;
  }

  var_6 = getplayerweaponrankxp(var_3, "mp");
  var_7 = getplayerweaponrankxp(var_3, "cp");
  var_8 = var_6 + var_7;
  var_9 = getweaponrankforxp(var_8);
  var_10 = getweaponmaxrankxp(var_3);
  var_11 = var_10 - var_7;
  var_12 = var_6 + var_2;
  if(var_12 > var_11) {
    var_12 = var_11;
  }

  var_13 = var_12 + var_7;
  var_14 = getmaxweaponrankforrootweapon(var_3);
  var_15 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_3, "prestige");
  var_10 = int(min(getweaponrankforxp(var_13), var_14));
  scripts\mp\analyticslog::logevent_givempweaponxp(var_0, var_15, var_10, var_2, var_1);
  self setplayerdata("common", "sharedProgression", "weaponLevel", var_3, "mpXP", var_12);
  var_11 = getweaponvariantindex(var_0);
  scripts\mp\matchdata::func_AFDC(var_3, "xp", var_2, var_11);
  if(var_9 < var_10) {
    scripts\mp\hud_message::showsplash("ranked_up_weapon_" + var_3, var_10 + 1);
    var_12 = "weapon_rank_up_0_4";
    if(var_10 >= 15) {
      var_12 = "weapon_rank_up_15_plus";
    } else if(var_10 >= 10) {
      var_12 = "weapon_rank_up_10_14";
    } else if(var_10 >= 5) {
      var_12 = "weapon_rank_up_5_9";
    }

    var_13 = scripts\mp\rank::getscoreinfovalue(var_12);
    scripts\mp\rank::giverankxp(var_12, var_13);
  }
}

remapscoreeventforweapon(var_0) {
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
  level addweaponrankxpmultiplier(var_0, var_1);
}

getglobalweaponrankxpmultiplier() {
  return level getweaponrankxpmultiplier();
}

addweaponrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    self.weaponrankxpmultipliers = [];
  }

  if(isDefined(self.weaponrankxpmultipliers[var_1])) {
    self.weaponrankxpmultipliers[var_1] = max(self.weaponrankxpmultipliers[var_1], var_0);
    return;
  }

  self.weaponrankxpmultipliers[var_1] = var_0;
}

getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return 1;
  }

  var_0 = 1;
  foreach(var_2 in self.weaponrankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 = var_0 * var_2;
  }

  return var_0;
}

removeglobalweaponrankxpmultiplier(var_0) {
  level removeweaponrankxpmultiplier(var_0);
}

removeweaponrankxpmultiplier(var_0) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.weaponrankxpmultipliers[var_0])) {
    return;
  }

  self.rankxpmultipliers[var_0] = undefined;
}

func_8233() {
  var_0 = getweaponrankxpmultiplier();
  var_1 = getglobalweaponrankxpmultiplier();
  return var_0 * var_1;
}