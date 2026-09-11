/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\loot.gsc
***********************************************/

function init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var1 = int(var1);
    var2 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var0, 1);
    level.lootweaponrefs[var1] = var2;
  }
}

function getpassivesforweapon(var0, var1) {
  var2 = getlootinfoforweapon(var0, var1);

  if(isDefined(var2)) {
    return var2.passives;
  }

  return undefined;
}

function getlootinfoforweapon(var0, var1) {
  if(!isDefined(var1)) {
    return undefined;
  }

  if(isDefined(level.lootweaponcache[var0]) && isDefined(level.lootweaponcache[var0][var1])) {
    var2 = level.lootweaponcache[var0][var1];
    return var2;
  }

  var2 = cachelootweaponweaponinfo(var1, var2);

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
}

function getweaponassetfromrootweapon(var0, var1) {
  var2 = "mp/loot/weapon/" + var0 + ".csv";
  var3 = tablelookup(var2, 0, var1, 3);
  return var3;
}

function lookupvariantref(var0, var1) {
  var2 = "mp/loot/weapon/" + var0 + ".csv";
  var3 = tablelookup(var2, 0, var1, 1);
  return var3;
}

function isweaponitem(var0) {
  return var0 >= 1 && var0 <= 9999;
}

function iskillstreakitem(var0) {
  return var0 >= 10000 && var0 <= 19999;
}

function ispoweritem(var0) {
  return var0 >= 20000 && var0 <= 29999;
}

function isconsumableitem(var0) {
  return var0 >= 30000 && var0 <= 39999;
}

function iscosmeticitem(var0) {
  return var0 >= 40000 && var0 <= 49999;
}

function cachelootweaponweaponinfo(var0, var1) {
  if(!isDefined(level.lootweaponcache[var0])) {
    level.lootweaponcache[var0] = [];
  }

  var2 = getweaponloottable(var0);
  var3 = readweaponinfofromtable(var2, var1);
  level.lootweaponcache[var0][var1] = var3;
  return var3;
}

function readweaponinfofromtable(var0, var1) {
  var2 = tablelookuprownum(var0, 0, var1);
  var3 = spawnStruct();
  var3.ref = tablelookupbyrow(var0, var2, 1);
  var3.weaponasset = tablelookupbyrow(var0, var2, 1);
  var3.passives = [];

  for(var4 = 0; var4 < 3; var4++) {
    var5 = tablelookupbyrow(var0, var2, 5 + var4);

    if(isDefined(var5) && var5 != "") {
      var3.passives[var3.passives.size] = var5;
    }
  }

  var3.quality = int(tablelookup("loot/weapon_ids.csv", 6, var3.ref, 2));
  var3.variantid = var1;
  return var3;
}

function getlootweaponref(var0) {
  return level.lootweaponrefs[var0];
}