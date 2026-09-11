/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weaponrank.gsc
***********************************************/

function init() {
  loadweaponranktable();
  var0 = getdvarint("PMORNPNTK", 1);
  addglobalweaponrankxpmultiplier(var0, "online_mp_weapon_xpscale");
  thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isai(var0)) {
      if(level.weaponxpenabled) {
        var1 = getdvarint("LNQMMNNPSR");
        var2 = var0 getprivatepartysize() > 1;

        if(var2) {
          addweaponrankxpmultiplier(var0, var1, "online_mp_party_weapon_xpscale");
        }

        var3 = getdvarint("scr_weaponxp_limit", 40000);
        var0.ref_11b7e = var3;
        var0.ref_13bfc = 0;
        var0.ref_14677 = [];

        foreach(var3 in level.weaponranktable.maxweaponranks) {
          var0.ref_14677[var5 + "_mp"] = 0;
        }
      }
    }
  }
}

function loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];

  for(var0 = 0;; var0++) {
    var1 = int(tablelookuprownum("mp/weaponRankTable.csv", 0, var0));

    if(!isDefined(var1) || var1 < 0) {
      break;
    }

    var2 = spawnStruct();
    level.weaponranktable.rankinfo[var0] = var2;
    var2.minxp = int(tablelookupbyrow("mp/weaponRankTable.csv", var0, 1));
    var2.xptonextrank = int(tablelookupbyrow("mp/weaponRankTable.csv", var0, 2));
    var2.maxxp = int(tablelookupbyrow("mp/weaponRankTable.csv", var0, 3));
  }

  level.weaponranktable.maxrank = var0 - 1;
  level.weaponranktable.maxweaponranks = [];

  for(var3 = 1;; var3++) {
    var1 = int(tablelookuprownum("mp/statstable.csv", 0, var3));

    if(!isDefined(var1) || var1 < 0) {
      break;
    }

    var4 = tablelookupbyrow("mp/statstable.csv", var1, 4);
    var5 = tablelookupbyrow("mp/statstable.csv", var1, 42);

    if(!isDefined(var4) || var4 == "" || !isDefined(var5) || var5 == "") {
      continue;
    }

    var5 = int(var5);
    level.weaponranktable.maxweaponranks[var4] = var5;
  }
}

function getplayerweaponrank(var0) {
  var1 = getplayerweaponrankxp(var0);
  var2 = getweaponrankforxp(var1);
  return var2;
}

function getplayerweaponrankxp(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "all";
  }

  switch (var1) {
    case "mp":
      var2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var0, "mpXP");
      return var2;
    case "cp":
      var3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var1, "cpXP");
      return var3;
    case "all":
      var2 = self getplayerdata("common", "sharedProgression", "weaponLevel", var2, "mpXP");
      var3 = self getplayerdata("common", "sharedProgression", "weaponLevel", var2, "cpXP");
      return (var2 + var3);
  }
}

function isplayerweaponatmaxxp(var0) {
  var1 = getplayerweaponrankxp(var0);
  var2 = getweaponmaxrankxp(var0);
  return var1 >= var2;
}

function weaponshouldgetxp(var0) {
  if(self.pers["rank"] < 3 && !getdvarint("OSPNSPSKL")) {
    return 0;
  }

  var1 = scripts\cp\utility::getweaponrootname(var0);
  return weaponhasranks(var1);
}

function weaponhasranks(var0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var0])) {
    return 0;
  }

  var1 = level.weaponranktable.maxweaponranks[var0] > 0;
  return var1;
}

function getweaponmaxrankxp(var0) {
  var1 = getmaxweaponrankforrootweapon(var0);
  return getweaponrankinfomaxxp(var1);
}

function getweaponrankforxp(var0) {
  if(var0 == 0) {
    return 0;
  }

  for(var1 = getmaxweaponrank() - 1; var1 >= 0; var1--) {
    if(var0 >= getweaponrankinfominxp(var1)) {
      return var1;
    }
  }

  return var1;
}

function getmaxweaponrankforrootweapon(var0) {
  return level.weaponranktable.maxweaponranks[var0];
}

function getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

function getweaponrankinfominxp(var0) {
  return level.weaponranktable.rankinfo[var0].minxp;
}

function getweaponrankinfoxptonextrank(var0) {
  return level.weaponranktable.rankinfo[var0].xptonextrank;
}

