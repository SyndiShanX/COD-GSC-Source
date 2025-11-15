/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreak_loot.gsc
******************************************/

init() {
  level.var_110EC = spawnStruct();
  level.var_110EC.passivestringref = [];
  level.var_110EC.streaktable = [];
  level.var_110EC.costoverride = [];
  level.var_110EC.costoverridepersist = [];
  level.var_110EC.rarity = [];
  level.var_110EC.var_E76D = [];
  level.var_110EC.baseref = [];
  level.var_110EC.ref = [];
  level thread registerkillstreakvariantinfo();
  func_DF05("passive_decreased_cost");
  func_DF05("passive_extra_points");
}

registerkillstreakvariantinfo() {
  level endon("game_ended");
  var_00 = 0;
  var_01 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_00, 0);
  while(var_01 != "") {
    level.var_110EC.costoverride[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 17));
    level.var_110EC.costoverridepersist[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 18));
    level.var_110EC.rarity[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 2));
    level.var_110EC.var_E76D[int(var_01)] = var_00;
    level.var_110EC.baseref[int(var_01)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 6);
    level.var_110EC.ref[int(var_01)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 1);
    var_00++;
    var_01 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_00, 0);
  }
}

getrandomvariantfrombaseref(param_00) {
  var_01 = [];
  foreach(var_04, var_03 in level.var_110EC.baseref) {
    if(var_03 == param_00) {
      var_01[var_01.size] = var_04;
    }
  }

  if(var_01.size == 0) {
    return undefined;
  }

  return var_01[randomint(var_01.size)];
}

modifycostforlootitem(param_00, param_01) {
  if(isDefined(param_00) && param_00 >= 0) {
    var_02 = scripts\engine\utility::ter_op(scripts\mp\utility::_hasperk("specialty_support_killstreaks"), level.var_110EC.costoverridepersist[param_00], level.var_110EC.costoverride[param_00]);
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  return param_01;
}

getrarityforlootitem(param_00) {
  var_01 = "";
  var_02 = undefined;
  if(isDefined(param_00)) {
    var_02 = level.var_110EC.rarity[param_00];
  }

  if(!isDefined(var_02)) {
    return var_01;
  }

  if(var_02 == 1) {
    var_01 = "";
  } else if(var_02 == 2) {
    var_01 = "rare";
  } else if(var_02 == 3) {
    var_01 = "legend";
  } else {
    var_01 = "epic";
  }

  return var_01;
}

getpassiveperk(param_00) {
  if(param_00 <= 0) {
    return [];
  }

  var_01 = level.var_110EC.passivestringref[param_00];
  if(!isDefined(var_01)) {
    var_02 = tablelookuprownum("mp\loot\iw7_killstreak_loot_master.csv", 0, param_00);
    var_03 = [7, 8, 9];
    var_01 = [];
    foreach(var_05 in var_03) {
      var_06 = func_B030(var_02, var_05);
      if(!isDefined(var_06)) {
        break;
      }

      var_01[var_01.size] = var_06;
    }

    level.var_110EC.passivestringref[param_00] = var_01;
  }

  return var_01;
}

func_B030(param_00, param_01) {
  var_02 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", param_00, param_01);
  return scripts\engine\utility::ter_op(isDefined(var_02) && var_02 != "", var_02, undefined);
}

func_988A(param_00, param_01) {
  param_00.passives = param_01;
}

func_DF07(param_00, param_01) {
  var_02 = level.var_110EC;
  foreach(var_04 in param_01) {
    if(!isDefined(var_02.streaktable[var_04])) {
      var_02.streaktable[var_04] = [];
    }

    var_02.streaktable[var_04][param_00] = 1;
  }
}

func_DF05(param_00) {
  var_01 = level.var_110EC;
  if(!isDefined(var_01.streaktable[param_00])) {
    var_01.streaktable[param_00] = [];
  }

  var_01.streaktable[param_00]["all"] = 1;
}

func_9ED5(param_00, param_01) {
  var_02 = level.var_110EC;
  if(!isDefined(var_02.streaktable[param_01])) {
    return 0;
  }

  if(scripts\mp\utility::istrue(var_02.streaktable[param_01]["all"])) {
    return 1;
  }

  return scripts\mp\utility::istrue(var_02.streaktable[param_01][param_00]);
}

func_89BC(param_00) {
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_extra_points")) {
    thread func_2A66(self, param_00);
  }
}

func_2A66(param_00, param_01) {
  param_00 endon("death");
  param_00 waittill("killed_enemy");
  param_00 thread scripts\mp\utility::giveunifiedpoints("extra_points_loot");
}