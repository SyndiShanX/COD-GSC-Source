/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2029.gsc
*************************************************/

init() {
  level._id_989C = [];
  level._id_989D = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv", var_0, 1);
    level._id_989D[var_1] = var_2;
    var_0++;
  }
}

_id_6C17(var_0, var_1) {
  var_2 = _id_6B20(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2._id_AEAC;
  }

  return undefined;
}

_id_6B20(var_0, var_1) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  if(isDefined(level._id_989C[var_0]) && isDefined(level._id_989C[var_0][var_1])) {
    var_2 = level._id_989C[var_0][var_1];
    return var_2;
  }

  var_2 = _id_2EA9(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

_id_6E66(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = _func_0222(var_2, 0, var_1, 3);
  return var_3;
}

_id_981C(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = _func_0222(var_2, 0, var_1, 1);
  return var_3;
}

_id_8B08(var_0) {
  return var_0 >= 1 && var_0 <= 9999;
}

_id_88EF(var_0) {
  return var_0 >= 10000 && var_0 <= 19999;
}

_id_89C2(var_0) {
  return var_0 >= 20000 && var_0 <= 29999;
}

_id_87BD(var_0) {
  return var_0 >= 30000 && var_0 <= 39999;
}

_id_87C5(var_0) {
  return var_0 >= 40000 && var_0 <= 49999;
}

_id_2EA9(var_0, var_1) {
  if(!isDefined(level._id_989C[var_0])) {
    level._id_989C[var_0] = [];
  }

  var_2 = _func_02F6(var_0);
  var_3 = _id_C0A8(var_2, var_1);
  level._id_989C[var_0][var_1] = var_3;
  return var_3;
}

_id_C0A8(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3._id_C189 = tablelookupbyrow(var_0, var_2, 1);
  var_3._id_10D5E = tablelookupbyrow(var_0, var_2, 1);
  var_3._id_AEAC = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "") {
      var_3._id_AEAC[var_3._id_AEAC.size] = var_5;
    }
  }

  var_3._id_BE98 = int(tablelookupbyrow(var_0, var_2, 4));
  var_3._id_04CC = var_1;
  return var_3;
}

_id_6E81(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = _func_02F6(var_0);
  var_3 = int(_func_0222(var_2, 0, var_1, 4));
  return var_3;
}

_id_6B25(var_0) {
  return level._id_989D[var_0];
}