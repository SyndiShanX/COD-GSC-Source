/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 801.gsc
*********************************************/

lib_0321::func_84DF(param_00, param_01) {
  var_02 = undefined;
  param_00 = tolower(param_00);
  var_03["friendly"] = 3;
  var_03["enemy"] = 4;
  var_03["objective"] = 5;
  var_03["neutral"] = 0;
  var_02 = var_03[param_00];
  self hudoutlineenable(var_02, param_01);
}

lib_0321::func_554E() {
  if(issplitscreen() || getDvar("4693") == "1") {
    return 1;
  }

  return 0;
}

lib_0321::func_554F() {
  if(issplitscreen()) {
    return 0;
  }

  if(!lib_0321::func_554E()) {
    return 0;
  }

  return 1;
}

lib_0321::func_55DE(param_00) {
  if(param_00 common_scripts\utility::func_3798("laststand_downed")) {
    return param_00 common_scripts\utility::func_3794("laststand_downed");
  }

  if(isDefined(param_00.var_00E8)) {
    return param_00.var_00E8;
  }

  return !isalive(param_00);
}

lib_0321::func_55DF(param_00) {
  if(!isDefined(param_00.var_32CC)) {
    return 0;
  }

  return param_00.var_32CC;
}

lib_0321::func_5A49(param_00) {
  if(lib_0321::func_5BE4()) {
    if(isDefined(level.var_5BE5)) {
      return param_00[[level.var_5BE5]]();
    }
  }

  return 0;
}

lib_0321::func_5621() {
  return lib_0321::func_5612() && getdvarint("719") > 0;
}

lib_0321::func_5BE4() {
  return isDefined(level.var_5BE7) && level.var_5BE7 > 0;
}

lib_0321::func_5612() {
  return getdvarint("1996") >= 1;
}

lib_0321::func_2614(param_00, param_01) {
  var_02 = "";
  if(param_00 < 0) {
    var_02 = var_02 + "-";
  }

  param_00 = lib_0321::func_7F05(param_00, 1, 0);
  var_03 = param_00 * 100;
  var_03 = int(var_03);
  var_03 = abs(var_03);
  var_04 = var_03 / 6000;
  var_04 = int(var_04);
  var_02 = var_02 + var_04;
  var_05 = var_03 / 100;
  var_05 = int(var_05);
  var_05 = var_05 - var_04 * 60;
  if(var_05 < 10) {
    var_02 = var_02 + ":0" + var_05;
  } else {
    var_02 = var_02 + ":" + var_05;
  }

  if(isDefined(param_01) && param_01) {
    var_06 = var_03;
    var_06 = var_06 - var_04 * 6000;
    var_06 = var_06 - var_05 * 100;
    var_06 = int(var_06 / 10);
    var_02 = var_02 + "." + var_06;
  }

  return var_02;
}

lib_0321::func_7F05(param_00, param_01, param_02) {
  param_01 = int(param_01);
  if(param_01 < 0 || param_01 > 4) {
    return param_00;
  }

  var_03 = 1;
  for(var_04 = 1; var_04 <= param_01; var_04++) {
    var_03 = var_03 * 10;
  }

  var_05 = param_00 * var_03;
  if(!isDefined(param_02) || param_02) {
    var_05 = floor(var_05);
  } else {
    var_05 = ceil(var_05);
  }

  param_00 = var_05 / var_03;
  return param_00;
}

lib_0321::func_7F0A(param_00, param_01, param_02) {
  var_03 = param_00 / 1000;
  var_03 = lib_0321::func_7F05(var_03, param_01, param_02);
  param_00 = var_03 * 1000;
  return int(param_00);
}

lib_0321::func_85EE(param_00, param_01) {
  if(lib_0322::func_5283(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  visionsetnaked(param_00, param_01);
  setDvar("vision_set_current", param_00);
}

lib_0321::func_85EF(param_00, param_01) {
  if(lib_0322::func_5283(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  self visionsetnakedforplayer(param_00, param_01);
}

lib_0321::func_94E3(param_00, param_01, param_02) {
  param_02 = int(param_02 * 20);
  var_03 = [];
  for(var_04 = 0; var_04 < 3; var_04++) {
    var_03[var_04] = param_00[var_04] - param_01[var_04] / param_02;
  }

  var_05 = [];
  for(var_04 = 0; var_04 < param_02; var_04++) {
    wait 0.05;
    for(var_06 = 0; var_06 < 3; var_06++) {
      var_05[var_06] = param_00[var_06] - var_03[var_06] * var_04;
    }

    setsunlight(var_05[0], var_05[1], var_05[2]);
  }

  setsunlight(param_01[0], param_01[1], param_01[2]);
}

lib_0321::func_4109(param_00, param_01, param_02, param_03) {
  if(!param_00.size) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = level.var_721C;
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_04 = param_01.var_0116;
  if(isDefined(param_02) && param_02) {
    var_04 = param_01 getEye();
  }

  var_05 = undefined;
  var_06 = param_01 getangles();
  var_07 = anglesToForward(var_06);
  var_08 = -1;
  foreach(var_0A in param_00) {
    var_0B = vectortoangles(var_0A.var_0116 - var_04);
    var_0C = anglesToForward(var_0B);
    var_0D = vectordot(var_07, var_0C);
    if(var_0D < var_08) {
      continue;
    }

    if(var_0D < param_03) {
      continue;
    }

    var_08 = var_0D;
    var_05 = var_0A;
  }

  return var_05;
}

lib_0321::func_4101(param_00, param_01, param_02) {
  if(!param_00.size) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = level.var_721C;
  }

  var_03 = param_01.var_0116;
  if(isDefined(param_02) && param_02) {
    var_03 = param_01 getEye();
  }

  var_04 = undefined;
  var_05 = param_01 getangles();
  var_06 = anglesToForward(var_05);
  var_07 = -1;
  for(var_08 = 0; var_08 < param_00.size; var_08++) {
    var_09 = vectortoangles(param_00[var_08].var_0116 - var_03);
    var_0A = anglesToForward(var_09);
    var_0B = vectordot(var_06, var_0A);
    if(var_0B < var_07) {
      continue;
    }

    var_07 = var_0B;
    var_04 = var_08;
  }

  return var_04;
}

lib_0321::func_3C96(param_00, param_01, param_02) {
  common_scripts\utility::func_3C87(param_00);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  param_01 thread lib_0322::func_0629(param_00, param_02);
  return param_01;
}

lib_0321::func_3C97(param_00, param_01, param_02) {
  common_scripts\utility::func_3C87(param_00);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  for(var_03 = 0; var_03 < param_01.size; var_03++) {
    param_01[var_03] thread lib_0322::func_0629(param_00, 0);
  }

  return param_01;
}

lib_0321::func_3C91(param_00, param_01) {
  wait(param_01);
  common_scripts\utility::func_3C8F(param_00);
}

lib_0321::func_3C7C(param_00, param_01) {
  wait(param_01);
  common_scripts\utility::func_3C7B(param_00);
}

lib_0321::func_5CB1(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(lib_0321::func_0F44() && !param_00) {
    return 0;
  }

  if(level.var_6256 && !param_00) {
    return 0;
  }

  if(common_scripts\utility::func_3C77("game_saving")) {
    return 0;
  }

  if(!param_00) {
    for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
      var_03 = level.var_744A[var_02];
      if(!isalive(var_03)) {
        return 0;
      }
    }
  }

  common_scripts\utility::func_3C8F("game_saving");
  var_04 = "levelshots / autosave / autosave_" + level.var_015D + "end";
  var_05 = param_01;
  function_0076("levelend", &"AUTOSAVE_AUTOSAVE", var_04, 1, 1, var_05);
  common_scripts\utility::func_3C7B("game_saving");
  return 1;
}

lib_0321::func_0928(param_00, param_01, param_02) {
  level.var_0625[param_00] = [];
  level.var_0625[param_00]["func"] = param_01;
  level.var_0625[param_00]["msg"] = param_02;
}

lib_0321::func_7C87(param_00) {
  level.var_0625[param_00] = undefined;
}

lib_0321::func_139B() {
  thread lib_0321::func_138F("autosave_stealth", 8, 1);
}

lib_0321::func_139C() {
  thread lib_0321::func_138F("autosave_stealth", 8, 1, 1);
}

lib_0321::func_139D() {
  lib_0322::func_13A2();
  thread lib_0322::func_13A1();
}

lib_0321::func_138D(param_00) {
  thread lib_0321::func_138F(param_00);
}

lib_0321::func_138E(param_00) {
  thread lib_0321::func_138F(param_00, undefined, undefined, 1);
}

lib_0321::func_138F(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_28CE)) {
    level.var_28CE = 1;
  }

  var_04 = "levelshots/autosave/autosave_" + level.var_015D + level.var_28CE;
  var_05 = level lib_0299::func_13A3(level.var_28CE, var_04, param_01, undefined, param_02, param_03);
  if(isDefined(var_05) && var_05) {
    if(!isDefined(param_03) || param_03 == 0) {
      lib_031D::func_7430("CHECKPOINT_REACHED");
    }

    level.var_28CE++;
  }
}

lib_0321::func_1397(param_00, param_01) {
  thread lib_0321::func_138F(param_00, param_01);
}

lib_0321::func_2AF1(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  if(isDefined(param_03)) {
    param_03 endon("death");
    param_01 = param_03.var_0116;
  }

  for(var_04 = 0; var_04 < param_02 * 20; var_04++) {
    if(!isDefined(param_03)) {} else {}

    wait 0.05;
  }
}

lib_0321::func_2AF2(param_00, param_01) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 5;
  }

  for(var_02 = 0; var_02 < param_01 * 20; var_02++) {
    wait 0.05;
  }
}

lib_0321::func_2AF3(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    level notify(param_00 + param_03);
    level endon(param_00 + param_03);
  } else {
    level notify(param_00);
    level endon(param_00);
  }

  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  for(var_04 = 0; var_04 < param_02 * 20; var_04++) {
    wait 0.05;
  }
}

lib_0321::func_0136(param_00) {
  var_01 = spawn("script_model", (0, 0, 0));
  var_01.var_0116 = level.var_721C getorigin();
  var_01 setModel(param_00);
  var_01 delete();
}

lib_0321::func_244A(param_00, param_01) {
  return param_00 >= param_01;
}

lib_0321::func_3A52(param_00, param_01) {
  return param_00 <= param_01;
}

lib_0321::func_4465(param_00, param_01, param_02) {
  return lib_0322::func_255C(param_00, param_01, param_02, ::lib_0321::func_244A);
}

lib_0321::func_4105(param_00, param_01, param_02) {
  var_03 = param_01[0];
  var_04 = distance(param_00, var_03);
  for(var_05 = 0; var_05 < param_01.size; var_05++) {
    var_06 = distance(param_00, param_01[var_05]);
    if(var_06 >= var_04) {
      continue;
    }

    var_04 = var_06;
    var_03 = param_01[var_05];
  }

  if(!isDefined(param_02) || var_04 <= param_02) {
    return var_03;
  }

  return undefined;
}

lib_0321::func_4189(param_00, param_01) {
  if(param_01.size < 1) {
    return;
  }

  var_02 = distance(param_01[0] getorigin(), param_00);
  var_03 = param_01[0];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    var_05 = distance(param_01[var_04] getorigin(), param_00);
    if(var_05 < var_02) {
      continue;
    }

    var_02 = var_05;
    var_03 = param_01[var_04];
  }

  return var_03;
}

lib_0321::func_43E3(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(distance(param_01[var_04].var_0116, param_00) <= param_02) {
      var_03[var_03.size] = param_01[var_04];
    }
  }

  return var_03;
}

lib_0321::func_4276(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(distance(param_01[var_04].var_0116, param_00) > param_02) {
      var_03[var_03.size] = param_01[var_04];
    }
  }

  return var_03;
}

lib_0321::func_4102(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 9999999;
  }

  if(param_01.size < 1) {
    return;
  }

  var_03 = undefined;
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(!isalive(param_01[var_04])) {
      continue;
    }

    var_05 = distance(param_01[var_04].var_0116, param_00);
    if(var_05 >= param_02) {
      continue;
    }

    param_02 = var_05;
    var_03 = param_01[var_04];
  }

  return var_03;
}

lib_0321::func_41C3(param_00, param_01, param_02) {
  if(!param_02.size) {
    return;
  }

  var_03 = undefined;
  var_04 = vectortoangles(param_01 - param_00);
  var_05 = anglesToForward(var_04);
  var_06 = -1;
  foreach(var_08 in param_02) {
    var_04 = vectortoangles(var_08.var_0116 - param_00);
    var_09 = anglesToForward(var_04);
    var_0A = vectordot(var_05, var_09);
    if(var_0A < var_06) {
      continue;
    }

    var_06 = var_0A;
    var_03 = var_08;
  }

  return var_03;
}

lib_0321::func_40FF(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 9999999;
  }

  if(param_01.size < 1) {
    return;
  }

  var_03 = undefined;
  foreach(var_07, var_05 in param_01) {
    var_06 = distance(var_05.var_0116, param_00);
    if(var_06 >= param_02) {
      continue;
    }

    param_02 = var_06;
    var_03 = var_07;
  }

  return var_03;
}

lib_0321::func_40FB(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return undefined;
  }

  var_03 = 0;
  if(isDefined(param_02) && param_02.size) {
    var_04 = [];
    for(var_05 = 0; var_05 < param_01.size; var_05++) {
      var_04[var_05] = 0;
    }

    for(var_05 = 0; var_05 < param_01.size; var_05++) {
      for(var_06 = 0; var_06 < param_02.size; var_06++) {
        if(param_01[var_05] == param_02[var_06]) {
          var_04[var_05] = 1;
        }
      }
    }

    var_07 = 0;
    for(var_05 = 0; var_05 < param_01.size; var_05++) {
      if(!var_04[var_05] && isDefined(param_01[var_05])) {
        var_07 = 1;
        var_03 = distance(param_00, param_01[var_05].var_0116);
        var_08 = var_05;
        var_05 = param_01.size + 1;
      }
    }

    if(!var_07) {
      return undefined;
    }
  } else {
    for(var_05 = 0; var_05 < param_01.size; var_05++) {
      if(isDefined(param_01[var_05])) {
        var_03 = distance(param_00, param_01[0].var_0116);
        var_08 = var_05;
        var_05 = param_01.size + 1;
      }
    }
  }

  var_08 = undefined;
  for(var_05 = 0; var_05 < param_01.size; var_05++) {
    if(isDefined(param_01[var_05])) {
      var_04 = 0;
      if(isDefined(param_02)) {
        for(var_06 = 0; var_06 < param_02.size; var_06++) {
          if(param_01[var_05] == param_02[var_06]) {
            var_04 = 1;
          }
        }
      }

      if(!var_04) {
        var_09 = distance(param_00, param_01[var_05].var_0116);
        if(var_09 <= var_03) {
          var_03 = var_09;
          var_08 = var_05;
        }
      }
    }
  }

  if(isDefined(var_08)) {
    return param_01[var_08];
  }

  return undefined;
}

lib_0321::func_4103(param_00) {
  if(level.var_744A.size == 1) {
    return level.var_721C;
  }

  var_01 = common_scripts\utility::func_4461(param_00, level.var_744A);
  return var_01;
}

lib_0321::func_4104(param_00) {
  if(level.var_744A.size == 1) {
    return level.var_721C;
  }

  var_01 = lib_0321::func_42B7();
  var_02 = common_scripts\utility::func_4461(param_00, var_01);
  return var_02;
}

lib_0321::func_42B7() {
  var_00 = [];
  foreach(var_02 in level.var_744A) {
    if(lib_0321::func_55DE(var_02)) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return var_00;
}

lib_0321::func_40F5(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    var_03 = function_00CB(param_01);
  } else {
    var_03 = function_00CB();
  }

  if(var_03.size == 0) {
    return undefined;
  }

  if(isDefined(param_02)) {
    var_03 = common_scripts\utility::func_0F94(var_03, param_02);
  }

  return common_scripts\utility::func_4461(param_00, var_03);
}

lib_0321::func_40F6(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    var_03 = function_00CB(param_01);
  } else {
    var_03 = function_00CB();
  }

  if(var_03.size == 0) {
    return undefined;
  }

  return lib_0321::func_40FB(param_00, var_03, param_02);
}

lib_0321::func_42CF(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = distance(param_00, param_01);
  }

  param_03 = max(0.01, param_03);
  var_04 = vectornormalize(param_01 - param_00);
  var_05 = param_02 - param_00;
  var_06 = vectordot(var_05, var_04);
  var_06 = var_06 / param_03;
  var_06 = clamp(var_06, 0, 1);
  return var_06;
}

lib_0321::func_1F23(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!lib_0321::func_753A(param_00)) {
    return 0;
  }

  if(!sighttracepassed(self getEye(), param_00, param_01, self)) {
    return 0;
  }

  return 1;
}

lib_0321::func_5577(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 180;
  }

  var_02 = anglesToForward(self.var_001D);
  var_02 = vectornormalize((var_02[0], var_02[1], 0));
  var_03 = vectornormalize(param_00 - self.var_0116);
  var_03 = vectornormalize((var_03[0], var_03[1], 0));
  var_04 = vectordot(var_02, var_03);
  var_05 = cos(param_01 / 2);
  return var_04 > var_05;
}

lib_0321::func_753A(param_00) {
  var_01 = anglesToForward(self.var_001D);
  var_02 = vectornormalize(param_00 - self.var_0116);
  var_03 = vectordot(var_01, var_02);
  return var_03 > 0.766;
}

lib_0321::func_93D8() {
  self notify("stop_magic_bullet_shield");
  if(isai(self)) {
    self.var_0022 = 1;
  }

  self.var_5F6E = undefined;
  self.var_0068 = 0;
  self notify("internal_stop_magic_bullet_shield");
}

lib_0321::func_5F6D() {}

lib_0321::func_5F6E(param_00) {
  if(isai(self)) {} else {
    self.var_00BC = 100000;
  }

  self endon("internal_stop_magic_bullet_shield");
  if(isai(self)) {
    self.var_0022 = 0.1;
  }

  self notify("magic_bullet_shield");
  self.var_5F6E = 1;
  self.var_0068 = 1;
}

lib_0321::func_2F4B() {
  self.var_0794.var_2F8D = 1;
}

lib_0321::func_3631() {
  self.var_0794.var_2F8D = 0;
}

lib_0321::func_360A() {
  self.var_8C84 = undefined;
}

lib_0321::func_2F1F() {
  self.var_8C84 = 1;
}

lib_0321::func_2CF0() {
  lib_0321::func_5F6E(1);
}

lib_0321::func_41D8() {
  return self.var_00CE;
}

lib_0321::func_84E3(param_00) {
  self.var_00CE = param_00;
}

lib_0321::func_84E2(param_00) {
  self.var_00CA = param_00;
  if(param_00) {
    self method_8162();
  }
}

lib_0321::func_41D7(param_00) {
  return self.var_00CA;
}

lib_0321::func_8563(param_00) {
  self.var_0147 = param_00;
}

lib_0321::func_42D2(param_00) {
  return self.var_0147;
}

lib_0321::func_84E4(param_00) {
  self.var_50A1 = param_00;
}

lib_0321::func_848A(param_00) {
  self.var_0094 = param_00;
}

lib_0321::func_427D() {
  return self.var_0118;
}

lib_0321::func_8548(param_00) {
  self.var_0118 = param_00;
}

lib_0321::func_508D(param_00) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");
  if(!isDefined(self.var_508E)) {
    self.var_508E = self.var_00CE;
  }

  var_01 = function_00CB("bad_guys");
  foreach(var_03 in var_01) {
    if(!isalive(var_03.var_0088)) {
      continue;
    }

    if(var_03.var_0088 != self) {
      continue;
    }

    var_03 method_8162();
  }

  self.var_00CE = 1;
  wait(param_00);
  self.var_00CE = self.var_508E;
  self.var_508E = undefined;
}

lib_0321::func_2D0C(param_00) {
  common_scripts\_exploder::func_2D0D(param_00);
}

lib_0321::func_4CE2(param_00) {
  common_scripts\_exploder::func_4CE3(param_00);
}

lib_0321::func_8BC9(param_00) {
  common_scripts\_exploder::func_8BCA(param_00);
}

lib_0321::func_93C7(param_00) {
  common_scripts\_exploder::func_93C8(param_00);
}

lib_0321::func_417E(param_00) {
  return common_scripts\_exploder::func_417F(param_00);
}

lib_0321::func_3D80(param_00) {
  lib_02FC::func_3D83(param_00);
}

lib_0321::func_840C(param_00, param_01) {
  lib_0362::func_14AF(param_00, param_01);
}

lib_0321::func_3DE8(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  thread lib_0321::func_3DE9(param_00, param_01, param_02, param_03);
}

lib_0321::func_6CBA() {}

lib_0321::func_3DE9(param_00, param_01, param_02, param_03) {
  self.var_3E21 = 1;
  self.var_0794.var_3DF5 = param_01;
  self.var_6737 = 1;
  self.var_671E = param_03;
  self.var_0794.var_2963 = param_02;
  self.var_2774 = ::lib_0321::func_6CBA;
  self.var_00FB = 100000;
  self.var_00BC = 100000;
  lib_0321::func_3631();
  if(!isDefined(param_03) || param_03 == 0) {
    self.var_0794.var_3DE7 = param_00 + 181.02;
    return;
  }

  self.var_0794.var_3DE7 = param_00;
  thread animscripts\notetracks::func_67C9();
}

lib_0321::func_6681() {
  self endon("death");
  for(;;) {
    var_00 = self method_83B9();
    if(var_00) {
      var_01 = common_scripts\utility::func_A715("exo_dodge", "player_boost_land", "disable_high_jump");
      if(!isDefined(var_01) || var_01 == "player_boost_land" || var_01 == "disable_high_jump") {
        continue;
      }

      if(!isDefined(self.var_6681)) {
        self.var_6681 = 1;
      }

      common_scripts\utility::func_A70A("player_boost_land", "disable_high_jump");
      wait 0.05;
      self.var_6681 = undefined;
    }

    wait 0.05;
  }
}

lib_0321::func_8B0C() {
  precacheshellshock("default");
  self waittill("death");
  if(isDefined(self.var_90D0)) {
    return;
  }

  if(getDvar("r_texturebits") == "16") {
    return;
  }

  self shellshock("default", 3);
}

lib_0321::func_748C() {
  self endon("death");
  self endon("stop_unresolved_collision_script");
  lib_0321::func_7D48();
  childthread lib_0321::func_748D();
  for(;;) {
    if(self.var_A042) {
      self.var_A042 = 0;
      if(self.var_A043 >= 20) {
        if(isDefined(self.var_4A93)) {
          self[[self.var_4A93]]();
        } else {
          lib_0321::func_2BBE();
        }
      }
    } else {
      lib_0321::func_7D48();
    }

    wait 0.05;
  }
}

lib_0321::func_748D() {
  for(;;) {
    self waittill("unresolved_collision");
    self.var_A042 = 1;
    self.var_A043++;
  }
}

lib_0321::func_7D48() {
  self.var_A042 = 0;
  self.var_A043 = 0;
}

lib_0321::func_2BBE() {
  var_00 = getnodesinradiussorted(self.var_0116, 300, 0, 200, "Path");
  if(var_00.size) {
    self method_843C();
    self method_808C();
    self setorigin(var_00[0].var_0116);
    lib_0321::func_7D48();
    return;
  }

  self method_805A();
}

lib_0321::func_93E3() {
  self notify("stop_unresolved_collision_script");
  lib_0321::func_7D48();
}

lib_0321::func_2D1A(param_00, param_01) {
  param_00 endon("death");
  common_scripts\utility::func_A70A("death", "sound_death");
  if(isDefined(param_00)) {
    if(param_00 method_863C()) {
      param_00 waittill(param_01);
    }

    param_00 delete();
  }
}

lib_0321::func_555F() {
  return issentient(self) && !isalive(self);
}

lib_0321::func_0692(param_00, param_01) {
  param_01 endon("sound_death");
  param_00 waittill("death");
  return 1;
}

lib_0321::func_71AC(param_00, param_01, param_02, param_03, param_04) {
  if(common_scripts\utility::func_562E(param_02) && lib_0321::func_555F()) {
    return;
  }

  if(!function_0344(param_00)) {
    return;
  }

  if(isDefined(param_01)) {
    param_01 = tolower(param_01);
    if(self method_8445(param_01) == -1) {
      param_01 = undefined;
    }
  }

  if(!isDefined(param_02) || !param_02) {
    var_05 = lib_0380::func_6848(param_00, undefined, self, param_01);
  } else {
    var_05 = lib_0380::func_684A(param_01, undefined, self, param_02);
  }

  if(isDefined(var_05)) {
    var_06 = lib_0321::func_0692(var_05, self);
    if(!isDefined(var_06) && isDefined(var_05)) {
      lib_0380::func_6850(var_05, 0.1);
      wait(0.1);
    }
  } else {
    wait(0.1);
  }

  if(isDefined(param_03) && isDefined(self)) {
    self notify(param_03);
  }
}

lib_0321::func_71AD(param_00, param_01) {
  lib_0321::func_71AC(param_00, param_01, 1);
}

lib_0321::func_71AB(param_00, param_01) {
  lib_0321::func_71AC(param_00, undefined, undefined, param_01);
}

lib_0321::func_7154(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_origin", (0, 0, 0));
  var_04 endon("death");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(param_02) {
    thread common_scripts\utility::func_2D18(var_04);
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(param_03) {
    thread lib_0321::func_2D22(var_04);
  }

  if(isDefined(param_01)) {
    var_04 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_04.var_0116 = self.var_0116;
    var_04.var_001D = self.var_001D;
    var_04 linkto(self);
  }

  var_04 method_861D(param_00);
  self waittill("stop sound" + param_00);
  var_04 stoploopsound(param_00);
  var_04 delete();
}

lib_0321::func_2D22(param_00) {
  param_00 endon("death");
  while(isDefined(self)) {
    wait 0.05;
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

lib_0321::func_8057() {
  var_00 = function_00CB("allies");
  var_01 = 0;
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(isDefined(var_00[var_02].var_81B6)) {
      continue;
    }

    game["character" + var_01] = var_00[var_02] lib_0281::func_8055();
    var_01++;
  }

  game["total characters"] = var_01;
}

lib_0321::func_8FA3(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(!isDefined(param_00.var_3BAA)) {
    param_00 common_scripts\utility::func_A732("finished spawning", "death");
  }

  if(isalive(param_00)) {
    return 0;
  }

  return 1;
}

lib_0321::func_8FF2(param_00) {
  lib_0281::func_0136(param_00);
  self waittill("spawned", var_01);
  if(lib_0321::func_8FA3(var_01)) {
    return;
  }

  var_01 lib_0281::func_6685();
  var_01 lib_0281::func_5DDF(param_00);
}

lib_0321::func_59E4(param_00, param_01) {
  iprintlnbold(param_00, param_01["key1"]);
}

lib_0321::func_A4AD(param_00) {
  self endon("death");
  for(;;) {
    lib_02A9::func_33E0(param_00);
    wait 0.05;
  }
}

lib_0321::func_10CA(param_00) {
  if(isDefined(param_00)) {
    self.var_0EC4 = param_00;
  }

  self method_810F(level.var_80C8[self.var_0EC4]);
}

lib_0321::func_10D3() {
  if(isarray(level.var_80CD[self.var_0EC4])) {
    var_00 = randomint(level.var_80CD[self.var_0EC4].size);
    self setModel(level.var_80CD[self.var_0EC4][var_00]);
    return;
  }

  self setModel(level.var_80CD[self.var_0EC4]);
}

lib_0321::func_8F82(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_03 = spawn("script_model", param_01);
  var_03.var_0EC4 = param_00;
  var_03 lib_0321::func_10CA();
  var_03 lib_0321::func_10D3();
  if(isDefined(param_02)) {
    var_03.var_001D = param_02;
  }

  return var_03;
}

lib_0321::func_9DB8(param_00, param_01) {
  var_02 = getent(param_00, param_01);
  if(!isDefined(var_02)) {
    return;
  }

  var_02 waittill("trigger", var_03);
  level notify(param_00, var_03);
  return var_03;
}

lib_0321::func_9DB9(param_00) {
  return lib_0321::func_9DB8(param_00, "targetname");
}

lib_0321::func_8492(param_00, param_01) {
  thread lib_0321::func_8494(param_00, param_01, ::lib_0321::func_A728, "set_flag_on_dead");
}

lib_0321::func_8493(param_00, param_01) {
  thread lib_0321::func_8494(param_00, param_01, ::lib_0321::func_A729, "set_flag_on_dead_or_dying");
}

lib_0321::func_8496(param_00, param_01) {
  thread lib_0321::func_8494(param_00, param_01, ::lib_0321::func_35F9, "set_flag_on_spawned");
}

lib_0321::func_35F9(param_00) {}

lib_0321::func_8497(param_00, param_01) {
  self waittill("spawned", var_02);
  if(lib_0321::func_8FA3(var_02)) {
    return;
  }

  param_00.var_9044[param_00.var_9044.size] = var_02;
  common_scripts\utility::func_379A(param_01);
}

lib_0321::func_8498(param_00, param_01) {
  self waittill("spawned", var_02);
  param_00.var_9044[param_00.var_9044.size] = var_02;
  common_scripts\utility::func_379A(param_01);
}

lib_0321::func_8494(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_9044 = [];
  if(param_00.size == 0) {
    return;
  }

  var_05 = 0;
  var_06 = 0;
  foreach(var_08 in param_00) {
    if(isspawner(var_08)) {
      var_05++;
      continue;
    }

    var_06++;
  }

  if(var_06 != param_00.size && var_05 != param_00.size) {}

  if(isspawner(param_00[0])) {
    var_0A = param_00;
    foreach(var_0C in var_0A) {
      var_0C common_scripts\utility::func_3799(param_03);
    }

    if(var_0A[0].var_003B == "script_vehicle") {
      common_scripts\utility::func_0FB2(var_0A, ::lib_0321::func_8498, var_04, param_03);
    } else {
      common_scripts\utility::func_0FB2(var_0A, ::lib_0321::func_8497, var_04, param_03);
    }

    foreach(var_0C in var_0A) {
      var_0C common_scripts\utility::func_379C(param_03);
    }
  } else {
    var_07.var_9044 = param_03;
  }

  [[var_05]](var_07.var_9044);
  common_scripts\utility::func_3C8F(var_04);
}

lib_0321::func_849A(param_00, param_01) {
  if(!common_scripts\utility::func_3C77(param_01)) {
    param_00 waittill("trigger", var_02);
    common_scripts\utility::func_3C8F(param_01);
    return var_02;
  }
}

lib_0321::func_8499(param_00) {
  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  var_01 = getent(param_00, "targetname");
  var_01 waittill("trigger");
  common_scripts\utility::func_3C8F(param_00);
}

lib_0321::func_559A(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] == param_01) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_A728(param_00, param_01, param_02) {
  var_0A = spawnStruct();
  if(isDefined(param_02)) {
    var_0A endon("thread_timed_out");
    var_0A thread lib_0321::func_A72E(param_02);
  }

  var_0A.var_005C = param_00.size;
  if(isDefined(param_01) && param_01 < var_0A.var_005C) {
    var_0A.var_005C = param_01;
  }

  common_scripts\utility::func_0FB2(param_00, ::lib_0321::func_A72D, var_0A);
  while(var_0A.var_005C > 0) {
    var_0A waittill("waittill_dead guy died");
  }
}

lib_0321::func_A729(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_00) {
    if(isalive(var_05) && !var_05.var_00CD) {
      var_03[var_03.size] = var_05;
    }
  }

  param_00 = var_03;
  var_07 = spawnStruct();
  if(isDefined(param_02)) {
    var_07 endon("thread_timed_out");
    var_07 thread lib_0321::func_A72E(param_02);
  }

  var_07.var_005C = param_00.size;
  if(isDefined(param_01) && param_01 < var_07.var_005C) {
    var_07.var_005C = param_01;
  }

  common_scripts\utility::func_0FB2(param_00, ::lib_0321::func_A72C, var_07);
  while(var_07.var_005C > 0) {
    var_07 waittill("waittill_dead_guy_dead_or_dying");
  }
}

