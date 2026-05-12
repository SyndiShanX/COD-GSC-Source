/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1282.gsc
*********************************************/

func_7978() {
  var_00 = maps\mp\_utility::func_46E3();
  if(var_00 < 0) {
    var_00 = 0;
  }

  return var_00;
}

func_797A() {
  var_00 = game["switchedsides"] == 0;
  var_01 = level.var_3B5C;
  if(game["switchedsides"]) {
    var_01 = maps\mp\_utility::func_45DE(var_01);
  }

  return var_01;
}

func_7F9A() {
  level.var_79AE.var_6CCF = [];
  level.var_6BB6 = ::common_scripts\utility::func_A60A;
  maps\mp\_utility::func_5CBE("raid_victory");
  func_79D2();
  wait(0.5);
  var_00 = game["attackers"];
  if(getomnvar("ui_war_attacker_flipped") == 1) {
    var_00 = game["defenders"];
  }

  level.var_3B5C = var_00;
  level thread maps\mp\gametypes\_gamelogic::func_36B9(level.var_3B5C, game["end_reason"]["objective_completed"]);
}

func_86DE(param_00, param_01) {
  level.var_2945 = param_01;
  level.var_2946 = gettime();
  level.currentobjectiveaddedtime = 0;
  level.currentobjectiveoriginaltimelimit = param_00;
  level.currentobjectiveovertimetime = 0;
  setomnvar("ui_war_objective_starttime", level.var_2946);
  setomnvar("ui_war_active_sector", param_01 - 1);
  if(!maps\mp\gametypes\raid::func_6976()) {
    return;
  }

  var_02 = "scr_raid_timelimit";
  var_03 = lib_0501::func_4648("raid_stopWatch");
  if(var_03 && isDefined(param_01) && param_01 > 0 && param_01 < 5 && game["switchedsides"]) {
    var_04 = "time_split_" + level.var_9A6B[param_01];
    var_05 = game[game["defenders"] + "_raids"][var_04];
    if(var_05 == 0) {
      func_7F9A();
    }

    var_05 = var_05 + level.var_201B;
    var_06 = maps\mp\_utility::func_4589();
    var_07 = var_05 / -5536;
    var_08 = var_06 + var_07;
    func_8671(var_02, var_08 + 0.01694915);
  } else {
    var_06 = maps\mp\_utility::func_4589();
    var_08 = var_08 + param_01;
    func_8671(var_02, var_08 + 0.01694915);
    var_09 = "raids_time_limit_objective_" + level.var_9A6B[param_01];
    var_0A = param_00 * 60 * 1000;
    game[var_09] = int(var_0A);
  }

  maps\mp\_utility::func_A193(var_02);
}

addtoobjectivetimelimit(param_00, param_01) {
  if(!maps\mp\gametypes\raid::func_6976()) {
    return;
  }

  var_02 = "scr_raid_timelimit";
  level.currentobjectiveaddedtime = level.currentobjectiveaddedtime + param_00;
  level.currentobjectiveovertimetime = level.currentobjectiveovertimetime + lib_04FF::func_79B8();
  var_03 = level.currentobjectiveovertimetime / -5536;
  var_04 = gettime() - level.var_2946 / -5536;
  var_05 = level.currentobjectiveaddedtime / 60;
  var_06 = gettime() - level.var_9309 - level.var_2FB1 / -5536;
  var_07 = var_06 + var_05 + level.currentobjectiveoriginaltimelimit + var_03 - var_04;
  func_8671(var_02, var_07 + 0.01694915);
  var_08 = "raids_time_limit_objective_" + level.var_9A6B[param_01];
  var_09 = level.currentobjectiveoriginaltimelimit * 60 * 1000 + level.currentobjectiveaddedtime * 1000;
  game[var_08] = game[var_08] + int(var_09);
  maps\mp\_utility::func_A193(var_02);
  level thread lib_04F3::raidmusiccountdownrestart();
}

func_8671(param_00, param_01) {
  setDvar(param_00, param_01);
  level.var_4E06[param_00] = param_01;
}

func_A781() {
  level endon("host_migration_begin");
  if(isDefined(level.var_4E09)) {
    return;
  }

  level waittill("forever");
}

func_7B35(param_00) {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp/ddl/clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
  }

  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(level.var_2945 < 0 || level.var_2945 > 4) {
    return;
  }

  var_01 = func_7978();
  var_02 = gettime() - level.var_2946;
  var_03 = "time_split_" + level.var_9A6B[level.var_2945];
  var_04 = game["attackers"] + "GameModeData";
  var_05 = "ui_war_attacker_sector" + level.var_9A6B[level.var_2945] + "_completion_time";
  var_06 = "raids_time_limit_objective_" + level.var_9A6B[level.var_2945];
  var_07 = lib_0501::func_4648("raid_stopWatch");
  setmatchdata(var_04, level.var_2945 - 1, var_01);
  setclientmatchdata(var_04, level.var_2945 - 1, var_01);
  if(param_00) {
    setmatchdata(game["attackers"] + "OBJ", level.var_2945);
    setclientmatchdata(game["attackers"] + "OBJ", level.var_2945);
    game[game["attackers"] + "OBJ"] = level.var_2945;
  }

  if(var_07 && game["switchedsides"]) {
    var_08 = game[game["defenders"] + "_raids"][var_03];
    var_08 = var_08 + level.var_201B;
    level.var_201B = var_08 - var_02;
    if(var_02 > var_08) {
      var_02 = var_08;
      level.var_201B = 0;
    }
  } else if(var_02 > game[var_06]) {
    var_02 = game[var_06];
  }

  game[game["attackers"] + "_raids"][var_03] = var_02;
  setomnvar(var_05, var_02);
  func_6936();
}

raidobjectivefailure(param_00) {
  func_79D2();
  func_7B35(0);
  var_01 = game["defenders"];
  if(getomnvar("ui_war_attacker_flipped") == 1) {
    var_01 = game["attackers"];
  }

  var_02 = "time_limit_reached";
  if(common_scripts\utility::func_562E(param_00)) {
    var_02 = "objective_completed";
  }

  level.var_3B5C = var_01;
  level thread maps\mp\gametypes\_gamelogic::func_36B9(level.var_3B5C, game["end_reason"][var_02]);
}

raidawardflagraiserkillevent(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_flag_raiser_kill", param_00);
}

func_7922(param_00) {
  if(!isPlayer(param_00)) {
    return;
  }

  if(level.var_79AE.var_8DB.size > 0) {
    var_01 = level.var_79AE.var_8DB[0].var_695A;
    var_02 = level.var_79C2.var_693B[var_01].var_6984;
    if(isDefined(var_02) && !var_02 method_858B(param_00.var_116)) {
      return;
    }
  }

  param_00.var_259A++;
  param_00 maps\mp\_utility::func_86F5("constructs", param_00.var_259A);
  param_00 maps\mp\_utility::func_50EA("raids_construct", 1);
  param_00 setclientomnvar("ui_onevone_class_3", param_00.var_259A);
  level thread maps\mp\gametypes\_rank::func_1457("raids_construct", param_00);
}

func_7923(param_00) {
  if(level.var_79AE.var_8DB.size > 0) {
    var_01 = level.var_79AE.var_8DB[0].var_695A;
    var_02 = level.var_79C2.var_693B[var_01].var_6984;
    if(isDefined(var_02) && !var_02 method_858B(param_00.var_116)) {
      return;
    }
  }

  param_00.var_2E36++;
  param_00 maps\mp\_utility::func_86F5("destructs", param_00.var_2E36);
  param_00 maps\mp\_utility::func_50EA("raids_destruct", 1);
  param_00 setclientomnvar("ui_onevone_class_4", param_00.var_2E36);
  level thread maps\mp\gametypes\_rank::func_1457("raids_destruct", param_00);
}

raidawarddestructionpropevent(param_00) {
  param_00.var_2E36++;
  param_00 maps\mp\_utility::func_86F5("destructs", param_00.var_2E36);
  param_00 maps\mp\_utility::func_50EA("raids_destruct", 1);
  param_00 setclientomnvar("ui_onevone_class_4", param_00.var_2E36);
  level thread maps\mp\gametypes\_rank::func_1457("raids_destruct_equipment", param_00);
  level thread maps\mp\_utility::func_9863("raids_subobjective_destroyed", param_00);
}

func_7921(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_build_objective", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_build_objective", param_00);
}

func_7925(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_progress", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_progress", param_00);
  param_00 thread maps\mp\gametypes\_hud_message::func_9102(func_45CC(param_00.var_1A7));
}

raidawardsecuringobjectiveevent(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_secure", param_00);
}

raidawardtankescortevent(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_tank_escort", param_00);
}

raidawardtankescortcheckpointevent(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_tank_escort_checkpoint", param_00);
}

func_7924(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_escort", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_escort", param_00);
}

func_7926(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_retreat", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_retreat", param_00);
}

raidawardhostagedoorbreachevent(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457("raids_hostage_door_breach", param_00);
}

raidawardhostagereleasedevent(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_hostage_release", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_hostage_release", param_00);
}

