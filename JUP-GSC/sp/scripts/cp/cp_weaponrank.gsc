/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weaponrank.gsc
***********************************************/



#using script_3f8889c16399185c;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace cp_weaponrank;

function init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  loadweaponranktable();
  var_8215d55ce8caee38 = getdvarint(@ "online_mp_weapon_xpscale", 1);
  addglobalweaponrankxpmultiplier(var_8215d55ce8caee38, "online_mp_weapon_xpscale");
  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player)) {
      if(level.weaponxpenabled) {
        var_69a07d6024aeb70b = getdvarint(@ "online_mp_party_weapon_xpscale");
        isinparty = player getprivatepartysize() > 1;

        if(isinparty) {
          player addweaponrankxpmultiplier(var_69a07d6024aeb70b, "online_mp_party_weapon_xpscale");
        }

        value = getdvarint(@ "hash_7e1907b7e66376a7", 40000);
        player.maxweaponxpcap = value;
        player.totalweaponxpearned = 0;
        player.xpperweapon = [];

        foreach(value in level.weaponranktable.maxweaponranks) {
          player.xpperweapon[rootname + "_mp"] = 0;
        }
      }
    }
  }
}

function loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  weaponranktablebundle = getweaponranktablebundle();
  level.weaponranktable.maxrank = weaponranktablebundle.maxrank;

  for(rankid = 0; rankid <= level.weaponranktable.maxrank; rankid++) {
    weaponranktableentry = function_91ce54da71d1008d(weaponranktablebundle.weaponranklist[rankid].rank);
    rankinfo = spawnStruct();
    level.weaponranktable.rankinfo[rankid] = rankinfo;
    rankinfo.minxp = weaponranktableentry.minxp;
    rankinfo.xptonextrank = weaponranktableentry.xptonext;
    rankinfo.maxxp = weaponranktableentry.maxxp;
    assertex(rankinfo.minxp + rankinfo.xptonextrank == rankinfo.maxxp, "weaponRankTable entry " + rankid + " has values that don't add up, check weaponranktable gdt");
  }

  level.weaponranktable.maxweaponranks = [];
  weaponsscriptbundle = scripts\cp_mp\weapon::function_a221d76594ef4e8b();

  if(isDefined(weaponsscriptbundle)) {
    foreach(weaponname in weaponsscriptbundle) {
      weaponscriptbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7(weaponname, [#"ref", #"maxrank"]);
      rootname = weaponscriptbundle.ref;
      maxrank = weaponscriptbundle.maxrank;

      if(!isDefined(rootname) || rootname == "" || !isDefined(maxrank) || rootname == "iw9_la_mike32biolab") {
        continue;
      }

      maxrank = int(maxrank);
      assertex(maxrank <= level.weaponranktable.maxrank, "Statstable entry for \"" + rootname + "\" has a max rank of " + maxrank + " but weaponRankTable bundle only goes up to " + level.weaponranktable.maxrank);
      level.weaponranktable.maxweaponranks[rootname] = maxrank;
    }
  }

  assertex(level.weaponranktable.maxweaponranks.size > 0, "Found no valid leveling weapons while parsing StatsTable.csv. This is likely an error");
}

function getplayerweaponrank(rootweapon) {
  assert(weaponhasranks(rootweapon));
  weaponxp = getplayerweaponrankxp(rootweapon);
  rank = getweaponrankforxp(weaponxp);
  return rank;
}

function getplayerweaponrankxp(rootweapon, type) {
  assertex(weaponshouldgetxp(rootweapon), "getWeaponRankXP() called for a weapon that should can not gain XP");

  if(!isDefined(type)) {
    type = "all";
  }

  switch (type) {
    case #"hash_fa24c8f6bd607cf8":
      mpxp = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "mpXP");
      return mpxp;
    case #"hash_fa1ebcf6bd5bece6":
      cpxp = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "cpXP");
      return cpxp;
    case #"hash_c482c6c109150a4":
      mpxp = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "mpXP");
      cpxp = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "cpXP");
      return (mpxp + cpxp);
  }
}

function isplayerweaponatmaxxp(rootweapon) {
  assert(weaponhasranks(rootweapon));
  currentxp = getplayerweaponrankxp(rootweapon);
  maxxp = getweaponmaxrankxp(rootweapon);
  return currentxp >= maxxp;
}