lib_0321::func_A72D(param_00) {
  self waittill("death");
  param_00.var_005C--;
  param_00 notify("waittill_dead guy died");
}

lib_0321::func_A72C(param_00) {
  common_scripts\utility::func_A732("death", "pain_death");
  param_00.var_005C--;
  param_00 notify("waittill_dead_guy_dead_or_dying");
}

lib_0321::func_A72E(param_00) {
  wait(param_00);
  self notify("thread_timed_out");
}

lib_0321::func_A706(param_00) {
  while(level.var_0596[param_00].var_905E.size >= 1 || level.var_0596[param_00].var_0A62.size >= 1) {
    wait(0.25);
  }
}

lib_0321::func_A707(param_00, param_01) {
  for(;;) {
    var_02 = lib_0321::func_406F(param_00);
    var_02 = var_02 + lib_0321::func_406D(param_00);
    if(var_02 <= param_01) {
      break;
    }

    wait(0.25);
  }
}

lib_0321::func_A708(param_00, param_01) {
  for(;;) {
    var_02 = lib_0321::func_406D(param_00);
    if(var_02 <= param_01) {
      break;
    }

    wait(0.25);
  }
}

lib_0321::func_A709(param_00, param_01, param_02) {
  level endon(param_02);
  lib_0321::func_A708(param_00, param_01);
}

lib_0321::func_406C(param_00) {
  return lib_0321::func_406F(param_00) + lib_0321::func_406D(param_00);
}

lib_0321::func_406F(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_0596[param_00].var_905E) {
    var_01 = var_01 + var_03.var_005C;
  }

  return var_01;
}

lib_0321::func_406D(param_00) {
  return level.var_0596[param_00].var_0A62.size;
}

lib_0321::func_406B(param_00) {
  return level.var_0596[param_00].var_0A62;
}

lib_0321::func_4070(param_00) {
  return level.var_0596[param_00].var_905E;
}

lib_0321::func_A74A(param_00) {
  self endon("damage");
  self endon("death");
  self waittillmatch(param_00, "single anim");
}

lib_0321::func_41F7(param_00, param_01) {
  var_02 = lib_0321::func_41F8(param_00, param_01);
  if(var_02.size > 1) {
    return undefined;
  }

  return var_02[0];
}

lib_0321::func_41F8(param_00, param_01) {
  var_02 = function_00CC("all", "all");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(!isalive(var_05)) {
      continue;
    }

    switch (param_01) {
      case "targetname":
        if(isDefined(var_05.var_01A5) && var_05.var_01A5 == param_00) {
          var_03[var_03.size] = var_05;
        }
        break;

      case "script_noteworthy":
        if(isDefined(var_05.var_0165) && var_05.var_0165 == param_00) {
          var_03[var_03.size] = var_05;
        }
        break;
    }
  }

  return var_03;
}

lib_0321::func_43B9(param_00, param_01) {
  var_02 = lib_0321::func_43BC(param_00, param_01);
  if(!var_02.size) {
    return undefined;
  }

  return var_02[0];
}

lib_0321::func_43BC(param_00, param_01) {
  var_02 = getEntArray(param_00, param_01);
  var_03 = [];
  var_04 = [];
  foreach(var_06 in var_02) {
    if(var_06.var_003B != "script_vehicle") {
      continue;
    }

    var_04[0] = var_06;
    if(isspawner(var_06)) {
      if(isDefined(var_06.var_5B4F)) {
        var_04[0] = var_06.var_5B4F;
        var_03 = common_scripts\utility::func_0F8C(var_03, var_04);
      }

      continue;
    }

    var_03 = common_scripts\utility::func_0F8C(var_03, var_04);
  }

  return var_03;
}

lib_0321::func_41F9(param_00, param_01, param_02) {
  var_03 = lib_0321::func_41FA(param_00, param_01, param_02);
  if(var_03.size > 1) {
    return undefined;
  }

  return var_03[0];
}

lib_0321::func_41FA(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = "all";
  }

  var_03 = function_00CC("allies", param_02);
  var_03 = common_scripts\utility::func_0F73(var_03, function_00CC("axis", param_02));
  var_04 = [];
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    switch (param_01) {
      case "targetname":
        if(isDefined(var_03[var_05].var_01A5) && var_03[var_05].var_01A5 == param_00) {
          var_04[var_04.size] = var_03[var_05];
        }
        break;

      case "script_noteworthy":
        if(isDefined(var_03[var_05].var_0165) && var_03[var_05].var_0165 == param_00) {
          var_04[var_04.size] = var_03[var_05];
        }
        break;
    }
  }

  return var_04;
}

lib_0321::func_4003(param_00, param_01) {
  if(isDefined(level.var_4002[param_00])) {
    if(level.var_4002[param_00]) {
      wait 0.05;
      if(isalive(self)) {
        self notify("gather_delay_finished" + param_00 + param_01);
      }

      return;
    }

    level waittill(param_00);
    if(isalive(self)) {
      self notify("gather_delay_finished" + param_00 + param_01);
    }

    return;
  }

  level.var_4002[param_00] = 0;
  wait(param_01);
  level.var_4002[param_00] = 1;
  level notify(param_00);
  if(isalive(self)) {
    self notify("gather_delay_finished" + param_00 + param_01);
  }
}

lib_0321::func_4002(param_00, param_01) {
  thread lib_0321::func_4003(param_00, param_01);
  self waittill("gather_delay_finished" + param_00 + param_01);
}

lib_0321::func_2A9A(param_00) {
  self waittill("death");
  level notify(param_00);
}

lib_0321::func_4453(param_00) {
  if(param_00 == 0) {
    return "0";
  }

  if(param_00 == 1) {
    return "1";
  }

  if(param_00 == 2) {
    return "2";
  }

  if(param_00 == 3) {
    return "3";
  }

  if(param_00 == 4) {
    return "4";
  }

  if(param_00 == 5) {
    return "5";
  }

  if(param_00 == 6) {
    return "6";
  }

  if(param_00 == 7) {
    return "7";
  }

  if(param_00 == 8) {
    return "8";
  }

  if(param_00 == 9) {
    return "9";
  }
}

lib_0321::func_455C(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    var_05 = var_04.var_0164;
    if(!isDefined(var_05)) {
      continue;
    }

    if(!isDefined(param_01[var_05])) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

lib_0321::func_0F8D(param_00, param_01) {
  if(!param_00.size) {
    return param_01;
  }

  if(!param_01.size) {
    return param_00;
  }

  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    var_02[var_04.var_0164] = 1;
  }

  for(var_03 = 0; var_03 < param_01.size; var_03++) {
    var_04 = param_01[var_03];
    if(isDefined(var_02[var_04.var_0164])) {
      continue;
    }

    var_02[var_04.var_0164] = 1;
    param_00[param_00.size] = var_04;
  }

  return param_00;
}

lib_0321::func_455B() {
  var_00 = [];
  if(isDefined(self.var_81EF)) {
    var_01 = common_scripts\utility::func_41F3();
    foreach(var_03 in var_01) {
      var_04 = function_01DC(var_03, "script_linkname");
      var_00 = common_scripts\utility::func_0F73(var_00, var_04);
    }
  }

  return var_00;
}

lib_0321::func_33B9(param_00, param_01, param_02, param_03, param_04) {
  wait 0.05;
}

lib_0321::func_33BF(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_05 = gettime() + param_05 * 1000;
  while(gettime() < param_05) {
    wait 0.05;
    if(!isDefined(param_01) || !isDefined(param_01.var_0116)) {
      return;
    }
  }
}

lib_0321::func_33BB(param_00, param_01, param_02, param_03, param_04, param_05) {
  lib_0321::func_33BF(param_01, param_00, param_02, param_03, param_04, param_05);
}

lib_0321::func_33BC(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  param_01 endon("death");
  param_05 = gettime() + param_05 * 1000;
  while(gettime() < param_05) {
    wait 0.05;
  }
}

lib_0321::func_33BD(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 endon("death");
  param_01 endon("death");
  param_05 endon(param_06);
  wait 0.05;
}

lib_0321::func_33C0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_05 endon(param_06);
  var_07 = 1;
  for(;;) {
    common_scripts\utility::func_33BA(param_00, param_01, param_02, param_03, param_04, var_07);
    wait(var_07);
  }
}

lib_0321::func_33BE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_06 = gettime() + param_06 * 1000;
  param_01 = param_01 * param_02;
  while(gettime() < param_06) {
    wait 0.05;
    if(!isDefined(param_00) || !isDefined(param_00.var_0116)) {
      return;
    }
  }
}

lib_0321::func_33A8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_07)) {
    var_08 = param_07;
  } else {
    var_08 = 16;
  }

  var_09 = 360 / var_08;
  var_0A = [];
  for(var_0B = 0; var_0B < var_08; var_0B++) {
    var_0C = var_09 * var_0B;
    var_0D = cos(var_0C) * param_01;
    var_0E = sin(var_0C) * param_01;
    var_0F = param_00[0] + var_0D;
    var_10 = param_00[1] + var_0E;
    var_11 = param_00[2];
    var_0A[var_0A.size] = (var_0F, var_10, var_11);
  }

  thread lib_0321::func_33A7(var_0A, param_02, param_03, param_04, param_05, param_06);
}

lib_0321::func_33A7(param_00, param_01, param_02, param_03, param_04, param_05) {
  for(var_06 = 0; var_06 < param_00.size; var_06++) {
    var_07 = param_00[var_06];
    if(var_06 + 1 >= param_00.size) {
      var_08 = param_00[0];
    } else {
      var_08 = param_00[var_06 + 1];
    }

    thread lib_0321::func_33C0(var_07, var_08, param_01, param_02, param_03, param_04, param_05);
  }
}

lib_0321::func_23B5() {
  self notify("enemy");
  self method_8162();
}

lib_0321::func_163D(param_00) {
  lib_02A8::func_2A44(param_00);
}

lib_0321::func_163E(param_00) {
  lib_02A8::func_2A46(param_00);
}

lib_0321::func_841E(param_00) {
  lib_0321::func_2A49(!param_00);
}

lib_0321::func_3D60(param_00) {
  thread lib_0321::func_849D(1, param_00);
}

lib_0321::func_3D5F(param_00) {
  thread lib_0321::func_849D(0, param_00);
}

lib_0321::func_849D(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "allies";
  }

  if(!level.var_2128) {
    return;
  }

  wait(1.5);
  level.var_3D5E[param_01] = param_00;
  var_02 = [];
  var_02 = function_00CB(param_01);
  common_scripts\utility::func_0FB2(var_02, ::lib_0321::func_849C, param_00);
}

lib_0321::func_849C(param_00) {
  self.var_3D5E = param_00;
}

lib_0321::func_3ECB() {
  var_00 = function_00CB("allies");
  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 lib_0321::func_84AB(0);
    }
  }

  level.var_3EC9 = 0;
}

lib_0321::func_3ECC() {
  var_00 = function_00CB("allies");
  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 lib_0321::func_84AB(1);
    }
  }

  level.var_3EC9 = 1;
}

lib_0321::func_84AB(param_00) {
  if(param_00) {
    self.var_3ECA = undefined;
    return;
  }

  self.var_3ECA = 1;
}

lib_0321::func_2A62(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  switch (param_00) {
    case "reznov":
    case "hudson":
    case "mason":
      level.var_2A3D.var_723F = getsubstr(param_00, 0, 3);
      break;

    default:
      level.var_2A3D.var_723F = "mas";
      break;
  }

  self.var_2A3F = level.var_2A3D.var_723F;
}

lib_0321::func_2A49(param_00) {
  if(isai(self) && isalive(self)) {
    if(param_00) {
      self.var_2A44 = 1;
      return;
    }

    self.var_2A44 = 0;
    return;
  }
}

lib_0321::func_4258(param_00) {
  var_01 = getEntArray("objective", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02].var_0165 == param_00) {
      return var_01[var_02].var_0116;
    }
  }
}

lib_0321::func_4257(param_00) {
  var_01 = getEntArray("objective_event", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02].var_0165 == param_00) {
      return var_01[var_02];
    }
  }
}

lib_0321::func_A74E() {
  lib_0322::func_A750(1);
}

lib_0321::func_A74F() {
  lib_0322::func_A750(0);
}

lib_0321::func_2B5A() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");
  for(;;) {
    var_00 = anglesToForward(self.var_001D);
    var_01 = var_00 * 30;
    var_02 = var_00 * 20;
    var_03 = anglestoright(self.var_001D);
    var_04 = var_03 * -10;
    var_03 = var_03 * 10;
    wait 0.05;
  }
}

lib_0321::func_41E3(param_00) {
  var_01 = self;
  while(isDefined(var_01.var_01A2)) {
    wait 0.05;
    if(isDefined(var_01.var_01A2)) {
      switch (param_00) {
        case "vehiclenode":
          var_01 = getvehiclenode(var_01.var_01A2, "targetname");
          break;

        case "pathnode":
          var_01 = getnode(var_01.var_01A2, "targetname");
          break;

        case "ent":
          var_01 = getent(var_01.var_01A2, "targetname");
          break;

        case "struct":
          var_01 = common_scripts\utility::func_46B5(var_01.var_01A2, "targetname");
          break;

        default:
          break;
      }

      continue;
    }

    break;
  }

  var_02 = var_01;
  return var_02;
}

lib_0321::func_8381(param_00) {
  self endon("death");
  var_01 = function_00CB("allies");
  var_01[var_01.size] = level.var_721C;
  var_01 = function_01AC(var_01, self.var_0116, 3000);
  var_01 = common_scripts\utility::func_0FA0(var_01);
  var_02 = var_01[randomintrange(0, int(var_01.size / 2))];
  self method_8163(var_02, 1);
  if(isDefined(param_00)) {
    thread lib_0321::func_9A01(param_00);
  }

  self.var_00AE = 64;
  self method_81A3(var_02);
  if(!isDefined(self.var_6A58)) {
    self.var_6A58 = self.var_00AE;
  }

  common_scripts\utility::func_A70A("goal", "timeout");
  if(isDefined(self.var_6A58)) {
    self.var_00AE = self.var_6A58;
    self.var_6A58 = undefined;
  }
}

lib_0321::func_731C(param_00) {
  if(isDefined(param_00)) {
    thread lib_0321::func_9A01(param_00);
  }

  self.var_00AE = 128;
  self method_81A3(level.var_721C);
  if(!isDefined(self.var_6A58)) {
    self.var_6A58 = self.var_00AE;
  }

  common_scripts\utility::func_A70A("goal", "timeout");
  if(isDefined(self.var_6A58)) {
    self.var_00AE = self.var_6A58;
    self.var_6A58 = undefined;
  }
}

lib_0321::func_9A01(param_00) {
  self endon("death");
  wait(param_00);
  self notify("timeout");
}

lib_0321::func_84A7() {
  if(isDefined(self.var_84A6)) {
    return;
  }

  self.var_6A57 = self.var_011D;
  self.var_6A5F = self.var_011E;
  self.var_6A60 = self.var_0100;
  self.var_011D = 8;
  self.var_011E = 8;
  self.var_0100 = 1;
  self.var_84A6 = 1;
}

lib_0321::func_A04D() {
  if(!isDefined(self.var_84A6)) {
    return;
  }

  self.var_011D = self.var_6A57;
  self.var_011E = self.var_6A5F;
  self.var_0100 = self.var_6A60;
  self.var_84A6 = undefined;
}

lib_0321::func_0F9D(param_00) {
  var_01 = [];
  var_02 = getarraykeys(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(!isalive(param_00[var_04])) {
      continue;
    }

    var_01[var_04] = param_00[var_04];
  }

  return var_01;
}

lib_0321::func_0F9C(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

lib_0321::func_0F9E(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    if(isai(var_03) && var_03 lib_0321::func_3201()) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

lib_0321::func_947A() {
  var_00 = spawnStruct();
  var_00.var_0F6D = [];
  var_00.var_5BAD = 0;
  return var_00;
}

lib_0321::func_947D(param_00, param_01) {
  param_00.var_0F6D[param_00.var_5BAD] = param_01;
  param_01.var_9479 = param_00.var_5BAD;
  param_00.var_5BAD++;
}

lib_0321::func_947E(param_00, param_01) {
  lib_0321::func_9483(param_00, param_01);
  param_00.var_0F6D[param_00.var_5BAD - 1] = undefined;
  param_00.var_5BAD--;
}

lib_0321::func_947F(param_00, param_01) {
  if(isDefined(param_00.var_0F6D[param_00.var_5BAD - 1])) {
    param_00.var_0F6D[param_01] = param_00.var_0F6D[param_00.var_5BAD - 1];
    param_00.var_0F6D[param_01].var_9479 = param_01;
    param_00.var_0F6D[param_00.var_5BAD - 1] = undefined;
    param_00.var_5BAD = param_00.var_0F6D.size;
    return;
  }

  param_00.var_0F6D[param_01] = undefined;
  lib_0321::func_9480(param_00);
}

lib_0321::func_9480(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_0F6D) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  param_00.var_0F6D = var_01;
  foreach(var_06, var_03 in param_00.var_0F6D) {
    var_03.var_9479 = var_06;
  }

  param_00.var_5BAD = param_00.var_0F6D.size;
}

lib_0321::func_9483(param_00, param_01) {
  param_00 lib_0322::func_9482(param_00.var_0F6D[param_00.var_5BAD - 1], param_01);
}

lib_0321::func_9481(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01; var_02++) {
    param_00 lib_0322::func_9482(param_00.var_0F6D[var_02], param_00.var_0F6D[randomint(param_00.var_5BAD)]);
  }
}

lib_0321::func_43B5() {
  if(level.var_258F) {
    return " + usereload";
  }

  return " + activate";
}

lib_0321::func_4350(param_00, param_01) {
  var_02 = newhudelem();
  if(level.var_258F) {
    var_02.var_01D3 = 68;
    var_02.var_01D7 = 35;
  } else {
    var_02.var_01D3 = 58;
    var_02.var_01D7 = 95;
  }

  var_02.var_0010 = "center";
  var_02.var_0011 = "middle";
  var_02.var_00C6 = "left";
  var_02.var_01CA = "middle";
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = level.var_3965;
  }

  var_02 setclock(var_03, param_00, "hudStopwatch", 64, 64);
  return var_02;
}

lib_0321::func_6916(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.var_08C4.size; var_02++) {
    if(level.var_08C4[var_02] != param_00) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

lib_0321::func_6917(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.var_50D8.size; var_02++) {
    if(level.var_50D8[var_02] != param_00) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

lib_0321::func_853F(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_08C4.size; var_02++) {
    if(level.var_08C4[var_02] == param_00) {
      continue;
    }

    var_01[var_01.size] = level.var_08C4[var_02];
  }

  level.var_08C4 = var_01;
  var_03 = 0;
  for(var_02 = 0; var_02 < level.var_50D8.size; var_02++) {
    if(level.var_50D8[var_02] != param_00) {
      continue;
    }

    var_03 = 1;
  }

  if(!var_03) {
    level.var_50D8[level.var_50D8.size] = param_00;
  }
}

lib_0321::func_853E(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_50D8.size; var_02++) {
    if(level.var_50D8[var_02] == param_00) {
      continue;
    }

    var_01[var_01.size] = level.var_50D8[var_02];
  }

  level.var_50D8 = var_01;
  var_03 = 0;
  for(var_02 = 0; var_02 < level.var_08C4.size; var_02++) {
    if(level.var_08C4[var_02] != param_00) {
      continue;
    }

    var_03 = 1;
  }

  if(!var_03) {
    level.var_08C4[level.var_08C4.size] = param_00;
  }
}

lib_0321::func_6257() {
  if(level.var_6256) {
    return;
  }

  if(isDefined(level.var_66C7)) {
    return;
  }

  if(getDvar("failure_disabled") == "1") {
    return;
  }

  level.var_721C lib_02FA::func_4CFE();
  level.var_6256 = 1;
  common_scripts\utility::func_3C8F("missionfailed");
  if(lib_0321::func_0F44()) {
    return;
  }

  if(isDefined(level.var_6251)) {
    thread[[level.var_6251]]();
    return;
  }

  lib_0322::func_6252(0);
  function_0056();
}

lib_0321::func_8526(param_00) {
  level.var_6251 = param_00;
}

lib_0321::func_4905(param_00) {
  thread lib_0324::func_4904(param_00);
}

lib_0321::func_4923(param_00, param_01, param_02, param_03, param_04) {
  lib_0324::func_4922(param_00, param_01, param_02, param_03, param_04);
}

lib_0321::func_4916(param_00) {
  var_01 = self.var_7E7F;
  if(!isDefined(var_01)) {
    return 0;
  }

  if(isDefined(param_00) && !param_00) {
    foreach(var_03 in var_01.var_A037) {
      if(isDefined(var_03) && var_03 == self) {
        return 0;
      }
    }
  }

  if(isDefined(self.var_A390)) {
    return 1;
  }

  return 0;
}

lib_0321::func_419E(param_00, param_01) {
  var_02 = function_00CB(param_00);
  var_03 = [];
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = var_02[var_04];
    if(!isDefined(var_05.var_81AD)) {
      continue;
    }

    if(var_05.var_81AD != param_01) {
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  return var_03;
}

lib_0321::func_4085() {
  var_00 = function_00CB("allies");
  var_01 = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    if(!isDefined(var_03.var_81AD)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

lib_0321::func_408B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.var_01A2;
  }

  var_01 = [];
  var_02 = getEntArray(param_00, "targetname");
  var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  var_02 = getnodearray(param_00, "targetname");
  var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  var_02 = common_scripts\utility::func_46B7(param_00, "targetname");
  var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  var_02 = function_01DC(param_00, "targetname");
  var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  return var_01;
}

lib_0321::func_3601() {
  if(isDefined(self.var_81AD)) {
    return;
  }

  if(!isDefined(self.var_6A31)) {
    return;
  }

  lib_0321::func_84A1(self.var_6A31);
  self.var_6A31 = undefined;
}

lib_0321::func_3602() {
  self.var_3241 = 1;
  lib_0321::func_3601();
}

lib_0321::func_2F19() {
  if(isDefined(self.var_668B)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  if(isDefined(self.var_8135)) {
    lib_0321::func_2F26(0);
  }

  self method_815A();
  if(!isDefined(self.var_81AD)) {
    return;
  }

  self.var_6A31 = self.var_81AD;
  lib_02A0::func_7C6E();
}

lib_0321::func_23B9() {
  lib_0321::func_2F19();
}

lib_0321::func_2169(param_00) {
  var_01 = level.var_24F8[tolower(param_00)];
  if(isDefined(self.var_81AD) && var_01 == self.var_81AD) {
    return 1;
  }

  return 0;
}

lib_0321::func_419D() {
  var_00 = self.var_81AD;
  return var_00;
}

lib_0321::func_84A1(param_00) {
  var_01 = lib_02A0::func_08F9(param_00);
}

lib_0321::func_57EC(param_00, param_01) {
  lib_02A0::func_57ED(param_00, param_01);
}

lib_0321::func_23AC(param_00, param_01) {
  lib_02A0::func_23AD(param_00, param_01);
}

lib_0321::func_239D(param_00) {
  foreach(var_02 in level.var_24FD) {
    lib_02A0::func_23AD(var_02, param_00);
  }
}

lib_0321::func_7D12() {
  thread lib_02A0::func_2500();
}

lib_0321::func_2F57() {
  self.var_7D12 = undefined;
  self notify("_disable_reinforcement");
}

lib_0321::func_93E5() {
  self notify("_disable_reinforcement");
}

lib_0321::func_93B4(param_00, param_01) {
  thread lib_02A0::func_2506(param_00, param_01);
}

lib_0321::func_8FED(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = "allies";
  }

  thread lib_02A0::func_2505(param_03, param_00, param_01, param_02);
}

lib_0321::func_23C8(param_00) {
  lib_02A0::func_24FE(param_00);
}

lib_0321::func_8562(param_00, param_01, param_02) {
  lib_02A0::func_2502(param_00, param_01, param_02);
}

lib_0321::func_847F(param_00, param_01) {
  lib_02A0::func_2501(param_00, param_01);
}

lib_0321::func_4B29() {
  if(lib_02A0::func_437D() == "axis") {
    return isDefined(self.var_813C) || isDefined(self.var_81AD);
  }

  return isDefined(self.var_813B) || isDefined(self.var_81AD);
}

lib_0321::func_4114() {
  return lib_02A0::func_4115();
}

lib_0321::func_4110() {
  return lib_02A0::func_4111();
}

lib_0321::func_3D58(param_00) {
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

lib_0321::func_3D55(param_00) {
  self endon("death");
  self endon("flashed");
  wait(0.2);
  self method_812D(0);
  wait(param_00 + 2);
  self method_812D(1);
}

lib_0321::func_66DA(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [0.8, 0.7, 0.7, 0.6];
  var_06 = [1, 0.8, 0.6, 0.6];
  foreach(var_0C, var_08 in var_06) {
    var_09 = param_01 - 0.85 / 0.15;
    if(var_09 > param_02) {
      param_02 = var_09;
    }

    if(param_02 < 0.25) {
      param_02 = 0.25;
    }

    var_0A = 0.3;
    if(param_01 > 1 - var_0A) {
      param_01 = 1;
    } else {
      param_01 = param_01 / 1 - var_0A;
    }

    if(param_04 != self.var_01A7) {
      var_0B = param_01 * param_02 * 6;
    } else {
      var_0B = param_01 * param_02 * 3;
    }

    if(var_0B < 0.25) {
      continue;
    }

    var_0B = var_08 * var_0B;
    if(isDefined(self.var_6084) && var_0B > self.var_6084) {
      var_0B = self.var_6084;
    }

    self.var_3D4A = param_04;
    self notify("flashed");
    self.var_3D48 = gettime() + var_0B * 1000;
    self shellshock("flashbang", var_0B);
    common_scripts\utility::func_3C8F("player_flashed");
    if(param_01 * param_02 > 0.5) {
      thread lib_0321::func_3D55(var_0B);
    }

    wait(var_05[var_0C]);
  }

  thread lib_0322::func_A01C(0.05);
}

lib_0321::func_3D54() {
  self endon("death");
  for(;;) {
    self waittill("flashbang", var_00, var_01, var_02, var_03, var_04);
    if("1" == getDvar("noflash")) {
      continue;
    }

    if(lib_0321::func_55DE(self)) {
      continue;
    }

    if(isDefined(self.var_999C)) {
      var_05 = 0.8;
      var_06 = 1 - var_05;
      self.var_999C = undefined;
      if(var_01 < var_06) {
        continue;
      }

      var_01 = var_01 - var_06 / var_05;
    }

    var_07 = var_01 - 0.85 / 0.15;
    if(var_07 > var_02) {
      var_02 = var_07;
    }

    if(var_02 < 0.25) {
      var_02 = 0.25;
    }

    var_08 = 0.3;
    if(var_01 > 1 - var_08) {
      var_01 = 1;
    } else {
      var_01 = var_01 / 1 - var_08;
    }

    if(var_04 != self.var_01A7) {
      var_09 = var_01 * var_02 * 6;
    } else {
      var_09 = var_01 * var_02 * 3;
    }

    if(var_09 < 0.25) {
      continue;
    }

    if(isDefined(self.var_6084) && var_09 > self.var_6084) {
      var_09 = self.var_6084;
    }

    self.var_3D4A = var_04;
    self notify("flashed");
    self.var_3D48 = gettime() + var_09 * 1000;
    self shellshock("flashbang", var_09);
    self lightsetoverrideenableforplayer("flashed", 0.1);
    common_scripts\utility::func_3C8F("player_flashed");
    thread lib_0322::func_A01C(var_09);
    wait(0.1);
    self method_83C8(var_09 - 0.1);
    if(var_01 * var_02 > 0.5) {
      thread lib_0321::func_3D55(var_09);
    }

    if(var_09 > 2) {
      thread lib_0321::func_3D58(0.75);
    } else {
      thread lib_0321::func_3D58(0.25);
    }

    if(var_04 != "allies") {
      thread lib_0321::func_3D56(var_09, var_04);
    }
  }
}

lib_0321::func_3D56(param_00, param_01) {
  wait 0.05;
  var_02 = function_00CB("allies");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(distancesquared(var_02[var_03].var_0116, self.var_0116) < 122500) {
      var_04 = param_00 + randomfloatrange(-1000, 1500);
      if(var_04 > 4.5) {
        var_04 = 4.5;
      } else if(var_04 < 0.25) {
        continue;
      }

      var_05 = gettime() + var_04 * 1000;
      if(!isDefined(var_02[var_03].var_3D48) || var_02[var_03].var_3D48 < var_05) {
        var_02[var_03].var_3D4A = param_01;
        var_02[var_03] lib_0321::func_3D44(var_04);
      }
    }
  }
}

lib_0321::func_7DD3() {
  common_scripts\_createfx::func_7DCD();
}

lib_0321::func_6F22(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 common_scripts\utility::func_6F21();
      }

      return;
    }

    return;
  }

  foreach(var_06 in level.var_2804) {
    if(!isDefined(var_06.var_A265["exploder"])) {
      continue;
    }

    if(var_06.var_A265["exploder"] != param_00) {
      continue;
    }

    var_06 common_scripts\utility::func_6F21();
  }
}

lib_0321::func_7DD4(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 lib_0321::func_7DD3();
      }

      return;
    }

    return;
  }

  foreach(var_06 in level.var_2804) {
    if(!isDefined(var_06.var_A265["exploder"])) {
      continue;
    }

    if(var_06.var_A265["exploder"] != param_00) {
      continue;
    }

    var_06 lib_0321::func_7DD3();
  }
}

lib_0321::func_44F6(param_00) {
  var_01 = [];
  if(isDefined(level.var_2802)) {
    var_02 = level.var_2802[param_00];
    if(isDefined(var_02)) {
      var_01 = var_02;
    }
  } else {
    for(var_03 = 0; var_03 < level.var_2804.size; var_03++) {
      if(level.var_2804[var_03].var_A265["fxid"] == param_00) {
        var_01[var_01.size] = level.var_2804[var_03];
      }
    }
  }

  return var_01;
}

lib_0321::func_5095(param_00) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");
  if(param_00) {
    self.var_6A4E = self getthreatbiasgroup();
    var_01 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_02 = [];
    var_02["axis"] = "allies";
    var_02["allies"] = "axis";
    var_03 = function_00CB(var_02[self.var_01A7]);
    var_04 = [];
    for(var_05 = 0; var_05 < var_03.size; var_05++) {
      var_04[var_03[var_05] getthreatbiasgroup()] = 1;
    }

    var_06 = getarraykeys(var_04);
    for(var_05 = 0; var_05 < var_06.size; var_05++) {
      setthreatbias(var_06[var_05], "ignore_everybody", 0);
    }

    return;
  }

  var_01 = undefined;
  if(self.var_6A4E != "") {
    self setthreatbiasgroup(self.var_6A4E);
  }

  self.var_6A4E = undefined;
}

lib_0321::func_A302() {
  lib_032A::func_A380();
}

lib_0321::func_A39A() {
  thread lib_032A::func_A39B();
}

lib_0321::func_A358(param_00) {
  lib_032A::func_A35A(param_00);
}

lib_0321::func_A360(param_00) {
  lib_032A::func_A361(param_00);
}

lib_0321::func_A313(param_00, param_01) {
  lib_0323::func_A381(param_00, param_01);
}

lib_0321::func_4883(param_00) {
  return bulletTrace(param_00, param_00 + (0, 0, -100000), 0, self)["position"];
}

lib_0321::func_20B9(param_00) {
  self.var_729D = self.var_729D + param_00;
  self notify("update_health_packets");
  if(self.var_729D >= 3) {
    self.var_729D = 3;
  }
}

lib_0321::func_4714(param_00) {
  var_01 = lib_0321::func_4715(param_00);
  return var_01[0];
}

lib_0321::func_4715(param_00) {
  return lib_032A::func_063F(param_00);
}