raidawardbuildxpevent() {
  self notify("buildXPEvent");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("buildXPEvent");
  var_00 = 0;
  while(common_scripts\utility::func_562E(self.var_581C)) {
    wait(0.1);
    var_00++;
    if(var_00 >= 10) {
      var_00 = 0;
      level thread maps\mp\gametypes\_rank::func_1457("raids_building", self);
    }
  }
}

func_56D3() {
  return isDefined(self.var_187) && self.var_187 & 1 && self.var_3A == "script_brushmodel";
}

func_06A9() {
  if(common_scripts\utility::func_562E(self.var_799B)) {
    return;
  }

  self.var_799B = 1;
  self.var_7999 = self method_85A0();
  self.var_799A = func_56D3();
  self.var_799C = self.var_3B == "misc_turret";
  if(isDefined(self.var_8247) && self.var_8247 == "onlyManualDisconnect") {
    self.var_799A = 0;
  }

  self.var_7998 = self.var_3B == "script_brushmodel";
  self.var_799D = self.var_3B == "script_model";
  self.var_799E = self.var_3B == "trigger_use_touch" || self.var_799C;
}

func_7997() {
  func_06A9();
  func_793D("drop");
  self method_805C();
  if(self.var_7998) {
    if(self.var_799A) {
      if(isDefined(self.var_8260) && self.var_8260 == "start_disconnected") {
        self method_805F();
      } else {
        self method_8060();
      }
    }

    self notsolid();
  }

  if(self.var_799D) {
    self method_80B1();
  }

  if(self.var_799C) {
    thread func_06AA();
    return;
  }

  if(self.var_799E) {
    common_scripts\utility::func_9D9F();
  }
}

func_06AA() {
  self endon("death");
  var_00 = self method_80E2();
  if(isDefined(var_00)) {
    var_00 method_85E9();
    wait 0.05;
  }

  if(self.var_799E) {
    common_scripts\utility::func_9D9F();
  }
}

func_79C6() {
  func_06A9();
  self method_805B();
  if(self.var_7998) {
    self solid();
    if(self.var_799A) {
      if(isDefined(self.var_8260) && self.var_8260 == "start_disconnected") {
        self method_8060();
      } else {
        self method_805F();
      }
    }
  }

  if(self.var_799D) {
    self method_80B0(self.var_7999);
  }

  if(self.var_799E) {
    common_scripts\utility::func_9DA3();
  }

  func_793D();
}

func_7D5C(param_00) {
  param_00.var_93FD = 0;
  param_00.var_A86E = 1;
  param_00.var_6A = 0;
}

func_6936() {
  level thread lib_04F3::raidmusicobjectivecomplete();
  foreach(var_01 in level.var_744A) {
    if(var_01.var_1A7 == game["attackers"]) {
      func_7925(var_01);
      continue;
    }

    if(var_01.var_1A7 == game["defenders"]) {
      var_01 thread maps\mp\gametypes\_hud_message::func_9102(func_45CF(var_01.var_1A7));
    }
  }

  level thread func_940C(5);
}

func_45CF(param_00) {
  if(func_7979(param_00) == "allies") {
    return "raids_objective_lost_allies";
  }

  return "raids_objective_lost_axis";
}

func_45CC(param_00) {
  if(func_7979(param_00) == "allies") {
    return "raids_progress_allies";
  }

  return "raids_progress_axis";
}

func_940C(param_00) {
  level.var_2FA1 = 1;
  wait(param_00);
  level.var_2FA1 = 0;
}

func_A754() {
  for(;;) {
    if(isDefined(level.var_744A)) {
      foreach(var_01 in level.var_744A) {
        if(isDefined(var_01.var_1A7) && var_01.var_1A7 == "allies" || var_01.var_1A7 == "axis") {
          return;
        }
      }
    }

    wait 0.05;
  }
}

func_2D1D() {
  self endon("death");
  level waittill("game_ended");
  self delete();
}

func_8C23(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  self method_805C();
  foreach(var_03 in level.var_744A) {
    var_04 = var_03.var_178 == "spectator";
    if(var_03.var_1A7 == param_00 && !var_04) {
      self showtoclient(var_03);
    }

    if(param_01 && (var_03.var_1A7 == "spectator" || var_04) && param_00 == "allies") {
      self showtoclient(var_03);
    }
  }
}

func_8C21(param_00, param_01) {
  thread animscripts\notetracks_common::func_8C21(param_00, param_01);
  thread func_8C22(param_00);
}

func_8C20() {
  self notify("clear");
  self method_805B();
  func_8C1F();
}

func_2FA6() {
  self endon("death");
  self endon("enableUseForAllPlayers");
  self notify("disableUseForAllPlayers");
  self endon("disableUseForAllPlayers");
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    foreach(var_01 in level.var_744A) {
      self disableplayeruse(var_01);
    }

    level waittill("connected");
  }
}

func_3669() {
  self endon("death");
  self endon("disableUseForAllPlayers");
  self notify("enableUseForAllPlayers");
  self endon("enableUseForAllPlayers");
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    foreach(var_01 in level.var_744A) {
      self enableplayeruse(var_01);
    }

    level waittill("connected");
  }
}

func_7979(param_00) {
  if(param_00 == "attackers" || param_00 == "defenders") {
    var_01 = game[param_00];
  } else {
    var_01 = var_01;
  }

  if(game["switchedsides"]) {
    return maps\mp\_utility::func_45DE(var_01);
  }

  return var_01;
}

func_4679(param_00) {
  var_01 = [];
  if(!isDefined(param_00.var_8260)) {
    return var_01;
  }

  var_02 = [];
  var_02 = strtok(param_00.var_8260, " ");
  var_03 = 0;
  foreach(var_05 in var_02) {
    var_06 = [];
    var_06 = strtok(var_05, ":");
    if(var_06.size == 2) {
      var_01[var_06[0]] = var_06[1];
      continue;
    }

    var_01[var_03] = var_06[0];
    var_03++;
  }

  return var_01;
}

func_A273(param_00, param_01, param_02) {
  if(!isarray(param_00) && isarray(param_01) && isarray(param_02)) {
    return 0;
  }

  foreach(var_04 in param_01) {
    if(!isDefined(param_00[var_04])) {
      return 0;
    }
  }

  var_06 = common_scripts\utility::func_F8C(param_01, param_02);
  foreach(var_04, var_08 in param_00) {
    if(!isDefined(var_08)) {
      return 0;
    }

    if(!common_scripts\utility::func_F79(var_06, var_04)) {
      return 0;
    }
  }

  return 1;
}

func_2D2D() {
  self endon("death");
  wait 0.05;
  wait 0.05;
  self delete();
}

func_2548(param_00, param_01) {
  if(!isDefined(self.var_2548)) {
    self.var_2548 = [];
  }

  var_02 = spawnStruct();
  var_02.var_109 = param_00;
  var_02.var_3F02 = param_01;
  self.var_2548[param_00] = var_02;
  return var_02;
}

func_2549(param_00, param_01) {
  foreach(var_0A, param_00 in level.var_2548) {
    var_03 = common_scripts\utility::func_46B7(var_0A, "script_noteworthy");
    var_04 = getEntArray(var_0A, "script_noteworthy");
    var_05 = getnodearray(var_0A, "script_noteworthy");
    var_06 = common_scripts\utility::func_F73(common_scripts\utility::func_F73(var_03, var_04), var_05);
    foreach(var_08 in var_06) {
      var_08 func_254B();
      var_08 func_254A(var_08, param_00);
    }
  }
}

func_254A(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  if(isDefined(param_01.var_2548)) {
    foreach(var_04, var_03 in param_01.var_2548) {
      if(!isDefined(param_00.var_982D[var_04])) {
        param_00.var_982D[var_04] = [];
      }
    }
  }

  if(isDefined(param_01.var_3F02)) {
    self thread[[param_01.var_3F02]](param_00);
  }

  if(!isDefined(param_01.var_2548)) {
    return;
  }

  foreach(var_04, var_06 in param_00.var_982D) {
    foreach(var_08 in var_06) {
      func_254A(var_08, param_01.var_2548[var_04]);
    }
  }
}

func_254B(param_00) {
  if(!isDefined(self.var_982D)) {
    self.var_982D = [];
  }

  if(common_scripts\utility::func_562E(self.var_982F)) {
    return;
  }

  self.var_982F = 1;
  self.var_982E = param_00;
  if(!isDefined(self.var_1A2)) {
    return;
  }

  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  var_02 = getEntArray(self.var_1A2, "targetname");
  var_03 = getnodearray(self.var_1A2, "targetname");
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(!isDefined(var_03[var_04].var_165)) {
      var_03[var_04] = var_03[var_03.size - 1];
      var_03[var_03.size - 1] = undefined;
      var_04--;
    }
  }

  var_05 = common_scripts\utility::func_F73(common_scripts\utility::func_F73(var_01, var_02), var_03);
  foreach(var_07 in var_05) {
    var_08 = var_07.var_165;
    if(!isDefined(var_08)) {
      var_08 = var_07.var_3A;
    }

    if(!isDefined(var_08)) {
      var_08 = "script_struct";
    }

    if(!isDefined(self.var_982D[var_08])) {
      self.var_982D[var_08] = [];
    }

    var_09 = self.var_982D[var_08].size;
    self.var_982D[var_08][var_09] = var_07;
    var_07 func_254B(self);
  }
}