function weaponshouldgetxp(weapon) {
  var_f486e79b42c6cbec = getdvarint(@ "hash_39c5e2e95ae3c2e6", 1) == 1;

  if(!var_f486e79b42c6cbec && self.pers["rank"] < 3 && !getdvarint(@ "hash_9c2d59c1962cac50")) {
    return 0;
  }

  rootname = getweaponrootname(weapon);
  return weaponhasranks(rootname);
}

function weaponhasranks(rootname) {
  if(!isDefined(level.weaponranktable)) {
    return 0;
  }

  if(!isDefined(level.weaponranktable.maxweaponranks[rootname])) {
    return 0;
  }

  hasranks = level.weaponranktable.maxweaponranks[rootname] > 0;
  assertex(!hasranks || isenumvaluevalid("common", "LoadoutWeapon", rootname), "\"" + rootname + "\" has a max weapon rank listed in statstable.csv, but is not in the LoadoutWeapons enum in playerdata");
  return hasranks;
}

function getweaponmaxrankxp(rootweapon) {
  assert(weaponhasranks(rootweapon));
  maxrank = getmaxweaponrankforrootweapon(rootweapon);
  return getweaponrankinfomaxxp(maxrank);
}

function getweaponrankforxp(xpval) {
  if(xpval == 0) {
    return 0;
  }

  for(rankid = getmaxweaponrank() - 1; rankid >= 0; rankid--) {
    if(xpval >= getweaponrankinfominxp(rankid)) {
      return rankid;
    }
  }

  return rankid;
}

function getmaxweaponrankforrootweapon(rootweapon) {
  assert(weaponhasranks(rootweapon));
  return level.weaponranktable.maxweaponranks[rootweapon];
}

function getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

function getweaponrankinfominxp(rankid) {
  return level.weaponranktable.rankinfo[rankid].minxp;
}

function getweaponrankinfoxptonextrank(rankid) {
  return level.weaponranktable.rankinfo[rankid].xptonextrank;
}

function getweaponrankinfomaxxp(rankid) {
  return level.weaponranktable.rankinfo[rankid].maxxp;
}

function giveplayerweaponxp(objweapon, type, xp) {
  if(isai(self) || !isPlayer(self) || !isDefined(xp) || xp == 0 || !level.weaponxpenabled) {
    return;
  }

  rootweapon = getweaponrootname(objweapon.basename);

  if(!self isitemunlocked(rootweapon, "weapon")) {
    return;
  }

  if(!weaponhasranks(rootweapon)) {
    return;
  }

  newtype = remapscoreeventforweapon(type);

  if(newtype != type) {
    type = newtype;
    xp = scripts\cp\rank::getscoreinfovalue(type);
  }

  if(xp < 0) {
    assertmsg("Attempting to give negative weapon XP.");
    return;
  }

  basexp = xp;
  xp *= getweaponrankxpmultipliertotal();
  xp = int(xp);
  var_d6c1d2574e3947c7 = getplayerweaponrankxp(rootweapon, "mp");
  var_6e5c89151ed6e249 = getplayerweaponrankxp(rootweapon, "cp");
  var_d9e44a427ec4c8d9 = var_d6c1d2574e3947c7 + var_6e5c89151ed6e249;
  oldrank = getweaponrankforxp(var_d9e44a427ec4c8d9);
  maxxp = getweaponmaxrankxp(rootweapon);
  var_bc811beec61533e0 = maxxp - var_6e5c89151ed6e249;
  var_ccc135d35f5bebc8 = var_d6c1d2574e3947c7 + xp;

  if(var_ccc135d35f5bebc8 > var_bc811beec61533e0) {
    var_ccc135d35f5bebc8 = var_bc811beec61533e0;
  }

  var_2993edf5241f55a = var_ccc135d35f5bebc8 + var_6e5c89151ed6e249;
  maxrank = getmaxweaponrankforrootweapon(rootweapon);
  current_prestige = self getplayerdata("common", "sharedProgression", "weaponLevel", rootweapon, "prestige");
  current_rank = int(min(getweaponrankforxp(var_2993edf5241f55a), maxrank));
  scripts\cp\cp_analytics::logevent_givecpweaponxp(objweapon, current_prestige, current_rank, xp, type);

  if(oldrank < current_rank) {
    var_9060bffe66826b8c = #"hash_e9aa6f742889a408";

    if(current_rank >= 15) {
      var_9060bffe66826b8c = #"hash_df87536a55018058";
    } else if(current_rank >= 10) {
      var_9060bffe66826b8c = #"hash_db8b62b195e166e8";
    } else if(current_rank >= 5) {
      var_9060bffe66826b8c = #"hash_2235f7435f85418";
    }

    var_12239dca1aef95cd = scripts\cp\rank::getscoreinfovalue(var_9060bffe66826b8c);
    scripts\cp\rank::giverankxp(var_9060bffe66826b8c, var_12239dca1aef95cd);
  }

  println("<dev string:x1c>" + rootweapon + "<dev string:x29>" + xp);
  println("<dev string:x2d>" + xp - basexp);

  return xp;
}