lib_0321::func_2D90(param_00, param_01, param_02, param_03, param_04, param_05) {
  lib_0321::func_0967();
  if(!isDefined(level.var_91E2)) {
    level.var_91E2 = [];
  }

  level.var_91E2[param_00] = lib_0321::func_0968(param_00, param_01, param_02, param_03, [param_04], param_05);
}

lib_0321::func_0966(param_00, param_01, param_02, param_03, param_04, param_05) {
  lib_0321::func_0967();
  param_00 = tolower(param_00);
  if(isDefined(param_04)) {
    if(param_04.size > 2) {
      var_06 = [];
      var_06[0] = param_04[0];
      var_06[1] = param_04[1];
      param_04 = var_06;
    }

    if(!isDefined(level.var_929E)) {
      level.var_929E = [];
    }

    foreach(var_08 in param_04) {
      if(!common_scripts\utility::func_0F79(level.var_929E, var_08)) {
        level.var_929E[level.var_929E.size] = var_08;
      }
    }
  }

  if(isDefined(level.var_91E2) && isDefined(level.var_91E2[param_00])) {
    var_0B = level.var_91E2[param_00];
  } else {
    var_0B = lib_0321::func_0968(param_01, param_02, param_03, param_04, param_05, var_0B);
  }

  if(!isDefined(param_01)) {
    if(!isDefined(level.var_91E2)) {} else if(!issubstr(param_00, "no_game")) {
      if(!isDefined(level.var_91E2[param_00])) {
        return;
      }
    }
  }

  level.var_9210[level.var_9210.size] = var_0B;
  level.var_918B[param_00] = var_0B;
}

lib_0321::func_096A(param_00, param_01, param_02, param_03) {
  if(isDefined(param_01)) {
    level.var_918B[param_00]["visionset"] = param_01;
  }

  if(isDefined(param_02)) {
    level.var_918B[param_00]["lightset"] = param_02;
  }

  if(isDefined(param_03)) {
    level.var_918B[param_00]["clut"] = param_03;
  }
}

lib_0321::func_8594(param_00, param_01) {
  if(!isDefined(level.var_918B)) {
    return;
  }

  if(!isDefined(level.var_918B[param_00])) {
    return;
  }

  param_00 = tolower(param_00);
  if(param_01.size > 2) {
    var_02 = [];
    var_02[0] = param_01[0];
    var_02[1] = param_01[1];
    param_01 = var_02;
  }

  if(!isDefined(level.var_929E)) {
    level.var_929E = [];
  }

  foreach(var_04 in param_01) {
    if(!common_scripts\utility::func_0F79(level.var_929E, var_04)) {
      level.var_929E[level.var_929E.size] = var_04;
    }
  }

  level.var_918B[param_00]["transients_to_load"] = param_01;
}

lib_0321::func_55C4() {
  return issubstr(level.var_9267, "no_game");
}

lib_0321::func_0968(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  var_06["name"] = param_00;
  var_06["start_func"] = param_01;
  var_06["start_loc_string"] = param_02;
  var_06["logic_func"] = param_03;
  var_06["transients_to_load"] = param_04;
  var_06["catchup_function"] = param_05;
  return var_06;
}

lib_0321::func_0967() {
  if(!isDefined(level.var_9210)) {
    level.var_9210 = [];
  }
}

lib_0321::func_5CB3() {
  return level.var_9210.size > 1;
}

lib_0321::func_845D(param_00) {
  level.var_2BB9 = param_00;
}

lib_0321::func_2BB8(param_00) {
  level.var_2BB8 = param_00;
}

lib_0321::func_5D9B(param_00, param_01, param_02, param_03) {
  thread lib_0322::func_5D9C(param_00, param_01, param_02, param_03);
}

lib_0321::func_AA4B(param_00, param_01, param_02, param_03) {
  var_04 = vectornormalize((param_02[0], param_02[1], 0) - (param_00[0], param_00[1], 0));
  var_05 = anglesToForward((0, param_01[1], 0));
  return vectordot(var_05, var_04) >= param_03;
}

lib_0321::func_415F(param_00, param_01, param_02) {
  var_03 = vectornormalize(param_02 - param_00);
  var_04 = anglesToForward(param_01);
  var_05 = vectordot(var_04, var_03);
  return var_05;
}

lib_0321::func_AA4D(param_00, param_01) {
  var_02 = undefined;
  for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
    var_04 = level.var_744A[var_03] getEye();
    var_02 = common_scripts\utility::func_AA4A(var_04, level.var_744A[var_03] getangles(), param_00, param_01);
    if(!var_02) {
      return 0;
    }
  }

  return 1;
}

lib_0321::func_A643(param_00, param_01) {
  var_02 = param_01 * 1000 - gettime() - param_00;
  var_02 = var_02 * 0.001;
  if(var_02 > 0) {
    wait(var_02);
  }
}

lib_0321::func_1673() {
  anim.var_8319 = gettime();
}

lib_0321::func_2EC5(param_00) {
  if(!isDefined(level.var_6F46)) {
    level.var_6F46 = 0;
  }

  level.var_6F46++;
  if(self == level) {
    var_01 = level.var_721C;
  } else {
    var_01 = self;
  }

  if(isDefined(var_01.var_2A3F) && lib_02A8::func_95FE(var_01)) {
    level notify("dialogue started");
  }

  var_02 = getsndaliasvalue(param_00, "squelchname");
  if(self == level || (isDefined(var_02) && var_02 != "") || isDefined(level.var_721C) && self == level.var_721C) {
    if(isDefined(lib_037B::func_77D8())) {
      lib_037B::func_8DB8(1);
    }

    lib_0321::func_78B4(param_00, undefined, var_02);
    if(isDefined(lib_037B::func_77D8())) {
      lib_037B::func_8DB8(0);
    }

    level.var_6F46--;
    return;
  }

  lib_0321::func_1673();
  if(var_01 != level.var_721C && !isDefined(self.var_0EC4) || !isDefined(level.var_80D2[self.var_0EC4]) || !isDefined(level.var_80D2[self.var_0EC4][param_00])) {
    animscripts\face::func_7497("auto", param_00, 1, param_00);
    var_03 = 0;
  } else {
    lib_0293::func_0E76(self, param_00);
  }

  level.var_6F46--;
}

lib_0321::func_2EC7(param_00, param_01) {
  var_02 = getsndaliasvalue(param_00, "squelchname");
  if(self == level || (isDefined(var_02) && var_02 != "") || isDefined(level.var_721C) && self == level.var_721C) {
    if(isDefined(lib_037B::func_77D8())) {
      lib_037B::func_8DB8(1);
    }

    lib_0321::func_78B4(param_00, undefined, var_02);
    if(isDefined(lib_037B::func_77D8())) {
      lib_037B::func_8DB8(0);
    }

    return;
  }

  thread lib_0290::func_0AD1(param_01, 1);
  lib_0321::func_1673();
  lib_0293::func_0E76(self, param_00);
  thread lib_0290::func_0AD1(param_01, 0);
}

lib_0321::func_4020(param_00, param_01) {
  lib_0321::func_1673();
  lib_0293::func_0E0E(self, param_00, undefined, undefined, param_01);
}

lib_0321::func_78B4(param_00, param_01, param_02) {
  if(!isDefined(level.var_7306)) {
    var_03 = spawn("script_origin", (0, 0, 0));
    var_03 linkto(level.var_721C, "", (0, 0, 0), (0, 0, 0));
    level.var_7306 = var_03;
  }

  lib_0321::func_1673();
  if(!isDefined(param_01)) {
    return level.var_7306 lib_0321::func_3F12(::lib_0321::func_78B9, param_00, param_02);
  }

  return level.var_7306 lib_0321::func_3F18(param_01, ::lib_0321::func_78B9, param_00, param_02);
}

lib_0321::func_78B9(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "none";
  }

  level.var_7308 = 0;
  if(param_01 != "none" && isDefined(level.var_80D1["squelches"][param_01])) {
    lib_0321::func_71AC(level.var_80D1["squelches"][param_01]["on"], undefined, 1);
  }

  var_02 = 0;
  level.var_721C notify(param_00);
  if(isDefined(level.var_80D1[param_00])) {
    var_02 = lib_0321::func_71AC(level.var_80D1[param_00], undefined, 1);
  } else {
    var_02 = lib_0321::func_71AC(param_00, undefined, 1);
  }

  if(param_01 != "none" && isDefined(level.var_80D1["squelches"][param_01])) {
    thread lib_0321::func_78C1(param_01);
  }

  return var_02;
}

lib_0321::func_78B7(param_00) {
  if(!isDefined(level.var_7307)) {
    level.var_7307 = [];
  }

  var_01 = spawn("script_origin", (0, 0, 0));
  level.var_7307[level.var_7307.size] = var_01;
  var_01 endon("death");
  thread lib_0321::func_2D1A(var_01, "sounddone");
  var_01.var_0116 = level.var_7306.var_0116;
  var_01.var_001D = level.var_7306.var_001D;
  var_01 linkto(level.var_7306);
  var_01 method_8617(level.var_80D1[param_00], "sounddone");
  if(!isDefined(lib_0322::func_A65C(var_01))) {
    var_01 method_8614();
  }

  wait 0.05;
  level.var_7307 = common_scripts\utility::func_0F93(level.var_7307, var_01);
  var_01 delete();
}

lib_0321::func_78BE() {
  if(!isDefined(level.var_7306)) {
    return;
  }

  level.var_7306 delete();
}

lib_0321::func_78B8() {
  if(!isDefined(level.var_7307)) {
    return;
  }

  foreach(var_01 in level.var_7307) {
    if(isDefined(var_01)) {
      var_01 method_8614();
      wait 0.05;
      var_01 delete();
    }
  }

  level.var_7307 = undefined;
}

lib_0321::func_78B5() {
  if(!isDefined(level.var_7306)) {
    return;
  }

  level.var_7306 lib_0321::func_3F14();
}

lib_0321::func_78BC(param_00) {
  if(!isDefined(level.var_7306)) {
    return;
  }

  if(!isDefined(level.var_7306.var_3F12)) {
    return;
  }

  var_01 = [];
  var_02 = 0;
  var_03 = level.var_7306.var_3F12.size;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    if(var_04 == 0 && isDefined(level.var_7306.var_3F12[0].var_3F15) && isDefined(level.var_7306.var_3F12[0].var_3F15)) {
      var_01[var_01.size] = level.var_7306.var_3F12[var_04];
      continue;
    }

    if(isDefined(level.var_7306.var_3F12[var_04].var_6E55) && level.var_7306.var_3F12[var_04].var_6E55 == param_00) {
      level.var_7306.var_3F12[var_04] notify("death");
      level.var_7306.var_3F12[var_04] = undefined;
      var_02 = 1;
      continue;
    }

    var_01[var_01.size] = level.var_7306.var_3F12[var_04];
  }

  if(var_02) {
    level.var_7306.var_3F12 = var_01;
  }
}

lib_0321::func_78B6(param_00) {
  if(!isDefined(level.var_7306)) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01 linkto(level.var_721C, "", (0, 0, 0), (0, 0, 0));
    level.var_7306 = var_01;
  }

  level.var_7306 lib_0321::func_71AC(level.var_80D1[param_00], undefined, 1);
}

lib_0321::func_78BD(param_00) {
  return lib_0321::func_78B4(param_00, 0.05);
}

lib_0321::func_8CD3(param_00, param_01) {
  var_02 = getsndaliasvalue(param_00, "squelchname");
  lib_0322::func_097A(param_00);
  lib_0321::func_78B4(param_00, param_01, var_02);
}

lib_0321::func_8CD4(param_00) {
  lib_0322::func_097A(param_00);
  lib_0321::func_78BE();
  lib_0321::func_78B6(param_00);
}

lib_0321::func_8CD5(param_00) {
  lib_0322::func_097A(param_00);
  lib_0321::func_78B7(param_00);
}

lib_0321::func_8CD0(param_00) {
  lib_0322::func_0977(param_00);
  lib_0321::func_2EC5(param_00);
}

lib_0321::func_8CD1(param_00) {
  lib_0322::func_0978(param_00);
  lib_0321::func_4020(param_00);
}

lib_0321::func_78C1(param_00, param_01) {
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0.1;
  }

  level.var_7308 = 1;
  wait(param_01);
  if(isDefined(level.var_7306) && level.var_7308 == 1) {
    level.var_7306 lib_0321::func_3F12(::lib_0321::func_71AC, level.var_80D1["squelches"][param_00]["off"], undefined, 1);
  }
}

lib_0321::func_78BA(param_00, param_01) {
  lib_0321::func_78B4(param_00, undefined, param_01);
}

lib_0321::func_4D8D(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  if(isDefined(param_01) && param_01 == 1) {
    var_03.var_1739 = newhudelem();
  }

  var_03.var_35D5 = newhudelem();
  var_03 lib_0321::func_4DA1(param_02);
  var_03.var_35D5 settext(param_00);
  return var_03;
}

lib_0321::func_4D92() {
  self notify("death");
  if(isDefined(self.var_35D5)) {
    self.var_35D5 destroy();
  }

  if(isDefined(self.var_1739)) {
    self.var_1739 destroy();
  }
}

lib_0321::func_4DA1(param_00) {
  if(level.var_258F) {
    self.var_35D5.var_009B = 2;
  } else {
    self.var_35D5.var_009B = 1.6;
  }

  self.var_35D5.var_01D3 = 0;
  self.var_35D5.var_01D7 = -40;
  self.var_35D5.var_0010 = "center";
  self.var_35D5.var_0011 = "bottom";
  self.var_35D5.var_00C6 = "center";
  self.var_35D5.var_01CA = "middle";
  self.var_35D5.var_0184 = 1;
  self.var_35D5.var_0018 = 0.8;
  if(!isDefined(self.var_1739)) {
    return;
  }

  self.var_1739.var_01D3 = 0;
  self.var_1739.var_01D7 = -40;
  self.var_1739.var_0010 = "center";
  self.var_1739.var_0011 = "middle";
  self.var_1739.var_00C6 = "center";
  self.var_1739.var_01CA = "middle";
  self.var_1739.var_0184 = -1;
  if(level.var_258F) {
    self.var_1739 setshader("popmenu_bg", 650, 52);
  } else {
    self.var_1739 setshader("popmenu_bg", 650, 42);
  }

  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  self.var_1739.var_0018 = param_00;
}

lib_0321::func_945F(param_00) {
  return "" + param_00;
}

lib_0321::func_561B(param_00) {
  var_01 = float(param_00);
  if(function_02C6(param_00, " ")) {
    while(function_02C6(param_00, " ")) {
      param_00 = getsubstr(param_00, 1, 9999);
    }
  }

  if(function_02C6(param_00, "-.") || function_02C6(param_00, ".")) {
    param_00 = "0" + lib_0321::func_945F(param_00);
  }

  if(issubstr(param_00, ".")) {
    while(isendstr(param_00, "0")) {
      param_00 = function_02FF(param_00, "0");
    }
  } else {
    param_00 = lib_0321::func_945F(param_00);
  }

  return lib_0321::func_945F(var_01) == param_00;
}

lib_0321::func_5099(param_00, param_01) {
  setignoremegroup(param_00, param_01);
  setignoremegroup(param_01, param_00);
}

lib_0321::func_092D(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_05["function"] = param_01;
  var_05["param1"] = param_02;
  var_05["param2"] = param_03;
  var_05["param3"] = param_04;
  level.var_8FB8[param_00][level.var_8FB8[param_00].size] = var_05;
}

lib_0321::func_7C91(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < level.var_8FB8[param_00].size; var_03++) {
    if(level.var_8FB8[param_00][var_03]["function"] != param_01) {
      var_02[var_02.size] = level.var_8FB8[param_00][var_03];
    }
  }

  level.var_8FB8[param_00] = var_02;
}

lib_0321::func_38E2(param_00, param_01) {
  if(!isDefined(level.var_8FB8)) {
    return 0;
  }

  for(var_02 = 0; var_02 < level.var_8FB8[param_00].size; var_02++) {
    if(level.var_8FB8[param_00][var_02]["function"] == param_01) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_7CB5(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_8FB9) {
    if(var_03["function"] == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  self.var_8FB9 = var_01;
}

lib_0321::func_0961(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in self.var_8FB9) {
    if(var_07["function"] == param_00) {
      return;
    }
  }

  var_09 = [];
  var_09["function"] = param_00;
  var_09["param1"] = param_01;
  var_09["param2"] = param_02;
  var_09["param3"] = param_03;
  var_09["param4"] = param_04;
  var_09["param5"] = param_05;
  self.var_8FB9[self.var_8FB9.size] = var_09;
}

lib_0321::func_091B(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in self.var_2A87) {
    if(var_07["function"] == param_00) {
      return;
    }
  }

  var_09 = [];
  var_09["function"] = param_00;
  var_09["param1"] = param_01;
  var_09["param2"] = param_02;
  var_09["param3"] = param_03;
  var_09["param4"] = param_04;
  var_09["param5"] = param_05;
  self.var_2A87[self.var_2A87.size] = var_09;
}

lib_0321::func_0F7B(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    param_00[var_01] delete();
  }
}

lib_0321::func_0F87(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    param_00[var_01] method_805A();
  }
}

lib_0321::func_5093(param_00) {
  self endon("death");
  self.var_00D3 = 1;
  if(isDefined(param_00)) {
    wait(param_00);
  } else {
    wait(0.5);
  }

  self.var_00D3 = 0;
}

lib_0321::func_08A3(param_00) {
  var_01 = getent(param_00, "targetname");
  if(isDefined(var_01)) {
    var_01 lib_0321::func_089F();
  }
}

lib_0321::func_08A2(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  if(isDefined(var_01)) {
    var_01 lib_0321::func_089F();
  }
}

lib_0321::func_2F68(param_00) {
  var_01 = getent(param_00, "targetname");
  var_01 common_scripts\utility::func_9D9F();
}

lib_0321::func_2F67(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 common_scripts\utility::func_9D9F();
}

lib_0321::func_364F(param_00) {
  var_01 = getent(param_00, "targetname");
  var_01 common_scripts\utility::func_9DA3();
}

lib_0321::func_364E(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 common_scripts\utility::func_9DA3();
}

lib_0321::func_5590() {
  return isDefined(level.var_4CB5[lib_0321::func_4067()]);
}

lib_0321::func_4067() {
  if(!isDefined(self.var_A01E)) {
    lib_0321::func_8402();
  }

  return self.var_A01E;
}

lib_0321::func_8402() {
  self.var_A01E = "ai" + level.var_0AB5;
  level.var_0AB5++;
}

lib_0321::func_5FAA() {
  level.var_4CB5[self.var_A01E] = 1;
}

lib_0321::func_A03B() {
  level.var_4CB5[self.var_A01E] = undefined;
}

lib_0321::func_41C2() {
  var_00 = [];
  var_01 = function_00CB("allies");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] lib_0321::func_5590()) {
      var_00[var_00.size] = var_01[var_02];
    }
  }

  return var_00;
}

lib_0321::func_85A2(param_00, param_01) {
  var_02 = function_00CB(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_02[var_03].var_0118 = param_01;
  }
}

lib_0321::func_7C7F(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

lib_0321::func_7C92(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] lib_0321::func_5590()) {
      continue;
    }

    var_01[var_01.size] = param_00[var_02];
  }

  return var_01;
}

lib_0321::func_7C7B(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    if(!isDefined(var_04.var_81AD)) {
      continue;
    }

    if(var_04.var_81AD == param_01) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

lib_0321::func_7CA8(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    if(!isDefined(var_04.var_0165)) {
      continue;
    }

    if(var_04.var_0165 == param_01) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

lib_0321::func_40F8(param_00, param_01) {
  var_02 = lib_0321::func_419E("allies", param_00);
  var_02 = lib_0321::func_7C92(var_02);
  if(!isDefined(param_01)) {
    var_03 = level.var_721C.var_0116;
  } else {
    var_03 = var_02;
  }

  return common_scripts\utility::func_4461(var_03, var_02);
}

lib_0321::func_7CC6(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(!issubstr(param_00[var_03].var_003A, param_01)) {
      continue;
    }

    var_02[var_02.size] = param_00[var_03];
  }

  return var_02;
}

lib_0321::func_7CC7(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(!issubstr(param_00[var_03].var_0106, param_01)) {
      continue;
    }

    var_02[var_02.size] = param_00[var_03];
  }

  return var_02;
}

lib_0321::func_40F9(param_00, param_01, param_02) {
  var_03 = lib_0321::func_419E("allies", param_00);
  var_03 = lib_0321::func_7C92(var_03);
  if(!isDefined(param_02)) {
    var_04 = level.var_721C.var_0116;
  } else {
    var_04 = var_03;
  }

  var_03 = lib_0321::func_7CC6(var_03, param_01);
  return common_scripts\utility::func_4461(var_04, var_03);
}

lib_0321::func_7774(param_00, param_01) {
  for(;;) {
    var_02 = lib_0321::func_40F8(param_00);
    if(!isalive(var_02)) {
      wait(1);
      continue;
    }

    var_02 lib_0321::func_84A1(param_01);
  }
}

lib_0321::func_53E4(param_00, param_01) {
  for(;;) {
    var_02 = lib_0321::func_40F8(param_00);
    if(!isalive(var_02)) {
      return;
    }

    var_02 lib_0321::func_84A1(param_01);
  }
}

lib_0321::func_53E5(param_00, param_01, param_02) {
  for(;;) {
    var_03 = lib_0321::func_40F9(param_00, param_02);
    if(!isalive(var_03)) {
      return;
    }

    var_03 lib_0321::func_84A1(param_01);
  }
}

lib_0321::func_7775(param_00, param_01, param_02) {
  for(;;) {
    var_03 = lib_0321::func_40F9(param_00, param_02);
    if(!isalive(var_03)) {
      wait(1);
      continue;
    }

    var_03 lib_0321::func_84A1(param_01);
  }
}

lib_0321::func_7E97(param_00) {
  self method_818E("face angle", param_00);
  self.var_00EE = 1;
}

lib_0321::func_7E98() {
  self.var_00EE = 0;
}

lib_0321::func_53E7(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = [];
  for(var_05 = 0; var_05 < param_00.size; var_05++) {
    var_06 = param_00[var_05];
    if(var_03 || !issubstr(var_06.var_003A, param_02)) {
      var_04[var_04.size] = var_06;
      continue;
    }

    var_03 = 1;
    var_06 lib_0321::func_84A1(param_01);
  }

  return var_04;
}

lib_0321::func_53E6(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_05 = param_00[var_04];
    if(var_02) {
      var_03[var_03.size] = var_05;
      continue;
    }

    var_02 = 1;
    var_05 lib_0321::func_84A1(param_01);
  }

  return var_03;
}

lib_0321::func_A65B(param_00) {
  lib_0322::func_A660(param_00, "script_noteworthy");
}

lib_0321::func_A65E(param_00) {
  lib_0322::func_A660(param_00, "targetname");
}

lib_0321::func_A64C(param_00, param_01) {
  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  level endon(param_00);
  wait(param_01);
}

lib_0321::func_A652(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

lib_0321::func_A661(param_00) {
  self endon("trigger");
  wait(param_00);
}

lib_0321::func_A648(param_00, param_01) {
  var_02 = spawnStruct();
  var_03 = [];
  var_03 = common_scripts\utility::func_0F73(var_03, getEntArray(param_00, "targetname"));
  var_03 = common_scripts\utility::func_0F73(var_03, getEntArray(param_01, "targetname"));
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_02 thread lib_0322::func_37B0(var_03[var_04]);
  }

  var_02 waittill("done");
}

lib_0321::func_3441(param_00) {
  var_01 = lib_02FC::func_904F(param_00);
  return var_01;
}

lib_0321::func_3440(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  var_01 = lib_02FC::func_904F(param_00);
  var_01[[level.var_3431]]();
  var_01.var_8FB8 = param_00.var_8FB9;
  var_01 thread lib_02FC::func_7F71();
  var_01.var_0186 = param_00;
  return var_01;
}

lib_0321::func_9531(param_00) {
  return lib_02FC::func_9056(param_00);
}

lib_0321::func_9532(param_00) {
  return lib_02FC::func_9058(param_00);
}

lib_0321::func_845C() {
  if(lib_0290::func_0AAE() && self.var_01B9 != "dog" && self.var_01B9 != "civilian") {
    self.var_011E = animscripts\shg_asm\soldier\common\shared::func_428A();
    self.var_011D = animscripts\shg_asm\soldier\common\shared::func_4289();
    return;
  }

  self.var_011E = 192;
  self.var_011D = 192;
}

lib_0321::func_2714(param_00) {
  if(param_00 == "on") {
    lib_0321::func_3612();
    return;
  }

  lib_0321::func_2F2B();
}

lib_0321::func_3612() {
  if(self.var_01B9 == "dog" || self.var_01B9 == "civilian") {
    return;
  }

  lib_0290::func_0AD4("walk");
}

lib_0321::func_2F2B() {
  lib_0290::func_0AD4("none");
}

lib_0321::func_3641() {
  lib_0321::func_3612();
  var_00 = "sneak";
  if(animscripts\shg_asm\soldier\common\shared::func_560C()) {
    var_00 = "smg_sneak";
  }

  lib_0290::func_0AD3(var_00);
}

lib_0321::func_2F5A() {
  lib_0321::func_2F2B();
  lib_0290::func_0AC3();
}

lib_0321::func_3624() {
  if(self.var_01B9 == "dog" || self.var_01B9 == "civilian") {
    return;
  }

  lib_0290::func_0ACF(1);
}

lib_0321::func_2F3B() {
  if(self.var_01B9 == "dog" || self.var_01B9 == "civilian") {
    return;
  }

  lib_0290::func_0ACF(0);
}

lib_0321::func_3640() {
  if(self.var_01B9 == "dog") {
    return;
  }

  lib_0290::func_0A9E(1);
}

lib_0321::func_2F59() {
  if(self.var_01B9 == "dog") {
    return;
  }

  lib_0290::func_0A9E(0);
}

lib_0321::func_363C() {
  self.var_1DC6 = 1;
}

lib_0321::func_2F56() {
  self.var_1DC6 = undefined;
}

lib_0321::func_270E(param_00) {
  if(!isDefined(param_00)) {
    self.var_2712 = undefined;
    return;
  }

  self.var_2712 = param_00;
  if(!isDefined(param_00.var_0116)) {}
}

lib_0321::func_84A3(param_00) {
  if(isDefined(param_00) && param_00) {
    self.var_3E2E = 1;
    return;
  }

  self.var_3E2E = undefined;
}

lib_0321::func_30BD(param_00, param_01, param_02, param_03) {
  if(isDefined(param_01)) {
    [[param_00]](param_01);
  } else {
    [[param_00]]();
  }

  if(isDefined(param_03)) {
    [[param_02]](param_03);
    return;
  }

  [[param_02]]();
}

lib_0321::func_83D7(param_00, param_01) {
  if(isDefined(param_01)) {
    self notify(param_00, param_01);
    return;
  }

  self notify(param_00);
}

lib_0321::func_A743(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03 endon("complete");
  var_03 lib_0321::func_2CED(param_02, ::lib_0321::func_83D7, "complete");
  self waittillmatch(param_01, param_00);
  return param_00;
}

lib_0321::func_2D36(param_00) {
  param_00 notify("deleted");
  param_00 delete();
}

lib_0321::func_3C59(param_00) {
  if(!isDefined(self.var_9ABD)) {
    self.var_9ABD = [];
  }

  if(isDefined(self.var_9ABD[param_00.var_A01E])) {
    return 0;
  }

  self.var_9ABD[param_00.var_A01E] = 1;
  return 1;
}

lib_0321::func_4417(param_00) {
  return level.var_80C5[self.var_0EC4][param_00];
}

lib_0321::func_4B52(param_00) {
  return isDefined(level.var_80C5[self.var_0EC4][param_00]);
}

lib_0321::func_4418(param_00, param_01) {
  return level.var_80C5[param_01][param_00];
}

lib_0321::func_4419(param_00) {
  return level.var_80C5["generic"][param_00];
}

lib_0321::func_0930(param_00, param_01, param_02) {
  if(!isDefined(level.var_9D88)) {
    level.var_9D88 = [];
    level.var_9D87 = [];
  }

  level.var_9D88[param_00] = param_01;
  precachestring(param_01);
  if(isDefined(param_02)) {
    level.var_9D87[param_00] = param_02;
  }
}

lib_0321::func_8BCF(param_00) {
  thread lib_0322::func_8C00(param_00);
}

lib_0321::func_4CE6(param_00) {
  param_00.var_9A01 = 1;
}

lib_0321::func_3BCB(param_00, param_01) {
  var_02 = spawn("trigger_radius", param_00, 0, param_01, 48);
  for(;;) {
    var_02 waittill("trigger", var_03);
    level.var_721C dodamage(5, param_00);
  }
}

lib_0321::func_2412(param_00, param_01) {
  setthreatbias(param_00, param_01, 0);
  setthreatbias(param_01, param_00, 0);
}

lib_0321::func_99AA() {}

lib_0321::func_0F74(param_00, param_01) {
  if(!param_00.size) {
    return param_01;
  }

  var_02 = getarraykeys(param_01);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    param_00[var_02[var_03]] = param_01[var_02[var_03]];
  }

  return param_00;
}

lib_0321::func_84E5(param_00) {
  self.var_00D2 = param_00;
}

lib_0321::func_84C5(param_00) {
  self.var_00AE = param_00;
}

lib_0321::func_9E0A() {
  var_00 = self.var_3975;
  for(;;) {
    var_01 = self method_808D();
    if(lib_0321::func_8FA3(var_01)) {
      wait(1);
      continue;
    }

    return var_01;
  }
}

lib_0321::func_840B(param_00) {
  self.var_0013 = param_00;
}

lib_0321::func_8576(param_00, param_01, param_02) {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0AD5(param_00, param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self.var_0CB6 = param_01;
  } else {
    self.var_0CB6 = 1;
  }

  lib_0321::func_2F69();
  self.var_7F6A = level.var_80C5[self.var_0EC4][param_00];
  self.var_A7B7 = self.var_7F6A;
}

lib_0321::func_8474() {
  self.var_0794.var_64B0 = "walk";
  lib_0290::func_0ACD("arrivals", 0);
  lib_0290::func_0ACD("exits", 0);
  self.var_8244 = 1;
}

lib_0321::func_8439(param_00, param_01, param_02, param_03) {}

lib_0321::func_852F(param_00, param_01, param_02) {}

lib_0321::func_84B0(param_00) {
  var_01 = level.var_80C5["generic"][param_00];
  if(isarray(var_01)) {
    self.var_90D1 = var_01;
    return;
  }

  self.var_90D1[0] = var_01;
}

lib_0321::func_84E1(param_00) {
  var_01 = level.var_80C5[self.var_0EC4][param_00];
  if(isarray(var_01)) {
    self.var_90D1 = var_01;
    return;
  }

  self.var_90D1[0] = var_01;
}

lib_0321::func_23BB() {
  self.var_90D1 = undefined;
  self notify("stop_specialidle");
}

lib_0321::func_84B1(param_00, param_01) {
  lib_0321::func_84B2(param_00, undefined, param_01);
}

lib_0321::func_23BC() {
  self notify("movemode");
  lib_0321::func_3650();
  self.var_7F6A = undefined;
  self.var_A7B7 = undefined;
}

lib_0321::func_84B2(param_00, param_01, param_02) {
  self notify("movemode");
  if(!isDefined(param_02) || param_02) {
    self.var_0CB6 = 1;
  } else {
    self.var_0CB6 = undefined;
  }

  lib_0321::func_2F69();
  self.var_7F6A = level.var_80C5["generic"][param_00];
  self.var_A7B7 = self.var_7F6A;
  if(isDefined(param_01)) {
    self.var_7F69 = level.var_80C5["generic"][param_01];
    self.var_A7B6 = self.var_7F69;
    return;
  }

  self.var_7F69 = undefined;
  self.var_A7B6 = undefined;
}

