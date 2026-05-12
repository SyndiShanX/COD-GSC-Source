/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1286.gsc
*********************************************/

func_52BF() {
  level.var_1676["wall_built"] = "mp_war_cover_constructed";
  level.var_1676["wall_destroyed"] = "mp_war_cover_destroyed";
  level.var_1676["turret_repaired"] = "mp_war_turret_repaired";
  level.var_1676["turret_disabled"] = "mp_war_turret_disabled";
  level.var_1676["fallback"] = "mp_war_move_back";
  level.var_1676["retreat"] = "mp_war_move_retreat";
  level.var_1676["advance"] = "mp_war_move_forward";
}

func_52C0() {
  game["dialog"]["attacker_out_of_bounds1"] = "sticktotheobjective";
  game["dialog"]["attacker_out_of_bounds2"] = "getbackinthebattle";
  game["dialog"]["attacker_out_of_bounds3"] = "whereareyougoingsoldier";
  game["dialog"]["attacker_out_of_bounds4"] = "getbacktothefront";
  game["dialog"]["attacker_out_of_bounds5"] = "focusontheobjective";
  game["dialog"]["attacker_out_of_bounds6"] = "wrongwaysoldier";
  game["dialog"]["defender_out_of_bounds1"] = "sticktotheobjective";
  game["dialog"]["defender_out_of_bounds2"] = "getbackinthebattle";
  game["dialog"]["defender_out_of_bounds3"] = "whereareyougoingsoldier";
  game["dialog"]["defender_out_of_bounds4"] = "getbacktothefront";
  game["dialog"]["defender_out_of_bounds5"] = "focusontheobjective";
  game["dialog"]["defender_out_of_bounds6"] = "wrongwaysoldier";
  var_00 = undefined;
  if(game["attackers"] == "allies") {
    var_00 = "attacker";
  } else if(game["defenders"] == "allies") {
    var_00 = "defender";
  }

  if(isDefined(var_00)) {
    game["dialog"][var_00 + "_out_of_bounds1"] = "stick2totheobjective";
    game["dialog"][var_00 + "_out_of_bounds2"] = "get2backinthebattle";
    game["dialog"][var_00 + "_out_of_bounds3"] = "where2areyougoingsoldier";
    game["dialog"][var_00 + "_out_of_bounds4"] = "return2tothefrontimmediat";
    game["dialog"][var_00 + "_out_of_bounds5"] = "focus2ontheobjective";
    game["dialog"][var_00 + "_out_of_bounds6"] = "wrong2waysoldier";
  }

  game["dialog"]["attacker_attacker_airdrop"] = "airdropincoming";
  game["dialog"]["defender_attacker_airdrop"] = "enemyairdropincoming";
  game["dialog"]["attacker_defender_airdrop"] = "enemyairdropincoming";
  game["dialog"]["defender_defender_airdrop"] = "airdropincoming";
  game["dialog"]["attacker_attacker_cpkg_destroyed"] = "ss_cpkg_destroyed";
  game["dialog"]["defender_attacker_cpkg_destroyed"] = "";
  game["dialog"]["attacker_defender_cpkg_destroyed"] = "";
  game["dialog"]["defender_defender_cpkg_destroyed"] = "ss_cpkg_destroyed";
  game["dialog"]["attacker_attacker_cpkg_enemysteal"] = "ss_cpkg_enemysteal";
  game["dialog"]["defender_attacker_cpkg_enemysteal"] = "";
  game["dialog"]["attacker_defender_cpkg_enemysteal"] = "";
  game["dialog"]["defender_defender_cpkg_enemysteal"] = "ss_cpkg_enemysteal";
  initkillstreakvo();
  level.hijackeventfunc = ::hijackeventfunc;
}

initkillstreakvo() {
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 1);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    if(var_01 == "b1" || var_01 == "none") {} else if(!isDefined(level.var_275F[var_01])) {} else {
      var_02 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 12);
      game["dialog"]["attacker_" + var_01] = var_02;
      game["dialog"]["defender_" + var_01] = var_02;
      var_03 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 13);
      game["dialog"]["allies_friendly_" + var_01 + "_inbound"] = "ss_" + var_03 + "_allyuse";
      game["dialog"]["allies_enemy_" + var_01 + "_inbound"] = "ss_" + var_03 + "_enemyuse";
      var_04 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 14);
      game["dialog"]["axis_friendly_" + var_01 + "_inbound"] = "ss_" + var_04 + "_allyuse";
      game["dialog"]["axis_enemy_" + var_01 + "_inbound"] = "ss_" + var_04 + "_enemyuse";
    }

    var_00++;
  }
}

