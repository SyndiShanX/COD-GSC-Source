/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1277.gsc
*********************************************/

flagsobjectiveinit(param_00) {
  var_01 = [0.1, 0.5, 1, 2, 3, 5, 7.5, 10, 12.5, 15];
  lib_04FF::func_6934(param_00);
  lib_04FF::func_6963("pauseDuringTransitionDelay", 0);
  lib_04FF::func_6963("pointTransitionDelay", 0, var_01);
  lib_04FF::func_6963("captureTime", 10, var_01);
  lib_04FF::func_6964("flagsCapFunc", undefined);
  func_1D4D();
  thread flagsobjectivethink();
  level.var_695E[level.var_695E.size] = ::flagobjectiveonplayerkilled;
}

flagobjectiveonplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  if(isDefined(var_0A.raisingflag) && var_0A.raisingflag) {
    lib_0502::raidawardflagraiserkillevent(param_01);
  }
}

flagsobjectivethink() {
  self endon("end_think");
  self.var_62C7 = self;
  lib_04FF::func_6983(self.var_695A);
  self.var_292D = 0;
  self.var_2929 = 0;
  self.var_21DC = [];
  setomnvar("ui_assault_objective_update", self.var_292D);
  setomnvar("ui_assault_objective_complete", 1);
  thread momentumwatchgameend();
  foreach(var_01 in self.var_62CF) {
    if(common_scripts\utility::func_562E(var_01.var_5758)) {
      self.var_21DC[self.var_21DC.size] = clamp(var_01.var_62C6 / self.var_62CF.size, 0, 1);
    }
  }

  wait(0.1);
  self.var_62CF[self.var_292D] thread func_08B1();
  for(;;) {
    self waittill("momentumCapture", var_03);
    if(var_03 == game["attackers"]) {
      level notify("momentum_point_" + self.var_292D + "_attackers");
      self.var_62CF[self.var_292D] thread func_2A78();
      self.var_292D++;
      if(self.var_292D >= self.var_62CF.size) {
        lib_04FF::func_6935(self.var_695A);
        wait(1);
        return;
      }

      if(self.var_62CF[self.var_292D].var_5758) {
        self.var_2929++;
      }

      self.var_62CF[self.var_292D] thread func_08B1();
    } else if(var_03 == game["defenders"]) {
      level notify("momentum_point_" + self.var_292D + "_defenders");
      if(self.var_292D <= 0) {}

      self.var_62CF[self.var_292D] thread func_2A78();
      self.var_292D--;
      self.var_62CF[self.var_292D] thread func_08B1();
    } else {}

    setomnvar("ui_assault_objective_update", self.var_292D);
  }
}

momentumwatchgameend() {
  level waittill("game_ended");
  setomnvar("ui_assault_objective_complete", 0);
}

func_86CE(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = 0;
  var_03 = 1;
  if(isDefined(self.var_62C7.var_21DC[self.var_62C7.var_2929])) {
    var_03 = self.var_62C7.var_21DC[self.var_62C7.var_2929];
  }

  if(self.var_62C7.var_2929 >= 1) {
    var_02 = self.var_62C7.var_21DC[self.var_62C7.var_2929 - 1];
  }

  var_04 = clamp(self.var_62C7.var_292D / self.var_62C7.var_62CF.size, 0, 1);
  var_05 = clamp(var_04 - var_02 / var_03 - var_02, 0, 1);
  var_06 = int(var_05 * 10000);
  self.var_62C7.var_62CF[self.var_62C7.var_292D].var_695D lib_04FF::func_860D(param_00);
  if(param_01) {
    self.var_62C7.var_62CF[self.var_62C7.var_292D].var_695D lib_04FF::func_8615(var_06, param_00, var_02, var_03);
    return;
  }

  self.var_62C7.var_62CF[self.var_62C7.var_292D].var_695D lib_04FF::func_8617("taking", param_00);
}

func_1D4D() {
  self.var_62CF = [];
  var_00 = undefined;
  for(var_00 = func_45A7(); isDefined(var_00); var_00 = var_00 func_45A7()) {
    var_00 thread func_62D0(self, self.var_62CF.size);
    self.var_62CF[self.var_62CF.size] = var_00;
  }

  if(self.var_62CF.size == 0) {}
}

func_45A7() {
  if(!isDefined(self.var_1A2)) {
    return undefined;
  }

  var_00 = [];
  var_01 = getEntArray(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_165)) {
      var_03.var_165 = "trigger";
    }

    if(var_03.var_165 == "trigger") {
      var_00[var_00.size] = var_03;
    }
  }

  if(var_00.size <= 0) {
    return undefined;
  }

  if(var_00.size != 1) {
    return undefined;
  }

  return var_00[0];
}