function remapscoreeventforweapon(event) {
  switch (event) {
    case #"hash_611825599f1b56f9":
      event = "kill_weapon";
      break;
    case #"hash_5b8ea26626b7f31e":
      event = "weapon_challenge";
      break;
  }

  return event;
}

function addglobalweaponrankxpmultiplier(multiplier, ref) {
  level addweaponrankxpmultiplier(multiplier, ref);
}

function getglobalweaponrankxpmultiplier() {
  return level getweaponrankxpmultiplier();
}

function getplatformweaponrankxpmultiplier() {
  return true;
}

function addweaponrankxpmultiplier(multiplier, ref) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    self.weaponrankxpmultipliers = [];
  }

  if(isDefined(self.weaponrankxpmultipliers[ref])) {
    self.weaponrankxpmultipliers[ref] = max(self.weaponrankxpmultipliers[ref], multiplier);
    return;
  }

  self.weaponrankxpmultipliers[ref] = multiplier;
}

function getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return 1;
  }

  modifiertotal = 1;

  foreach(modifier in self.weaponrankxpmultipliers) {
    if(!isDefined(modifier)) {
      continue;
    }

    modifiertotal *= modifier;
  }

  return modifiertotal;
}

function removeglobalweaponrankxpmultiplier(ref) {
  level removeweaponrankxpmultiplier(ref);
}

function removeweaponrankxpmultiplier(ref) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    assertmsg("removeWeaponRankXPMultiplier() called for \"" + ref + "\", but no xp modifiers have been added.");
    return;
  }

  if(!isDefined(self.weaponrankxpmultipliers[ref])) {
    assertmsg("removeWeaponRankXPMultiplier() called for \"" + ref + "\", but that xp modifier has not been added.");
    return;
  }

  self.rankxpmultipliers[ref] = undefined;
}

function getweaponrankxpmultipliertotal() {
  playermodifier = getweaponrankxpmultiplier();
  globalmodifier = getglobalweaponrankxpmultiplier();
  gametypemodifier = getgametypeweaponxpmultiplier();
  platformmodifier = getplatformweaponrankxpmultiplier();
  dev_scalar = getdvarfloat(@ "hash_e5fe74384334ce18", 1);
  return playermodifier * globalmodifier * gametypemodifier * dev_scalar * platformmodifier;
}

function getgametypeweaponxpmultiplier() {
  if(getdvarint(@ "hash_78653010d584aa6e", 0) == 0) {
    if(!isDefined(level.gametypeweaponxpmodifier)) {
      level.gametypeweaponxpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 19));
    }

    return level.gametypeweaponxpmodifier;
  }

  return level.gametypebundle.var_3c836934a83182a5;
}

function getgametypekillsperhouravg() {
  if(getdvarint(@ "hash_78653010d584aa6e", 0) == 0) {
    if(!isDefined(level.gametypekillsperhouravg)) {
      level.gametypekillsperhouravg = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 20));
    }

    return level.gametypekillsperhouravg;
  }

  return level.gametypebundle.var_d98341b1a105c7af;
}

function getgametypekillspermatchmaximum() {
  if(!isDefined(level.gametypekillspermatchmax)) {
    timelimit = getdvarint(hashcat(@ "scr_", getgametype(), "_timelimit"));

    if(timelimit == 0) {
      timelimit = 900;
    }

    winlimit = getdvarint(hashcat(@ "scr_", getgametype(), "_winlimit"));

    if(winlimit > 0) {
      timelimit *= winlimit * 2 - 1;
    }

    level.gametypekillspermatchmax = getgametypekillsperhouravg() / 60 * timelimit / 60;
  }

  return level.gametypekillspermatchmax;
}