func_2084(param_00) {
  param_00 linkto(param_00.var_982E);
}

ces_setownedbyparent(param_00) {
  param_00 setentityowner(param_00.var_982E);
}

func_2082(param_00) {
  if(!isDefined(param_00.var_1D)) {
    param_00.var_1D = (0, 0, 0);
  }
}

func_6AB1(param_00) {
  if(isDefined(param_00.var_8260)) {
    self waittillmatch(param_00.var_8260, "trigger");
  } else {
    self waittill("trigger");
  }

  param_00 common_scripts\utility::func_161();
}

func_207A(param_00) {
  param_00 endon("death");
  func_6AB1(param_00);
  param_00 delete();
}

func_2087(param_00) {
  param_00 endon("death");
  func_6AB1(param_00);
  var_01 = vectornormalize(param_00.var_116 - param_00.var_982E.var_116);
  var_01 = var_01 * 10000;
  param_00 method_82C5(param_00.var_116, var_01);
}

func_2088(param_00) {
  param_00 endon("death");
  param_00 func_7997();
  func_6AB1(param_00);
  param_00 func_79C6();
}

func_207B(param_00) {
  func_6AB1(param_00);
  playFX(common_scripts\utility::func_44F5(param_00.var_81BB), param_00.var_116, anglesToForward(param_00.var_1D));
}

func_2089(param_00) {
  func_6AB1(param_00);
  lib_04F3::func_79CB(param_00.var_828A, param_00.var_116);
}

func_2085(param_00) {
  param_00 endon("death");
  func_6AB1(param_00);
  var_01 = common_scripts\utility::func_46B5(param_00.var_1A2, "targetname");
  var_02 = param_00.var_817A;
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  var_03 = trajectorycalculateinitialvelocity(param_00.var_116, var_01.var_116, (0, 0, -800), var_02);
  param_00 gravitymove(var_03, var_02);
  param_00 rotateto(var_01.var_1D, var_02, 0, var_02);
}

func_2086(param_00) {
  param_00 endon("death");
  func_6AB1(param_00);
  var_01 = common_scripts\utility::func_46B5(param_00.var_1A2, "targetname");
  var_02 = param_00.var_817A;
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  param_00 moveto(var_01.var_116, var_02);
  param_00 rotateto(var_01.var_1D, var_02, 0, var_02);
}

func_2083(param_00) {
  param_00 endon("death");
  func_6AB1(param_00);
  var_01 = getent(param_00.var_1A2, "targetname");
  param_00 linkto(var_01);
}

func_2081(param_00) {
  func_2080(param_00);
  var_01 = param_00.var_982E;
  var_01.var_64D7 = param_00.var_165;
  var_01.var_64D9 = undefined;
  if(var_01.var_116 != param_00.var_116 || anglesdelta(param_00.var_1D, var_01.var_1D) != 0) {
    var_01.var_64DA = spawn("script_origin", param_00.var_116);
    var_01.var_64DA.var_1D = param_00.var_1D;
    var_01.var_64DA linkto(var_01);
    return;
  }

  var_01.var_64DA = var_01;
}

func_2080(param_00) {
  if(!isDefined(param_00.var_1D)) {
    param_00.var_1D = (0, 0, 0);
  }

  var_01 = param_00.var_982E;
  if(!isDefined(var_01.var_64AE)) {
    var_01.var_64BD = [];
  }

  var_01.var_64DB[param_00.var_165] = param_00;
}

func_207D(param_00) {
  if(isDefined(self.var_982D) && isDefined(self.var_982D[param_00])) {
    return self.var_982D[param_00];
  }

  return [];
}

func_207E(param_00) {
  if(isDefined(self.var_982D) && isDefined(self.var_982D[param_00])) {
    return self.var_982D[param_00][0];
  }

  return undefined;
}

func_207C(param_00) {
  var_01 = [];
  if(isDefined(self.var_982D)) {
    if(isDefined(self.var_982D[param_00])) {
      var_01 = self.var_982D[param_00];
    }

    foreach(var_03 in self.var_982D) {
      foreach(var_05 in var_03) {
        var_01 = common_scripts\utility::func_F73(var_01, var_05 func_207C(param_00));
      }
    }
  }

  return var_01;
}

func_207F() {
  var_00 = self;
  while(isDefined(var_00.var_982E)) {
    var_00 = var_00.var_982E;
  }

  return var_00;
}

func_8628(param_00) {
  var_01 = level.var_79C2.var_693B[param_00].var_6984;
  if(!isDefined(var_01)) {
    return;
  }

  level notify("kill_minimap_objectives");
  level.var_1D35 = common_scripts\utility::func_FA0(level.var_1D35);
  foreach(var_03 in level.var_1D35) {
    var_03.var_C0F = 0;
  }

  foreach(var_03 in level.var_1D35) {
    if(!common_scripts\utility::func_562E(var_03.var_2F16) && var_01 method_858B(var_03.var_116)) {
      var_03.var_C0F = 1;
    }
  }

  foreach(var_03 in level.var_1D35) {
    if(var_03.var_6989 > -1 && var_03.var_C0F == 0) {
      maps\mp\_utility::func_68B(var_03.var_6989);
      var_03.var_6989 = -1;
    }
  }

  foreach(var_03 in level.var_1D35) {
    if(var_03.var_6989 == -1 && var_03.var_C0F == 1) {
      var_0A = maps\mp\gametypes\_gameobjects::func_45A9();
      var_03.var_6989 = var_0A;
      objective_add(var_0A, "noclamp", var_03.var_1D34, var_03.var_1D33);
    }
  }
}

func_1D39(param_00) {
  if(!isDefined(level.var_1D35)) {
    level.var_1D35 = [];
  }

  level.var_1D35[level.var_1D35.size] = param_00;
  param_00.var_1D34 = (0, 0, 0);
  param_00.var_6989 = -1;
  param_00.var_C0F = 0;
}

func_1D3A(param_00, param_01) {
  if(self.var_1D34 == (0, 0, 0)) {
    if(function_0296(param_00)) {
      self.var_1D34 = param_00;
    } else {
      self.var_1D34 = param_00.var_116;
    }
  }

  if(common_scripts\utility::func_562E(param_01)) {
    self.var_1D33 = "waypoint_buildable_active_map";
    return;
  }

  self.var_1D33 = "waypoint_buildable_inactive_map";
}

func_2DBE(param_00) {
  if(!isDefined(level.var_1D35)) {
    level.var_1D35 = [];
  }

  level.var_1D35[level.var_1D35.size] = param_00;
  param_00.var_1D34 = param_00.var_116;
  param_00.var_6989 = -1;
  param_00.var_C0F = 0;
  param_00.var_1D33 = "waypoint_buildable_active_map";
}

func_2DBF(param_00) {
  if(param_00.var_6989 > 0) {
    objective_delete(param_00.var_6989);
  }

  level.var_1D35 = common_scripts\utility::func_F98(param_00, level.var_1D35);
}

func_1D3B(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    self.var_1D33 = "waypoint_buildable_active_map";
  } else {
    self.var_1D33 = "waypoint_buildable_inactive_map";
  }

  if(self.var_6989 > -1) {
    function_01D1(self.var_6989, self.var_1D33);
  }
}

func_1D38(param_00, param_01, param_02, param_03) {
  var_04 = func_1D36(param_00, param_01, param_02);
  return var_04;
}

func_1D36(param_00, param_01, param_02) {
  var_03 = -1;
  if(isexplosivedamagemod(param_02) && isDefined(param_01)) {
    var_04 = param_01;
    if(function_030D(param_01)) {
      var_04 = maps\mp\_utility::func_452B(param_01);
    }

    if(maps\mp\_utility::func_5856(var_04)) {
      var_04 = maps\mp\gametypes\_class::func_4432(var_04);
    }

    switch (var_04) {
      case "bouncingbetty_mp":
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        if(isDefined(param_00) && param_00 maps\mp\_utility::func_649("specialty_explosivewareffectiveness")) {
          var_03 = 2;
        } else {
          var_03 = 1;
        }
        break;

      case "panzerschreck_mp":
      case "bazooka_mp":
      case "c4_mp":
        if(isDefined(param_00) && param_00 maps\mp\_utility::func_649("specialty_explosivewareffectiveness")) {
          var_03 = 4;
        } else {
          var_03 = 2;
        }
        break;

      default:
        break;
    }
  }

  return var_03;
}

func_1D37(param_00, param_01, param_02, param_03) {
  var_04 = func_207F();
  if(isDefined(var_04.var_2599)) {
    if(var_04.var_2599 == 0) {
      return 0;
    }
  }

  if(isPlayer(param_00) && isDefined(self.var_706B) && param_00.var_1A7 != self.var_706B) {
    return 0;
  }

  if(maps\mp\_utility::func_5694(param_02) || isexplosivedamagemod(param_02)) {
    return param_03;
  }

  return 0;
}