lib_0321::func_8577(param_00, param_01, param_02) {
  self notify("movemode");
  if(!isDefined(param_02) || param_02) {
    self.var_0CB6 = 1;
  } else {
    self.var_0CB6 = undefined;
  }

  lib_0321::func_2F69();
  self.var_7F6A = level.var_80C5[self.var_0EC4][param_00];
  self.var_A7B7 = self.var_7F6A;
  if(isDefined(param_01)) {
    self.var_7F69 = level.var_80C5[self.var_0EC4][param_01];
    self.var_A7B6 = self.var_7F69;
    return;
  }

  self.var_7F69 = undefined;
  self.var_A7B6 = undefined;
}

lib_0321::func_23C9(param_00) {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0A79(param_00);
    return;
  }

  self notify("clear_run_anim");
  self notify("movemode");
  if(self.var_01B9 == "dog") {
    self.var_0794.var_64B0 = "run";
    lib_0290::func_0ACD("arrivals", 1);
    lib_0290::func_0ACD("exits", 1);
    self.var_8244 = undefined;
    return;
  }

  if(!isDefined(self.var_202F)) {
    lib_0321::func_3650();
  }

  self.var_0CB6 = undefined;
  self.var_7F6A = undefined;
  self.var_A7B7 = undefined;
  self.var_7F69 = undefined;
  self.var_A7B6 = undefined;
}

lib_0321::func_2B64(param_00, param_01) {
  setdvarifuninitialized(param_00, param_01);
  return getdvarfloat(param_00);
}

lib_0321::func_6FA8(param_00, param_01, param_02) {
  self endon("parked");
  self endon("death");
  self endon("stop_physicsjolt");
  if(!isDefined(param_00) || !isDefined(param_01) || !isDefined(param_02)) {
    param_00 = 400;
    param_01 = 256;
    param_02 = (0, 0, 0.075);
  }

  var_03 = param_00 * param_00;
  var_04 = 3;
  var_05 = param_02;
  for(;;) {
    wait(0.1);
    param_02 = var_05;
    if(self.var_003B == "script_vehicle") {
      var_06 = self method_8283();
      if(var_06 < var_04) {
        var_07 = var_06 / var_04;
        param_02 = var_05 * var_07;
      }
    }

    var_08 = distancesquared(self.var_0116, level.var_721C.var_0116);
    var_07 = var_03 / var_08;
    if(var_07 > 1) {
      var_07 = 1;
    }

    param_02 = param_02 * var_07;
    var_09 = param_02[0] + param_02[1] + param_02[2];
    if(var_09 > 0.025) {
      physicsradiusjitter(self.var_0116, param_00, param_01, param_02[2], param_02[2] * 2);
    }
  }
}

lib_0321::func_84BC(param_00) {
  self method_81A3(param_00);
}

lib_0321::func_089F(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    lib_0321::func_08A1(param_02);
    return;
  }

  common_scripts\utility::func_0FB2(getEntArray(param_00, param_01), ::lib_0321::func_08A1, param_02);
}

lib_0321::func_08A1(param_00) {
  self notify("trigger", param_00);
}

lib_0321::func_83BD() {
  self delete();
}

lib_0321::func_7CA5(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = param_00[var_02];
    if(var_03 lib_0321::func_4B29()) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

lib_0321::func_23AE() {
  lib_0321::func_23D0("axis");
  lib_0321::func_23D0("allies");
}

lib_0321::func_23D0(param_00) {
  level.var_292C[param_00]["r"] = undefined;
  level.var_292C[param_00]["b"] = undefined;
  level.var_292C[param_00]["c"] = undefined;
  level.var_292C[param_00]["y"] = undefined;
  level.var_292C[param_00]["p"] = undefined;
  level.var_292C[param_00]["o"] = undefined;
  level.var_292C[param_00]["g"] = undefined;
}

lib_0321::func_4314() {
  var_00 = [];
  var_00["r"] = (1, 0, 0);
  var_00["o"] = (1, 0.5, 0);
  var_00["y"] = (1, 1, 0);
  var_00["g"] = (0, 1, 0);
  var_00["c"] = (0, 1, 1);
  var_00["b"] = (0, 0, 1);
  var_00["p"] = (1, 0, 1);
  return var_00;
}

lib_0321::func_67F1(param_00, param_01) {
  self endon("death");
  if(param_01 > 0) {
    wait(param_01);
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(param_00);
}

lib_0321::func_48D9() {
  if(!isDefined(self.var_01D0) || self.var_01D0 == "none") {
    return;
  }

  if(isai(self)) {
    animscripts\shared::func_7008(self.var_01D0, "none");
    return;
  }

  if(!isDefined(self.var_48DA) && self.var_01D0 != "none") {
    self.var_48DA = 1;
    lib_0321::func_2E38(self.var_01D0);
    self method_802E(getweaponmodel(self.var_01D0), "tag_weapon_right");
  }
}

lib_0321::func_48D8() {
  if(isai(self)) {
    if(isDefined(self.var_5C10) && self.var_01D0 != self.var_5C10) {
      self.var_01D0 = self.var_5C10;
    }

    animscripts\shared::func_7008(self.var_01D0, "right");
    return;
  }

  if(isDefined(self.var_48DA)) {
    self.var_48DA = undefined;
    self attach(getweaponmodel(self.var_01D0), "tag_weapon_right");
    lib_0321::func_A0D9(self.var_01D0);
  }
}

lib_0321::func_A0D9(param_00) {
  if(isDefined(param_00) && param_00 != "none") {
    var_01 = function_029C(param_00);
    var_02 = common_scripts\utility::func_0F9A(var_01, 0);
    foreach(var_04 in var_02) {
      self attach(var_04["worldModel"], var_04["worldAttachTag"]);
    }

    self method_850A(param_00);
  }
}

lib_0321::func_2E38(param_00) {
  if(isDefined(param_00) && param_00 != "none") {
    var_01 = function_029C(param_00);
    var_02 = common_scripts\utility::func_0F9A(var_01, 0);
    foreach(var_04 in var_02) {
      self method_802E(var_04["worldModel"], var_04["worldAttachTag"], 0);
    }
  }
}

lib_0321::func_1136(param_00) {
  var_01 = level.var_721C getcurrentweapon();
  var_02 = function_029C(var_01);
  var_03 = var_02[0]["weapon"];
  var_04 = common_scripts\utility::func_0F9A(var_02, 0);
  param_00 attach(var_03, "TAG_WEAPON_RIGHT", 1);
  foreach(var_06 in var_04) {
    param_00 attach(var_06["attachment"], var_06["attachTag"]);
  }

  param_00 method_850A(var_01);
}

lib_0321::func_7004(param_00, param_01) {
  if(!animscripts\shared::func_0B59(param_00)) {
    animscripts\init::func_5368(param_00);
  }

  animscripts\shared::func_7008(param_00, param_01);
}

lib_0321::func_3E2F(param_00, param_01, param_02) {
  if(!animscripts\init::func_5853(param_00)) {
    animscripts\init::func_5368(param_00);
  }

  var_03 = self.var_01D0 != "none";
  var_04 = 0;
  var_05 = param_01 == "sidearm";
  var_06 = param_01 == "secondary";
  if(var_03 && var_04 != var_05) {
    if(var_04) {
      var_07 = "none";
    } else if(var_07) {
      var_07 = "back";
    } else {
      var_07 = "chest";
    }

    animscripts\shared::func_7008(self.var_01D0, var_07);
    self.var_5C10 = self.var_01D0;
  } else {
    self.var_5C10 = param_01;
  }

  animscripts\shared::func_7008(param_01, "right");
  if(var_06) {
    self.var_8C3C = param_01;
  } else if(var_07) {
    self.var_835A = param_01;
  } else {
    self.var_7704 = param_01;
  }

  self.var_01D0 = param_01;
  self.var_1D83 = weaponclipsize(self.var_01D0);
  animscripts\shg_asm\asm_init::func_1074(var_03);
  self notify("weapon_switch_done");
}

lib_0321::func_5C8D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  lib_0322::func_5C8F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, 0);
}

lib_0321::func_5C8E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  lib_0322::func_5C8F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, 1);
}

lib_0321::func_5C8B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  param_09 = lib_0321::func_429A();
  var_0A = spawn("script_origin", (0, 0, 0));
  var_0A.var_0116 = param_09.var_0116;
  var_0A.var_001D = param_09 getangles();
  if(isDefined(param_08) && param_08) {
    param_09 playerlinkto(var_0A, "", param_03, param_04, param_05, param_06, param_07, param_08);
  } else if(isDefined(param_04)) {
    param_09 playerlinkto(var_0A, "", param_03, param_04, param_05, param_06, param_07);
  } else if(isDefined(param_03)) {
    param_09 playerlinkto(var_0A, "", param_03);
  } else {
    param_09 playerlinkto(var_0A);
  }

  var_0A moveto(param_00, param_02, param_02 * 0.25);
  var_0A rotateto(param_01, param_02, param_02 * 0.25);
  wait(param_02);
  var_0A delete();
}

lib_0321::func_5C90(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  lib_0322::func_5C91(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, 0);
}

lib_0321::func_5C8C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = lib_0321::func_429A();
  var_0A = spawn("script_origin", (0, 0, 0));
  var_0A.var_0116 = var_09 lib_0321::func_4298();
  var_0A.var_001D = var_09 getangles();
  if(isDefined(param_08)) {
    var_09 playerlinktodelta(var_0A, "", param_03, param_04, param_05, param_06, param_07, param_08);
  } else if(isDefined(param_04)) {
    var_09 playerlinktodelta(var_0A, "", param_03, param_04, param_05, param_06, param_07);
  } else if(isDefined(param_03)) {
    var_09 playerlinktodelta(var_0A, "", param_03);
  } else {
    var_09 playerlinktodelta(var_0A);
  }

  var_0A moveto(param_00, param_02, param_02 * 0.25);
  var_0A rotateto(param_01, param_02, param_02 * 0.25);
  wait(param_02);
  var_0A delete();
}

lib_0321::func_8FCD(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_8FFC();
  var_03.var_0116 = self.var_0116;
  var_03.var_001D = self.var_001D;
  var_04 = self.var_01C9;
  if(isPlayer(self)) {
    var_03.var_001D = self getangles();
    var_04 = self getvelocity();
  }

  var_03 thread lib_0321::func_5C93(param_00, var_03.var_0116, var_04, param_01, param_02);
  return var_03;
}

lib_0321::func_5C93(param_00, param_01, param_02, param_03, param_04) {
  param_03 endon("death");
  self endon("death");
  var_05 = 0.05;
  var_06 = gettime();
  var_07 = var_06 + param_00 * 1000;
  var_08 = param_03.var_001D;
  var_09 = param_03.var_0116;
  if(isDefined(param_04)) {
    var_09 = param_03 gettagorigin(param_04);
  }

  var_0A = param_01;
  while(isDefined(self) && isDefined(param_03) && gettime() < var_07) {
    var_0B = float(gettime() - var_06) / float(var_07 - var_06);
    var_0B = 0.5 - cos(var_0B * 180) * 0.5;
    var_0C = param_03.var_0116;
    if(isDefined(param_04)) {
      var_0C = param_03 gettagorigin(param_04);
    }

    var_0D = var_0C - var_09 / var_05;
    var_0E = vectorlerp(param_02, var_0D, var_0B);
    var_0A = var_0A + var_0E * var_05;
    self.var_0116 = vectorlerp(var_0A, var_0C, var_0B);
    if(isDefined(param_04)) {
      self.var_001D = angleslerp(var_08, param_03 gettagangles(param_04), var_0B);
    }

    var_09 = var_0C;
    wait(var_05);
  }

  if(isDefined(param_04)) {
    self linkto(param_03, param_04, (0, 0, 0), (0, 0, 0));
    return;
  }

  self.var_0116 = param_03.var_0116;
}

lib_0321::func_72EC(param_00) {
  var_01 = level.var_721C.var_0116;
  for(;;) {
    if(distance(var_01, level.var_721C.var_0116) > param_00) {
      break;
    }

    wait 0.05;
  }
}

lib_0321::func_A733(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  thread lib_0322::func_A734(var_04, param_00, param_01);
  thread lib_0322::func_A734(var_04, param_02, param_03);
  var_04 waittill("done");
}

lib_0321::func_A745(param_00) {
  self waittill(param_00);
}

lib_0321::func_2FF7(param_00, param_01, param_02, param_03, param_04) {
  var_05 = lib_0321::func_429A();
  if(isDefined(level.var_9D87[param_00])) {
    if(var_05[[level.var_9D87[param_00]]]()) {
      return;
    }

    var_05 thread lib_0322::func_4DC2(level.var_9D88[param_00], param_00, level.var_9D87[param_00], param_01, param_02, param_03, undefined, undefined, param_04);
    return;
  }

  var_05 thread lib_0322::func_4DC2(level.var_9D88[param_00], param_00, undefined, undefined, undefined, undefined, undefined, undefined, param_04);
}

lib_0321::func_4DBC(param_00, param_01, param_02, param_03, param_04, param_05) {
  lib_0322::func_4DBD(param_00);
  if(!isDefined(param_01)) {
    lib_0321::func_2FF7(param_00, param_02, param_03, param_04, param_05);
    return;
  }

  lib_0321::func_2FFB(param_00, param_01, param_02, param_03, param_04, param_05);
}

lib_0321::func_4DBF(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = lib_0321::func_429A();
  if(var_06[[level.var_9D87[param_00]]]()) {
    return;
  }

  lib_0322::func_4DBD(param_00);
  var_06 thread lib_0322::func_4DC2(level.var_9D88[param_00], param_00, level.var_9D87[param_00], param_03, param_04, param_05, param_01, param_02);
}

lib_0321::func_0911(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_9D88)) {
    level.var_9D88 = [];
    level.var_9D87 = [];
  }

  level.var_9D88[param_00] = param_01;
  level.var_4D9B[param_00]["gamepad"] = param_01;
  level.var_4D9B[param_00]["pc"] = param_03;
  level.var_4D9B[param_00]["southpaw"] = param_04;
  level.var_4D9B[param_00]["pcBindings"] = param_05;
  precachestring(param_01);
  if(isDefined(param_03)) {
    precachestring(param_03);
  }

  if(isDefined(param_04)) {
    precachestring(param_04);
  }

  if(isDefined(param_05)) {
    foreach(var_07 in param_05) {
      precachestring(var_07);
    }
  }

  if(isDefined(param_02)) {
    level.var_9D87[param_00] = param_02;
  }
}

lib_0321::func_4B01() {
  if(!isDefined(level.var_4DB7)) {
    level.var_4DB7 = [];
  }

  for(;;) {
    level.var_4DB7 = common_scripts\utility::func_0FA0(level.var_4DB7);
    if(isDefined(level.var_4DB7) && isDefined(level.var_721C)) {
      foreach(var_01 in level.var_4DB7) {
        if(level.var_721C common_scripts\utility::func_55E0()) {
          var_01 sethintstring(var_01.var_4822);
          continue;
        }

        var_01 sethintstring(var_01.var_6F2C);
      }
    }

    wait(0.1);
  }
}

lib_0321::func_09B2(param_00, param_01) {
  if(!isDefined(level.var_4DB7)) {
    thread lib_0321::func_4B01();
    level.var_4DB7 = [];
  }

  var_02 = 0;
  foreach(var_04 in level.var_4DB7) {
    if(self == var_04) {
      var_04.var_4822 = param_00;
      var_04.var_6F2C = param_01;
      var_02 = 1;
      break;
    }
  }

  if(!var_02) {
    self.var_4822 = param_00;
    self.var_6F2C = param_01;
    level.var_4DB7 = common_scripts\utility::func_0F6F(level.var_4DB7, self);
  }
}

lib_0321::func_2FFB(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = lib_0321::func_429A();
  var_06 thread lib_0322::func_4DC2(level.var_9D88[param_00], param_00, level.var_9D87[param_00], param_02, param_03, param_04, param_01, undefined, param_05);
}

lib_0321::func_2FFC(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = lib_0321::func_429A();
  if(var_06[[level.var_9D87[param_00]]]()) {
    return;
  }

  var_06 thread lib_0322::func_4DC2(level.var_9D88[param_00], param_00, level.var_9D87[param_00], param_03, param_04, param_05, param_01, param_02);
}

lib_0321::func_2FF8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  var_0A = lib_0322::func_4DAA(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  thread lib_0321::func_2FF7(var_0A, param_07, param_08, param_09);
  thread lib_0322::func_4DAB(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

lib_0321::func_2FF9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  var_0B = lib_0322::func_4DAA(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
  thread lib_0321::func_2FFB(var_0B, param_01, param_08, param_09, param_0A);
  thread lib_0322::func_4DAB(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

lib_0321::func_2FFA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_08)) {
    param_08 = 0;
  }

  var_0C = lib_0322::func_4DAA(param_00, param_03, param_04, param_05, param_06, param_07, param_08);
  thread lib_0321::func_2FFC(var_0C, param_01, param_02, param_09, param_0A, param_0B);
  thread lib_0322::func_4DAB(param_00, param_03, param_04, param_05, param_06, param_07, param_08);
}

lib_0321::func_216F(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    return [[level.var_9D87[param_00]]](param_01, param_02, param_03);
  }

  if(isDefined(param_02)) {
    return [[level.var_9D87[param_00]]](param_01, param_02);
  }

  if(isDefined(param_01)) {
    return [[level.var_9D87[param_00]]](param_01);
  }

  return [[level.var_9D87[param_00]]]();
}

lib_0321::func_44FE(param_00) {
  return level.var_80C5["generic"][param_00];
}

lib_0321::func_360E() {
  self.var_8135 = 1;
}

lib_0321::func_2F26(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self.var_8135 = 0;
  self notify("stop_being_careful", param_00);
}

lib_0321::func_3643(param_00) {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0A8D(1, param_00);
    return;
  }

  self.var_9130 = 1;
}

lib_0321::func_2F5B() {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0A8D(0);
    return;
  }

  self.var_9130 = undefined;
}

lib_0321::func_2F24() {
  self.var_2F73 = 1;
}

lib_0321::func_360D() {
  self.var_2F73 = undefined;
}

lib_0321::func_8C45(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = -1;
  var_05 = [];
  foreach(var_07 in level.var_08C7) {
    if(isDefined(var_07) && isDefined(var_07.var_378F)) {
      var_08 = var_07.var_378F;
      var_09 = animscripts\shg_asm\soldier\common\shared::func_4339();
      var_0A = undefined;
      if(isDefined(param_02)) {
        var_0A = param_02;
      }

      var_0B = undefined;
      if(function_0296(param_00)) {
        var_0B = param_00;
      } else if(isai(param_00)) {
        var_0B = param_00 animscripts\shg_asm\soldier\common\aim_and_fire::func_4327();
      } else {
        var_0B = param_00.var_0116;
      }

      var_0C = undefined;
      if(function_0296(param_01)) {
        var_0C = param_01;
      } else if(isai(param_01)) {
        var_0C = param_01 method_8091();
      } else {
        var_0C = param_01.var_0116;
      }

      if(isDefined(var_0A) && distancesquared(var_0B, var_0C) > var_0A) {
        return [0, undefined];
      }

      var_0D = lib_02FA::func_4107(var_08.var_0116, var_0B, var_0C);
      var_0E = var_0D[0];
      var_0F = var_0D[1];
      var_10 = var_0D[2];
      if(var_0F > var_09) {
        continue;
      }

      var_11 = undefined;
      if(function_0296(param_00) && function_0296(param_01)) {
        var_11 = sighttracepassed(var_0B, var_0C, 0, undefined);
      } else if(function_0296(param_00) && !function_0296(param_01)) {
        var_11 = sighttracepassed(var_0B, var_0C, 0, undefined);
      } else if(!function_0296(param_00) && function_0296(param_01)) {
        if(isai(param_00)) {
          var_11 = param_00 lib_0321::func_1F23(var_0C);
        } else {
          var_11 = sighttracepassed(var_0B, var_0C, 0, undefined);
        }
      } else if(isai(param_00)) {
        var_11 = param_00 method_81B9(param_01);
      } else {
        var_11 = sighttracepassed(var_0B, var_0C, 0, undefined);
      }

      if(!var_11) {
        return [0, undefined];
      }

      var_12 = vectornormalize(var_08.var_0116 - var_0C);
      var_13 = vectornormalize(var_08.var_0116 - var_0B);
      if(vectordot(var_12, var_13) < 0 || distancesquared(var_0C, var_08.var_0116) < animscripts\shg_asm\soldier\common\shared::func_4338()) {
        var_05[var_05.size] = var_07;
      }
    }
  }

  if(var_06.size == 0) {
    return [1, undefined];
  }

  foreach(var_16 in var_06) {
    if(var_16.var_23D1 - gettime() > var_05) {
      var_05 = var_16.var_23D1 - gettime();
      var_04 = var_16;
    }
  }

  return [0, var_04];
}

lib_0321::func_23B4(param_00) {
  setDvar(param_00, "");
}

lib_0321::func_8491() {
  self.var_0098 = 1;
}

lib_0321::func_8490() {
  self.var_0098 = 0;
}

lib_0321::func_8F71(param_00, param_01) {
  self endon("death");
  common_scripts\utility::func_0161();
  if(!isDefined(self)) {
    return undefined;
  }

  if(!issubstr(self.var_003A, "actor")) {
    return undefined;
  }

  var_02 = isDefined(self.var_82A2) && common_scripts\utility::func_3C77("stealth_enabled");
  var_03 = undefined;
  if(isDefined(self.var_8173)) {
    var_03 = lib_0321::func_3440(self);
  } else if(isDefined(self.var_81B2) || isDefined(param_00)) {
    var_03 = self method_808E(var_02);
  } else {
    var_03 = self method_808D(var_02);
  }

  if(isDefined(param_01) && param_01 && isalive(var_03)) {
    var_03 lib_0321::func_5F6E();
  }

  if(!isDefined(self.var_8173)) {
    lib_0321::func_8FA3(var_03);
  }

  return var_03;
}

lib_0321::func_3F12(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07 thread lib_0322::func_3F16(self, param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  return lib_0322::func_3F1A(var_07);
}

lib_0321::func_3F18(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07 thread lib_0322::func_3F16(self, param_01, param_02, param_03, param_04, param_05, param_06);
  if(isDefined(var_07.var_3F15) || var_07 common_scripts\utility::func_A71A(param_00, "function_stack_func_begun") != "timeout") {
    return lib_0322::func_3F1A(var_07);
  }

  var_07 notify("death");
  return 0;
}

lib_0321::func_3F14() {
  var_00 = [];
  if(isDefined(self.var_3F12[0]) && isDefined(self.var_3F12[0].var_3F15)) {
    var_00[0] = self.var_3F12[0];
  }

  self.var_3F12 = undefined;
  self notify("clear_function_stack");
  waittillframeend;
  if(!var_00.size) {
    return;
  }

  if(!var_00[0].var_3F15) {
    return;
  }

  self.var_3F12 = var_00;
}

lib_0321::func_4034() {
  if(isDefined(self.var_4034)) {
    return;
  }

  self.var_7AC4 = self getorigin();
  self moveto(self.var_7AC4 + (0, 0, -10000), 0.2);
  self.var_4034 = 1;
}

lib_0321::func_4035() {
  if(!isDefined(self.var_4034)) {
    return;
  }

  self moveto(self.var_7AC4, 0.2);
  self waittill("movedone");
  self.var_4034 = undefined;
}

lib_0321::func_2F36() {
  if(isai(self)) {
    lib_0290::func_0ACD("exits", 0);
  }
}

lib_0321::func_361D() {
  if(isai(self)) {
    lib_0290::func_0ACD("exits", 1);
  }
}

lib_0321::func_2F69() {
  self.var_6818 = 1;
}

lib_0321::func_3650() {
  self.var_6818 = undefined;
}

lib_0321::func_2F1D() {
  if(isai(self)) {
    lib_0290::func_0ACD("arrivals", 0);
  }
}

lib_0321::func_3607() {
  self endon("death");
  waittillframeend;
  if(isai(self)) {
    lib_0290::func_0ACD("arrivals", 1);
  }
}

lib_0321::func_842A(param_00, param_01) {
  function_0072(param_00, param_01);
}

lib_0321::func_84C3(param_00) {
  self.var_00AE = param_00;
}

lib_0321::func_84C0(param_00) {
  self.var_5B49 = param_00;
  self.var_5B4A = undefined;
  self.var_5B48 = undefined;
  if(isDefined(param_00.var_01B9) && param_00.var_01B9 == "Turret" && !isDefined(getnodeturret(param_00))) {
    return;
  }

  self method_81A1(param_00);
}

lib_0321::func_84C1(param_00) {
  var_01 = getnode(param_00, "targetname");
  lib_0321::func_84C0(var_01);
}

lib_0321::func_84C2(param_00) {
  self.var_5B49 = undefined;
  self.var_5B4A = param_00;
  self.var_5B48 = undefined;
  self method_81A2(param_00);
}

lib_0321::func_84BA(param_00) {
  lib_0321::func_84C2(param_00.var_0116);
  self.var_5B48 = param_00;
}

lib_0321::func_41B0() {
  if(isDefined(self.var_5B4A)) {
    return self.var_5B4A;
  }

  if(isDefined(self.var_5B49)) {
    return self.var_5B49.var_0116;
  }

  if(isDefined(self.var_5B48)) {
    return self.var_5B48.var_0116;
  }

  if(isDefined(self.var_011F)) {
    return self.var_011F;
  }

  if(isDefined(self.var_00AD)) {
    return self.var_00AD;
  }

  return self.var_0116;
}

lib_0321::func_41AD() {
  if(isDefined(self.var_5B49)) {
    return self.var_5B49.var_001D;
  }

  if(isDefined(self.var_5B48)) {
    return self.var_5B48.var_001D;
  }

  return self.var_001D;
}

lib_0321::func_41AF() {
  var_00 = self.var_010D;
  if(!isDefined(var_00)) {
    if(isDefined(self.var_0139) && distancesquared(self.var_0139.var_0116, self.var_00AD) < 4) {
      return self.var_0139;
    }

    if(isDefined(self.var_5B48)) {
      return self.var_5B48;
    }

    if(isDefined(self.var_5B49)) {
      return self.var_5B49;
    }

    var_01 = lib_0321::func_41B0();
    if(isDefined(var_01)) {
      var_02 = lib_0321::func_41AD();
      var_00 = spawnStruct();
      var_00.var_0116 = var_01;
      var_00.var_001D = var_02;
    }
  }

  return var_00;
}

lib_0321::func_690B(param_00) {
  lib_0322::func_691F(param_00);
  objective_state(param_00, "done");
  level notify("objective_complete" + param_00);
}

lib_0321::func_4B0C(param_00, param_01, param_02, param_03) {}

lib_0321::func_0FA6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = spawnStruct();
  var_04.var_4AB6 = 0;
  var_04.var_4AB5 = [];
  var_05 = [];
  foreach(var_08, var_07 in param_00) {
    var_07.var_005C = 1;
    if(param_03) {
      thread lib_0321::func_0FAD(var_04, var_08, var_07, param_01, param_02);
      continue;
    }

    var_05[var_05.size] = lib_0321::func_0FAD(var_04, var_08, var_07, param_01, param_02);
  }

  if(param_03) {
    for(;;) {
      waittillframeend;
      waittillframeend;
      waittillframeend;
      waittillframeend;
      if(var_04.var_4AB6 == param_00.size) {
        break;
      } else {
        wait 0.05;
      }
    }

    var_05 = common_scripts\utility::func_0FA0(var_04.var_4AB5);
  }

  if(!param_02) {}

  return var_05;
}

lib_0321::func_0FAD(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(getsubstr(param_02.var_003A, 7, 10) == "veh") {
    var_05 = param_02 lib_0321::func_9016();
    if(isDefined(var_05.var_01A2) && !isDefined(var_05.var_8208)) {
      var_05 thread lib_0323::func_4816();
    }
  } else {
    var_05 = param_02 lib_0321::func_8F71(param_03);
    if(!param_04) {}
  }

  param_00.var_4AB6++;
  param_00.var_4AB5[param_01] = var_05;
  return var_05;
}

lib_0321::func_0FA9(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = [];
  foreach(var_06 in param_00) {
    var_06.var_005C = 1;
    if(getsubstr(var_06.var_003A, 7, 10) == "veh") {
      var_07 = var_06 lib_0321::func_9016();
      if(isDefined(var_07.var_01A2) && !isDefined(var_07.var_8208)) {
        var_07 thread lib_0323::func_4816();
      }

      var_04[var_04.size] = var_07;
      continue;
    }

    var_07 = var_06 lib_0321::func_8F71(1);
    var_04 = common_scripts\utility::func_0F6F(var_04, var_07);
    if(isDefined(param_03)) {
      wait(param_03);
      continue;
    }

    wait 0.05;
  }

  if(!param_02) {}

  return var_04;
}

lib_0321::func_0FAF(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, "targetname");
  return lib_0321::func_0FA6(var_05, param_01, param_02, param_04);
}

lib_0321::func_0FB0(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, "targetname");
  return lib_0321::func_0FA9(var_05, param_01, param_03, param_02);
}

lib_0321::func_0FAE(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, "script_noteworthy");
  return lib_0321::func_0FA6(var_05, param_01, param_02, param_04);
}

lib_0321::func_8FF0(param_00, param_01) {
  var_02 = getent(param_00, "script_noteworthy");
  var_03 = var_02 lib_0321::func_8F71(param_01);
  return var_03;
}

lib_0321::func_9001(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_03 = var_02 lib_0321::func_8F71(param_01);
  return var_03;
}

lib_0321::func_0920(param_00, param_01, param_02) {
  if(getdvarint("2853", 0)) {
    return;
  }

  if(!isDefined(level.var_2EC4)) {
    level.var_2EC4 = [];
  }

  var_03 = 0;
  for(;;) {
    if(!isDefined(level.var_2EC4[var_03])) {
      break;
    }

    var_03++;
  }

  var_04 = "^3";
  if(isDefined(param_02)) {
    switch (param_02) {
      case "red":
      case "r":
        var_04 = "^1";
        break;

      case "green":
      case "g":
        var_04 = "^2";
        break;

      case "y":
      case "yellow":
        var_04 = "^3";
        break;

      case "blue":
      case "b":
        var_04 = "^4";
        break;

      case "cyan":
      case "c":
        var_04 = "^5";
        break;

      case "purple":
      case "p":
        var_04 = "^6";
        break;

      case "w":
      case "white":
        var_04 = "^7";
        break;

      case "bl":
      case "black":
        var_04 = "^8";
        break;
    }
  }

  level.var_2EC4[var_03] = 1;
  var_05 = lib_02C6::func_27ED("default", 1.5);
  var_05.var_5E55 = 0;
  var_05.var_0010 = "left";
  var_05.var_0011 = "top";
  var_05.var_00A0 = 1;
  var_05.var_0184 = 20;
  var_05.var_0018 = 0;
  var_05 fadeovertime(0.5);
  var_05.var_0018 = 1;
  var_05.var_01D3 = 40;
  var_05.var_01D7 = 260 + var_03 * 18;
  var_05.var_00E5 = " " + var_04 + "< " + param_00 + " > ^7" + param_01;
  var_05.var_0056 = (1, 1, 1);
  wait(2);
  var_06 = 40;
  var_05 fadeovertime(6);
  var_05.var_0018 = 0;
  for(var_07 = 0; var_07 < var_06; var_07++) {
    var_05.var_0056 = (1, 1, 0 / var_06 - var_07);
    wait 0.05;
  }

  wait(4);
  var_05 destroy();
  level.var_2EC4[var_03] = undefined;
}

lib_0321::func_2DF2() {
  common_scripts\_destructible::func_2F37();
}

lib_0321::func_2DF8() {
  common_scripts\_destructible::func_3DED();
}

lib_0321::func_84C7(param_00) {
  self.var_00B2 = param_00;
}

lib_0321::func_4298() {
  var_00 = self.var_0116;
  var_01 = anglestoup(self getangles());
  var_02 = self getviewheight();
  var_03 = var_00 + (0, 0, var_02);
  var_04 = var_00 + var_01 * var_02;
  var_05 = var_03 - var_04;
  var_06 = var_00 + var_05;
  return var_06;
}

