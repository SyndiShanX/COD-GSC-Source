/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\raid.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::func_D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  lib_0501::func_5340();
  setDvar("raid_allow_scorestreaks", 0);
  level.var_579A = 1;
  level.var_5A6F = 0;
  level.var_79A1 = 0;
  level.var_2FAB = 0;
  level.var_2F8B = 1;
  level.var_80A8 = 1;
  level.var_79C2 = spawnStruct();
  level.var_79C2.var_9DE = 0;
  level.var_9565 = 1;
  level.var_2FA1 = 0;
  level.var_A16 = 0;
  level.var_2E8F = 0.5;
  level.var_7DB3 = lib_0501::func_4648("raid_respawnType");
  level.attackersrespawndelay = lib_0501::func_4647("raid_attackersRespawn");
  level.defendersrespawndelay = lib_0501::func_4647("raid_defendersRespawn");
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_62AD = ::func_62AE;
  level.var_6B96 = ::func_4665;
  level.var_6BB6 = ::func_6BB6;
  level.var_6B7F = ::func_6B80;
  level.var_6B7B = ::func_6B7C;
  level.var_2EC3 = ::lib_0506::func_A5F8;
  level.var_3FC7 = ::func_79A5;
  level.gamemodehandledroppedweapon = ::raidmodehandledroppedweapon;
  level.var_3FD1 = ::lib_0502::func_79EC;
  level.var_3FCE = ::lib_0502::func_79EB;
  level.var_2EBB = ::lib_0506::func_2EDC;
  level.var_469A = ::func_469A;
  level.var_36C3 = ::func_36C3;
  level.var_36C0 = ::func_36C0;
  level.spectatorspawnedforintrovignettesfunc = ::lib_0505::spectatorspawnedforintrovignettes;
  level.var_21ED = ::func_21ED;
  level thread func_8A26();
  level thread func_535B();
  setdvarifuninitialized("trailer_disable_boundaries", 0);
  setdvarifuninitialized("trailer_disable_borders", 0);
  lib_04FF::func_5321();
  lib_04F4::func_767F();
  lib_0506::func_52BF();
  level.var_79E9 = [];
  lib_0502::func_8671("scr_raid_playerrespawndelay", 3);
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  setdvarifuninitialized("raid_auto_advance", 0);
}

func_8A26() {
  level endon("game_ended");
  level.var_4E06 = [];
  for(;;) {
    lib_0502::func_A781();
    maps\mp\gametypes\_hostmigration::func_A782();
    foreach(var_02, var_01 in level.var_4E06) {
      setDvar(var_02, var_01);
    }
  }
}

func_535B() {
  level.var_9A6B = ["0", "1", "2", "3", "4"];
  level.var_201B = 0;
  level.var_2945 = 1;
  level.var_2946 = 0;
  if(!common_scripts\utility::func_562E(game["switchedsides"])) {
    foreach(var_01 in level.var_985B) {
      game[var_01 + "_raids"]["time_split_1"] = 0;
      game[var_01 + "_raids"]["time_split_2"] = 0;
      game[var_01 + "_raids"]["time_split_3"] = 0;
      game[var_01 + "_raids"]["time_split_4"] = 0;
      game[var_01 + "OBJ"] = 0;
    }

    game["raids_time_limit_objective_1"] = 0;
    game["raids_time_limit_objective_2"] = 0;
    game["raids_time_limit_objective_3"] = 0;
    game["raids_time_limit_objective_4"] = 0;
    return;
  }

  for(;;) {
    if(isDefined(level.var_9309) && gettime() > level.var_9309 + 1000) {
      var_01 = game["defenders"];
      var_03 = var_01 + "_raids";
      function_0226(&"set_prev_round_objective_times", 4, game[var_03]["time_split_1"], game[var_03]["time_split_2"], game[var_03]["time_split_3"], game[var_03]["time_split_4"]);
      var_04 = var_01 + "GameModeData";
      var_05 = game[var_03]["time_split_1"];
      var_06 = var_05 + game[var_03]["time_split_2"];
      var_07 = var_06 + game[var_03]["time_split_3"];
      var_08 = var_07 + game[var_03]["time_split_4"];
      if(!isDefined(game["clientMatchDataDef"])) {
        game["clientMatchDataDef"] = "mp/ddl/clientmatchdata.ddl";
        setclientmatchdatadef(game["clientMatchDataDef"]);
      }

      setclientmatchdata(var_01 + "OBJ", game[var_01 + "OBJ"]);
      setclientmatchdata(var_04, 0, var_05);
      setclientmatchdata(var_04, 1, var_06);
      setclientmatchdata(var_04, 2, var_07);
      setclientmatchdata(var_04, 3, var_08);
      break;
    }

    wait 0.05;
  }
}

