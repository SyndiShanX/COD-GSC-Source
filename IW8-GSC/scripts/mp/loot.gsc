/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\loot.gsc
***********************************************/

function init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var_0, 1);
    level.lootweaponrefs[var_1] = var_2;
  }
}

function getpassivesforweapon(var_0, var_1) {
  var_2 = getlootinfoforweapon(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2.passives;
  }

  return undefined;
}

function getlootinfoforweapon(var_0, var_1) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  if(isDefined(level.lootweaponcache[var_0]) && isDefined(level.lootweaponcache[var_0][var_1])) {
    var_2 = level.lootweaponcache[var_0][var_1];
    return var_2;
  }

  var_2 = cachelootweaponweaponinfo(var_1, var_2);

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

function getweaponassetfromrootweapon(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = tablelookup(var_2, 0, var_1, 3);
  return var_3;
}

function lookupvariantref(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = tablelookup(var_2, 0, var_1, 1);
  return var_3;
}

function isweaponitem(var_0) {
  return var_0 >= 1 && var_0 <= 9999;
}

function iskillstreakitem(var_0) {
  return var_0 >= 10000 && var_0 <= 19999;
}

function ispoweritem(var_0) {
  return var_0 >= 20000 && var_0 <= 29999;
}

function isconsumableitem(var_0) {
  return var_0 >= 30000 && var_0 <= 39999;
}

function iscosmeticitem(var_0) {
  return var_0 >= 40000 && var_0 <= 49999;
}

function cachelootweaponweaponinfo(var_0, var_1) {
  if(!isDefined(level.lootweaponcache[var_0])) {
    level.lootweaponcache[var_0] = [];
  }

  var_2 = getweaponloottable(var_0);
  var_3 = readweaponinfofromtable(var_2, var_1);
  level.lootweaponcache[var_0][var_1] = var_3;
  return var_3;
}

function readweaponinfofromtable(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_0, var_2, 1);
  var_3.weaponasset = tablelookupbyrow(var_0, var_2, 1);
  var_3.passives = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "") {
      var_3.passives[var_3.passives.size] = var_5;
    }
  }

  var_3.quality = int(tablelookup("loot/weapon_ids.csv", 6, var_3.ref, 2));
  var_3.variantid = var_1;
  return var_3;
}

function getlootweaponref(var_0) {
  return level.lootweaponrefs[var_0];
}