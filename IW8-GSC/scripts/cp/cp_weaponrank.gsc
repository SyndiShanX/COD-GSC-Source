/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weaponrank.gsc
***********************************************/

function init() {
  loadweaponranktable();
  var_0 = getdvarint("online_mp_weapon_xpscale", 1);
  addglobalweaponrankxpmultiplier(var_0, "online_mp_weapon_xpscale");
  thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      if(level.weaponxpenabled) {
        var_1 = getdvarint("online_mp_party_weapon_xpscale");
        var_2 = var_0 getprivatepartysize() > 1;

        if(var_2) {
          addweaponrankxpmultiplier(var_0, var_1, "online_mp_party_weapon_xpscale");
        }

        var_3 = getdvarint("scr_weaponxp_limit", 40000);
        var_0.ref_11B7E = var_3;
        var_0.ref_13BFC = 0;
        var_0.ref_14677 = [];

        foreach(var_3 in level.weaponranktable.maxweaponranks) {
          var_0.ref_14677[var_5 + "_mp"] = 0;
        }
      }
    }
  }
}

function loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];

  for(var_0 = 0;; var_0++) {
    var_1 = int(tablelookuprownum("mp/weaponRankTable.csv", 0, var_0));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_2 = spawnStruct();
    level.weaponranktable.rankinfo[var_0] = var_2;
    var_2.minxp = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 1));
    var_2.xptonextrank = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 2));
    var_2.maxxp = int(tablelookupbyrow("mp/weaponRankTable.csv", var_0, 3));
  }

  level.weaponranktable.maxrank = var_0 - 1;
  level.weaponranktable.maxweaponranks = [];

  for(var_3 = 1;; var_3++) {
    var_1 = int(tablelookuprownum("mp/statstable.csv", 0, var_3));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_4 = tablelookupbyrow("mp/statstable.csv", var_1, 4);
    var_5 = tablelookupbyrow("mp/statstable.csv", var_1, 42);

    if(!isDefined(var_4) || var_4 == "" || !isDefined(var_5) || var_5 == "") {
      continue;
    }

    var_5 = int(var_5);
    level.weaponranktable.maxweaponranks[var_4] = var_5;
  }
}

function getplayerweaponrank(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponrankforxp(var_1);
  return var_2;
}

function getplayerweaponrankxp(var_0, var_1) {
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
      var_3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var_2, "cpXP");
      return (var_2 + var_3);
  }
}

function isplayerweaponatmaxxp(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponmaxrankxp(var_0);
  return var_1 >= var_2;
}

function weaponshouldgetxp(var_0) {
  if(self.pers["rank"] < 3 && !getdvarint("force_ranking")) {
    return 0;
  }

  var_1 = scripts\cp\utility::getweaponrootname(var_0);
  return weaponhasranks(var_1);
}

function weaponhasranks(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0])) {
    return 0;
  }

  var_1 = level.weaponranktable.maxweaponranks[var_0] > 0;
  return var_1;
}

function getweaponmaxrankxp(var_0) {
  var_1 = getmaxweaponrankforrootweapon(var_0);
  return getweaponrankinfomaxxp(var_1);
}

function getweaponrankforxp(var_0) {
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

function getmaxweaponrankforrootweapon(var_0) {
  return level.weaponranktable.maxweaponranks[var_0];
}

function getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

function getweaponrankinfominxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

function getweaponrankinfoxptonextrank(var_0) {
  return level.weaponranktable.rankinfo[var_0].xptonextrank;
}

function getweaponrankinfomaxxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
}

function giveplayerweaponxp(var_0, var_1, var_2) {
  if(isai(self) || !isPlayer(self) || !isDefined(var_2) || var_2 == 0 || !level.weaponxpenabled) {
    return;
  }

  var_3 = scripts\cp\utility::getweaponrootname(var_0.basename);

  if(!self isitemunlocked(var_3, "weapon")) {
    return;
  }

  if(!weaponhasranks(var_3)) {
    return;
  }

  var_4 = remapscoreeventforweapon(var_1);

  if(var_4 != var_1) {
    var_1 = var_4;
    var_2 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_1);
  }

  if(var_2 < 0) {
    return;
  }

  var_5 = var_2;
  var_2 *= getweaponrankxpmultipliertotal();
  var_2 = int(var_2);
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
  var_16 = int(min(getweaponrankforxp(var_13), var_14));
  scripts\cp\cp_analytics::ref_119B3(var_0, var_15, var_16, var_2, var_1);

  if(var_9 < var_16) {
    var_17 = "weapon_rank_up_0_4";

    if(var_16 >= 15) {
      var_17 = "weapon_rank_up_15_plus";
    } else if(var_16 >= 10) {
      var_17 = "weapon_rank_up_10_14";
    } else if(var_16 >= 5) {
      var_17 = "weapon_rank_up_5_9";
    }

    var_18 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_17);
    scripts\cp\drone\emp_drone::giverankxp(var_17, var_18);
  }

  return var_2;
}

function remapscoreeventforweapon(var_0) {
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

function addglobalweaponrankxpmultiplier(var_0, var_1) {
  addweaponrankxpmultiplier(level, var_0, var_1);
}

function getglobalweaponrankxpmultiplier() {
  return getweaponrankxpmultiplier(level);
}

function respawntagvisibility() {
  if(self resetclientkillstreakindexes()) {
    return sortbydistancecullbyradius();
  }

  return 1;
}

function addweaponrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    self.weaponrankxpmultipliers = [];
  }

  if(isDefined(self.weaponrankxpmultipliers[var_1])) {
    self.weaponrankxpmultipliers[var_1] = max(self.weaponrankxpmultipliers[var_1], var_0);
    return;
  }

  self.weaponrankxpmultipliers[var_1] = var_0;
}

function getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.weaponrankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function removeglobalweaponrankxpmultiplier(var_0) {
  removeweaponrankxpmultiplier(level, var_0);
}

function removeweaponrankxpmultiplier(var_0) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.weaponrankxpmultipliers[var_0])) {
    return;
  }

  self.rankxpmultipliers[var_0] = undefined;
}

function getweaponrankxpmultipliertotal() {
  var_0 = getweaponrankxpmultiplier();
  var_1 = getglobalweaponrankxpmultiplier();
  var_2 = reloadnotehandler();
  var_3 = respawntagvisibility();
  var_4 = getdvarfloat("scr_weaponxp_scalar", 1);
  var_5 = 1;
  var_6 = function_0446(self, 1);

  if(isDefined(scripts\engine\utility::array_find(var_6, self)) && var_6.size > 1) {
    var_5 *= 1.25;
  }

  return var_0 * var_1 * var_2 * var_4 * var_3 * var_5;
}

function reloadnotehandler() {
  if(!isDefined(level.playplundersound)) {
    level.playplundersound = float(tablelookup("mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 19));
  }

  return level.playplundersound;
}

function reload_handle_hintstring() {
  if(!isDefined(level.playjumpsoundtosquad)) {
    level.playjumpsoundtosquad = int(tablelookup("mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 20));
  }

  return level.playjumpsoundtosquad;
}

function reload_use_think() {
  if(!isDefined(level.playkillstreakdeploydialog)) {
    var_0 = getdvarint("scr_" + scripts\cp\utility::getgametype() + "_timelimit");

    if(var_0 == 0) {
      var_0 = 900;
    }

    var_1 = getdvarint("scr_" + scripts\cp\utility::getgametype() + "_winlimit");

    if(var_1 > 0) {
      var_0 *= var_1 * 2 - 1;
    }

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * var_0 / 60;
  }

  return level.playkillstreakdeploydialog;
}