func_7977(param_00) {
  if(common_scripts\utility::func_562E(level.var_79C1)) {
    var_01 = maps\mp\_utility::func_45DE(param_00);
  } else {
    var_01 = var_01;
  }

  return maps\mp\gametypes\_teams::func_46D9(var_01);
}

func_166E(param_00, param_01) {
  level thread maps\mp\gametypes\_battlechatter_mp::func_8079(param_00, param_01);
}

func_A618(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  if(isDefined(param_02)) {
    level endon(param_02);
  }

  return func_A619(param_00, param_01, param_03, param_04);
}

func_A619(param_00, param_01, param_02, param_03) {
  var_04 = "_" + param_00;
  var_05 = "_" + param_00;
  if(game["attackers"] == "allies") {
    var_04 = "attacker" + var_04;
    var_05 = "defender" + var_05;
  } else {
    var_05 = "attacker" + var_05;
    var_04 = "defender" + var_04;
  }

  if(isDefined(param_01)) {
    if(param_01 < 0) {
      return 0;
    }

    maps\mp\gametypes\_hostmigration::func_A6F5(param_01);
  }

  if(!isDefined(level.var_A5E6)) {
    level.var_A5E6 = [];
    level.var_A5E7 = "";
  }

  if(common_scripts\utility::func_562E(param_02) && level.var_A5E6.size) {
    return 0;
  }

  if(!isDefined(param_03)) {
    level.var_A5E6[level.var_A5E6.size] = param_00;
    maps\mp\_utility::func_5C3E(var_04, "allies", var_05, "axis");
  } else if(param_03.var_1A7 == "allies") {
    param_03 maps\mp\_utility::func_5C43(var_04);
  } else {
    param_03 maps\mp\_utility::func_5C43(var_05);
  }

  return 1;
}

func_A61D(param_00, param_01, param_02, param_03) {
  func_A618(param_00, param_01, param_02, param_03);
  level waittill("vo_done_" + param_00);
}

func_A61A(param_00) {
  func_A61D(param_00, 6);
}

func_A61C(param_00, param_01, param_02, param_03, param_04) {
  func_A623(param_01);
  func_A61D(param_01, param_02, param_03, param_04);
  level.var_A5E4 = param_00;
}

func_A61B(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 3;
  }

  var_04 = param_03;
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(level.var_A5E5)) {
    level.var_A5E5 = [];
  }

  if(!isDefined(level.var_A5E5[param_00])) {
    level.var_A5E5[param_00] = 1;
  }

  var_05 = param_00 + level.var_A5E5[param_00];
  thread func_A618(var_05, param_01, undefined, param_02);
  level.var_A5E5[param_00]++;
  if(level.var_A5E5[param_00] > var_04) {
    level.var_A5E5[param_00] = 1;
  }
}

func_A623(param_00) {
  game["dialog"]["offense_obj"] = game["dialog"]["attacker_" + param_00];
  game["dialog"]["defense_obj"] = game["dialog"]["defender_" + param_00];
  foreach(var_02 in level.var_744A) {
    if(!isDefined(var_02.var_1A7)) {
      continue;
    }

    if(var_02.var_1A7 == game["attackers"]) {
      var_02.var_5BA8 = game["dialog"]["offense_obj"];
      continue;
    }

    var_02.var_5BA8 = game["dialog"]["defense_obj"];
  }
}

func_2EC2() {
  wait(level.var_2E8F);
}

func_A5F8() {
  if(self issplitscreenplayer() && !self method_82ED()) {
    return;
  }

  func_2EC2();
  if(self.var_1A7 == game["attackers"]) {
    if(!isDefined(self.var_5BA8) || self.var_5BA8 != game["dialog"]["offense_obj"]) {
      maps\mp\_utility::func_5C43("offense_obj", "introboost");
      return;
    }

    return;
  }

  if(!isDefined(self.var_5BA8) || self.var_5BA8 != game["dialog"]["defense_obj"]) {
    maps\mp\_utility::func_5C43("defense_obj", "introboost");
  }
}