func_64D5(param_00, param_01, param_02, param_03) {
  param_00 notify("moveToPos");
  param_00.var_64D8 = param_01;
  var_04 = param_00.var_64DB[param_01];
  var_05 = transformmove(var_04.var_116, var_04.var_1D, param_00.var_64DA.var_116, param_00.var_64DA.var_1D, param_00.var_116, param_00.var_1D);
  param_00 moveto(var_05["origin"], param_02);
  param_00 rotateto(var_05["angles"], param_02);
  thread func_64EE(param_00, param_02, param_03);
}

func_64EE(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("moveToPos");
  if(param_00 func_56D3() && !common_scripts\utility::func_562E(param_02)) {
    param_00 method_8060();
  }

  wait(param_01);
  if(param_00 func_56D3() && !common_scripts\utility::func_562E(param_02)) {
    param_00 method_805F();
  }

  param_00.var_64D6 = param_00.var_AD;
  param_00.var_64D8 = undefined;
  self notify("moveToPosDone");
}

func_6514() {
  return spawnStruct();
}

func_6516() {
  self waittill("objective_complete", var_00);
  return var_00;
}

func_6517(param_00, param_01, param_02, param_03) {
  self endon("objective_complete");
  if(isDefined(param_03)) {
    [[param_01]](param_02, param_03);
  } else if(isDefined(param_02)) {
    [[param_01]](param_02);
  } else {
    [[param_01]]();
  }

  self notify("objective_complete", param_00);
}

func_90A7(param_00, param_01, param_02, param_03, param_04) {
  level notify("spawnStaggerToLabel");
  level endon("spawnStaggerToLabel");
  func_90A4(param_00, param_01);
  maps\mp\gametypes\_hostmigration::func_A6F5(param_02);
  func_90A4(param_03, param_04);
}

func_90A4(param_00, param_01) {
  var_02 = getgamespawnpointactivelabel("allies");
  var_03 = getgamespawnpointactivelabel("axis");
  var_04 = getgamespawnpointactivelabel("free");
  if(game["defenders"] == "axis") {
    if(isDefined(param_00)) {
      var_03 = param_00;
    }

    if(isDefined(param_01)) {
      var_02 = param_01;
    }
  } else {
    if(isDefined(param_00)) {
      var_02 = param_00;
    }

    if(isDefined(param_01)) {
      var_03 = param_01;
    }
  }

  func_8691(var_02, var_03, var_04);
}

func_8691(param_00, param_01, param_02) {
  thread func_8690(param_00, param_01, param_02);
}

func_8690(param_00, param_01, param_02) {
  level notify("SetGameSpawnPointActiveLabel");
  level endon("SetGameSpawnPointActiveLabel");
  level endon("game_ended");
  setgamespawnpointactivelabel(param_00, param_01, param_02);
  level notify("raid_spawns_changed");
  for(;;) {
    func_A781();
    maps\mp\gametypes\_hostmigration::func_A782();
    setgamespawnpointactivelabel(param_00, param_01, param_02);
    level notify("raid_spawns_changed");
  }
}

func_447F(param_00) {
  var_01 = lib_050D::func_44F9(param_00);
  var_02 = [];
  var_03 = getgamespawnpointactivelabel(param_00);
  foreach(var_05 in var_01) {
    if(var_05.var_9849 == param_00 && var_05.var_1A5 == var_03) {
      var_02[var_02.size] = var_05;
    }
  }

  return var_02;
}

func_79E1(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 notify("_raidTrigger");
  param_00 endon("_raidTrigger");
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_05)) {
    param_05 = (0, 0, 0);
  }

  if(isDefined(param_00.var_A240)) {
    param_00.var_A240 maps\mp\gametypes\_gameobjects::func_2D58();
  }

  param_00 sethintstring(param_01);
  param_00 setcursorhint("HINT_NOICON");
  if(param_02 > 0) {
    childthread func_79E7(param_00, param_02, param_01, param_03, param_04, param_05);
    return;
  }

  childthread func_79E2(param_00);
}

func_79E7(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = maps\mp\gametypes\_gameobjects::func_2837("neutral", param_00, [], param_05, !param_04, 1);
  var_06 maps\mp\gametypes\_gameobjects::func_C30("any");
  var_06 maps\mp\gametypes\_gameobjects::func_8A57(param_02);
  var_06 maps\mp\gametypes\_gameobjects::func_8A5A(param_01);
  var_06.var_6BBF = ::func_79E5;
  var_06.var_6ABC = ::func_79E3;
  var_06.var_6AFA = ::func_79E4;
  var_06.var_A23E = param_03;
  var_06.var_113F = 0;
  param_00.var_A240 = var_06;
}

func_79E2(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 waittill("trigger", var_01);
    get_geyser(param_00, var_01);
  }
}

func_79E5(param_00) {
  get_geyser(self.var_9D65, param_00);
}

get_geyser(param_00, param_01) {
  param_00 notify("used", param_01);
}

func_79E3(param_00) {
  param_00 method_812A(0);
  self.var_9D65 notify("beginUse", param_00);
}

func_79E4(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_01 method_812A(1);
  }

  self.var_9D65 notify("endUse", param_01, param_02);
}

func_8AD7(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(param_00.var_6607)) {
    param_00.var_6607 = [];
  }

  if(!isDefined(param_00.var_6607[param_01])) {
    param_00.var_6607[param_01] = -1;
  }

  if(param_00.var_6607[param_01] > 0) {
    if(isDefined(param_05)) {
      param_00.var_6607[param_01] = param_00.var_6607[param_01] + param_05 * 1000;
    }

    return;
  }

  param_00.var_6607[param_01] = gettime() + param_02 * 1000;
  if(isDefined(param_06)) {
    var_07 = gettime() + param_06;
  } else {
    var_07 = param_01.var_6607[param_02];
  }

  var_08 = gettime();
  while(var_08 < param_00.var_6607[param_01] && var_08 < var_07) {
    common_scripts\utility::func_A74B("death", 0.5);
    if(!maps\mp\_utility::func_57A0(param_00)) {
      param_00.var_6607[param_01] = -1;
    }
  }

  param_00.var_6607[param_01] = -1;
  if(isDefined(param_03)) {
    param_00 notify(param_03);
  }

  if(isDefined(param_04)) {
    param_00[[param_04]]();
  }
}

func_2D53(param_00, param_01, param_02) {
  var_03 = param_02 * param_02;
  var_04 = getEntArray(param_00, "targetname");
  var_05 = param_00 == "care_package";
  foreach(var_07 in var_04) {
    var_08 = distancesquared(param_01, var_07.var_116);
    if(var_08 < var_03) {
      if(var_05 && isDefined(var_07.var_1A7)) {
        if(var_07.var_1A7 == game["attackers"]) {
          thread lib_0506::func_A618("attacker_cpkg_destroyed");
        } else {
          thread lib_0506::func_A618("defender_cpkg_destroyed");
        }
      }

      if(isDefined(var_07.var_65E1)) {
        var_07[[var_07.var_65E1]]();
        continue;
      }

      var_07 delete();
    }
  }
}

func_9541(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = [];
  }

  foreach(var_03 in level.var_61ED) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(param_00 method_858B(var_03.var_116 + (0, 0, 60))) {
      var_04 = 1;
      if(param_01.size > 0) {
        var_04 = common_scripts\utility::func_F79(param_01, var_03.var_A9E0);
      }

      if(var_04) {
        var_03 maps\mp\gametypes\_weapons::func_61E4(undefined, 0.1, 0.3);
      }
    }
  }

  level.var_61ED = common_scripts\utility::func_FA0(level.var_61ED);
}

func_9540(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = [];
  }

  var_03 = param_01 * param_01;
  foreach(var_05 in level.var_61ED) {
    if(!isDefined(var_05)) {
      continue;
    }

    var_06 = 1;
    if(param_02.size > 0) {
      var_06 = common_scripts\utility::func_F79(param_02, var_05.var_A9E0);
    }

    if(var_06 == 0) {
      continue;
    }

    var_07 = distancesquared(param_00, var_05.var_116);
    if(var_07 < var_03) {
      var_05 maps\mp\gametypes\_weapons::func_61E4(undefined, 0.1, 0.3);
    }
  }

  level.var_61ED = common_scripts\utility::func_FA0(level.var_61ED);
}

func_573E(param_00, param_01) {
  if(!isDefined(param_01.var_12C["killstreaks"][param_00]) || !isDefined(param_01.var_12C["killstreaks"][param_00].var_13AF)) {
    return 1;
  }

  if(param_01.var_12C["killstreaks"][param_00].var_13AF == 0) {
    return 1;
  }

  return 0;
}

func_21AC(param_00, param_01) {
  if(!isDefined(param_00.var_5C06)) {
    param_00.var_5C06 = "";
  }

  if(param_00.var_5C06 != param_01.var_1A7 || param_00.var_66BB <= gettime()) {
    param_00.var_5C06 = param_01.var_1A7;
    param_00.var_66BB = gettime() + 30000;
    return 1;
  }

  return 0;
}

func_4627(param_00, param_01) {
  return animscripts\notetracks_common::func_4627(param_00, param_01);
}

