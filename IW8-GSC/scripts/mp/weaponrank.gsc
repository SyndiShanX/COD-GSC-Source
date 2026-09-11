/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weaponrank.gsc
***********************************************/

function init() {
  track_consecutive_kills();
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
      }
    }
  }
}

function loadweaponranktable(var0) {
  var1 = spawnStruct();
  var1.rankinfo = [];

  for(var2 = 0;; var2++) {
    var3 = int(tablelookuprownum(var0, 0, var2));

    if(!isDefined(var3) || var3 < 0) {
      break;
    }

    var4 = spawnStruct();
    var1.rankinfo[var2] = var4;
    var4.minxp = int(tablelookupbyrow(var0, var2, 1));
    var4.xptonextrank = int(tablelookupbyrow(var0, var2, 2));
    var4.maxxp = int(tablelookupbyrow(var0, var2, 3));
  }

  var1.maxrank = var2 - 1;
  return var1;
}

function track_consecutive_kills() {
  level.ref_1459a = loadweaponranktable("mp/t9_weaponranktable.csv");
  level.weaponranktable = loadweaponranktable("mp/weaponRankTable.csv");
  level.weaponranktable.maxweaponranks = [];
  var0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var1 = 0; var1 < var0; var1++) {
    var2 = tablelookupbyrow("mp/statstable.csv", var1, 4);
    var3 = tablelookupbyrow("mp/statstable.csv", var1, 42);

    if(!isDefined(var2) || var2 == "" || !isDefined(var3) || var3 == "") {
      continue;
    }

    var3 = int(var3);
    level.weaponranktable.maxweaponranks[var2] = var3;
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
    return false;
  }

  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);

  if(!weaponhasranks(var1)) {
    return false;
  }

  return true;
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

function rpg_attack_apc(var0) {
  for(var1 = replace_turret() - 1; var1 >= 0; var1--) {
    if(var0 >= rpg_building_guys(var1)) {
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

function replace_turret() {
  return level.ref_1459a.maxrank;
}

function getweaponrankinfominxp(var0) {
  return level.weaponranktable.rankinfo[var0].minxp;
}

function rpg_building_guys(var0) {
  return level.ref_1459a.rankinfo[var0].minxp;
}

function getweaponrankinfoxptonextrank(var0) {
  return level.weaponranktable.rankinfo[var0].xptonextrank;
}

function getweaponrankinfomaxxp(var0) {
  return level.weaponranktable.rankinfo[var0].maxxp;
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

function safefromnuke() {
  if(!isDefined(level.ref_12750)) {
    level.ref_12750 = getdvarfloat("scr_playlist_weaponxp_scalar", 1);
  }

  return level.ref_12750;
}

function getweaponrankxpmultipliertotal() {
  var0 = getweaponrankxpmultiplier();
  var1 = getglobalweaponrankxpmultiplier();
  var2 = reloadnotehandler();
  var3 = respawntagvisibility();
  var4 = safefromnuke();
  var5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var6 = 1;

  if(isDefined(self)) {
    var7 = function_0446(self, 1);

    if(isDefined(scripts\engine\utility::array_find(var7, self)) && var7.size > 1) {
      var6 *= 1.25;
    }
  }

  return var0 * var1 * var2 * var3 * var4 * var5 * var6;
}

function reloadnotehandler() {
  if(!isDefined(level.playplundersound)) {
    level.playplundersound = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 19));
  }

  return level.playplundersound;
}

function reload_handle_hintstring() {
  if(!isDefined(level.playjumpsoundtosquad)) {
    level.playjumpsoundtosquad = getdvarint("scr_KPH_override", int(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 20)));
  }

  return level.playjumpsoundtosquad;
}

function reload_use_think() {
  if(!isDefined(level.playkillstreakdeploydialog)) {
    var0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_timelimit");

    if(var0 == 0) {
      var0 = 900;
    }

    var1 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_winlimit");

    if(var1 > 0) {
      var0 *= var1 * 2 - 1;
    }

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * var0 / 60;
  }

  return level.playkillstreakdeploydialog;
}