func_2EDC(param_00, param_01) {
  var_02 = lookupsoundlength(param_01);
  var_02 = var_02 + 0.5;
  maps\mp\gametypes\_hostmigration::func_A6F5(var_02);
  if(isDefined(level.var_A5E6) && level.var_A5E6.size > 0 && level.var_A5E7 == "" || !issubstr(param_00, level.var_A5E7)) {
    foreach(var_04 in level.var_A5E6) {
      if(issubstr(param_00, var_04)) {
        level.var_A5E7 = var_04;
        level.var_A5E6 = common_scripts\utility::func_F93(level.var_A5E6, var_04);
        level notify("vo_done_" + var_04);
        break;
      }
    }
  }
}

func_7FE0(param_00, param_01, param_02, param_03) {
  thread func_7FC2(param_01, param_02, param_03);
  if(isDefined(level.var_7939)) {
    thread[[level.var_7939]](param_00, param_01, param_02);
  } else {
    thread func_7FBF(param_00, param_01, param_02);
  }

  thread func_7FA4(param_01, param_02);
  thread func_7FA3(param_01, param_02);
}

func_7FC2(param_00, param_01, param_02) {
  level endon(param_01);
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = common_scripts\utility::func_562E(param_02);
  for(;;) {
    var_08 = maps\mp\gametypes\_gamelogic::func_46E5();
    if(var_03 == 0 && var_08 < 121000 && var_08 > 120000) {
      thread func_A618("2min", 0, param_01);
      if(!var_07) {
        var_03 = 1;
      } else {
        wait(1);
      }
    }

    if(var_04 == 0 && var_08 < -4536 && var_08 > -5536) {
      thread func_A618("1min", 0, param_01);
      if(!var_07) {
        var_04 = 1;
      } else {
        wait(1);
      }
    }

    if(var_05 == 0 && var_08 < 31000 && var_08 > 30000) {
      thread func_A618("30sec", 0, param_01);
      if(!var_07) {
        var_05 = 1;
      } else {
        wait(1);
      }
    }

    if(var_06 == 0 && var_08 < 11000 && var_08 > 10000) {
      thread func_A618("10sec", 0, param_01);
      if(!var_07) {
        var_06 = 1;
      } else {
        wait(1);
      }
    }

    wait 0.05;
  }
}

func_7FBF(param_00, param_01, param_02) {
  var_03 = param_01 + "_nag";
  var_04 = 1;
  if(param_00 >= 225) {
    var_05 = param_00 - 210;
    thread func_A618(var_03 + var_04, var_05, param_02);
    var_04++;
  }

  if(param_00 >= 210) {
    var_05 = param_00 - 180;
    thread func_A618(var_03 + var_04, var_05, param_02);
    var_04++;
  }

  if(param_00 >= 180) {
    var_05 = param_00 - 150;
    thread func_A618(var_03 + var_04, var_05, param_02);
    var_04++;
  }

  if(param_00 >= 120) {
    var_05 = param_00 - 90;
    thread func_A618(var_03 + var_04, var_05, param_02);
    var_04++;
  }

  if(param_00 >= 90) {
    var_05 = param_00 - 45;
    thread func_A618(var_03 + var_04, var_05, param_02);
  }
}

func_7FA3(param_00, param_01) {
  level endon(param_01);
  level endon("game_ended");
  level waittill("start_overtime");
  var_02 = 3;
  var_03 = param_00 + "_overtime";
  var_04 = 1;
  for(;;) {
    thread func_A618(var_03 + var_04, 1.5);
    var_04 = var_04 + 1;
    if(var_04 > var_02) {
      var_04 = 1;
    }

    maps\mp\gametypes\_hostmigration::func_A6F5(10);
  }
}

func_7FA4(param_00, param_01) {
  level endon(param_01);
  level waittill("game_ended", var_02);
  if(var_02 == game["attackers"]) {
    var_03 = param_00 + "_success";
  } else {
    var_03 = param_01 + "_failure";
  }

  var_04 = 0.5;
  thread func_A618(var_03, var_04);
}

hijackeventfunc() {
  if(self.var_1A7 == game["attackers"]) {
    thread func_A618("attacker_cpkg_enemysteal");
    return;
  }

  thread func_A618("defender_cpkg_enemysteal");
}