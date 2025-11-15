/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\utility.gsc
**********************************/

func_7CCC(param_00) {
  var_01 = [];
  var_02 = getnumparts(param_00);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_01[var_01.size] = getpartname(param_00, var_03);
  }

  return var_01;
}

func_77FF(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(param_01.size < 1) {
    return var_04;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  param_02 = squared(param_02);
  foreach(var_06 in param_01) {
    if(!isalive(var_06) || !isDefined(var_06) || !param_03 && isDefined(var_06.a.var_58DA)) {
      continue;
    }

    if(distancesquared(var_06.origin, param_00) <= param_02) {
      var_04[var_04.size] = var_06;
    }
  }

  return var_04;
}

func_BD6B(param_00, param_01) {
  param_00 = param_00 * 17.6;
  var_02 = param_01 / param_00;
  return var_02;
}

func_F40A(param_00, param_01, param_02) {
  var_03 = undefined;
  param_00 = tolower(param_00);
  var_04["friendly"] = 3;
  var_04["enemy"] = 1;
  var_04["objective"] = 5;
  var_04["neutral"] = 0;
  var_03 = var_04[param_00];
  param_02 = scripts\engine\utility::ter_op(isDefined(param_02), param_02, 1);
  func_9196(var_03, param_01, param_02);
}

func_45F8(param_00, param_01) {
  var_02 = "";
  if(param_00 < 0) {
    var_02 = var_02 + "-";
  }

  param_00 = func_E753(param_00, 1, 0);
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

func_E753(param_00, param_01, param_02) {
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

func_E754(param_00, param_01, param_02) {
  var_03 = param_00 / 1000;
  var_03 = func_E753(var_03, param_01, param_02);
  param_00 = var_03 * 1000;
  return int(param_00);
}

func_111DA(param_00, param_01, param_02) {
  param_02 = int(param_02 * 20);
  var_03 = [];
  for(var_04 = 0; var_04 < 3; var_04++) {
    var_03[var_04] = param_00[var_04] - param_01[var_04] / param_02;
  }

  var_05 = [];
  for(var_04 = 0; var_04 < param_02; var_04++) {
    wait(0.05);
    for(var_06 = 0; var_06 < 3; var_06++) {
      var_05[var_06] = param_00[var_06] - var_03[var_06] * var_04;
    }

    setsunlight(var_05[0], var_05[1], var_05[2]);
  }

  setsunlight(param_01[0], param_01[1], param_01[2]);
}

func_65E3(param_00) {
  while(isDefined(self) && !self.var_65DB[param_00]) {
    self waittill(param_00);
  }
}

func_65E7(param_00) {
  while(isDefined(self) && !self.var_65DB[param_00]) {
    self waittill(param_00);
  }
}

func_65E4(param_00, param_01) {
  while(isDefined(self)) {
    if(func_65DB(param_00)) {
      return;
    }

    if(func_65DB(param_01)) {
      return;
    }

    scripts\engine\utility::waittill_either(param_00, param_01);
  }
}

func_65E6(param_00, param_01) {
  var_02 = gettime();
  while(isDefined(self)) {
    if(self.var_65DB[param_00]) {
      break;
    }

    if(gettime() >= var_02 + param_01 * 1000) {
      break;
    }

    scripts\sp\utility_code::func_65FA(param_00, param_01);
  }
}

func_65E8(param_00) {
  while(isDefined(self) && self.var_65DB[param_00]) {
    self waittill(param_00);
  }
}

func_65DC(param_00) {}

func_65E9(param_00, param_01) {
  while(isDefined(self)) {
    if(!func_65DB(param_00)) {
      return;
    }

    if(!func_65DB(param_01)) {
      return;
    }

    scripts\engine\utility::waittill_either(param_00, param_01);
  }
}

func_65E0(param_00) {
  if(!isDefined(self.var_65DB)) {
    self.var_65DB = [];
    self.var_65EA = [];
  }

  self.var_65DB[param_00] = 0;
}

func_65DF(param_00) {
  if(isDefined(self.var_65DB) && isDefined(self.var_65DB[param_00])) {
    return 1;
  }

  return 0;
}

func_65E2(param_00, param_01) {
  self endon("death");
  wait(param_01);
  func_65E1(param_00);
}

func_65E1(param_00) {
  self.var_65DB[param_00] = 1;
  self notify(param_00);
}

func_65DD(param_00, param_01) {
  if(self.var_65DB[param_00]) {
    self.var_65DB[param_00] = 0;
    self notify(param_00);
  }

  if(isDefined(param_01) && param_01) {
    self.var_65DB[param_00] = undefined;
  }
}

func_65DE(param_00, param_01) {
  wait(param_01);
  if(isDefined(self)) {
    func_65DD(param_00);
  }
}

func_65DB(param_00) {
  return self.var_65DB[param_00];
}

func_78C8(param_00, param_01, param_02, param_03) {
  if(!param_00.size) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = level.player;
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_04 = param_01.origin;
  if(isDefined(param_02) && param_02) {
    var_04 = param_01 getEye();
  }

  var_05 = undefined;
  var_06 = param_01 getplayerangles();
  var_07 = anglesToForward(var_06);
  var_08 = -1;
  foreach(var_0A in param_00) {
    var_0B = vectortoangles(var_0A.origin - var_04);
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

func_78B9(param_00, param_01, param_02) {
  if(!param_00.size) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = level.player;
  }

  var_03 = param_01.origin;
  if(isDefined(param_02) && param_02) {
    var_03 = param_01 getEye();
  }

  var_04 = undefined;
  var_05 = param_01 getplayerangles();
  var_06 = anglesToForward(var_05);
  var_07 = -1;
  for(var_08 = 0; var_08 < param_00.size; var_08++) {
    var_09 = vectortoangles(param_00[var_08].origin - var_03);
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

func_6E49(param_00, param_01, param_02) {
  scripts\engine\utility::flag_init(param_00);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  param_01 thread scripts\sp\utility_code::func_1287(param_00, param_02);
  return param_01;
}

func_6E4A(param_00, param_01, param_02) {
  scripts\engine\utility::flag_init(param_00);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  for(var_03 = 0; var_03 < param_01.size; var_03++) {
    param_01[var_03] thread scripts\sp\utility_code::func_1287(param_00, 0);
  }

  return param_01;
}

func_6E2B(param_00, param_01) {
  wait(param_01);
  scripts\engine\utility::flag_clear(param_00);
}

func_ABD2() {
  if(level.var_B8D0) {
    return;
  }

  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }

  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    var_01 = level.players[var_00];
    if(!isalive(var_01)) {
      return;
    }
  }

  scripts\engine\utility::flag_set("game_saving");
  var_02 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", & "AUTOSAVE_AUTOSAVE", var_02, 1);
  scripts\engine\utility::flag_clear("game_saving");
}

func_16D5(param_00, param_01, param_02) {
  level.var_2668.var_6A42[param_00] = [];
  level.var_2668.var_6A42[param_00]["func"] = param_01;
  level.var_2668.var_6A42[param_00]["msg"] = param_02;
}

func_E00D(param_00) {
  level.var_2668.var_6A42[param_00] = undefined;
}

func_2677() {
  thread func_266B("autosave_stealth", 8, 1);
}

func_2678() {
  thread func_266B("autosave_stealth", 8, 1, 1);
}

func_2679() {
  scripts\sp\utility_code::func_2680();
  thread scripts\sp\utility_code::func_267F();
}

func_2669(param_00) {
  thread func_266B(param_00);
}

func_266A(param_00) {
  thread func_266B(param_00, undefined, undefined, 1);
}

func_266B(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_4B18)) {
    level.var_4B18 = 1;
  }

  var_04 = "levelshots\autosave\autosave_" + level.script + level.var_4B18;
  var_05 = level scripts\sp\autosave::func_12891(level.var_4B18, "autosave", var_04, param_01, param_02, param_03);
  if(isDefined(var_05) && var_05) {
    level.var_4B18++;
  }
}

func_2672(param_00, param_01) {
  thread func_266B(param_00, param_01);
}

func_2673(param_00, param_01) {
  thread func_266B(param_00, param_01, undefined, 1);
}

func_4EF6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  if(isDefined(param_03)) {
    param_03 endon("death");
    param_01 = param_03.origin;
  }

  for(var_04 = 0; var_04 < param_02 * 20; var_04++) {
    if(!isDefined(param_03)) {} else {}

    wait(0.05);
  }
}

func_4EF7(param_00, param_01) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 5;
  }

  for(var_02 = 0; var_02 < param_01 * 20; var_02++) {
    wait(0.05);
  }
}

func_4EF8(param_00, param_01, param_02, param_03) {
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
    wait(0.05);
  }
}

func_4295(param_00, param_01) {
  return param_00 >= param_01;
}

func_7E33(param_00, param_01, param_02) {
  return scripts\sp\utility_code::func_4461(param_00, param_01, param_02, ::func_4295);
}

func_79B3(param_00, param_01) {
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

func_7D80(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(distance(param_01[var_04].origin, param_00) <= param_02) {
      var_03[var_03.size] = param_01[var_04];
    }
  }

  return var_03;
}

func_7B5C(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(distance(param_01[var_04].origin, param_00) > param_02) {
      var_03[var_03.size] = param_01[var_04];
    }
  }

  return var_03;
}

func_78BB(param_00, param_01, param_02) {
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

    var_05 = distance(param_01[var_04].origin, param_00);
    if(var_05 >= param_02) {
      continue;
    }

    param_02 = var_05;
    var_03 = param_01[var_04];
  }

  return var_03;
}

func_7A05(param_00, param_01, param_02) {
  if(!param_02.size) {
    return;
  }

  var_03 = undefined;
  var_04 = vectortoangles(param_01 - param_00);
  var_05 = anglesToForward(var_04);
  var_06 = -1;
  foreach(var_08 in param_02) {
    var_04 = vectortoangles(var_08.origin - param_00);
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

func_78B8(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 9999999;
  }

  if(param_01.size < 1) {
    return;
  }

  var_03 = undefined;
  foreach(var_07, var_05 in param_01) {
    var_06 = distance(var_05.origin, param_00);
    if(var_06 >= param_02) {
      continue;
    }

    param_02 = var_06;
    var_03 = var_07;
  }

  return var_03;
}

func_78B5(param_00, param_01, param_02) {
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
        var_03 = distance(param_00, param_01[var_05].origin);
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
        var_03 = distance(param_00, param_01[0].origin);
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
        var_09 = distance(param_00, param_01[var_05].origin);
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

func_78AA(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    var_03 = getaiarray(param_01);
  } else {
    var_03 = getaiarray();
  }

  if(var_03.size == 0) {
    return undefined;
  }

  if(isDefined(param_02)) {
    var_03 = scripts\engine\utility::array_remove_array(var_03, param_02);
  }

  return scripts\engine\utility::getclosest(param_00, var_03);
}

func_78AB(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    var_03 = getaiarray(param_01);
  } else {
    var_03 = getaiarray();
  }

  if(var_03.size == 0) {
    return undefined;
  }

  return func_78B5(param_00, var_03, param_02);
}

func_7BDB(param_00, param_01, param_02, param_03) {
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

func_3849(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!func_D637(param_00)) {
    return 0;
  }

  if(!sighttracepassed(self getEye(), param_00, param_01, self)) {
    return 0;
  }

  return 1;
}

func_D637(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = anglesToForward(self.angles);
  var_02 = vectornormalize(param_00 - self.origin);
  var_03 = vectordot(var_01, var_02);
  return var_03 > 0.766;
}

func_1101B() {
  self notify("stop_magic_bullet_shield");
  if(isai(self)) {
    if(isDefined(self.var_C3B0)) {
      self.var_50 = self.var_C3B0;
      self.var_C3B0 = undefined;
    } else {
      self.var_50 = 1;
    }
  }

  self.var_B14F = undefined;
  self.var_E0 = 0;
  self notify("internal_stop_magic_bullet_shield");
}

func_B14E() {}

func_B14F(param_00) {
  if(isai(self)) {} else {
    self.health = 100000;
  }

  self endon("internal_stop_magic_bullet_shield");
  if(isai(self)) {
    self.var_C3B0 = self.var_50;
    self.var_50 = 0.1;
  }

  self notify("magic_bullet_shield");
  self.var_B14F = 1;
  self.var_E0 = 1;
}

func_5550() {
  self.a.disablelongdeath = 1;
}

func_6215() {
  self.a.disablelongdeath = 0;
}

func_61DE() {
  self.var_10264 = undefined;
}

func_5508() {
  self.var_10264 = 1;
}

func_5131() {
  func_B14F(1);
}

func_7A31() {
  return self.ignoreme;
}

func_F416(param_00) {
  self.ignoreme = param_00;
}

func_F415(param_00) {
  self.precacheleaderboards = param_00;
}

func_F39C(param_00) {
  self.loadstartpointtransients = param_00;
}

func_7B61() {
  return self.triggeroneoffradarsweep;
}

func_F4B2(param_00) {
  self.triggeroneoffradarsweep = param_00;
}

func_5151(param_00) {
  scripts\common\exploder::delete_exploder_proc(param_00);
}

func_8E80(param_00) {
  scripts\common\exploder::hide_exploder_models_proc(param_00);
}

func_100DA(param_00) {
  scripts\common\exploder::show_exploder_models_proc(param_00);
}

func_10FEC(param_00) {
  scripts\common\exploder::stop_exploder_proc(param_00);
}

func_79A6(param_00) {
  return scripts\common\exploder::get_exploder_array_proc(param_00);
}

func_6F54(param_00) {
  lib_0B77::func_6F5A(param_00);
}

func_7267(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  thread func_7268(param_00, param_01, param_02, param_03);
}

func_C812() {
  if(isDefined(self.a.var_4C42)) {
    self.a.var_2274["crawl"] = self.a.var_4C42["crawl"];
    self.a.var_2274["death"] = self.a.var_4C42["death"];
    self.a.var_486A = self.a.var_4C42["blood_fx_rate"];
    if(isDefined(self.a.var_4C42["blood_fx"])) {
      self.a.var_4869 = self.a.var_4C42["blood_fx"];
    }
  }

  self.a.var_2274["stand_2_crawl"] = [];
  if(isDefined(self.var_C05D)) {
    self.a.pose = "prone";
  }

  self orientmode("face angle", self.a.var_7266);
  self.a.var_7266 = undefined;
}

func_7268(param_00, param_01, param_02, param_03) {
  self.var_72CC = 1;
  self.a.var_7280 = param_01;
  self.noragdoll = 1;
  self.var_C05D = param_03;
  self.a.var_4C42 = param_02;
  self.var_4875 = ::func_C812;
  self.maxhealth = 100000;
  self.health = 100000;
  func_6215();
  if(!isDefined(param_03) || param_03 == 0) {
    self.a.var_7266 = param_00 + 181.02;
    return;
  }

  self.a.var_7266 = param_00;
  thread scripts\anim\notetracks::notetrackposecrawl();
}

func_19D3() {
  self.var_10265 = 1;
  func_54C6();
}

func_D463(param_00) {
  self endon("death");
  self endon("stop_unresolved_collision_script");
  if(!isDefined(param_00)) {
    param_00 = 3;
  }

  func_E23C();
  childthread func_D464();
  for(;;) {
    if(self.var_366) {
      self.var_366 = 0;
      if(self.var_12BE5 >= param_00) {
        if(isDefined(self.unresolved_collision_mover)) {
          var_01 = self.unresolved_collision_mover;
          if(isDefined(var_01.unresolved_collision_func)) {
            var_01[[var_01.unresolved_collision_func]](self);
          }
        }

        if(isDefined(self.var_8969)) {
          self[[self.var_8969]]();
        } else {
          func_502A();
        }
      }
    } else {
      func_E23C();
    }

    wait(0.05);
  }
}

func_D464() {
  for(;;) {
    self waittill("unresolved_collision", var_00);
    self.var_366 = 1;
    self.var_12BE5++;
    self.unresolved_collision_mover = var_00;
  }
}

func_E23C() {
  self.var_366 = 0;
  self.var_12BE5 = 0;
}

func_502A() {
  var_00 = getnodesinradiussorted(self.origin, 500, 0, 200, "Path");
  if(var_00.size) {
    self cancelmantle();
    self dontinterpolate();
    self setorigin(var_00[0].origin);
    func_E23C();
  }
}

func_11032() {
  self notify("stop_unresolved_collision_script");
  func_E23C();
}

func_9BB2() {
  return issentient(self) && !isalive(self);
}

play_sound_on_tag(param_00, param_01, param_02, param_03, param_04) {
  if(func_9BB2()) {
    return;
  }

  var_05 = spawn("script_origin", self.origin);
  var_05 endon("death");
  thread scripts\sp\utility_code::func_517B(var_05, "sounddone");
  if(isDefined(param_01)) {
    var_05 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_05.origin = self.origin;
    var_05.angles = self.angles;
    var_05 linkto(self);
  }

  var_05 playSound(param_00, "sounddone");
  if(isDefined(param_02)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_05))) {
      var_05 stopsounds();
    }

    wait(0.05);
  } else {
    var_05 waittill("sounddone");
  }

  if(isDefined(param_03)) {
    self notify(param_03);
  }

  var_05 delete();
}

func_CE48(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(func_9BB2()) {
    return;
  }

  var_06 = spawn("script_origin", self.origin);
  var_06 endon("death");
  if(!isDefined(param_01)) {
    param_01 = "dirt";
  }

  thread scripts\sp\utility_code::func_517B(var_06, "sounddone");
  if(isDefined(param_02)) {
    var_06 linkto(self, param_02, (0, 0, 0), (0, 0, 0));
  } else {
    var_06.origin = self.origin;
    var_06.angles = self.angles;
    var_06 linkto(self);
  }

  var_06 playsurfacesound(param_00, param_01, "sounddone");
  if(isDefined(param_03)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_06))) {
      var_06 stopsounds();
    }

    wait(0.05);
  } else {
    var_06 waittill("sounddone");
  }

  if(isDefined(param_04)) {
    self notify(param_04);
  }

  var_06 delete();
}

func_CE32(param_00, param_01) {
  play_sound_on_tag(param_00, param_01, 1);
}

play_loop_sound_on_entity_with_pitch(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_origin", (0, 0, 0));
  var_04 endon("death");
  thread scripts\engine\utility::delete_on_death(var_04);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(isDefined(param_01)) {
    var_04.origin = self.origin + param_01;
  } else {
    var_04.origin = self.origin;
  }

  var_04.angles = self.angles;
  var_04 linkto(self);
  var_04 playLoopSound(param_00);
  var_04 _meth_8277(param_02, param_03);
  self waittill("stop sound" + param_00);
  var_04 stoploopsound(param_00);
  var_04 delete();
}

play_sound_on_entity(param_00, param_01) {
  play_sound_on_tag(param_00, undefined, undefined, param_01);
}