func_4592() {
  var_00 = [];
  if(isDefined(self.var_1A2)) {
    var_01 = getEntArray(self.var_1A2, "targetname");
    foreach(var_03 in var_01) {
      if(!isDefined(var_03.var_165)) {
        continue;
      }

      if(var_03.var_165 == "visuals") {
        var_00[var_00.size] = var_03;
      }
    }
  }

  return var_00;
}

handleflagoutline(param_00) {
  level endon("game_ended");
  self endon("disableFlag");
  self notify("teamFlagOutline");
  self endon("teamFlagOutline");
  var_01 = game["defenders"];
  var_02 = self.flagpole;
  var_03 = 0;
  var_04 = 1;
  var_05 = 2;
  for(;;) {
    if(param_00) {
      var_06 = [];
      var_07 = [];
      foreach(var_09 in level.var_744A) {
        if(var_09.var_1A7 == var_01 || var_09.var_1A7 == "spectator") {
          var_07[var_07.size] = var_09;
          continue;
        }

        var_06[var_06.size] = var_09;
      }

      if(var_07.size > 0) {
        var_02 hudoutlineenableforclients(var_07, var_04, 1);
      }

      if(var_06.size > 0) {
        var_02 hudoutlineenableforclients(var_06, var_05, 1);
      }
    } else if(level.var_744A.size > 0) {
      var_02 hudoutlineenableforclients(level.var_744A, var_03, 1);
    }

    level waittill("joined_team");
  }
}

handleflaguse() {
  level endon("game_ended");
  self endon("disableFlag");
  var_00 = game["defenders"];
  var_01 = self.var_9D65;
  foreach(var_03 in level.var_744A) {
    if(var_03.var_1A7 == var_00 || var_03.var_1A7 == "spectator") {
      var_01 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_1A7 != var_00) {
      var_01 enableplayeruse(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team", var_03);
    if(var_03.var_1A7 == var_00 || var_03.var_1A7 == "spectator") {
      var_01 disableplayeruse(var_03);
      continue;
    }

    if(var_03.var_1A7 != var_00) {
      var_01 enableplayeruse(var_03);
    }
  }
}

disableflaguse() {
  level endon("game_ended");
  self endon("activateFlag");
  var_00 = self.var_9D65;
  foreach(var_02 in level.var_744A) {
    var_00 disableplayeruse(var_02);
  }

  var_04 = self.flagpole;
  var_04 handleobjsheen(0);
  for(;;) {
    level waittill("joined_team", var_02);
    var_00 disableplayeruse(var_02);
  }
}

func_62D0(param_00, param_01) {
  lib_04FF::func_6942(self);
  self.var_62C7 = param_00;
  self.var_62C6 = param_01;
  self.var_5758 = isDefined(self.var_8260) && self.var_8260 == "isCheckpoint";
  var_02 = func_4592();
  foreach(var_04 in var_02) {
    var_04 lib_0502::func_7997();
  }

  var_06 = getent(self.var_81EF, "script_linkname");
  var_07 = getent(var_06.var_81EF, "script_linkname");
  var_08 = getent(var_07.var_81EF, "script_linkname");
  var_06 method_805C();
  lib_04FF::func_6983(self.var_62C7.var_695A);
  var_09 = lib_04FF::func_45CE(self);
  var_0A = "flags_raiseTime_" + param_01;
  var_0B = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], self, var_02, var_09, 0, 1);
  var_0B maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_0B maps\mp\gametypes\_gameobjects::func_8740("friendly", self.var_62C7 lib_04FF::func_45D0("captureTime"));
  var_0B maps\mp\gametypes\_gameobjects::func_8740("enemy", self.var_62C7 lib_04FF::func_45D0("captureTime"));
  var_0B maps\mp\gametypes\_gameobjects::func_8A59(&"MP_SECURING_POSITION");
  var_0B maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_RAISE_FLAG");
  var_0B maps\mp\gametypes\_gameobjects::func_8A5A(lib_0501::func_4647(var_0A));
  var_0B.alliedflag = var_06;
  var_0B.axisflag = var_07;
  var_0B.flagpole = var_08;
  var_0B thread disableflaguse();
  var_0B.var_681A = 0;
  var_0C = var_0B maps\mp\gametypes\_gameobjects::func_454C();
  var_0B.var_E5 = var_0C;
  var_0B maps\mp\gametypes\_gameobjects::func_8A60("friendly");
  var_0B.var_6ABC = ::func_62CA;
  var_0B.var_6AFA = ::func_62CB;
  var_0B.var_6BBF = ::func_62CC;
  var_0B.var_A23E = 21;
  var_0B.var_5F95 = 1;
  var_0B.var_502A = "raidZoneCaptureTwar";
  var_0B.var_59DD = 1;
  var_0B.var_A248 = "war_hammer_assemble_mp";
  var_0B.var_113F = 0;
  var_0B.var_4B25 = 0;
  var_0B.var_62C7 = param_00;
  var_0B.var_A22B = 1;
  var_0B.var_76EB = 0;
  var_0B.var_76E3 = 0;
  var_0B.var_76E4 = 0;
  self.var_695D = var_0B;
  var_0B thread updateflagprogress();
  lib_04FF::func_6982(self.var_62C7.var_695A);
  self notify("end_think");
  self notify("end_hud");
  var_0B maps\mp\gametypes\_gameobjects::func_2F93();
  var_0B maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_0B maps\mp\gametypes\_gameobjects::func_2D58();
}