func_4665() {
  if(level.var_7DB3 == 1) {
    if(self.var_1A7 == game["defenders"]) {
      return level.defendersrespawndelay;
    }

    return level.attackersrespawndelay;
  }

  return 0;
}

func_6B80(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\gametypes\_rank::func_4671(param_00);
  if(isDefined(var_05) && var_05 > 0 && !getdvarint("raid_allow_scorestreaks", 0)) {
    param_01 maps\mp\killstreaks\_killstreaks::func_300F(param_00, var_05);
  }

  return var_05;
}

func_6B7C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  if(maps\mp\gametypes\_damage::func_118E(param_01, param_04)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(param_01 == var_0A) {
    return;
  }

  if(maps\mp\gametypes\_damage::func_56FA(var_0A, param_01)) {
    return;
  }

  if(common_scripts\utility::func_562E(var_0A.var_581C)) {
    param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
    param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
  }

  foreach(var_0C in level.var_695E) {
    [[var_0C]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }
}

func_6BB6() {
  if(lib_04FF::func_79B0()) {
    return;
  }

  if(level.var_79AE.var_8DB.size) {
    var_00 = level.var_79AE.var_8DB[0];
    if(level.var_A16) {
      iprintlnbold("Auto Advance Objective");
      level.var_99F5 = 1;
      wait(1);
      level thread func_2CC5(1);
      lib_04FF::func_6935(var_00.var_695A);
      return;
    }

    if(isDefined(var_00.var_6BB6)) {
      var_00[[var_00.var_6BB6]]();
      return;
    }
  }

  if(maps\mp\_utility::func_5CBA("raid_victory")) {
    return;
  }

  lib_0502::raidobjectivefailure();
}

func_2CC5(param_00) {
  wait(param_00);
  level.var_99F5 = 0;
}

func_469A() {
  if(!isDefined(level.var_541E)) {
    level.var_541E = [];
    var_00 = getEntArray("mp_global_intermission", "classname");
    foreach(var_02 in var_00) {
      if(isDefined(var_02.var_165)) {
        var_03 = int(var_02.var_165);
        var_04 = var_02.var_8260;
        if(!isDefined(var_04)) {
          var_04 = "attackers";
        }

        if(!isDefined(level.var_541E[var_03])) {
          level.var_541E[var_03] = [];
        }

        if(!isDefined(level.var_541E[var_03][var_04])) {
          level.var_541E[var_03][var_04] = [];
        }

        level.var_541E[var_03][var_04] = var_02;
      }
    }
  }

  var_06 = getomnvar("ui_war_active_sector");
  if(isDefined(level.var_541E[var_06])) {
    var_07 = level.var_541E[var_06];
    var_08 = self.var_12C["team"];
    if(isDefined(var_07["defenders"]) && isDefined(var_08) && var_08 == game["defenders"]) {
      return var_07["defenders"];
    }

    return var_07["attackers"];
  }

  var_00 = getEntArray("mp_global_intermission", "classname");
  return var_00[0];
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_raid_roundswitch", 0);
  maps\mp\_utility::func_7BF8("raid", 0, 0, 9);
  setdynamicdvar("scr_raid_roundlimit", 1);
  maps\mp\_utility::func_7BF7("raid", 1);
  setdynamicdvar("scr_raid_winlimit", 1);
  maps\mp\_utility::func_7C04("raid", 1);
  setdynamicdvar("scr_raid_halftime", 0);
  maps\mp\_utility::func_7BE5("raid", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  lib_0502::func_8671("scr_raid_timelimit", 0);
  setomnvar("ui_war_attacker_team", maps\mp\_utility::func_46D4(game["attackers"]));
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
    level.var_79C1 = 1;
    setomnvar("ui_war_attacker_sector1_completion_time", 0);
    setomnvar("ui_war_attacker_sector2_completion_time", 0);
    setomnvar("ui_war_attacker_sector3_completion_time", 0);
    setomnvar("ui_war_attacker_sector4_completion_time", 0);
    setomnvar("ui_current_round", 2);
  }

  lib_050D::func_10E4();
  var_02 = lib_050D::func_46A0(game["attackers"]);
  maps\mp\_utility::func_5CBC("raid_victory", 0);
  lib_04F9::func_52C6();
  lib_04F8::func_52B4();
  lib_04F7::func_533C();
  lib_0504::func_5341();
  thread lib_0500::func_533F();
  lib_04F4::func_D5();
  lib_0505::func_D5();
  func_5352();
  lib_0502::func_2549();
  if(isDefined(level.var_75EE)) {
    level.var_7F16 = level.var_75EE;
  }

  lib_0503::func_5282();
  var_03[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_F9(var_03);
  level.var_46D9 = ::lib_0506::func_7977;
  if(getdvarint("raid_auto_advance", 0)) {
    level.var_A16 = 1;
  }

  level thread func_6B6C();
  level thread func_6B79();
  level thread func_6B82();
  level thread func_79DE();
}

func_5352() {
  var_00 = getEntArray("raidSpawnProtectionTrigger", "targetname");
  common_scripts\utility::func_FB2(var_00, ::func_79D1);
}

func_79D1() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    if(var_00 istouching(self)) {
      var_00 thread func_73BE(self);
    }
  }
}