play_loop_sound_on_tag(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawn("script_origin", (0, 0, 0));
  var_05 endon("death");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(param_02) {
    thread scripts\engine\utility::delete_on_death(var_05);
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(param_03) {
    thread func_5187(var_05);
  }

  if(isDefined(param_01)) {
    var_05 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_05.origin = self.origin;
    var_05.angles = self.angles;
    var_05 linkto(self);
  }

  var_05 playLoopSound(param_00);
  self waittill("stop sound" + param_00);
  if(isDefined(param_04)) {
    var_05 playSound(param_04, "sounddone");
    var_05 scripts\engine\utility::delaycall(0.15, ::stoploopsound, param_00);
    var_05 waittill("sounddone");
    var_05 delete();
    return;
  }

  var_05 stoploopsound(param_00);
  var_05 delete();
}

func_5187(param_00) {
  param_00 endon("death");
  while(isDefined(self)) {
    wait(0.05);
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_106ED(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(!isDefined(param_00.var_6CDA)) {
    param_00 scripts\engine\utility::waittill_either("finished spawning", "death");
  }

  if(isalive(param_00)) {
    return 0;
  }

  return 1;
}

func_23B7(param_00) {
  if(isDefined(param_00)) {
    self.var_1FBB = param_00;
  }

  self glinton(level.var_EC87[self.var_1FBB]);
}

func_23B8() {
  var_00 = tolower(self.subclass);
  switch (var_00) {
    case "c6":
      func_23C2();
      break;

    case "c8":
      func_23C4();
      break;

    case "c12":
      func_23C5();
      break;

    case "no_boost":
    case "crew":
    case "riotshield":
    case "regular":
    case "juggernaut":
    case "elite":
      func_23CA();
      break;

    default:
      break;
  }
}

func_23B9() {
  var_00 = tolower(self.unittype);
  switch (var_00) {
    case "c6":
      func_23C2();
      break;

    case "c8":
      func_23C4();
      break;

    case "c12":
      func_23C5();
      break;

    case "soldier":
    case "civilian":
    case "c6i":
      func_23CA();
      break;

    default:
      break;
  }
}

func_23C2() {
  self glinton(#animtree);
}

func_23C4() {
  self glinton(#animtree);
}

func_23C5() {
  self glinton(#animtree);
}

func_23CA() {
  self glinton(#animtree);
}

func_23CC() {
  if(isarray(level.var_EC8C[self.var_1FBB])) {
    var_00 = randomint(level.var_EC8C[self.var_1FBB].size);
    self setModel(level.var_EC8C[self.var_1FBB][var_00]);
    return;
  }

  self setModel(level.var_EC8C[self.var_1FBB]);
}

func_10639(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_03 = spawn("script_model", param_01);
  var_03.var_1FBB = param_00;
  var_03 func_23B7();
  var_03 func_23CC();
  if(isDefined(param_02)) {
    var_03.angles = param_02;
  }

  return var_03;
}

func_127AE(param_00, param_01) {
  var_02 = getent(param_00, param_01);
  if(!isDefined(var_02)) {
    return;
  }

  var_02 waittill("trigger", var_03);
  level notify(param_00, var_03);
  return var_03;
}

func_127B3(param_00) {
  return func_127AE(param_00, "targetname");
}

func_F3A1(param_00, param_01) {
  thread func_F3A5(param_00, param_01, ::func_13753, "set_flag_on_dead");
}

func_F3A3(param_00, param_01) {
  thread func_F3A5(param_00, param_01, ::func_13754, "set_flag_on_dead_or_dying");
}

empty_func(param_00) {}

func_F3A8(param_00, param_01) {
  self waittill("spawned", var_02);
  if(func_106ED(var_02)) {
    return;
  }

  param_00.var_1912[param_00.var_1912.size] = var_02;
  func_65E1(param_01);
}

func_F3A5(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_1912 = [];
  foreach(var_06 in param_00) {
    var_06 func_65E0(param_03);
  }

  scripts\engine\utility::array_thread(param_00, ::func_F3A8, var_04, param_03);
  foreach(var_06 in param_00) {
    var_06 func_65E3(param_03);
  }

  [[param_02]](var_04.var_1912);
  scripts\engine\utility::flag_set(param_01);
}

func_F3AB(param_00, param_01) {
  if(!scripts\engine\utility::flag(param_01)) {
    param_00 waittill("trigger", var_02);
    scripts\engine\utility::flag_set(param_01);
    return var_02;
  }
}

func_F3AA(param_00) {
  if(scripts\engine\utility::flag(param_00)) {
    return;
  }

  var_01 = getent(param_00, "targetname");
  var_01 waittill("trigger");
  scripts\engine\utility::flag_set(param_00);
}

func_13753(param_00, param_01, param_02) {
  var_0A = spawnStruct();
  if(isDefined(param_02)) {
    var_0A endon("thread_timed_out");
    var_0A thread scripts\sp\utility_code::func_13758(param_02);
  }

  var_0A.var_C1 = param_00.size;
  if(isDefined(param_01) && param_01 < var_0A.var_C1) {
    var_0A.var_C1 = param_01;
  }

  scripts\engine\utility::array_thread(param_00, ::scripts\sp\utility_code::func_13757, var_0A);
  while(var_0A.var_C1 > 0) {
    var_0A waittill("waittill_dead guy died");
  }
}

func_13754(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_00) {
    if(isalive(var_05) && !var_05.precachemodel) {
      var_03[var_03.size] = var_05;
    }
  }

  param_00 = var_03;
  var_07 = spawnStruct();
  if(isDefined(param_02)) {
    var_07 endon("thread_timed_out");
    var_07 thread scripts\sp\utility_code::func_13758(param_02);
  }

  var_07.var_C1 = param_00.size;
  if(isDefined(param_01) && param_01 < var_07.var_C1) {
    var_07.var_C1 = param_01;
  }

  scripts\engine\utility::array_thread(param_00, ::scripts\sp\utility_code::func_13756, var_07);
  while(var_07.var_C1 > 0) {
    var_07 waittill("waittill_dead_guy_dead_or_dying");
  }
}

waittill_nonai_isnt_blocking_tank(param_00) {
  self endon("damage");
  self endon("death");
  self waittillmatch(param_00, "single anim");
}

func_7A9D(param_00, param_01) {
  var_02 = func_7A9E(param_00, param_01);
  if(var_02.size > 1) {
    return undefined;
  }

  return var_02[0];
}

func_7A9E(param_00, param_01) {
  var_02 = getaispeciesarray("all", "all");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(!isalive(var_05)) {
      continue;
    }

    switch (param_01) {
      case "targetname":
        if(isDefined(var_05.var_336) && var_05.var_336 == param_00) {
          var_03[var_03.size] = var_05;
        }
        break;

      case "script_noteworthy":
        if(isDefined(var_05.script_noteworthy) && var_05.script_noteworthy == param_00) {
          var_03[var_03.size] = var_05;
        }
        break;
    }
  }

  return var_03;
}

func_7D40(param_00, param_01) {
  var_02 = func_7D43(param_00, param_01);
  if(!var_02.size) {
    return undefined;
  }

  return var_02[0];
}

func_7D43(param_00, param_01) {
  var_02 = getEntArray(param_00, param_01);
  var_03 = [];
  var_04 = [];
  foreach(var_06 in var_02) {
    if(var_06.var_9F != "script_vehicle") {
      continue;
    }

    var_04[0] = var_06;
    if(isspawner(var_06)) {
      if(isDefined(var_06.var_A90E)) {
        var_04[0] = var_06.var_A90E;
        var_03 = func_22A2(var_03, var_04);
      }

      continue;
    }

    var_03 = func_22A2(var_03, var_04);
  }

  return var_03;
}

func_7A9F(param_00, param_01, param_02) {
  var_03 = func_7AA0(param_00, param_01, param_02);
  if(var_03.size > 1) {
    return undefined;
  }

  return var_03[0];
}

func_7AA0(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = "all";
  }

  var_03 = getaispeciesarray("allies", param_02);
  var_03 = scripts\engine\utility::array_combine(var_03, getaispeciesarray("axis", param_02));
  var_04 = [];
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    switch (param_01) {
      case "targetname":
        if(isDefined(var_03[var_05].var_336) && var_03[var_05].var_336 == param_00) {
          var_04[var_04.size] = var_03[var_05];
        }
        break;

      case "script_noteworthy":
        if(isDefined(var_03[var_05].script_noteworthy) && var_03[var_05].script_noteworthy == param_00) {
          var_04[var_04.size] = var_03[var_05];
        }
        break;
    }
  }

  return var_04;
}

func_76F4(param_00, param_01) {
  if(isDefined(level.var_76F3[param_00])) {
    if(level.var_76F3[param_00]) {
      wait(0.05);
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

  level.var_76F3[param_00] = 0;
  wait(param_01);
  level.var_76F3[param_00] = 1;
  level notify(param_00);
  if(isalive(self)) {
    self notify("gather_delay_finished" + param_00 + param_01);
  }
}

func_76F3(param_00, param_01) {
  thread func_76F4(param_00, param_01);
  self waittill("gather_delay_finished" + param_00 + param_01);
}

func_7F79(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    var_05 = var_04.destroynavobstacle;
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

func_22A2(param_00, param_01) {
  if(param_00.size == 0) {
    return param_01;
  }

  if(param_01.size == 0) {
    return param_00;
  }

  var_02 = param_00;
  foreach(var_04 in param_01) {
    var_05 = 0;
    foreach(var_07 in param_00) {
      if(var_07 == var_04) {
        var_05 = 1;
        break;
      }
    }

    if(var_05) {
      continue;
    } else {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_2290(param_00, param_01) {
  var_02 = param_00;
  for(var_03 = 0; var_03 < param_01.size; var_03++) {
    if(scripts\engine\utility::array_contains(param_00, param_01[var_03])) {
      var_02 = scripts\engine\utility::array_remove(var_02, param_01[var_03]);
    }
  }

  return var_02;
}

array_compare(param_00, param_01) {
  if(param_00.size != param_01.size) {
    return 0;
  }

  foreach(var_05, var_03 in param_00) {
    if(!isDefined(param_01[var_05])) {
      return 0;
    }

    var_04 = param_01[var_05];
    if(var_04 != var_03) {
      return 0;
    }
  }

  return 1;
}

func_7F77() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();
    foreach(var_03 in var_01) {
      var_04 = getvehiclenodearray(var_03, "script_linkname");
      var_00 = scripts\engine\utility::array_combine(var_00, var_04);
    }
  }

  return var_00;
}

draw_line(param_00, param_01, param_02, param_03, param_04) {
  wait(0.05);
}

func_5B51(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_05 = gettime() + param_05 * 1000;
  while(gettime() < param_05) {
    wait(0.05);
    if(!isDefined(param_01) || !isDefined(param_01.origin)) {
      return;
    }
  }
}

func_5B4C(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_5B51(param_01, param_00, param_02, param_03, param_04, param_05);
}

func_5B4D(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  param_01 endon("death");
  param_05 = gettime() + param_05 * 1000;
  while(gettime() < param_05) {
    wait(0.05);
  }
}

func_5B4E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 endon("death");
  param_01 endon("death");
  param_05 endon(param_06);
  wait(0.05);
}

func_5B52(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_05 endon(param_06);
  scripts\engine\utility::draw_line_for_time(param_00, param_01, param_02, param_03, param_04, 0.05);
}

func_5B4F(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_06 = gettime() + param_06 * 1000;
  param_01 = param_01 * param_02;
  while(gettime() < param_06) {
    wait(0.05);
    if(!isDefined(param_00) || !isDefined(param_00.origin)) {
      return;
    }
  }
}

draw_circle(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 16;
  var_07 = 360 / var_06;
  var_08 = [];
  for(var_09 = 0; var_09 < var_06; var_09++) {
    var_0A = var_07 * var_09;
    var_0B = cos(var_0A) * param_01;
    var_0C = sin(var_0A) * param_01;
    var_0D = param_00[0] + var_0B;
    var_0E = param_00[1] + var_0C;
    var_0F = param_00[2];
    var_08[var_08.size] = (var_0D, var_0E, var_0F);
  }

  for(var_09 = 0; var_09 < var_08.size; var_09++) {
    var_10 = var_08[var_09];
    if(var_09 + 1 >= var_08.size) {
      var_11 = var_08[0];
      continue;
    }

    var_11 = var_08[var_09 + 1];
  }
}

draw_circle_until_notify(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = 16;
  var_08 = 360 / var_07;
  var_09 = [];
  for(var_0A = 0; var_0A < var_07; var_0A++) {
    var_0B = var_08 * var_0A;
    var_0C = cos(var_0B) * param_01;
    var_0D = sin(var_0B) * param_01;
    var_0E = param_00[0] + var_0C;
    var_0F = param_00[1] + var_0D;
    var_10 = param_00[2];
    var_09[var_09.size] = (var_0E, var_0F, var_10);
  }

  thread draw_circle_lines_until_notify(var_09, param_02, param_03, param_04, param_05, param_06);
}

draw_circle_lines_until_notify(param_00, param_01, param_02, param_03, param_04, param_05) {
  for(var_06 = 0; var_06 < param_00.size; var_06++) {
    var_07 = param_00[var_06];
    if(var_06 + 1 >= param_00.size) {
      var_08 = param_00[0];
    } else {
      var_08 = param_00[var_06 + 1];
    }

    thread func_5B52(var_07, var_08, param_01, param_02, param_03, param_04, param_05);
  }
}

func_28D7(param_00) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter::func_29C1();
  if(isDefined(param_00)) {
    func_F2DC(param_00, 0);
    var_01 = getaiarray(param_00);
  } else {
    foreach(param_00 in level.var_115E7) {
      func_F2DC(param_00, 0);
    }

    var_01 = getaiarray();
  }

  if(!isDefined(level.var_3D4B) || !level.var_3D4B) {
    return;
  }

  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    var_01[var_04].var_28CF = 0;
  }

  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    var_05 = var_01[var_04];
    if(!isalive(var_05)) {
      continue;
    }

    if(!var_05.var_3D4B) {
      continue;
    }

    if(!var_05.var_9F6B) {
      continue;
    }

    var_05 scripts\sp\utility_code::func_1368E();
    anim.var_29B7 = 0;
  }

  var_06 = gettime() - level.var_AA27["allies"];
  if(var_06 < 1500) {
    wait(var_06 / 1000);
  }

  if(isDefined(param_00)) {
    level notify(param_00 + " done speaking");
    return;
  }

  level notify("done speaking");
}

func_28D8(param_00) {
  thread scripts\sp\utility_code::func_28D9(param_00);
}

func_F2DA(param_00) {
  if(!level.var_3D4B) {
    return;
  }

  if(param_00) {
    if((isDefined(self.var_ED17) && !self.var_ED17) || isDefined(self.unittype) && self.unittype == "c8" || isDefined(self.unittype) && self.unittype == "c12" || isDefined(self.asmname) && self.asmname == "seeker") {
      self.var_28CF = 0;
      return;
    }

    self.var_28CF = 1;
    return;
  }

  self.var_28CF = 0;
  if(isDefined(self.var_9F6B) && self.var_9F6B) {
    self waittill("done speaking");
  }
}

func_F5C2(param_00, param_01) {
  if(!level.var_3D4B) {
    return;
  }

  var_02 = getarraykeys(level.var_46BD);
  var_03 = scripts\engine\utility::array_contains(var_02, param_01);
  if(!var_03) {
    return;
  }

  var_04 = getaiarray(param_00);
  foreach(var_06 in var_04) {
    var_06 func_F292(param_01);
    scripts\engine\utility::waitframe();
  }
}

func_F292(param_00) {
  if(!level.var_3D4B) {
    return;
  }

  var_01 = getarraykeys(level.var_46BD);
  var_02 = scripts\engine\utility::array_contains(var_01, param_00);
  if(!var_02) {
    return;
  }

  if(self.type == "dog") {
    return;
  }

  if(isDefined(self.var_9F6B) && self.var_9F6B) {
    self waittill("done speaking");
    wait(0.1);
  }

  scripts\anim\battlechatter_ai::func_E11B();
  waittillframeend;
  self.voice = param_00;
  scripts\anim\battlechatter_ai::func_185D();
}

func_6EEB(param_00, param_01) {
  thread func_F3B0(1, param_00, param_01);
}

func_6EEA(param_00, param_01) {
  thread func_F3B0(0, param_00, param_01);
}

func_F3B0(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = "allies";
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  } else {
    anim.var_C52F = 1;
  }

  while(!isDefined(level.var_3D4B)) {
    wait(0.05);
  }

  if(!level.var_3D4B) {
    return;
  }

  wait(1.5);
  level.var_6EE9[param_01] = param_00;
  var_03 = [];
  var_04 = [];
  if(isDefined(level.var_A056) && isDefined(level.var_A056.var_1630)) {
    if(!isDefined(level.var_D127) || level.player != level.var_D127) {
      level.player.var_C4B2 = 1;
    }

    var_04 = level.var_A056.var_1630;
    var_04 = scripts\engine\utility::array_removeundefined(var_04);
    foreach(var_06 in var_04) {
      if(isDefined(var_06.team) && var_06.team != "allies") {
        var_04 = scripts\engine\utility::array_remove(var_04, var_06);
      }

      if(isDefined(var_06.var_ED2D) && var_06.var_ED2D == "fake") {
        var_04 = scripts\engine\utility::array_remove(var_04, var_06);
      }
    }
  }

  if(!param_00) {
    if(isDefined(level.var_C52F)) {
      anim.var_C52F = 0;
    }
  }

  var_03 = getaiarray(param_01);
  var_03 = scripts\engine\utility::array_combine(var_03, var_04);
  scripts\engine\utility::array_thread(var_03, ::func_F3AF, param_00);
}

func_F3AF(param_00) {
  self.var_6EE9 = param_00;
}

func_7412() {
  var_00 = getaiarray("allies");
  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 func_F3C0(0);
    }
  }

  level.var_7410 = 0;
}

func_7413() {
  var_00 = getaiarray("allies");
  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 func_F3C0(1);
    }
  }

  level.var_7410 = 1;
}

func_F3C0(param_00) {
  if(param_00) {
    self.var_7411 = undefined;
    return;
  }

  self.var_7411 = 1;
}

func_CF8D() {
  thread lib_0E4E::func_CF8E();
}

func_CF8B() {
  thread lib_0E4E::func_CF8C();
}

func_4F4B() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");
  for(;;) {
    var_00 = anglesToForward(self.angles);
    var_01 = var_00 * 30;
    var_02 = var_00 * 20;
    var_03 = anglestoright(self.angles);
    var_04 = var_03 * -10;
    var_03 = var_03 * 10;
    wait(0.05);
  }
}

func_7A97() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = scripts\engine\utility::getstruct(var_01[var_02], "script_linkname");
      if(isDefined(var_03)) {
        var_00[var_00.size] = var_03;
      }
    }
  }

  return var_00;
}

func_7A96() {
  var_00 = func_7A97();
  if(!var_00.size) {
    return undefined;
  }

  return var_00[0];
}

func_7A6F(param_00) {
  var_01 = self;
  while(isDefined(var_01.target)) {
    wait(0.05);
    if(isDefined(var_01.target)) {
      switch (param_00) {
        case "vehiclenode":
          var_01 = getvehiclenode(var_01.target, "targetname");
          break;

        case "pathnode":
          var_01 = getnode(var_01.target, "targetname");
          break;

        case "ent":
          var_01 = getent(var_01.target, "targetname");
          break;

        case "struct":
          var_01 = scripts\engine\utility::getstruct(var_01.target, "targetname");
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

timeout(param_00) {
  self endon("death");
  wait(param_00);
  self notify("timeout");
}

func_F3BC() {
  if(isDefined(self.var_F3BB)) {
    return;
  }

  self.var_C3EC = self.vectortoyaw;
  self.var_C3F4 = self.vehicle_getarray;
  self.var_C3F5 = self.maxsightdistsqrd;
  self.vectortoyaw = 8;
  self.vehicle_getarray = 8;
  self.maxsightdistsqrd = 1;
  self.var_F3BB = 1;
}

func_12BFA() {
  if(!isDefined(self.var_F3BB)) {
    return;
  }

  self.vectortoyaw = self.var_C3EC;
  self.vehicle_getarray = self.var_C3F4;
  self.maxsightdistsqrd = self.var_C3F5;
  self.var_F3BB = undefined;
}

func_22BA(param_00) {
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

func_22B9(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

array_removedeadvehicles(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    if(var_03 func_58DA()) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

array_remove_nokeys(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(param_00[var_03] != param_01) {
      var_02[var_02.size] = param_00[var_03];
    }
  }

  return var_02;
}

func_22B2(param_00, param_01) {
  var_02 = [];
  foreach(var_05, var_04 in param_00) {
    if(param_01 == var_05) {
      continue;
    }

    var_02[var_05] = var_04;
  }

  return var_02;
}

func_22B3(param_00, param_01) {
  if(param_01.size == 0) {
    return param_00;
  }

  var_02 = [];
  foreach(var_09, var_04 in param_00) {
    var_05 = 0;
    foreach(var_07 in param_01) {
      if(var_07 == var_09) {
        var_05 = 1;
        break;
      }
    }

    if(var_05) {
      continue;
    }

    var_02[var_09] = var_04;
  }

  return var_02;
}

array_remove_index(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size - 1; var_02++) {
    if(var_02 == param_01) {
      param_00[var_02] = param_00[var_02 + 1];
      param_01++;
    }
  }

  param_00[param_00.size - 1] = undefined;
  return param_00;
}

func_22A4(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    var_04 notify(param_01, param_02);
  }
}

func_1115A() {
  var_00 = spawnStruct();
  var_00.var_2274 = [];
  var_00.lastindex = 0;
  return var_00;
}

func_11161(param_00, param_01) {
  param_00.var_2274[param_00.lastindex] = param_01;
  param_01.var_11159 = param_00.lastindex;
  param_00.lastindex++;
}

func_11162(param_00, param_01) {
  func_11167(param_00, param_01);
  param_00.var_2274[param_00.lastindex - 1] = undefined;
  param_00.lastindex--;
}

func_11163(param_00, param_01) {
  if(isDefined(param_00.var_2274[param_00.lastindex - 1])) {
    param_00.var_2274[param_01] = param_00.var_2274[param_00.lastindex - 1];
    param_00.var_2274[param_01].var_11159 = param_01;
    param_00.var_2274[param_00.lastindex - 1] = undefined;
    param_00.lastindex = param_00.var_2274.size;
    return;
  }

  param_00.var_2274[param_01] = undefined;
  func_11164(param_00);
}

func_11164(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_2274) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  param_00.var_2274 = var_01;
  foreach(var_06, var_03 in param_00.var_2274) {
    var_03.var_11159 = var_06;
  }

  param_00.lastindex = param_00.var_2274.size;
}

func_11167(param_00, param_01) {
  param_00 scripts\sp\utility_code::func_11166(param_00.var_2274[param_00.lastindex - 1], param_01);
}

func_11165(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01; var_02++) {
    param_00 scripts\sp\utility_code::func_11166(param_00.var_2274[var_02], param_00.var_2274[randomint(param_00.lastindex)]);
  }
}

func_4C39(param_00) {
  return scripts\anim\battlechatter_ai::func_4C3B(param_00);
}

func_7CAE(param_00, param_01) {
  var_02 = newhudelem();
  if(level.console) {
    var_02.x = 68;
    var_02.y = 35;
  } else {
    var_02.x = 58;
    var_02.y = 95;
  }

  var_02.alignx = "center";
  var_02.aligny = "middle";
  var_02.horzalign = "left";
  var_02.vertalign = "middle";
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = level.var_6A04;
  }

  var_02 setclock(var_03, param_00, "hudStopwatch", 64, 64);
  return var_02;
}

func_B8D1() {
  if(level.var_B8D0) {
    return;
  }

  if(isDefined(level.var_BF95)) {
    return;
  }

  if(func_93AB()) {
    level.player _meth_8591(1);
    updategamerprofile();
    scripts\sp\endmission::func_41ED();
  }

  level.var_B8D0 = 1;
  scripts\engine\utility::flag_set("missionfailed");
  if(getdvar("failure_disabled") == "1") {
    return;
  }

  if(isDefined(level.var_B8BE)) {
    thread[[level.var_B8BE]]();
    return;
  }

  missionfailed(func_93AB());
}

func_F487(param_00) {
  level.var_B8BE = param_00;
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return 1;
  }

  return 0;
}

func_EF15() {
  var_00 = gettime();
  if(isDefined(self.var_EF15)) {
    wait(self.var_EF15);
    if(isDefined(self.var_EF1A)) {
      self.var_EF15 = self.var_EF15 + self.var_EF1A;
    }
  } else if(isDefined(self.var_EF1C) && isDefined(self.var_EF1B)) {
    wait(randomfloatrange(self.var_EF1C, self.var_EF1B));
    if(isDefined(self.var_EF1A)) {
      self.var_EF1C = self.var_EF1C + self.var_EF1A;
      self.var_EF1B = self.var_EF1B + self.var_EF1A;
    }
  }

  return gettime() - var_00;
}

func_79C8(param_00, param_01) {
  var_02 = getaiarray(param_00);
  var_03 = [];
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = var_02[var_04];
    if(!isDefined(var_05.var_EDAD)) {
      continue;
    }

    if(var_05.var_EDAD != param_01) {
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  return var_03;
}

get_all_force_color_friendlies() {
  var_00 = getaiarray("allies");
  var_01 = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    if(!isDefined(var_03.var_EDAD)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

func_61C7() {
  if(isDefined(self.var_EDAD)) {
    return;
  }

  if(!isDefined(self.var_C3BE)) {
    return;
  }

  func_F3B5(self.var_C3BE);
  self.var_C3BE = undefined;
}

func_61C8() {
  self.var_5955 = 1;
  func_61C7();
}

func_54F7() {
  if(isDefined(self.var_BF06)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self getplayerheadmodel();
  if(!isDefined(self.var_EDAD)) {
    return;
  }

  self.var_C3BE = self.var_EDAD;
  level.var_22E0[scripts\sp\colors::func_7CE4()][self.var_EDAD] = scripts\engine\utility::array_remove(level.var_22E0[scripts\sp\colors::func_7CE4()][self.var_EDAD], self);
  scripts\sp\colors::func_AB3A();
  self.var_EDAD = undefined;
  self.var_4BDF = undefined;
}

func_414F() {
  func_54F7();
}

func_79C7() {
  var_00 = self.var_EDAD;
  return var_00;
}

func_FEEE(param_00) {
  return level.var_43A3[tolower(param_00)];
}

func_F3B5(param_00) {
  var_01 = func_FEEE(param_00);
  if(!isai(self)) {
    func_F3B7(var_01);
    return;
  }

  if(self.team == "allies") {
    self.logstring = 1;
    self.lookupsoundlength = 64;
    self.vectortoyaw = 0;
    self.vehicle_getarray = 0;
  }

  self.var_ED34 = undefined;
  self.var_ED33 = undefined;
  self.var_C3BE = undefined;
  var_02 = scripts\sp\colors::func_7CE4();
  if(isDefined(self.var_EDAD)) {
    level.var_22E0[var_02][self.var_EDAD] = scripts\engine\utility::array_remove(level.var_22E0[var_02][self.var_EDAD], self);
  }

  self.var_EDAD = var_01;
  level.var_22E0[var_02][var_01] = func_22B9(level.var_22E0[var_02][var_01]);
  level.var_22E0[var_02][self.var_EDAD] = scripts\engine\utility::array_add(level.var_22E0[var_02][self.var_EDAD], self);
  thread scripts\sp\utility_code::func_BF01(var_01);
}

func_F3B7(param_00) {
  self.var_EDAD = param_00;
  self.var_C3BE = undefined;
}

func_6EDC(param_00) {
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

func_6ED8(param_00) {
  self endon("death");
  self endon("flashed");
  wait(0.2);
  self _meth_80D0(0);
  wait(param_00 + 2);
  self _meth_80D0(1);
}

func_E2B0() {
  scripts\common\createfx::restart_fx_looper();
}

pauseexploder(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 scripts\engine\utility::pauseeffect();
      }

      return;
    }

    return;
  }

  foreach(var_06 in level.createfxent) {
    if(!isDefined(var_06.v["exploder"])) {
      continue;
    }

    if(var_06.v["exploder"] != var_03) {
      continue;
    }

    var_06 scripts\engine\utility::pauseeffect();
  }
}

func_E2B1(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 func_E2B0();
      }

      return;
    }

    return;
  }

  foreach(var_06 in level.createfxent) {
    if(!isDefined(var_06.v["exploder"])) {
      continue;
    }

    if(var_06.v["exploder"] != var_03) {
      continue;
    }

    var_06 func_E2B0();
  }
}

func_9326(param_00) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");
  if(param_00) {
    self.var_C3DE = self getthreatbiasgroup();
    var_01 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self give_zombies_perk("ignore_everybody");
    var_02 = [];
    var_02["axis"] = "allies";
    var_02["allies"] = "axis";
    var_03 = getaiarray(var_02[self.team]);
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
  if(self.var_C3DE != "") {
    self give_zombies_perk(self.var_C3DE);
  }

  self.var_C3DE = undefined;
}

func_131CC() {
  scripts\sp\vehicle_code::func_13219();
}

func_13221() {
  thread scripts\sp\vehicle_paths::func_13222();
}

func_131FF(param_00) {
  scripts\sp\vehicle_code::func_13201(param_00);
}

func_13206(param_00) {
  scripts\sp\vehicle_code::func_13207(param_00);
}

func_131D5(param_00, param_01) {
  scripts\sp\vehicle::func_1321A(param_00, param_01);
}

func_864C(param_00, param_01) {
  if(isDefined(param_01)) {
    param_01 = param_01 * -100000;
  } else {
    param_01 = (0, 0, -100000);
  }

  return bulletTrace(param_00, param_00 + param_01, 0, self)["position"];
}

func_3C4A(param_00) {
  self.var_D0CE = self.var_D0CE + param_00;
  self notify("update_health_packets");
  if(self.var_D0CE >= 3) {
    self.var_D0CE = 3;
  }
}

maymovetopoint(param_00, param_01) {
  var_02 = melee(param_00, param_01);
  return var_02[0];
}

melee(param_00, param_01) {
  return scripts\sp\vehicle_code::func_12B8(param_00, param_01);
}

func_1749(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  scripts\sp\starts::func_174A();
  param_00 = tolower(param_00);
  var_07 = scripts\sp\starts::func_174B(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  level.var_10C58[level.var_10C58.size] = var_07;
  level.var_10BA8[param_00] = var_07;
}

func_F343(param_00) {
  level.var_5019 = param_00;
}

func_F344(param_00) {
  level.var_501A = param_00;
}

func_13D91(param_00, param_01, param_02, param_03) {
  var_04 = vectornormalize((param_02[0], param_02[1], 0) - (param_00[0], param_00[1], 0));
  var_05 = anglesToForward((0, param_01[1], 0));
  return vectordot(var_05, var_04) >= param_03;
}

func_7951(param_00, param_01, param_02) {
  var_03 = vectornormalize(param_02 - param_00);
  var_04 = anglesToForward(param_01);
  var_05 = vectordot(var_04, var_03);
  return var_05;
}

func_13D92(param_00, param_01) {
  var_02 = undefined;
  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    var_04 = level.players[var_03] getEye();
    var_02 = scripts\engine\utility::within_fov(var_04, level.players[var_03] getplayerangles(), param_00, param_01);
    if(!var_02) {
      return 0;
    }
  }

  return 1;
}

func_135AF(param_00, param_01) {
  var_02 = param_01 * 1000 - gettime() - param_00;
  var_02 = var_02 * 0.001;
  if(var_02 > 0) {
    wait(var_02);
  }
}

func_29C0() {
  anim.var_EF75 = gettime();
}

func_5480(param_00) {
  func_29C0();
  scripts\sp\anim::func_1F32(self, param_00);
}

func_7749(param_00, param_01) {
  func_29C0();
  scripts\sp\anim::func_1ECD(self, param_00, undefined, undefined, param_01);
}

func_DBEF(param_00, param_01) {
  if(!isDefined(level.var_D24D)) {
    var_02 = spawn("script_origin", (0, 0, 0));
    var_02 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D24D = var_02;
  }

  func_29C0();
  var_03 = 0;
  if(!isDefined(param_01)) {
    var_03 = level.var_D24D func_74D7(::play_sound_on_tag, level.var_EC91[param_00], undefined, 1);
  } else {
    var_03 = level.var_D24D func_74DD(param_01, ::play_sound_on_tag, level.var_EC91[param_00], undefined, 1);
  }

  return var_03;
}

func_DBF2(param_00) {
  level.var_D24D play_sound_on_tag(level.var_EC91[param_00], undefined, 1);
}

func_DBF5() {
  if(!isDefined(level.var_D24D)) {
    return;
  }

  level.var_D24D delete();
}

func_DBF0() {
  if(!isDefined(level.var_D24D)) {
    return;
  }

  level.var_D24D func_74D9();
}

func_DBF1(param_00) {
  if(!isDefined(level.var_D24D)) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D24D = var_01;
  }

  level.var_D24D play_sound_on_tag(level.var_EC91[param_00], undefined, 1);
}

func_DBF4(param_00) {
  return func_DBEF(param_00, 0.05);
}

func_10350(param_00, param_01) {
  scripts\sp\utility_code::func_1778(param_00);
  func_DBEF(param_00, param_01);
}

func_10352(param_00) {
  scripts\sp\utility_code::func_1778(param_00);
  func_DBF5();
  func_DBF1(param_00);
}

func_10353(param_00) {
  scripts\sp\utility_code::func_1778(param_00);
  func_DBF2(param_00);
}

func_D01B(param_00, param_01) {
  return func_D01E(param_00, 0, undefined, undefined, undefined, param_01);
}

func_1369(param_00, param_01, param_02, param_03, param_04) {
  if(func_9BB2()) {
    return;
  }

  var_05 = spawn("script_origin", (0, 0, 0));
  var_05 endon("death");
  var_05.origin = self.origin;
  var_05.angles = self.angles;
  var_05 linkto(self);
  if(param_01 > 0) {
    var_05 scripts\engine\utility::delaycall(param_01, ::playsound, param_00, "sounddone");
  } else {
    var_05 playSound(param_00, "sounddone");
  }

  if(isDefined(param_02)) {
    if(isarray(param_02)) {
      for(var_06 = 0; var_06 < param_02.size; var_06++) {
        if(isDefined(param_04) && isDefined(param_04[var_06])) {
          level.player scripts\engine\utility::delaythread(param_03[var_06], ::func_D090, param_02[var_06], param_04[var_06]);
          continue;
        }

        level.player scripts\engine\utility::delaythread(param_03[var_06], ::func_D090, param_02[var_06]);
      }
    } else if(isDefined(param_04)) {
      level.player scripts\engine\utility::delaythread(param_03, ::func_D090, param_02, param_04);
    } else {
      level.player scripts\engine\utility::delaythread(param_03, ::func_D090, param_02);
    }
  }

  if(param_01 > 0) {
    wait(param_01);
  }

  if(!isDefined(scripts\sp\utility_code::func_1362A(var_05, level.player))) {
    var_05 stopsounds();
  }

  wait(0.05);
  var_05 delete();
}

func_D01E(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_D01D)) {
    var_06 = spawn("script_origin", (0, 0, 0));
    var_06 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D01D = var_06;
  }

  func_29C0();
  var_07 = 0;
  if(!isDefined(param_05)) {
    var_07 = level.var_D01D func_74D7(::func_1369, level.var_EC8E[param_00], param_01, param_02, param_03, param_04);
  } else {
    var_07 = level.var_D01D func_74DD(param_05, ::func_1369, level.var_EC8E[param_00], param_01, param_02, param_03, param_04);
  }

  return var_07;
}

func_D020() {
  if(!isDefined(level.var_D01D)) {
    return;
  }

  level.var_D01D delete();
}