updateflagprogress() {
  var_00 = self.alliedflag;
  var_01 = self.axisflag;
  var_02 = var_01.var_116;
  var_03 = var_00.var_116;
  var_04 = self.var_A23F;
  var_05 = distance(var_02, var_03);
  var_06 = vectornormalize(var_02 - var_03);
  var_07 = var_04 / 2;
  var_08 = 1;
  for(;;) {
    var_09 = self.var_28D5;
    if(var_09 < var_07) {
      var_0A = var_09 / var_07;
      var_01.var_116 = var_02 - var_05 * var_06 * var_0A;
    } else {
      if(var_08) {
        var_00 method_805B();
        var_01 method_805C();
        var_08 = 0;
      }

      var_0A = var_09 - var_07 / var_07;
      var_00.var_116 = var_03 + var_05 * var_06 * var_0A;
    }

    wait 0.05;
  }
}

handleobjsheen(param_00) {
  if(param_00 == 1) {
    if(isDefined(self.var_8260)) {
      self setModel(self.var_8260);
      return;
    }

    return;
  }

  if(param_00 == 0) {
    if(isDefined(self.var_6C4C)) {
      self setModel(self.var_6C4C);
      return;
    }
  }
}

func_08B1() {
  self.var_695D notify("activateFlag");
  self.var_695D thread handleflaguse();
  self.var_695D.flagpole.var_6C4C = self.var_695D.flagpole.var_106;
  self.var_695D.flagpole handleobjsheen(1);
  self.var_695D maps\mp\gametypes\_gameobjects::func_8A60("any");
  foreach(var_01 in self.var_695D.var_A582) {
    var_01 lib_0502::func_79C6();
  }

  var_03 = 0;
  var_04 = 1;
  if(isDefined(self.var_62C7.var_21DC[self.var_62C7.var_2929])) {
    var_04 = self.var_62C7.var_21DC[self.var_62C7.var_2929];
  }

  if(self.var_62C7.var_2929 >= 1) {
    var_03 = self.var_62C7.var_21DC[self.var_62C7.var_2929 - 1];
  }

  var_05 = self.var_62C7 lib_04FF::func_45D0("captureTime");
  self.var_695D lib_04FF::func_990(self.var_116, undefined, undefined, var_05 * 1000, 24, 0, 1);
  self.var_695D.var_A6E8 = 1;
  lib_04FF::func_79B2(self.var_695A);
  if(self.var_62C7 lib_04FF::func_45D0("pauseDuringTransitionDelay")) {
    setomnvar("ui_war_pause_timer", 1);
    maps\mp\gametypes\_gamelogic::func_6F27();
  }

  var_06 = self.var_62C7 lib_04FF::func_45D0("pointTransitionDelay");
  if(var_06 > 0) {
    wait(var_06);
  }

  self.var_695D.var_A6E8 = 0;
  if(self.var_62C7 lib_04FF::func_45D0("pauseDuringTransitionDelay")) {
    setomnvar("ui_war_pause_timer", 0);
    maps\mp\gametypes\_gamelogic::func_7DFC();
  }

  lib_04FF::func_79B3(self.var_695A);
  if(!self.var_695D func_62C5()) {
    self.var_695D maps\mp\gametypes\_gameobjects::func_C30("any");
    self.var_695D lib_04FF::func_860D(135);
    self.var_695D lib_04FF::func_8614(135);
  } else {
    self.var_695D maps\mp\gametypes\_gameobjects::func_C30("any");
    self.var_695D lib_04FF::func_860D(23);
    self.var_695D lib_04FF::func_8614(23);
  }

  thread func_62CE();
}