isshotgun(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = function_01AA(param_00);
  if(isDefined(var_01) && var_01 == "spread") {
    return 1;
  }

  return 0;
}

func_9861(param_00, param_01, param_02) {
  param_00 endon("death");
  level endon("game_ended");
  for(;;) {
    var_03 = [];
    if(!isDefined(param_01)) {
      var_03 = level.var_744A;
    } else {
      foreach(var_05 in level.var_744A) {
        if(var_05.var_1A7 == param_01) {
          var_03[var_03.size] = var_05;
        }
      }
    }

    if(var_03.size > 0) {
      param_00 hudoutlineenableforclients(var_03, param_02, 1);
    }

    level waittill("joined_team");
  }
}

func_9862(param_00, param_01, param_02) {
  param_00 endon("death");
  level endon("game_ended");
  param_00 notify("enable_Outline");
  param_00 endon("enable_Outline");
  for(;;) {
    var_03 = [];
    var_04 = [];
    if(!isDefined(param_01)) {
      var_03 = level.var_744A;
    } else {
      foreach(var_06 in level.var_744A) {
        if(var_06.var_1A7 == param_01) {
          var_03[var_03.size] = var_06;
          continue;
        }

        var_04[var_04.size] = var_06;
      }
    }

    if(var_03.size > 0) {
      param_00 hudoutlineenableforclients(var_03, param_02, 1);
    }

    if(var_04.size > 0) {
      param_00 hudoutlinedisableforclients(var_04);
    }

    level waittill("joined_team");
  }
}

func_985E(param_00, param_01) {
  param_00 notify("enable_Outline");
  var_02 = [];
  if(!isDefined(param_01)) {
    var_02 = level.var_744A;
  } else {
    foreach(var_04 in level.var_744A) {
      if(!isDefined(param_01) || var_04.var_1A7 == param_01) {
        var_02[var_02.size] = var_04;
      }
    }
  }

  if(var_02.size > 0) {
    param_00 hudoutlinedisableforclients(var_02);
  }
}

func_985F(param_00, param_01) {
  param_00 endon("death");
  level endon("game_ended");
  param_00 notify("disable_outline");
  param_00 endon("disable_outline");
  for(;;) {
    var_02 = [];
    if(!isDefined(param_01)) {
      var_02 = level.var_744A;
    } else {
      foreach(var_04 in level.var_744A) {
        if(!isDefined(param_01) || var_04.var_1A7 == param_01) {
          var_02[var_02.size] = var_04;
        }
      }
    }

    if(var_02.size > 0) {
      param_00 hudoutlinedisableforclients(var_02);
    }

    level waittill("joined_team");
  }
}

func_9860(param_00, param_01, param_02, param_03) {
  var_04 = [];
  foreach(var_06 in level.var_744A) {
    if(var_06.var_1A7 != param_00.var_1A7) {
      var_04[var_04.size] = var_06;
    }
  }

  if(var_04.size > 0) {
    param_00 hudoutlineenableforclients(var_04, param_01, param_03);
    param_00 thread func_985D(param_00, param_02);
  }
}

func_985D(param_00, param_01) {
  self notify("outlined_again");
  self endon("outlined_again");
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::func_A74B("death", param_01);
  param_00 hudoutlinedisableforclients(level.var_744A);
}

func_697B() {
  if(isDefined(level.var_79C2.var_693B)) {
    return;
  }

  level.var_79C2.var_693B = [];
  level.var_79C2.var_6953 = undefined;
  level.var_79C2.var_694C = undefined;
}