func_73BE(param_00) {
  self endon("disconnect");
  self endon("death");
  self endon("removed_spawn_protection");
  level endon("game_ended");
  while(self istouching(param_00)) {
    wait 0.05;
  }

  self.var_4B97 = undefined;
  self notify("removed_spawn_protection");
}

func_79DE() {
  maps\mp\_utility::func_3FA5("prematch_done");
  if(func_6976()) {
    return;
  }

  var_00 = maps\mp\gametypes\_hud_util::func_282B("hudbig", 1);
  var_00 maps\mp\gametypes\_hud_util::func_8707("LEFTBOTTOM", undefined, 125, -30);
  var_00.var_56 = (1, 1, 1);
  var_00.var_1F = 0;
  var_00 settimerup(0);
}

func_6976() {
  var_00 = 1;
  return var_00;
}

func_09DB(param_00) {
  if(!func_6976()) {
    return;
  }

  var_01 = "scr_raid_timelimit";
  var_02 = getdvarfloat(var_01, 0);
  lib_0502::func_8671(var_01, var_02 + param_00);
  maps\mp\_utility::func_A193(var_01);
}

func_6BA7() {
  if(isPlayer(self)) {
    thread func_9093(3);
    thread func_9026(3);
    self.var_8D0 = undefined;
  }

  thread func_6AB8();
}

func_62AE(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = float(param_03);
  if(isPlayer(param_00)) {
    if(param_04 == "MOD_TRIGGER_HURT") {
      return param_03;
    }

    if(common_scripts\utility::func_562E(self.var_4B97)) {
      var_0A = 1;
      var_0B = lib_0502::func_799F();
      if(var_0B && param_04 != "MOD_EXPLOSIVE" && isPlayer(param_02) && isDefined(param_06)) {
        iprintlnbold("Spawn-Protected player hit with bullet damage at (" + param_00.var_116[0] + "," + param_00.var_116[1] + "," + param_00.var_116[2] + ")");
        iprintln("Spawn-Protected player hit with bullet damage at (" + param_00.var_116[0] + "," + param_00.var_116[1] + "," + param_00.var_116[2] + ")");
        level thread maps\mp\_utility::func_33D8(param_02.var_116 + (0, 0, 60), param_06, 60, (1, 0, 0));
      }
    }

    var_0C = isDefined(param_00 method_85E3());
    if(var_0C) {
      if(isPlayer(param_02) && maps\mp\_utility::func_5694(param_04) && func_581B(param_00) || var_0A < 100) {
        var_0D = maps\mp\_utility::func_3B8E(param_00, param_02, 100);
        var_0E = isDefined(param_02 method_85E3());
        var_0F = maps\mp\_utility::func_570A(param_05, param_08, param_04, param_02);
        var_10 = func_4B93(param_02);
        if(var_0D && !var_0E && (!var_0F || func_581B(param_00)) && !var_10) {
          var_0A = var_0A * 0.5;
        }
      }

      if(isDefined(param_05) && param_05 == "bomb_site_mp" && func_581F(param_00)) {
        var_0A = 0;
      }
    }

    if(maps\mp\gametypes\_damage::func_118E(param_02, param_05)) {
      var_0A = 0;
    }

    if(isDefined(param_02) && common_scripts\utility::func_562E(param_02.var_A3EF)) {
      if(param_00.var_BC == 1) {
        var_0A = 0;
      } else {
        var_0A = 1;
      }
    }

    if(isDefined(param_00.raidmaniac) && param_00.raidmaniac) {
      var_0A = var_0A * 0.4;
    }

    if(isDefined(param_00.raidcombatbuff) && param_00.raidcombatbuff) {
      var_0A = var_0A * 0.5;
    }
  }

  param_03 = int(var_0A);
  return param_03;
}