func_D01C() {
  if(!isDefined(level.var_D01D)) {
    return;
  }

  level.var_D01D func_74D9();
}

func_D01F(param_00) {
  func_D020();
  if(!isDefined(level.var_D01D)) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D01D = var_01;
  }

  level.var_D01D func_1369(level.var_EC8E[param_00], 0);
}

func_1034D(param_00, param_01) {
  scripts\sp\utility_code::func_1773(param_00);
  func_D01B(param_00, param_01);
}

func_1034F(param_00) {
  scripts\sp\utility_code::func_1773(param_00);
  func_D01F(param_00);
}

func_1034E(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\sp\utility_code::func_1773(param_00);
  func_D01E(param_00, param_01, param_02, param_03, param_04, param_05);
}

func_10346(param_00) {
  scripts\sp\utility_code::func_175F(param_00);
  func_5480(param_00);
}

func_10347(param_00) {
  scripts\sp\utility_code::func_1760(param_00);
  func_7749(param_00);
}

func_DBF3(param_00) {
  func_DBEF(param_00);
}

string(param_00) {
  return "" + param_00;
}

func_9329(param_00, param_01) {
  setignoremegroup(param_00, param_01);
  setignoremegroup(param_01, param_00);
}

func_16E5(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_05["function"] = param_01;
  var_05["param1"] = param_02;
  var_05["param2"] = param_03;
  var_05["param3"] = param_04;
  level.var_10707[param_00][level.var_10707[param_00].size] = var_05;
}

func_E031(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < level.var_10707[param_00].size; var_03++) {
    if(level.var_10707[param_00][var_03]["function"] != param_01) {
      var_02[var_02.size] = level.var_10707[param_00][var_03];
    }
  }

  level.var_10707[param_00] = var_02;
}

func_693E(param_00, param_01) {
  if(!isDefined(level.var_10707)) {
    return 0;
  }

  for(var_02 = 0; var_02 < level.var_10707[param_00].size; var_02++) {
    if(level.var_10707[param_00][var_02]["function"] == param_01) {
      return 1;
    }
  }

  return 0;
}

func_E08B(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_10708) {
    if(var_03["function"] == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  self.var_10708 = var_01;
}

func_1747(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in self.var_10708) {
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
  self.var_10708[self.var_10708.size] = var_09;
}

func_228A(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(isDefined(param_00[var_01])) {
      param_00[var_01] delete();
    }
  }
}

func_229F(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    param_00[var_01] _meth_81D0();
  }
}

func_931D(param_00) {
  self endon("death");
  self.precacheshader = 1;
  if(isDefined(param_00)) {
    wait(param_00);
  } else {
    wait(0.5);
  }

  self.precacheshader = 0;
}

func_15F5(param_00) {
  var_01 = getent(param_00, "targetname");
  var_01 func_15F1();
}

func_15F3(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 func_15F1();
}

func_5599(param_00) {
  var_01 = getent(param_00, "targetname");
  var_01 scripts\engine\utility::trigger_off();
}

func_5598(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 scripts\engine\utility::trigger_off();
}

func_624C(param_00) {
  var_01 = getent(param_00, "targetname");
  var_01 scripts\engine\utility::trigger_on();
}

func_624B(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 scripts\engine\utility::trigger_on();
}

func_77E1() {
  if(!isDefined(self.unique_id)) {
    func_F294();
  }

  return self.unique_id;
}

func_F294() {
  if(!isDefined(level.var_19C9)) {
    level.var_19C9 = 0;
  }

  self.unique_id = "ai" + level.var_19C9;
  level.var_19C9++;
}

func_F5C3(param_00, param_01) {
  var_02 = getaiarray(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_02[var_03].triggeroneoffradarsweep = param_01;
  }
}

func_E198() {
  scripts\sp\colors::func_43AA();
}

func_107B3(param_00, param_01) {
  scripts\sp\colors::func_43AC(param_00, param_01);
}

func_F55D(param_00, param_01) {
  if(!isDefined(level.var_4B58)) {
    level.var_4B58 = [];
  }

  param_00 = func_FEEE(param_00);
  param_01 = func_FEEE(param_01);
  level.var_4B58[param_00] = param_01;
  if(!isDefined(level.var_4B58[param_01])) {
    func_F38A(param_01);
  }
}

func_F38A(param_00) {
  if(!isDefined(level.var_4B58)) {
    level.var_4B58 = [];
  }

  level.var_4B58[param_00] = "none";
}

func_DFEB(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isalive(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

func_DFDA(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    if(!isDefined(var_04.var_EDAD)) {
      continue;
    }

    if(var_04.var_EDAD == param_01) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

func_E05E(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    if(!isDefined(var_04.script_noteworthy)) {
      continue;
    }

    if(var_04.script_noteworthy == param_01) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

func_78AF(param_00, param_01) {
  var_02 = func_79C8("allies", param_00);
  if(!isDefined(param_01)) {
    var_03 = level.player.origin;
  } else {
    var_03 = var_02;
  }

  return scripts\engine\utility::getclosest(var_03, var_02);
}

func_E0AF(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(!issubstr(param_00[var_03].classname, param_01)) {
      continue;
    }

    var_02[var_02.size] = param_00[var_03];
  }

  return var_02;
}

func_E0B0(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(!issubstr(param_00[var_03].model, param_01)) {
      continue;
    }

    var_02[var_02.size] = param_00[var_03];
  }

  return var_02;
}

func_78B0(param_00, param_01, param_02) {
  var_03 = func_79C8("allies", param_00);
  if(!isDefined(param_02)) {
    var_04 = level.player.origin;
  } else {
    var_04 = var_03;
  }

  var_03 = func_E0AF(var_03, param_01);
  return scripts\engine\utility::getclosest(var_04, var_03);
}

func_DA6E(param_00, param_01) {
  for(;;) {
    var_02 = func_78AF(param_00);
    if(!isalive(var_02)) {
      wait(1);
      continue;
    }

    var_02 func_F3B5(param_01);
  }
}

func_9931(param_00, param_01) {
  for(;;) {
    var_02 = func_78AF(param_00);
    if(!isalive(var_02)) {
      return;
    }

    var_02 func_F3B5(param_01);
  }
}

func_9932(param_00, param_01, param_02) {
  for(;;) {
    var_03 = func_78B0(param_00, param_02);
    if(!isalive(var_03)) {
      return;
    }

    var_03 func_F3B5(param_01);
  }
}

func_DA6F(param_00, param_01, param_02) {
  for(;;) {
    var_03 = func_78B0(param_00, param_02);
    if(!isalive(var_03)) {
      wait(1);
      continue;
    }

    var_03 func_F3B5(param_01);
  }
}

riotshield_lock_orientation(param_00) {
  self orientmode("face angle", param_00);
  self.setmusicstate = 1;
}

riotshield_unlock_orientation() {
  self.setmusicstate = 0;
}

func_9934(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = [];
  for(var_05 = 0; var_05 < param_00.size; var_05++) {
    var_06 = param_00[var_05];
    if(var_03 || !issubstr(var_06.classname, param_02)) {
      var_04[var_04.size] = var_06;
      continue;
    }

    var_03 = 1;
    var_06 func_F3B5(param_01);
  }

  return var_04;
}

func_9933(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_05 = param_00[var_04];
    if(var_02) {
      var_03[var_03.size] = var_05;
      continue;
    }

    var_02 = 1;
    var_05 func_F3B5(param_01);
  }

  return var_03;
}

func_13624(param_00) {
  scripts\sp\utility_code::func_13634(param_00, "script_noteworthy");
}

func_13630(param_00) {
  scripts\sp\utility_code::func_13634(param_00, "targetname");
}

func_135D5(param_00, param_01) {
  if(scripts\engine\utility::flag(param_00)) {
    return;
  }

  level endon(param_00);
  wait(param_01);
}

func_135F1(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

func_13635(param_00) {
  self endon("trigger");
  wait(param_00);
}

func_135CA(param_00, param_01) {
  var_02 = spawnStruct();
  var_03 = [];
  var_03 = scripts\engine\utility::array_combine(var_03, getEntArray(param_00, "targetname"));
  var_03 = scripts\engine\utility::array_combine(var_03, getEntArray(param_01, "targetname"));
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_02 thread scripts\sp\utility_code::func_65FB(var_03[var_04]);
  }

  var_02 waittill("done");
}

func_5CC9(param_00) {
  var_01 = lib_0B77::func_1085E(param_00);
  return var_01;
}

func_6B47(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  var_01 = lib_0B77::func_1085E(param_00);
  var_01[[level.var_6B43]]();
  var_01.var_10707 = param_00.var_10708;
  var_01.var_10708 = undefined;
  var_01 thread lib_0B77::func_E81A();
  var_01.spawner = param_00;
  var_01.var_ED8A = 1;
  if(isDefined(param_00.var_EE5A)) {
    var_01.var_C05C = param_00.var_EE5A;
  }

  if(isDefined(param_00.var_EE5F)) {
    var_01.noragdoll = param_00.var_EE5F;
  }

  return var_01;
}

func_2C17(param_00) {
  var_01 = lib_0B77::func_1085E(param_00);
  var_01.var_10707 = param_00.var_10708;
  var_01.var_10708 = undefined;
  var_01 thread lib_0B77::func_E81A();
  return var_01;
}

func_5CC8(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  var_01 = lib_0B77::func_1085E(param_00);
  var_01[[level.var_5C7C]]();
  var_01.var_10707 = param_00.var_10708;
  var_01.var_10708 = undefined;
  var_01 thread lib_0B77::func_E81A();
  return var_01;
}

func_48C1() {
  var_00 = getEntArray("corpse", "script_noteworthy");
  if(var_00.size) {
    func_22C7(var_00, ::func_9591);
  }

  var_00 = getEntArray("corpse_noragdoll", "script_noteworthy");
  if(var_00.size) {
    func_22C7(var_00, ::func_9591);
  }

  var_00 = func_7C84("corpse", "script_noteworthy");
  if(var_00.size) {
    func_22C7(var_00, ::func_9591);
  }
}

func_9591() {
  if(!isDefined(self.script_animation)) {
    self delete();
    return;
  }

  self.var_1FBB = "corpse";
  self _meth_839E();
  if(isai(self)) {
    self.precacheleaderboards = 1;
  } else {
    self notsolid();
  }

  if(isDefined(self.target)) {
    var_00 = scripts\engine\utility::get_target_ent(self.target);
    self dontinterpolate();
    if(isai(self)) {
      self _meth_80F1(var_00.origin, var_00.angles);
    } else {
      self.origin = var_00.origin;
      self.angles = var_00.angles;
    }
  }

  var_01 = getweaponmodel(self.var_394);
  if(isDefined(var_01) && var_01 != "") {
    if(isai(self)) {
      func_86E4();
    } else {
      self detach(var_01, "tag_weapon_right");
    }

    if(!isDefined(self.var_EE5A)) {
      var_02 = spawn("weapon_" + self.var_394, self gettagorigin("tag_weapon_right"));
      var_02.angles = self gettagangles("tag_weapon_right");
    }
  }

  if(isai(self)) {
    if(self.script_noteworthy == "corpse_noragdoll") {
      self.noragdoll = 1;
    }

    func_F333(self.script_animation);
    self _meth_81D0();
    return;
  }

  self animscripted("corpse_anim", self.origin, self.angles, func_7DC1(self.script_animation), "deathplant", undefined, 0);
  if(self.script_noteworthy != "corpse_noragdoll") {
    var_03 = getanimlength(func_7DC1(self.script_animation));
    if(var_03 > 0) {
      wait(var_03 * 0.35);
    }

    if(isDefined(self.var_71C8)) {
      self[[self.var_71C8]]();
    }

    self giverankxp();
  }
}

func_7D1E() {
  if(isDefined(self.var_ED9A)) {
    return self.var_ED9A;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

func_F340() {
  self.vehicle_getarray = 192;
  self.vectortoyaw = 192;
}

func_4793(param_00) {
  if(param_00 == "on") {
    func_61E7();
    return;
  }

  func_5514();
}

func_13861(param_00, param_01, param_02) {
  if(param_00 == "on") {
    self.var_1198.var_13863 = 1;
    if(isDefined(param_02)) {
      if(param_02 == "right") {
        self.var_13862 = "right";
      } else {
        self.var_13862 = "left";
      }
    }

    if(!isDefined(param_01)) {
      self.var_13864 = level.player;
      return;
    }

    self.var_13864 = param_01;
    if(!isDefined(param_01.origin)) {
      return;
    }

    return;
  }

  self.var_1198.var_13863 = 0;
}

func_DC45(param_00) {
  if(isplayer(self)) {
    switch (param_00) {
      case "raise":
        lib_0E4B::func_1348D();
        break;

      case "lower":
        lib_0E4B::func_13485();
        break;
    }

    return;
  }

  if(param_00 == "raise") {
    self.asm.var_DC48 = 1;
  } else {
    self.asm.var_DC48 = 0;
  }

  lib_0A1E::func_236E();
}

func_61E7(param_00) {
  if(self.type == "dog") {
    return;
  }

  if(!isDefined(param_00)) {
    self.var_4797 = 1;
  }

  self.var_358 = 0.2;
  level thread scripts\anim\cqb::func_6CB4();
  func_51E1("cqb");
}

func_5514() {
  if(self.type == "dog") {
    return;
  }

  self.var_4797 = undefined;
  self.var_358 = 0.3;
  self.var_478F = undefined;
  func_4145();
}

func_622F() {
  self.var_32D4 = 1;
}

func_5574() {
  self.var_32D4 = undefined;
}

func_4788(param_00) {
  if(!isDefined(param_00)) {
    self.var_4792 = undefined;
    return;
  }

  self.var_4792 = param_00;
  if(!isDefined(param_00.origin)) {}
}

func_F3B8(param_00) {
  if(isDefined(param_00) && param_00) {
    self.forcesuppression = 1;
    return;
  }

  self.forcesuppression = undefined;
}

func_F225(param_00, param_01) {
  if(isDefined(param_01)) {
    self notify(param_00, param_01);
    return;
  }

  self notify(param_00);
}

func_137A3(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03 endon("complete");
  var_03 scripts\engine\utility::delaythread(param_02, ::func_F225, "complete");
  self waittillmatch(param_01, param_00);
}

func_137A4(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03 endon("complete");
  var_03 scripts\engine\utility::delaythread(param_02, ::func_F225, "complete");
  self waittill(param_00, param_01);
  return param_01;
}

func_6DDE(param_00) {
  if(!isDefined(self.var_11A3F)) {
    self.var_11A3F = [];
  }

  if(isDefined(self.var_11A3F[param_00.unique_id])) {
    return 0;
  }

  self.var_11A3F[param_00.unique_id] = 1;
  return 1;
}

func_7DC1(param_00) {
  return level.var_EC85[self.var_1FBB][param_00];
}

func_8BC9(param_00) {
  return isDefined(level.var_EC85[self.var_1FBB][param_00]);
}

func_7DC2(param_00, param_01) {
  return level.var_EC85[param_01][param_00];
}

func_7DC3(param_00) {
  return level.var_EC85["generic"][param_00];
}

func_8BCA(param_00) {
  return isDefined(level.var_EC85["generic"][param_00]);
}

func_16EB(param_00, param_01, param_02) {
  if(!isDefined(level.var_12750)) {
    level.var_12750 = [];
    level.var_1274F = [];
  }

  level.var_12750[param_00] = param_01;
  precachestring(param_01);
  if(isDefined(param_02)) {
    level.var_1274F[param_00] = param_02;
  }
}

clearthreatbias(param_00, param_01) {
  setthreatbias(param_00, param_01, 0);
  setthreatbias(param_01, param_00, 0);
}

func_11813() {
  scripts\anim\combat_utility::func_11814();
}

func_F417(param_00) {
  self.precacherumble = param_00;
}

func_F3E0(param_00) {
  self.objective_playermask_showto = param_00;
}

func_F2A8(param_00) {
  self.var_30 = param_00;
}

func_F582(param_00, param_01) {
  if(getdvarint("ai_iw7", 0) == 1) {
    var_02 = "combat";
    func_F48E(var_02, param_00);
    self.var_E80C = level.var_EC85[self.var_1FBB][param_00];
    return;
  }

  if(isDefined(var_02)) {
    self.alwaysrunforward = var_02;
  } else {
    self.alwaysrunforward = 1;
  }

  func_559A();
  self.var_E80C = level.var_EC85[self.var_1FBB][param_01];
  self.var_13872 = self.var_E80C;
}

func_F48E(param_00, param_01) {
  scripts\asm\asm::asm_setdemeanoranimoverride(param_00, "move", level.var_EC85[self.var_1FBB][param_01]);
}

func_4169(param_00) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(param_00, "move");
}

func_F40E(param_00, param_01) {
  scripts\asm\asm::asm_setdemeanoranimoverride(param_00, "idle", level.var_EC85[self.var_1FBB][param_01]);
}

func_415D(param_00) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(param_00, "idle");
}

func_F35F() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.var_55ED = 1;
  self.var_EE56 = 1;
}

func_F303(param_00, param_01, param_02, param_03) {
  scripts\anim\animset::func_950F(param_00, param_01, param_02, param_03);
}

func_F48F(param_00, param_01, param_02) {
  var_03 = scripts\anim\utility::func_B028(param_00);
  if(isarray(param_01)) {
    var_03["straight"] = param_01[0];
    var_03["move_f"] = param_01[0];
    var_03["move_l"] = param_01[1];
    var_03["move_r"] = param_01[2];
    var_03["move_b"] = param_01[3];
  } else {
    var_03["straight"] = param_01;
    var_03["move_f"] = param_01;
  }

  if(isDefined(param_02)) {
    var_03["sprint"] = param_02;
  }

  self.custommoveanimset[param_00] = var_03;
}

func_F2C9(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(isDefined(self.var_22EE)) {
    self.var_22EE = param_00;
    return;
  }
}

func_412D() {
  if(isDefined(self.var_22EE)) {
    self.var_22EE = 1;
  }
}

func_C81A(param_00) {
  var_01 = lib_0A1E::func_2357(self.asm.archetype, "move_walk_loop", "casual_purpose");
  scripts\asm\asm::asm_setdemeanoranimoverride(param_00, "move", var_01);
  if(param_00 == "casual") {
    thread func_F2C9(1.15);
  }
}

func_416A() {
  thread func_4169(scripts\asm\asm::asm_getdemeanor());
  thread func_412D();
}

func_51E1(param_00) {
  if(param_00 == "cqb") {
    level thread scripts\anim\cqb::func_6CB4();
  }

  if(self.asmname == "soldier") {
    if(param_00 == "casual" || param_00 == "casual_walk" || param_00 == "casual_gun") {
      self.var_358 = 0.1;
    } else if(param_00 == "cqb") {
      self.var_358 = 0.2;
    } else {
      self.var_358 = 0.3;
    }
  }

  self.demeanoroverride = param_00;
}

func_4145() {
  self.demeanoroverride = undefined;
  if(self.asmname == "soldier") {
    self.var_358 = 0.3;
  }
}

func_F3C8(param_00) {
  var_01 = level.var_EC85["generic"][param_00];
  if(isarray(var_01)) {
    self.var_1095A = var_01;
    return;
  }

  self.var_1095A[0] = var_01;
}

func_13035(param_00, param_01, param_02) {
  scripts\asm\asm_bb::func_296E(param_00);
  scripts\asm\asm_bb::func_296F(param_01);
  var_04 = (-16, 0, 0);
  var_05 = param_00 gettweakablevalue(var_04);
  var_06 = physicstrace(var_05, var_05 + (0, 0, -72));
  var_07 = (0, param_00.angles[1], 0);
  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self _meth_80F1(var_06, var_07);
  var_08 = param_00 getlinkedparent();
  if(isDefined(var_08)) {
    self linkto(var_08);
  }

  var_09 = self.asmname;
  var_0A = self.var_164D[var_09].var_4BC0;
  var_0B = level.asm[var_09].states[var_0A];
  scripts\asm\asm::func_2388(var_09, var_0A, var_0B, var_0B.var_116FB);
  scripts\asm\asm::func_238A(var_09, "script_use_turret", 0.2);
}

func_11051() {
  scripts\asm\asm_bb::func_296E(undefined);
  scripts\asm\asm_bb::func_296F(undefined);
}

func_4154() {
  self.var_1095A = undefined;
  self notify("stop_specialidle");
}

func_F3CB(param_00, param_01) {
  func_F3CC(param_00, undefined, param_01);
}

func_4155() {
  self notify("movemode");
  func_624D();
  self.var_E80C = undefined;
  self.var_13872 = undefined;
}

func_F3CC(param_00, param_01, param_02) {
  self notify("movemode");
  if(!isDefined(param_02) || param_02) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.var_E80C = level.var_EC85["generic"][param_00];
  self.var_13872 = self.var_E80C;
  if(isDefined(param_01)) {
    self.var_E80B = level.var_EC85["generic"][param_01];
    self.var_13871 = self.var_E80B;
    return;
  }

  self.var_E80B = undefined;
  self.var_13871 = undefined;
}

func_F583(param_00, param_01, param_02) {
  self notify("movemode");
  if(!isDefined(param_02) || param_02) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.var_E80C = level.var_EC85[self.var_1FBB][param_00];
  self.var_13872 = self.var_E80C;
  if(isDefined(param_01)) {
    self.var_E80B = level.var_EC85[self.var_1FBB][param_01];
    self.var_13871 = self.var_E80B;
    return;
  }

  self.var_E80B = undefined;
  self.var_13871 = undefined;
}

func_417A() {
  self notify("clear_run_anim");
  self notify("movemode");
  if(self.type == "dog") {
    self.a.movement = "run";
    self.disablearrivals = 0;
    self.var_55ED = 0;
    self.var_EE56 = undefined;
    return;
  }

  if(getdvarint("ai_iw7", 0) == 1) {
    var_00 = "combat";
    self.var_1198.alwaysrunforward = 0;
    func_4169(var_00);
    self.var_E80C = undefined;
    return;
  }

  if(!isDefined(self.var_3B17)) {
    func_624D();
  }

  self.alwaysrunforward = undefined;
  self.var_E80C = undefined;
  self.var_13872 = undefined;
  self.var_E80B = undefined;
  self.var_13871 = undefined;
}

func_CB0F(param_00, param_01, param_02) {
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
    if(self.var_9F == "script_vehicle") {
      var_06 = self vehicle_getspeed();
      if(var_06 < var_04) {
        var_07 = var_06 / var_04;
        param_02 = var_05 * var_07;
      }
    }

    var_08 = distancesquared(self.origin, level.player.origin);
    var_07 = var_03 / var_08;
    if(var_07 > 1) {
      var_07 = 1;
    }

    param_02 = param_02 * var_07;
    var_09 = param_02[0] + param_02[1] + param_02[2];
    if(var_09 > 0.025) {
      physicsjitter(self.origin, param_00, param_01, param_02[2], param_02[2] * 2);
    }
  }
}

func_F3D5(param_00) {
  self setgoalentity(param_00);
}

func_15F1(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    func_15F2(param_02);
    return;
  }

  var_03 = getEntArray(param_00, param_01);
  scripts\engine\utility::array_thread(var_03, ::func_15F2, param_02);
}

func_15F2(param_00) {
  if(isDefined(self.var_ED33)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("allies");
  }

  if(isDefined(self.var_ED34)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("axis");
  }

  self notify("trigger", param_00);
}

func_F1DE() {
  self delete();
}

func_8B6C() {
  if(scripts\sp\colors::func_7CE4() == "axis") {
    return isDefined(self.var_ED34) || isDefined(self.var_EDAD);
  }

  return isDefined(self.var_ED33) || isDefined(self.var_EDAD);
}

func_413D() {
  func_4186("axis");
  func_4186("allies");
}

func_4186(param_00) {
  level.var_4BE0[param_00]["r"] = undefined;
  level.var_4BE0[param_00]["b"] = undefined;
  level.var_4BE0[param_00]["c"] = undefined;
  level.var_4BE0[param_00]["y"] = undefined;
  level.var_4BE0[param_00]["p"] = undefined;
  level.var_4BE0[param_00]["o"] = undefined;
  level.var_4BE0[param_00]["g"] = undefined;
}

func_C12D(param_00, param_01) {
  self endon("death");
  if(param_01 > 0) {
    wait(param_01);
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(param_00);
}

func_BE49() {
  self.var_C3FB = self.name;
  self.name = "";
}

func_BE4A() {
  self.name = self.var_C3FB;
}

func_86E4() {
  if(isai(self)) {
    scripts\anim\shared::placeweaponon(self.var_394, "none");
    return;
  }

  self detach(getweaponmodel(self.var_394), "tag_weapon_right");
}

func_86E2() {
  if(isai(self)) {
    scripts\anim\shared::placeweaponon(self.var_394, "right");
    return;
  }

  self attach(getweaponmodel(self.var_394), "tag_weapon_right");
}

func_CC06(param_00, param_01) {
  if(!scripts\anim\utility::func_1A18(param_00)) {
    scripts\anim\init::func_98E1(param_00);
  }

  scripts\anim\shared::placeweaponon(param_00, param_01);
}

func_72EC(param_00, param_01) {
  if(!scripts\anim\init::func_A000(param_00)) {
    scripts\anim\init::func_98E1(param_00);
  }

  var_02 = self.var_394 != "none";
  var_03 = scripts\anim\utility_common::isusingsidearm();
  var_04 = param_01 == "sidearm";
  var_05 = param_01 == "secondary";
  if(var_02 && var_03 != var_04) {
    if(var_03) {
      var_06 = "none";
    } else if(var_06) {
      var_06 = "back";
    } else {
      var_06 = "chest";
    }

    scripts\anim\shared::placeweaponon(self.var_394, var_06);
    self.lastweapon = self.var_394;
  } else {
    self.lastweapon = param_00;
  }

  scripts\anim\shared::placeweaponon(param_00, "right");
  if(var_04) {
    self.var_101B4 = param_00;
  } else if(var_05) {
    self.secondaryweapon = param_00;
  } else {
    self.primaryweapon = param_00;
  }

  self.var_394 = param_00;
  self.bulletsinclip = weaponclipsize(self.var_394);
  self notify("weapon_switch_done");
}

func_D1FD(param_00) {
  var_01 = level.player.origin;
  for(;;) {
    if(distance(var_01, level.player.origin) > param_00) {
      break;
    }

    wait(0.05);
  }
}

func_13763(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  thread scripts\sp\utility_code::func_13764(var_04, param_00, param_01);
  thread scripts\sp\utility_code::func_13764(var_04, param_02, param_03);
  var_04 waittill("done");
}

func_137AA(param_00) {
  self waittill(param_00);
}

func_56BA(param_00, param_01, param_02, param_03) {
  var_04 = func_7B92();
  if(isDefined(level.var_1274F[param_00])) {
    if(var_04[[level.var_1274F[param_00]]]()) {
      return;
    }

    var_04 thread scripts\sp\utility_code::func_9021(level.var_12750[param_00], level.var_1274F[param_00], param_01, param_02, param_03);
    return;
  }

  var_04 thread scripts\sp\utility_code::func_9021(level.var_12750[param_00]);
}

func_56BE(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_7B92();
  if(isDefined(level.var_1274F[param_00]) && var_05[[level.var_1274F[param_00]]]()) {
    return;
  }

  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 6);
  var_05 thread scripts\sp\utility_code::func_9021(level.var_12750[param_00], level.var_1274F[param_00], param_02, param_03, param_04, param_01);
}

