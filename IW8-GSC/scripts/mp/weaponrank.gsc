/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weaponrank.gsc
***********************************************/

function init() {
  track_consecutive_kills();
  var_0 = getdvarint("PMORNPNTK", 1);
  addglobalweaponrankxpmultiplier(var_0, "online_mp_weapon_xpscale");
  thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      if(level.weaponxpenabled) {
        var_1 = getdvarint("LNQMMNNPSR");
        var_2 = var_0 getprivatepartysize() > 1;

        if(var_2) {
          addweaponrankxpmultiplier(var_0, var_1, "online_mp_party_weapon_xpscale");
        }
      }
    }
  }
}

function loadweaponranktable(var_0) {
  var_1 = spawnStruct();
  var_1.rankinfo = [];

  for(var_2 = 0;; var_2++) {
    var_3 = int(tablelookuprownum(var_0, 0, var_2));

    if(!isDefined(var_3) || var_3 < 0) {
      break;
    }

    var_4 = spawnStruct();
    var_1.rankinfo[var_2] = var_4;
    var_4.minxp = int(tablelookupbyrow(var_0, var_2, 1));
    var_4.xptonextrank = int(tablelookupbyrow(var_0, var_2, 2));
    var_4.maxxp = int(tablelookupbyrow(var_0, var_2, 3));
  }

  var_1.maxrank = var_2 - 1;
  return var_1;
}

function track_consecutive_kills() {
  level.ref_1459a = loadweaponranktable("mp/t9_weaponranktable.csv");
  level.weaponranktable = loadweaponranktable("mp/weaponRankTable.csv");
  level.weaponranktable.maxweaponranks = [];
  var_0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/statstable.csv", var_1, 4);
    var_3 = tablelookupbyrow("mp/statstable.csv", var_1, 42);

    if(!isDefined(var_2) || var_2 == "" || !isDefined(var_3) || var_3 == "") {
      continue;
    }

    var_3 = int(var_3);
    level.weaponranktable.maxweaponranks[var_2] = var_3;
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
  if(self.pers["rank"] < 3 && !getdvarint("OSPNSPSKL")) {
    return false;
  }

  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(!weaponhasranks(var_1)) {
    return false;
  }

  return true;
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

function rpg_attack_apc(var_0) {
  for(var_1 = replace_turret() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= rpg_building_guys(var_1)) {
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

function replace_turret() {
  return level.ref_1459a.maxrank;
}

function getweaponrankinfominxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

function rpg_building_guys(var_0) {
  return level.ref_1459a.rankinfo[var_0].minxp;
}

function getweaponrankinfoxptonextrank(var_0) {
  return level.weaponranktable.rankinfo[var_0].xptonextrank;
}

function getweaponrankinfomaxxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
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

function safefromnuke() {
  if(!isDefined(level.ref_12750)) {
    level.ref_12750 = getdvarfloat("scr_playlist_weaponxp_scalar", 1);
  }

  return level.ref_12750;
}

function getweaponrankxpmultipliertotal() {
  var_0 = getweaponrankxpmultiplier();
  var_1 = getglobalweaponrankxpmultiplier();
  var_2 = reloadnotehandler();
  var_3 = respawntagvisibility();
  var_4 = safefromnuke();
  var_5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var_6 = 1;

  if(isDefined(self)) {
    var_7 = function_0446(self, 1);

    if(isDefined(scripts\engine\utility::array_find(var_7, self)) && var_7.size > 1) {
      var_6 *= 1.25;
    }
  }

  return var_0 * var_1 * var_2 * var_3 * var_4 * var_5 * var_6;
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
    var_0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_timelimit");

    if(var_0 == 0) {
      var_0 = 900;
    }

    var_1 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_winlimit");

    if(var_1 > 0) {
      var_0 *= var_1 * 2 - 1;
    }

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * var_0 / 60;
  }

  return level.playkillstreakdeploydialog;
}