func_581F(param_00) {
  var_01 = param_00 method_85E3();
  if(isDefined(var_01)) {
    var_02 = var_01 getlinkedparent();
    return isDefined(var_02) && isDefined(var_02.var_3B) && var_02.var_3B == "script_vehicle";
  }

  return 0;
}

func_581B(param_00) {
  var_01 = param_00 method_85E3();
  if(isDefined(var_01) && isDefined(var_01.var_165) && var_01.var_165 == "armored_mg") {
    return 1;
  }

  return 0;
}

func_4B93(param_00) {
  var_01 = param_00 getcurrentweapon();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = function_01AA(var_01);
  if(isDefined(var_02) && var_02 == "spread") {
    return 1;
  }

  return 0;
}

func_9093(param_00) {
  self endon("disconnect");
  self endon("removed_spawn_protection");
  self.var_4B97 = 1;
  common_scripts\utility::func_A70D(param_00, self, "death", self, "disable_spawn_protection");
  self.var_4B97 = undefined;
  self notify("removed_spawn_protection");
}

func_9026(param_00) {
  self endon("disconnect");
  self notify("spawnAllowClassSelection");
  self endon("spawnAllowClassSelection");
  self.var_C1F = 1;
  common_scripts\utility::func_A74B("death", param_00);
  self.var_C1F = undefined;
}

func_6B6C() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    level thread func_2820(var_00);
    var_00.var_7682 = ::func_743C;
    var_00 thread func_6B82();
  }
}

func_6B79() {
  level endon("game_ended");
  for(;;) {
    level waittill("joined_team", var_00);
    if(var_00.var_1A7 == "spectator") {
      continue;
    }

    var_00 lib_0502::func_7416();
  }
}

func_6B82() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.var_5DA9 = undefined;
    self.var_5DAA = undefined;
    self.var_3E24 = 0;
    self.var_3E19 = 0;
    self.var_2011 = 0;
    self.var_2012 = undefined;
  }
}

func_743C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(param_02) && param_02 isusingturret()) {
    var_0B = param_02 method_85E3();
    if(isDefined(var_0B) && common_scripts\utility::func_562E(var_0B.var_5DBC)) {
      param_02.var_5DA9 = var_0B;
      param_02.var_5DAA = "tag_yaw";
      return;
    }

    return;
  }

  if(common_scripts\utility::func_562E(param_02.var_2011)) {
    thread func_2011();
    return;
  }

  var_0C = param_02 method_8551();
  if(isDefined(var_0C) && common_scripts\utility::func_562E(var_0C.var_4881)) {
    param_02.var_3E24 = 1;
    return;
  }
}

func_2011() {
  self endon("disconnect");
  self.var_3E24 = 1;
  self.var_3E19 = 1;
  if(isDefined(self.var_2012)) {
    playFX(common_scripts\utility::func_44F5(self.var_2012), self.var_116);
  }

  wait(0.1);
  physicsexplosionsphere(self.var_116 + (0, 0, 5), 200, 50, 3);
}

func_6AB8() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("applyLoadout");
  if(function_01EF(self)) {
    self.var_1444 = 0;
  }

  if(isDefined(self.var_3FC6) && self.var_3FC6) {
    maps\mp\killstreaks\_killstreaks::func_2400();
  }

  if(0) {
    self.var_79 = 5;
  }

  level notify("raidRoleSet", self);
  waittillframeend;
  self.var_3FC6 = 0;
}

func_2820(param_00) {
  param_00.var_3FC6 = 1;
  param_00.var_79A2 = 0;
  param_00.var_259A = 0;
  param_00.var_2E36 = 0;
  param_00.var_38D3 = 1;
  if(!isDefined(param_00 maps\mp\_utility::func_4607("raidKillz"))) {
    param_00 maps\mp\_utility::func_532D("raidKillz");
  }

  if(!isDefined(param_00 maps\mp\_utility::func_4607("constructs"))) {
    param_00 maps\mp\_utility::func_532D("constructs");
  }

  if(!isDefined(param_00 maps\mp\_utility::func_4607("destructs"))) {
    param_00 maps\mp\_utility::func_532D("destructs");
  }

  if(game["switchedsides"]) {
    param_00.var_79A2 = param_00 maps\mp\_utility::func_4607("raidKillz");
    param_00 setclientomnvar("ui_onevone_class_1", param_00.var_79A2);
    param_00 setclientomnvar("ui_onevone_class_2", param_00 maps\mp\_utility::func_4607("defends"));
    param_00.var_259A = param_00 maps\mp\_utility::func_4607("constructs");
    param_00 setclientomnvar("ui_onevone_class_3", param_00.var_259A);
    param_00.var_2E36 = param_00 maps\mp\_utility::func_4607("destructs");
    param_00 setclientomnvar("ui_onevone_class_4", param_00.var_2E36);
  }
}