func_56BF(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_7B92();
  if(isDefined(level.var_1274F[param_00]) && var_06[[level.var_1274F[param_00]]]()) {
    return;
  }

  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 6);
  var_06 thread scripts\sp\utility_code::func_9021(level.var_12750[param_00], level.var_1274F[param_00], param_03, param_04, param_05, param_01, param_02);
}

func_56BB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  var_0A = scripts\sp\utility_code::func_900D(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  func_56BA(var_0A, param_07, param_08, param_09);
  thread scripts\sp\utility_code::func_900E(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

func_56BC(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  var_0B = scripts\sp\utility_code::func_900D(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
  thread func_56BE(var_0B, param_01, param_08, param_09, param_0A);
  thread scripts\sp\utility_code::func_900E(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_56BD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_08)) {
    param_08 = 0;
  }

  var_0C = scripts\sp\utility_code::func_900D(param_00, param_03, param_04, param_05, param_06, param_07, param_08);
  thread func_56BF(var_0C, param_01, param_02, param_09, param_0A, param_0B);
  thread scripts\sp\utility_code::func_900E(param_00, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_7ECF(param_00) {
  return level.var_EC85["generic"][param_00];
}

func_61E3() {
  self.var_ED27 = 1;
}

func_550D() {
  self.var_ED27 = 0;
  self notify("stop_being_careful");
}

func_623B() {
  self.var_10AB7 = 1;
}

func_5588() {
  self.var_10AB7 = undefined;
}

func_550C() {
  self.disablebulletwhizbyreaction = 1;
}

func_61DF() {
  self.disablebulletwhizbyreaction = undefined;
}

func_F39F() {
  self.logstring = 1;
}

func_F39E() {
  self.logstring = 0;
}

func_10619(param_00, param_01) {
  if(isDefined(self.var_ED52)) {
    self endon("death");
    wait(self.var_ED52);
  }

  var_02 = undefined;
  var_03 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
  if(isDefined(self.var_ED6E)) {
    var_02 = func_5CC8(self);
  } else if(isDefined(self.var_ED8A)) {
    var_02 = func_6B47(self);
  } else if(isDefined(self.var_ED1B)) {
    var_02 = func_2C17(self);
  } else if(isDefined(self.var_EDB3) || isDefined(param_00)) {
    var_02 = self _meth_8393(var_03);
  } else {
    var_02 = self dospawn(var_03);
  }

  if(isDefined(param_01) && param_01 && isalive(var_02)) {
    var_02 func_B14F();
  }

  if(!isDefined(self.var_ED6E) && !isDefined(self.var_ED8A) && !isDefined(self.var_ED1B)) {
    func_106ED(var_02);
  }

  if(isDefined(self.var_EEB5)) {
    self delete();
  }

  return var_02;
}

func_74D7(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06 thread scripts\sp\utility_code::func_74DB(self, param_00, param_01, param_02, param_03, param_04, param_05);
  return scripts\sp\utility_code::func_74DF(var_06);
}

func_74DD(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07 thread scripts\sp\utility_code::func_74DB(self, param_01, param_02, param_03, param_04, param_05, param_06);
  if(isDefined(var_07.var_74DA) || var_07 scripts\engine\utility::waittill_any_timeout_1(param_00, "function_stack_func_begun") != "timeout") {
    return scripts\sp\utility_code::func_74DF(var_07);
  }

  var_07 notify("death");
  return 0;
}

func_74D9() {
  var_00 = [];
  if(isDefined(self.var_74D7[0]) && isDefined(self.var_74D7[0].var_74DA)) {
    var_00[0] = self.var_74D7[0];
  }

  self.var_74D7 = undefined;
  self notify("clear_function_stack");
  waittillframeend;
  if(!var_00.size) {
    return;
  }

  if(!var_00[0].var_74DA) {
    return;
  }

  self.var_74D7 = var_00;
}

func_5528() {
  self.var_55ED = 1;
}

func_61F7() {
  self.var_55ED = undefined;
}

func_559A() {
  self.noturnanims = 1;
}

func_624D() {
  self.noturnanims = undefined;
}

func_5504() {
  self.disablearrivals = 1;
}

func_61DB() {
  self endon("death");
  waittillframeend;
  self.disablearrivals = undefined;
}

func_F2E1(param_00, param_01) {
  setblur(param_00, param_01);
}

func_F3DD(param_00) {
  self.objective_playermask_showto = param_00;
}

func_F3D9(param_00) {
  self.var_A906 = param_00;
  self.var_A907 = undefined;
  self.var_A905 = undefined;
  self give_more_perk(param_00);
}

func_F3DA(param_00) {
  var_01 = getnode(param_00, "targetname");
  func_F3D9(var_01);
}

func_F3DC(param_00) {
  self.var_A906 = undefined;
  self.var_A907 = param_00;
  self.var_A905 = undefined;
  self give_mp_super_weapon(param_00);
}

func_F3D3(param_00) {
  func_F3DC(param_00.origin);
  self.var_A905 = param_00;
  if(isstruct(param_00) && !isDefined(param_00.type)) {
    param_00.type = "struct";
  }
}

func_C27C(param_00) {
  objective_state(param_00, "done");
  level notify("objective_complete" + param_00);
}

func_7C84(param_00, param_01) {
  var_02 = getspawnerarray();
  var_03 = [];
  if(param_01 == "code_classname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_05.var_9F) && var_05.var_9F == param_00) {
        var_03[var_03.size] = var_05;
      }
    }
  } else if(param_01 == "classname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_05.classname) && var_05.classname == param_00) {
        var_03[var_03.size] = var_05;
      }
    }
  } else if(param_01 == "target") {
    foreach(var_05 in var_02) {
      if(isDefined(var_05.target) && var_05.target == param_00) {
        var_03[var_03.size] = var_05;
      }
    }
  } else if(param_01 == "script_linkname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_05.destroynavobstacle) && var_05.destroynavobstacle == param_00) {
        var_03[var_03.size] = var_05;
      }
    }
  } else if(param_01 == "script_noteworthy") {
    foreach(var_05 in var_02) {
      if(isDefined(var_05.script_noteworthy) && var_05.script_noteworthy == param_00) {
        var_03[var_03.size] = var_05;
      }
    }
  } else if(param_01 == "targetname") {} else {}

  return var_03;
}

func_22C6(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_03 = [];
  foreach(var_05 in param_00) {
    var_05.var_C1 = 1;
    if(getsubstr(var_05.classname, 7, 10) == "veh") {
      var_06 = var_05 func_10808();
      if(isDefined(var_06.target) && !isDefined(var_06.var_EE2B)) {
        var_06 thread scripts\sp\vehicle_paths::setsuit();
      }

      var_03[var_03.size] = var_06;
      continue;
    }

    var_06 = var_05 func_10619(param_01);
    if(!param_02) {}

    var_03[var_03.size] = var_06;
  }

  if(!param_02) {}

  return var_03;
}

func_22CD(param_00, param_01, param_02, param_03) {
  var_04 = getspawnerarray(param_00);
  var_04 = func_22A2(var_04, getEntArray(param_00, "targetname"));
  if(isDefined(level.var_107A7)) {
    var_05 = scripts\engine\utility::getstructarray(param_00, "targetname");
    if(isDefined(param_03) && param_03) {
      func_51D6(var_05);
    }

    var_06 = lib_0B77::func_7BC6(var_05);
    var_04 = scripts\engine\utility::array_combine(var_04, var_06);
  }

  return func_22C6(var_04, param_01, param_02);
}

func_22CB(param_00, param_01, param_02, param_03) {
  var_04 = func_7C84(param_00, "script_noteworthy");
  var_04 = func_22A2(var_04, getEntArray(param_00, "script_noteworthy"));
  if(isDefined(level.var_107A7)) {
    var_05 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
    if(isDefined(param_03) && param_03) {
      func_51D6(var_05);
    }

    var_06 = lib_0B77::func_7BC6(var_05);
    var_04 = scripts\engine\utility::array_combine(var_04, var_06);
  }

  return func_22C6(var_04, param_01, param_02);
}

func_107CD(param_00, param_01) {
  var_02 = getspawner(param_00, "script_noteworthy");
  var_03 = var_02 func_10619(param_01);
  return var_03;
}

func_107EA(param_00, param_01) {
  var_02 = getspawner(param_00, "targetname");
  var_03 = var_02 func_10619(param_01);
  return var_03;
}

func_16C5(param_00, param_01, param_02) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }

  if(!isDefined(level.var_545A)) {
    level.var_545A = [];
  }

  if(level.var_545A.size == 5) {
    var_03 = level.var_545A[0];
    level.var_545A = array_remove_index(level.var_545A, 0);
    func_12DB1();
    var_03 thread func_52A5();
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

      case "yellow":
      case "y":
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

      case "white":
      case "w":
        var_04 = "^7";
        break;

      case "bl":
      case "black":
        var_04 = "^8";
        break;
    }
  }

  var_05 = scripts\sp\hud_util::createfontstring("default", 1);
  var_06 = level.var_545A.size;
  level.var_545A[var_06] = var_05;
  var_05.foreground = 1;
  var_05.sort = 20;
  var_05.x = 40;
  var_05.y = 260 + var_06 * 12;
  var_05.label = "" + var_04 + param_00 + ": ^7" + param_01;
  var_05.alpha = 0;
  var_05 fadeovertime(0.2);
  var_05.alpha = 1;
  var_05 endon("death");
  wait(8);
  level.var_545A = scripts\engine\utility::array_remove(level.var_545A, var_05);
  func_12DB1();
  var_05 thread func_52A5();
}

func_52A5() {
  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12;
  self.alpha = 0;
  wait(0.2);
  self destroy();
}

func_12DB1() {
  level.var_545A = scripts\engine\utility::array_removeundefined(level.var_545A);
  foreach(var_02, var_01 in level.var_545A) {
    var_01 moveovertime(0.2);
    var_01.y = 260 + var_02 * 12;
  }
}

func_F3E6(param_00) {
  self.objective_state = param_00;
}

func_7B91() {
  var_00 = self.origin;
  var_01 = anglestoup(self getplayerangles());
  var_02 = self getplayerviewheight();
  var_03 = var_00 + (0, 0, var_02);
  var_04 = var_00 + var_01 * var_02;
  var_05 = var_03 - var_04;
  var_06 = var_00 + var_05;
  return var_06;
}

func_F2D8(param_00) {
  self.var_2894 = param_00;
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }

  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  } else {}

  if(!isDefined(level.var_13E0F)) {
    level.var_13E0F = getdvar("xenonGame") == "true";
  } else {}

  if(!isDefined(level.var_DADB)) {
    level.var_DADB = getdvar("ps3Game") == "true";
  } else {}

  if(!isDefined(level.var_13E0E)) {
    level.var_13E0E = getdvar("xb3Game") == "true";
  } else {}

  if(!isDefined(level.var_DADC)) {
    level.var_DADC = getdvar("ps4Game") == "true";
  }
}

func_9BEE() {
  if(level.var_13E0E || level.var_DADC || !level.console) {
    return 1;
  }

  return 0;
}

func_266F(param_00) {
  return scripts\sp\autosave::func_1190(param_00);
}

func_2670() {
  return scripts\sp\autosave::func_1190(1);
}

func_F3C7(param_00) {
  self.var_4E2A = func_7ECF(param_00);
}

func_F333(param_00) {
  self.var_4E2A = func_7DC1(param_00);
}

func_4141() {
  self.var_4E2A = undefined;
}

putgunaway() {
  scripts\anim\shared::placeweaponon(self.var_394, "none");
  self.var_394 = "none";
}

anim_stopanimscripted() {
  self givescorefortrophyblocks();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

func_5564() {
  self.a.var_5605 = 1;
  self.allowpain = 0;
}

func_6224() {
  self.a.var_5605 = 0;
  self.allowpain = 1;
}

func_2011(param_00) {
  self.var_1C78 = param_00;
}

func_200C() {
  self.var_1C78 = undefined;
}

func_200D(param_00, param_01) {
  if(param_01) {
    if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0 || param_00 == "all") {
      level.var_2006.var_5602 = [];
      level.var_2006.var_5602[0] = param_00;
      return;
    }

    if(level.var_2006.var_5602[0] != "all") {
      level.var_2006.var_5602 = scripts\engine\utility::array_combine_unique(level.var_2006.var_5602, [param_00]);
      return;
    }

    return;
  }

  if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0) {
    return;
  }

  if(param_00 == "all") {
    level.var_2006.var_5602 = undefined;
    return;
  }

  if(level.var_2006.var_5602[0] == "all") {
    level.var_2006.var_5602 = [];
    if(param_00 == "allies") {
      level.var_2006.var_5602[0] = "axis";
      return;
    }

    level.var_2006.var_5602[0] = "allies";
    return;
  }

  level.var_2006.var_5602 = scripts\engine\utility::array_remove_array(level.var_2006.var_5602, [param_00]);
}

func_A62F() {
  self getrankinfofull(0);
  self _meth_81D0();
  return 1;
}

func_22D8(param_00, param_01, param_02) {
  var_03 = getarraykeys(param_00);
  var_04 = [];
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
  }

  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    var_04[var_06] = spawnStruct();
    var_04[var_06].var_1187 = 1;
    var_04[var_06] thread scripts\sp\utility_code::func_22D9(param_00[var_06], param_01, param_02);
  }

  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    if(isDefined(param_00[var_06]) && var_04[var_06].var_1187) {
      var_04[var_06] waittill("_array_wait");
    }
  }
}

func_54C6() {
  self _meth_81D0((0, 0, 0));
}

func_7FBC(param_00) {
  return level.var_EC8C[param_00];
}

func_9D27() {
  return self getweaponrankinfominxp() > 0.5;
}

func_5575() {
  self.var_E198 = undefined;
  self notify("_disable_reinforcement");
}

func_137DF(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    param_05 = level.player;
  }

  var_06 = spawnStruct();
  if(isDefined(param_03)) {
    var_06 thread func_C12D("timeout", param_03);
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
      var_0A = self.origin;
    }

    if(param_05 func_D1DF(var_0A, param_00, param_02, param_04)) {
      var_08--;
      if(var_08 <= 0) {
        return 1;
      }
    } else {
      var_08 = var_07;
    }

    wait(0.05);
  }
}

func_137E1(param_00, param_01, param_02, param_03) {
  func_137DF(param_01, param_00, param_02, undefined, param_03);
}

func_D1DF(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 0.8;
  }

  var_04 = func_7B92();
  var_05 = var_04 getEye();
  var_06 = vectortoangles(param_00 - var_05);
  var_07 = anglesToForward(var_06);
  var_08 = var_04 getplayerangles();
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

func_6001(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < level.players.size; var_04++) {
    if(level.players[var_04] func_D1DF(param_00, param_01, param_02, param_03)) {
      return 1;
    }
  }

  return 0;
}

func_D63A(param_00) {
  var_01 = func_7B92();
  var_02 = vectortoangles(param_00 - var_01 getEye());
  var_03 = anglesToForward(var_02);
  var_04 = var_01 getplayerangles();
  var_05 = anglesToForward(var_04);
  var_06 = vectorcross(var_03, var_05);
  if(var_06[2] < 0) {
    return "left";
  }

  return "right";
}

func_CFAC(param_00, param_01) {
  var_02 = gettime();
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(isDefined(param_00.var_D412) && param_00.var_D412 + param_01 >= var_02) {
    return param_00.var_D411;
  }

  param_00.var_D412 = var_02;
  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, param_00.origin, 0.766)) {
    param_00.var_D411 = 0;
    return 0;
  }

  var_03 = level.player getEye();
  var_04 = param_00.origin;
  if(sighttracepassed(var_03, var_04, 1, level.player, param_00)) {
    param_00.var_D411 = 1;
    return 1;
  }

  var_05 = param_00 getEye();
  if(sighttracepassed(var_03, var_05, 1, level.player, param_00)) {
    param_00.var_D411 = 1;
    return 1;
  }

  var_06 = var_05 + var_04 * 0.5;
  if(sighttracepassed(var_03, var_06, 1, level.player, param_00)) {
    param_00.var_D411 = 1;
    return 1;
  }

  param_00.var_D411 = 0;
  return 0;
}

func_D40E(param_00, param_01) {
  var_02 = param_00 * param_00;
  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    if(distancesquared(param_01, level.players[var_03].origin) < var_02) {
      return 1;
    }
  }

  return 0;
}

func_1938(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = 0.75;
  while(param_00.size > 0) {
    wait(1);
    for(var_03 = 0; var_03 < param_00.size; var_03++) {
      if(!isDefined(param_00[var_03]) || !isalive(param_00[var_03])) {
        param_00 = scripts\engine\utility::array_remove(param_00, param_00[var_03]);
        continue;
      }

      if(func_D40E(param_01, param_00[var_03].origin)) {
        continue;
      }

      if(func_6001(param_00[var_03].origin + (0, 0, 48), var_02, 1)) {
        continue;
      }

      if(isDefined(param_00[var_03].var_B14F)) {
        param_00[var_03] func_1101B();
      }

      param_00[var_03] delete();
      param_00 = scripts\engine\utility::array_remove(param_00, param_00[var_03]);
    }
  }
}

func_178D(param_00, param_01, param_02, param_03) {
  func_97A2();
  var_04 = spawnStruct();
  var_04.var_376B = self;
  var_04.func = param_00;
  var_04.var_C8FD = [];
  if(isDefined(param_01)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_03;
  }

  if(!isDefined(level.var_13711.var_13590)) {
    level.var_13711.var_13590 = [var_04];
    return;
  }

  level.var_13711.var_13590[level.var_13711.var_13590.size] = var_04;
}

func_168D(param_00, param_01, param_02, param_03) {
  func_97A2();
  var_04 = spawnStruct();
  var_04.var_376B = self;
  var_04.func = param_00;
  var_04.var_C8FD = [];
  if(isDefined(param_01)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_C8FD[var_04.var_C8FD.size] = param_03;
  }

  level.var_13711.var_1523[level.var_13711.var_1523.size] = var_04;
}

func_16DB(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_06.var_376B = self;
  var_06.func = param_00;
  var_06.var_C8FD = [];
  if(isDefined(param_01)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_05;
  }

  level.var_13711.var_E7F9[level.var_13711.var_E7F9.size] = var_06;
}

func_16AA(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_06.var_376B = self;
  var_06.func = param_00;
  var_06.var_C8FD = [];
  if(isDefined(param_01)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_05;
  }

  level.var_13711.var_E7E0[level.var_13711.var_E7E0.size] = var_06;
}

func_171F(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_06.func = param_00;
  var_06.var_C8FD = [];
  if(isDefined(param_01)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_03;
  }

  if(isDefined(param_04)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_04;
  }

  if(isDefined(param_05)) {
    var_06.var_C8FD[var_06.var_C8FD.size] = param_05;
  }

  level.var_13711.var_E80A[level.var_13711.var_E80A.size] = var_06;
}

func_16CD(param_00) {
  func_97A2();
  var_01 = spawnStruct();
  var_01.var_376B = self;
  var_01.var_6317 = param_00;
  level.var_13711.var_57D7[level.var_13711.var_57D7.size] = var_01;
}

func_57D6() {
  func_97A2();
  func_57D5(level.var_13711.var_13590.size - 1);
}

func_57D5(param_00) {
  func_97A2();
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = spawnStruct();
  var_02 = level.var_13711.var_13590;
  var_03 = level.var_13711.var_57D7;
  var_04 = level.var_13711.var_E7F9;
  var_05 = level.var_13711.var_E7E0;
  var_06 = level.var_13711.var_E80A;
  var_07 = level.var_13711.var_1523;
  level.var_13711.var_13590 = [];
  level.var_13711.var_E7F9 = [];
  level.var_13711.var_57D7 = [];
  level.var_13711.var_1523 = [];
  level.var_13711.var_E7E0 = [];
  level.var_13711.var_E80A = [];
  var_01.var_C1 = var_02.size;
  var_01 scripts\engine\utility::array_levelthread(var_02, ::scripts\sp\utility_code::func_13774, var_03);
  var_01 thread scripts\sp\utility_code::func_5767(var_07);
  var_01 endon("any_funcs_aborted");
  for(;;) {
    if(var_01.var_C1 <= param_00) {
      break;
    }

    var_01 waittill("func_ended");
  }

  var_01 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var_04, ::scripts\sp\utility_code::func_68CE, []);
  scripts\engine\utility::array_levelthread(var_05, ::scripts\sp\utility_code::func_68CC);
  scripts\engine\utility::array_levelthread(var_06, ::scripts\sp\utility_code::func_68CD);
}

func_578A() {
  var_00 = spawnStruct();
  var_01 = level.var_13711.var_E7F9;
  level.var_13711.var_E7F9 = [];
  foreach(var_03 in var_01) {
    level scripts\sp\utility_code::func_68CE(var_03, []);
  }

  var_00 notify("all_funcs_ended");
}

func_9BB5() {
  if(isDefined(level.var_72AD) && level.var_72AD == 1) {
    return 0;
  }

  if(isDefined(level.var_501A) && level.var_501A == level.var_10CDA) {
    return 1;
  }

  if(isDefined(level.var_5019) && level.var_5019 == level.var_10CDA) {
    return 1;
  }

  if(isDefined(level.var_5018)) {
    return level.var_10CDA == "default";
  }

  if(scripts\sp\starts::func_ABDA()) {
    return level.var_10CDA == level.var_10C58[0]["name"];
  }

  return level.var_10CDA == "default";
}

func_13BBF(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  if(isDefined(param_01)) {
    var_02 = 1;
  }

  if(isDefined(param_00)) {
    scripts\engine\utility::flag_assert(param_00);
    level endon(param_00);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_03 = self.origin + (0, 0, 150);
    var_04 = self.origin - (0, 0, 150);
    var_05 = bulletTrace(var_03, var_04, 0, undefined);
    if(var_05["surfacetype"] != "water") {
      continue;
    }

    var_06 = "water_movement";
    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_06 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      var_06 = "water_" + self.a.movement;
    }

    var_07 = scripts\engine\utility::getfx(var_06);
    var_03 = var_05["position"];
    var_08 = (0, self.angles[1], 0);
    var_09 = anglesToForward(var_08);
    var_0A = anglestoup(var_08);
    playFX(var_07, var_03, var_0A, var_09);
    if(var_06 != "water_stop" && var_02) {
      thread scripts\engine\utility::play_sound_in_space(param_01, var_03);
    }
  }
}

func_B317(param_00, param_01) {
  param_00 endon("death");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  for(;;) {
    self.origin = param_00.origin + param_01;
    self.angles = param_00.angles;
    wait(0.05);
  }
}

func_BF95(param_00) {
  scripts\sp\endmission::func_1355(param_00);
}

func_BF97(param_00, param_01, param_02) {
  if(!scripts\engine\utility::flag_exist("nextmission_preload_complete")) {
    scripts\engine\utility::flag_init("nextmission_preload_complete");
  }

  scripts\engine\utility::flag_clear("nextmission_preload_complete");
  scripts\sp\endmission::func_1356(param_00, param_01, param_02);
  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

func_BF98() {
  scripts\sp\endmission::func_1357();
}

func_CE6D(param_00) {}

func_7F6E(param_00) {
  return scripts\sp\endmission::func_12B0(param_00);
}

func_7E2C(param_00) {
  return scripts\sp\endmission::func_12AF(param_00);
}

func_7F70(param_00) {
  return scripts\sp\endmission::func_12B1(param_00);
}

func_13705(param_00) {
  if(!isDefined(param_00)) {
    param_00 = level.script;
  }

  scripts\sp\endmission::func_1455(param_00);
}

func_13C3C(param_00) {
  scripts\sp\endmission::func_1463(param_00);
}

func_13C60() {
  scripts\sp\endmission::func_1464();
}

func_B263(param_00, param_01, param_02, param_03, param_04) {
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

func_6AC4() {
  level.var_6AD2 = 1;
}

func_C08C() {
  level.var_6AD2 = 0;
}

_meth_806D() {
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

func_1454(param_00) {
  wait(param_00);
}

func_AB9A(param_00, param_01, param_02) {
  var_03 = getdvarfloat(param_00);
  level notify(param_00 + "_lerp_savedDvar");
  level endon(param_00 + "_lerp_savedDvar");
  var_04 = param_01 - var_03;
  var_05 = 0.05;
  var_06 = int(param_02 / var_05);
  if(var_06 > 0) {
    var_07 = var_04 / var_06;
    while(var_06) {
      var_03 = var_03 + var_07;
      setsaveddvar(param_00, var_03);
      wait(var_05);
      var_06--;
    }
  }

  setsaveddvar(param_00, param_01);
}

func_AB89(param_00, param_01, param_02, param_03) {
  var_04 = getomnvar(param_00);
  level notify(param_00 + "_lerp_savedDvar");
  level endon(param_00 + "_lerp_savedDvar");
  var_05 = param_01 - var_04;
  var_06 = 0.05;
  var_07 = int(param_02 / var_06);
  var_08 = var_05 / var_07;
  while(var_07) {
    var_04 = var_04 + var_08;
    if(isDefined(param_03)) {
      var_09 = func_E753(var_04, param_03);
      setomnvar(param_00, var_09);
    } else {
      setomnvar(param_00, var_04);
    }

    wait(var_06);
    var_07--;
  }

  if(isDefined(param_03)) {
    var_09 = func_E753(param_01, param_03);
    setomnvar(param_00, var_09);
    return;
  }

  setomnvar(param_00, param_01);
}

func_AB8B(param_00, param_01, param_02) {
  var_03 = getomnvar(param_00);
  level notify(param_00 + "_lerp_savedDvar");
  level endon(param_00 + "_lerp_savedDvar");
  var_04 = param_01 - var_03;
  var_05 = 0.05;
  var_06 = int(param_02 / var_05);
  var_07 = var_04 / var_06;
  while(var_06) {
    var_03 = var_03 + var_07;
    setomnvar(param_00, int(var_03));
    wait(var_05);
    var_06--;
  }

  setomnvar(param_00, int(param_01));
}

func_AB9B(param_00, param_01, param_02, param_03) {
  if(func_9BEE()) {
    func_AB9A(param_00, param_02, param_03);
    return;
  }

  func_AB9A(param_00, param_01, param_03);
}

settimer(param_00, param_01) {
  if(func_9BB7()) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!param_01 && func_9C32()) {
    return;
  }

  level.player giveachievement(param_00);
}

func_D0A1(param_00) {
  if(func_9BB7()) {
    return;
  }

  if(func_9C32()) {
    return;
  }

  self giveachievement(param_00);
}

func_10327(param_00) {
  level.var_1031B.var_1098F = param_00;
}

func_10326(param_00) {
  level.var_1031B.var_1098C = param_00;
}

func_10324(param_00) {
  level.var_1031B.var_ABA1 = param_00;
}

func_10325(param_00) {
  level.var_1031B.var_ABA2 = param_00;
}

func_10321() {
  if(isDefined(level.var_C014) && level.var_C014) {
    return;
  }

  scripts\sp\audio::func_F5A0();
  setslowmotion(level.var_1031B.var_1098C, level.var_1031B.var_1098F, level.var_1031B.var_ABA1);
}

func_10322() {
  if(isDefined(level.var_C014) && level.var_C014) {
    return;
  }

  setslowmotion(level.var_1031B.var_1098F, level.var_1031B.var_1098C, level.var_1031B.var_ABA2);
  scripts\sp\audio::func_F59F();
}

func_16CC(param_00, param_01, param_02, param_03) {
  level.earthquake[param_00]["magnitude"] = param_01;
  level.earthquake[param_00]["duration"] = param_02;
  level.earthquake[param_00]["radius"] = param_03;
}

func_BDF2(param_00, param_01, param_02) {
  level.var_1188.var_A90A = param_00;
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  musicstop(0);
  musicplay(param_00, 0, 1, 1, param_02);
}

func_BDDF(param_00, param_01, param_02, param_03, param_04) {
  thread scripts\sp\utility_code::func_BDE1(param_00, param_01, param_02, param_03, param_04);
}

func_BDE3(param_00, param_01, param_02, param_03, param_04) {
  thread scripts\sp\utility_code::func_BDE1(param_00, param_01, param_02, param_03, param_04, 1);
}

func_BDE5(param_00, param_01, param_02, param_03) {
  if(isDefined(param_01) && param_01 > 0) {
    thread scripts\sp\utility_code::func_BDE6(param_00, param_01, param_02, param_03);
    return;
  }

  func_BDEC();
  func_BDF2(param_00, param_02, param_03);
}

func_BDD5(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(isDefined(level.var_1188.var_A90A)) {
    musicstop(param_01, level.var_1188.var_A90A, param_03);
  } else {}

  level.var_1188.var_A90A = param_00;
  musicplay(param_00, param_01, param_02, 0, param_03);
  level endon("stop_music");
  wait(param_01);
  level notify("done_crossfading");
}

func_BDEC(param_00) {
  if(!isDefined(param_00) || param_00 <= 0) {
    musicstop();
  } else {
    musicstop(param_00);
  }

  level notify("stop_music");
}

func_D121() {
  var_00 = getEntArray("grenade", "classname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(var_02.model == "weapon_claymore") {
      continue;
    }

    if(isDefined(var_02.var_C182)) {
      continue;
    }

    for(var_03 = 0; var_03 < level.players.size; var_03++) {
      var_04 = level.players[var_03];
      if(distancesquared(var_02.origin, var_04.origin) < 75625) {
        return 1;
      }
    }
  }

  return 0;
}

func_D022() {
  return getdvarint("player_died_recently", "0") > 0;
}

func_7E72() {
  if(level.var_7683 < 1) {
    return "easy";
  }

  if(level.var_7683 < 2) {
    return "medium";
  }

  if(level.var_7683 < 3) {
    return "hard";
  }

  return "fu";
}

func_7853(param_00) {
  var_01 = (0, 0, 0);
  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03.origin;
  }

  return var_01 * 1 / param_00.size;
}

