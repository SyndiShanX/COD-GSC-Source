/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\loot.gsc
***********************************************/

init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_8A6B235B1C79C6F6DE3ACB96EE9BBEDD95580EBDB9EB63B7DB1DF5D685B947B29C171BE6B3", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("_encstr_8A6B235B1C79C6F6DE3ACB96EE9BBEDD95580EBDB9EB63B7DB1DF5D685B947B29C171BE6B3", var_0, 1);
    level.lootweaponrefs[var_1] = var_2;
    var_0++;
  }
}

getpassivesforweapon(var_0, var_1) {
  var_2 = getlootinfoforweapon(var_0, var_1);

  if(isDefined(var_2))
    return var_2.passives;

  return undefined;
}

getlootinfoforweapon(var_0, var_1) {
  if(!isDefined(var_1))
    return undefined;

  if(isDefined(level.lootweaponcache[var_0]) && isDefined(level.lootweaponcache[var_0][var_1])) {
    var_2 = level.lootweaponcache[var_0][var_1];
    return var_2;
  }

  var_2 = cachelootweaponweaponinfo(var_0, var_1);

  if(isDefined(var_2))
    return var_2;

  return undefined;
}

getweaponassetfromrootweapon(var_0, var_1) {
  var_2 = "_encstr_85331038937FC097B223A0947F0AF1E89656" + var_0 + "_encstr_96A70506895E33";
  var_3 = tablelookup(var_2, 0, var_1, 3);
  return var_3;
}

lookupvariantref(var_0, var_1) {
  var_2 = "_encstr_85331038937FC097B223A0947F0AF1E89656" + var_0 + "_encstr_96A70506895E33";
  var_3 = tablelookup(var_2, 0, var_1, 1);
  return var_3;
}

isweaponitem(var_0) {
  return var_0 >= 1 && var_0 <= 9999;
}

iskillstreakitem(var_0) {
  return var_0 >= 10000 && var_0 <= 19999;
}

ispoweritem(var_0) {
  return var_0 >= 20000 && var_0 <= 29999;
}

isconsumableitem(var_0) {
  return var_0 >= 30000 && var_0 <= 39999;
}

iscosmeticitem(var_0) {
  return var_0 >= 40000 && var_0 <= 49999;
}

cachelootweaponweaponinfo(var_0, var_1) {
  if(!isDefined(level.lootweaponcache[var_0]))
    level.lootweaponcache[var_0] = [];

  var_2 = getweaponloottable(var_0);
  var_3 = readweaponinfofromtable(var_2, var_1);
  level.lootweaponcache[var_0][var_1] = var_3;
  return var_3;
}

readweaponinfofromtable(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_0, var_2, 1);
  var_3.weaponasset = tablelookupbyrow(var_0, var_2, 1);
  var_3.passives = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "_encstr_B40101")
      var_3.passives[var_3.passives.size] = var_5;
  }

  var_3.quality = int(tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 6, var_3.ref, 2));
  var_3.variantid = var_1;
  return var_3;
}

getlootweaponref(var_0) {
  return level.lootweaponrefs[var_0];
}