func_36C3(param_00, param_01, param_02, param_03) {
  foreach(var_05 in level.var_744A) {
    if(isDefined(var_05.var_2583) || var_05.var_12C["team"] == "spectator" && !var_05 method_8436()) {
      continue;
    }

    var_05 setclientomnvar("ui_round_end", 2);
  }

  maps\mp\gametypes\_gamelogic::func_7F19(level.var_7F16, 0);
  if(!game["switchedsides"]) {
    wait(0.2);
  }
}

func_36C0() {
  foreach(var_01 in level.var_744A) {
    transferandzeroroundstats(var_01);
  }

  foreach(var_01 in level.var_744A) {
    var_01.var_1E24 = var_01.var_12C["team"];
    var_01.cacheloss = var_01.var_12C["recordedLoss"];
    var_01.cachejip = var_01.var_12C["jip_game_one"];
  }

  function_03A4();
  foreach(var_01 in level.var_744A) {
    var_01.var_12C["team"] = var_01.var_1E24;
    var_01.var_12C["recordedLoss"] = var_01.cacheloss;
    var_01.var_12C["jip_game_one"] = var_01.cachejip;
  }

  game["gamestarted"] = undefined;
  game["clientMatchDataDef"] = undefined;
  foreach(var_01 in level.var_744A) {
    var_01.var_12C["secondHalfInitialConnect"] = 1;
  }
}

func_21ED() {
  var_00 = 3;
  if(!game["switchedsides"]) {
    return;
  }

  var_01 = maps\mp\gametypes\_gamelogic::func_46E5();
  if(var_01 > 0) {
    var_02 = var_01 <= var_00 * 60 * 1000;
    setnojiptime(var_02);
  }
}

func_79A5(param_00) {
  if(!func_79A6()) {
    return 0;
  }

  if(common_scripts\utility::func_F79(level.var_79E9, param_00)) {
    return 0;
  }

  return 1;
}

isweaponnearinteractable(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_01[2] + param_02;
  if(param_00[2] > var_05) {
    return 0;
  }

  var_06 = param_01[2] - param_03;
  if(param_00[2] < var_06) {
    return 0;
  }

  if(distance2dsquared(param_00, param_01) < param_04) {
    return 1;
  }

  return 0;
}

func_79A6() {
  foreach(var_01 in level.var_79BF) {
    if(!isDefined(var_01)) {
      continue;
    }

    if(isDefined(var_01.repairactive) && var_01.repairactive == 0) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_01.var_116, 30, 90, 30625)) {
      return 0;
    }
  }

  foreach(var_04 in level.var_79C2.var_9F96) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_04.var_116, 30, 90, 19600)) {
      return 0;
    }
  }

  foreach(var_07 in level.var_79EE) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_07.var_116, 30, 90, 65536)) {
      return 0;
    }
  }

  foreach(var_0A in level.var_79ED) {
    if(!isDefined(var_0A)) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_0A.var_116, 30, 90, 65536)) {
      return 0;
    }
  }

  foreach(var_0D in level.var_7929) {
    if(!isDefined(var_0D)) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_0D.var_116, 30, 90, 262144)) {
      return 0;
    }
  }

  foreach(var_11, var_10 in level.var_79BE) {
    if(!isDefined(var_10)) {
      continue;
    }

    if(isweaponnearinteractable(self.var_116, var_10.var_116, 30, 90, 262144)) {
      return 0;
    }
  }

  foreach(var_13 in level.raidhostageobjectivetrigger) {
    if(!isDefined(var_13)) {
      continue;
    }

    if(ispointinvolume(self.var_116, var_13)) {
      return 0;
    }
  }

  return 1;
}

raidmodehandledroppedweapon(param_00) {
  param_00 endon("death");
  wait(2);
  if(isDefined(param_00) && !param_00 func_79A6()) {
    param_00 delete();
  }
}