func_7748() {
  self.var_4CF5 = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    foreach(var_0B in self.var_4CF5) {
      thread[[var_0B]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    }
  }
}

func_16B7(param_00) {
  self.var_4CF5[self.var_4CF5.size] = param_00;
}

func_DFE6(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_4CF5) {
    if(var_03 == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  self.var_4CF5 = var_01;
}

func_D4BF(param_00) {
  self playlocalsound(param_00);
}

func_6278(param_00) {
  if(level.players.size < 1) {
    return;
  }

  foreach(var_02 in level.players) {
    if(param_00 == 1) {
      var_02 enableweapons();
      continue;
    }

    var_02 getradiuspathsighttestnodes();
  }
}

func_11633(param_00) {
  level.player setorigin(param_00.origin);
  if(isDefined(param_00.angles)) {
    level.player setplayerangles(param_00.angles);
  }
}

func_11634(param_00) {
  level.player setplayerangles((0, 0, 0));
  if(isDefined(param_00.angles)) {
    level.player setworldupreferenceangles(param_00.angles);
  }

  level.player setorigin(param_00.origin, 1, 1);
  level.player setvelocity((0, 0, 0));
}

func_12687() {
  var_00 = [];
  if(isDefined(self.var_6633)) {
    var_00 = self.var_6633;
  }

  if(isDefined(self.issplitscreen)) {
    var_00[var_00.size] = self.issplitscreen;
  }

  scripts\engine\utility::array_levelthread(var_00, ::scripts\sp\utility_code::func_12688);
}

func_C621(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level.player endon("stop_opening_fov");
  wait(param_00);
  level.player playerlinktodelta(param_01, param_02, 1, param_03, param_04, param_05, param_06, 1);
}

func_77E3(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  var_03 = getaispeciesarray(param_00, param_01);
  var_04 = [];
  foreach(var_06 in var_03) {
    if(var_06 istouching(self)) {
      var_04[var_04.size] = var_06;
    }
  }

  return var_04;
}

func_7964(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  var_01 = [];
  if(param_00 == "all") {
    var_01 = func_22A2(level.var_5CC3["allies"].var_2274, level.var_5CC3["axis"].var_2274);
    var_01 = func_22A2(var_01, level.var_5CC3["neutral"].var_2274);
  } else {
    var_01 = level.var_5CC3[param_00].var_2274;
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

func_7965(param_00) {
  var_01 = func_22A2(level.var_5CC3["allies"].var_2274, level.var_5CC3["axis"].var_2274);
  var_01 = func_22A2(var_01, level.var_5CC3["neutral"].var_2274);
  var_02 = [];
  foreach(var_04 in var_01) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(isDefined(var_04.var_336) && var_04.var_336 == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_F311(param_00) {
  self.var_C1 = param_00;
}

func_7226(param_00, param_01, param_02, param_03) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_04 = undefined;
  if(!isDefined(param_00.classname)) {
    if(!isDefined(param_00.type)) {
      var_04 = "struct";
    } else {
      var_04 = "node";
    }
  } else {
    var_04 = "entity";
  }

  if(!isDefined(param_01)) {
    param_01 = 300;
  }

  var_05 = self.var_EDB0;
  self.var_EDB0 = 1;
  lib_0B77::worldpointinreticle_circle(param_00, var_04, param_02, param_01, param_03);
  self.var_EDB0 = var_05;
  if(!isDefined(self.var_EDB0) || !self.var_EDB0) {
    self.objective_playermask_showto = level.var_4FF6;
  }
}

func_61F1(param_00, param_01, param_02, param_03, param_04, param_05) {
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

  self.var_5953 = param_05;
  thread scripts\sp\utility_code::func_5F8E(param_00, param_01, param_02, param_03, param_04);
}

func_5523() {
  self notify("stop_dynamic_run_speed");
}

func_D282() {
  self endon("death");
  self endon("stop_player_seek");
  var_00 = 1200;
  if(func_8BAB()) {
    var_00 = 250;
  }

  var_01 = distance(self.origin, level.player.origin);
  for(;;) {
    wait(2);
    self.objective_playermask_showto = var_01;
    var_02 = level.player;
    self setgoalentity(var_02);
    var_01 = var_01 - 175;
    if(var_01 < var_00) {
      var_01 = var_00;
      return;
    }
  }
}

func_D281() {
  self notify("stop_player_seek");
}

func_1376C(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  var_03 = gettime() + param_02 * 1000;
  while(isDefined(param_00)) {
    if(distance(param_00.origin, self.origin) <= param_01) {
      break;
    }

    if(gettime() > var_03) {
      break;
    }

    wait(0.1);
  }
}

func_1376B(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  while(isDefined(param_00)) {
    if(distance(param_00.origin, self.origin) <= param_01) {
      break;
    }

    wait(0.1);
  }
}

func_1376D(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  while(isDefined(param_00)) {
    if(distance(param_00.origin, self.origin) > param_01) {
      break;
    }

    wait(0.1);
  }
}

func_8BAB() {
  self endon("death");
  if(!isDefined(self.var_394)) {
    return 0;
  }

  if(scripts\engine\utility::weaponclass(self.var_394) == "spread") {
    return 1;
  }

  return 0;
}

isprimaryweapon(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(weaponinventorytype(param_00) != "primary") {
    return 0;
  }

  switch (scripts\engine\utility::weaponclass(param_00)) {
    case "sniper":
    case "rocketlauncher":
    case "mg":
    case "smg":
    case "rifle":
    case "spread":
    case "pistol":
      return 1;

    default:
      return 0;
  }
}

func_D0C8() {
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

func_13817(param_00, param_01) {
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = self.objective_playermask_showto;
  }

  for(;;) {
    self waittill("goal");
    if(distance(self.origin, param_00) < param_01 + 10) {
      break;
    }
  }
}

func_D2CD(param_00, param_01) {
  var_02 = int(getdvar("g_speed"));
  if(!isDefined(level.player.var_764D)) {
    level.player.var_764D = var_02;
  }

  var_03 = int(level.player.var_764D * param_00 * 0.01);
  level.player func_D2D1(var_03, param_01);
}

func_2B78(param_00, param_01) {
  var_02 = self;
  if(!isplayer(var_02)) {
    var_02 = level.player;
  }

  if(!isDefined(var_02.var_BCF5)) {
    var_02.var_BCF5 = 1;
  }

  var_03 = param_00 * 0.01;
  var_02 func_2B76(var_03, param_01);
}

func_D2D1(param_00, param_01) {
  var_02 = int(getdvar("g_speed"));
  if(!isDefined(level.player.var_764D)) {
    level.player.var_764D = var_02;
  }

  var_03 = ::scripts\sp\utility_code::func_764E;
  var_04 = ::scripts\sp\utility_code::func_764F;
  level.player thread func_D2CE(param_00, param_01, var_03, var_04, "player_speed_set");
}

func_CF97(param_00, param_01) {
  var_02 = ::scripts\sp\utility_code::func_7647;
  var_03 = ::scripts\sp\utility_code::func_7648;
  level.player thread func_D2CE(param_00, param_01, var_02, var_03, "player_bob_scale_set");
}

func_2B76(param_00, param_01) {
  var_02 = self;
  if(!isplayer(var_02)) {
    var_02 = level.player;
  }

  if(!isDefined(var_02.var_BCF5)) {
    var_02.var_BCF5 = 1;
  }

  var_03 = ::scripts\sp\utility_code::func_BCF0;
  var_04 = ::scripts\sp\utility_code::func_BCF3;
  var_02 thread func_D2CE(param_00, param_01, var_03, var_04, "blend_movespeedscale");
}

func_D2CE(param_00, param_01, param_02, param_03, param_04) {
  self notify(param_04);
  self endon(param_04);
  var_05 = [
    [param_02]
  ]();
  var_06 = param_00;
  if(isDefined(param_01)) {
    var_07 = var_06 - var_05;
    var_08 = 0.05;
    var_09 = param_01 / var_08;
    var_0A = var_07 / var_09;
    while(abs(var_06 - var_05) > abs(var_0A * 1.1)) {
      var_05 = var_05 + var_0A;
      [
        [param_03]
      ](var_05);
      wait(var_08);
    }
  }

  [
    [param_03]
  ](var_06);
}

func_D2CA(param_00) {
  if(!isDefined(level.player.var_764D)) {
    return;
  }

  level.player func_D2D1(level.player.var_764D, param_00);
  waittillframeend;
  level.player.var_764D = undefined;
}

func_2B77(param_00) {
  var_01 = self;
  if(!isplayer(var_01)) {
    var_01 = level.player;
  }

  if(!isDefined(var_01.var_BCF5)) {
    return;
  }

  var_01 func_2B76(1, param_00);
  var_01.var_BCF5 = undefined;
}

func_11624(param_00) {
  if(isplayer(self)) {
    self setorigin(param_00.origin);
    self setplayerangles(param_00.angles);
    return;
  }

  if(isai(self)) {
    self _meth_80F1(param_00.origin, param_00.angles);
    return;
  }

  self.origin = param_00.origin;
  self.angles = param_00.angles;
}

func_11645(param_00, param_01) {
  var_02 = param_00 gettagorigin(param_01);
  var_03 = param_00 gettagangles(param_01);
  self dontinterpolate();
  if(isplayer(self)) {
    self setorigin(var_02);
    self setplayerangles(var_03);
    return;
  }

  if(isai(self)) {
    self _meth_80F1(var_02, var_03);
    return;
  }

  self.origin = var_02;
  self.angles = var_03;
}

func_1160F(param_00) {
  self _meth_80F1(param_00.origin, param_00.angles);
  self give_mp_super_weapon(self.origin);
  self give_more_perk(param_00);
}

func_BC00(param_00) {
  foreach(var_02 in level.createfxent) {
    var_02.v["origin"] = var_02.v["origin"] + param_00;
  }
}

func_9F59() {
  return isDefined(self.slidemodel);
}

func_2A75(param_00, param_01, param_02) {
  self endon("stop_sliding");
  self endon("death");
  var_03 = self;
  if(var_03 func_65DF("is_sliding")) {
    var_03 func_65DD("is_sliding");
  } else {
    var_03 func_65E0("is_sliding");
  }

  var_04 = isDefined(level.var_4C5D);
  var_05 = level.player scripts\engine\utility::spawn_tag_origin();
  var_03.slidemodel = var_05;
  var_06 = level.player scripts\engine\utility::spawn_tag_origin();
  var_03.var_7601 = var_06;
  var_07 = scripts\common\trace::create_contents(0, 1, 0, 0, 0, 0);
  var_08 = scripts\common\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_03, var_07);
  var_09 = 0;
  var_0A = (0, 0, 0);
  var_0B = var_08["normal"];
  for(;;) {
    if(!var_03 isjumping()) {
      var_08 = scripts\common\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_03, var_07);
      var_0B = var_08["normal"];
      if(isDefined(var_0B)) {
        var_0C = vectordot(var_0B, (0, 0, 1));
        if(var_0C <= 0.95) {
          var_09 = acos(var_0C);
          var_0A = var_08["position"];
          break;
        }
      }
    }

    wait(0.05);
  }

  var_0B = vectornormalize(scripts\engine\utility::flatten_vector(var_0B, (0, 0, 1)));
  var_0D = vectornormalize(vectorcross(var_0B, (0, 1, 0)));
  var_0E = vectornormalize(vectorcross(var_0B, var_0D));
  var_05.angles = var_03.angles;
  var_05.origin = var_03.origin;
  var_0F = vectortoangles(var_0B) + var_0B * var_09;
  var_05.var_77BA = spawn("script_model", var_05.origin + anglesToForward(var_0F) * 2000);
  var_05.var_77BA.angles = var_0F;
  var_03.var_7601.angles = var_0F;
  if(!isDefined(param_00)) {
    param_00 = var_03 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(param_01)) {
    param_01 = 10;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.035;
  }

  var_05 moveslide((0, 0, 15), 15, param_00);
  var_03 thread play_sound_on_entity("foot_slide_plr_start");
  var_03 _meth_84FE();
  var_03 forceplaygestureviewmodel("ges_slide", var_05.var_77BA, 0.2);
  if(isDefined(level._effect["vfx_slide_dirt"])) {
    var_10 = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_03.var_7601, "tag_origin");
    var_03.var_7601 show();
  }

  var_03 func_65E1("is_sliding");
  if(var_04) {
    var_03 playerlinktoblend(var_05, undefined, 1);
    wait(1);
    var_03 playerlinktodelta(var_05, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else {
    var_03 playerlinktodelta(var_05, "tag_origin", 0, 180, 180, 180, 180);
  }

  setsaveddvar("depthSortViewmodel", 1);
  var_03 scripts\engine\utility::allow_fire(0);
  var_03 scripts\engine\utility::allow_prone(0);
  var_03 scripts\engine\utility::allow_stances(0);
  var_03 scripts\engine\utility::allow_reload(0);
  var_03 thread scripts\sp\utility_code::func_5AAD(var_05, param_01, param_02);
  var_03 thread play_loop_sound_on_tag("foot_slide_plr_loop");
}

func_6389() {
  var_00 = self;
  if(level.player isgestureplaying()) {
    var_00 stopgestureviewmodel("ges_slide");
    var_00 notify("stop soundfoot_slide_plr_loop");
    var_00 thread play_sound_on_entity("foot_slide_plr_end");
  }

  var_00 scripts\engine\utility::delaycall(0.2, ::_meth_84FD);
  if(level.player islinked()) {
    var_00 unlink();
    var_00 setvelocity(var_00.slidemodel.slidevelocity);
  }

  if(isDefined(var_00.var_7601)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      var_01 = scripts\engine\utility::getfx("vfx_slide_dirt");
      if(isDefined(var_01)) {
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_00.var_7601, "tag_origin");
      }
    }

    var_00.var_7601 delete();
  }

  if(var_00 func_65DF("is_sliding") && var_00 func_65DB("is_sliding")) {
    var_00 func_65DD("is_sliding");
  }

  var_00.slidemodel delete();
  var_00 scripts\engine\utility::allow_fire(1);
  var_00 scripts\engine\utility::allow_prone(1);
  var_00 scripts\engine\utility::allow_stances(1);
  var_00 scripts\engine\utility::allow_reload(1);
  setsaveddvar("depthSortViewmodel", 0);
  var_00 notify("stop_sliding");
}

func_2A76(param_00, param_01, param_02) {
  var_03 = self;
  if(var_03 func_65DF("is_sliding")) {
    var_03 func_65DD("is_sliding");
  } else {
    var_03 func_65E0("is_sliding");
  }

  var_03 thread play_sound_on_entity("foot_slide_plr_start");
  var_03 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  var_04 = isDefined(level.var_4C5D);
  if(!isDefined(param_00)) {
    param_00 = var_03 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(param_01)) {
    param_01 = 10;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.035;
  }

  var_05 = spawn("script_origin", var_03.origin);
  var_05.angles = var_03.angles;
  var_03.slidemodel = var_05;
  var_05 moveslide((0, 0, 15), 15, param_00);
  var_03 func_65E1("is_sliding");
  if(var_04) {
    var_03 playerlinktoblend(var_05, undefined, 1);
  } else {
    var_03 playerlinkto(var_05);
  }

  var_03 getradiuspathsighttestnodes();
  var_03 allowprone(0);
  var_03 allowcrouch(1);
  var_03 allowstand(0);
  var_03 thread scripts\sp\utility_code::func_5AAD(var_05, param_01, param_02);
}

func_638A() {
  var_00 = self;
  var_00 notify("stop soundfoot_slide_plr_loop");
  var_00 thread play_sound_on_entity("foot_slide_plr_end");
  var_00 unlink();
  var_00 setvelocity(var_00.slidemodel.slidevelocity);
  var_00.slidemodel delete();
  var_00 enableweapons();
  var_00 allowprone(1);
  var_00 allowcrouch(1);
  var_00 allowstand(1);
  var_00 notify("stop_sliding");
  if(var_00 func_65DF("is_sliding") && var_00 func_65DB("is_sliding")) {
    var_00 func_65DD("is_sliding");
  }
}

func_10808() {
  return scripts\sp\vehicle::func_13237(self);
}

func_7E9C(param_00) {
  var_01 = scripts\sp\trigger::func_7AA4();
  var_02 = [];
  foreach(var_06, var_04 in var_01) {
    if(!issubstr(var_06, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_06, "classname");
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  var_07 = scripts\sp\trigger::func_7AA5();
  foreach(var_09, var_04 in var_07) {
    if(!issubstr(var_09, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_09, "targetname");
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  var_0A = undefined;
  foreach(var_0C in var_02) {
    if(var_0C.var_ED9A == param_00) {
      return var_0C;
    }
  }
}

func_7E99(param_00) {
  var_01 = scripts\sp\trigger::func_7AA4();
  var_02 = [];
  foreach(var_06, var_04 in var_01) {
    if(!issubstr(var_06, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_06, "classname");
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  var_07 = scripts\sp\trigger::func_7AA5();
  foreach(var_09, var_04 in var_07) {
    if(!issubstr(var_09, "flag")) {
      continue;
    }

    var_05 = getEntArray(var_09, "targetname");
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  var_0A = [];
  foreach(var_0C in var_02) {
    if(var_0C.var_ED9A == param_00) {
      var_0A[var_0A.size] = var_0C;
    }
  }

  return var_0A;
}

func_F623(param_00, param_01) {
  return (param_00[0], param_00[1], param_01);
}

func_1796(param_00, param_01) {
  return (param_00[0], param_00[1], param_00[2] + param_01);
}

func_F622(param_00, param_01) {
  return (param_00[0], param_01, param_00[2]);
}

func_F621(param_00, param_01) {
  return (param_01, param_00[1], param_00[2]);
}

func_58DA() {
  return isDefined(self.a.var_58DA);
}

func_7C23(param_00) {
  var_01 = func_7B92();
  if(!isDefined(param_00)) {
    param_00 = "steady_rumble";
  }

  var_02 = spawn("script_origin", var_01 getEye());
  var_02.var_99E5 = 1;
  var_02 thread scripts\sp\utility_code::func_12E1F(var_01, param_00);
  return var_02;
}

func_F581(param_00) {
  self.var_99E5 = param_00;
}

func_E7C8(param_00) {
  thread func_E7C9(1, param_00);
}

func_E7C7(param_00) {
  thread func_E7C9(0, param_00);
}

func_E7C9(param_00, param_01) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_02 = param_01 * 20;
  var_03 = param_00 - self.var_99E5;
  var_04 = var_03 / var_02;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    self.var_99E5 = self.var_99E5 + var_04;
    wait(0.05);
  }

  self.var_99E5 = param_00;
}

func_7B92() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self)) {
      return level.player;
    }

    return self;
  }

  return level.player;
}

func_7B93() {
  return int(self _meth_8155("gameskill"));
}

func_228B(param_00, param_01, param_02) {
  var_03 = [];
  param_01 = param_02 - param_01;
  foreach(var_05 in param_00) {
    var_03[var_03.size] = var_05;
    if(var_03.size == param_02) {
      var_03 = scripts\engine\utility::array_randomize(var_03);
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

func_1378E(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.5;
  }

  self endon("death");
  while(isDefined(self)) {
    if(distance(param_00, self.origin) <= param_01) {
      break;
    }

    wait(param_02);
  }
}

func_558D() {
  self.target_alloc = 0;
}

func_6242() {
  self.target_alloc = squared(512);
}

func_61FF(param_00) {
  self.heat = 1;
  self.var_C009 = 1;
  self.var_36C = 1;
  if(!isDefined(param_00) || !param_00) {
    self.var_596C = 1;
    self.setthermalbodymaterial = 64;
    self.vehicle_getarray = 2048;
    func_558D();
  }

  self.var_1096A = ::scripts\anim\animset::func_8CD8;
  self.custommoveanimset["run"] = scripts\anim\utility::func_B028("heat_run");
}

func_5537() {
  self.heat = undefined;
  self.var_C009 = undefined;
  self.var_596C = undefined;
  self.var_36C = 0;
  self.setthermalbodymaterial = 512;
  self.var_1096A = undefined;
  self.custommoveanimset = undefined;
}

maymovefrompointtopoint() {
  return vehicle_getarray();
}

func_8FE1(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_03 = 0.5;
  level endon("clearing_hints");
  if(isDefined(level.var_9019)) {
    level.var_9019 scripts\sp\hud_util::destroyelem();
  }

  level.var_9019 = scripts\sp\hud_util::createfontstring("default", 1.5);
  level.var_9019 scripts\sp\hud_util::setpoint("MIDDLE", undefined, 0, 30 + param_02);
  level.var_9019.color = (1, 1, 1);
  level.var_9019 settext(param_00);
  level.var_9019.alpha = 0;
  level.var_9019 fadeovertime(0.5);
  level.var_9019.alpha = 1;
  wait(0.5);
  level.var_9019 endon("death");
  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    return;
  }

  level.var_9019 fadeovertime(var_03);
  level.var_9019.alpha = 0;
  wait(var_03);
  level.var_9019 scripts\sp\hud_util::destroyelem();
}

func_8FF8() {
  var_00 = 1;
  if(isDefined(level.var_9019)) {
    level notify("clearing_hints");
    level.var_9019 fadeovertime(var_00);
    level.var_9019.alpha = 0;
    wait(var_00);
  }
}

func_A5CE(param_00, param_01) {
  if(!isDefined(level.flag[param_00])) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_03 in level.var_4E3F[param_00]) {
    foreach(var_05 in var_03) {
      if(isalive(var_05)) {
        var_05 thread scripts\sp\utility_code::func_A5CF(param_01);
        continue;
      }

      var_05 delete();
    }
  }
}

func_7BB6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = "player_view_controller";
  }

  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  var_04 = param_00 gettagorigin(param_01);
  var_05 = spawnturret("misc_turret", var_04, param_03);
  var_05.angles = param_00 gettagangles(param_01);
  var_05 setModel("tag_turret");
  var_05 linkto(param_00, param_01, param_02, (0, 0, 0));
  var_05 makeunusable();
  var_05 hide();
  var_05 give_player_session_tokens("manual");
  return var_05;
}

func_48AA(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04 childthread scripts\sp\utility_code::func_D961(param_00, self, param_01, param_02, param_03);
  return var_04;
}

func_110A8(param_00) {
  if(!isDefined(self.var_110B7)) {
    self.var_110B7 = [];
  }

  var_01 = [];
  var_02 = self getweaponslistall();
  foreach(var_04 in var_02) {
    var_01[var_04] = [];
    var_01[var_04]["clip_left"] = self getweaponammoclip(var_04, "left");
    var_01[var_04]["clip_right"] = self getweaponammoclip(var_04, "right");
    var_01[var_04]["stock"] = self getweaponammostock(var_04);
  }

  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  self.var_110B7[param_00] = [];
  self.var_110B7[param_00]["current_weapon"] = self getcurrentweapon();
  self.var_110B7[param_00]["inventory"] = var_01;
}

func_E2CF(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(self.var_110B7) || !isDefined(self.var_110B7[param_00])) {
    return;
  }

  self takeallweapons();
  foreach(var_04, var_03 in self.var_110B7[param_00]["inventory"]) {
    if(weaponinventorytype(var_04) != "altmode") {
      self giveweapon(var_04);
    }

    self setweaponammoclip(var_04, var_03["clip_left"], "left");
    self setweaponammoclip(var_04, var_03["clip_right"], "right");
    self setweaponammostock(var_04, var_03["stock"]);
  }

  var_05 = self.var_110B7[param_00]["current_weapon"];
  if(var_05 != "none") {
    if(scripts\engine\utility::istrue(param_01)) {
      self switchtoweaponimmediate(var_05);
      return;
    }

    self switchtoweapon(var_05);
  }
}

func_8E7E() {
  switch (self.var_9F) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;

    case "script_brushmodel":
      self hide();
      self notsolid();
      if(self.spawnimpulsefield & 1) {
        self connectpaths();
      }
      break;

    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      scripts\engine\utility::trigger_off();
      break;

    default:
      break;
  }
}

func_100D7() {
  switch (self.var_9F) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;

    case "script_brushmodel":
      self show();
      self solid();
      if(self.spawnimpulsefield & 1) {
        self disconnectpaths();
      }
      break;

    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      scripts\engine\utility::trigger_on();
      break;

    default:
      break;
  }
}

func_F492(param_00, param_01) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  if(isDefined(param_01)) {
    var_02 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_03 = param_00 - var_02;
    var_04 = 0.05;
    var_05 = param_01 / var_04;
    var_06 = var_03 / var_05;
    while(abs(param_00 - var_02) > abs(var_06 * 1.1)) {
      scripts\asm\asm::func_237B(var_02 + var_06);
      wait(var_04);
      var_02 = scripts\asm\asm::asm_getmoveplaybackrate();
    }
  }

  scripts\asm\asm::func_237B(param_00);
}