function getweaponrankinfomaxxp(var0) {
  return level.weaponranktable.rankinfo[var0].maxxp;
}

function giveplayerweaponxp(var0, var1, var2) {
  if(isai(self) || !isPlayer(self) || !isDefined(var2) || var2 == 0 || !level.weaponxpenabled) {
    return;
  }

  var3 = scripts\cp\utility::getweaponrootname(var0.basename);

  if(!self isitemunlocked(var3, "weapon")) {
    return;
  }

  if(!weaponhasranks(var3)) {
    return;
  }

  var4 = remapscoreeventforweapon(var1);

  if(var4 != var1) {
    var1 = var4;
    var2 = scripts\cp\drone\emp_drone::getscoreinfovalue(var1);
  }

  if(var2 < 0) {
    return;
  }

  var5 = var2;
  var2 *= getweaponrankxpmultipliertotal();
  var2 = int(var2);
  var6 = getplayerweaponrankxp(var3, "mp");
  var7 = getplayerweaponrankxp(var3, "cp");
  var8 = var6 + var7;
  var9 = getweaponrankforxp(var8);
  var10 = getweaponmaxrankxp(var3);
  var11 = var10 - var7;
  var12 = var6 + var2;

  if(var12 > var11) {
    var12 = var11;
  }

  var13 = var12 + var7;
  var14 = getmaxweaponrankforrootweapon(var3);
  var15 = self getplayerdata("common", "sharedProgression", "weaponLevel", var3, "prestige");
  var16 = int(min(getweaponrankforxp(var13), var14));
  scripts\cp\cp_analytics::ref_119b3(var0, var15, var16, var2, var1);

  if(var9 < var16) {
    var17 = "weapon_rank_up_0_4";

    if(var16 >= 15) {
      var17 = "weapon_rank_up_15_plus";
    } else if(var16 >= 10) {
      var17 = "weapon_rank_up_10_14";
    } else if(var16 >= 5) {
      var17 = "weapon_rank_up_5_9";
    }

    var18 = scripts\cp\drone\emp_drone::getscoreinfovalue(var17);
    scripts\cp\drone\emp_drone::giverankxp(var17, var18);
  }

  return var2;
}

function remapscoreeventforweapon(var0) {
  switch (var0) {
    case "kill":
      var0 = "kill_weapon";
      break;
    case "challenge":
      var0 = "weapon_challenge";
      break;
  }

  return var0;
}

function addglobalweaponrankxpmultiplier(var0, var1) {
  addweaponrankxpmultiplier(level, var0, var1);
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

function addweaponrankxpmultiplier(var0, var1) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    self.weaponrankxpmultipliers = [];
  }

  if(isDefined(self.weaponrankxpmultipliers[var1])) {
    self.weaponrankxpmultipliers[var1] = max(self.weaponrankxpmultipliers[var1], var0);
    return;
  }

  self.weaponrankxpmultipliers[var1] = var0;
}

function getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.weaponrankxpmultipliers) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function removeglobalweaponrankxpmultiplier(var0) {
  removeweaponrankxpmultiplier(level, var0);
}

function removeweaponrankxpmultiplier(var0) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.weaponrankxpmultipliers[var0])) {
    return;
  }

  self.rankxpmultipliers[var0] = undefined;
}

function getweaponrankxpmultipliertotal() {
  var0 = getweaponrankxpmultiplier();
  var1 = getglobalweaponrankxpmultiplier();
  var2 = reloadnotehandler();
  var3 = respawntagvisibility();
  var4 = getdvarfloat("scr_weaponxp_scalar", 1);
  var5 = 1;
  var6 = function_0446(self, 1);

  if(isDefined(scripts\engine\utility::array_find(var6, self)) && var6.size > 1) {
    var5 *= 1.25;
  }

  return var0 * var1 * var2 * var4 * var3 * var5;
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
    var0 = getdvarint("scr_" + scripts\cp\utility::getgametype() + "_timelimit");

    if(var0 == 0) {
      var0 = 900;
    }

    var1 = getdvarint("scr_" + scripts\cp\utility::getgametype() + "_winlimit");

    if(var1 > 0) {
      var0 *= var1 * 2 - 1;
    }

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * var0 / 60;
  }

  return level.playkillstreakdeploydialog;
}