func_697C(param_00, param_01) {
  if(!isDefined(level.var_79C2.var_693B)) {
    func_697B();
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(isDefined(level.var_79C2.var_693B[param_00])) {
    level.var_79C2.var_693B[param_00].var_9309 = func_7978();
    level.var_79C2.var_693B[param_00].var_60A3 = level.var_79C2.var_693B[param_00].var_9309 + max(param_01, 1);
    return;
  }

  var_02 = spawnStruct();
  var_02.var_9309 = func_7978();
  var_02.var_60A3 = var_02.var_9309 + max(param_01, 1);
  var_02.var_256B = -1;
  var_02.var_6F4B = 0;
  var_02.var_2566 = 0;
  var_02.var_B7F = [];
  var_02.var_6984 = undefined;
  level.var_79C2.var_693B[param_00] = var_02;
}

func_697F(param_00, param_01) {
  if(!isDefined(level.var_79C2.var_693B[param_00])) {
    func_697C(param_00);
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  level.var_79C2.var_693B[param_00].var_9309 = func_7978();
  level.var_79C2.var_693B[param_00].var_60A3 = level.var_79C2.var_693B[param_00].var_9309 + max(param_01, 1);
  level.var_79C2.var_6953 = param_00;
  func_8628(param_00);
}

func_697D(param_00, param_01) {
  if(!isDefined(level.var_79C2.var_693B[param_00])) {
    return;
  }

  level.var_79C2.var_693B[param_00].var_B7F[level.var_79C2.var_693B[param_00].var_B7F.size] = param_01;
}

func_697E(param_00, param_01) {
  if(!isDefined(level.var_79C2.var_693B[param_00])) {
    return;
  }

  level.var_79C2.var_693B[param_00].var_6984 = param_01;
}

func_6979(param_00) {
  if(!isDefined(level.var_79C2.var_693B[param_00])) {
    return undefined;
  }

  return level.var_79C2.var_693B[param_00];
}

func_697A(param_00) {
  if(!isDefined(level.var_79C2.var_693B[param_00])) {
    return;
  }

  if(level.var_79C2.var_693B[param_00].var_2566 == 1) {
    return;
  }

  level notify("objTrackingObjCompleted");
  var_01 = func_7978();
  var_02 = level.var_79C2.var_693B[param_00];
  var_02.var_256B = var_01;
  var_02.var_6F4B = var_01 / var_02.var_60A3;
  var_02.var_2566 = 1;
  level.var_79C2.var_693B[param_00] = var_02;
  level.var_79C2.var_694C = param_00;
}

func_6978() {
  if(!isDefined(level.var_79C2.var_6953)) {
    return "no objective defined";
  }

  return level.var_79C2.var_6953;
}

func_6977() {
  if(!isDefined(level.var_79C2.var_694C)) {
    return "no objective defined";
  }

  return level.var_79C2.var_694C;
}

func_79C9(param_00) {
  self.var_8CA9 = param_00;
  if(!self.var_8CA9) {
    self notify("stop_being_slow");
  }
}

func_79CA(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(self.var_8CA9)) {
    self.var_8CA9 = 1;
  }

  for(;;) {
    self waittill("trigger", var_04);
    if(!common_scripts\utility::func_562E(self.var_8CA9)) {
      continue;
    }

    if(!common_scripts\utility::func_562E(var_04.var_53C5)) {
      var_04 thread func_7408(self, param_00, param_01, param_02, param_03);
    }
  }
}

func_7408(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  self.var_53C5 = 1;
  maps\mp\gametypes\_weapons::func_A13B();
  if(!param_03) {
    self method_8113(0);
  }

  if(!param_02) {
    self method_8114(0);
  }

  self method_8308(0);
  if(param_01) {
    self allowjump(0);
  }

  if(param_04) {
    self method_8322();
  }

  param_00 notify("player_in_slowtrigger", self);
  func_7409(param_00, param_01);
  self.var_53C5 = 0;
  maps\mp\gametypes\_weapons::func_A13B();
  self method_8113(1);
  self method_8114(1);
  self method_8308(1);
  if(param_01) {
    self allowjump(1);
    self allowmovement(1);
  }

  if(param_04) {
    self method_8323();
  }

  param_00 notify("player_out_of_slowtrigger", self);
}

func_7409(param_00, param_01) {
  param_00 endon("stop_being_slow");
  self endon("death");
  var_02 = 1;
  while(self istouching(param_00)) {
    if(param_01) {
      if(!self isonground() && var_02) {
        self allowmovement(0);
        var_03 = self getvelocity();
        self setvelocity((0, 0, 0));
      }

      if(self.var_A9F6 == "war_dynamite_mp") {
        self allowmovement(0);
      } else {
        self allowmovement(1);
      }
    }

    var_02 = 0;
    wait 0.05;
  }
}

func_79EC(param_00) {
  if(common_scripts\utility::func_562E(param_00.var_681A)) {
    return;
  }

  self setclientomnvar("ui_use_bar_text", param_00.var_A23E);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_01 = -1;
  while(maps\mp\_utility::func_57A0(self) && isDefined(param_00) && maps\mp\gametypes\_gameobjects::func_A224(param_00) && !level.var_3F9D && isDefined(self)) {
    var_02 = maps\mp\gametypes\_gameobjects::func_45D4(param_00);
    if(var_01 != var_02) {
      if(param_00.var_28D5 > param_00.var_A23F) {
        param_00.var_28D5 = param_00.var_A23F;
      }

      if(var_02 > 0) {
        var_03 = gettime();
        var_04 = param_00.var_28D5 / param_00.var_A23F;
        var_05 = var_03 + 1 - var_04 * param_00.var_A23F / var_02;
        var_06 = var_05 - param_00.var_A23F / var_02;
        self setclientomnvar("ui_use_bar_start_time", int(var_06));
        self setclientomnvar("ui_use_bar_end_time", int(var_05));
      }

      var_01 = var_02;
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_use_bar_end_time", 0);
  }
}

func_79EB(param_00, param_01) {
  var_02 = self.var_12C["team"];
  if(param_01 || !param_00 maps\mp\gametypes\_gameobjects::func_1F53(var_02) || var_02 != param_00.var_230F || param_00.var_681A || param_00.var_5107 && !isDefined(param_00.var_230E) || param_00.var_230E != self) {
    if(isDefined(self.var_79BC) && !isDefined(self.var_79BC.var_9DBD) || self.var_79BC.var_9DBD == param_00.var_9D65) {
      self setclientomnvar("ui_use_bar_end_time", 0);
      self.var_79BC.var_5C0C = undefined;
      self.var_79BC.var_5BAA = 0;
      self.var_79BC.var_9DBD = undefined;
    }

    return;
  }

  if(!isDefined(self.var_79BC)) {
    self.var_79BC = spawnStruct();
    self.var_79BC.var_5C0C = undefined;
    self.var_79BC.var_5BAA = 0;
  }

  self setclientomnvar("ui_use_bar_text", param_00.var_A23E);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  if(!isDefined(self.var_79BC.var_5C0C) || self.var_79BC.var_5C0C != param_00.var_A22B || self.var_79BC.var_5BAA != isDefined(level.var_4E09)) {
    if(param_00.var_28D5 > param_00.var_A23F) {
      param_00.var_28D5 = param_00.var_A23F;
    }

    var_03 = gettime();
    var_04 = param_00.var_28D5 / param_00.var_A23F;
    var_05 = param_00.var_A22B;
    if(isDefined(level.var_4E09)) {
      var_05 = 0;
    }

    if(param_00.var_59DD && !var_04 && var_05 < 0) {
      var_05 = 0;
    }

    if(var_05 > 0) {
      var_06 = var_03 + 1 - var_04 * param_00.var_A23F / var_05;
      self setclientomnvar("ui_use_bar_start_time", int(var_06 - param_00.var_A23F));
      self setclientomnvar("ui_use_bar_end_time", int(var_06));
    } else {
      self setclientomnvar("ui_use_bar_end_time", 0);
    }

    self.var_79BC.var_9DBD = param_00.var_9D65;
    self.var_79BC.var_5C0C = param_00.var_A22B;
    self.var_79BC.var_5BAA = isDefined(level.var_4E09);
  }
}

func_793D(param_00) {
  func_797B(param_00);
  func_797C(param_00);
}

func_797B(param_00) {
  var_01 = self getlinkedchildren();
  foreach(var_03 in var_01) {
    var_03 thread func_791D(param_00);
  }
}

func_797C(param_00) {
  if(isDefined(level.var_61ED)) {
    foreach(var_02 in level.var_61ED) {
      if(isDefined(var_02) && self istouching(var_02)) {
        var_02 thread func_791D(param_00);
      }
    }
  }
}

func_791D(param_00) {
  if(isDefined(self.var_3A) && self.var_3A == "grenade") {
    if(maps\mp\gametypes\_weapons::func_57C3(self)) {
      waittillframeend;
      self unlink();
      self method_81D6();
      return;
    }

    if(isDefined(self.var_A9E0) && self.var_A9E0 == "bouncingbetty_mp") {
      if(isDefined(param_00) && param_00 == "drop") {
        self unlink();
        return;
      }

      self delete();
      return;
    }

    if(isDefined(self.var_A9E0) && self.var_A9E0 == "c4_mp") {
      if(isDefined(self.var_9D65)) {
        self.var_9D65 delete();
      }

      self delete();
      return;
    }

    return;
  }

  if(function_0388(self)) {
    self unlink();
  }
}

func_2FC4() {
  self endon("death");
  level endon("game_ended");
  self endon("stopDisconnectingPaths");
  var_00 = (0, 0, -20000);
  var_01 = 0;
  var_02 = 0;
  var_03 = 0.05;
  var_04 = 60;
  var_05 = (0, 0, -20000);
  var_06 = 0;
  var_07 = gettime() + randomintrange(5000, 10000);
  for(;;) {
    var_08 = distancesquared(var_05, self.var_116);
    var_09 = angleclamp360(var_06) - angleclamp360(self.var_1D[1]);
    if(gettime() > var_07 && var_08 > 0.01 || abs(var_09) > 0.01) {
      var_00 = self.var_116;
      var_05 = self.var_116;
      var_01 = self.var_1D[1];
      var_06 = self.var_1D[1];
      var_02 = 0;
      if(common_scripts\utility::func_64F3()) {
        self method_805F(1);
      }

      var_07 = gettime() + randomintrange(5000, 10000);
    }

    var_0A = distancesquared(var_00, self.var_116);
    var_0B = angleclamp360(var_01) - angleclamp360(self.var_1D[1]);
    if(var_0A > var_04 * var_04 || (var_0A > 0.01 || abs(var_0B) > 0.01) && var_02 >= 2) {
      var_00 = self.var_116;
      var_01 = self.var_1D[1];
      var_02 = 0;
      if(common_scripts\utility::func_64F3()) {
        self method_805F(0);
      }
    }

    wait(var_03);
    var_02 = var_02 + var_03;
  }
}

func_93FE() {
  self notify("stopDisconnectingPaths");
  if(common_scripts\utility::func_64F3()) {
    self method_8060(0);
  }
}

func_2FC2() {
  self endon("death");
  level endon("game_ended");
  var_00 = (0, 0, -20000);
  var_01 = 0;
  var_02 = 0;
  var_03 = 0.05;
  for(;;) {
    var_04 = distancesquared(var_00, self.var_116);
    var_05 = angleclamp360(var_01) - angleclamp360(self.var_1D[1]);
    if((var_04 > 0.01 || abs(var_05) > 0.01) && var_02 >= 2) {
      var_00 = self.var_116;
      var_01 = self.var_1D[1];
      var_02 = 0;
      if(common_scripts\utility::func_64F3()) {
        self method_805F(0);
      }
    }

    wait(var_03);
    var_02 = var_02 + var_03;
    if(var_02 >= 10) {
      return;
    }
  }
}

func_4713(param_00) {
  var_01 = function_01DD();
  return common_scripts\utility::func_F7E(var_01, param_00);
}

func_4518(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  switch (param_00) {
    case "grab_defend":
      if(param_01 == 1) {
        return 25;
      }

      if(param_01 == 2) {
        return 30;
      } else {
        return 112;
      }

      break;

    case "escort_kill":
      if(param_01 == 1) {
        return 26;
      }

      if(param_01 == 2) {
        return 31;
      } else {
        return 113;
      }

      break;

    case "grab_return":
      if(param_01 == 1) {
        return 27;
      }

      if(param_01 == 2) {
        return 32;
      } else {
        return 114;
      }

      break;

    case "taking_defend":
      if(param_01 == 1) {
        return 45;
      }

      if(param_01 == 2) {
        return 46;
      } else {
        return 115;
      }

      break;

    case "grab_taking":
      if(param_01 == 1) {
        return 47;
      }

      if(param_01 == 2) {
        return 48;
      } else {
        return 116;
      }

      break;

    case "taking_return":
      if(param_01 == 1) {
        return 49;
      }

      if(param_01 == 2) {
        return 50;
      } else {
        return 117;
      }

      break;

    case "escort_halt":
      if(param_01 == 1) {
        return 33;
      } else if(param_01 == 2) {
        return 37;
      } else if(param_01 == 3) {
        return 41;
      } else {
        return 5;
      }

      break;

    case "escorting_halt":
      if(param_01 == 1) {
        return 34;
      } else if(param_01 == 2) {
        return 38;
      } else if(param_01 == 3) {
        return 42;
      } else {
        return 13;
      }

      break;

    case "contested_contested":
      if(param_01 == 1) {
        return 35;
      } else if(param_01 == 2) {
        return 39;
      } else if(param_01 == 3) {
        return 43;
      } else {
        return 14;
      }

      break;

    case "escort_defenders_touch":
      if(param_01 == 1) {
        return 36;
      } else if(param_01 == 2) {
        return 40;
      } else if(param_01 == 3) {
        return 44;
      } else {
        return 17;
      }

      break;

    case "escort_blocked":
      if(param_01 == 1) {
        return 51;
      } else if(param_01 == 2) {
        return 52;
      } else if(param_01 == 3) {
        return 53;
      } else {
        return 54;
      }

      break;

    case "capture_defend":
      if(param_01 == 1) {
        return 55;
      } else if(param_01 == 2) {
        return 56;
      } else {
        return 1;
      }

      break;

    case "taking_losing":
      if(param_01 == 1) {
        return 57;
      } else if(param_01 == 2) {
        return 58;
      } else {
        return 2;
      }

      break;

    case "contested_contested_hp":
      if(param_01 == 1) {
        return 59;
      } else if(param_01 == 2) {
        return 60;
      } else {
        return 3;
      }

      break;

    case "capture_defend_enemy":
      if(param_01 == 1) {
        return 61;
      } else if(param_01 == 2) {
        return 62;
      } else {
        return 29;
      }

      break;

    case "target_defend":
      if(param_01 == 1) {
        return 63;
      } else if(param_01 == 2) {
        return 64;
      } else if(param_01 == 3) {
        return 126;
      } else if(param_01 == 4) {
        return 130;
      } else {
        return 8;
      }

      break;

    case "defend_defuse":
      if(param_01 == 1) {
        return 65;
      } else if(param_01 == 2) {
        return 66;
      } else if(param_01 == 3) {
        return 127;
      } else if(param_01 == 4) {
        return 131;
      } else {
        return 9;
      }

      break;

    case "planting_defend":
      if(param_01 == 1) {
        return 67;
      } else if(param_01 == 2) {
        return 68;
      } else if(param_01 == 3) {
        return 128;
      } else if(param_01 == 4) {
        return 132;
      } else {
        return 15;
      }

      break;

    case "defend_defusing":
      if(param_01 == 1) {
        return 69;
      } else if(param_01 == 2) {
        return 70;
      } else if(param_01 == 3) {
        return 129;
      } else if(param_01 == 4) {
        return 133;
      } else {
        return 16;
      }

      break;

    case "destroy_objects":
      if(param_01 == 1) {
        return 111;
      } else {
        return 110;
      }

      break;

    case "rescue_hostage":
      if(param_01 == 1) {
        return 71;
      } else {
        return 72;
      }

      break;

    case "rescue_contest":
      if(param_01 == 1) {
        return 73;
      } else {
        return 74;
      }

      break;

    case "rescuing_contest":
      if(param_01 == 1) {
        return 75;
      } else {
        return 76;
      }

      break;

    case "deathmatch":
      if(param_01 == 1) {
        return 124;
      } else {
        return 125;
      }

      break;

    case "search_defend":
      if(param_01 == 1) {
        return 137;
      } else {
        return 138;
      }

      break;

    default:
      break;
  }
}

func_09FF(param_00, param_01) {
  if(func_57F9(param_00) || func_56E8(param_00)) {
    if(!isDefined(level.var_97C5)) {
      level.var_97C5 = [];
    }

    level.var_97C5[level.var_97C5.size] = param_00;
    if(func_57F9(param_00)) {
      param_00 thread func_A3EC();
    }

    param_00.var_7451 = [];
    foreach(var_03 in level.var_744A) {
      if(!isDefined(param_01) || var_03.var_1A7 == param_01) {
        var_03 func_7468(param_00);
      }
    }

    if(isDefined(param_01)) {
      param_00.var_9402 = maps\mp\_utility::func_45DE(param_01);
    }
  }
}

func_7D03(param_00, param_01, param_02) {
  if(func_57F9(param_00) || func_56E8(param_00)) {
    var_03 = 0;
    for(var_04 = 0; var_04 < level.var_97C5.size; var_04++) {
      if(param_00 == level.var_97C5[var_04]) {
        level.var_97C5[var_04] = level.var_97C5[level.var_97C5.size - 1];
        level.var_97C5[level.var_97C5.size - 1] = undefined;
        var_03 = 1;
        break;
      }
    }

    if(var_03) {
      foreach(var_06 in level.var_744A) {
        if(!isDefined(param_00.var_9402) || var_06.var_1A7 != param_00.var_9402) {
          var_06 func_7469(param_00, param_01);
        }
      }

      param_00.var_7451 = undefined;
      if(func_57F9(param_00) && !common_scripts\utility::func_562E(param_02)) {
        param_00 thread func_A3F9();
        return;
      }
    }
  }
}

func_5845(param_00) {
  return isDefined(param_00.var_1C8);
}

func_57F9(param_00) {
  return func_5845(param_00) && param_00 method_8564() == "tank";
}

func_56E8(param_00) {
  return isDefined(param_00.var_56E8);
}

func_8C22(param_00) {
  if(func_57F9(self) || func_56E8(self)) {
    func_986B(maps\mp\_utility::func_45DE(param_00), self);
  }
}

func_8C1F() {
  if(func_57F9(self) || func_56E8(self)) {
    func_986A(self);
  }
}

func_986B(param_00, param_01) {
  if(!isDefined(param_01.var_9402)) {
    param_01.var_9402 = param_00;
    foreach(var_03 in level.var_744A) {
      if(var_03.var_1A7 == param_00) {
        var_03 func_7469(param_01);
      }
    }
  }
}

func_986A(param_00) {
  var_01 = param_00.var_9402;
  param_00.var_9402 = undefined;
  foreach(var_03 in level.var_744A) {
    if(var_03.var_1A7 == var_01) {
      var_03 func_7468(param_00);
    }
  }
}

func_7416() {
  if(isDefined(level.var_97C5)) {
    foreach(var_01 in level.var_97C5) {
      if(isDefined(var_01.var_9402) && self.var_1A7 == var_01.var_9402) {
        func_7469(var_01);
        continue;
      }

      if(!isDefined(var_01.var_9402) || self.var_1A7 != var_01.var_9402) {
        func_7468(var_01);
      }
    }
  }
}

func_7468(param_00) {
  if(isDefined(param_00)) {
    if(isDefined(param_00.var_9402) && self.var_1A7 == param_00.var_9402) {
      return;
    }

    if(isDefined(common_scripts\utility::func_F7E(param_00.var_7451, self))) {
      return;
    }

    lib_04F3::func_79F6(param_00);
    param_00.var_7451[param_00.var_7451.size] = self;
    return;
  }

  if(isDefined(level.var_97C5)) {
    foreach(param_00 in level.var_97C5) {
      if(isDefined(param_00.var_9402) && self.var_1A7 == param_00.var_9402) {
        continue;
      }

      if(isDefined(common_scripts\utility::func_F7E(param_00.var_7451, self))) {
        continue;
      }

      lib_04F3::func_79F6(param_00);
      param_00.var_7451[param_00.var_7451.size] = self;
    }
  }
}

func_7469(param_00, param_01) {
  lib_04F3::func_79F7(param_00, param_01);
  var_02 = common_scripts\utility::func_F7E(param_00.var_7451, self);
  if(isDefined(var_02)) {
    param_00.var_7451[var_02] = undefined;
  }
}

func_A3EC() {
  self endon("death");
  while(!isDefined(level.var_19E8)) {
    wait 0.05;
  }

  self.var_1B49 = [];
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = 0;
  var_0E = 0;
  if(self.var_106 == "vehicle_usa_tank_sherman_75mm_no_turret") {
    var_00 = 140;
    var_01 = -130;
    var_02 = 34;
    var_03 = 0;
    var_04 = -34;
    var_05 = 65;
    var_06 = 0;
    var_07 = -65;
    var_08 = 70;
    var_09 = 70;
    var_0A = 70;
    var_0B = -70;
    var_0C = -70;
    var_0D = -70;
    var_0E = 15;
  } else if(self.var_106 == "vehicle_usa_tank_sherman_75mm_no_turret_dozer") {
    var_00 = 158;
    var_01 = -135;
    var_02 = 34;
    var_03 = 0;
    var_04 = -34;
    var_05 = 65;
    var_06 = 0;
    var_07 = -65;
    var_08 = 77;
    var_09 = 73;
    var_0A = 70;
    var_0B = -77;
    var_0C = -73;
    var_0D = -70;
    var_0E = 25;
  } else if(common_scripts\utility::func_9467(self.var_106, "vehicle_ger_tank_king_tiger_mp")) {
    var_00 = 160;
    var_01 = -165;
    var_02 = 34;
    var_03 = 0;
    var_04 = -34;
    var_05 = 65;
    var_06 = 0;
    var_07 = -65;
    var_08 = 90;
    var_09 = 90;
    var_0A = 90;
    var_0B = -90;
    var_0C = -90;
    var_0D = -90;
    var_0E = 15;
  } else {}

  var_0F = [];
  var_0F[var_0F.size] = [var_00, var_02, "front"];
  var_0F[var_0F.size] = [var_00, var_03, "front"];
  var_0F[var_0F.size] = [var_00, var_04, "front"];
  var_0F[var_0F.size] = [var_01, var_02, "back"];
  var_0F[var_0F.size] = [var_01, var_03, "back"];
  var_0F[var_0F.size] = [var_01, var_04, "back"];
  var_0F[var_0F.size] = [var_05, var_08, "right"];
  var_0F[var_0F.size] = [var_06, var_09, "right"];
  var_0F[var_0F.size] = [var_07, var_0A, "right"];
  var_0F[var_0F.size] = [var_05, var_0B, "left"];
  var_0F[var_0F.size] = [var_06, var_0C, "left"];
  var_0F[var_0F.size] = [var_07, var_0D, "left"];
  var_10 = anglesToForward(self.var_1D);
  var_11 = anglestoright(self.var_1D);
  var_12 = anglestoup(self.var_1D);
  foreach(var_14 in var_0F) {
    var_15 = var_14[0];
    var_16 = var_14[1];
    var_17 = self.var_116 + var_10 * var_15 + var_11 * var_16 + var_12 * var_0E;
    var_18 = spawn("script_origin", var_17);
    var_18.var_1D = self.var_1D;
    var_18 method_805C();
    var_18 linkto(self);
    var_18 thread func_2D1D();
    thread common_scripts\utility::func_2D18(var_18);
    var_18.var_8C3A = var_14[2];
    self.var_1B49[self.var_1B49.size] = var_18;
  }
}

func_A3F9() {
  if(isDefined(self.var_1B49)) {
    foreach(var_01 in self.var_1B49) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }

    self.var_1B49 = undefined;
  }
}

func_3B80(param_00) {
  var_01 = (0, 0, 0);
  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03.var_116;
  }

  var_01 = var_01 / param_00.size;
  var_05 = common_scripts\utility::func_40B0(var_01, param_00);
  return var_05[0];
}

