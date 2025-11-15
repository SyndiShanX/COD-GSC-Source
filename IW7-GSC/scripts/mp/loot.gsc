/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\loot.gsc
*******************************/

init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp\loot\iw7_weapon_loot_master.csv", var_00, 0);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    var_01 = int(var_01);
    var_02 = tablelookupbyrow("mp\loot\iw7_weapon_loot_master.csv", var_00, 1);
    level.lootweaponrefs[var_01] = var_02;
    var_00++;
  }
}

getpassivesforweapon(param_00) {
  if(isplayer(self) && weaponhasprestigenuke(param_00)) {
    return ["passive_nuke"];
  }

  var_01 = getlootinfoforweapon(param_00);
  if(isDefined(var_01)) {
    return var_01.passives;
  }

  return undefined;
}

getlootinfoforweapon(param_00) {
  var_01 = getweaponvariantindex(param_00);
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_02 = scripts\mp\utility::getweaponrootname(param_00);
  if(isDefined(level.lootweaponcache[var_02]) && isDefined(level.lootweaponcache[var_02][var_01])) {
    var_03 = level.lootweaponcache[var_02][var_01];
    return var_03;
  }

  var_03 = cachelootweaponweaponinfo(var_01, var_03, var_02);
  if(isDefined(var_03)) {
    return var_03;
  }

  return undefined;
}

getweaponassetfromrootweapon(param_00, param_01) {
  var_02 = "mp\loot\weapon\" + param_00 + ".csv ";
  var_03 = tablelookup(var_02, 0, param_01, 3);
  return var_03;
}

lookupvariantref(param_00, param_01) {
  var_02 = "mp\loot\weapon\" + param_00 + ".csv ";
  var_03 = tablelookup(var_02, 0, param_01, 1);
  return var_03;
}

isweaponitem(param_00) {
  return param_00 >= 1 && param_00 <= 9999;
}

iskillstreakitem(param_00) {
  return param_00 >= 10000 && param_00 <= 19999;
}

ispoweritem(param_00) {
  return param_00 >= 20000 && param_00 <= 29999;
}

isconsumableitem(param_00) {
  return param_00 >= 30000 && param_00 <= -25537;
}

iscosmeticitem(param_00) {
  return param_00 >= -25536 && param_00 <= -15537;
}

cachelootweaponweaponinfo(param_00, param_01, param_02) {
  if(!isDefined(level.lootweaponcache[param_01])) {
    level.lootweaponcache[param_01] = [];
  }

  var_03 = getweaponloottable(param_00);
  var_04 = readweaponinfofromtable(var_03, param_02);
  level.lootweaponcache[param_01][param_02] = var_04;
  return var_04;
}

readweaponinfofromtable(param_00, param_01) {
  var_02 = tablelookuprownum(param_00, 0, param_01);
  var_03 = spawnStruct();
  var_03.ref = tablelookupbyrow(param_00, var_02, 1);
  var_03.weaponasset = tablelookupbyrow(param_00, var_02, 1);
  var_03.passives = [];
  for(var_04 = 0; var_04 < 3; var_04++) {
    var_05 = tablelookupbyrow(param_00, var_02, 5 + var_04);
    if(isDefined(var_05) && var_05 != "") {
      var_03.passives[var_03.passives.size] = var_05;
    }
  }

  var_03.quality = int(tablelookupbyrow(param_00, var_02, 4));
  var_03.variantid = param_01;
  return var_03;
}

getweaponqualitybyid(param_00, param_01) {
  if(!isDefined(param_01) || param_01 < 0) {
    return 0;
  }

  var_02 = getweaponloottable(param_00);
  var_03 = int(tablelookup(var_02, 0, param_01, 4));
  return var_03;
}

getlootweaponref(param_00) {
  return level.lootweaponrefs[param_00];
}

weaponhasprestigenuke(param_00) {
  var_01 = scripts\mp\utility::getweaponrootname(param_00);
  var_02 = var_01 + "_nuke";
  if(isDefined(level.prestigeextras[var_02])) {
    return self isitemunlocked(var_02, "prestigeExtras", 1);
  }

  return 0;
}