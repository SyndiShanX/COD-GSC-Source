/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2759.gsc
***************************************/

init() {
  level.func_110EC = spawnStruct();
  level.func_110EC.passivestringref = [];
  level.func_110EC.streaktable = [];
  level.func_110EC.costoverride = [];
  level.func_110EC.costoverridepersist = [];
  level.func_110EC.rarity = [];
  level.func_110EC.func_E76D = [];
  level.func_110EC.baseref = [];
  level.func_110EC.ref = [];
  level thread registerkillstreakvariantinfo();
  func_DF05("passive_decreased_cost");
  func_DF05("passive_extra_points");
}

registerkillstreakvariantinfo() {
  level endon("game_ended");
  var_00 = 0;

  for(var_01 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_00, 0); var_01 != ""; var_01 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_00, 0)) {
    level.func_110EC.costoverride[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 17));
    level.func_110EC.costoverridepersist[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 18));
    level.func_110EC.rarity[int(var_01)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 2));
    level.func_110EC.func_E76D[int(var_01)] = var_00;
    level.func_110EC.baseref[int(var_01)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 6);
    level.func_110EC.ref[int(var_01)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_01, 1);
    var_0++;
  }
}

getrandomvariantfrombaseref(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in level.func_110EC.baseref) {
    if(var_03 == var_00) {
      var_1[var_1.size] = var_04;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  } else {
    return var_1[randomint(var_1.size)];
  }
}

modifycostforlootitem(var_00, var_01) {
  if(isDefined(var_00) && var_00 >= 0) {
    var_02 = scripts\engine\utility::ter_op(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks"), level.func_110EC.costoverridepersist[var_00], level.func_110EC.costoverride[var_00]);

    if(isDefined(var_02)) {
      return var_02;
    }
  }

  return var_01;
}

getrarityforlootitem(var_00) {
  var_01 = "";
  var_02 = undefined;

  if(isDefined(var_00)) {
    var_02 = level.func_110EC.rarity[var_00];
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

getpassiveperk(var_00) {
  if(var_00 <= 0) {
    return [];
  }

  var_01 = level.func_110EC.passivestringref[var_00];

  if(!isDefined(var_01)) {
    var_02 = tablelookuprownum("mp\loot\iw7_killstreak_loot_master.csv", 0, var_00);
    var_03 = [7, 8, 9];
    var_01 = [];

    foreach(var_05 in var_03) {
      var_06 = func_B030(var_02, var_05);

      if(!isDefined(var_06)) {
        break;
      }
      var_1[var_1.size] = var_06;
    }

    level.func_110EC.passivestringref[var_00] = var_01;
  }

  return var_01;
}

func_B030(var_00, var_01) {
  var_02 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_00, var_01);
  return scripts\engine\utility::ter_op(isDefined(var_02) && var_02 != "", var_02, undefined);
}

func_988A(var_00, var_01) {
  var_0.passives = var_01;
}

func_DF07(var_00, var_01) {
  var_02 = level.func_110EC;

  foreach(var_04 in var_01) {
    if(!isDefined(var_2.streaktable[var_04])) {
      var_2.streaktable[var_04] = [];
    }

    var_2.streaktable[var_04][var_00] = 1;
  }
}

func_DF05(var_00) {
  var_01 = level.func_110EC;

  if(!isDefined(var_1.streaktable[var_00])) {
    var_1.streaktable[var_00] = [];
  }

  var_1.streaktable[var_00]["all"] = 1;
}

func_9ED5(var_00, var_01) {
  var_02 = level.func_110EC;

  if(!isDefined(var_2.streaktable[var_01])) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_2.streaktable[var_01]["all"])) {
    return 1;
  }

  return scripts\mp\utility\game::istrue(var_2.streaktable[var_01][var_00]);
}

func_89BC(var_00) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_extra_points")) {
    thread func_2A66(self, var_00);
  }
}

func_2A66(var_00, var_01) {
  var_00 endon("death");
  var_00 waittill("killed_enemy");
  var_00 thread scripts\mp\utility\game::giveunifiedpoints("extra_points_loot");
}