func_0F52(param_00, param_01, param_02) {
  return param_00[0] * param_01[1] - param_00[1] * param_01[0] + param_01[0] * param_02[1] - param_02[0] * param_01[1] + param_02[0] * param_00[1] - param_00[0] * param_02[1];
}

func_0F53(param_00, param_01, param_02) {
  return func_0F52(param_00, param_01, param_02) * 0.5;
}

func_5F36(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = func_0F52(param_01, param_02, param_00);
  if(var_04 > param_03) {
    return 1;
  }

  if(var_04 < param_03 * -1) {
    return 2;
  }

  return 3;
}

func_776A(param_00, param_01) {
  var_02 = vectordot(param_00, param_01) / lengthsquared(param_01);
  return [param_01 * var_02, var_02];
}

func_7770(param_00, param_01, param_02) {
  param_00 = param_00 - param_01;
  var_03 = func_776A(param_00, param_02 - param_01);
  param_00 = var_03[0];
  var_04 = var_03[1];
  param_00 = param_00 + param_01;
  return [param_00, var_04];
}

func_7771(param_00, param_01, param_02) {
  var_03 = func_7770(param_00, param_01, param_02);
  param_00 = var_03[0];
  var_04 = var_03[1];
  if(var_04 < 0) {
    param_00 = param_01;
  } else if(var_04 > 1) {
    param_00 = param_02;
  }

  return [param_00, var_04];
}