func_2A78() {
  self.var_695D notify("disableFlag");
  self.var_695D thread disableflaguse();
  foreach(var_01 in self.var_695D.var_A582) {
    var_01 lib_0502::func_7997();
  }

  self.var_695D maps\mp\gametypes\_gameobjects::func_8A60("none");
  self.var_695D maps\mp\gametypes\_gameobjects::func_C30("none");
  self.var_695D.var_A23F = 0;
  self.var_695D.var_76EB = 0;
  self.var_695D.var_28D5 = 0;
  self.var_695D.var_230F = "none";
  self.var_695D.var_230E = undefined;
  self.var_695D.var_5B82 = "none";
  self.var_695D lib_04FF::func_7CCA();
  self notify("deactivated");
  lib_04FF::func_79B3(self.var_695A);
}

func_62CA(param_00) {
  param_00.raisingflag = 1;
  param_00 thread momentumawardraisingxpevent();
  self.var_A22B = 1;
  lib_04FF::func_860D(136);
  lib_04FF::func_8617("taking", 136);
  var_01 = maps\mp\gametypes\_gameobjects::func_45F7();
  self.var_2EE9 = 0;
  self.var_2950 = 0;
  if(param_00.var_1A7 == game["attackers"]) {
    lib_04FF::func_6981(self.var_62C7.var_695A, "progress", 0);
  } else {
    lib_04FF::func_6981(self.var_62C7.var_695A, "enemyprogress", 0);
  }

  level notify("momentum_point_capture_start_attmept_vo");
}

momentumawardraisingxpevent() {
  self notify("raiseXPEvent");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("raiseXPEvent");
  var_00 = 0;
  while(common_scripts\utility::func_562E(self.raisingflag)) {
    wait(0.1);
    var_00++;
    if(var_00 >= 10) {
      var_00 = 0;
      level thread maps\mp\gametypes\_rank::func_1457("raids_flag_raising", self);
    }
  }
}

func_62C5() {
  return !self.var_9D65.var_62C6 == 0 && !self.var_9D65.var_5758;
}

func_62CC(param_00) {
  var_01 = gettime();
  var_02 = param_00.var_1A7;
  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  self.var_1FC1 = gettime();
  self.var_4B25 = 1;
  var_04 = self.var_62C7 lib_04FF::func_45D0("flagsCapFunc");
  if(isDefined(var_04)) {
    [[var_04]]();
  }

  self.var_9D65.var_62C7 notify("momentumCapture", param_00.var_1A7);
}

func_62CB(param_00, param_01, param_02) {
  param_01.raisingflag = undefined;
  lib_04FF::func_860D(135);
  lib_04FF::func_8614(135);
  if(isPlayer(param_01)) {
    param_01 setclientomnvar("ui_capture_icon", 0);
    param_01 setclientomnvar("ui_capture_status_index", 0);
  }

  if(param_02) {
    if(param_00 == game["attackers"]) {
      lib_04FF::func_6981(self.var_62C7.var_695A, "advance", 0);
    } else {
      lib_04FF::func_6981(self.var_62C7.var_695A, "retreat", 0);
    }

    momentumawardflagcaptureobjectiveevent(param_01);
  }

  if(!func_62C5()) {
    maps\mp\gametypes\_gameobjects::func_C30("any");
    lib_04FF::func_860D(135);
    lib_04FF::func_8614(135);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_C30("any");
  lib_04FF::func_860D(23);
  lib_04FF::func_8614(23);
}

momentumawardflagcaptureobjectiveevent(param_00) {
  param_00 maps\mp\_utility::func_50EA("raids_flag_raise", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_flag_raise", param_00);
}

func_62CE() {
  self notify("momentumOvertimeUpdate");
  self endon("momentumOvertimeUpdate");
  self endon("deactivated");
  var_00 = 10;
  var_01 = 0;
  for(;;) {
    var_02 = 0;
    if(isDefined(self.var_695D.var_54F5) && self.var_695D.var_54F5) {
      var_00 = 10;
    }

    if(var_00 > 0) {
      if(common_scripts\utility::func_562E(level.var_99F5)) {
        var_00 = var_00 - 0.05;
      }

      foreach(var_04 in level.var_744A) {
        if(var_04.var_1A7 == game["attackers"]) {
          if(var_04 istouching(self)) {
            var_02 = 1;
          }
        }
      }
    }

    if(var_02 != var_01) {
      if(var_02) {
        lib_04FF::func_79B2(self.var_695A);
      } else {
        lib_04FF::func_79B3(self.var_695A);
      }

      var_01 = var_02;
    }

    wait 0.05;
  }
}