func_22C7(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in param_00) {
    var_07 thread func_1747(param_01, param_02, param_03, param_04, param_05);
  }
}

func_22CA(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getspawnerarray(param_00);
  var_06 = func_22A2(var_06, getEntArray(param_00, "targetname"));
  func_22C7(var_06, param_01, param_02, param_03, param_04, param_05);
}

func_22C9(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_7C84(param_00, "script_noteworthy");
  var_06 = func_22A2(var_06, getEntArray(param_00, "script_noteworthy"));
  func_22C7(var_06, param_01, param_02, param_03, param_04, param_05);
}

func_22C8(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_77DF(param_00);
  func_22C7(var_06, param_01, param_02, param_03, param_04, param_05);
}

func_61ED() {
  self.dontevershoot = 1;
}

func_551B() {
  self.dontevershoot = undefined;
}

func_4960(param_00) {
  if(!isDefined(level.var_11220)) {
    level.var_11220 = [];
  }

  var_01 = spawnStruct();
  var_01.name = param_00;
  level.var_11220[param_00] = var_01;
  return var_01;
}

func_6245() {
  thread func_6246();
}

func_6246() {
  self endon("death");
  for(;;) {
    self.var_115CE = 1;
    wait(0.05);
  }
}

func_5590() {
  self.var_115CE = undefined;
}

func_9A4D() {
  var_00 = [];
  var_00[0] = ["interactive_birds", "targetname"];
  var_00[1] = ["interactive_vulture", "targetname"];
  var_00[2] = ["interactive_fish", "script_noteworthy"];
  return var_00;
}

func_B3CB(param_00) {
  var_01 = func_9A4D();
  var_02 = [];
  foreach(var_04 in var_01) {
    var_05 = getEntArray(var_04[0], var_04[1]);
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  foreach(var_08 in var_02) {
    if(!isDefined(level.var_12EF[var_08.var_9A4B].var_EB78)) {
      continue;
    }

    foreach(var_0B in param_00) {
      if(!var_0B istouching(var_08)) {
        continue;
      }

      if(!isDefined(var_0B.var_9A4E)) {
        var_0B.var_9A4E = [];
      }

      var_0B.var_9A4E[var_0B.var_9A4E.size] = var_08[[level.var_12EF[var_08.var_9A4B].var_EB78]]();
    }
  }
}

func_15BD() {
  if(!isDefined(self.var_9A4E)) {
    return;
  }

  foreach(var_01 in self.var_9A4E) {
    var_01[[level.var_12EF[var_01.var_9A4B].var_AE17]]();
  }

  self.var_9A4E = undefined;
}

func_515D(param_00) {
  func_B3CB(param_00);
  foreach(var_02 in param_00) {
    var_02.var_9A4E = undefined;
  }
}

func_B3CA(param_00) {
  if(getdvar("createfx") != "") {
    return;
  }

  var_01 = getEntArray("script_brushmodel", "classname");
  var_02 = getEntArray("script_model", "classname");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_01[var_01.size] = var_02[var_03];
  }

  foreach(var_05 in param_00) {
    foreach(var_07 in var_01) {
      if(isDefined(var_07.script_prefab_exploder)) {
        var_07.script_exploder = var_07.script_prefab_exploder;
      }

      if(!isDefined(var_07.script_exploder)) {
        continue;
      }

      if(!isDefined(var_07.model)) {
        continue;
      }

      if(var_07.var_9F != "script_model") {
        continue;
      }

      if(!var_07 istouching(var_05)) {
        continue;
      }

      var_07.masked_exploder = 1;
    }
  }
}

func_15AD() {
  var_00 = spawn("script_origin", (0, 0, 0));
  foreach(var_02 in level.createfxent) {
    if(!isDefined(var_02.v["masked_exploder"])) {
      continue;
    }

    var_00.origin = var_02.v["origin"];
    var_00.angles = var_02.v["angles"];
    if(!var_00 istouching(self)) {
      continue;
    }

    var_03 = var_02.v["masked_exploder"];
    var_04 = var_02.v["masked_exploder_spawnflags"];
    var_05 = var_02.v["masked_exploder_script_disconnectpaths"];
    var_06 = spawn("script_model", (0, 0, 0), var_04);
    var_06 setModel(var_03);
    var_06.origin = var_02.v["origin"];
    var_06.angles = var_02.v["angles"];
    var_02.v["masked_exploder"] = undefined;
    var_02.v["masked_exploder_spawnflags"] = undefined;
    var_02.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_06.disconnect_paths = var_05;
    var_06.script_exploder = var_02.v["exploder"];
    scripts\common\exploder::setup_individual_exploder(var_06);
    var_02.model = var_06;
  }

  var_00 delete();
}

func_5146(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03.var_5379 = [];
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
            wait(0.05);
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

func_5153(param_00, param_01) {
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
      if(!isDefined(var_0B.script_exploder)) {
        continue;
      }

      var_06.origin = var_0B getorigin();
      if(!var_09 istouching(var_06)) {
        continue;
      }

      var_05[var_05.size] = var_0B;
    }
  }

  func_228A(var_05);
  var_06 delete();
}

setflashbangimmunity(param_00) {
  self.var_6EC4 = param_00;
}

func_6EC3() {
  var_00 = self.flashendtime - gettime();
  if(var_00 < 0) {
    return 0;
  }

  return var_00 * 0.001;
}

func_6EC5() {
  return func_6EC3() > 0;
}

func_6EC6(param_00) {
  if(isDefined(self.var_6EC4) && self.var_6EC4) {
    return;
  }

  var_01 = gettime() + param_00 * 1000;
  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var_01);
  } else {
    self.flashendtime = var_01;
  }

  self notify("flashed");
  self give_money(1);
}

func_13821() {
  for(;;) {
    var_00 = getaispeciesarray("axis", "all");
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
      var_05 = func_77E3("axis");
      if(!var_05.size) {
        break;
      }
    }

    wait(0.05);
  }
}

func_13822() {
  var_00 = 0;
  for(;;) {
    var_01 = getaispeciesarray("axis", "all");
    var_02 = 0;
    foreach(var_04 in var_01) {
      if(!isalive(var_04)) {
        continue;
      }

      if(var_04 istouching(self)) {
        if(var_04 func_58DA()) {
          continue;
        }

        var_02 = 1;
        var_00 = 1;
        break;
      }

      wait(0.0125);
    }

    if(!var_02) {
      var_06 = func_77E3("axis");
      if(!var_06.size) {
        break;
      } else {
        var_00 = 1;
      }
    }

    wait(0.05);
  }

  return var_00;
}

func_13823(param_00) {
  func_13821();
  scripts\engine\utility::flag_set(param_00);
}

func_1380D(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02 func_13823(param_01);
}

func_D0F4() {
  if(isplayer(self)) {
    var_00 = self;
  } else {
    var_00 = level.player;
  }

  return isDefined(var_00.isent) && var_00.isent.var_6F43;
}

func_CFAA() {
  level.player func_65DD("player_zero_attacker_accuracy");
  level.player.precachenightvisioncodeassets = 0;
  level.player scripts\sp\gameskill::func_12E0B();
}

func_CFB8() {
  level.player func_65E1("player_zero_attacker_accuracy");
  level.player.var_50 = 0;
  level.player.precachenightvisioncodeassets = 1;
}

func_F520(param_00) {
  var_01 = func_7B92();
  var_01.gs.var_CF81 = param_00;
  var_01 scripts\sp\gameskill::func_12E0B();
}

func_2298(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_03.script_parameters] = var_03;
  }

  return var_01;
}

func_2297(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_03.classname] = var_03;
  }

  return var_01;
}

func_2299(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(isDefined(var_03.script_index)) {
      var_01[var_03.script_index] = var_03;
    }
  }

  return var_01;
}

func_78D5() {
  var_00 = scripts\sp\utility_code::func_78D1();
  var_01 = var_00["team"];
  foreach(var_03 in var_00["codes"]) {
    var_04 = level.var_22DF[var_01][var_03];
    if(isDefined(var_04)) {
      return var_04;
    }
  }

  return undefined;
}

func_78D3() {
  var_00 = scripts\sp\utility_code::func_78D1();
  var_01 = var_00["team"];
  foreach(var_03 in var_00["codes"]) {
    var_04 = level.var_22DD[var_01][var_03];
    if(isDefined(var_04)) {
      return var_04;
    }
  }

  return undefined;
}

func_6EC7() {
  self.flashendtime = undefined;
  self give_money(0);
}

func_7E96(param_00, param_01) {
  var_02 = getent(param_00, param_01);
  if(isDefined(var_02)) {
    return var_02;
  }

  return scripts\engine\utility::getstruct(param_00, param_01);
}

func_7C9A(param_00) {
  return getcsplineid(param_00);
}

func_7C9B(param_00) {
  return getcsplineidarray(param_00);
}

grenade_earthquake() {
  thread scripts\sp\utility_code::endondeath();
  self endon("end_explode");
  self waittill("explode", var_00);
  func_7751(var_00);
}

func_7751(param_00) {
  func_5FC7(param_00);
  func_54EF(param_00);
}

func_5FC7(param_00) {
  playrumbleonposition("grenade_rumble", param_00);
  earthquake(0.4, 0.5, param_00, 400);
}

func_54EF(param_00) {
  if(level.player _meth_853E()) {
    return;
  }

  if(!isDefined(level.player.var_A8FD)) {
    level.player.var_A8FD = gettime();
  } else if(gettime() - level.player.var_A8FD < 3000) {
    return;
  }

  level.player.var_A8FD = gettime();
  foreach(var_02 in level.players) {
    if(distance(param_00, var_02.origin) > 600) {
      continue;
    }

    if(var_02 damageconetrace(param_00)) {
      var_02 thread dirteffect(param_00);
    }
  }
}

dirteffect(param_00, param_01) {
  var_02 = func_ECC4(param_00);
  foreach(var_05, var_04 in var_02) {
    thread scripts\sp\gameskill::forcehidegrenadehudwarning(var_05);
  }
}

func_2BC6(param_00) {
  if(!isDefined(self.damageattacker)) {
    return;
  }

  var_01 = func_ECC4(self.damageattacker.origin);
  foreach(var_04, var_03 in var_01) {
    thread scripts\sp\gameskill::func_2BC1(var_04);
  }
}

func_ECC4(param_00) {
  var_01 = vectornormalize(anglesToForward(self.angles));
  var_02 = vectornormalize(anglestoright(self.angles));
  var_03 = vectornormalize(param_00 - self.origin);
  var_04 = vectordot(var_03, var_01);
  var_05 = vectordot(var_03, var_02);
  var_06 = [];
  var_07 = self getcurrentweapon();
  if(var_04 > 0 && var_04 > 0.5 && weapontype(var_07) != "riotshield") {
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

func_C971(param_00) {
  if(!isDefined(self.var_C3D0)) {
    self.var_C3D0 = self.visionsetalternate;
  }

  self.visionsetalternate = param_00;
}

func_C972() {
  if(isDefined(self.var_C3D0)) {
    return;
  }

  self.var_C3D0 = self.visionsetalternate;
  self.visionsetalternate = 0;
}

func_C970() {
  self.visionsetalternate = self.var_C3D0;
  self.var_C3D0 = undefined;
}

func_13876() {
  if(isDefined(self.var_C3E3)) {
    return;
  }

  self.var_C3E2 = self.var_391;
  self.var_C3E3 = self.var_392;
  self.var_391 = 0;
  self.var_392 = 0;
}

func_13875() {
  self.var_391 = self.var_C3E2;
  self.var_392 = self.var_C3E3;
  self.var_C3E2 = undefined;
  self.var_C3E3 = undefined;
}

func_6205() {
  thread func_9330();
}

func_9330() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.precachenightvisioncodeassets = 1;
  self.var_6B4B = self.health;
  self.health = 1000000;
  for(;;) {
    self waittill("damage", var_00, var_01);
    if(!isplayer(var_01) && issentient(var_01)) {
      if(isDefined(var_01.isnodeoccupied) && var_01.isnodeoccupied != self) {
        continue;
      }
    }

    self.var_6B4B = self.var_6B4B - var_00;
    if(self.var_6B4B <= 0) {
      break;
    }
  }

  self _meth_81D0();
}

func_8E9A() {
  if(!isDefined(self.var_C3E9)) {
    self.var_C3E9 = self setcontents(0);
  }

  self hide();
}

func_100FC() {
  if(!isai(self)) {
    self solid();
  }

  if(isDefined(self.var_C3E9)) {
    self setcontents(self.var_C3E9);
  }

  self show();
}

func_F2E7(param_00) {
  self.var_371 = param_00;
}

func_553C() {
  if(!isalive(self)) {
    return;
  }

  if(!isDefined(self.precachenightvisioncodeassets)) {
    return;
  }

  self notify("disable_ignorerandombulletdamage_drone");
  self.precachenightvisioncodeassets = undefined;
  self.health = self.var_6B4B;
}

func_11905(param_00) {
  var_01 = spawnStruct();
  var_01 scripts\engine\utility::delaythread(param_00, ::func_F225, "timeout");
  return var_01;
}

func_50E4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  childthread scripts\sp\utility_code::func_50E5(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_6E7C(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isarray(param_00)) {
    param_00 = [param_00, 0];
  }

  thread scripts\sp\utility_code::func_6E7D(param_01, param_00, param_02, param_03, param_04, param_05, param_06);
}

func_13843(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  if(!isarray(param_00)) {
    param_00 = [param_00, 0];
  }

  thread scripts\sp\utility_code::func_13844(param_01, param_00, param_02, param_03, param_04, param_05, param_06);
}

func_61EB(param_00) {
  param_00 = param_00 * 1000;
  self.var_F7 = 1;
  self.var_E4 = param_00;
  self.var_BEFA = undefined;
}

func_5517() {
  self.var_F7 = 0;
  self.var_BEFA = 1;
}

func_F3EC(param_00, param_01) {
  level.var_18D7 = param_00;
  level.var_18D6 = param_01;
}

func_E1F2(param_00) {
  level.var_A936[param_00] = gettime();
}

func_F323(param_00) {
  level.var_4C53 = param_00;
  thread scripts\sp\gameskill::func_E26C();
}

func_4140() {
  level.var_4C53 = undefined;
  thread scripts\sp\gameskill::func_E26C();
}

func_11147(param_00) {
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

func_F2DC(param_00, param_01) {
  level.var_28CF[param_00] = param_01;
  scripts\sp\utility_code::func_12D95();
}

func_C27B(param_00) {
  for(var_01 = 0; var_01 < 8; var_01++) {
    objective_additionalposition(param_00, var_01, (0, 0, 0));
  }
}

func_7AE6(param_00) {
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

func_D0CA(param_00) {
  var_01 = level.player getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(var_03 == param_00) {
      return 1;
    }
  }

  return 0;
}

func_D0BD(param_00, param_01) {
  var_02 = level.player getweaponslistoffhands();
  foreach(var_04 in var_02) {
    if(var_04 == param_00) {
      return 1;
    }
  }

  if(isDefined(param_01) && param_01 == 1) {
    if(level.player.var_110BD == param_00) {
      return 1;
    }

    if(level.player.var_110BA == param_00) {
      return 1;
    }
  }

  return 0;
}

func_D0BE(param_00) {
  if(level.player.var_110BD == param_00) {
    return 1;
  }

  if(level.player.var_110BA == param_00) {
    return 1;
  }

  return 0;
}

func_C264(param_00) {
  if(!isDefined(level.var_C265)) {
    level.var_C265 = [];
  }

  if(!isDefined(level.var_C265[param_00])) {
    level.var_C265[param_00] = level.var_C265.size + 1;
  }

  return level.var_C265[param_00];
}

func_C268(param_00) {
  return isDefined(level.var_C265) && isDefined(level.var_C265[param_00]);
}

_meth_848C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_04 - param_02;
  var_06 = param_03 - param_01;
  var_07 = var_05 / var_06;
  param_00 = param_00 - param_03;
  param_00 = var_07 * param_00;
  param_00 = param_00 + param_04;
  return param_00;
}

func_BDF1(param_00) {
  var_01 = lookupsoundlength(param_00);
  var_01 = var_01 * 0.001;
  return var_01;
}

func_9B9D(param_00) {
  var_01 = getkeybinding(param_00);
  return var_01["count"];
}

func_ACED(param_00, param_01, param_02) {
  var_03 = param_02 - param_01;
  var_04 = param_00 * var_03;
  var_05 = param_01 + var_04;
  return var_05;
}

func_509E(param_00) {
  level.var_AE21 = param_00;
}

func_50A0(param_00) {
  switch (param_00) {
    case "titan":
      level.plant_anims = "titan";
      break;

    case "moon_port":
      level.plant_anims = "moon";
      break;

    case "marscrib":
    case "marsbase":
    case "marscrash":
      level.plant_anims = "mars";
      break;

    case "rogue":
      level.plant_anims = "asteroid";
      break;

    case "europa":
      level.plant_anims = "europa";
      break;

    default:
      level.plant_anims = "earth";
      break;
  }
}

func_116CB(param_00) {
  func_509E(param_00);
  level.template_script = param_00;
  func_50A0(param_00);
}

func_116CD(param_00) {
  level.var_25FA = param_00;
}

func_7616(param_00, param_01) {
  thread func_7617(param_00, param_01);
}

func_7617(param_00, param_01) {
  var_02 = getent(param_00, "script_noteworthy");
  var_02 notify("new_volume_command");
  var_02 endon("new_volume_command");
  wait(0.05);
  scripts\sp\utility_code::func_7615(var_02, param_01);
}

func_7619(param_00) {
  thread func_761A(param_00);
}

func_761A(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  var_01 notify("new_volume_command");
  var_01 endon("new_volume_command");
  wait(0.05);
  if(!isDefined(var_01.var_75BA)) {
    return;
  }

  var_01.var_75BA = undefined;
  func_7618(var_01);
}

func_7618(param_00) {
  scripts\engine\utility::array_thread(param_00.fx, ::func_E2B0);
}

func_16AE(param_00, param_01) {
  if(!isDefined(level.var_4074)) {
    level.var_4074 = [];
  }

  if(!isDefined(level.var_4074[param_01])) {
    level.var_4074[param_01] = [];
  }

  level.var_4074[param_01][level.var_4074[param_01].size] = param_00;
}

func_4074(param_00) {
  var_01 = level.var_4074[param_00];
  var_01 = scripts\engine\utility::array_removeundefined(var_01);
  func_228A(var_01);
  level.var_4074[param_00] = undefined;
}

func_4075(param_00) {
  if(!isDefined(level.var_4074)) {
    return;
  }

  if(!isDefined(level.var_4074[param_00])) {
    return;
  }

  var_01 = level.var_4074[param_00];
  var_01 = scripts\engine\utility::array_removeundefined(var_01);
  foreach(var_03 in var_01) {
    if(!isai(var_03)) {
      continue;
    }

    if(!isalive(var_03)) {
      continue;
    }

    if(!isDefined(var_03.var_B14F)) {
      continue;
    }

    if(!var_03.var_B14F) {
      continue;
    }

    var_03 func_1101B();
  }

  func_228A(var_01);
  level.var_4074[param_00] = undefined;
}

func_178A(param_00) {
  if(!isDefined(self.var_1274A)) {
    thread scripts\sp\utility_code::func_1789();
  }

  self.var_1274A[self.var_1274A.size] = param_00;
}

func_7DB7() {
  var_00 = [];
  var_01 = getEntArray();
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.classname)) {
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var_03.classname, "weapon_")) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_BCA1(param_00, param_01, param_02) {
  self notify("newmove");
  self endon("newmove");
  if(!isDefined(param_02)) {
    param_02 = 200;
  }

  var_03 = distance(self.origin, param_00);
  var_04 = var_03 / param_02;
  var_05 = vectornormalize(param_00 - self.origin);
  self moveto(param_00, var_04, 0, 0);
  self rotateto(param_01, var_04, 0, 0);
  wait(var_04);
  if(!isDefined(self)) {
    return;
  }

  self.var_381 = var_05 * var_03 / var_04;
}

func_6E3D(param_00) {
  level endon(param_00);
  self waittill("death");
  scripts\engine\utility::flag_set(param_00);
}

func_61EA() {
  level.damagefeedback = 1;
}

func_5516() {
  level.damagefeedback = 0;
}

func_9BAF() {
  return isDefined(level.damagefeedback) && level.damagefeedback;
}

func_9BB7() {
  if(getdvar("e3demo") == "1") {
    return 1;
  }

  return 0;
}

func_9C32() {
  if(level.script == "shipcrib_epilogue") {
    return 1;
  }

  return 0;
}

func_51D5(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getstructarray(param_00, param_01);
  func_51D6(var_03, param_02);
}

func_51D4(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00.destroynavobstacle;
  if(isDefined(var_01) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["script_linkname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.struct_class_names["script_linkname"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_01].size == 0) {
      level.struct_class_names["script_linkname"][var_01] = undefined;
    }
  }

  var_01 = param_00.script_noteworthy;
  if(isDefined(var_01) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["script_noteworthy"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.struct_class_names["script_noteworthy"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_01].size == 0) {
      level.struct_class_names["script_noteworthy"][var_01] = undefined;
    }
  }

  var_01 = param_00.target;
  if(isDefined(var_01) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["target"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.struct_class_names["target"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_01].size == 0) {
      level.struct_class_names["target"][var_01] = undefined;
    }
  }

  var_01 = param_00.var_336;
  if(isDefined(var_01) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["targetname"][var_01]) {
      if(isDefined(var_03) && param_00 == var_03) {
        level.struct_class_names["targetname"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_01].size == 0) {
      level.struct_class_names["targetname"][var_01] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_04, var_03 in level.struct) {
      if(param_00 == var_03) {
        level.struct[var_04] = undefined;
      }
    }
  }
}

func_51D6(param_00, param_01) {
  if(!isDefined(param_00) || !isarray(param_00) || param_00.size == 0) {
    return;
  }

  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 0);
  param_01 = scripts\engine\utility::ter_op(param_01 > 0, param_01, 0);
  if(param_01 > 0) {
    foreach(var_03 in param_00) {
      func_51D4(var_03);
      wait(param_01);
    }

    return;
  }

  foreach(var_03 in param_01) {
    func_51D4(var_03);
  }
}

getstruct_delete(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct(param_00, param_01);
  func_51D4(var_02);
  return var_02;
}

_meth_8181(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getstructarray(param_00, param_01);
  func_51D6(var_03, param_02);
  return var_03;
}

func_13DCC(param_00) {
  var_01 = param_00 - self.origin;
  return (vectordot(var_01, anglesToForward(self.angles)), -1 * vectordot(var_01, anglestoright(self.angles)), vectordot(var_01, anglestoup(self.angles)));
}

func_10460(param_00, param_01) {
  self ghostattack(0, param_00);
  if(scripts\engine\utility::istrue(param_01)) {
    scripts\engine\utility::delaycall(param_00 + 0.05, ::stoploopsound);
  } else {
    scripts\engine\utility::delaycall(param_00 + 0.05, ::stopsounds);
  }

  scripts\engine\utility::delaycall(param_00 + 0.1, ::delete);
}

func_10461(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_01 = clamp(param_01, 0, 1);
  param_02 = max(0.05, param_02);
  self ghostattack(0);
  wait(0.05);
  if(isDefined(param_03)) {
    self playLoopSound(param_00);
  } else {
    self playSound(param_00);
  }

  wait(0.05);
  scripts\engine\utility::delaycall(0.05, ::ghostattack, param_01, param_02);
}

func_5188() {
  self waittill("sounddone");
  self delete();
}

func_5184(param_00) {
  self waittill(param_00);
  self delete();
}

func_9ACE(param_00, param_01, param_02, param_03, param_04) {
  level.var_9AF3 = spawnStruct();
  level.var_9AF3.var_4480 = 3;
  level.var_9AF3.var_6AAA = 1.5;
  level.var_9AF3.var_6A9F = undefined;
  if(isDefined(param_03)) {
    level.var_9AF3.var_ACF2 = [param_00, param_01, param_02, param_03];
  } else {
    level.var_9AF3.var_ACF2 = [param_00, param_01, param_02];
  }

  scripts\engine\utility::noself_array_call(level.var_9AF3.var_ACF2, ::precachestring);
}

func_9ACF(param_00) {
  level.var_9AF3.var_4C88 = param_00;
}

func_9AD0(param_00, param_01, param_02) {
  level.var_9AF3.var_4480 = param_00;
  level.var_9AF3.var_6AAA = param_01;
  level.var_9AF3.var_6A9F = param_02;
}

func_DE97(param_00, param_01, param_02) {
  scripts\anim\animset::func_DEE7(param_00, param_01, param_02);
}

func_2124(param_00) {
  return scripts\anim\animset::func_2126(param_00);
}

func_F2C8(param_00) {
  self.var_1F62 = param_00;
  self notify("move_loop_restart");
  if(param_00 == "creepwalk") {
    self.nodetoentitysighttest = 72;
  }
}

func_412C() {
  if(isDefined(self.var_1F62) && self.var_1F62 == "creepwalk") {
    self.nodetoentitysighttest = 30;
  }

  self.var_1F62 = undefined;
  self notify("move_loop_restart");
}

