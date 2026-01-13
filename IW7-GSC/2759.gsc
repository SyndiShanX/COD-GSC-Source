/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2759.gsc
***************************************/

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
  var_0 = 0;

  for(var_1 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_0, 0); var_1 != ""; var_1 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_0, 0)) {
    level.var_110EC.costoverride[int(var_1)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_1, 17));
    level.var_110EC.costoverridepersist[int(var_1)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_1, 18));
    level.var_110EC.rarity[int(var_1)] = int(tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_1, 2));
    level.var_110EC.var_E76D[int(var_1)] = var_0;
    level.var_110EC.baseref[int(var_1)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_1, 6);
    level.var_110EC.ref[int(var_1)] = tablelookup("mp\loot\iw7_killstreak_loot_master.csv", 0, var_1, 1);
    var_0++;
  }
}

getrandomvariantfrombaseref(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in level.var_110EC.baseref) {
    if(var_3 == var_0) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  } else {
    return var_1[randomint(var_1.size)];
  }
}

modifycostforlootitem(var_0, var_1) {
  if(isDefined(var_0) && var_0 >= 0) {
    var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\game::_hasperk("specialty_support_killstreaks"), level.var_110EC.costoverridepersist[var_0], level.var_110EC.costoverride[var_0]);

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  return var_1;
}

getrarityforlootitem(var_0) {
  var_1 = "";
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_2 = level.var_110EC.rarity[var_0];
  }

  if(!isDefined(var_2)) {
    return var_1;
  }

  if(var_2 == 1) {
    var_1 = "";
  } else if(var_2 == 2) {
    var_1 = "rare";
  } else if(var_2 == 3) {
    var_1 = "legend";
  } else {
    var_1 = "epic";
  }

  return var_1;
}

getpassiveperk(var_0) {
  if(var_0 <= 0) {
    return [];
  }

  var_1 = level.var_110EC.passivestringref[var_0];

  if(!isDefined(var_1)) {
    var_2 = tablelookuprownum("mp\loot\iw7_killstreak_loot_master.csv", 0, var_0);
    var_3 = [7, 8, 9];
    var_1 = [];

    foreach(var_5 in var_3) {
      var_6 = func_B030(var_2, var_5);

      if(!isDefined(var_6)) {
        break;
      }
      var_1[var_1.size] = var_6;
    }

    level.var_110EC.passivestringref[var_0] = var_1;
  }

  return var_1;
}

func_B030(var_0, var_1) {
  var_2 = tablelookupbyrow("mp\loot\iw7_killstreak_loot_master.csv", var_0, var_1);
  return scripts\engine\utility::ter_op(isDefined(var_2) && var_2 != "", var_2, undefined);
}

func_988A(var_0, var_1) {
  var_0.passives = var_1;
}

func_DF07(var_0, var_1) {
  var_2 = level.var_110EC;

  foreach(var_4 in var_1) {
    if(!isDefined(var_2.streaktable[var_4])) {
      var_2.streaktable[var_4] = [];
    }

    var_2.streaktable[var_4][var_0] = 1;
  }
}

func_DF05(var_0) {
  var_1 = level.var_110EC;

  if(!isDefined(var_1.streaktable[var_0])) {
    var_1.streaktable[var_0] = [];
  }

  var_1.streaktable[var_0]["all"] = 1;
}

func_9ED5(var_0, var_1) {
  var_2 = level.var_110EC;

  if(!isDefined(var_2.streaktable[var_1])) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_2.streaktable[var_1]["all"])) {
    return 1;
  }

  return scripts\mp\utility\game::istrue(var_2.streaktable[var_1][var_0]);
}

func_89BC(var_0) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_extra_points")) {
    thread func_2A66(self, var_0);
  }
}

func_2A66(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("killed_enemy");
  var_0 thread scripts\mp\utility\game::giveunifiedpoints("extra_points_loot");
}