func_3048(param_00, param_01, param_02) {
  var_03 = func_7770(param_00, param_01, param_02);
  var_04 = var_03[0];
  var_05 = var_03[1];
  return distance(var_04, param_00);
}

func_791A(param_00) {
  if(!common_scripts\utility::func_F79(level.var_79E9, param_00)) {
    level.var_79E9[level.var_79E9.size] = param_00;
  }
}

func_79BD(param_00) {
  level.var_79E9 = common_scripts\utility::func_F93(level.var_79E9, param_00);
}

func_799F() {
  switch (maps\mp\_utility::func_4571()) {
    case "mp_raid_d_day":
    case "mp_raid_dlc4":
    case "mp_raid_dlc3":
    case "mp_raid_dlc2":
    case "mp_raid_aachen":
    case "mp_raid_cobra":
    case "mp_raid_bulge":
      return 0;

    default:
      return 1;
  }
}

func_8A18(param_00) {
  var_01 = param_00.var_116 + (0, 0, 5);
  var_02 = param_00.var_116 + anglestoright(param_00.var_1D) * 100 + (0, 0, 96);
  var_03 = bulletTrace(var_01, var_02, 0, param_00);
  var_04 = spawn("script_model", var_03["position"]);
  var_04 setModel("tag_origin");
  var_05 = param_00.var_116 - var_03["position"];
  var_04.var_1D = vectortoangles(var_05);
  var_04 setscriptmoverkillcam("script_entity");
  self.var_5A2C = var_04;
}

isteleportenabled(param_00, param_01, param_02) {
  param_00 endon("death");
  param_02 makeunusable();
  param_00 makeunusable();
  if(isDefined(param_02.var_A2C8) && common_scripts\utility::func_562E(param_02.var_A2C8.isdrivable)) {
    param_00 sethintstring(&"RAIDS_USE_TANK_MG_FROM_GROUND");
  } else {
    param_00 sethintstring(&"RAIDS_USE_TANK_TURRET");
  }

  param_00 setcursorhint("HINT_NOICON");
  param_02.var_4B70 = 1;
  param_00.var_6DB2 = param_01;
  param_00.var_9EDD = param_02;
  param_00 thread lib_0504::func_9F9B(param_01);
  if(!isDefined(level.var_79C2.var_9F96)) {
    level.var_79C2.var_9F96 = [];
  }

  level.var_79C2.var_9F96[level.var_79C2.var_9F96.size] = param_00;
  for(;;) {
    param_00 makeusable();
    var_03 = common_scripts\utility::func_A70F(-1, param_00, "trigger", param_00.var_9EDD, "turret_mount_from_driver", param_00.var_9EDD, "death");
    var_04 = var_03[0];
    var_05 = var_03[1];
    var_06 = var_03[2];
    var_06 thread maps\mp\_audio_submixes::func_8A9D("mp_war_vehicle_turret", 0.1);
    waittillframeend;
    if(!isDefined(var_06)) {
      continue;
    }

    if(!isDefined(param_02)) {
      return;
    }

    if(var_06 common_scripts\_plant_weapon::func_5855()) {
      continue;
    }

    if(var_05 == "trigger") {
      param_02 useby(var_06);
      if(isDefined(param_02.mountcallback)) {
        param_02[[param_02.mountcallback]](var_06);
      }

      if(isDefined(param_02.var_A2C8)) {
        param_02.var_A2C8 notify("turret_mount_from_ground", var_06);
      }
    }

    var_06 method_86AA(1);
    param_00 makeunusable();
    var_03 = param_02 common_scripts\utility::func_A717("turretownerchange", "death");
    if(isDefined(var_06)) {
      var_06 thread maps\mp\_audio_submixes::func_8A9F("mp_war_vehicle_turret", 0.1);
      var_06 method_86AA(0);
      if(isDefined(param_02) && isDefined(param_02.dismountcallback)) {
        param_02[[param_02.dismountcallback]](var_06);
      }
    }

    if(!isDefined(param_02)) {
      return;
    }
  }
}

func_79D2() {
  foreach(var_01 in level.var_744A) {
    if(!isDefined(var_01) || !isDefined(var_01.var_178) || var_01.var_178 == "spectator") {
      continue;
    }

    var_01 thread maps\mp\gametypes\_gamelogic::func_9412();
  }
}

replacehintstringclient(param_00, param_01) {
  var_02 = self getclientomnvar("ui_hintstring_client_text_replacement");
  var_03 = 0;
  var_04 = get_all_override_table_rows_given_matching_original(param_00);
  foreach(var_06 in var_04) {
    var_03 = var_03 | 1 << var_06;
  }

  if(isDefined(param_01)) {
    var_08 = get_override_table_row_given_matching_original_and_override(param_00, param_01);
    var_09 = 1 << var_08;
    var_02 = var_02 &~var_03;
    var_02 = var_02 | var_09;
  } else {
    var_02 = var_02 &~var_03;
  }

  self setclientomnvar("ui_hintstring_client_text_replacement", var_02);
}

get_override_table_row_given_matching_original_and_override(param_00, param_01) {
  return get_override_table_matching_rows_internal(param_00, param_01);
}

get_all_override_table_rows_given_matching_original(param_00) {
  return get_override_table_matching_rows_internal(param_00, undefined);
}

get_override_table_matching_rows_internal(param_00, param_01) {
  var_02 = [];
  if(!isDefined(param_00)) {
    return [];
  }

  if(!isDefined(level.var_79C4)) {
    return [];
  }

  if(!isDefined(level.var_79C4.interact_client_text_overrides_table)) {
    var_03 = [];
    var_04 = function_027A("mp/raid_interact_client_text_overrides.csv");
    for(var_05 = 0; var_05 < var_04; var_05++) {
      var_03[var_05] = spawnStruct();
      var_03[var_05].original = function_01B0("mp/raid_interact_client_text_overrides.csv", var_05, 0);
      var_03[var_05].override = function_01B0("mp/raid_interact_client_text_overrides.csv", var_05, 1);
    }

    level.var_79C4.interact_client_text_overrides_table = var_03;
  }

  foreach(var_08, var_07 in level.var_79C4.interact_client_text_overrides_table) {
    if(var_07.original == param_00) {
      if(isDefined(param_01)) {
        if(var_07.override == param_01) {
          return var_08;
        }

        continue;
      }

      var_02[var_02.size] = var_08;
    }
  }

  if(var_02.size == 0) {
    var_09 = getlocalizedstringrefname(param_00);
    var_0A = "undefined";
    if(isDefined(param_01)) {
      var_0A = getlocalizedstringrefname(param_01);
    }
  }

  return var_02;
}

raid_spawn_tag_origin() {
  if(isDefined(level.var_5FEB)) {
    var_00 = spawn("script_model", level.var_5FEB);
  } else {
    var_00 = spawn("script_model", (0, 0, 0));
  }

  var_00 setModel("tag_origin");
  if(isDefined(self.var_116)) {
    var_00.var_116 = self.var_116;
  }

  if(isDefined(self.var_1D)) {
    var_00.var_1D = self.var_1D;
  }

  return var_00;
}