func_12641(param_00) {
  if(istransientloaded(param_00)) {
    return;
  }

  if(!scripts\engine\utility::flag_exist(param_00 + "_loaded")) {
    scripts\engine\utility::flag_init(param_00 + "_loaded");
  }

  loadtransient(param_00);
  while(!istransientloaded(param_00)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set(param_00 + "_loaded");
  level notify("new_transient_loaded");
}

func_1264E(param_00) {
  if(!istransientloaded(param_00)) {
    return;
  }

  unloadtransient(param_00);
  while(istransientloaded(param_00)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_clear(param_00 + "_loaded");
}

func_12643(param_00) {
  foreach(var_02 in param_00) {
    thread func_12641(var_02);
  }

  for(;;) {
    var_04 = 1;
    foreach(var_02 in param_00) {
      if(!istransientloaded(var_02)) {
        var_04 = 0;
        break;
      }
    }

    if(var_04) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level notify("new_transient_loaded");
}

func_12651(param_00) {
  foreach(var_02 in param_00) {
    thread func_1264E(var_02);
  }

  for(;;) {
    var_04 = 1;
    foreach(var_02 in param_00) {
      if(istransientloaded(var_02)) {
        var_04 = 0;
        break;
      }
    }

    if(var_04) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_1263F(param_00) {
  scripts\engine\utility::flag_init(param_00 + "_loaded");
}

func_1264C(param_00, param_01) {
  if(scripts\engine\utility::flag(param_00 + "_loaded")) {
    func_1264E(param_00);
  }

  if(!scripts\engine\utility::flag(param_01 + "_loaded")) {
    func_12641(param_01);
  }
}

func_12653(param_00) {
  unloadalltransients();
  func_12641(param_00);
}

func_F6DB(param_00, param_01, param_02) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    setdvar(param_00, param_02);
    return;
  }

  setdvar(param_00, param_01);
}

func_F828(param_00, param_01, param_02) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    setsaveddvar(param_00, param_02);
    return;
  }

  setsaveddvar(param_00, param_01);
}

func_7227(param_00, param_01) {
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

  self.var_4B76 = var_02;
  var_02 script_delay();
  while(isDefined(var_02)) {
    self.var_4B76 = var_02;
    if(isDefined(var_02.setnojiptime)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var_02.var_336])) {
      var_04 = ::func_722A;
    } else if(isDefined(var_02.classname)) {
      var_04 = ::func_7228;
    } else {
      var_04 = ::func_7229;
    }

    if(isDefined(var_02.fgetarg) && var_02.fgetarg != 0) {
      self.objective_playermask_showto = var_02.fgetarg;
    }

    if(self.objective_playermask_showto < 16) {
      self.objective_playermask_showto = 16;
    }

    if(isDefined(var_02.height) && var_02.height != 0) {
      self.objective_playermask_hidefrom = var_02.height;
    }

    var_05 = self.objective_playermask_showto;
    self childthread[[var_04]](var_02);
    if(isDefined(var_02.animation)) {
      var_02 waittill(var_02.animation);
    } else {
      for(;;) {
        self waittill("goal");
        if(distance(var_02.origin, self.origin) < var_05 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_02 notify("trigger", self);
    if(isDefined(var_02.var_ED9E)) {
      scripts\engine\utility::flag_set(var_02.var_ED9E);
    }

    if(isDefined(var_02.script_parameters)) {
      var_06 = strtok(var_02.script_parameters, " ");
      for(var_07 = 0; var_07 < var_06.size; var_07++) {
        if(isDefined(level.var_4C50)) {
          self[[level.var_4C50]](var_06[var_07], var_02);
        }

        if(self.type == "dog") {
          continue;
        }

        switch (var_06[var_07]) {
          case "enable_cqb":
            func_61E7();
            break;

          case "disable_cqb":
            func_5514();
            break;

          case "deleteme":
            self delete();
            break;
        }
      }
    }

    if(!isDefined(var_02.var_EE95) && param_01 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(func_722C(var_02, param_01)) {
          break;
        }

        if(isDefined(var_02.animation)) {
          self.objective_playermask_showto = var_05;
          self give_mp_super_weapon(self.origin);
        }

        wait(0.05);
      }
    }

    if(!isDefined(var_02.target)) {
      break;
    }

    if(isDefined(var_02.var_EDA0)) {
      scripts\engine\utility::flag_wait(var_02.var_EDA0);
    }

    var_02 script_delay();
    var_02 = var_02 scripts\engine\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

func_722C(param_00, param_01) {
  if(distance(level.player.origin, param_00.origin) < distance(self.origin, param_00.origin)) {
    return 1;
  }

  var_02 = undefined;
  var_02 = anglesToForward(self.angles);
  var_03 = vectornormalize(level.player.origin - self.origin);
  if(isDefined(param_00.target)) {
    var_04 = scripts\engine\utility::get_target_ent(param_00.target);
    var_02 = vectornormalize(var_04.origin - param_00.origin);
  } else if(isDefined(param_00.angles)) {
    var_02 = anglesToForward(param_00.angles);
  } else {
    var_02 = anglesToForward(self.angles);
  }

  if(vectordot(var_02, var_03) > 0) {
    return 1;
  }

  if(distance(level.player.origin, self.origin) < param_01) {
    return 1;
  }

  return 0;
}

func_7229(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.animation)) {
    param_00 scripts\sp\anim::func_1ECE(self, param_00.animation);
    self notify("starting_anim", param_00.animation);
    if(isDefined(param_00.script_parameters) && issubstr(param_00.script_parameters, "gravity")) {
      param_00 scripts\sp\anim::func_1ECB(self, param_00.animation);
    } else {
      param_00 scripts\sp\anim::func_1ED1(self, param_00.animation);
    }

    self give_mp_super_weapon(self.origin);
    return;
  }

  func_F3D9(param_00);
}

func_7228(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.animation)) {
    param_00 scripts\sp\anim::func_1ECE(self, param_00.animation);
    self notify("starting_anim", param_00.animation);
    if(isDefined(param_00.script_parameters) && issubstr(param_00.script_parameters, "gravity")) {
      param_00 scripts\sp\anim::func_1ECB(self, param_00.animation);
    } else {
      param_00 scripts\sp\anim::func_1ED1(self, param_00.animation);
    }

    self give_mp_super_weapon(self.origin);
    return;
  }

  func_F3D3(param_00);
}

func_722A(param_00) {
  self notify("follow_path_new_goal");
  if(isDefined(param_00.animation)) {
    param_00 scripts\sp\anim::func_1ECE(self, param_00.animation);
    self notify("starting_anim", param_00.animation);
    func_5528();
    if(isDefined(param_00.script_parameters) && issubstr(param_00.script_parameters, "gravity")) {
      param_00 scripts\sp\anim::func_1ECB(self, param_00.animation);
    } else {
      param_00 scripts\sp\anim::func_1ED1(self, param_00.animation);
    }

    scripts\engine\utility::delaythread(0.05, ::func_61F7);
    self give_mp_super_weapon(self.origin);
    return;
  }

  func_F3DC(param_00.origin);
}

func_D6D9(param_00) {
  if(!isDefined(level.var_D6D8)) {
    level.var_D6D8 = [];
  }

  level.var_D6D8 = scripts\engine\utility::array_add(level.var_D6D8, param_00);
}

func_765B() {
  if(level.var_13E0F) {
    return 1;
  }

  if(level.var_DADB) {
    return 1;
  }

  return 0;
}

func_12B17(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setdvar(var_01, "on");
}

func_12B16(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setdvar(var_01, "turn_off");
}

func_12B18(param_00) {
  var_01 = "ui_actionslot_" + param_00 + "_forceActive";
  setdvar(var_01, "onetime");
}

hastag(param_00, param_01) {
  if(!isDefined(level.has_tag)) {
    level.has_tag = [];
  }

  var_02 = param_00 + "_" + param_01;
  if(isDefined(level.has_tag[var_02])) {
    return level.has_tag[var_02];
  }

  var_03 = getnumparts(param_00);
  if(var_03 > 0) {
    for(var_04 = 0; var_04 < var_03; var_04++) {
      var_05 = tolower(getpartname(param_00, var_04));
      if(var_05 == tolower(param_01)) {
        level.has_tag[var_02] = 1;
        return 1;
      }
    }

    level.has_tag[var_02] = 0;
  }

  return 0;
}

func_1119E(param_00, param_01, param_02, param_03) {
  if(!isarray(param_00)) {
    param_00 = [param_00];
  }

  var_04 = 320;
  var_05 = 200;
  var_06 = [];
  foreach(var_0A, var_08 in param_00) {
    var_09 = scripts\sp\introscreen::func_111A0(var_08, param_01, var_04, var_05 + var_0A * 20, "center", param_02, param_03);
    var_06 = scripts\engine\utility::array_combine(var_09, var_06);
  }

  wait(param_01);
  scripts\sp\introscreen::func_1119F(var_06, var_04, var_05, param_00.size);
}

func_97A2() {
  if(!scripts\engine\utility::add_init_script("waits", ::func_97A2)) {
    return;
  }

  level.var_13711 = spawnStruct();
  level.var_13711.var_13590 = [];
  level.var_13711.var_E7F9 = [];
  level.var_13711.var_E7E0 = [];
  level.var_13711.var_E80A = [];
  level.var_13711.var_57D7 = [];
  level.var_13711.var_1523 = [];
}

func_F5AF(param_00, param_01) {
  var_02 = [];
  if(isstring(param_00)) {
    var_02 = scripts\engine\utility::get_target_array(param_00);
  } else if(isarray(param_00)) {
    var_02 = param_00;
  }

  if(var_02.size == 0) {
    return;
  }

  foreach(var_04 in param_01) {
    var_05 = undefined;
    foreach(var_07 in var_02) {
      if(!isDefined(var_07.script_noteworthy)) {
        continue;
      }

      if(isplayer(var_04)) {
        if(var_07.script_noteworthy == "player") {
          var_05 = var_07;
          break;
        }

        continue;
      }

      if(isDefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_07.script_noteworthy) {
        var_05 = var_07;
        break;
      }
    }

    if(isDefined(var_05)) {
      var_05.var_1146E = 1;
      var_04.var_10CBA = var_05;
      if(isai(var_04)) {
        var_04 give_mp_super_weapon(var_05.origin);
      }

      var_04 func_11624(var_05);
    }
  }

  foreach(var_04 in param_01) {
    if(isDefined(var_04.var_10CBA)) {
      continue;
    }

    foreach(var_07 in var_02) {
      if(!isDefined(var_07.var_1146E)) {
        var_07.var_1146E = 1;
        var_04.var_10CBA = var_07;
        if(isai(var_04)) {
          var_04 give_mp_super_weapon(var_07.origin);
        }

        var_04 func_11624(var_07);
        break;
      }
    }
  }
}

func_A6F2(param_00) {}

func_61F0(param_00) {
  scripts\sp\dynamic_move::func_5F84(param_00);
}

func_5522() {
  scripts\sp\dynamic_move::func_5557();
}

func_D08C(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  var_03 = undefined;
  var_04 = 0;
  if(level.player func_7B8C() == "safe") {
    var_03 = 1;
    var_04 = 1;
  }

  var_05 = 0;
  if(isDefined(param_01)) {
    var_02 = self playgestureviewmodel(param_00, param_01, var_05, var_03, undefined);
  } else {
    var_02 = self playgestureviewmodel(param_00, undefined, var_05, var_03, undefined);
  }

  return var_02;
}

func_D091(param_00, param_01) {
  self endon("death");
  if(self _meth_819F()) {
    return 0;
  }

  if(self getteamsize()) {
    return 0;
  }

  return func_D090(param_00, param_01);
}

func_D090(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  var_03 = undefined;
  var_04 = 0;
  if(level.player func_7B8C() == "safe") {
    var_03 = 0.2;
    var_04 = 1;
  }

  if(isDefined(param_01) && isent(param_01)) {
    var_02 = self forceplaygestureviewmodel(param_00, param_01, var_03, undefined, undefined);
  } else {
    var_02 = self forceplaygestureviewmodel(param_00, undefined, var_03, undefined, undefined);
  }

  if(var_02) {
    thread lib_0E49::func_D092(param_00, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  }

  return var_02;
}

func_77DB(param_00) {
  return level.var_1162[param_00].var_10878 + level.var_1162[param_00].var_1A09;
}

func_77DD(param_00) {
  level.var_1162[param_00].var_1912 = array_removedeadvehicles(level.var_1162[param_00].var_1912);
  level.var_1162[param_00].var_1912 = scripts\engine\utility::array_removeundefined(level.var_1162[param_00].var_1912);
  return level.var_1162[param_00].var_1A09;
}

func_77DE(param_00) {
  return level.var_1162[param_00].var_10878;
}

func_77DC(param_00) {
  return level.var_1162[param_00].var_1A0D;
}

func_77DF(param_00) {
  return level.var_1162[param_00].spawners;
}

func_77DA(param_00) {
  level.var_1162[param_00].var_1912 = array_removedeadvehicles(level.var_1162[param_00].var_1912);
  level.var_1162[param_00].var_1912 = scripts\engine\utility::array_removeundefined(level.var_1162[param_00].var_1912);
  return level.var_1162[param_00].var_1912;
}

func_75C4(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75C5(param_00, param_01, param_02, param_03);
}

func_75C5(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("entitydeleted");
  if(isDefined(param_03)) {
    self endon(param_03);
  }

  if(isDefined(param_02)) {
    wait(param_02);
  }

  func_75CD();
  func_1173C(param_01, param_00);
  playFXOnTag(scripts\engine\utility::getfx(param_00), self, param_01);
}

func_75F8(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75F9(param_00, param_01, param_02, param_03);
}

func_1173C(param_00, param_01) {
  if(self.model == "") {}

  if(!hastag(self.model, param_00)) {}
}

func_75F9(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("entitydeleted");
  if(isDefined(param_03)) {
    self endon(param_03);
  }

  if(isDefined(param_02)) {
    wait(param_02);
  }

  func_75CD();
  func_1173C(param_01, param_00);
  stopFXOnTag(scripts\engine\utility::getfx(param_00), self, param_01);
}

func_75A0(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75A1(param_00, param_01, param_02, param_03);
}

func_75A1(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("entitydeleted");
  if(isDefined(param_03)) {
    self endon(param_03);
  }

  if(isDefined(param_02)) {
    wait(param_02);
  }

  func_75CD();
  func_1173C(param_01, param_00);
  killfxontag(scripts\engine\utility::getfx(param_00), self, param_01);
}

func_79E1() {
  self.var_7609++;
  return string(self.var_7609);
}

func_75CE() {
  if(isDefined(self.var_760A)) {
    return;
  }

  self.var_760A = [];
  self.var_7609 = 0;
  thread func_75CF();
}

func_75CF() {
  self endon("death");
  self endon("entitydeleted");
  var_00 = 0;
  for(;;) {
    self waittill("new_fx_call");
    while(self.var_760A.size > 0) {
      var_01 = self.var_760A[0];
      self.var_760A = scripts\engine\utility::array_remove(self.var_760A, var_01);
      self notify(var_01);
      var_00++;
      if(var_00 == 3) {
        wait(0.05);
        var_00 = 0;
      }
    }
  }
}

func_75CD() {
  self endon("death");
  self endon("entitydeleted");
  var_00 = func_79E1();
  self.var_760A = scripts\engine\utility::array_add(self.var_760A, var_00);
  self notify("new_fx_call");
  self waittill(var_00);
}

func_1102B(param_00) {
  if(isDefined(param_00)) {
    self stopgestureviewmodel(param_00);
  } else {
    self stopgestureviewmodel();
  }

  self notify("gesture_stop");
}

func_F526(param_00, param_01) {
  self notify("entering_new_demeanor");
  if(!isDefined(self.var_77C1)) {
    self.var_77C1 = spawnStruct();
  }

  waittillframeend;
  switch (param_00) {
    case "normal":
      lib_0E49::func_660C();
      break;

    case "relaxed":
      lib_0E49::func_660D();
      break;

    case "safe":
      lib_0E49::func_660E(param_01);
      break;

    case "magboots":
      lib_0E49::func_660B();
      break;

    default:
      break;
  }
}

func_7B8C() {
  return level.player _meth_846D();
}

func_960B() {
  if(!isDefined(level.isinphase)) {
    level.isinphase = getdvarint("bg_gravity");
    level._meth_8519 = getomnvar("physics_gravity_z");
  }
}

func_EBA6(param_00, param_01) {
  func_960B();
  if(isDefined(param_00)) {
    setsaveddvar("bg_gravity", level.isinphase * param_00);
  }

  if(isDefined(param_01)) {
    physics_setgravity((0, 0, level._meth_8519 * param_01));
  }
}

func_241F(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(param_00 && !level.var_241D) {
    level.var_241D = param_00;
  } else if(!param_00 && level.var_241D) {
    level.var_241D = param_00;
  }

  if(isDefined(level.var_A056) && isDefined(level.var_A056.var_241A)) {
    [[level.var_A056.var_241A]](level.var_241D);
  }
}

func_F3E4(param_00, param_01) {
  func_960B();
  if(isDefined(param_00)) {
    setsaveddvar("bg_gravity", param_00);
  }

  if(isDefined(param_01)) {
    physics_setgravity((0, 0, param_01));
  }
}

func_E1F0() {
  setsaveddvar("bg_gravity", level.isinphase);
  physics_setgravity((0, 0, level._meth_8519));
}

func_77B9(param_00) {
  if(isDefined(self.unittype) && self.unittype == "c6") {
    thread lib_0C4C::func_1965(param_00);
  } else {
    thread lib_0C4C::func_194F(param_00 * 0.1);
    thread lib_0C4C::func_1964(param_00);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self.var_D4A4 = undefined;
}

func_77BD(param_00) {
  thread lib_0C4C::func_1967(param_00);
}

func_7793(param_00) {
  thread lib_0C4C::func_194F(param_00);
}

func_779E(param_00) {
  if(self.unittype == "c6") {
    thread lib_0C4C::func_1965(param_00);
  } else {
    lib_0C4C::func_1964(param_00);
  }

  self notify("stop_lookat");
}

func_7799(param_00, param_01, param_02) {
  self endon("death");
  thread lib_0C4C::func_1955(param_00, param_01, param_02);
}

func_779A(param_00, param_01, param_02, param_03) {
  thread lib_0C4C::func_1956(param_00, param_01, param_02, param_03);
}

func_7798(param_00, param_01, param_02) {
  thread lib_0C4C::func_194E(param_00, param_01, param_02);
}

func_779C(param_00, param_01) {
  thread lib_0C4C::func_1959(param_00, param_01);
}

func_779B(param_00, param_01) {
  lib_0C4C::func_196A(param_00, param_01);
}

func_7797(param_00, param_01) {
  lib_0C4C::func_1969(param_00, param_01);
}

func_77A9(param_00) {
  lib_0C4C::func_195D(param_00);
}

func_77B7(param_00) {
  lib_0C4C::func_1960(param_00);
}

func_7791(param_00, param_01, param_02) {
  lib_0C4C::func_194C(param_00, param_01, param_02);
}

func_7790(param_00, param_01) {
  lib_0C4C::func_192F(param_00, param_01);
}

func_7792(param_00, param_01) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");
  if(!isDefined(self.var_9BDC)) {
    thread func_7798(param_00, 4, 0.1);
  }

  if(isDefined(param_01) && param_01) {
    thread func_7799(param_00, 0.15, 0.7);
  }

  wait(0.7);
  for(;;) {
    thread func_7797(param_00, 2);
    wait(randomfloatrange(3, 5));
    var_02 = param_00 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread func_7797(var_02, 2);
    wait(randomfloatrange(0.25, 0.5));
    if(scripts\engine\utility::cointoss()) {
      var_02 = param_00 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread func_7797(var_02, 2);
      wait(randomfloatrange(0.25, 0.5));
    }
  }
}

func_77B8(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("gesture_stop");
  var_04 = squared(param_01);
  scripts\sp\interaction_manager::func_168F();
  var_05 = distance2dsquared(self.origin, param_02.origin);
  for(;;) {
    if(var_05 < var_04 && scripts\sp\interaction_manager::func_3838(param_01 * 3)) {
      break;
    }

    var_05 = distance2dsquared(self.origin, param_02.origin);
    scripts\engine\utility::waitframe();
  }

  self.var_D4A4 = 1;
  if(isDefined(param_03)) {
    thread func_77B7(param_00);
    self[[param_03]]();
  } else {
    func_77B7(param_00);
  }

  wait(2);
  scripts\sp\interaction_manager::func_DFB5();
  self.var_D4A4 = 0;
}

func_D123() {
  var_00 = level.player _meth_8473();
  if(isDefined(var_00)) {
    return 1;
  }

  return 0;
}

func_7B9D() {
  return level.var_D127.var_B154 / scripts\sp\gameskill::func_7A59();
}

func_A1A8(param_00) {
  if(!isDefined(level.var_A056)) {
    return 0;
  }

  if(!isDefined(level.var_A056.var_68B3)) {
    return 0;
  }

  if(!isDefined(param_00)) {
    return level.var_A056.var_68B3.running;
  }

  if(!isDefined(level.var_A056.var_68B3.var_68B6[param_00])) {
    return 0;
  }

  return level.var_A056.var_68B3.var_68B6[param_00].running;
}

func_13793() {
  while(func_A1A8()) {
    wait(0.05);
  }
}

func_13792(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  while(!isDefined(level.var_A056.var_68B3.var_68B6[param_00])) {
    wait(0.05);
  }

  while(!func_A1A8(param_00)) {
    wait(0.05);
  }

  if(param_01) {
    while(func_A1A8(param_00)) {
      wait(0.05);
    }
  }
}

func_D15B(param_00) {
  if(!isDefined(level.var_A056)) {
    return 0;
  }

  if(level.var_A056.var_D3C1 == param_00) {
    return 1;
  }

  return 0;
}

func_B324() {
  if(isDefined(level.var_A056) && level.var_A056.var_B323) {
    return 1;
  }

  return 0;
}

func_793C(param_00, param_01, param_02) {
  var_03 = vectortoangles(param_02 - param_01);
  var_04 = param_00[1] - var_03[1];
  var_04 = var_04 + 360;
  var_04 = int(var_04) % 360;
  if(var_04 > 350 || var_04 < 10) {
    var_05 = "8";
  } else if(var_05 < 60) {
    var_05 = "9";
  } else if(var_05 < 120) {
    var_05 = "6";
  } else if(var_05 < 150) {
    var_05 = "3";
  } else if(var_05 < 210) {
    var_05 = "2";
  } else if(var_05 < 240) {
    var_05 = "1";
  } else if(var_05 < 300) {
    var_05 = "4";
  } else {
    var_05 = "7";
  }

  return var_05;
}

func_1C49(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55CA)) {
      self.var_55CA = 0;
    }

    self.var_55CA--;
    if(!self.var_55CA) {
      level.player func_65DD("no_grenade_block_gesture");
      return;
    }

    return;
  }

  if(!isDefined(self.var_55CA)) {
    self.var_55CA = 0;
  }

  self.var_55CA++;
  level.player func_65E1("no_grenade_block_gesture");
}

func_1C75(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55E8)) {
      self.var_55E8 = 0;
    }

    self.var_55E8--;
    if(!self.var_55E8) {
      scripts\engine\utility::flag_clear("weapon_scanning_off");
      return;
    }

    return;
  }

  if(!isDefined(self.var_55E8)) {
    self.var_55E8 = 0;
  }

  self.var_55E8++;
  scripts\engine\utility::flag_set("weapon_scanning_off");
}

func_1C39(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55C0)) {
      self.var_55C0 = 0;
    }

    self.var_55C0--;
    if(!self.var_55C0) {
      level.player func_65DD("disable_antigrav_float");
      return;
    }

    return;
  }

  if(!isDefined(self.var_55C0)) {
    self.var_55C0 = 0;
  }

  self.var_55C0++;
  if(!level.player func_65DF("disable_antigrav_float")) {
    level.player func_65E0("disable_antigrav_float");
  }

  level.player func_65E1("disable_antigrav_float");
}

func_1C3E(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55C2)) {
      self.var_55C2 = 0;
    }

    self.var_55C2--;
    if(!self.var_55C2) {
      setsaveddvar("cg_drawCrosshair", 1);
      return;
    }

    return;
  }

  if(!isDefined(self.var_55C2)) {
    self.var_55C2 = 0;
  }

  self.var_55C2++;
  setsaveddvar("cg_drawCrosshair", 0);
}

func_1C72(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55E7)) {
      self.var_55E7 = 0;
    }

    self.var_55E7--;
    if(!self.var_55E7) {
      setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
      return;
    }

    return;
  }

  if(!isDefined(self.var_55E7)) {
    self.var_55E7 = 0;
  }

  self.var_55E7++;
  setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
}

_meth_82EA(param_00) {
  func_1143E();
  self giveweapon(param_00);
  self assignweaponmeleeslot(param_00);
}

func_1143E() {
  var_00 = self _meth_8524();
  if(var_00 != "none") {
    self takeweapon(var_00);
  }
}

func_7AD7() {
  var_00 = self _meth_8524();
  if(var_00 != "none") {
    return var_00;
  }

  return undefined;
}

scriptmodelplayanimdeltamotion(param_00) {
  self.var_1586 = param_00;
  self giveweapon(param_00);
  if(!isDefined(self.var_55BD) || !self.var_55BD) {
    self setactionslot(1, "weapon", param_00);
  }
}

func_11425() {
  self setactionslot(1, "");
  self takeweapon(self.var_1586);
  self.var_1586 = undefined;
}

func_77C9() {
  if(isDefined(self.var_1586)) {
    return self.var_1586;
  }

  return "";
}

func_1C34(param_00) {
  if(param_00) {
    if(!isDefined(self.var_55BD)) {
      self.var_55BD = 0;
    }

    self.var_55BD--;
    if(!self.var_55BD) {
      if(isDefined(self.var_1586)) {
        self setactionslot(1, "weapon", self.var_1586);
        return;
      }

      return;
    }

    return;
  }

  if(!isDefined(self.var_55BD)) {
    self.var_55BD = 0;
  }

  self.var_55BD++;
  self setactionslot(1, "");
}

func_9B4D() {
  if(!isDefined(self.var_55BD)) {
    return 1;
  }

  if(!self.var_55BD) {
    return 1;
  }

  return 0;
}

func_7D74(param_00, param_01) {
  if(isDefined(param_00) && param_00 == 1) {
    var_02 = level.player getweaponslist("primary", "altmode");
  } else {
    var_02 = level.player getweaponslist("primary");
  }

  var_03 = [];
  var_04 = level.player func_7AD7();
  if(isDefined(var_04) && !isDefined(param_01) || param_01 == 0) {
    foreach(var_06 in var_02) {
      if(var_06 != var_04) {
        var_03[var_03.size] = var_06;
      }
    }
  } else {
    var_03 = var_02;
  }

  return var_03;
}

func_1145A(param_00) {
  lib_0B29::func_11456(param_00);
  self takeweapon(param_00);
}

func_11428() {
  lib_0B29::func_11427();
  self takeallweapons();
}

func_9C8D() {
  return scripts\engine\utility::flag("primary_equipment_input_down");
}

func_9C11() {
  if(self == level.player) {
    if(!isDefined(self.var_93B5) || self.var_93B5 == 0) {
      return 0;
    }

    return 1;
  }

  if(!isDefined(self.var_2023)) {
    return 0;
  }

  return 1;
}

func_13657() {
  scripts\engine\utility::flag_waitopen("primary_equipment_input_down");
}