lib_0321::func_841C(param_00) {
  lib_0290::func_0ACC(param_00);
}

lib_0321::func_843E() {
  if(!isDefined(level.var_258F)) {
    level.var_258F = getDvar("5554") == "true";
  } else {}

  if(!isDefined(level.var_01D4)) {
    level.var_01D4 = getDvar("3475") == "true";
  } else {}

  if(!isDefined(level.var_01D5)) {
    level.var_01D5 = getDvar("2695") == "true";
  } else {}

  if(!isDefined(level.var_0148)) {
    level.var_0148 = getDvar("3864") == "true";
  } else {}

  if(!isDefined(level.var_0149)) {
    level.var_0149 = getDvar("3957") == "true";
  } else {}

  if(!isDefined(level.var_0122)) {
    level.var_0122 = !level.var_258F;
  } else {}

  if(!isDefined(level.var_010B)) {
    level.var_010B = level.var_0122 || level.var_0148 || level.var_01D4;
  }
}

lib_0321::func_5583() {
  return level.var_010B;
}

lib_0321::func_1395(param_00) {
  var_01 = lib_0299::func_13A3(undefined, undefined, undefined, 1, undefined, param_00);
  if(isDefined(var_01) && var_01) {
    if(!isDefined(param_00) || param_00 == 0) {
      lib_031D::func_7430("CHECKPOINT_REACHED");
    }
  }

  return var_01;
}

lib_0321::func_1396() {
  return lib_0299::func_13A3(undefined, undefined, undefined, 1, undefined, 1);
}

lib_0321::func_84AF(param_00) {
  self.var_2A9B = lib_0321::func_44FE(param_00);
}

lib_0321::func_8459(param_00) {
  self.var_2A9B = lib_0321::func_4417(param_00);
}

lib_0321::func_23B1() {
  self.var_2A9B = undefined;
}

lib_0321::func_4FA3(param_00) {
  wait(1.75);
  if(isDefined(param_00)) {
    self method_8617(param_00);
  } else {
    self method_8617("door_wood_slow_open");
  }

  self rotateto(self.var_001D + (0, 70, 0), 2, 0.5, 0);
  self method_8060();
  self waittill("rotatedone");
  self rotateto(self.var_001D + (0, 40, 0), 2, 0, 2);
}

lib_0321::func_6E17(param_00) {
  wait(1.35);
  if(isDefined(param_00)) {
    self method_8617(param_00);
  } else {
    self method_8617("door_wood_slow_open");
  }

  self rotateto(self.var_001D + (0, 70, 0), 2, 0.5, 0);
  self method_8060();
  self waittill("rotatedone");
  self rotateto(self.var_001D + (0, 40, 0), 2, 0, 2);
}

lib_0321::func_5C83(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 method_8035(param_01, param_00);
  }

  wait(param_00);
}

lib_0321::func_5C84(param_00, param_01) {
  var_02 = getdvarfloat("3078");
  var_03 = int(param_00 / 0.05);
  var_04 = param_01 - var_02 / var_03;
  var_05 = var_02;
  for(var_06 = 0; var_06 < var_03; var_06++) {
    var_05 = var_05 + var_04;
    function_00C8("3078", var_05);
    wait 0.05;
  }

  function_00C8("3078", param_01);
}

lib_0321::func_77C5() {
  animscripts\shared::func_7008(self.var_01D0, "none");
  self.var_01D0 = "none";
}

lib_0321::func_0F28() {
  lib_0298::func_849F(0);
}

lib_0321::func_0F27() {
  lib_0298::func_849F(1);
}

lib_0321::func_0E86() {
  self method_813C();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

lib_0321::func_2F51() {
  self.var_0794.var_2F95 = 1;
  self.var_0016 = 0;
}

lib_0321::func_3636() {
  self.var_0794.var_2F95 = 0;
  self.var_0016 = 1;
}

lib_0321::func_05FB() {
  self delete();
}

lib_0321::func_0669() {
  self method_805A();
}

lib_0321::func_5A26() {
  if(isPlayer(self)) {
    if(common_scripts\utility::func_3C83("special_op_terminated") && common_scripts\utility::func_3C77("special_op_terminated")) {
      return 0;
    }

    if(lib_0321::func_55DE(self)) {
      self method_80E7();
    }
  }

  self method_80E3(0);
  self method_805A();
  return 1;
}

lib_0321::func_06D1(param_00) {
  self method_8163(param_00);
}

lib_0321::func_05E2() {
  self method_8164();
}

lib_0321::func_0733() {
  self unlink();
}

lib_0321::func_2F50(param_00) {
  var_01 = getarraykeys(level.var_0643[param_00]);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    level.var_0643[param_00][var_01[var_02]].var_5EED delete();
    level.var_0643[param_00][var_01[var_02]] = undefined;
  }
}

lib_0321::func_06D3(param_00) {
  self method_81DF(param_00);
}

lib_0321::func_0673(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    self linkto(param_00, param_01, param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    self linkto(param_00, param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self linkto(param_00, param_01);
    return;
  }

  self linkto(param_00);
}

lib_0321::func_0FBA(param_00, param_01, param_02) {
  var_03 = getarraykeys(param_00);
  var_04 = [];
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
  }

  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    var_04[var_06] = spawnStruct();
    var_04[var_06].var_05A3 = 1;
    var_04[var_06] thread lib_0322::func_0FBB(param_00[var_06], param_01, param_02);
  }

  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    if(isDefined(param_00[var_06]) && var_04[var_06].var_05A3) {
      var_04[var_06] waittill("_array_wait");
    }
  }
}

lib_0321::func_2EED() {
  self method_805A((0, 0, 0));
}

lib_0321::func_458F(param_00) {
  return level.var_80CD[param_00];
}

lib_0321::func_5663() {
  return self playerads() > 0.5;
}

lib_0321::func_A756(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    param_05 = level.var_721C;
  }

  var_06 = spawnStruct();
  if(isDefined(param_03)) {
    var_06 thread lib_0321::func_67F1("timeout", param_03);
  }

  var_06 endon("timeout");
  if(!isDefined(param_00)) {
    param_00 = 0.92;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_07 = int(param_01 * 20);
  var_08 = var_07;
  self endon("death");
  var_09 = isai(self);
  var_0A = undefined;
  for(;;) {
    if(var_09) {
      var_0A = self getEye();
    } else {
      var_0A = self.var_0116;
    }

    if(param_05 lib_0321::func_72E5(var_0A, param_00, param_02, param_04)) {
      var_08--;
      if(var_08 <= 0) {
        return 1;
      }
    } else {
      var_08 = var_07;
    }

    wait 0.05;
  }
}

lib_0321::func_A757(param_00, param_01, param_02, param_03) {
  lib_0321::func_A756(param_01, param_00, param_02, undefined, param_03);
}

lib_0321::func_72E5(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 0.8;
  }

  var_04 = lib_0321::func_429A();
  var_05 = var_04 getEye();
  var_06 = vectortoangles(param_00 - var_05);
  var_07 = anglesToForward(var_06);
  var_08 = var_04 getangles();
  var_09 = anglesToForward(var_08);
  var_0A = vectordot(var_07, var_09);
  if(var_0A < param_01) {
    return 0;
  }

  if(isDefined(param_02)) {
    return 1;
  }

  var_0B = bulletTrace(param_00, var_05, 0, param_03);
  return var_0B["fraction"] == 1;
}

lib_0321::func_35AA(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < level.var_744A.size; var_04++) {
    if(level.var_744A[var_04] lib_0321::func_72E5(param_00, param_01, param_02, param_03)) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_723A(param_00, param_01, param_02) {
  var_03 = gettime();
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_04 = 0.766;
  if(isDefined(param_02)) {
    var_04 = cos(param_02);
  }

  if(isDefined(param_00.var_7453) && param_00.var_7453 + param_01 >= var_03) {
    return param_00.var_7452;
  }

  param_00.var_7453 = var_03;
  if(!common_scripts\utility::func_AA4A(level.var_721C.var_0116, level.var_721C geteyeangles(), param_00.var_0116, var_04)) {
    param_00.var_7452 = 0;
    return 0;
  }

  var_05 = level.var_721C getEye();
  var_06 = param_00.var_0116;
  if(sighttracepassed(var_05, var_06, 1, level.var_721C, param_00)) {
    param_00.var_7452 = 1;
    return 1;
  }

  var_07 = var_06 + (0, 0, 120);
  if(sighttracepassed(var_05, var_07, 1, level.var_721C, param_00)) {
    param_00.var_7452 = 1;
    return 1;
  }

  var_08 = var_07 + var_06 * 0.5;
  if(sighttracepassed(var_05, var_08, 1, level.var_721C, param_00)) {
    param_00.var_7452 = 1;
    return 1;
  }

  param_00.var_7452 = 0;
  return 0;
}

lib_0321::func_744D(param_00, param_01) {
  var_02 = param_00 * param_00;
  for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
    if(distancesquared(param_01, level.var_744A[var_03].var_0116) < var_02) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_0A7F(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = 0.75;
  if(issplitscreen()) {
    var_02 = 0.65;
  }

  while(param_00.size > 0) {
    wait(1);
    for(var_03 = 0; var_03 < param_00.size; var_03++) {
      if(!isDefined(param_00[var_03]) || !isalive(param_00[var_03])) {
        param_00 = common_scripts\utility::func_0F93(param_00, param_00[var_03]);
        continue;
      }

      if(lib_0321::func_744D(param_01, param_00[var_03].var_0116)) {
        continue;
      }

      if(lib_0321::func_35AA(param_00[var_03].var_0116 + (0, 0, 48), var_02, 1)) {
        continue;
      }

      if(isDefined(param_00[var_03].var_5F6E)) {
        param_00[var_03] lib_0321::func_93D8();
      }

      param_00[var_03] delete();
      param_00 = common_scripts\utility::func_0F93(param_00, param_00[var_03]);
    }
  }
}

lib_0321::func_098B(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_1E82 = self;
  var_04.var_3F02 = param_00;
  var_04.var_6E87 = [];
  if(isDefined(param_01)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_03;
  }

  level.var_A63D[level.var_A63D.size] = var_04;
}

lib_0321::func_08F5(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_1E82 = self;
  var_04.var_3F02 = param_00;
  var_04.var_6E87 = [];
  if(isDefined(param_01)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_6E87[var_04.var_6E87.size] = param_03;
  }

  level.var_0846[level.var_0846.size] = var_04;
}

lib_0321::func_092A(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.var_1E82 = self;
  var_06.var_3F02 = param_00;
  var_06.var_6E87 = [];
  if(isDefined(param_01)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_05;
  }

  level.var_7F62[level.var_7F62.size] = var_06;
}

lib_0321::func_0907(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.var_1E82 = self;
  var_06.var_3F02 = param_00;
  var_06.var_6E87 = [];
  if(isDefined(param_01)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_05;
  }

  level.var_7F5A[level.var_7F5A.size] = var_06;
}

lib_0321::func_094A(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.var_3F02 = param_00;
  var_06.var_6E87 = [];
  if(isDefined(param_01)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_6E87[var_06.var_6E87.size] = param_05;
  }

  level.var_7F67[level.var_7F67.size] = var_06;
}

lib_0321::func_0924(param_00) {
  var_01 = spawnStruct();
  var_01.var_1E82 = self;
  var_01.var_36B6 = param_00;
  level.var_30FF[level.var_30FF.size] = var_01;
}

lib_0321::func_30FE() {
  lib_0321::func_30FD(level.var_A63D.size - 1);
}

lib_0321::func_30FD(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = spawnStruct();
  var_02 = level.var_A63D;
  var_03 = level.var_30FF;
  var_04 = level.var_7F62;
  var_05 = level.var_7F5A;
  var_06 = level.var_7F67;
  var_07 = level.var_0846;
  level.var_A63D = [];
  level.var_7F62 = [];
  level.var_30FF = [];
  level.var_0846 = [];
  level.var_7F5A = [];
  level.var_7F67 = [];
  var_01.var_005C = var_02.size;
  var_01 common_scripts\utility::func_0F8A(var_02, ::lib_0322::func_A73F, var_03);
  var_01 thread lib_0322::func_3093(var_07);
  var_01 endon("any_funcs_aborted");
  for(;;) {
    if(var_01.var_005C <= param_00) {
      break;
    }

    var_01 waittill("func_ended");
  }

  var_01 notify("all_funcs_ended");
  common_scripts\utility::func_0F8A(var_04, ::lib_0322::func_38D6, []);
  common_scripts\utility::func_0F8A(var_05, ::lib_0322::func_38D4);
  common_scripts\utility::func_0F8A(var_06, ::lib_0322::func_38D5);
}

lib_0321::func_30B8() {
  var_00 = spawnStruct();
  var_01 = level.var_7F62;
  level.var_7F62 = [];
  foreach(var_03 in var_01) {
    level lib_0322::func_38D6(var_03, []);
  }

  var_00 notify("all_funcs_ended");
}

lib_0321::func_5564() {
  if(isDefined(level.var_3E13) && level.var_3E13 == 1) {
    return 0;
  }

  if(isDefined(level.var_2BB9) && level.var_2BB9 == level.var_9267) {
    return 1;
  }

  if(isDefined(level.var_2BB8)) {
    return level.var_9267 == "default";
  }

  if(lib_0321::func_5CB3()) {
    return level.var_9267 == level.var_9210[0]["name"];
  }

  return level.var_9267 == "default";
}

lib_0321::func_3E00() {
  level.var_3E13 = 1;
}

lib_0321::func_557E() {
  if(!lib_0321::func_5CB3()) {
    return 1;
  }

  return level.var_9267 == level.var_9210[0]["name"];
}

lib_0321::func_552D(param_00) {
  var_01 = 0;
  if(level.var_9267 == param_00) {
    return 0;
  }

  for(var_02 = 0; var_02 < level.var_9210.size; var_02++) {
    if(level.var_9210[var_02]["name"] == param_00) {
      var_01 = 1;
      continue;
    }

    if(level.var_9210[var_02]["name"] == level.var_9267) {
      return var_01;
    }
  }
}

lib_0321::func_0610(param_00, param_01, param_02, param_03) {
  earthquake(param_00, param_01, param_02, param_03);
}

lib_0321::func_A967(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  if(isDefined(param_01)) {
    var_02 = 1;
  }

  if(isDefined(param_00)) {
    common_scripts\utility::func_3C78(param_00);
    level endon(param_00);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_03 = self.var_0116 + (0, 0, 150);
    var_04 = self.var_0116 - (0, 0, 150);
    var_05 = bulletTrace(var_03, var_04, 0, undefined);
    if(!issubstr(var_05["surfacetype"], "water")) {
      continue;
    }

    var_06 = "water_movement";
    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_06 = "water_stop";
      }
    } else if(isDefined(level.var_0611["water_" + self.var_0794.var_64B0])) {
      var_06 = "water_" + self.var_0794.var_64B0;
    }

    var_07 = common_scripts\utility::func_44F5(var_06);
    var_03 = var_05["position"];
    var_08 = (0, self.var_001D[1], 0);
    var_09 = anglesToForward(var_08);
    var_0A = anglestoup(var_08);
    playFX(var_07, var_03, var_0A, var_09);
    if(var_06 != "water_stop" && var_02) {
      thread common_scripts\utility::func_71A9(param_01, var_03);
    }
  }
}

lib_0321::func_7461(param_00) {
  if(isDefined(param_00)) {
    common_scripts\utility::func_3C78(param_00);
    level endon(param_00);
  }

  for(;;) {
    wait(randomfloatrange(0.25, 0.5));
    var_01 = self.var_0116 + (0, 0, 0);
    var_02 = self.var_0116 - (0, 0, 5);
    var_03 = bulletTrace(var_01, var_02, 0, undefined);
    var_04 = anglesToForward(self.var_001D);
    var_05 = distance(self getvelocity(), (0, 0, 0));
    if(isDefined(self.var_A2C8)) {
      continue;
    }

    if(var_03["surfacetype"] != "snow") {
      continue;
    }

    if(var_05 <= 10) {
      continue;
    }

    var_06 = "snow_movement";
    if(distance(self getvelocity(), (0, 0, 0)) <= 154) {
      playFX(common_scripts\utility::func_44F5("footstep_snow_small"), var_03["position"], var_03["normal"], var_04);
    }

    if(distance(self getvelocity(), (0, 0, 0)) > 154) {
      playFX(common_scripts\utility::func_44F5("footstep_snow"), var_03["position"], var_03["normal"], var_04);
    }
  }
}

lib_0321::func_6265(param_00) {
  var_01 = 60;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    self method_8611(param_00, param_00 + "_off", var_01 - var_02 / var_01);
    wait 0.05;
  }
}

lib_0321::func_625F(param_00) {
  var_01 = 60;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    self method_8611(param_00, param_00 + "_off", var_02 / var_01);
    wait 0.05;
  }
}

lib_0321::func_5FD4(param_00, param_01) {
  param_00 endon("death");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  for(;;) {
    self.var_0116 = param_00.var_0116 + param_01;
    self.var_001D = param_00.var_001D;
    wait 0.05;
  }
}

lib_0321::func_66C7() {
  lib_0322::func_6252();
  lib_02B3::func_0682();
}

lib_0321::func_47F7(param_00, param_01) {
  lib_02B3::func_0644(param_00, param_01);
}

lib_0321::func_5FA1(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_05[var_05.size] = param_00;
  if(isDefined(param_01)) {
    var_05[var_05.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_05[var_05.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_05[var_05.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_05[var_05.size] = param_04;
  }

  return var_05;
}

lib_0321::func_39D6() {
  level.var_39E8 = 1;
}

lib_0321::func_6743() {
  level.var_39E8 = 0;
}

lib_0321::func_4619() {
  var_00 = self getweaponslistall();
  var_01 = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    var_01[var_03] = self getweaponammoclip(var_03);
  }

  var_04 = 0;
  if(isDefined(var_01["claymore"]) && var_01["claymore"] > 0) {
    var_04 = var_01["claymore"];
  }

  return var_04;
}

lib_0321::func_076D(param_00) {
  wait(param_00);
}

lib_0321::func_0770(param_00, param_01) {
  self waittillmatch(param_01, param_00);
}

lib_0321::func_06D9(param_00, param_01) {
  function_00C8(param_00, param_01);
}

lib_0321::func_5C94(param_00, param_01, param_02) {
  var_03 = getdvarfloat(param_00);
  level notify(param_00 + "_lerp_savedDvar");
  level endon(param_00 + "_lerp_savedDvar");
  var_04 = param_01 - var_03;
  var_05 = 0.05;
  var_06 = int(param_02 / var_05);
  var_07 = var_04 / var_06;
  while(var_06) {
    var_03 = var_03 + var_07;
    function_00C8(param_00, var_03);
    wait(var_05);
    var_06--;
  }

  function_00C8(param_00, param_01);
}

lib_0321::func_5C95(param_00, param_01, param_02, param_03) {
  if(lib_0321::func_5583()) {
    lib_0321::func_5C94(param_00, param_02, param_03);
    return;
  }

  lib_0321::func_5C94(param_00, param_01, param_03);
}

lib_0321::func_476F(param_00) {
  if(lib_0321::func_5567() || getdvarint("3224")) {
    return;
  }

  foreach(var_02 in level.var_744A) {
    var_02 giveachievement(param_00);
  }
}

lib_0321::func_728C(param_00) {
  if(lib_0321::func_5567()) {
    return;
  }

  self giveachievement(param_00);
}

lib_0321::func_0937(param_00) {
  var_01 = spawn("script_model", (0, 0, 0));
  var_01 method_80B1();
  var_01 setModel("weapon_javelin_obj");
  var_01.var_0116 = self.var_0116;
  var_01.var_001D = self.var_001D;
  lib_0321::func_098B(::lib_0321::func_2D1F);
  if(isDefined(param_00)) {
    common_scripts\utility::func_3C78(param_00);
    lib_0321::func_098B(::common_scripts\utility::func_3C9F, param_00);
  }

  lib_0321::func_30FE();
  var_01 delete();
}

lib_0321::func_0906(param_00) {
  var_01 = spawn("script_model", (0, 0, 0));
  var_01 method_80B1();
  var_01 setModel("weapon_c4_obj");
  var_01.var_0116 = self.var_0116;
  var_01.var_001D = self.var_001D;
  lib_0321::func_098B(::lib_0321::func_2D1F);
  if(isDefined(param_00)) {
    common_scripts\utility::func_3C78(param_00);
    lib_0321::func_098B(::common_scripts\utility::func_3C9F, param_00);
  }

  lib_0321::func_30FE();
  var_01 delete();
}

lib_0321::func_2D1F() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    wait 0.05;
  }
}

lib_0321::func_8CB5() {}

lib_0321::func_8CAC() {}

lib_0321::func_8CB4(param_00) {
  level.var_8CAB.var_90EF = param_00;
}

lib_0321::func_8CB3(param_00) {
  level.var_8CAB.var_90EB = param_00;
}

lib_0321::func_8CB1(param_00) {
  level.var_8CAB.var_5C9C = param_00;
}

lib_0321::func_8CB2(param_00) {
  level.var_8CAB.var_5C9D = param_00;
}

lib_0321::func_8CAD() {
  if(isDefined(level.var_66FC) && level.var_66FC) {
    return;
  }

  setslowmotion(level.var_8CAB.var_90EB, level.var_8CAB.var_90EF, level.var_8CAB.var_5C9C);
}

lib_0321::func_8CAE() {
  if(isDefined(level.var_66FC) && level.var_66FC) {
    return;
  }

  setslowmotion(level.var_8CAB.var_90EF, level.var_8CAB.var_90EB, level.var_8CAB.var_5C9D);
}

lib_0321::func_0923(param_00, param_01, param_02, param_03) {
  level.var_353D[param_00]["magnitude"] = param_01;
  level.var_353D[param_00]["duration"] = param_02;
  level.var_353D[param_00]["radius"] = param_03;
}

lib_0321::func_0F44() {
  return getDvar("2559") == "1";
}

lib_0321::func_0F46() {
  if(!isDefined(level.var_0F45)) {
    return;
  }

  level notify("arcadeMode_remove_timer");
  level.var_0F47 = gettime();
  level.var_0F45 destroy();
  level.var_0F45 = undefined;
}

lib_0321::func_65BE(param_00, param_01) {
  level.var_05A5.var_5B4D = param_00;
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  function_0347(0);
  function_0346(param_00, 0, 1, 1);
}

lib_0321::func_65B3(param_00, param_01, param_02, param_03) {
  thread lib_0322::func_65B4(param_00, param_01, param_02, param_03);
}

lib_0321::func_65B6(param_00, param_01, param_02, param_03) {
  thread lib_0322::func_65B4(param_00, param_01, param_02, param_03);
}

lib_0321::func_65B8(param_00, param_01, param_02) {
  if(isDefined(param_01) && param_01 > 0) {
    thread lib_0322::func_65B9(param_00, param_01, param_02);
    return;
  }

  lib_0321::func_65BB();
  lib_0321::func_65BE(param_00, param_02);
}

lib_0321::func_65B1(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(isDefined(level.var_05A5.var_5B4D)) {
    function_0347(param_01, level.var_05A5.var_5B4D);
  } else {
    iprintln("^3WARNING!script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");
  }

  level.var_05A5.var_5B4D = param_00;
  function_0346(param_00, param_01, param_02, 0);
  level endon("stop_music");
  wait(param_01);
  level notify("done_crossfading");
}

lib_0321::func_65BB(param_00) {
  if(!isDefined(param_00) || param_00 <= 0) {
    function_0347();
  } else {
    function_0347(param_00);
  }

  level notify("stop_music");
}

lib_0321::func_72C5() {
  var_00 = getEntArray("grenade", "classname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(var_02.var_0106 == "weapon_claymore") {
      continue;
    }

    for(var_03 = 0; var_03 < level.var_744A.size; var_03++) {
      var_04 = level.var_744A[var_03];
      if(distancesquared(var_02.var_0116, var_04.var_0116) < 75625) {
        return 1;
      }
    }
  }

  return 0;
}

lib_0321::func_7259() {
  return getdvarint("player_died_recently", "0") > 0;
}

lib_0321::func_0BD2(param_00) {
  foreach(var_02 in level.var_744A) {
    if(!var_02 istouching(param_00)) {
      return 0;
    }
  }

  return 1;
}

lib_0321::func_0F0C(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 istouching(param_00)) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_448F() {
  if(level.var_3FD4 < 1) {
    return "easy";
  }

  if(level.var_3FD4 < 2) {
    return "medium";
  }

  if(level.var_3FD4 < 3) {
    return "hard";
  }

  return "fu";
}

lib_0321::func_442F() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in level.var_744A) {
    var_00 = var_00 + var_04.var_0116[0];
    var_01 = var_01 + var_04.var_0116[1];
    var_02 = var_02 + var_04.var_0116[2];
  }

  var_00 = var_00 / level.var_744A.size;
  var_01 = var_01 / level.var_744A.size;
  var_02 = var_02 / level.var_744A.size;
  return (var_00, var_01, var_02);
}

lib_0321::func_40B9(param_00) {
  var_01 = (0, 0, 0);
  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03.var_0116;
  }

  return var_01 * 1 / param_00.size;
}

lib_0321::func_401F() {
  self.var_299C = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06);
    foreach(var_08 in self.var_299C) {
      thread[[var_08]](var_00, var_01, var_02, var_03, var_04, var_05, var_06);
    }
  }
}

lib_0321::func_0913(param_00) {
  self.var_299C[self.var_299C.size] = param_00;
}

lib_0321::func_7C7C(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_299C) {
    if(var_03 == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  self.var_299C = var_01;
}

lib_0321::func_74BF(param_00) {
  self method_8615(param_00);
}

lib_0321::func_365F(param_00) {
  if(level.var_744A.size < 1) {
    return;
  }

  foreach(var_02 in level.var_744A) {
    if(param_00 == 1) {
      var_02 method_8323();
      continue;
    }

    var_02 method_8322();
  }
}

lib_0321::func_98A6(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in param_00) {
    if(isDefined(var_05.var_0165) && var_05.var_0165 == "player1") {
      var_01 = var_05;
      continue;
    }

    if(isDefined(var_05.var_0165) && var_05.var_0165 == "player2") {
      var_02 = var_05;
      continue;
    }

    if(!isDefined(var_01)) {
      var_01 = var_05;
    }

    if(!isDefined(var_02)) {
      var_02 = var_05;
    }
  }

  foreach(var_08 in level.var_744A) {
    if(var_08 == level.var_721C) {
      var_03 = var_01;
    } else if(var_08 == level.var_73AB) {
      var_03 = var_02;
    }

    var_08 setorigin(var_03.var_0116);
    var_08 setangles(var_03.var_001D);
  }
}

lib_0321::func_98A3(param_00) {
  level.var_721C setorigin(param_00.var_0116);
  if(isDefined(param_00.var_001D)) {
    level.var_721C setangles(param_00.var_001D);
  }
}

lib_0321::func_9C88() {
  var_00 = [];
  if(isDefined(self.var_37C3)) {
    var_00 = self.var_37C3;
  }

  if(isDefined(self.var_008E)) {
    var_00[var_00.size] = self.var_008E;
  }

  common_scripts\utility::func_0F8A(var_00, ::lib_0322::func_9C89);
}

lib_0321::func_6BF7(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level.var_721C endon("stop_opening_fov");
  wait(param_00);
  level.var_721C playerlinktodelta(param_01, param_02, 1, param_03, param_04, param_05, param_06, 1);
}

lib_0321::func_4069(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  var_03 = function_00CC(param_00, param_01);
  var_04 = [];
  foreach(var_06 in var_03) {
    if(var_06 istouching(self)) {
      var_04[var_04.size] = var_06;
    }
  }

  return var_04;
}