func_13655() {
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

func_13656() {
  self waittill("primary_equipment_pressed");
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

func_9C8E() {
  return scripts\engine\utility::flag("primary_equipment_in_use");
}

func_9CB5() {
  return scripts\engine\utility::flag("secondary_equipment_input_down");
}

func_13662() {
  scripts\engine\utility::flag_waitopen("secondary_equipment_input_down");
}

func_13660() {
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

func_13661() {
  self waittill("secondary_equipment_pressed");
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

func_9CB6() {
  return scripts\engine\utility::flag("secondary_equipment_in_use");
}

func_7BD6() {
  if(level.player.curobjid == "") {
    return undefined;
  }

  return level.player.curobjid;
}

func_7BD7() {
  if(level.player.curobjid == "") {
    return 0;
  }

  if(func_799D(level.player.curobjid) == "drain") {
    return 1;
  }

  return level.player getrunningforwardpainanim(level.player.curobjid);
}

func_7C3D() {
  if(level.player.var_4B21 == "") {
    return undefined;
  }

  return level.player.var_4B21;
}

func_7C3E() {
  if(level.player.var_4B21 == "") {
    return 0;
  }

  if(func_799D(level.player.var_4B21) == "drain") {
    return 1;
  }

  return level.player getrunningforwardpainanim(level.player.var_4B21);
}

func_7CAF() {
  if(level.player.var_110BD == "") {
    return undefined;
  }

  return level.player.var_110BD;
}

func_7CB0() {
  if(level.player.var_110BD != "" && func_799D(level.player.var_110BD) == "drain") {
    return 1;
  }

  return level.player.var_110BE;
}

func_7CB1() {
  if(level.player.var_110BA == "") {
    return undefined;
  }

  return level.player.var_110BA;
}

func_7CB2() {
  if(level.player.var_110BA != "" && func_799D(level.player.var_110BA) == "drain") {
    return 1;
  }

  return level.player.var_110BB;
}

func_799C(param_00) {
  var_01 = [::func_7BD6, ::func_7CAF, ::func_7C3D, ::func_7CB1];
  var_02 = [::func_7BD7, ::func_7CB0, ::func_7C3E, ::func_7CB2];
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    var_04 = [[var_01[var_03]]]();
    var_05 = [[var_02[var_03]]]();
    if(isDefined(var_04) && var_04 == param_00) {
      return var_05;
    }
  }
}

func_D0C9() {
  if(!isDefined(level.player.var_110C0) || !level.player.var_110C0) {
    return 0;
  }

  return 1;
}

func_799D(param_00) {
  return lib_0B29::func_129C(param_00);
}

func_78E4() {
  if(getdvarint("ai_corpseSynch")) {
    return self _meth_82CC();
  }

  return self.origin;
}

func_9187(param_00, param_01, param_02) {
  scripts\sp\outline::func_9188(param_00, param_01, param_02);
}

func_9189(param_00, param_01, param_02) {
  scripts\sp\outline::func_918A(param_00, param_01, param_02);
}

func_9199(param_00, param_01) {
  scripts\sp\outline::func_919A(param_00, param_01);
}

func_9196(param_00, param_01, param_02, param_03) {
  scripts\sp\outline::func_9197(param_03, param_00, param_01, param_02, 0);
}

func_9198(param_00, param_01, param_02, param_03) {
  scripts\sp\outline::func_9197(param_03, param_00, param_01, param_02, 1);
}

func_9193(param_00) {
  scripts\sp\outline::func_9194(param_00);
}

func_918D(param_00, param_01) {
  scripts\sp\outline::func_CC8D(param_00, param_01);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + param_00);
}

func_918E(param_00, param_01) {
  thread scripts\sp\outline::func_CC8E(param_00, param_01);
}

func_91A9(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  setsaveddvar("r_hudoutlineEnable", 1);
  var_01 = "0.5 0.5 0.5";
  var_02 = "1 1 1";
  if(param_00) {
    var_01 = "0.5 0.5 0.5 1";
    var_02 = "0.5 0.5 0.5 0.2";
    var_03 = "0.5 0.5 0.5 1";
    var_04 = "0.7 0.7 0.7 1";
    var_05 = "0.5 0.5 0.5 1";
  } else {
    var_04 = "0.5 0.5 0.5 0";
    var_05 = "0.5 0.5 0.5 0";
    var_03 = "0.5 0.5 0.5 1";
    var_04 = "0.5 0.5 0.5 0.5";
    var_05 = "0.5 0.5 0.5 0.5";
  }

  setsaveddvar("r_hudoutlineFillColor0", var_01);
  setsaveddvar("r_hudoutlineFillColor1", var_02);
  setsaveddvar("r_hudoutlineOccludedOutlineColor", var_03);
  setsaveddvar("r_hudoutlineOccludedInlineColor", var_04);
  setsaveddvar("r_hudoutlineOccludedInteriorColor", var_05);
  setsaveddvar("r_hudOutlineOccludedColorFromFill", 1);
}

func_91A8(param_00, param_01) {
  var_02["allies"] = "friendly";
  var_02["axis"] = "enemy";
  var_02["team3"] = "neutral";
  var_02["dead"] = "neutral";
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else if(isDefined(self.team)) {
    var_03 = self.team;
  } else {
    var_03 = "dead";
  }

  if(param_00 && isDefined(var_02[var_03])) {
    func_F40A(var_02[var_03], 0);
    return;
  }

  self hudoutlinedisable();
}

func_9131(param_00) {
  setomnvar("ui_show_bink", 1);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(param_00);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  stopcinematicingame();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
}

func_918B(param_00, param_01, param_02) {
  if(isDefined(level.player.var_20F8)) {
    func_918C();
  }

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait(0.05);
  setsaveddvar("r_hudoutlineEnable", 1);
  level.player.var_20F8 = scripts\engine\utility::spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.var_20F8);
  if(!isDefined(param_00)) {
    param_00 = "ar_callouts_default";
  }

  setomnvar("ui_ar_object_text", param_00);
  wait(0.05);
  if(isDefined(param_01) && param_01) {
    func_9196(6, 1, 1, "default");
  } else {
    func_9196(6, 0, 1, "default");
  }

  setomnvar("ui_show_ar_elem", 1);
  thread func_1182(param_02);
}

func_1182(param_00) {
  level.player endon("stop_ar_callout");
  self endon("death");
  for(;;) {
    if(isDefined(param_00)) {
      var_01 = self.origin + param_00;
    } else {
      var_01 = self.origin + (0, 0, 30);
    }

    level.player.var_20F8.origin = var_01;
    wait(0.05);
  }
}

func_918C() {
  func_9193("default");
  setomnvar("ui_show_ar_elem", 0);
  wait(0.1);
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.var_20F8 delete();
  level.player.var_20F8 = undefined;
}

func_9145(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "fluff_messages_default";
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  setomnvar("ui_sp_fluff_messaging", param_00);
  setomnvar("ui_sp_fluff_messaging_context", param_01);
}

func_914C(param_00, param_01, param_02, param_03) {
  var_04 = 20;
  if(!isDefined(param_02)) {
    param_02 = "default";
  }

  switch (param_02) {
    case "intel_acepilot0":
      var_04 = 0;
      break;

    case "intel_acepilot1":
      var_04 = 1;
      break;

    case "intel_acepilot2":
      var_04 = 2;
      break;

    case "intel_acepilot3":
      var_04 = 3;
      break;

    case "intel_acepilot4":
      var_04 = 4;
      break;

    case "intel_acepilot5":
      var_04 = 5;
      break;

    case "intel_acepilot6":
      var_04 = 6;
      break;

    case "intel_acepilot7":
      var_04 = 7;
      break;

    case "intel_acepilot8":
      var_04 = 8;
      break;

    case "intel_acepilot9":
      var_04 = 9;
      break;

    case "intel_acepilot10":
      var_04 = 10;
      break;

    case "intel_acepilot11":
      var_04 = 11;
      break;

    case "intel_acepilot12":
      var_04 = 12;
      break;

    case "intel_acepilot13":
      var_04 = 13;
      break;

    case "intel_acepilot14":
      var_04 = 14;
      break;

    case "intel_acepilot15":
      var_04 = 15;
      break;

    case "intel_acepilot16":
      var_04 = 16;
      break;

    case "intel_acepilot17":
      var_04 = 17;
      break;

    case "intel_acepilot18":
      var_04 = 18;
      break;

    case "intel_acepilot19":
      var_04 = 19;
      break;

    case "default":
      var_04 = 20;
      break;

    case "capops_intel":
      var_04 = 20;
      break;

    case "tally_intel":
      var_04 = 21;
      break;

    case "jackal_intel":
      var_04 = 22;
      break;

    case "sdf_intel_1":
      var_04 = 23;
      break;

    case "news_intel":
      var_04 = 24;
      break;

    case "eweapon_intel":
      var_04 = 25;
      break;

    case "scan_intel":
      var_04 = 26;
      break;

    case "intel_captain0":
      var_04 = 27;
      break;

    case "intel_captain1":
      var_04 = 28;
      break;

    case "intel_captain2":
      var_04 = 29;
      break;

    case "intel_captain3":
      var_04 = 30;
      break;

    case "intel_captain4":
      var_04 = 31;
      break;

    case "intel_captain5":
      var_04 = 32;
      break;

    case "intel_captain6":
      var_04 = 33;
      break;

    case "intel_captain7":
      var_04 = 34;
      break;

    case "intel_captain8":
      var_04 = 35;
      break;

    case "intel_captain9":
      var_04 = 36;
      break;

    case "intel_scrap":
      var_04 = 37;
      break;

    case "intel_reticle":
      var_04 = 38;
      break;

    case "intel_attachment":
      var_04 = 39;
      break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", var_04);
  setomnvar("ui_sp_intel_messaging_text", param_01);
  setomnvar("ui_sp_intel_messaging_header", param_00);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread func_12EE();
  var_05 = param_02 == "tally_intel";
  if(var_05) {
    level.player thread func_12ED();
  }

  if(isDefined(param_03)) {
    setomnvar("ui_sp_intel_messaging_ent", 1);
  } else {
    setomnvar("ui_sp_intel_messaging_ent", 0);
  }

  var_06 = "close";
  var_07 = gettime() / 1000;
  var_08 = 5;
  while((var_05 && !isDefined(level.player.var_9951)) || !var_05 && gettime() / 1000 - var_07 < var_08) {
    if(isDefined(level.player.var_9963)) {
      var_06 = "waypoint";
      break;
    }

    wait(0.05);
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.var_9951 = undefined;
  if(var_06 == "waypoint" && isDefined(param_03)) {
    var_09 = scripts\engine\utility::spawn_script_origin(param_03, (0, 0, 0));
    var_09.icon = newhudelem();
    var_09.icon setshader("intel_hint_icon", 32, 32);
    var_09.icon.color = (0, 1, 0.976);
    var_09.icon.alpha = 1;
    var_09.icon setwaypoint(1, 1, 0);
    var_09.icon settargetent(var_09);
    var_0A = distance2dsquared(level.player.origin, var_09.origin);
    for(;;) {
      if(distance2dsquared(level.player.origin, var_09.origin) < squared(75) || distance2dsquared(level.player.origin, var_09.origin) > var_0A * 2.5) {
        break;
      }

      wait(0.05);
    }

    var_09.icon destroy();
    var_09 delete();
    level.player.var_9963 = undefined;
    return;
  }

  level.player notify("dismiss_skipped");
  level.player.var_9951 = undefined;
}

func_12EE() {
  level notify("stopstop_intel_waypoint_int");
  level endon("stop_intel_waypoint");
  self.var_9963 = undefined;
  self notifyonplayercommand("set_waypoint", "+weapnext");
  self waittill("set_waypoint");
  self.var_9963 = 1;
}

func_12ED() {
  self endon("dismiss_skipped");
  self notifyonplayercommand("intel_dismiss", "+gostand");
  self notifyonplayercommand("intel_dismiss", "+activate");
  self notifyonplayercommand("intel_dismiss", "+usereload");
  self waittill("intel_dismiss");
  self.var_9951 = 1;
}

func_9674() {
  var_00 = getEntArray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::array_thread(var_00, ::func_B2FC);
}

func_B2FC() {
  if(isDefined(self.var_EDA0)) {
    scripts\engine\utility::flag_init(self.var_EDA0);
  }

  if(isDefined(self.var_ED48)) {
    scripts\engine\utility::flag_init(self.var_ED48);
  }

  if(isDefined(self.script_rotation_speed)) {
    self.var_10BA1 = self.angles;
    if(!isDefined(self.script_rotation_max)) {
      self.script_rotation_max = (0, 0, 0);
    }

    self.var_E746 = [];
    for(var_00 = 0; var_00 < 3; var_00++) {
      if(self.script_rotation_max[var_00] != 0) {
        if(self.script_rotation_speed[var_00] > 0) {
          self.var_E746[var_00] = scripts\sp\math::func_10AB0(self.script_rotation_speed[var_00] * 10, 0, self.var_10BA1[var_00] + self.script_rotation_max[var_00], 0);
          continue;
        }
      }
    }

    thread func_E702();
  }

  if(isDefined(self.var_EEEA)) {
    self.var_10CCA = self.origin;
    if(!isDefined(self.var_EEE9)) {
      self.var_EEE9 = (0, 0, 0);
    }

    self.var_12689 = [];
    for(var_00 = 0; var_00 < 3; var_00++) {
      if(self.var_EEE9[var_00] != 0) {
        if(self.var_EEEA[var_00] > 0) {
          self.var_12689[var_00] = scripts\sp\math::func_10AB0(self.var_EEEA[var_00] * 10, 0, self.var_10CCA[var_00] + self.var_EEE9[var_00], 0);
          continue;
        }
      }
    }

    thread func_12686();
  }

  thread func_B2FB();
  thread func_B2FA();
}

func_12686() {
  self endon("death");
  self endon("stop_manipulate_ent");
  if(isDefined(self.var_EDA0)) {
    scripts\engine\utility::flag_wait(self.var_EDA0);
  }

  for(;;) {
    var_00 = [];
    for(var_01 = 0; var_01 < 3; var_01++) {
      if(self.var_EEEA[var_01] == 0) {
        var_00[var_01] = self.var_10CCA[var_01];
        continue;
      }

      if(self.var_EEEA[var_01] != 0 && self.var_EEE9[var_01] == 0) {
        var_00[var_01] = self.origin[var_01] + self.var_EEEA[var_01] / 20;
        continue;
      }

      if(self.var_EEEA[var_01] > 0 && self.var_EEE9[var_01] != 0) {
        var_00[var_01] = scripts\sp\math::func_10AB4(self.var_12689[var_01], self.var_10CCA[var_01]);
      }
    }

    self.origin = (var_00[0], var_00[1], var_00[2]);
    scripts\engine\utility::waitframe();
  }
}

func_E702() {
  self endon("death");
  self endon("stop_manipulate_ent");
  if(isDefined(self.var_EDA0)) {
    scripts\engine\utility::flag_wait(self.var_EDA0);
  }

  for(;;) {
    var_00 = [];
    for(var_01 = 0; var_01 < 3; var_01++) {
      if(self.script_rotation_speed[var_01] == 0) {
        var_00[var_01] = self.var_10BA1[var_01];
        continue;
      }

      if(self.script_rotation_speed[var_01] != 0 && self.script_rotation_max[var_01] == 0) {
        var_00[var_01] = self.angles[var_01] + self.script_rotation_speed[var_01] / 20;
        continue;
      }

      if(self.script_rotation_speed[var_01] > 0 && self.script_rotation_max[var_01] != 0) {
        var_00[var_01] = scripts\sp\math::func_10AB4(self.var_E746[var_01], self.var_10BA1[var_01]);
      }
    }

    self.angles = (var_00[0], var_00[1], var_00[2]);
    scripts\engine\utility::waitframe();
  }
}

func_B2FB() {
  self endon("death");
  if(isDefined(self.var_ED48)) {
    scripts\engine\utility::flag_wait(self.var_ED48);
    if(isDefined(self.var_ED54) && self.var_ED54) {
      self delete();
      return;
    }

    self notify("stop_manipulate_ent");
  }
}

func_B2FA() {
  scripts\engine\utility::waittill_either("death", "stop_manipulate_ent");
  if(isDefined(self.var_E746)) {
    foreach(var_01 in self.var_E746) {
      scripts\sp\math::func_10AAA(var_01);
    }
  }

  if(isDefined(self.var_12689)) {
    foreach(var_01 in self.var_12689) {
      scripts\sp\math::func_10AAA(var_01);
    }
  }
}

func_9DB4(param_00) {
  if(isDefined(self.var_E2) && self.var_E2 != "alt_none" && self.var_E2 != "none" && getweaponbasename(self.var_E2) == param_00) {
    return 1;
  }

  return 0;
}

func_9FFE(param_00) {
  var_01 = getweaponattachments(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  foreach(var_03 in var_01) {
    if(issubstr(var_03, "epic")) {
      return 1;
    }
  }

  return 0;
}

strip_suffix(param_00, param_01) {
  if(param_00.size <= param_01.size) {
    return param_00;
  }

  if(getsubstr(param_00, param_00.size - param_01.size, param_00.size) == param_01) {
    return getsubstr(param_00, 0, param_00.size - param_01.size);
  }

  return param_00;
}

func_F398(param_00, param_01) {
  self.exception[param_00] = param_01;
}

func_F2A4(param_00) {
  var_01 = getarraykeys(self.exception);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    self.exception[var_01[var_02]] = param_00;
  }
}

waittill_multiple_ents(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  var_08 = spawnStruct();
  var_08.threads = 0;
  if(isDefined(param_00)) {
    param_00 childthread scripts\engine\utility::waittill_string(param_01, var_08);
    var_08.threads++;
  }

  if(isDefined(param_02)) {
    param_02 childthread scripts\engine\utility::waittill_string(param_03, var_08);
    var_08.threads++;
  }

  if(isDefined(param_04)) {
    param_04 childthread scripts\engine\utility::waittill_string(param_05, var_08);
    var_08.threads++;
  }

  if(isDefined(param_06)) {
    param_06 childthread scripts\engine\utility::waittill_string(param_07, var_08);
    var_08.threads++;
  }

  while(var_08.threads) {
    var_08 waittill("returned");
    var_08.threads--;
  }

  var_08 notify("die");
}

func_7A8F() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();
    foreach(var_03 in var_01) {
      var_04 = getEntArray(var_03, "script_linkname");
      if(var_04.size > 0) {
        var_00 = scripts\engine\utility::array_combine(var_00, var_04);
      }
    }
  }

  return var_00;
}

func_7A9A() {
  var_00 = [];
  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();
    foreach(var_03 in var_01) {
      var_04 = getvehiclenodearray(var_03, "script_linkname");
      if(var_04.size > 0) {
        var_00 = scripts\engine\utility::array_combine(var_00, var_04);
      }
    }
  }

  return var_00;
}

func_7A8E() {
  var_00 = func_7A8F();
  return var_00[0];
}

func_E820(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, "targetname");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  if(isDefined(level._meth_8134)) {
    var_06 = [[level._meth_8134]](param_00);
    foreach(var_08 in var_06) {
      if(isnonentspawner(var_08)) {
        scripts\engine\utility::array_thread([var_08], param_01, param_02, param_03, param_04);
      }
    }
  }

  var_05 = scripts\engine\utility::getstructarray(param_00, "targetname");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  var_05 = [
    [level.getnodearrayfunction]
  ](param_00, "targetname");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  var_05 = getvehiclenodearray(param_00, "targetname");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
}

func_E81F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getEntArray(param_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  if(isDefined(level._meth_8134)) {
    var_06 = [[level._meth_8134]]();
    foreach(var_08 in var_06) {
      if(isDefined(var_08.script_noteworthy) && var_08.script_noteworthy == param_00 && isnonentspawner(var_08)) {
        scripts\engine\utility::array_thread([var_08], param_01, param_02, param_03, param_04);
      }
    }
  }

  var_05 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  var_05 = [
    [level.getnodearrayfunction]
  ](param_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
  var_05 = getvehiclenodearray(param_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, param_01, param_02, param_03, param_04);
}

func_7B27(param_00) {
  var_01 = getent(param_00, "script_noteworthy");
  if(isDefined(var_01)) {
    return var_01;
  }

  if(scripts\engine\utility::issp()) {
    var_01 = [[level.getnodefunction]](param_00, "script_noteworthy");
    if(isDefined(var_01)) {
      return var_01;
    }
  }

  var_01 = scripts\engine\utility::getstruct(param_00, "script_noteworthy");
  if(isDefined(var_01)) {
    return var_01;
  }

  var_01 = getvehiclenode(param_00, "script_noteworthy");
  if(isDefined(var_01)) {
    return var_01;
  }
}

func_9C39(param_00) {
  var_01 = level.lock[param_00];
  return var_01.var_C1 > var_01.max_count;
}

func_12BDD(param_00) {
  thread scripts\engine\utility::unlock_thread(param_00);
  wait(0.05);
}

func_7EB4(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 500000;
  }

  var_03 = 0;
  var_04 = undefined;
  foreach(var_06 in param_01) {
    var_07 = distance(var_06.origin, param_00);
    if(var_07 <= var_03 || var_07 >= param_02) {
      continue;
    }

    var_03 = var_07;
    var_04 = var_06;
  }

  return var_04;
}

func_22C1(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size - 1; var_02++) {
    for(var_03 = var_02 + 1; var_03 < param_00.size; var_03++) {
      if(param_00[var_03][
          [param_01]
        ]() < param_00[var_02][
          [param_01]
        ]()) {
        var_04 = param_00[var_03];
        param_00[var_03] = param_00[var_02];
        param_00[var_02] = var_04;
      }
    }
  }

  return param_00;
}

func_965C() {
  if(isDefined(level.script)) {
    return;
  }

  level.script = tolower(getdvar("mapname"));
}

func_93A6() {
  if(getdvarint("g_specialistMode")) {
    return 1;
  }

  return 0;
}

func_93AB() {
  if(getdvarint("g_yoloMode")) {
    return 1;
  }

  return 0;
}

func_B979(param_00, param_01) {
  param_00 waittill("trigger", var_02);
  level.player getrawbaseweaponname(0.1, 0.1);
  level.player scripts\engine\utility::allow_ads(0);
  while(!level.player isonground()) {
    wait(0.05);
  }

  var_03 = level.player getstance();
  if(var_03 != param_01) {
    level.player setstance(param_01);
    if(var_03 == "prone") {
      wait(0.2);
    }
  }

  level.player _meth_80A6();
  level.player scripts\engine\utility::allow_ads(1);
  return var_02;
}

func_19FA(param_00, param_01, param_02, param_03, param_04) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");
  if(!param_03) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait(0.05);
    }
  }

  self.var_72BD = self.var_394;
  if(isDefined(param_04)) {
    if(self.var_394 != param_04) {
      func_192C(self.var_394);
    }

    self.var_72BA = self.var_C828;
    func_72EC(param_04, "primary");
    self.var_13CAE = 1;
    return;
  }

  func_72EC(param_01, "primary");
  func_192C(param_00);
  self.var_72BB = param_00;
  self.var_72BC = param_01;
  self.var_42AE = param_02;
  self.var_72BA = self.var_72BC;
}

func_4125(param_00, param_01, param_02) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");
  if(!param_01) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait(0.05);
    }
  }

  if(isDefined(param_02)) {
    if(isDefined(self.var_13C4D) && self.var_13C4D.model == getweaponmodel(param_02)) {
      self.var_13C4D delete();
    }

    func_CC06(param_02, "right");
  } else {
    func_CC06(self.var_72BD, "right");
  }

  if(isDefined(self.var_13C4D) && param_00) {
    self.var_13C4D delete();
  }

  self.var_72BA = undefined;
  self.var_13CAE = 0;
}

func_192C(param_00) {
  self.var_13C4D = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self.var_13C4D setModel(getweaponmodel(param_00));
  self.var_13C4D notsolid();
  self.var_13C4D.angles = self gettagangles("tag_stowed_back");
  self.var_13C4D linkto(self, "tag_stowed_back");
}

func_46AD(param_00, param_01) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", param_01);
  setomnvar("ui_countdown_timer", gettime() + param_00 * 1000);
  wait(param_00);
  level notify(param_01);
  wait(5);
  setomnvar("ui_countdown_timer", 0);
}

func_46AB() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

func_F44E(param_00) {
  level.var_C086 = !param_00;
}

func_ABD9() {
  return !level.var_C086;
}

func_CE10(param_00, param_01, param_02) {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(param_00);
  thread scripts\sp\gameskill::func_E080();
  func_E006();
  if(func_93A6()) {
    scripts\sp\specialist_MAYBE::hide_helmet_impacts();
  }

  level.player scripts\engine\utility::allow_weapon(0);
  level.player freezecontrols(1);
  level.player getrankinfoxpamt();
  level.player _meth_8475();
  level.player _meth_8559(0);
  setomnvar("ui_hide_hud", 1);
  level.player func_1C3E(0);
  setomnvar("ui_hide_weapon_info", 1);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  thread func_3F71(param_01);
  if(isDefined(param_02)) {
    func_3F72(param_02);
    if(func_93A6()) {
      scripts\sp\specialist_MAYBE::show_helmet_impacts();
    }

    level.player scripts\engine\utility::allow_weapon(1);
    level.player _meth_80A1();
    level.player freezecontrols(0);
    level.player _meth_8475();
    level.player _meth_8559(1);
    level.player thread scripts\sp\gameskill::func_8CBA();
    setomnvar("ui_hide_hud", 0);
    level.player func_1C3E(1);
    setomnvar("ui_hide_weapon_info", 0);
    level notify("skippable_cinematic_done");
    while(iscinematicplaying()) {
      scripts\engine\utility::waitframe();
    }

    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "0");
    setomnvar("ui_is_bink_skippable", 0);
    stopcinematicingame();
    return;
  }

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "0");
  setomnvar("ui_is_bink_skippable", 0);
  stopcinematicingame();
  if(func_93A6()) {
    scripts\sp\specialist_MAYBE::show_helmet_impacts();
  }

  level.player scripts\engine\utility::allow_weapon(1);
  level.player _meth_80A1();
  level.player freezecontrols(0);
  level.player _meth_8475();
  level.player _meth_8559(1);
  level.player thread scripts\sp\gameskill::func_8CBA();
  setomnvar("ui_hide_hud", 0);
  level.player func_1C3E(1);
  setomnvar("ui_hide_weapon_info", 0);
  level notify("skippable_cinematic_done");
}

func_3F71(param_00) {
  level endon("skippable_cinematic_done");
  if(isDefined(param_00)) {
    self waittill(param_00);
  }

  setomnvar("ui_is_bink_skippable", 1);
  for(;;) {
    level.player waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "skip_bink_input") {
      level notify("cinematic_skipped");
      stopcinematicingame();
      break;
    }
  }
}

func_3F72(param_00) {
  level endon("cinematic_skipped");
  param_00 = param_00 * 1000;
  for(;;) {
    var_01 = cinematicgettimeinmsec();
    if(var_01 >= param_00) {
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

func_93AC() {
  return level.player func_65DF("zero_gravity") && level.player func_65DB("zero_gravity");
}

func_E006(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
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
    param_03 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  if(param_00) {
    thread lib_0E26::func_DFC1();
  }

  if(param_01) {
    thread lib_0E25::func_DFBE();
  }

  if(param_02) {
    thread lib_0E21::func_DFBA();
  }

  if(param_03) {
    thread scripts\sp\coverwall::func_DFBD();
  }

  if(param_04) {
    thread scripts\sp\detonategrenades::func_DFBF();
  }

  if(param_05) {
    thread lib_0E2D::func_5139();
  }

  if(param_06) {
    thread lib_0E2D::func_A5B9();
  }
}

func_F6FE(param_00) {
  self.var_6A8B = param_00;
}

func_41AD(param_00) {
  self.var_6A8B = "asm";
  if(!isDefined(self.var_6B14) || !self.var_6B14) {
    lib_0A1E::func_2376();
  }
}

isfacialstateallowed(param_00) {
  if(!isai(self) && !isDefined(self.var_6B14) || !self.var_6B14) {
    return 0;
  }

  if(!isDefined(self.var_6A8B)) {
    self.var_6A8B = "asm";
  }

  var_01 = [];
  var_01["asm"] = 0;
  var_01["filler"] = 1;
  var_01["vignette"] = 2;
  if(var_01[param_00] >= var_01[self.var_6A8B]) {
    return 1;
  }

  return 0;
}

func_F708(param_00) {
  param_00 = max(param_00, 2);
  level.var_2A6F = param_00;
}

dyndof(param_00, param_01) {
  level notify("stop_dyndof");
  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
  }

  level.dyndof = scripts\sp\utility_code::create_dyndof();
  level thread scripts\sp\utility_code::dyndof_thread();
}

dyndof_farsettings(param_00, param_01, param_02) {
  if(isDefined(param_00)) {
    level.dyndof.farstart = param_00;
  }

  if(isDefined(param_01)) {
    level.dyndof.farend = param_01;
  }

  if(isDefined(param_02)) {
    level.dyndof.farblur = param_02;
  }
}

dyndof_disable() {
  level notify("stop_dyndof");
  scripts\sp\utility_code::destroy_dyndof();
  scripts\sp\art::func_583D(1);
}

isactorwallrunning() {
  if(isDefined(self.var_138BC)) {
    return 1;
  }

  return 0;
}