lib_0321::func_4164(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  var_01 = [];
  if(param_00 == "all") {
    var_01 = common_scripts\utility::func_0F8C(level.var_343C["allies"].var_0F6D, level.var_343C["axis"].var_0F6D);
    var_01 = common_scripts\utility::func_0F8C(var_01, level.var_343C["neutral"].var_0F6D);
  } else {
    var_01 = level.var_343C[param_00].var_0F6D;
  }

  var_02 = [];
  foreach(var_04 in var_01) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(var_04 istouching(self)) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

lib_0321::func_4165(param_00) {
  var_01 = common_scripts\utility::func_0F8C(level.var_343C["allies"].var_0F6D, level.var_343C["axis"].var_0F6D);
  var_01 = common_scripts\utility::func_0F8C(var_01, level.var_343C["neutral"].var_0F6D);
  var_02 = [];
  foreach(var_04 in var_01) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(isDefined(var_04.var_01A5) && var_04.var_01A5 == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

lib_0321::func_426B(param_00) {
  foreach(var_02 in level.var_744A) {
    if(param_00 == var_02) {
      continue;
    }

    return var_02;
  }
}

lib_0321::func_8445(param_00) {
  self.var_005C = param_00;
  if(self.var_005C == 0) {
    self notify("spawner_emptied");
  }
}

lib_0321::func_3DC4(param_00) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_01 = undefined;
  if(!isDefined(param_00.var_003A)) {
    if(!isDefined(param_00.var_01B9)) {
      var_01 = "struct";
    } else {
      var_01 = "node";
    }
  } else {
    var_01 = "entity";
  }

  var_02 = self.var_81B0;
  self.var_81B0 = 1;
  lib_02FC::func_47F8(param_00, var_01);
  self.var_81B0 = var_02;
}

lib_0321::func_361B(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_00)) {
    param_00 = 250;
  }

  if(!isDefined(param_01)) {
    param_01 = 100;
  }

  if(!isDefined(param_02)) {
    param_02 = param_00 * 2;
  }

  if(!isDefined(param_03)) {
    param_03 = param_00 * 1.25;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  self.var_323F = param_05;
  thread lib_0322::func_3527(param_00, param_01, param_02, param_03, param_04);
}

lib_0321::func_2F34() {
  self notify("stop_dynamic_run_speed");
}

lib_0321::func_731E() {
  self endon("death");
  self endon("stop_player_seek");
  var_00 = 1200;
  if(lib_0321::func_4B41()) {
    var_00 = 250;
  }

  var_01 = distance(self.var_0116, level.var_721C.var_0116);
  for(;;) {
    wait(2);
    self.var_00AE = var_01;
    var_02 = lib_0321::func_4103(self.var_0116);
    self method_81A3(var_02);
    var_01 = var_01 - 175;
    if(var_01 < var_00) {
      var_01 = var_00;
      return;
    }
  }
}

lib_0321::func_731D() {
  self notify("stop_player_seek");
}

lib_0321::func_A739(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  var_03 = gettime() + param_02 * 1000;
  while(isDefined(param_00)) {
    if(distance(param_00.var_0116, self.var_0116) <= param_01) {
      break;
    }

    if(gettime() > var_03) {
      break;
    }

    wait(0.1);
  }
}

lib_0321::func_A738(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  while(isDefined(param_00)) {
    if(distance(param_00.var_0116, self.var_0116) <= param_01) {
      break;
    }

    wait(0.1);
  }
}

lib_0321::func_A73A(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  while(isDefined(param_00)) {
    if(distance(param_00.var_0116, self.var_0116) > param_01) {
      break;
    }

    wait(0.1);
  }
}

lib_0321::func_4B41() {
  self endon("death");
  if(!isDefined(self.var_01D0)) {
    return 0;
  }

  if(function_01AA(self.var_01D0) == "spread") {
    return 1;
  }

  return 0;
}

lib_0321::func_5795(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(function_01D4(param_00) != "primary") {
    return 0;
  }

  switch (function_01AA(param_00)) {
    case "mg":
    case "pistol":
    case "smg":
    case "rifle":
    case "rocketlauncher":
    case "sniper":
    case "spread":
      return 1;

    default:
      return 0;
  }
}

lib_0321::func_729B() {
  var_00 = self getweaponslistall();
  if(!isDefined(var_00)) {
    return 0;
  }

  foreach(var_02 in var_00) {
    if(issubstr(var_02, "thermal")) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_A769(param_00, param_01) {
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = self.var_00AE;
  }

  for(;;) {
    self waittill("goal");
    if(distance(self.var_0116, param_00) < param_01 + 10) {
      break;
    }
  }
}

lib_0321::func_7334(param_00, param_01) {
  var_02 = int(getDvar("5502"));
  if(!isDefined(level.var_721C.var_3F88)) {
    level.var_721C.var_3F88 = var_02;
  }

  var_03 = int(level.var_721C.var_3F88 * param_00 * 0.01);
  level.var_721C lib_0321::func_7336(var_03, param_01);
}

lib_0321::func_1793(param_00, param_01) {
  var_02 = self;
  if(!isPlayer(var_02)) {
    var_02 = level.var_721C;
  }

  if(!isDefined(var_02.var_64CC)) {
    var_02.var_64CC = 1;
  }

  var_03 = param_00 * 0.01;
  var_02 lib_0321::func_1791(var_03, param_01);
}

lib_0321::func_7336(param_00, param_01) {
  var_02 = int(getDvar("5502"));
  if(!isDefined(level.var_721C.var_3F88)) {
    level.var_721C.var_3F88 = var_02;
  }

  var_03 = ::lib_0322::func_3F89;
  var_04 = ::lib_0322::func_3F8A;
  level.var_721C thread lib_0321::func_7335(param_00, param_01, var_03, var_04, "player_speed_set");
}

lib_0321::func_7234(param_00, param_01) {
  var_02 = ::lib_0322::func_3F86;
  var_03 = ::lib_0322::func_3F87;
  level.var_721C thread lib_0321::func_7335(param_00, param_01, var_02, var_03, "player_bob_scale_set");
}

lib_0321::func_1791(param_00, param_01) {
  var_02 = self;
  if(!isPlayer(var_02)) {
    var_02 = level.var_721C;
  }

  if(!isDefined(var_02.var_64CC)) {
    var_02.var_64CC = 1;
  }

  var_03 = ::lib_0322::func_64C9;
  var_04 = ::lib_0322::func_64CB;
  var_02 thread lib_0321::func_7335(param_00, param_01, var_03, var_04, "blend_movespeedscale");
}

lib_0321::func_7335(param_00, param_01, param_02, param_03, param_04) {
  self notify(param_04);
  self endon(param_04);
  var_05 = [[param_02]]();
  var_06 = param_00;
  if(isDefined(param_01)) {
    var_07 = var_06 - var_05;
    var_08 = 0.05;
    var_09 = param_01 / var_08;
    var_0A = var_07 / var_09;
    while(abs(var_06 - var_05) > abs(var_0A * 1.1)) {
      var_05 = var_05 + var_0A;
      [[param_03]](var_05);
      wait(var_08);
    }
  }

  [[param_03]](var_06);
}

lib_0321::func_7333(param_00) {
  if(!isDefined(level.var_721C.var_3F88)) {
    return;
  }

  level.var_721C lib_0321::func_7336(level.var_721C.var_3F88, param_00);
  waittillframeend;
  level.var_721C.var_3F88 = undefined;
}

lib_0321::func_1792(param_00) {
  var_01 = self;
  if(!isPlayer(var_01)) {
    var_01 = level.var_721C;
  }

  if(!isDefined(var_01.var_64CC)) {
    return;
  }

  var_01 lib_0321::func_1791(1, param_00);
  waittillframeend;
  var_01.var_64CC = undefined;
}

lib_0321::func_987D(param_00) {
  if(isPlayer(self)) {
    self setorigin(param_00.var_0116);
    self setangles(param_00.var_001D);
    return;
  }

  self method_81C2(param_00.var_0116, param_00.var_001D);
}

lib_0321::func_98B5(param_00, param_01) {
  var_02 = param_00 gettagorigin(param_01);
  var_03 = param_00 gettagangles(param_01);
  self method_808C();
  if(isPlayer(self)) {
    self setorigin(var_02);
    self setangles(var_03);
    return;
  }

  if(isai(self)) {
    self method_81C2(var_02, var_03);
    return;
  }

  self.var_0116 = var_02;
  self.var_001D = var_03;
}

lib_0321::func_9874(param_00) {
  self method_81C2(param_00.var_0116, param_00.var_001D);
  self method_81A2(param_00.var_0116);
  self method_81A1(param_00);
}

lib_0321::func_6470(param_00) {
  foreach(var_02 in level.var_2804) {
    var_02.var_A265["origin"] = var_02.var_A265["origin"] + param_00;
  }
}

lib_0321::func_57D3() {
  return isDefined(self.var_8CA0);
}

lib_0321::func_171A(param_00, param_01, param_02) {
  var_03 = self;
  var_03 thread lib_0321::func_71AB("foot_slide_plr_start");
  if(function_0344("foot_slide_plr_loop")) {
    var_03 thread lib_0321::func_7154("foot_slide_plr_loop");
  }

  var_04 = isDefined(level.var_296E);
  if(!isDefined(param_00)) {
    param_00 = var_03 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(param_01)) {
    param_01 = 10;
  }

  if(!isDefined(param_02)) {
    if(isDefined(level.var_8C9E)) {
      param_02 = level.var_8C9E;
    } else {
      param_02 = 0.035;
    }
  }

  var_05 = spawn("script_origin", var_03.var_0116);
  var_05.var_001D = var_03.var_001D;
  var_03.var_8CA0 = var_05;
  var_05 moveslide((0, 0, 15), 15, param_00);
  if(var_04) {
    var_03 playerlinktoblend(var_05, undefined, 1);
  } else {
    var_03 playerlinkto(var_05);
  }

  var_03 method_8322();
  var_03 method_8114(0);
  var_03 method_8113(1);
  var_03 method_8112(0);
  var_03 thread lib_0322::func_32AA(var_05, param_01, param_02);
}

lib_0321::func_36EA() {
  var_00 = self;
  var_00 notify("stop soundfoot_slide_plr_loop");
  var_00 thread lib_0321::func_71AB("foot_slide_plr_end");
  var_00 unlink();
  var_00 setvelocity(var_00.var_8CA0.var_0182);
  var_00.var_8CA0 delete();
  var_00 method_8323();
  var_00 method_8114(1);
  var_00 method_8113(1);
  var_00 method_8112(1);
  var_00 notify("stop_sliding");
}

lib_0321::func_9016() {
  return lib_0323::func_A3B8(self);
}

lib_0321::func_44CC(param_00) {
  var_01 = lib_0319::func_41FC();
  var_02 = [];
  foreach(var_06, var_04 in var_01) {
    if(!issubstr(var_06, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_06, "classname");
    var_02 = common_scripts\utility::func_0F73(var_02, var_05);
  }

  var_07 = undefined;
  foreach(var_09 in var_02) {
    if(var_09.var_819A == param_00) {
      return var_09;
    }
  }
}

lib_0321::func_44C4(param_00) {
  var_01 = lib_0319::func_41FC();
  var_02 = [];
  foreach(var_06, var_04 in var_01) {
    if(!issubstr(var_06, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_06, "classname");
    var_02 = common_scripts\utility::func_0F73(var_02, var_05);
  }

  var_07 = [];
  foreach(var_09 in var_02) {
    if(var_09.var_819A == param_00) {
      var_07[var_07.size] = var_09;
    }
  }

  return var_07;
}

lib_0321::func_85FA(param_00, param_01) {
  return (param_00[0], param_00[1], param_01);
}

lib_0321::func_098D(param_00, param_01) {
  return (param_00[0], param_00[1], param_00[2] + param_01);
}

lib_0321::func_85F9(param_00, param_01) {
  return (param_00[0], param_01, param_00[2]);
}

lib_0321::func_85F8(param_00, param_01) {
  return (param_01, param_00[1], param_00[2]);
}

lib_0321::func_7396() {
  var_00 = self getcurrentweapon();
  if(!isDefined(var_00)) {
    return 0;
  }

  if(issubstr(tolower(var_00), "rpg")) {
    return 1;
  }

  if(issubstr(tolower(var_00), "stinger")) {
    return 1;
  }

  if(issubstr(tolower(var_00), "javelin")) {
    return 1;
  }

  return 0;
}

lib_0321::func_3201() {
  return isDefined(self.var_0794.var_3201);
}

lib_0321::func_430A(param_00, param_01) {
  if(lib_0321::func_554E()) {}

  var_02 = lib_0321::func_429A();
  if(!isDefined(param_00)) {
    param_00 = "steady_rumble";
  }

  var_03 = spawn("script_origin", var_02 getEye());
  if(!isDefined(param_01) || !function_02A2(param_01)) {
    var_03.var_00D8 = 1;
  } else {
    var_03.var_00D8 = param_01;
  }

  var_03 thread lib_0322::func_A0C9(var_02, param_00);
  return var_03;
}

lib_0321::func_8575(param_00) {
  self.var_00D8 = param_00;
}

lib_0321::func_7F51(param_00) {
  thread lib_0321::func_7F52(1, param_00);
}

lib_0321::func_7F50(param_00) {
  thread lib_0321::func_7F52(0, param_00);
}

lib_0321::func_7F52(param_00, param_01) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_02 = param_01 * 20;
  var_03 = param_00 - self.var_00D8;
  var_04 = var_03 / var_02;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    self.var_00D8 = self.var_00D8 + var_04;
    wait 0.05;
  }

  self.var_00D8 = param_00;
}

lib_0321::func_429A() {
  if(isDefined(self)) {
    if(!lib_0321::func_559A(level.var_744A, self)) {
      return level.var_721C;
    }

    return self;
  }

  return level.var_721C;
}

lib_0321::func_429B() {
  return int(self getplayersetting("gameskill"));
}

lib_0321::func_47E7(param_00) {
  if(isDefined(self.var_6725)) {
    return;
  }

  self.var_6725 = self.var_0106;
  if(!isDefined(param_00)) {
    param_00 = self.var_0106 + "_obj";
  }

  self setModel(param_00);
}

lib_0321::func_9407(param_00) {
  if(!isDefined(self.var_6725)) {
    return;
  }

  self setModel(self.var_6725);
  self.var_6725 = undefined;
}

lib_0321::func_0F7C(param_00, param_01, param_02) {
  var_03 = [];
  param_01 = param_02 - param_01;
  foreach(var_05 in param_00) {
    var_03[var_03.size] = var_05;
    if(var_03.size == param_02) {
      var_03 = common_scripts\utility::func_0F92(var_03);
      for(var_06 = param_01; var_06 < var_03.size; var_06++) {
        var_03[var_06] delete();
      }

      var_03 = [];
    }
  }

  var_08 = [];
  foreach(var_05 in param_00) {
    if(!isDefined(var_05)) {
      continue;
    }

    var_08[var_08.size] = var_05;
  }

  return var_08;
}

lib_0321::func_A741(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.5;
  }

  self endon("death");
  while(isDefined(self)) {
    if(distance(param_00, self.var_0116) <= param_01) {
      break;
    }

    wait(param_02);
  }
}

lib_0321::func_561A(param_00, param_01) {
  var_02 = getclosestpointonnavmesh(param_01, self);
  if(distancesquared(param_01, var_02) > 576) {
    return 0;
  }

  var_03 = getclosestpointonnavmesh(param_00, self);
  if(!function_02DE(var_03, var_02, self) && navtrace(var_03, var_02, self)) {
    return 0;
  }

  return 1;
}

lib_0321::func_097C(param_00) {
  var_01 = spawnStruct();
  var_01 thread lib_0322::func_097D(param_00);
  return var_01;
}

lib_0321::func_9B87(param_00, param_01, param_02) {
  var_03 = self gettagorigin(param_01);
  var_04 = self gettagangles(param_01);
  lib_0321::func_9B86(param_00, var_03, var_04, param_02);
}

lib_0321::func_9B86(param_00, param_01, param_02, param_03) {
  var_04 = anglesToForward(param_02);
  var_05 = bulletTrace(param_01, param_01 + var_04 * param_03, 0, undefined);
  if(var_05["fraction"] >= 1) {
    return;
  }

  var_06 = var_05["surfacetype"];
  if(!isDefined(level.var_9B80[param_00][var_06])) {
    var_06 = "default";
  }

  var_07 = level.var_9B80[param_00][var_06];
  if(isDefined(var_07["fx"])) {
    playFX(var_07["fx"], var_05["position"], var_05["normal"]);
  }

  if(isDefined(var_07["fx_array"])) {
    foreach(var_09 in var_07["fx_array"]) {
      playFX(var_09, var_05["position"], var_05["normal"]);
    }
  }

  if(isDefined(var_07["sound"])) {
    level thread common_scripts\utility::func_71A9(var_07["sound"], var_05["position"]);
  }

  if(isDefined(var_07["rumble"])) {
    var_0B = lib_0321::func_429A();
    var_0B playrumbleonentity(var_07["rumble"]);
  }
}

lib_0321::func_2F5E() {
  self.var_6694 = 0;
}

lib_0321::func_3646() {
  self.var_6694 = squared(512);
}

lib_0321::func_2F4F() {
  if(!isPlayer(self)) {
    return;
  }

  lib_02DC::func_9A77(0);
}

lib_0321::func_3635() {
  if(!isPlayer(self)) {
    return;
  }

  lib_02DC::func_9A77(1);
}

lib_0321::func_362A(param_00) {}

lib_0321::func_2F41() {}

lib_0321::func_4711() {
  return vehicle_getarray();
}

lib_0321::func_4D7C(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_03 = 0.5;
  level endon("clearing_hints");
  if(isDefined(level.var_4DC0)) {
    level.var_4DC0 lib_02C6::func_2DCC();
  }

  level.var_4DC0 = lib_02C6::func_27ED("default", 1.5);
  level.var_4DC0 lib_02C6::func_8707("MIDDLE", undefined, 0, 30 + param_02);
  level.var_4DC0.var_0056 = (1, 1, 1);
  level.var_4DC0 settext(param_00);
  level.var_4DC0.var_0018 = 0;
  level.var_4DC0 fadeovertime(0.5);
  level.var_4DC0.var_0018 = 1;
  wait(0.5);
  level.var_4DC0 endon("death");
  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    return;
  }

  level.var_4DC0 fadeovertime(var_03);
  level.var_4DC0.var_0018 = 0;
  wait(var_03);
  level.var_4DC0 lib_02C6::func_2DCC();
}

lib_0321::func_4D93() {
  var_00 = 1;
  if(isDefined(level.var_4DC0)) {
    level notify("clearing_hints");
    level.var_4DC0 fadeovertime(var_00);
    level.var_4DC0.var_0018 = 0;
    wait(var_00);
  }
}

lib_0321::func_59FF(param_00, param_01, param_02) {
  if(!isDefined(level.var_3C77[param_00])) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_04 in level.var_2AA2[param_00]) {
    foreach(var_06 in var_04) {
      if(isalive(var_06)) {
        var_06 thread lib_0322::func_5A00(param_01, param_02);
        continue;
      }

      var_06 delete();
    }
  }
}

lib_0321::func_42AE(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = "player_view_controller";
  }

  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  var_04 = param_00 gettagorigin(param_01);
  var_05 = spawnturret("misc_turret", var_04, param_03);
  var_05.var_001D = param_00 gettagangles(param_01);
  var_05 setModel("tag_turret");
  var_05 linkto(param_00, param_01, param_02, (0, 0, 0));
  var_05 makeunusable();
  var_05 method_805C();
  var_05 setmode("manual");
  return var_05;
}

lib_0321::func_2784(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04 childthread lib_0322::func_7744(param_00, self, param_01, param_02, param_03);
  return var_04;
}

lib_0321::func_85BD(param_00, param_01) {
  if(!isDefined(self.var_A08B)) {
    self.var_A08B = [];
  }

  if(!isDefined(param_01) || param_01) {
    self.var_A08B[param_00] = 1;
    return;
  }

  self.var_A08B[param_00] = undefined;
}

lib_0321::func_5639(param_00) {
  if(!isDefined(self.var_A08B)) {
    return 0;
  }

  return isDefined(self.var_A08B[param_00]);
}

lib_0321::func_941E(param_00) {
  if(!isDefined(self.var_9429)) {
    self.var_9429 = [];
  }

  if(!isDefined(self.var_A08B)) {
    self.var_A08B = [];
  }

  var_01 = [];
  var_02 = self getweaponslistall();
  var_03 = self getcurrentweapon();
  var_04 = self method_834A();
  var_05 = self method_831F();
  foreach(var_07 in var_02) {
    if(isDefined(self.var_A08B[var_07])) {
      continue;
    }

    var_01[var_07] = [];
    var_01[var_07]["clip_left"] = self getweaponammoclip(var_07, "left");
    var_01[var_07]["clip_right"] = self getweaponammoclip(var_07, "right");
    var_01[var_07]["stock"] = self getweaponammostock(var_07);
  }

  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  self.var_9429[param_00] = [];
  if(isDefined(self.var_A08B[var_03])) {
    var_09 = self getweaponslistprimaries();
    foreach(var_07 in var_09) {
      if(!isDefined(self.var_A08B[var_07])) {
        var_03 = var_07;
        break;
      }
    }
  }

  self.var_9429[param_00]["current_weapon"] = var_03;
  self.var_9429[param_00]["inventory"] = var_01;
  self.var_9429[param_00]["lethal_offhand"] = var_04;
  self.var_9429[param_00]["tactical_offhand"] = var_05;
}

lib_0321::func_7DEA(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(self.var_9429) || !isDefined(self.var_9429[param_00])) {
    return;
  }

  self takeallweapons();
  foreach(var_03, var_02 in self.var_9429[param_00]["inventory"]) {
    if(function_01D4(var_03) != "altmode") {
      self giveweapon(var_03);
    }

    self method_82FA(var_03, var_02["clip_left"], "left");
    self method_82FA(var_03, var_02["clip_right"], "right");
    self setweaponammostock(var_03, var_02["stock"]);
  }

  var_04 = self.var_9429[param_00]["current_weapon"];
  if(var_04 != "none") {
    self switchtoweapon(var_04);
  }

  self method_8349(self.var_9429[param_00]["lethal_offhand"]);
  self method_831E(self.var_9429[param_00]["tactical_offhand"]);
}

lib_0321::func_4353() {
  var_00 = self getweaponslistall();
  if(isDefined(self.var_A08B)) {
    foreach(var_02 in var_00) {
      if(isDefined(self.var_A08B[var_02])) {
        var_00 = common_scripts\utility::func_0F93(var_00, var_02);
      }
    }
  }

  return var_00;
}

lib_0321::func_4354() {
  var_00 = self getweaponslistprimaries();
  if(isDefined(self.var_A08B)) {
    foreach(var_02 in var_00) {
      if(isDefined(self.var_A08B[var_02])) {
        var_00 = common_scripts\utility::func_0F93(var_00, var_02);
      }
    }
  }

  return var_00;
}

lib_0321::func_4352() {
  var_00 = self getcurrentprimaryweapon();
  if(isDefined(self.var_A08B) && isDefined(self.var_A08B[var_00])) {
    var_00 = lib_0321::func_4190();
  }

  return var_00;
}

lib_0321::func_4351() {
  var_00 = self getcurrentweapon();
  if(isDefined(self.var_A08B) && isDefined(self.var_A08B[var_00])) {
    var_00 = lib_0321::func_4190();
  }

  return var_00;
}

lib_0321::func_4190() {
  var_00 = lib_0321::func_4354();
  if(var_00.size > 0) {
    var_01 = var_00[0];
  } else {
    var_01 = "none";
  }

  return var_01;
}

lib_0321::func_4CE0() {
  switch (self.var_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self method_805C();
      break;

    case "script_brushmodel":
      self method_805C();
      self notsolid();
      if(self.var_0187 & 1) {
        self method_8060();
      }
      break;

    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::func_9D9F();
      break;

    default:
      break;
  }
}

lib_0321::func_8BC7() {
  switch (self.var_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self method_805B();
      break;

    case "script_brushmodel":
      self method_805B();
      self solid();
      if(self.var_0187 & 1) {
        self method_805F();
      }
      break;

    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::func_9DA3();
      break;

    default:
      break;
  }
}

lib_0321::func_06B0(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    self rotateyaw(param_00, param_01, param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    self rotateyaw(param_00, param_01, param_02);
    return;
  }

  self rotateyaw(param_00, param_01);
}

lib_0321::func_8530(param_00, param_01, param_02) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  if(isDefined(param_02) && param_02) {
    thread lib_0321::func_8531(param_00, param_01);
  }

  if(!isDefined(self.var_64BB)) {
    self.var_64BB = self.var_64BA;
  }

  if(isDefined(param_01)) {
    var_03 = param_00 - self.var_64BA;
    var_04 = 0.05;
    var_05 = param_01 / var_04;
    var_06 = var_03 / var_05;
    while(abs(param_00 - self.var_64BA) > abs(var_06 * 1.1)) {
      self.var_64BA = self.var_64BA + var_06;
      wait(var_04);
    }
  }

  self.var_64BA = param_00;
}

lib_0321::func_7DE4(param_00, param_01) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  if(isDefined(param_01) && param_01) {
    thread lib_0321::func_7DE5(param_00);
  }

  lib_0321::func_8530(self.var_64BB, param_00, 0);
  self.var_64BB = undefined;
}

lib_0321::func_8531(param_00, param_01) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  if(!isDefined(self.var_64E0)) {
    self.var_64E0 = self.var_64DF;
  }

  if(isDefined(param_01)) {
    var_02 = param_00 - self.var_64DF;
    var_03 = 0.05;
    var_04 = param_01 / var_03;
    var_05 = var_02 / var_04;
    while(abs(param_00 - self.var_64DF) > abs(var_05 * 1.1)) {
      self.var_64DF = self.var_64DF + var_05;
      wait(var_03);
    }
  }

  self.var_64DF = param_00;
}

lib_0321::func_7DE5(param_00) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  lib_0321::func_8531(self.var_64E0, param_00);
  self.var_64E0 = undefined;
}

lib_0321::func_0FAA(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in param_00) {
    var_07 thread lib_0321::func_0961(param_01, param_02, param_03, param_04, param_05);
  }
}

lib_0321::func_0FAC(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getEntArray(param_00, "targetname");
  lib_0321::func_0FAA(var_06, param_01, param_02, param_03, param_04, param_05);
}

lib_0321::func_0FAB(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getEntArray(param_00, "script_noteworthy");
  lib_0321::func_0FAA(var_06, param_01, param_02, param_03, param_04, param_05);
}

lib_0321::func_3619() {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0A83(1);
    return;
  }

  self.var_3247 = 1;
}

lib_0321::func_2F32() {
  if(lib_0290::func_0AAE()) {
    lib_0290::func_0A83(0);
    return;
  }

  self.var_3247 = undefined;
}

lib_0321::func_27BF(param_00) {
  if(!isDefined(level.var_94E8)) {
    level.var_94E8 = [];
  }

  var_01 = spawnStruct();
  var_01.var_0109 = param_00;
  level.var_94E8[param_00] = var_01;
  return var_01;
}

lib_0321::func_27C6(param_00) {
  if(!isDefined(level.var_A565)) {
    level.var_A565 = [];
  }

  var_01 = spawnStruct();
  var_01.var_0109 = param_00;
  var_01.var_1105 = 0;
  var_01.var_110E = 0;
  var_01.var_110F = 0;
  var_01.var_1104 = 1;
  var_01.var_10FF = 0;
  var_01.var_1100 = 1;
  var_01.var_1101 = 0;
  var_01.var_111F = 0;
  var_01.var_1115 = 0;
  var_01.var_1116 = 0;
  var_01.var_1117 = 0;
  var_01.var_1120 = 0;
  var_01.var_111C = 0;
  var_01.var_111D = 0;
  var_01.var_111E = 0;
  var_01.var_1122 = 0;
  var_01.var_1125 = 0;
  var_01.var_1123 = (0, 0, 0);
  var_01.var_111B = 0;
  var_01.var_1124 = 0;
  var_01.var_1118 = 0;
  var_01.var_1119 = 0;
  var_01.var_111A = 0;
  var_01.var_1121 = 0;
  level.var_A565[tolower(param_00)] = var_01;
  return var_01;
}

lib_0321::func_43CB(param_00) {
  if(!isDefined(level.var_A565)) {
    level.var_A565 = [];
  }

  var_01 = level.var_A565[tolower(param_00)];
  if(lib_0321::func_A251() && isDefined(var_01) && isDefined(var_01.var_4BD4)) {
    var_01 = level.var_A565[tolower(var_01.var_4BD4)];
  }

  return var_01;
}

lib_0321::func_279B(param_00) {
  if(!isDefined(level.var_3DA7)) {
    level.var_3DA7 = [];
  }

  var_01 = spawnStruct();
  var_01.var_0109 = param_00;
  level.var_3DA7[tolower(param_00)] = var_01;
  return var_01;
}

lib_0321::func_419B(param_00) {
  if(!isDefined(level.var_3DA7)) {
    level.var_3DA7 = [];
  }

  var_01 = level.var_3DA7[tolower(param_00)];
  return var_01;
}

lib_0321::func_525B() {
  if(!isDefined(self.var_3DA9)) {
    self.var_3DA9 = spawnStruct();
    self.var_3DA9.var_3DAC = "";
    self.var_3DA9.var_99DA = 0;
  }
}

lib_0321::func_A251() {
  if(!isDefined(level.var_258F)) {
    lib_0321::func_843E();
  }

  return lib_0321::func_5583();
}

lib_0321::func_3DA8(param_00, param_01) {
  if(!isPlayer(self)) {
    lib_0298::func_51D3();
  } else {
    lib_0321::func_525B();
  }

  if(!isDefined(level.var_3DA7)) {
    level.var_3DA7 = [];
  }

  var_02 = level.var_3DA7[tolower(param_00)];
  if(!isDefined(var_02)) {
    var_02 = level.var_A565[tolower(param_00)];
  }

  if(isDefined(var_02) && isDefined(var_02.var_4BD4) && lib_0321::func_A251()) {
    if(isDefined(level.var_3DA7[tolower(var_02.var_4BD4)])) {
      var_02 = level.var_3DA7[tolower(var_02.var_4BD4)];
    } else if(isDefined(level.var_A565)) {
      var_02 = level.var_A565[tolower(var_02.var_4BD4)];
    }
  }

  if(!isDefined(param_01)) {
    param_01 = var_02.var_9C83;
  }

  if(!isPlayer(self)) {
    common_scripts\utility::func_84A0(var_02, param_01);
    level.var_3DA9.var_3DAC = param_00;
    level.var_3DA9.var_99DA = param_01;
    return;
  }

  if(param_00 != "" && self.var_3DA9.var_3DAC == param_00 && self.var_3DA9.var_99DA == param_01) {
    return;
  }

  common_scripts\utility::func_84A0(var_02, param_01);
  self.var_3DA9.var_3DAC = param_00;
  self.var_3DA9.var_99DA = param_01;
}

lib_0321::func_A566(param_00, param_01) {
  var_02 = lib_0321::func_A564(param_00, param_01);
  if(var_02) {
    if(isDefined(lib_0321::func_43CB(param_00))) {
      lib_0321::func_3DA8(param_00, param_01);
      return;
    }

    clearfog(param_01);
  }
}

lib_0321::func_525C() {
  if(!isDefined(self.var_A569)) {
    self.var_A569 = spawnStruct();
    self.var_A569.var_A563 = "";
    self.var_A569.var_99DA = 0;
  }
}

lib_0321::func_A564(param_00, param_01) {
  if(!isPlayer(self)) {
    var_02 = 1;
    if(!isDefined(level.var_A569)) {
      level.var_A569 = spawnStruct();
      level.var_A569.var_A563 = "";
      level.var_A569.var_99DA = 0;
      var_02 = 0;
    }

    if(param_00 != "" && level.var_A569.var_A563 == param_00 && level.var_A569.var_99DA == param_01) {
      return 0;
    }

    level.var_A569.var_A563 = param_00;
    level.var_A569.var_99DA = param_01;
    if(var_02 && getdvarint("scr_art_tweak") != 0) {} else {
      visionsetnaked(param_00, param_01);
    }

    level.var_5F53 = param_00;
    setDvar("vision_set_current", param_00);
  } else {
    lib_0321::func_525C();
    if(param_01 != "" && self.var_A569.var_A563 == param_01 && self.var_A569.var_99DA == var_02) {
      return 0;
    }

    self.var_A569.var_A563 = param_01;
    self.var_A569.var_99DA = var_02;
    self visionsetnakedforplayer(param_01, var_02);
  }

  return 1;
}

lib_0321::func_3647() {
  thread lib_0321::func_3648();
}

lib_0321::func_3648() {
  self endon("death");
  for(;;) {
    self.var_9855 = 1;
    wait 0.05;
  }
}

lib_0321::func_2F60() {
  self.var_9855 = undefined;
}

lib_0321::func_06A4(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    radiusdamage(param_00, param_01, param_02, param_03);
    return;
  }

  radiusdamage(param_00, param_01, param_02, param_03, param_04);
}

lib_0321::func_6016(param_00) {
  var_01 = getEntArray("destructible_toy", "targetname");
  var_02 = getEntArray("destructible_vehicle", "targetname");
  var_03 = common_scripts\utility::func_0F73(var_01, var_02);
  foreach(var_05 in param_00) {
    var_05.var_2E27 = [];
  }

  foreach(var_08 in var_03) {
    foreach(var_05 in param_00) {
      if(!var_05 istouching(var_08)) {
        continue;
      }

      var_05 lib_0322::func_77C4(var_08);
      break;
    }
  }
}

lib_0321::func_540C() {
  var_00 = [];
  var_00[0] = ["interactive_birds", "targetname"];
  var_00[1] = ["interactive_vulture", "targetname"];
  var_00[2] = ["interactive_fish", "script_noteworthy"];
  return var_00;
}

lib_0321::func_6018(param_00) {
  var_01 = lib_0321::func_540C();
  var_02 = [];
  foreach(var_04 in var_01) {
    var_05 = getEntArray(var_04[0], var_04[1]);
    var_02 = common_scripts\utility::func_0F73(var_02, var_05);
  }

  foreach(var_08 in var_02) {
    if(!isDefined(level.var_065F[var_08.var_540A].var_806C)) {
      continue;
    }

    foreach(var_0B in param_00) {
      if(!var_0B istouching(var_08)) {
        continue;
      }

      if(!isDefined(var_0B.var_540D)) {
        var_0B.var_540D = [];
      }

      var_0B.var_540D[var_0B.var_540D.size] = var_08[[level.var_065F[var_08.var_540A].var_806C]]();
    }
  }
}

lib_0321::func_0896() {
  if(!isDefined(self.var_540D)) {
    return;
  }

  foreach(var_01 in self.var_540D) {
    var_01[[level.var_065F[var_01.var_540A].var_5DEB]]();
  }

  self.var_540D = undefined;
}

lib_0321::func_2D13(param_00) {
  lib_0321::func_6018(param_00);
  foreach(var_02 in param_00) {
    var_02.var_540D = undefined;
  }
}

lib_0321::func_6017(param_00) {
  if(getDvar("1459") != "") {
    return;
  }

  var_01 = getEntArray("script_brushmodel", "classname");
  var_02 = getEntArray("script_model", "classname");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_01[var_01.size] = var_02[var_03];
  }

  foreach(var_05 in param_00) {
    foreach(var_07 in var_01) {
      if(isDefined(var_07.var_8272)) {
        var_07.var_8186 = var_07.var_8272;
      }

      if(!isDefined(var_07.var_8186)) {
        continue;
      }

      if(!isDefined(var_07.var_0106)) {
        continue;
      }

      if(var_07.var_003B != "script_model") {
        continue;
      }

      if(!var_07 istouching(var_05)) {
        continue;
      }

      var_07.var_6019 = 1;
    }
  }
}

lib_0321::func_0892() {
  foreach(var_01 in level.var_2804) {
    if(!isDefined(var_01.var_A265["masked_exploder"])) {
      continue;
    }

    if(!self method_858B(var_01.var_A265["origin"])) {
      continue;
    }

    var_02 = var_01.var_A265["masked_exploder"];
    var_03 = var_01.var_A265["masked_exploder_spawnflags"];
    var_04 = var_01.var_A265["masked_exploder_script_disconnectpaths"];
    var_05 = spawn("script_model", (0, 0, 0), var_03);
    var_05 setModel(var_02);
    var_05.var_0116 = var_01.var_A265["origin"];
    var_05.var_001D = var_01.var_A265["angles"];
    var_01.var_A265["masked_exploder"] = undefined;
    var_01.var_A265["masked_exploder_spawnflags"] = undefined;
    var_01.var_A265["masked_exploder_script_disconnectpaths"] = undefined;
    var_05.var_2FBF = var_04;
    var_05.var_8186 = var_01.var_A265["exploder"];
    common_scripts\_exploder::func_885C(var_05);
    var_01.var_0106 = var_05;
  }
}

lib_0321::func_7642(param_00) {
  var_01 = common_scripts\_destructible::func_2E02(param_00);
  if(var_01 != -1) {
    return;
  }

  if(!isDefined(level.var_2DFA)) {
    level.var_2DFA = [];
  }

  var_02 = spawnStruct();
  var_02.var_2E25 = common_scripts\_destructible::func_2E03(param_00);
  var_02 thread common_scripts\_destructible::func_7643();
  var_02 thread common_scripts\_destructible::func_091C();
}

lib_0321::func_2D07(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03.var_2E27 = [];
  }

  var_05 = ["destructible_toy", "destructible_vehicle"];
  var_06 = 0;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_08 in var_05) {
    var_09 = getEntArray(var_08, "targetname");
    foreach(var_0B in var_09) {
      foreach(var_03 in param_00) {
        if(param_01) {
          var_06++;
          var_06 = var_06 % 5;
          if(var_06 == 1) {
            wait 0.05;
          }
        }

        if(!var_03 istouching(var_0B)) {
          continue;
        }

        var_0B delete();
        break;
      }
    }
  }
}

lib_0321::func_2D0E(param_00, param_01) {
  var_02 = getEntArray("script_brushmodel", "classname");
  var_03 = getEntArray("script_model", "classname");
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_02[var_02.size] = var_03[var_04];
  }

  var_05 = [];
  var_06 = spawn("script_origin", (0, 0, 0));
  var_07 = 0;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_09 in param_00) {
    foreach(var_0B in var_02) {
      if(!isDefined(var_0B.var_8186)) {
        continue;
      }

      var_06.var_0116 = var_0B getorigin();
      if(!var_09 istouching(var_06)) {
        continue;
      }

      var_05[var_05.size] = var_0B;
    }
  }

  lib_0321::func_0F7B(var_05);
  var_06 delete();
}

lib_0321::func_0890() {
  if(!isDefined(self.var_2E27)) {
    return;
  }

  foreach(var_01 in self.var_2E27) {
    var_02 = spawn("script_model", (0, 0, 0));
    var_02 setModel(var_01.var_9B7A);
    var_02.var_0116 = var_01.var_0116;
    var_02.var_001D = var_01.var_001D;
    var_02.var_0165 = var_01.var_0165;
    var_02.var_01A5 = var_01.var_01A5;
    var_02.var_01A2 = var_01.var_01A2;
    var_02.var_81EF = var_01.var_81EF;
    var_02.var_0075 = var_01.var_0075;
    var_02.var_8249 = var_01.var_8249;
    var_02 common_scripts\_destructible::func_87D2(1);
  }

  self.var_2E27 = [];
}

lib_0321::func_8684(param_00) {
  self.var_3D41 = param_00;
}

lib_0321::func_3D40() {
  var_00 = self.var_3D48 - gettime();
  if(var_00 < 0) {
    return 0;
  }

  return var_00 * 0.001;
}

lib_0321::func_3D42() {
  return lib_0321::func_3D40() > 0;
}

lib_0321::func_3D44(param_00) {
  if(isDefined(self.var_3D41) && self.var_3D41) {
    return;
  }

  var_01 = gettime() + param_00 * 1000;
  if(isDefined(self.var_3D48)) {
    self.var_3D48 = max(self.var_3D48, var_01);
  } else {
    self.var_3D48 = var_01;
  }

  self notify("flashed");
  self method_8167(1);
}

lib_0321::func_A76C() {
  for(;;) {
    var_00 = function_00CC("axis", "all");
    var_01 = 0;
    foreach(var_03 in var_00) {
      if(!isalive(var_03)) {
        continue;
      }

      if(var_03 istouching(self)) {
        var_01 = 1;
        break;
      }

      wait(0.0125);
    }

    if(!var_01) {
      var_05 = lib_0321::func_4069("axis");
      if(!var_05.size) {
        break;
      }
    }

    wait 0.05;
  }
}

lib_0321::func_A76D() {
  var_00 = 0;
  for(;;) {
    var_01 = function_00CC("axis", "all");
    var_02 = 0;
    foreach(var_04 in var_01) {
      if(!isalive(var_04)) {
        continue;
      }

      if(var_04 istouching(self)) {
        if(var_04 lib_0321::func_3201()) {
          continue;
        }

        var_02 = 1;
        var_00 = 1;
        break;
      }

      wait(0.0125);
    }

    if(!var_02) {
      var_06 = lib_0321::func_4069("axis");
      if(!var_06.size) {
        break;
      } else {
        var_00 = 1;
      }
    }

    wait 0.05;
  }

  return var_00;
}

lib_0321::func_A76E(param_00) {
  lib_0321::func_A76C();
  common_scripts\utility::func_3C8F(param_00);
}

lib_0321::func_A762(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02 lib_0321::func_A76E(param_01);
}

lib_0321::func_7236() {
  level.var_721C common_scripts\utility::func_3796("player_zero_attacker_accuracy");
  level.var_721C.var_00D1 = 0;
  level.var_721C lib_02BA::func_A0C1();
}

lib_0321::func_723D() {
  level.var_721C common_scripts\utility::func_379A("player_zero_attacker_accuracy");
  level.var_721C.var_0022 = 0;
  level.var_721C.var_00D1 = 1;
}

lib_0321::func_8552(param_00) {
  var_01 = lib_0321::func_429A();
  var_01.var_489A.var_722F = param_00;
  var_01 lib_02BA::func_A0C1();
}

lib_0321::func_0F84(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_03.var_8260] = var_03;
  }

  return var_01;
}

lib_0321::func_0F83(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_03.var_003A] = var_03;
  }

  return var_01;
}

lib_0321::func_0F85(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_04 = var_03.var_81E1;
    if(isDefined(var_04)) {
      var_01[var_04] = var_03;
    }
  }

  return var_01;
}

lib_0321::func_096D(param_00) {
  if(isDefined(param_00)) {
    self.var_7001 = param_00;
  } else {
    self.var_7001 = getent(self.var_01A2, "targetname");
  }

  self linkto(self.var_7001);
}

lib_0321::func_3D45() {
  self.var_3D48 = undefined;
  self method_8167(0);
}

lib_0321::func_485C() {
  thread lib_0321::func_36DC();
  self endon("end_explode");
  self waittill("explode", var_00);
  lib_0321::func_2F11(var_00);
}

lib_0321::func_36DC() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

lib_0321::func_2F11(param_00) {
  function_01BB("grenade_rumble", param_00);
  earthquake(0.3, 0.5, param_00, 400);
  foreach(var_02 in level.var_744A) {
    if(distance(param_00, var_02.var_0116) > 600) {
      continue;
    }

    if(var_02 method_81D7(param_00)) {
      var_02 thread lib_0321::func_2F13(param_00);
    }
  }
}

lib_0321::func_7315(param_00, param_01, param_02, param_03) {
  return lib_0321::func_7313("shotgun", level.var_721C, param_00, param_01, param_02, param_03);
}

lib_0321::func_7313(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01)) {
    param_01 = level.var_721C;
  }

  param_01 method_8113(0);
  param_01 method_8114(0);
  param_01 method_8322();
  var_06 = common_scripts\utility::func_8FFC();
  var_06 linkto(self, "tag_passenger", lib_0321::func_7314(param_00), (0, 0, 0));
  var_06.var_725D = common_scripts\utility::func_8FFC();
  var_06.var_725D linkto(self, "tag_body", lib_0321::func_7312(param_00), (0, 0, 0));
  if(!isDefined(param_02)) {
    param_02 = 90;
  }

  if(!isDefined(param_03)) {
    param_03 = 90;
  }

  if(!isDefined(param_04)) {
    param_04 = 40;
  }

  if(!isDefined(param_05)) {
    param_05 = 40;
  }

  param_01 method_8322();
  param_01 playerlinkto(var_06, "tag_origin", 0.8, param_02, param_03, param_04, param_05);
  param_01.var_4FA0 = var_06;
  return var_06;
}

lib_0321::func_7314(param_00) {
  switch (param_00) {
    case "shotgun":
      return (-5, 10, -34);

    case "backleft":
      return (-45, 45, -34);

    case "backright":
      return (-45, 5, -34);
  }
}

lib_0321::func_7312(param_00) {
  switch (param_00) {
    case "shotgun":
      return (-8, -90, -12.6);

    case "backleft":
      return (-58, 85, -12.6);

    case "backright":
      return (-58, -95, -12.6);
  }
}

lib_0321::func_72DF(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = self;
  var_02 = level.var_721C;
  if(isPlayer(self)) {
    var_02 = self;
    var_01 = var_02.var_4FA0;
  }

  var_01 unlink();
  if(!param_00) {
    var_03 = 0.6;
    var_01 moveto(var_01.var_725D.var_0116, var_03, var_03 * 0.5, var_03 * 0.5);
    wait(var_03);
  }

  var_02 unlink();
  var_02 method_8323();
  var_02 method_8113(1);
  var_02 method_8114(1);
  var_02.var_4FA0 = undefined;
  var_01.var_725D delete();
  var_01 delete();
}

lib_0321::func_2F13(param_00, param_01) {
  var_02 = lib_0321::func_80E8(param_00);
  foreach(var_05, var_04 in var_02) {
    thread lib_02BA::func_485A(var_05);
  }
}

lib_0321::func_1800(param_00) {
  if(!isDefined(self.var_0063)) {
    return;
  }

  var_01 = lib_0321::func_80E8(self.var_0063.var_0116);
  foreach(var_04, var_03 in var_01) {
    thread lib_02BA::func_17FB(var_04);
  }
}

lib_0321::func_80E8(param_00) {
  var_01 = vectornormalize(anglesToForward(self.var_001D));
  var_02 = vectornormalize(anglestoright(self.var_001D));
  var_03 = vectornormalize(param_00 - self.var_0116);
  var_04 = vectordot(var_03, var_01);
  var_05 = vectordot(var_03, var_02);
  var_06 = [];
  var_07 = self getcurrentweapon();
  if(var_04 > 0 && var_04 > 0.5 && function_01A9(var_07) != "riotshield") {
    var_06["bottom"] = 1;
  }

  if(abs(var_04) < 0.866) {
    if(var_05 > 0) {
      var_06["right"] = 1;
    } else {
      var_06["left"] = 1;
    }
  }

  return var_06;
}

lib_0321::func_6EF0(param_00) {
  if(!isDefined(self.var_6A44)) {
    self.var_6A44 = self.var_0121;
  }

  self.var_0121 = param_00;
}

lib_0321::func_6EF1() {
  if(isDefined(self.var_6A44)) {
    return;
  }

  self.var_6A44 = self.var_0121;
  self.var_0121 = 0;
}

lib_0321::func_6EEF() {
  self.var_0121 = self.var_6A44;
  self.var_6A44 = undefined;
}

lib_0321::func_A7BB() {
  if(isDefined(self.var_6A51)) {
    return;
  }

  self.var_6A50 = self.var_01CE;
  self.var_6A51 = self.var_01CF;
  self.var_01CE = 0;
  self.var_01CF = 0;
}

lib_0321::func_A7B9() {
  if(!isDefined(self.var_6A51)) {
    self.var_6A50 = self.var_01CE;
    self.var_6A51 = self.var_01CF;
  }

  self.var_01CE = 999999999;
  self.var_01CF = 999999999;
}

lib_0321::func_5656() {
  return isDefined(self.var_6A51) || isDefined(self.var_6A50);
}

lib_0321::func_A7BA() {
  self.var_01CE = self.var_6A50;
  self.var_01CF = self.var_6A51;
  self.var_6A50 = undefined;
  self.var_6A51 = undefined;
}

lib_0321::func_362F() {
  thread lib_0321::func_509F();
}

lib_0321::func_509F() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.var_00D1 = 1;
  self.var_3A09 = self.var_00BC;
  self.var_00BC = 1000000;
  for(;;) {
    self waittill("damage", var_00, var_01);
    if(!isPlayer(var_01) && issentient(var_01)) {
      if(isDefined(var_01.var_0088) && var_01.var_0088 != self) {
        continue;
      }
    }

    self.var_3A09 = self.var_3A09 - var_00;
    if(self.var_3A09 <= 0) {
      break;
    }
  }

  self method_805A();
}

lib_0321::func_842B(param_00) {
  self.var_01C0 = param_00;
}

lib_0321::func_2F47() {
  if(!isalive(self)) {
    return;
  }

  if(!isDefined(self.var_00D1)) {
    return;
  }

  self notify("disable_ignorerandombulletdamage_drone");
  self.var_00D1 = undefined;
  self.var_00BC = self.var_3A09;
}

lib_0321::func_9A03(param_00) {
  var_01 = spawnStruct();
  var_01 lib_0321::func_2CED(param_00, ::lib_0321::func_83D7, "timeout");
  return var_01;
}

lib_0321::func_2CED(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  thread lib_0322::func_2CEF(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

lib_0321::func_2CC1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  childthread lib_0322::func_2CC2(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

lib_0321::func_3CC9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  if(!isarray(param_00)) {
    param_00 = [param_00, 0];
  }

  thread lib_0322::func_3CCA(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

lib_0321::func_A793(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  if(!isarray(param_00)) {
    param_00 = [param_00, 0];
  }

  thread lib_0322::func_A794(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

lib_0321::func_3617(param_00) {
  param_00 = param_00 * 1000;
  self.var_007C = 1;
  self.var_006E = param_00;
  self.var_6684 = undefined;
}

lib_0321::func_2F2F() {
  self.var_007C = 0;
  self.var_6684 = 1;
}

lib_0321::func_84C8(param_00, param_01) {
  level.var_0A19 = param_00;
  level.var_0A18 = param_01;
}

lib_0321::func_7D37(param_00) {
  level.var_5B6D[param_00] = gettime();
}

lib_0321::func_844C(param_00) {
  level.var_296A = param_00;
  thread lib_02BA::func_7D6E();
}

lib_0321::func_23AF() {
  level.var_296A = undefined;
  thread lib_02BA::func_7D6E();
}

lib_0321::func_85F7(param_00, param_01, param_02) {
  lib_0295::func_5287();
  if(isDefined(param_02)) {
    level.var_AA25.var_A2AD = param_02;
  }

  level.var_AA25.var_7A76 = param_01;
  level.var_AA25.var_A9FE = param_00;
  level notify("windchange", "strong");
}

lib_0321::func_9463(param_00) {
  if(param_00.size > 1) {
    return 0;
  }

  var_01 = [];
  var_01["0"] = 1;
  var_01["1"] = 1;
  var_01["2"] = 1;
  var_01["3"] = 1;
  var_01["4"] = 1;
  var_01["5"] = 1;
  var_01["6"] = 1;
  var_01["7"] = 1;
  var_01["8"] = 1;
  var_01["9"] = 1;
  if(isDefined(var_01[param_00])) {
    return 1;
  }

  return 0;
}

lib_0321::func_841F(param_00, param_01) {
  level.var_1639[param_00] = param_01;
  lib_0322::func_A096();
}

lib_0321::func_690A(param_00) {
  for(var_01 = 0; var_01 < 8; var_01++) {
    function_0105(param_00, var_01, (0, 0, 0));
  }
}

lib_0321::func_6909(param_00, param_01) {
  function_0105(param_00, param_01, (0, 0, 0));
}

lib_0321::func_4219(param_00) {
  var_01 = [];
  var_01["minutes"] = 0;
  for(var_01["seconds"] = int(param_00 / 1000); var_01["seconds"] >= 60; var_01["seconds"] = var_01["seconds"] - 60) {
    var_01["minutes"]++;
  }

  if(var_01["seconds"] < 10) {
    var_01["seconds"] = "0" + var_01["seconds"];
  }

  return var_01;
}

lib_0321::func_729C(param_00) {
  var_01 = level.var_721C getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(var_03 == param_00) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_68A4(param_00) {
  if(param_00 == "main") {
    return 31;
  }

  if(!isDefined(level.var_68A7)) {
    level.var_68A7 = [];
  }

  if(!isDefined(level.var_68A7[param_00])) {
    level.var_68A7[param_00] = level.var_68A7.size + 1;
  }

  return level.var_68A7[param_00];
}

lib_0321::func_68C8(param_00) {
  return isDefined(level.var_68A7) && isDefined(level.var_68A7[param_00]);
}

lib_0321::func_72EB(param_00) {
  self method_80F3(param_00);
  self.var_3401 = param_00;
}

lib_0321::func_725E() {
  self method_80F4();
  self.var_3401 = undefined;
}

lib_0321::func_4842(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_04 - param_02;
  var_06 = param_03 - param_01;
  var_07 = var_05 / var_06;
  param_00 = param_00 - param_03;
  param_00 = var_07 * param_00;
  param_00 = param_00 + param_04;
  return param_00;
}

lib_0321::func_35FF() {
  self.var_7A70 = 1;
}

lib_0321::func_2F17() {
  self.var_7A70 = undefined;
}

lib_0321::func_3600(param_00) {
  param_00 lib_0321::func_35FF();
}

lib_0321::func_2F18(param_00) {
  param_00 lib_0321::func_2F17();
}

lib_0321::func_65BD(param_00) {
  var_01 = tablelookup("sound/soundlength.csv", 0, param_00, 1);
  if(!isDefined(var_01) || var_01 == "") {
    return -1;
  }

  var_01 = int(var_01);
  var_01 = var_01 * 0.001;
  return var_01;
}

lib_0321::func_554A(param_00) {
  var_01 = function_00D2(param_00);
  return var_01["count"];
}

lib_0321::func_2C8E(param_00) {
  level.var_5DEE = param_00;
}

lib_0321::func_98DB(param_00) {
  lib_0321::func_2C8E(param_00);
  level.var_98DC = param_00;
}

lib_0321::func_98DD(param_00) {
  level.var_1364 = param_00;
}

lib_0321::func_3F57(param_00, param_01) {
  thread lib_0321::func_3F58(param_00, param_01);
}

lib_0321::func_3F58(param_00, param_01) {
  var_02 = getent(param_00, "script_noteworthy");
  var_02 notify("new_volume_command");
  var_02 endon("new_volume_command");
  wait 0.05;
  lib_0321::func_3F56(var_02, param_01);
}

lib_0321::func_3F56(param_00, param_01) {
  param_00.var_3F4A = 1;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    lib_0321::func_0FB3(param_00.var_3F2F, ::common_scripts\utility::func_6F21);
    return;
  }

  common_scripts\utility::func_0FB2(param_00.var_3F2F, ::common_scripts\utility::func_6F21);
}

lib_0321::func_0FB3(param_00, param_01, param_02) {
  var_03 = 0;
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  var_04 = [];
  foreach(var_06 in param_00) {
    var_04[var_04.size] = var_06;
    var_03++;
    var_03 = var_03 % param_02;
    if(param_02 == 0) {
      common_scripts\utility::func_0FB2(var_04, param_01);
      wait 0.05;
      var_04 = [];
    }
  }
}

lib_0321::func_3F5A(param_00) {
  thread lib_0321::func_3F5B(param_00);
}

lib_0321::func_3F5B(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 notify("new_volume_command");
  var_01 endon("new_volume_command");
  wait 0.05;
  if(!isDefined(var_01.var_3F4A)) {
    return;
  }

  var_01.var_3F4A = undefined;
  lib_0321::func_3F59(var_01);
}

lib_0321::func_3F59(param_00) {
  common_scripts\utility::func_0FB2(param_00.var_3F2F, ::lib_0321::func_7DD3);
}

lib_0321::func_3C7F(param_00) {
  if(!isDefined(level.var_3C7D)) {
    level.var_3C7D = [];
  }

  if(!isDefined(level.var_3C7D[param_00])) {
    level.var_3C7D[param_00] = 1;
    return;
  }

  level.var_3C7D[param_00]++;
}

lib_0321::func_3C7E(param_00) {
  level.var_3C7D[param_00]--;
  level.var_3C7D[param_00] = int(max(0, level.var_3C7D[param_00]));
  if(level.var_3C7D[param_00]) {
    return;
  }

  common_scripts\utility::func_3C8F(param_00);
}

lib_0321::func_3C80(param_00, param_01) {
  level.var_3C7D[param_00] = param_01;
}

lib_0321::func_090C(param_00, param_01) {
  if(!isDefined(level.var_2359)) {
    level.var_2359 = [];
  }

  if(!isDefined(level.var_2359[param_01])) {
    level.var_2359[param_01] = [];
  }

  level.var_2359[param_01][level.var_2359[param_01].size] = param_00;
}

lib_0321::func_2359(param_00) {
  var_01 = level.var_2359[param_00];
  var_01 = common_scripts\utility::func_0FA0(var_01);
  lib_0321::func_0F7B(var_01);
  level.var_2359[param_00] = undefined;
}

lib_0321::func_235B(param_00) {
  if(!isDefined(level.var_2359)) {
    return;
  }

  if(!isDefined(level.var_2359[param_00])) {
    return;
  }

  var_01 = level.var_2359[param_00];
  var_01 = common_scripts\utility::func_0FA0(var_01);
  foreach(var_03 in var_01) {
    if(!isai(var_03)) {
      continue;
    }

    if(!isalive(var_03)) {
      continue;
    }

    if(!isDefined(var_03.var_5F6E)) {
      continue;
    }

    if(!var_03.var_5F6E) {
      continue;
    }

    var_03 lib_0321::func_93D8();
  }

  lib_0321::func_0F7B(var_01);
  level.var_2359[param_00] = undefined;
}

lib_0321::func_0980(param_00) {
  if(!isDefined(self.var_9D83)) {
    thread lib_0322::func_097F();
  }

  self.var_9D83[self.var_9D83.size] = param_00;
}

lib_0321::func_4410() {
  var_00 = [];
  var_01 = getEntArray();
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_003A)) {
      continue;
    }

    if(issubstr(var_03.var_003A, "weapon_")) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

lib_0321::func_78B3(param_00) {
  level.var_80D1[param_00] = param_00;
}

lib_0321::func_649A(param_00, param_01, param_02) {
  self notify("newmove");
  self endon("newmove");
  if(!isDefined(param_02)) {
    param_02 = 200;
  }

  var_03 = distance(self.var_0116, param_00);
  var_04 = var_03 / param_02;
  var_05 = vectornormalize(param_00 - self.var_0116);
  self moveto(param_00, var_04, 0, 0);
  self rotateto(param_01, var_04, 0, 0);
  wait(var_04);
  if(!isDefined(self)) {
    return;
  }

  self.var_01C9 = var_05 * var_03 / var_04;
}

lib_0321::func_3C8D(param_00) {
  level endon(param_00);
  self waittill("death");
  common_scripts\utility::func_3C8F(param_00);
}

lib_0321::func_3615() {
  level.var_29C4 = 1;
}

lib_0321::func_2F2D() {
  level.var_29C4 = 0;
}

lib_0321::func_555C() {
  return isDefined(level.var_29C4) && level.var_29C4 && lib_0321::func_448F() != "fu";
}

lib_0321::func_3616() {
  level.var_29C5 = 1;
}

lib_0321::func_2F2E() {
  level.var_29C5 = 0;
}

lib_0321::func_555D() {
  return isDefined(level.var_29C5) && level.var_29C5 && lib_0321::func_448F() != "fu";
}

lib_0321::func_0915() {
  lib_02A7::func_6377();
}

lib_0321::func_7C7D() {
  lib_02A7::func_940D();
}

lib_0321::func_5567() {
  if(getDvar("2803") == "1") {
    return 1;
  }

  return 0;
}

lib_0321::func_2D50(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B7(param_00, param_01);
  lib_0321::func_2D51(var_03, param_02);
}

lib_0321::func_2D4F(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00.var_0164;
  if(isDefined(var_01) && isDefined(level.var_947C["script_linkname"]) && isDefined(level.var_947C["script_linkname"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["script_linkname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["script_linkname"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["script_linkname"][var_01].size == 0) {
      level.var_947C["script_linkname"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_0165;
  if(isDefined(var_01) && isDefined(level.var_947C["script_noteworthy"]) && isDefined(level.var_947C["script_noteworthy"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["script_noteworthy"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["script_noteworthy"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["script_noteworthy"][var_01].size == 0) {
      level.var_947C["script_noteworthy"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_01A2;
  if(isDefined(var_01) && isDefined(level.var_947C["target"]) && isDefined(level.var_947C["target"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["target"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["target"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["target"][var_01].size == 0) {
      level.var_947C["target"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_01A5;
  if(isDefined(var_01) && isDefined(level.var_947C["targetname"]) && isDefined(level.var_947C["targetname"][var_01])) {
    foreach(var_04, var_03 in level.var_947C["targetname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.var_947C["targetname"][var_01][var_04] = undefined;
      }
    }

    if(level.var_947C["targetname"][var_01].size == 0) {
      level.var_947C["targetname"][var_01] = undefined;
    }
  }

  if(isDefined(level.var_9478)) {
    foreach(var_04, var_03 in level.var_9478) {
      if(param_00 == var_03) {
        level.var_9478[var_04] = undefined;
      }
    }
  }
}

lib_0321::func_2D51(param_00, param_01) {
  if(!isDefined(param_00) || !isarray(param_00) || param_00.size == 0) {
    return;
  }

  param_01 = common_scripts\utility::func_98E7(isDefined(param_01), param_01, 0);
  param_01 = common_scripts\utility::func_98E7(param_01 > 0, param_01, 0);
  if(param_01 > 0) {
    foreach(var_03 in param_00) {
      lib_0321::func_2D4F(var_03);
      wait(param_01);
    }

    return;
  }

  foreach(var_03 in param_00) {
    lib_0321::func_2D4F(var_03);
  }
}

lib_0321::func_46B6(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B5(param_00, param_01);
  lib_0321::func_2D4F(var_02);
  return var_02;
}

lib_0321::func_46B8(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B7(param_00, param_01);
  lib_0321::func_2D51(var_03, param_02);
  return var_03;
}

lib_0321::func_8677(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_03)) {
    self.var_37D4 = param_03;
  } else {
    self.var_37D4 = (0, 0, 0);
  }

  if(isDefined(param_04)) {
    self.var_37D5 = param_04;
  }

  self notify("new_head_icon");
  var_05 = newhudelem();
  var_05.var_001F = 1;
  var_05.var_0018 = 0.8;
  var_05 setshader(param_00, param_01, param_02);
  var_05 setwaypoint(0, 0, 0, 1);
  self.var_37D3 = var_05;
  lib_0321::func_A110();
  thread lib_0321::func_A10F();
  thread lib_0321::func_2DCD();
}

lib_0321::func_7CDA() {
  if(!isDefined(self.var_37D3)) {
    return;
  }

  self.var_37D3 destroy();
}

lib_0321::func_A10F() {
  self endon("new_head_icon");
  self endon("death");
  var_00 = self.var_0116;
  for(;;) {
    if(var_00 != self.var_0116) {
      lib_0321::func_A110();
      var_00 = self.var_0116;
    }

    wait 0.05;
  }
}

lib_0321::func_A110() {
  if(isDefined(self.var_37D5)) {
    var_00 = self[[self.var_37D5]]();
    if(isDefined(var_00)) {
      self.var_37D3.var_01D3 = self.var_37D4[0] + var_00[0];
      self.var_37D3.var_01D7 = self.var_37D4[1] + var_00[1];
      self.var_37D3.var_01D9 = self.var_37D4[2] + var_00[2];
      return;
    }
  }

  self.var_37D3.var_01D3 = self.var_0116[0] + self.var_37D4[0];
  self.var_37D3.var_01D7 = self.var_0116[1] + self.var_37D4[1];
  self.var_37D3.var_01D9 = self.var_0116[2] + self.var_37D4[2];
}

lib_0321::func_2DCD() {
  self endon("new_head_icon");
  self waittill("death");
  if(!isDefined(self.var_37D3)) {
    return;
  }

  self.var_37D3 destroy();
}

lib_0321::func_AA8C(param_00) {
  var_01 = param_00 - self.var_0116;
  return (vectordot(var_01, anglesToForward(self.var_001D)), -1 * vectordot(var_01, anglestoright(self.var_001D)), vectordot(var_01, anglestoup(self.var_001D)));
}

lib_0321::func_5495(param_00, param_01, param_02, param_03, param_04) {
  level.var_54C9 = spawnStruct();
  level.var_54C9.var_2567 = 3;
  level.var_54C9.var_39BC = 1.5;
  level.var_54C9.var_39B7 = undefined;
  if(isDefined(param_03)) {
    level.var_54C9.var_5D99 = [param_00, param_01, param_02, param_03];
  } else {
    level.var_54C9.var_5D99 = [param_00, param_01, param_02];
  }

  common_scripts\utility::func_6753(level.var_54C9.var_5D99, ::precachestring);
}

lib_0321::func_5496(param_00) {
  level.var_54C9.var_297B = param_00;
}

lib_0321::func_5497(param_00, param_01, param_02) {
  level.var_54C9.var_2567 = param_00;
  level.var_54C9.var_39BC = param_01;
  level.var_54C9.var_39B7 = param_02;
}

lib_0321::func_853B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01)) {
    self.var_7F6A = param_01;
  }

  if(isDefined(param_02)) {
    self.var_A7B7 = param_02;
  }

  if(isDefined(param_03)) {
    self.var_90D1 = param_03;
  }

  self.var_0E94 = param_00;
  var_0A = [];
  if(isDefined(param_04) && isDefined(param_05)) {
    var_0B = [];
    foreach(var_0D in param_06) {
      var_0B[var_0D] = param_04;
    }

    var_0A["cover_trans"] = var_0B;
    var_0F = [];
    foreach(var_0D in param_06) {
      var_0F[var_0D] = param_05;
    }

    var_0A["cover_exit"] = var_0F;
  } else if(isDefined(param_04) || isDefined(param_05)) {}

  if(isDefined(param_07)) {
    if(isDefined(param_08)) {}

    var_0A["run_turn"] = param_07;
    var_0A["walk_turn"] = param_08;
    self.var_6818 = undefined;
  } else if(isDefined(param_08)) {} else {
    self.var_6818 = 1;
  }

  if(isDefined(param_09)) {
    var_12 = [];
    var_12["stairs_up"] = param_09["stairs_up"];
    var_12["stairs_down"] = param_09["stairs_down"];
    var_12["stairs_up_in"] = param_09["stairs_up_in"];
    var_12["stairs_down_in"] = param_09["stairs_down_in"];
    var_12["stairs_up_out"] = param_09["stairs_up_out"];
    var_12["stairs_down_out"] = param_09["stairs_down_out"];
    var_0A["walk"] = var_12;
    var_0A["run"] = var_12;
    self.var_7F6B = 1;
  } else {
    self.var_7F6B = undefined;
  }

  level.var_0F4A[param_00] = var_0A;
}

lib_0321::func_23C5(param_00) {
  self.var_0E94 = undefined;
  level.var_0F4A[param_00] = undefined;
  self.var_7F6A = undefined;
  self.var_7F6B = undefined;
  self.var_A7B7 = undefined;
  self.var_90D1 = undefined;
}

lib_0321::func_7B9B(param_00, param_01, param_02) {}

lib_0321::func_0F49(param_00) {}

lib_0321::func_8417(param_00) {}

lib_0321::func_23A4() {
  if(isDefined(self.var_0E94) && self.var_0E94 == "creepwalk") {
    self.var_017C = 30;
  }

  self.var_0E94 = undefined;
  self notify("move_loop_restart");
}

lib_0321::func_8B2F(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(var_03 lib_0321::func_8B30(param_00, param_01)) {
      return 1;
    }
  }

  return 0;
}

lib_0321::func_8B30(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 60;
  }

  var_03 = self method_8216(0, 0, 0);
  var_04 = var_03 - param_00;
  var_05 = length(var_04);
  var_06 = asin(clamp(param_02 / var_05, 0, 1));
  if(vectordot(vectornormalize(var_04), vectornormalize(param_01 - param_00)) > cos(var_06)) {
    return 1;
  }

  return 0;
}

lib_0321::func_9C60(param_00) {
  function_0209(param_00);
  while(!istransientqueued(param_00)) {
    wait(0.1);
  }

  common_scripts\utility::func_3C8F(param_00 + "_loaded");
}

lib_0321::func_9C62(param_00) {
  function_020A(param_00);
  while(istransientqueued(param_00)) {
    wait(0.1);
  }

  common_scripts\utility::func_3C7B(param_00 + "_loaded");
}

lib_0321::func_9C5F(param_00) {
  common_scripts\utility::func_3C87(param_00 + "_loaded");
}

lib_0321::func_9C61(param_00, param_01) {
  if(common_scripts\utility::func_3C77(param_00 + "_loaded")) {
    lib_0321::func_9C62(param_00);
  }

  if(!common_scripts\utility::func_3C77(param_01 + "_loaded")) {
    lib_0321::func_9C60(param_01);
  }
}

lib_0321::func_9C63(param_00) {
  function_020B();
  lib_0321::func_9C60(param_00);
}

lib_0321::func_2B7A(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    foreach(var_04 in param_00) {
      if(isDefined(var_04)) {
        if(isarray(var_04)) {
          lib_0321::func_2B7A(var_04, param_01);
          continue;
        }

        var_04[[param_01]]();
      }
    }

    return;
  }

  switch (param_02.size) {
    case 0:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]]();
        }
      }
      break;

    case 1:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]](param_02[0]);
        }
      }
      break;

    case 2:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]](param_02[0], param_02[1]);
        }
      }
      break;

    case 3:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]](param_02[0], param_02[1], param_02[2]);
        }
      }
      break;

    case 4:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]](param_02[0], param_02[1], param_02[2], param_02[3]);
        }
      }
      break;

    case 5:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7A(var_04, param_01, param_02);
            continue;
          }

          var_04[[param_01]](param_02[0], param_02[1], param_02[2], param_02[3], param_02[4]);
        }
      }
      break;
  }
}

lib_0321::func_2B7B(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    foreach(var_04 in param_00) {
      if(isDefined(var_04)) {
        if(isarray(var_04)) {
          lib_0321::func_2B7B(var_04, param_01, param_02);
          continue;
        }

        var_04 thread[[param_01]]();
      }
    }

    return;
  }

  switch (param_02.size) {
    case 0:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]]();
        }
      }
      break;

    case 1:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]](param_02[0]);
        }
      }
      break;

    case 2:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]](param_02[0], param_02[1]);
        }
      }
      break;

    case 3:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]](param_02[0], param_02[1], param_02[2]);
        }
      }
      break;

    case 4:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]](param_02[0], param_02[1], param_02[2], param_02[3]);
        }
      }
      break;

    case 5:
      foreach(var_04 in param_00) {
        if(isDefined(var_04)) {
          if(isarray(var_04)) {
            lib_0321::func_2B7B(var_04, param_01, param_02);
            continue;
          }

          var_04 thread[[param_01]](param_02[0], param_02[1], param_02[2], param_02[3], param_02[4]);
        }
      }
      break;
  }
}

lib_0321::func_8670(param_00, param_01, param_02) {
  if(!isDefined(level.var_258F)) {
    lib_0321::func_843E();
  }

  if(lib_0321::func_5583()) {
    setDvar(param_00, param_02);
    return;
  }

  setDvar(param_00, param_01);
}

lib_0321::func_871B(param_00, param_01, param_02) {
  if(!isDefined(level.var_258F)) {
    lib_0321::func_843E();
  }

  if(lib_0321::func_5583()) {
    function_00C8(param_00, param_02);
    return;
  }

  function_00C8(param_00, param_01);
}

lib_0321::func_3DC5(param_00, param_01) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait(0.1);
  var_02 = param_00;
  var_03 = undefined;
  var_04 = undefined;
  if(!isDefined(param_01)) {
    param_01 = 300;
  }

  self.var_28F9 = var_02;
  var_02 common_scripts\utility::func_0161();
  while(isDefined(var_02)) {
    self.var_28F9 = var_02;
    if(isDefined(var_02.var_00F0)) {
      break;
    }

    if(isDefined(level.var_947C["targetname"][var_02.var_01A5])) {
      var_04 = ::lib_0321::func_3DC8;
    } else if(isDefined(var_02.var_003A)) {
      var_04 = ::lib_0321::func_3DC6;
    } else {
      var_04 = ::lib_0321::func_3DC7;
    }

    if(isDefined(var_02.var_014F) && var_02.var_014F != 0) {
      self.var_00AE = var_02.var_014F;
    }

    if(self.var_00AE < 16) {
      self.var_00AE = 16;
    }

    if(isDefined(var_02.var_00BD) && var_02.var_00BD != 0) {
      self.var_00AC = var_02.var_00BD;
    }

    var_05 = self.var_00AE;
    self childthread[[var_04]](var_02);
    if(isDefined(var_02.var_0EA4)) {
      var_02 waittill(var_02.var_0EA4);
    } else {
      for(;;) {
        self waittill("goal");
        if(distance(var_02.var_0116, self.var_0116) < var_05 + 10 || self.var_01A7 != "allies") {
          break;
        }
      }
    }

    var_02 notify("trigger", self);
    if(isDefined(var_02.var_81A0)) {
      common_scripts\utility::func_3C8F(var_02.var_81A0);
    }

    if(isDefined(var_02.var_8260)) {
      var_06 = strtok(var_02.var_8260, " ");
      for(var_07 = 0; var_07 < var_06.size; var_07++) {
        if(isDefined(level.var_2967)) {
          self[[level.var_2967]](var_06[var_07], var_02);
        }

        if(self.var_01B9 == "dog") {
          continue;
        }

        switch (var_06[var_07]) {
          case "enable_cqb":
            lib_0321::func_3612();
            break;

          case "disable_cqb":
            lib_0321::func_2F2B();
            break;

          case "deleteme":
            self delete();
            break;
        }
      }
    }

    if(!isDefined(var_02.var_8279) && param_01 > 0 && self.var_01A7 == "allies") {
      while(isalive(level.var_721C)) {
        if(lib_0321::func_3DC9(var_02, param_01)) {
          break;
        }

        if(isDefined(var_02.var_0EA4)) {
          self.var_00AE = var_05;
          self method_81A2(self.var_0116);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_02.var_01A2)) {
      break;
    }

    if(isDefined(var_02.var_81A3)) {
      common_scripts\utility::func_3C9F(var_02.var_81A3);
    }

    var_02 common_scripts\utility::func_0161();
    var_02 = var_02 common_scripts\utility::func_4375();
  }

  self notify("path_end_reached");
}

lib_0321::func_3DC9(param_00, param_01) {
  if(distance(level.var_721C.var_0116, param_00.var_0116) < distance(self.var_0116, param_00.var_0116)) {
    return 1;
  }

  var_02 = undefined;
  var_02 = anglesToForward(self.var_001D);
  var_03 = vectornormalize(level.var_721C.var_0116 - self.var_0116);
  if(isDefined(param_00.var_01A2)) {
    var_04 = common_scripts\utility::func_4375(param_00.var_01A2);
    var_02 = vectornormalize(var_04.var_0116 - param_00.var_0116);
  } else if(isDefined(param_00.var_001D)) {
    var_02 = anglesToForward(param_00.var_001D);
  } else {
    var_02 = anglesToForward(self.var_001D);
  }

  if(vectordot(var_02, var_03) > 0) {
    return 1;
  }

  if(distance(level.var_721C.var_0116, self.var_0116) < param_01) {
    return 1;
  }

  return 0;
}

lib_0321::func_3DC7(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.var_0EA4)) {
    param_00 lib_0293::func_0E0F(self, param_00.var_0EA4);
    self notify("starting_anim", param_00.var_0EA4);
    if(isDefined(param_00.var_8260) && issubstr(param_00.var_8260, "gravity")) {
      param_00 lib_0293::func_0E0B(self, param_00.var_0EA4);
    } else {
      param_00 lib_0293::func_0E11(self, param_00.var_0EA4);
    }

    self method_81A2(self.var_0116);
    return;
  }

  lib_0321::func_84C0(param_00);
}

lib_0321::func_3DC6(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.var_0EA4)) {
    param_00 lib_0293::func_0E0F(self, param_00.var_0EA4);
    self notify("starting_anim", param_00.var_0EA4);
    if(isDefined(param_00.var_8260) && issubstr(param_00.var_8260, "gravity")) {
      param_00 lib_0293::func_0E0B(self, param_00.var_0EA4);
    } else {
      param_00 lib_0293::func_0E11(self, param_00.var_0EA4);
    }

    self method_81A2(self.var_0116);
    return;
  }

  lib_0321::func_84BA(param_00);
}

lib_0321::func_3DC8(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.var_0EA4)) {
    param_00 lib_0293::func_0E0F(self, param_00.var_0EA4);
    self notify("starting_anim", param_00.var_0EA4);
    lib_0321::func_2F36();
    if(isDefined(param_00.var_8260) && issubstr(param_00.var_8260, "gravity")) {
      param_00 lib_0293::func_0E0B(self, param_00.var_0EA4);
    } else {
      param_00 lib_0293::func_0E11(self, param_00.var_0EA4);
    }

    lib_0321::func_2CED(0.05, ::lib_0321::func_361D);
    self method_81A2(self.var_0116);
    return;
  }

  lib_0321::func_84C2(param_00.var_0116);
}

lib_0321::func_75CE(param_00) {
  if(!isDefined(level.var_75CD)) {
    level.var_75CD = [];
  }

  level.var_75CD = common_scripts\utility::func_0F6F(level.var_75CD, param_00);
}

lib_0321::func_5CA2(param_00, param_01) {
  thread lib_0321::func_5CA3(param_00, param_01);
}

lib_0321::func_5CA3(param_00, param_01) {
  self notify("new_lerp_Fov_Saved");
  self endon("new_lerp_Fov_Saved");
  self method_8035(param_00, param_01);
  wait(param_01);
  function_00C8("cg_fov", param_00);
}

lib_0321::func_44A9(param_00, param_01) {
  var_02 = getDvar(param_00);
  if(var_02 != "") {
    return float(var_02);
  }

  return param_01;
}

lib_0321::func_44AA(param_00, param_01) {
  var_02 = getDvar(param_00);
  if(var_02 != "") {
    return int(var_02);
  }

  return param_01;
}

lib_0321::func_9FED(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setDvar(var_01, "on");
}

lib_0321::func_9FEC(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setDvar(var_01, "turn_off");
}

lib_0321::func_9FEE(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setDvar(var_01, "onetime");
}

lib_0321::func_94C1(param_00, param_01, param_02, param_03) {
  if(!isarray(param_00)) {
    param_00 = [param_00];
  }

  var_04 = 320;
  var_05 = 200;
  var_06 = [];
  foreach(var_0A, var_08 in param_00) {
    var_09 = lib_02CB::func_94C3(var_08, param_01, var_04, var_05 + var_0A * 20, "center", param_02, param_03);
    var_06 = common_scripts\utility::func_0F73(var_09, var_06);
  }

  wait(param_01);
  lib_02CB::func_94C2(var_06, var_04, var_05, param_00.size);
}

lib_0321::func_2076(param_00) {
  thread lib_02CB::func_206F(param_00);
}

lib_0321::func_363E(param_00) {
  if(!lib_0321::func_8017()) {
    return;
  }

  if(isDefined(self.var_60B9) && self.var_60B9) {
    return;
  }

  if(!level.var_010B) {
    return;
  }

  if(isDefined(param_00) && param_00) {
    if(!isDefined(self.var_0E94) || self.var_0E94 == "soldier") {
      self.var_0E94 = "s1_soldier";
      return;
    }

    return;
  }

  if(!isDefined(self.var_0E94) || self.var_0E94 == "s1_soldier") {
    self.var_0E94 = "soldier";
  }
}

lib_0321::func_8017() {
  return 0;
}

lib_0321::func_0AAA() {
  if(isDefined(self.var_8173)) {
    return;
  }

  if(isDefined(self.var_0651)) {
    lib_0321::func_0B20();
  }

  self.var_0651 = [];
  self.var_0078 = lib_0322::func_0AC9(self.var_0078, "disableplayeradsloscheck", 1);
  self.var_00CA = lib_0322::func_0AC9(self.var_00CA, "ignoreall", 1);
  self.var_00CE = lib_0322::func_0AC9(self.var_00CE, "ignoreme", 1);
  self.var_00B3 = lib_0322::func_0AC9(self.var_00B3, "grenadeawareness", 0);
  self.var_0028 = lib_0322::func_0AC9(self.var_0028, "badplaceawareness", 0);
  self.var_00CC = lib_0322::func_0AC9(self.var_00CC, "ignoreexplosionevents", 1);
  self.var_00D1 = lib_0322::func_0AC9(self.var_00D1, "ignorerandombulletdamage", 1);
  self.var_00D2 = lib_0322::func_0AC9(self.var_00D2, "ignoresuppression", 1);
  self.var_007F = lib_0322::func_0AC9(self.var_007F, "dontavoidplayer", 1);
  self.var_6694 = lib_0322::func_0AC9(self.var_6694, "newEnemyReactionDistSq", 0);
  self.var_2F73 = lib_0322::func_0AC9(self.var_2F73, "disableBulletWhizbyReaction", 1);
  self.var_2F86 = lib_0322::func_0AC9(self.var_2F86, "disableFriendlyFireReaction", 1);
  self.var_324A = lib_0322::func_0AC9(self.var_324A, "dontMelee", 1);
  self.var_3D41 = lib_0322::func_0AC9(self.var_3D41, "flashBangImmunity", 1);
  self.var_007C = lib_0322::func_0AC9(self.var_007C, "doDangerReact", 0);
  self.var_6684 = lib_0322::func_0AC9(self.var_6684, "neverSprintForVariation", 1);
  self.var_0794.var_2F95 = lib_0322::func_0AC9(self.var_0794.var_2F95, "a.disablePain", 1);
  self.var_0016 = lib_0322::func_0AC9(self.var_0016, "allowPain", 0);
  self.var_0098 = lib_0322::func_0AC9(self.var_0098, "fixedNode", 1);
  self.var_81B0 = lib_0322::func_0AC9(self.var_81B0, "script_forcegoal", 1);
  self.var_00AE = lib_0322::func_0AC9(self.var_00AE, "goalradius", 5);
  lib_0321::func_2F19();
}

lib_0321::func_0B20(param_00) {
  if(isDefined(self.var_8173)) {
    return;
  }

  if(isDefined(param_00) && param_00) {
    if(isDefined(self.var_0651)) {
      self.var_0651 = undefined;
    }
  }

  self.var_0078 = lib_0322::func_0AC7("disableplayeradsloscheck", 0);
  self.var_00CA = lib_0322::func_0AC7("ignoreall", 0);
  self.var_00CE = lib_0322::func_0AC7("ignoreme", 0);
  self.var_00B3 = lib_0322::func_0AC7("grenadeawareness", 1);
  self.var_0028 = lib_0322::func_0AC7("badplaceawareness", 1);
  self.var_00CC = lib_0322::func_0AC7("ignoreexplosionevents", 0);
  self.var_00D1 = lib_0322::func_0AC7("ignorerandombulletdamage", 0);
  self.var_00D2 = lib_0322::func_0AC7("ignoresuppression", 0);
  self.var_007F = lib_0322::func_0AC7("dontavoidplayer", 0);
  self.var_6694 = lib_0322::func_0AC7("newEnemyReactionDistSq", 262144);
  self.var_2F73 = lib_0322::func_0AC7("disableBulletWhizbyReaction", undefined);
  self.var_2F86 = lib_0322::func_0AC7("disableFriendlyFireReaction", undefined);
  self.var_324A = lib_0322::func_0AC7("dontMelee", undefined);
  self.var_3D41 = lib_0322::func_0AC7("flashBangImmunity", undefined);
  self.var_007C = lib_0322::func_0AC7("doDangerReact", 1);
  self.var_6684 = lib_0322::func_0AC7("neverSprintForVariation", undefined);
  self.var_0794.var_2F95 = lib_0322::func_0AC7("a.disablePain", 0);
  self.var_0016 = lib_0322::func_0AC7("allowPain", 1);
  self.var_0098 = lib_0322::func_0AC7("fixedNode", 0);
  self.var_81B0 = lib_0322::func_0AC7("script_forcegoal", 0);
  self.var_00AE = lib_0322::func_0AC7("goalradius", 100);
  lib_0321::func_3601();
  self.var_0651 = undefined;
}

lib_0321::func_1135(param_00) {
  var_01 = level.var_721C getcurrentweapon();
  var_02 = function_029C(var_01);
  var_03 = var_02[0]["weapon"];
  var_04 = common_scripts\utility::func_0F9A(var_02, 0);
  self attach(var_03, param_00, 1);
  foreach(var_06 in var_04) {
    self attach(var_06["attachment"], var_06["attachTag"]);
  }

  self method_850A(var_01);
}

lib_0321::func_113B(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = function_029C(param_00);
  if(!isDefined(param_02) || param_02 == 0) {
    var_05 = var_04[0]["weapon"];
  } else {
    var_05 = var_05[0]["worldModel"];
  }

  var_06 = common_scripts\utility::func_0F9A(var_04, 0);
  var_03 attach(var_05, param_01, 1);
  foreach(var_08 in var_06) {
    if(!isDefined(param_02) || param_02 == 0) {
      var_03 attach(var_08["attachment"], var_08["attachTag"]);
      continue;
    }

    var_03 attach(var_08["worldModel"], var_08["attachTag"]);
  }
}

lib_0321::func_73B2(param_00, param_01) {
  lib_0321::func_0693("weaponPickup", param_00, param_01, ::lib_0321::func_0599, 0);
}

lib_0321::func_0599(param_00) {
  if(param_00) {
    self method_82CE();
    return;
  }

  self method_82CD();
}

lib_0321::func_0693(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(self.var_73D4)) {
    self.var_73D4 = [];
  }

  if(!isDefined(self.var_73D4[param_00])) {
    self.var_73D4[param_00] = [];
  }

  if(!isDefined(param_02)) {
    param_02 = "default";
  }

  if(param_01) {
    self.var_73D4[param_00] = common_scripts\utility::func_0F93(self.var_73D4[param_00], param_02);
    if(!self.var_73D4[param_00].size) {
      if(!isDefined(param_04) || param_04) {
        self[[param_03]](1);
        return;
      }

      self[[param_03]](1);
      return;
    }

    return;
  }

  if(!isDefined(common_scripts\utility::func_0F7E(self.var_73D4[param_00], param_02))) {
    self.var_73D4[param_00] = common_scripts\utility::func_0F6F(self.var_73D4[param_00], param_02);
  }

  if(!isDefined(param_04) || param_04) {
    self[[param_03]](0);
    return;
  }

  self[[param_03]](0);
}

lib_0321::func_76B5() {
  if(!isalive(self)) {
    return;
  }

  self.var_76B6 = 1;
  self method_84EF("disable");
  self method_81D3();
  self.var_00CE = 1;
  self.var_50A1 = 1;
}

lib_0321::func_9932() {
  precacheshader("loading_animation");
  common_scripts\utility::func_3C87("tff_sync_complete");
  lib_0322::func_072D();
}

lib_0321::func_9930(param_00) {
  if(isDefined(param_00)) {
    wait(param_00);
  }

  if(function_020D()) {
    common_scripts\utility::func_3C7B("tff_sync_complete");
    function_020C();
    while(function_020D()) {
      wait 0.05;
    }

    common_scripts\utility::func_3C8F("tff_sync_complete");
  }
}

lib_0321::func_9931(param_00, param_01) {
  lib_0321::func_9930(param_01);
}

lib_0321::func_5E8C() {
  level.var_721C endon("death");
  for(;;) {
    var_00 = function_02A1();
    var_01 = var_00[4];
    var_02 = gettime();
    function_02B8(level.var_721C, var_01, var_02);
    wait(2);
  }
}

lib_0321::func_44C6(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getent(param_00, "targetname");
}

lib_0321::func_45B3(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getnode(param_00, "targetname");
}

lib_0321::func_45B2(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getnode(param_00, "script_noteworthy");
}

lib_0321::func_44C3(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getEntArray(param_00, "targetname");
}

lib_0321::func_44C5(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getent(param_00, "script_noteworthy");
}

lib_0321::func_44C2(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  return getEntArray(param_00, "script_noteworthy");
}

lib_0321::func_4677(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = function_021F(param_00, "targetname");
  return var_01[0];
}

lib_0321::func_4676(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = function_021F(param_00, "script_noteworthy");
  return var_01[0];
}

lib_0321::func_9437(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("end_story_mode");
  var_08 = 0;
  if(!isDefined(param_01)) {
    param_01 = 150;
  }

  if(param_01 == 0) {
    var_08 = 1;
  }

  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  if(!var_08) {
    while(distance(level.var_721C.var_0116, param_00) > param_01) {
      wait 0.05;
    }
  }

  if(!isDefined(param_03)) {
    param_03 = 0.3;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.01;
  }

  if(!isDefined(param_04)) {
    param_04 = 0.3;
  }

  if(!isDefined(param_05)) {
    param_05 = 0.3;
  }

  level.var_721C enableslowaim(param_04, param_05);
  level.var_721C lib_0321::func_1791(param_03, 0.5);
  lib_0321::func_727E(1);
  level.var_721C method_8308(param_06);
  level.var_721C method_8497(param_06);
  level.var_721C allowjump(param_06);
  level.var_721C method_8114(param_06);
  level.var_721C method_812A(param_07);
  level.var_721C method_812B(param_07);
  level.var_721C allowads(param_07);
  if(isDefined(param_07) || param_07 != 1) {
    level.var_721C method_8324();
  }

  wait(0.5);
  if(!var_08) {
    var_09 = distance(level.var_721C.var_0116, param_00) - param_01;
    var_0A = 0;
    var_0B = 1;
    var_0C = 0;
    for(;;) {
      if(distance(level.var_721C.var_0116, param_00) > param_01) {
        var_0D = distance(level.var_721C.var_0116, param_00);
        var_0D = var_0D - param_01;
        if(var_0D < var_09) {
          var_0A = 0;
          level.var_721C lib_0321::func_1791(param_03, 0.5);
        } else if(!var_0A) {
          var_0A = 1;
          lib_0321::func_1791(param_02, 0.5);
        }

        var_09 = var_0D;
        continue;
      }

      level.var_721C method_81E1(param_04);
      var_0A = distance(level.var_721C.var_0116, param_01) - param_02;
      wait 0.05;
    }
  }
}

lib_0321::func_9436(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    param_00 = 1;
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

  level notify("end_story_mode");
  level.var_721C enableslowaim(param_01, param_02);
  level.var_721C lib_0321::func_1791(param_00, 2);
  lib_0321::func_727E(param_03);
  level.var_721C method_8308(1);
  level.var_721C method_8497(1);
  level.var_721C allowjump(1);
  level.var_721C method_8114(1);
  level.var_721C method_812A(1);
  level.var_721C method_812B(1);
  level.var_721C allowads(1);
  level.var_721C method_8325();
}

lib_0321::func_727E(param_00) {
  if(!isDefined(param_00) || !param_00) {
    function_00C8("414", -1);
    return;
  }

  function_00C8("414", 0);
}

lib_0321::func_9438(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("end_speed_control");
  level thread lib_0321::func_4981(param_02);
  level thread lib_0321::func_9437(level.var_721C.var_0116, 0, 0.23, 0.24, 0.7, 0.7, param_04, param_05);
  param_00 thread lib_0321::func_90E5();
  wait(0.1);
  var_06 = 0.01;
  if(!isDefined(param_03)) {
    param_03 = 0.8;
  }

  var_07 = 0;
  var_08 = 220;
  var_09 = 130;
  var_0A = 20;
  var_0B = 200;
  level.var_721C method_81E1(0.3);
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  level.var_721C method_8308(param_04);
  level.var_3DD2 = getEntArray(param_01, "script_noteworthy");
  for(;;) {
    if(param_04) {
      if(distancesquared(level.var_721C.var_0116, param_00.var_0116) > var_09 * var_09) {
        level.var_721C method_8308(1);
      } else {
        level.var_721C method_8308(0);
      }
    }

    if(level.var_3DD0 || level.var_3DD1 || level.var_3DCF) {
      var_0C = vectornormalize(anglesToForward(function_01AC(level.var_3DD2, param_00.var_00AD)[0].var_001D) + vectornormalize(param_00.var_0116 - level.var_721C.var_0116));
      var_0D = 0 - lib_0321::func_8C51(param_00.var_0116, var_0C, level.var_721C.var_0116);
      wait(0.1);
    } else {
      var_0C = vectornormalize(anglesToForward(param_00.var_001D) + vectornormalize(param_00.var_0116 - level.var_721C.var_0116));
      var_0D = 0 - lib_0321::func_8C51(param_00.var_0116, var_0C, level.var_721C.var_0116);
    }

    var_0E = common_scripts\utility::func_5D93(var_0D, var_07, var_08, var_06, param_03);
    waittillframeend;
    level.var_721C method_81E1(var_0E);
    wait 0.05;
  }

  level.var_721C method_81E1(1);
}

lib_0321::func_4981(param_00) {
  common_scripts\utility::func_3C9F(param_00);
  lib_0321::func_9436();
  level notify("end_speed_control");
}

lib_0321::func_90E5() {
  var_00 = 20;
  var_01 = var_00 * var_00;
  level endon("end_speed_control");
  level.var_3DD0 = 0;
  childthread lib_0321::func_90E7();
  childthread lib_0321::func_90E6();
  wait(0.2);
  for(;;) {
    self waittill("goal");
    level.var_3DD0 = 1;
    self waittill("goal_changed");
    level.var_3DD0 = 0;
    wait(3);
  }
}

lib_0321::func_90E6() {
  level endon("end_speed_control");
  level.var_3DD1 = 0;
  for(;;) {
    common_scripts\utility::func_A732("goal_changed", "goal");
    level.var_3DD1 = 1;
    wait(3);
    level.var_3DD1 = 0;
  }
}

lib_0321::func_90E7() {
  level endon("end_speed_control");
  var_00 = 0;
  var_01 = 150;
  var_02 = var_01 * var_01;
  level.var_3DCF = 0;
  for(;;) {
    self waittill("goal_changed");
    level.var_3DCF = 0;
    var_00 = 1;
    while(var_00) {
      if(distancesquared(self.var_0116, self.var_00AD) < var_02) {
        var_00 = 0;
      }

      wait 0.05;
    }

    level.var_3DCF = 1;
  }
}

lib_0321::func_8C51(param_00, param_01, param_02) {
  return vectordot(param_02 - param_00, param_01);
}

lib_0321::func_2312(param_00, param_01) {
  var_02 = 15;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_03 = 70;
  if(self getstance() == "crouch") {
    var_03 = 50;
  } else if(self getstance() == "prone") {
    var_03 = 30;
  }

  var_04 = var_03 * 0.5;
  return lib_0321::func_2311(param_00, self.var_0116 + (0, 0, var_04), var_02 - param_01, var_04);
}

lib_0321::func_2311(param_00, param_01, param_02, param_03) {
  var_04 = param_00 - param_01;
  if(abs(var_04[2]) <= param_03 - param_02) {
    var_05 = (var_04[0], var_04[1], 0);
    if(lengthsquared(var_05) > param_02 * param_02) {
      param_00 = param_01 + vectornormalize(var_05) * param_02;
      param_00 = (param_00[0], param_00[1], param_01[2] + var_04[2]);
    }
  } else if(var_04[2] > 0) {
    var_06 = param_01 + (0, 0, param_03 - param_02);
    var_04 = param_00 - var_06;
    if(lengthsquared(var_04) > param_02 * param_02) {
      param_00 = var_06 + vectornormalize(var_04) * param_02;
    }
  } else {
    var_06 = param_02 - (0, 0, var_04 - param_03);
    var_04 = param_00 - var_06;
    if(lengthsquared(var_04) > param_02 * param_02) {
      param_00 = var_06 + vectornormalize(var_04) * param_02;
    }
  }

  return param_00;
}

lib_0321::func_1E36(param_00, param_01, param_02, param_03) {
  var_04 = param_03 - param_01;
  var_05 = var_04[2];
  var_04 = (var_04[0], var_04[1], 0);
  var_06 = lengthsquared(var_04);
  if(var_06 <= 0) {
    if(var_05 < 0.1) {
      return (0, 0, 0);
    }

    return undefined;
  }

  var_07 = sqrt(var_06);
  if(param_00 > 0) {
    param_00 = param_00 * -1;
  }

  var_08 = squared(cos(param_02 * -1));
  var_09 = tan(param_02 * -1);
  var_0A = sqrt(param_00 * var_06 / 2 * var_08 * var_05 - var_07 * var_09);
  if(common_scripts\utility::func_55BF(var_0A)) {
    return undefined;
  }

  var_0B = rotatevector((1, 0, 0), (param_02, vectortoyaw(var_04), 0));
  var_0B = var_0B * var_0A;
  return var_0B;
}

lib_0321::func_9A7D(param_00) {
  lib_031E::func_9A74(param_00);
}

lib_0321::func_5670(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  return function_01D4(param_00) == "altmode";
}

lib_0321::func_1801(param_00, param_01, param_02) {
  self endon("death");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!issentient(self) || !isalive(self)) {
    return;
  }

  if(isDefined(self.var_1801) && self.var_1801) {
    return;
  }

  self.var_1801 = 1;
  if(isDefined(param_00)) {
    wait(randomfloat(param_00));
  }

  var_03 = [];
  var_03[0] = "j_hip_le";
  var_03[1] = "j_hip_ri";
  var_03[2] = "j_head";
  var_03[3] = "j_spine4";
  var_03[4] = "j_elbow_le";
  var_03[5] = "j_elbow_ri";
  var_03[6] = "j_clavicle_le";
  var_03[7] = "j_clavicle_ri";
  var_04 = getdvarint("cg_fov");
  thread lib_0321::func_1802(common_scripts\utility::func_7A33(var_03), undefined);
  if(isDefined(param_01) && isai(param_01) && isalive(param_01)) {
    if(!level.var_721C method_8214(param_01.var_0116, var_04, 500)) {
      param_01 method_81E8();
    }
  } else if(param_02) {
    var_05 = "allies";
    if(isDefined(self.var_01A7)) {
      if(self.var_01A7 == "allies" || self.var_01A7 == "neutral") {
        var_05 = "axis";
      }
    }

    var_06 = function_00CB(var_05);
    var_06 = function_01AC(var_06, level.var_721C.var_0116, 2000);
    var_06 = common_scripts\utility::func_0F92(var_06);
    foreach(var_08 in var_06) {
      if(!level.var_721C method_8214(var_08.var_0116 + (0, 0, 50), var_04, 500)) {
        if(isDefined(var_08.var_01D0) && function_01A9(var_08.var_01D0) == "bullet") {
          var_08 method_81E8();
          break;
        }
      }
    }
  }

  self dodamage(self.var_00BC + 50, self.var_0116);
}

lib_0321::func_1802(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = level.var_0611["bloody_death_impact"];
  }

  playFXOnTag(param_01, self, param_00);
}

lib_0321::func_A24C() {
  return getDvar("sm_sunShadowBitDepth") == 16;
}

lib_0321::func_A24B() {
  return getDvar("sm_spotShadowBitDepth") == 16;
}

sethealth_notmaxhealth(param_00) {
  var_01 = self.var_00FB;
  self.var_00BC = param_00;
  self.var_00FB = var_01;
}