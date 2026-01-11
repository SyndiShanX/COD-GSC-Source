/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2961.gsc
***************************************/

func_7CCC(var_00) {
  var_01 = [];
  var_02 = _getnumparts(var_00);

  for(var_03 = 0; var_03 < var_02; var_3++) {
    var_1[var_1.size] = _getpartname(var_00, var_03);
  }

  return var_01;
}

func_77FF(var_00, var_01, var_02, var_03) {
  var_04 = [];

  if(var_1.size < 1) {
    return var_04;
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  var_02 = squared(var_02);

  foreach(var_06 in var_01) {
    if(!isalive(var_06) || !isDefined(var_06) || !var_03 && isDefined(var_6.a.func_58DA)) {
      continue;
    }
    if(distancesquared(var_6.origin, var_00) <= var_02) {
      var_4[var_4.size] = var_06;
    }
  }

  return var_04;
}

func_BD6B(var_00, var_01) {
  var_00 = var_00 * 17.6;
  var_02 = var_01 / var_00;
  return var_02;
}

func_F40A(var_00, var_01, var_02) {
  var_03 = undefined;
  var_00 = tolower(var_00);
  var_4["friendly"] = 3;
  var_4["enemy"] = 1;
  var_4["objective"] = 5;
  var_4["neutral"] = 0;
  var_03 = var_4[var_00];
  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, 1);
  func_9196(var_03, var_01, var_02);
}

func_45F8(var_00, var_01) {
  var_02 = "";

  if(var_00 < 0) {
    var_02 = var_02 + "-";
  }

  var_00 = func_E753(var_00, 1, 0);
  var_03 = var_00 * 100;
  var_03 = int(var_03);
  var_03 = abs(var_03);
  var_04 = var_03 / 6000;
  var_04 = int(var_04);
  var_02 = var_02 + var_04;
  var_05 = var_03 / 100;
  var_05 = int(var_05);
  var_05 = var_05 - var_04 * 60;

  if(var_05 < 10) {
    var_02 = var_02 + (":0" + var_05);
  } else {
    var_02 = var_02 + (":" + var_05);
  }

  if(isDefined(var_01) && var_01) {
    var_06 = var_03;
    var_06 = var_06 - var_04 * 6000;
    var_06 = var_06 - var_05 * 100;
    var_06 = int(var_06 / 10);
    var_02 = var_02 + ("." + var_06);
  }

  return var_02;
}

func_E753(var_00, var_01, var_02) {
  var_01 = int(var_01);

  if(var_01 < 0 || var_01 > 4) {
    return var_00;
  }

  var_03 = 1;

  for(var_04 = 1; var_04 <= var_01; var_4++) {
    var_03 = var_03 * 10;
  }

  var_05 = var_00 * var_03;

  if(!isDefined(var_02) || var_02) {
    var_05 = floor(var_05);
  } else {
    var_05 = ceil(var_05);
  }

  var_00 = var_05 / var_03;
  return var_00;
}

func_E754(var_00, var_01, var_02) {
  var_03 = var_00 / 1000;
  var_03 = func_E753(var_03, var_01, var_02);
  var_00 = var_03 * 1000;
  return int(var_00);
}

func_111DA(var_00, var_01, var_02) {
  var_02 = int(var_02 * 20);
  var_03 = [];

  for(var_04 = 0; var_04 < 3; var_4++) {
    var_3[var_04] = (var_0[var_04] - var_1[var_04]) / var_02;
  }

  var_05 = [];

  for(var_04 = 0; var_04 < var_02; var_4++) {
    wait 0.05;

    for(var_06 = 0; var_06 < 3; var_6++) {
      var_5[var_06] = var_0[var_06] - var_3[var_06] * var_04;
    }

    _setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  _setsunlight(var_1[0], var_1[1], var_1[2]);
}

func_65E3(var_00) {
  while(isDefined(self) && !self.func_65DB[var_00]) {
    self waittill(var_00);
  }
}

func_65E7(var_00) {
  while(isDefined(self) && !self.func_65DB[var_00]) {
    self waittill(var_00);
  }
}

func_65E4(var_00, var_01) {
  while(isDefined(self)) {
    if(func_65DB(var_00)) {
      return;
    }
    if(func_65DB(var_01)) {
      return;
    }
    scripts\engine\utility::waittill_either(var_00, var_01);
  }
}

func_65E6(var_00, var_01) {
  var_02 = gettime();

  while(isDefined(self)) {
    if(self.func_65DB[var_00]) {
      break;
    }
    if(gettime() >= var_02 + var_01 * 1000) {
      break;
    }
    scripts\sp\utility_code::func_65FA(var_00, var_01);
  }
}

func_65E8(var_00) {
  while(isDefined(self) && self.func_65DB[var_00]) {
    self waittill(var_00);
  }
}

func_65DC(var_00) {}

func_65E9(var_00, var_01) {
  while(isDefined(self)) {
    if(!func_65DB(var_00)) {
      return;
    }
    if(!func_65DB(var_01)) {
      return;
    }
    scripts\engine\utility::waittill_either(var_00, var_01);
  }
}

func_65E0(var_00) {
  if(!isDefined(self.func_65DB)) {
    self.func_65DB = [];
    self.func_65EA = [];
  }

  self.func_65DB[var_00] = 0;
}

func_65DF(var_00) {
  if(isDefined(self.func_65DB) && isDefined(self.func_65DB[var_00])) {
    return 1;
  }

  return 0;
}

func_65E2(var_00, var_01) {
  self endon("death");
  wait(var_01);
  func_65E1(var_00);
}

func_65E1(var_00) {
  self.func_65DB[var_00] = 1;
  self notify(var_00);
}

func_65DD(var_00, var_01) {
  if(self.func_65DB[var_00]) {
    self.func_65DB[var_00] = 0;
    self notify(var_00);
  }

  if(isDefined(var_01) && var_01) {
    self.func_65DB[var_00] = undefined;
  }
}

func_65DE(var_00, var_01) {
  wait(var_01);

  if(isDefined(self)) {
    func_65DD(var_00);
  }
}

func_65DB(var_00) {
  return self.func_65DB[var_00];
}

func_78C8(var_00, var_01, var_02, var_03) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = level.player;
  }

  if(!isDefined(var_03)) {
    var_03 = -1;
  }

  var_04 = var_1.origin;

  if(isDefined(var_02) && var_02) {
    var_04 = var_01 getEye();
  }

  var_05 = undefined;
  var_06 = var_01 getplayerangles();
  var_07 = anglesToForward(var_06);
  var_08 = -1;

  foreach(var_10 in var_00) {
    var_11 = vectortoangles(var_10.origin - var_04);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_07, var_12);

    if(var_13 < var_08) {
      continue;
    }
    if(var_13 < var_03) {
      continue;
    }
    var_08 = var_13;
    var_05 = var_10;
  }

  return var_05;
}

func_78B9(var_00, var_01, var_02) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = level.player;
  }

  var_03 = var_1.origin;

  if(isDefined(var_02) && var_02) {
    var_03 = var_01 getEye();
  }

  var_04 = undefined;
  var_05 = var_01 getplayerangles();
  var_06 = anglesToForward(var_05);
  var_07 = -1;

  for(var_08 = 0; var_08 < var_0.size; var_8++) {
    var_09 = vectortoangles(var_0[var_08].origin - var_03);
    var_10 = anglesToForward(var_09);
    var_11 = vectordot(var_06, var_10);

    if(var_11 < var_07) {
      continue;
    }
    var_07 = var_11;
    var_04 = var_08;
  }

  return var_04;
}

func_6E49(var_00, var_01, var_02) {
  scripts\engine\utility::flag_init(var_00);

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_01 thread scripts\sp\utility_code::func_1287(var_00, var_02);
  return var_01;
}

func_6E4A(var_00, var_01, var_02) {
  scripts\engine\utility::flag_init(var_00);

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    var_1[var_03] thread scripts\sp\utility_code::func_1287(var_00, 0);
  }

  return var_01;
}

func_6E2B(var_00, var_01) {
  wait(var_01);
  scripts\engine\utility::flag_clear(var_00);
}

func_ABD2() {
  if(level.func_B8D0) {
    return;
  }
  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }
  for(var_00 = 0; var_00 < level.players.size; var_0++) {
    var_01 = level.players[var_00];

    if(!isalive(var_01)) {
      return;
    }
  }

  scripts\engine\utility::flag_set("game_saving");
  var_02 = "levelshots / autosave / autosave_" + level.script + "end";
  _savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_02, 1);
  scripts\engine\utility::flag_clear("game_saving");
}

func_16D5(var_00, var_01, var_02) {
  level.func_2668.func_6A42[var_00] = [];
  level.func_2668.func_6A42[var_00]["func"] = var_01;
  level.func_2668.func_6A42[var_00]["msg"] = var_02;
}

func_E00D(var_00) {
  level.func_2668.func_6A42[var_00] = undefined;
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

func_2669(var_00) {
  thread func_266B(var_00);
}

func_266A(var_00) {
  thread func_266B(var_00, undefined, undefined, 1);
}

func_266B(var_00, var_01, var_02, var_03) {
  if(!isDefined(level.func_4B18)) {
    level.func_4B18 = 1;
  }

  var_04 = "levelshots\autosave\autosave_" + level.script + level.func_4B18;
  var_05 = level scripts\sp\autosave::func_12891(level.func_4B18, "autosave", var_04, var_01, var_02, var_03);

  if(isDefined(var_05) && var_05) {
    level.func_4B18++;
  }
}

func_2672(var_00, var_01) {
  thread func_266B(var_00, var_01);
}

func_2673(var_00, var_01) {
  thread func_266B(var_00, var_01, undefined, 1);
}

func_4EF6(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02)) {
    var_02 = 5;
  }

  if(isDefined(var_03)) {
    var_03 endon("death");
    var_01 = var_3.origin;
  }

  for(var_04 = 0; var_04 < var_02 * 20; var_4++) {
    if(!isDefined(var_03)) {} else {}

    wait 0.05;
  }
}

func_4EF7(var_00, var_01) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_01)) {
    var_01 = 5;
  }

  for(var_02 = 0; var_02 < var_01 * 20; var_2++) {
    wait 0.05;
  }
}

func_4EF8(var_00, var_01, var_02, var_03) {
  if(isDefined(var_03)) {
    level notify(var_00 + var_03);
    level endon(var_00 + var_03);
  } else {
    level notify(var_00);
    level endon(var_00);
  }

  if(!isDefined(var_02)) {
    var_02 = 5;
  }

  for(var_04 = 0; var_04 < var_02 * 20; var_4++) {
    wait 0.05;
  }
}

func_4295(var_00, var_01) {
  return var_00 >= var_01;
}

func_7E33(var_00, var_01, var_02) {
  return scripts\sp\utility_code::func_4461(var_00, var_01, var_02, ::func_4295);
}

func_79B3(var_00, var_01) {
  if(var_1.size < 1) {
    return;
  }
  var_02 = distance(var_1[0] getorigin(), var_00);
  var_03 = var_1[0];

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    var_05 = distance(var_1[var_04] getorigin(), var_00);

    if(var_05 < var_02) {
      continue;
    }
    var_02 = var_05;
    var_03 = var_1[var_04];
  }

  return var_03;
}

func_7D80(var_00, var_01, var_02) {
  var_03 = [];

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    if(distance(var_1[var_04].origin, var_00) <= var_02) {
      var_3[var_3.size] = var_1[var_04];
    }
  }

  return var_03;
}

func_7B5C(var_00, var_01, var_02) {
  var_03 = [];

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    if(distance(var_1[var_04].origin, var_00) > var_02) {
      var_3[var_3.size] = var_1[var_04];
    }
  }

  return var_03;
}

func_78BB(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 9999999;
  }

  if(var_1.size < 1) {
    return;
  }
  var_03 = undefined;

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    if(!isalive(var_1[var_04])) {
      continue;
    }
    var_05 = distance(var_1[var_04].origin, var_00);

    if(var_05 >= var_02) {
      continue;
    }
    var_02 = var_05;
    var_03 = var_1[var_04];
  }

  return var_03;
}

func_7A05(var_00, var_01, var_02) {
  if(!var_2.size) {
    return;
  }
  var_03 = undefined;
  var_04 = vectortoangles(var_01 - var_00);
  var_05 = anglesToForward(var_04);
  var_06 = -1;

  foreach(var_08 in var_02) {
    var_04 = vectortoangles(var_8.origin - var_00);
    var_09 = anglesToForward(var_04);
    var_10 = vectordot(var_05, var_09);

    if(var_10 < var_06) {
      continue;
    }
    var_06 = var_10;
    var_03 = var_08;
  }

  return var_03;
}

func_78B8(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 9999999;
  }

  if(var_1.size < 1) {
    return;
  }
  var_03 = undefined;

  foreach(var_07, var_05 in var_01) {
    var_06 = distance(var_5.origin, var_00);

    if(var_06 >= var_02) {
      continue;
    }
    var_02 = var_06;
    var_03 = var_07;
  }

  return var_03;
}

func_78B5(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_03 = 0;

  if(isDefined(var_02) && var_2.size) {
    var_04 = [];

    for(var_05 = 0; var_05 < var_1.size; var_5++) {
      var_4[var_05] = 0;
    }

    for(var_05 = 0; var_05 < var_1.size; var_5++) {
      for(var_06 = 0; var_06 < var_2.size; var_6++) {
        if(var_1[var_05] == var_2[var_06]) {
          var_4[var_05] = 1;
        }
      }
    }

    var_07 = 0;

    for(var_05 = 0; var_05 < var_1.size; var_5++) {
      if(!var_4[var_05] && isDefined(var_1[var_05])) {
        var_07 = 1;
        var_03 = distance(var_00, var_1[var_05].origin);
        var_08 = var_05;
        var_05 = var_1.size + 1;
      }
    }

    if(!var_07) {
      return undefined;
    }
  } else {
    for(var_05 = 0; var_05 < var_1.size; var_5++) {
      if(isDefined(var_1[var_05])) {
        var_03 = distance(var_00, var_1[0].origin);
        var_08 = var_05;
        var_05 = var_1.size + 1;
      }
    }
  }

  var_08 = undefined;

  for(var_05 = 0; var_05 < var_1.size; var_5++) {
    if(isDefined(var_1[var_05])) {
      var_04 = 0;

      if(isDefined(var_02)) {
        for(var_06 = 0; var_06 < var_2.size; var_6++) {
          if(var_1[var_05] == var_2[var_06]) {
            var_04 = 1;
          }
        }
      }

      if(!var_04) {
        var_09 = distance(var_00, var_1[var_05].origin);

        if(var_09 <= var_03) {
          var_03 = var_09;
          var_08 = var_05;
        }
      }
    }
  }

  if(isDefined(var_08)) {
    return var_1[var_08];
  } else {
    return undefined;
  }
}

func_78AA(var_00, var_01, var_02) {
  if(isDefined(var_01)) {
    var_03 = _getaiarray(var_01);
  } else {
    var_03 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  if(isDefined(var_02)) {
    var_03 = scripts\engine\utility::array_remove_array(var_03, var_02);
  }

  return scripts\engine\utility::getclosest(var_00, var_03);
}

func_78AB(var_00, var_01, var_02) {
  if(isDefined(var_01)) {
    var_03 = _getaiarray(var_01);
  } else {
    var_03 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  return func_78B5(var_00, var_03, var_02);
}

func_7BDB(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03)) {
    var_03 = distance(var_00, var_01);
  }

  var_03 = max(0.01, var_03);
  var_04 = vectornormalize(var_01 - var_00);
  var_05 = var_02 - var_00;
  var_06 = vectordot(var_05, var_04);
  var_06 = var_06 / var_03;
  var_06 = clamp(var_06, 0, 1);
  return var_06;
}

func_3849(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(!func_D637(var_00)) {
    return 0;
  }

  if(!sighttracepassed(self getEye(), var_00, var_01, self)) {
    return 0;
  }

  return 1;
}

func_D637(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = anglesToForward(self.angles);
  var_02 = vectornormalize(var_00 - self.origin);
  var_03 = vectordot(var_01, var_02);
  return var_03 > 0.766;
}

func_1101B() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    if(isDefined(self.func_C3B0)) {
      self.attackeraccuracy = self.func_C3B0;
      self.func_C3B0 = undefined;
    } else
      self.attackeraccuracy = 1;
  }

  self.func_B14F = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

func_B14E() {}

func_B14F(var_00) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self.func_C3B0 = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
  }

  self notify("magic_bullet_shield");
  self.func_B14F = 1;
  self.damageshield = 1;
}

func_5550() {
  self.a.disablelongdeath = 1;
}

func_6215() {
  self.a.disablelongdeath = 0;
}

func_61DE() {
  self.func_10264 = undefined;
}

func_5508() {
  self.func_10264 = 1;
}

func_5131() {
  func_B14F(1);
}

func_7A31() {
  return self.ignoreme;
}

func_F416(var_00) {
  self.ignoreme = var_00;
}

func_F415(var_00) {
  self.ignoreall = var_00;
}

func_F39C(var_00) {
  self.favoriteenemy = var_00;
}

func_7B61() {
  return self.pacifist;
}

func_F4B2(var_00) {
  self.pacifist = var_00;
}

func_5151(var_00) {
  scripts\common\exploder::delete_exploder_proc(var_00);
}

func_8E80(var_00) {
  scripts\common\exploder::hide_exploder_models_proc(var_00);
}

func_100DA(var_00) {
  scripts\common\exploder::show_exploder_models_proc(var_00);
}

func_10FEC(var_00) {
  scripts\common\exploder::stop_exploder_proc(var_00);
}

func_79A6(var_00) {
  return scripts\common\exploder::get_exploder_array_proc(var_00);
}

func_6F54(var_00) {
  func_0B77::func_6F5A(var_00);
}

func_7267(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01)) {
    var_01 = 4;
  }

  thread func_7268(var_00, var_01, var_02, var_03);
}

func_C812() {
  if(isDefined(self.a.func_4C42)) {
    self.a.func_2274["crawl"] = self.a.func_4C42["crawl"];
    self.a.func_2274["death"] = self.a.func_4C42["death"];
    self.a.func_486A = self.a.func_4C42["blood_fx_rate"];

    if(isDefined(self.a.func_4C42["blood_fx"])) {
      self.a.func_4869 = self.a.func_4C42["blood_fx"];
    }
  }

  self.a.func_2274["stand_2_crawl"] = [];

  if(isDefined(self.func_C05D)) {
    self.a.pose = "prone";
  }

  self orientmode("face angle", self.a.func_7266);
  self.a.func_7266 = undefined;
}

func_7268(var_00, var_01, var_02, var_03) {
  self.func_72CC = 1;
  self.a.func_7280 = var_01;
  self.noragdoll = 1;
  self.func_C05D = var_03;
  self.a.func_4C42 = var_02;
  self.func_4875 = ::func_C812;
  self.maxhealth = 100000;
  self.health = 100000;
  func_6215();

  if(!isDefined(var_03) || var_03 == 0) {
    self.a.func_7266 = var_00 + 181.02;
  } else {
    self.a.func_7266 = var_00;
    thread scripts\anim\notetracks::notetrackposecrawl();
  }
}

func_19D3() {
  self.func_10265 = 1;
  func_54C6();
}

func_D463(var_00) {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  if(!isDefined(var_00)) {
    var_00 = 3;
  }

  func_E23C();
  childthread func_D464();

  for(;;) {
    if(self.unresolved_collision) {
      self.unresolved_collision = 0;

      if(self.func_12BE5 >= var_00) {
        if(isDefined(self.unresolved_collision_mover)) {
          var_01 = self.unresolved_collision_mover;

          if(isDefined(var_1.unresolved_collision_func)) {
            var_01[[var_1.unresolved_collision_func]](self);
          }
        }

        if(isDefined(self.func_8969)) {
          self[[self.func_8969]]();
        } else {
          func_502A();
        }
      }
    } else
      func_E23C();

    wait 0.05;
  }
}

func_D464() {
  for(;;) {
    self waittill("unresolved_collision", var_00);
    self.unresolved_collision = 1;
    self.func_12BE5++;
    self.unresolved_collision_mover = var_00;
  }
}

func_E23C() {
  self.unresolved_collision = 0;
  self.func_12BE5 = 0;
}

func_502A() {
  var_00 = getnodesinradiussorted(self.origin, 500, 0, 200, "Path");

  if(var_0.size) {
    self cancelmantle();
    self dontinterpolate();
    self setorigin(var_0[0].origin);
    func_E23C();
  } else {}
}

func_11032() {
  self notify("stop_unresolved_collision_script");
  func_E23C();
}

func_9BB2() {
  return issentient(self) && !isalive(self);
}

play_sound_on_tag(var_00, var_01, var_02, var_03, var_04) {
  if(func_9BB2()) {
    return;
  }
  var_05 = spawn("script_origin", self.origin);
  var_05 endon("death");
  thread scripts\sp\utility_code::func_517B(var_05, "sounddone");

  if(isDefined(var_01)) {
    var_05 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_05 linkto(self);
  }

  var_05 playSound(var_00, "sounddone");

  if(isDefined(var_02)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_05))) {
      var_05 stopsounds();
    }

    wait 0.05;
  } else
    var_05 waittill("sounddone");

  if(isDefined(var_03)) {
    self notify(var_03);
  }

  var_05 delete();
}

func_CE48(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(func_9BB2()) {
    return;
  }
  var_06 = spawn("script_origin", self.origin);
  var_06 endon("death");

  if(!isDefined(var_01)) {
    var_01 = "dirt";
  }

  thread scripts\sp\utility_code::func_517B(var_06, "sounddone");

  if(isDefined(var_02)) {
    var_06 linkto(self, var_02, (0, 0, 0), (0, 0, 0));
  } else {
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_06 linkto(self);
  }

  var_06 _meth_824E(var_00, var_01, "sounddone");

  if(isDefined(var_03)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_06))) {
      var_06 stopsounds();
    }

    wait 0.05;
  } else
    var_06 waittill("sounddone");

  if(isDefined(var_04)) {
    self notify(var_04);
  }

  var_06 delete();
}

func_CE32(var_00, var_01) {
  play_sound_on_tag(var_00, var_01, 1);
}

play_loop_sound_on_entity_with_pitch(var_00, var_01, var_02, var_03) {
  var_04 = spawn("script_origin", (0, 0, 0));
  var_04 endon("death");
  thread scripts\engine\utility::delete_on_death(var_04);

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  if(isDefined(var_01)) {
    var_4.origin = self.origin + var_01;
  } else {
    var_4.origin = self.origin;
  }

  var_4.angles = self.angles;
  var_04 linkto(self);
  var_04 playLoopSound(var_00);
  var_04 _meth_8277(var_02, var_03);
  self waittill("stop sound" + var_00);
  var_04 stoploopsound(var_00);
  var_04 delete();
}

play_sound_on_entity(var_00, var_01) {
  play_sound_on_tag(var_00, undefined, undefined, var_01);
}

play_loop_sound_on_tag(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawn("script_origin", (0, 0, 0));
  var_05 endon("death");

  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  if(var_02) {
    thread scripts\engine\utility::delete_on_death(var_05);
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  if(var_03) {
    thread func_5187(var_05);
  }

  if(isDefined(var_01)) {
    var_05 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  } else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_05 linkto(self);
  }

  var_05 playLoopSound(var_00);
  self waittill("stop sound" + var_00);

  if(isDefined(var_04)) {
    var_05 playSound(var_04, "sounddone");
    var_05 scripts\engine\utility::delaycall(0.15, ::stoploopsound, var_00);
    var_05 waittill("sounddone");
    var_05 delete();
  } else {
    var_05 stoploopsound(var_00);
    var_05 delete();
  }
}

func_5187(var_00) {
  var_00 endon("death");

  while(isDefined(self)) {
    wait 0.05;
  }

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_106ED(var_00) {
  if(!isalive(var_00)) {
    return 1;
  }

  if(!isDefined(var_0.func_6CDA)) {
    var_00 scripts\engine\utility::waittill_either("finished spawning", "death");
  }

  if(isalive(var_00)) {
    return 0;
  }

  return 1;
}

func_23B7(var_00) {
  if(isDefined(var_00)) {
    self.func_1FBB = var_00;
  }

  self glinton(level.func_EC87[self.func_1FBB]);
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

#using_animtree("c6");

func_23C2() {
  self glinton(#animtree);
}

#using_animtree("c8");

func_23C4() {
  self glinton(#animtree);
}

#using_animtree("c12");

func_23C5() {
  self glinton(#animtree);
}

#using_animtree("generic_human");

func_23CA() {
  self glinton(#animtree);
}

func_23CC() {
  if(isarray(level.func_EC8C[self.func_1FBB])) {
    var_00 = randomint(level.func_EC8C[self.func_1FBB].size);
    self setModel(level.func_EC8C[self.func_1FBB][var_00]);
  } else
    self setModel(level.func_EC8C[self.func_1FBB]);
}

func_10639(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    var_01 = (0, 0, 0);
  }

  var_03 = spawn("script_model", var_01);
  var_3.func_1FBB = var_00;
  var_03 func_23B7();
  var_03 func_23CC();

  if(isDefined(var_02)) {
    var_3.angles = var_02;
  }

  return var_03;
}

func_127AE(var_00, var_01) {
  var_02 = getent(var_00, var_01);

  if(!isDefined(var_02)) {
    return;
  }
  var_02 waittill("trigger", var_03);
  level notify(var_00, var_03);
  return var_03;
}

func_127B3(var_00) {
  return func_127AE(var_00, "targetname");
}

func_F3A1(var_00, var_01) {
  thread func_F3A5(var_00, var_01, ::func_13753, "set_flag_on_dead");
}

func_F3A3(var_00, var_01) {
  thread func_F3A5(var_00, var_01, ::func_13754, "set_flag_on_dead_or_dying");
}

empty_func(var_00) {
  return;
}

func_F3A8(var_00, var_01) {
  self waittill("spawned", var_02);

  if(func_106ED(var_02)) {
    return;
  }
  var_0.func_1912[var_0.func_1912.size] = var_02;
  func_65E1(var_01);
}

func_F3A5(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.func_1912 = [];

  foreach(var_07, var_06 in var_00) {
    var_06 func_65E0(var_03);
  }

  scripts\engine\utility::array_thread(var_00, ::func_F3A8, var_04, var_03);

  foreach(var_07, var_06 in var_00) {
    var_06 func_65E3(var_03);
  }

  [[var_02]](var_4.func_1912);
  scripts\engine\utility::flag_set(var_01);
}

func_F3AB(var_00, var_01) {
  if(!scripts\engine\utility::flag(var_01)) {
    var_00 waittill("trigger", var_02);
    scripts\engine\utility::flag_set(var_01);
    return var_02;
  }
}

func_F3AA(var_00) {
  if(scripts\engine\utility::flag(var_00)) {
    return;
  }
  var_01 = getent(var_00, "targetname");
  var_01 waittill("trigger");
  scripts\engine\utility::flag_set(var_00);
}

func_13753(var_00, var_01, var_02) {
  var_10 = spawnStruct();

  if(isDefined(var_02)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::func_13758(var_02);
  }

  var_10.count = var_0.size;

  if(isDefined(var_01) && var_01 < var_10.count) {
    var_10.count = var_01;
  }

  scripts\engine\utility::array_thread(var_00, scripts\sp\utility_code::func_13757, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

func_13754(var_00, var_01, var_02) {
  var_03 = [];

  foreach(var_05 in var_00) {
    if(isalive(var_05) && !var_5.ignoreforfixednodesafecheck) {
      var_3[var_3.size] = var_05;
    }
  }

  var_00 = var_03;
  var_07 = spawnStruct();

  if(isDefined(var_02)) {
    var_07 endon("thread_timed_out");
    var_07 thread scripts\sp\utility_code::func_13758(var_02);
  }

  var_7.count = var_0.size;

  if(isDefined(var_01) && var_01 < var_7.count) {
    var_7.count = var_01;
  }

  scripts\engine\utility::array_thread(var_00, scripts\sp\utility_code::func_13756, var_07);

  while(var_7.count > 0) {
    var_07 waittill("waittill_dead_guy_dead_or_dying");
  }
}

waittill_nonai_isnt_blocking_tank(var_00) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_00);
}

func_7A9D(var_00, var_01) {
  var_02 = func_7A9E(var_00, var_01);

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

func_7A9E(var_00, var_01) {
  var_02 = _getaispeciesarray("all", "all");
  var_03 = [];

  foreach(var_05 in var_02) {
    if(!isalive(var_05)) {
      continue;
    }
    switch (var_01) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_00) {
          var_3[var_3.size] = var_05;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_00) {
          var_3[var_3.size] = var_05;
        }

        break;
    }
  }

  return var_03;
}

func_7D40(var_00, var_01) {
  var_02 = func_7D43(var_00, var_01);

  if(!var_2.size) {
    return undefined;
  }

  return var_2[0];
}

func_7D43(var_00, var_01) {
  var_02 = getEntArray(var_00, var_01);
  var_03 = [];
  var_04 = [];

  foreach(var_06 in var_02) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_06;

    if(_isspawner(var_06)) {
      if(isDefined(var_6.func_A90E)) {
        var_4[0] = var_6.func_A90E;
        var_03 = func_22A2(var_03, var_04);
      }

      continue;
    }

    var_03 = func_22A2(var_03, var_04);
  }

  return var_03;
}

func_7A9F(var_00, var_01, var_02) {
  var_03 = func_7AA0(var_00, var_01, var_02);

  if(var_3.size > 1) {
    return undefined;
  }

  return var_3[0];
}

func_7AA0(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = "all";
  }

  var_03 = _getaispeciesarray("allies", var_02);
  var_03 = scripts\engine\utility::array_combine(var_03, _getaispeciesarray("axis", var_02));
  var_04 = [];

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    switch (var_01) {
      case "targetname":
        if(isDefined(var_3[var_05].targetname) && var_3[var_05].targetname == var_00) {
          var_4[var_4.size] = var_3[var_05];
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_05].script_noteworthy) && var_3[var_05].script_noteworthy == var_00) {
          var_4[var_4.size] = var_3[var_05];
        }

        break;
    }
  }

  return var_04;
}

func_76F4(var_00, var_01) {
  if(isDefined(level.func_76F3[var_00])) {
    if(level.func_76F3[var_00]) {
      wait 0.05;

      if(isalive(self)) {
        self notify("gather_delay_finished" + var_00 + var_01);
      }

      return;
    }

    level waittill(var_00);

    if(isalive(self)) {
      self notify("gather_delay_finished" + var_00 + var_01);
    }

    return;
  }

  level.func_76F3[var_00] = 0;
  wait(var_01);
  level.func_76F3[var_00] = 1;
  level notify(var_00);

  if(isalive(self)) {
    self notify("gather_delay_finished" + var_00 + var_01);
  }
}

func_76F3(var_00, var_01) {
  thread func_76F4(var_00, var_01);
  self waittill("gather_delay_finished" + var_00 + var_01);
}

func_7F79(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_0[var_03];
    var_05 = var_4.script_linkname;

    if(!isDefined(var_05)) {
      continue;
    }
    if(!isDefined(var_1[var_05])) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  return var_02;
}

func_22A2(var_00, var_01) {
  if(var_0.size == 0) {
    return var_01;
  }

  if(var_1.size == 0) {
    return var_00;
  }

  var_02 = var_00;

  foreach(var_04 in var_01) {
    var_05 = 0;

    foreach(var_07 in var_00) {
      if(var_07 == var_04) {
        var_05 = 1;
        break;
      }
    }

    if(var_05) {
      continue;
    } else {
      var_2[var_2.size] = var_04;
    }
  }

  return var_02;
}

func_2290(var_00, var_01) {
  var_02 = var_00;

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    if(scripts\engine\utility::array_contains(var_00, var_1[var_03])) {
      var_02 = scripts\engine\utility::array_remove(var_02, var_1[var_03]);
    }
  }

  return var_02;
}

array_compare(var_00, var_01) {
  if(var_0.size != var_1.size) {
    return 0;
  }

  foreach(var_05, var_03 in var_00) {
    if(!isDefined(var_1[var_05])) {
      return 0;
    }

    var_04 = var_1[var_05];

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

draw_line(var_00, var_01, var_02, var_03, var_04) {
  for(;;) {
    wait 0.05;
  }
}

func_5B51(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_05 = gettime() + var_05 * 1000;

  while(gettime() < var_05) {
    wait 0.05;

    if(!isDefined(var_01) || !isDefined(var_1.origin)) {
      return;
    }
  }
}

func_5B4C(var_00, var_01, var_02, var_03, var_04, var_05) {
  func_5B51(var_01, var_00, var_02, var_03, var_04, var_05);
}

func_5B4D(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("death");
  var_01 endon("death");
  var_05 = gettime() + var_05 * 1000;

  while(gettime() < var_05) {
    wait 0.05;
  }
}

func_5B4E(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_00 endon("death");
  var_01 endon("death");
  var_05 endon(var_06);

  for(;;) {
    wait 0.05;
  }
}

func_5B52(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_05 endon(var_06);

  for(;;) {
    scripts\engine\utility::draw_line_for_time(var_00, var_01, var_02, var_03, var_04, 0.05);
  }
}

func_5B4F(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_06 = gettime() + var_06 * 1000;
  var_01 = var_01 * var_02;

  while(gettime() < var_06) {
    wait 0.05;

    if(!isDefined(var_00) || !isDefined(var_0.origin)) {
      return;
    }
  }
}

draw_circle(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = 16;
  var_07 = 360 / var_06;
  var_08 = [];

  for(var_09 = 0; var_09 < var_06; var_9++) {
    var_10 = var_07 * var_09;
    var_11 = cos(var_10) * var_01;
    var_12 = sin(var_10) * var_01;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  for(var_09 = 0; var_09 < var_8.size; var_9++) {
    var_16 = var_8[var_09];

    if(var_09 + 1 >= var_8.size) {
      var_17 = var_8[0];
      continue;
    }

    var_17 = var_8[var_09 + 1];
  }
}

draw_circle_until_notify(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = 16;
  var_08 = 360 / var_07;
  var_09 = [];

  for(var_10 = 0; var_10 < var_07; var_10++) {
    var_11 = var_08 * var_10;
    var_12 = cos(var_11) * var_01;
    var_13 = sin(var_11) * var_01;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread draw_circle_lines_until_notify(var_09, var_02, var_03, var_04, var_05, var_06);
}

draw_circle_lines_until_notify(var_00, var_01, var_02, var_03, var_04, var_05) {
  for(var_06 = 0; var_06 < var_0.size; var_6++) {
    var_07 = var_0[var_06];

    if(var_06 + 1 >= var_0.size) {
      var_08 = var_0[0];
    } else {
      var_08 = var_0[var_06 + 1];
    }

    thread func_5B52(var_07, var_08, var_01, var_02, var_03, var_04, var_05);
  }
}

func_28D7(var_00) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter::func_29C1();

  if(isDefined(var_00)) {
    func_F2DC(var_00, 0);
    var_01 = _getaiarray(var_00);
  } else {
    foreach(var_00 in anim.func_115E7) {
      func_F2DC(var_00, 0);
    }

    var_01 = _getaiarray();
  }

  if(!isDefined(anim.func_3D4B) || !anim.func_3D4B) {
    return;
  }
  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    var_1[var_04].func_28CF = 0;
  }

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    var_05 = var_1[var_04];

    if(!isalive(var_05)) {
      continue;
    }
    if(!var_5.func_3D4B) {
      continue;
    }
    if(!var_5.func_9F6B) {
      continue;
    }
    var_05 scripts\sp\utility_code::func_1368E();
    anim.func_29B7 = 0;
  }

  var_06 = gettime() - anim.func_AA27["allies"];

  if(var_06 < 1500) {
    wait(var_06 / 1000);
  }

  if(isDefined(var_00)) {
    level notify(var_00 + " done speaking");
  } else {
    level notify("done speaking");
  }
}

func_28D8(var_00) {
  thread scripts\sp\utility_code::func_28D9(var_00);
}

func_F2DA(var_00) {
  if(!anim.func_3D4B) {
    return;
  }
  if(var_00) {
    if(isDefined(self.func_ED17) && !self.func_ED17 || isDefined(self.unittype) && self.unittype == "c8" || isDefined(self.unittype) && self.unittype == "c12" || isDefined(self.asmname) && self.asmname == "seeker") {
      self.func_28CF = 0;
    } else {
      self.func_28CF = 1;
    }
  } else {
    self.func_28CF = 0;

    if(isDefined(self.func_9F6B) && self.func_9F6B) {
      self waittill("done speaking");
    }
  }
}

func_F5C2(var_00, var_01) {
  if(!anim.func_3D4B) {
    return;
  }
  var_02 = getarraykeys(anim.func_46BD);
  var_03 = scripts\engine\utility::array_contains(var_02, var_01);

  if(!var_03) {
    return;
  }
  var_04 = _getaiarray(var_00);

  foreach(var_06 in var_04) {
    var_06 func_F292(var_01);
    scripts\engine\utility::waitframe();
  }
}

func_F292(var_00) {
  if(!anim.func_3D4B) {
    return;
  }
  var_01 = getarraykeys(anim.func_46BD);
  var_02 = scripts\engine\utility::array_contains(var_01, var_00);

  if(!var_02) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(isDefined(self.func_9F6B) && self.func_9F6B) {
    self waittill("done speaking");
    wait 0.1;
  }

  scripts\anim\battlechatter_ai::func_E11B();
  waittillframeend;
  self.voice = var_00;
  scripts\anim\battlechatter_ai::func_185D();
}

func_6EEB(var_00, var_01) {
  thread func_F3B0(1, var_00, var_01);
}

func_6EEA(var_00, var_01) {
  thread func_F3B0(0, var_00, var_01);
}

func_F3B0(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    var_01 = "allies";
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  } else {
    anim.func_C52F = 1;
  }

  while(!isDefined(anim.func_3D4B)) {
    wait 0.05;
  }

  if(!anim.func_3D4B) {
    return;
  }
  wait 1.5;
  level.func_6EE9[var_01] = var_00;
  var_03 = [];
  var_04 = [];

  if(isDefined(level.func_A056) && isDefined(level.func_A056.func_1630)) {
    if(!isDefined(level.func_D127) || anim.player != level.func_D127) {
      anim.player.func_C4B2 = 1;
    }

    var_04 = level.func_A056.func_1630;
    var_04 = scripts\engine\utility::array_removeundefined(var_04);

    foreach(var_06 in var_04) {
      if(isDefined(var_6.team) && var_6.team != "allies") {
        var_04 = scripts\engine\utility::array_remove(var_04, var_06);
      }

      if(isDefined(var_6.func_ED2D) && var_6.func_ED2D == "fake") {
        var_04 = scripts\engine\utility::array_remove(var_04, var_06);
      }
    }
  }

  if(!var_00) {
    if(isDefined(anim.func_C52F)) {
      anim.func_C52F = 0;
    }
  }

  var_03 = _getaiarray(var_01);
  var_03 = scripts\engine\utility::array_combine(var_03, var_04);
  scripts\engine\utility::array_thread(var_03, ::func_F3AF, var_00);
}

func_F3AF(var_00) {
  self.func_6EE9 = var_00;
}

func_7412() {
  var_00 = _getaiarray("allies");

  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 func_F3C0(0);
    }
  }

  level.func_7410 = 0;
}

func_7413() {
  var_00 = _getaiarray("allies");

  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 func_F3C0(1);
    }
  }

  level.func_7410 = 1;
}

func_F3C0(var_00) {
  if(var_00) {
    self.func_7411 = undefined;
  } else {
    self.func_7411 = 1;
  }
}

func_CF8D() {
  thread func_0E4E::func_CF8E();
}

func_CF8B() {
  thread func_0E4E::func_CF8C();
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
    wait 0.05;
  }
}

func_7A97() {
  var_00 = [];

  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();

    for(var_02 = 0; var_02 < var_1.size; var_2++) {
      var_03 = scripts\engine\utility::getstruct(var_1[var_02], "script_linkname");

      if(isDefined(var_03)) {
        var_0[var_0.size] = var_03;
      }
    }
  }

  return var_00;
}

func_7A96() {
  var_00 = func_7A97();

  if(!var_0.size) {
    return undefined;
  }

  return var_0[0];
}

func_7A6F(var_00) {
  var_01 = self;

  while(isDefined(var_1.target)) {
    wait 0.05;

    if(isDefined(var_1.target)) {
      switch (var_00) {
        case "vehiclenode":
          var_01 = getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_01 = getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_01 = getent(var_1.target, "targetname");
          break;
        case "struct":
          var_01 = scripts\engine\utility::getstruct(var_1.target, "targetname");
          break;
        default:
      }

      continue;
    }

    break;
  }

  var_02 = var_01;
  return var_02;
}

timeout(var_00) {
  self endon("death");
  wait(var_00);
  self notify("timeout");
}

func_F3BC() {
  if(isDefined(self.func_F3BB)) {
    return;
  }
  self.func_C3EC = self.pathenemyfightdist;
  self.func_C3F4 = self.pathenemylookahead;
  self.func_C3F5 = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.func_F3BB = 1;
}

func_12BFA() {
  if(!isDefined(self.func_F3BB)) {
    return;
  }
  self.pathenemyfightdist = self.func_C3EC;
  self.pathenemylookahead = self.func_C3F4;
  self.maxsightdistsqrd = self.func_C3F5;
  self.func_F3BB = undefined;
}

func_22BA(var_00) {
  var_01 = [];
  var_02 = getarraykeys(var_00);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];

    if(!isalive(var_0[var_04])) {
      continue;
    }
    var_1[var_04] = var_0[var_04];
  }

  return var_01;
}

func_22B9(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isalive(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

array_removedeadvehicles(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isalive(var_03)) {
      continue;
    }
    if(var_03 func_58DA()) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

array_remove_nokeys(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    if(var_0[var_03] != var_01) {
      var_2[var_2.size] = var_0[var_03];
    }
  }

  return var_02;
}

func_22B2(var_00, var_01) {
  var_02 = [];

  foreach(var_05, var_04 in var_00) {
    if(var_01 == var_05) {
      continue;
    }
    var_2[var_05] = var_04;
  }

  return var_02;
}

func_22B3(var_00, var_01) {
  if(var_1.size == 0) {
    return var_00;
  }

  var_02 = [];

  foreach(var_09, var_04 in var_00) {
    var_05 = 0;

    foreach(var_07 in var_01) {
      if(var_07 == var_09) {
        var_05 = 1;
        break;
      }
    }

    if(var_05) {
      continue;
    }
    var_2[var_09] = var_04;
  }

  return var_02;
}

array_remove_index(var_00, var_01) {
  for(var_02 = 0; var_02 < var_0.size - 1; var_2++) {
    if(var_02 == var_01) {
      var_0[var_02] = var_0[var_02 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_00;
}

func_22A4(var_00, var_01, var_02) {
  foreach(var_05, var_04 in var_00) {
    var_04 notify(var_01, var_02);
  }
}

func_1115A() {
  var_00 = spawnStruct();
  var_0.func_2274 = [];
  var_0.lastindex = 0;
  return var_00;
}

func_11161(var_00, var_01) {
  var_0.func_2274[var_0.lastindex] = var_01;
  var_1.func_11159 = var_0.lastindex;
  var_0.lastindex++;
}

func_11162(var_00, var_01) {
  func_11167(var_00, var_01);
  var_0.func_2274[var_0.lastindex - 1] = undefined;
  var_0.lastindex--;
}

func_11163(var_00, var_01) {
  if(isDefined(var_0.func_2274[var_0.lastindex - 1])) {
    var_0.func_2274[var_01] = var_0.func_2274[var_0.lastindex - 1];
    var_0.func_2274[var_01].func_11159 = var_01;
    var_0.func_2274[var_0.lastindex - 1] = undefined;
    var_0.lastindex = var_0.func_2274.size;
  } else {
    var_0.func_2274[var_01] = undefined;
    func_11164(var_00);
  }
}

func_11164(var_00) {
  var_01 = [];

  foreach(var_03 in var_0.func_2274) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  var_0.func_2274 = var_01;

  foreach(var_06, var_03 in var_0.func_2274) {
    var_3.func_11159 = var_06;
  }

  var_0.lastindex = var_0.func_2274.size;
}

func_11167(var_00, var_01) {
  var_00 scripts\sp\utility_code::func_11166(var_0.func_2274[var_0.lastindex - 1], var_01);
}

func_11165(var_00, var_01) {
  for(var_02 = 0; var_02 < var_01; var_2++) {
    var_00 scripts\sp\utility_code::func_11166(var_0.func_2274[var_02], var_0.func_2274[randomint(var_0.lastindex)]);
  }
}

func_4C39(var_00) {
  return scripts\anim\battlechatter_ai::func_4C3B(var_00);
}

func_7CAE(var_00, var_01) {
  var_02 = newhudelem();

  if(level.console) {
    var_2.x = 68;
    var_2.y = 35;
  } else {
    var_2.x = 58;
    var_2.y = 95;
  }

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "left";
  var_2.vertalign = "middle";

  if(isDefined(var_01)) {
    var_03 = var_01;
  } else {
    var_03 = level.func_6A04;
  }

  var_02 give_explosive_armor(var_03, var_00, "hudStopwatch", 64, 64);
  return var_02;
}

func_B8D1() {
  if(level.func_B8D0) {
    return;
  }
  if(isDefined(level.func_BF95)) {
    return;
  }
  if(func_93AB()) {
    level.player _meth_8591(1);
    _updategamerprofile();
    scripts\sp\endmission::func_41ED();
  }

  level.func_B8D0 = 1;
  scripts\engine\utility::flag_set("missionfailed");

  if(getdvar("failure_disabled") == "1") {
    return;
  }
  if(isDefined(level.func_B8BE)) {
    thread[[level.func_B8BE]]();
    return;
  }

  _missionfailed(func_93AB());
}

func_F487(var_00) {
  level.func_B8BE = var_00;
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

  if(isDefined(self.func_EF15)) {
    wait(self.func_EF15);

    if(isDefined(self.func_EF1A)) {
      self.func_EF15 = self.func_EF15 + self.func_EF1A;
    }
  } else if(isDefined(self.func_EF1C) && isDefined(self.func_EF1B)) {
    wait(randomfloatrange(self.func_EF1C, self.func_EF1B));

    if(isDefined(self.func_EF1A)) {
      self.func_EF1C = self.func_EF1C + self.func_EF1A;
      self.func_EF1B = self.func_EF1B + self.func_EF1A;
    }
  }

  return gettime() - var_00;
}

func_79C8(var_00, var_01) {
  var_02 = _getaiarray(var_00);
  var_03 = [];

  for(var_04 = 0; var_04 < var_2.size; var_4++) {
    var_05 = var_2[var_04];

    if(!isDefined(var_5.func_EDAD)) {
      continue;
    }
    if(var_5.func_EDAD != var_01) {
      continue;
    }
    var_3[var_3.size] = var_05;
  }

  return var_03;
}

get_all_force_color_friendlies() {
  var_00 = _getaiarray("allies");
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];

    if(!isDefined(var_3.func_EDAD)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

func_61C7() {
  if(isDefined(self.func_EDAD)) {
    return;
  }
  if(!isDefined(self.func_C3BE)) {
    return;
  }
  func_F3B5(self.func_C3BE);
  self.func_C3BE = undefined;
}

func_61C8() {
  self.func_5955 = 1;
  func_61C7();
}

func_54F7() {
  if(isDefined(self.func_BF06)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self getplayerheadmodel();

  if(!isDefined(self.func_EDAD)) {
    return;
  }
  self.func_C3BE = self.func_EDAD;
  level.func_22E0[scripts\sp\colors::func_7CE4()][self.func_EDAD] = ::scripts\engine\utility::array_remove(level.func_22E0[scripts\sp\colors::func_7CE4()][self.func_EDAD], self);
  scripts\sp\colors::func_AB3A();
  self.func_EDAD = undefined;
  self.func_4BDF = undefined;
}

func_414F() {
  func_54F7();
}

func_79C7() {
  var_00 = self.func_EDAD;
  return var_00;
}

func_FEEE(var_00) {
  return level.func_43A3[tolower(var_00)];
}

func_F3B5(var_00) {
  var_01 = func_FEEE(var_00);

  if(!isai(self)) {
    func_F3B7(var_01);
    return;
  }

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.func_ED34 = undefined;
  self.func_ED33 = undefined;
  self.func_C3BE = undefined;
  var_02 = scripts\sp\colors::func_7CE4();

  if(isDefined(self.func_EDAD)) {
    level.func_22E0[var_02][self.func_EDAD] = ::scripts\engine\utility::array_remove(level.func_22E0[var_02][self.func_EDAD], self);
  }

  self.func_EDAD = var_01;
  level.func_22E0[var_02][var_01] = func_22B9(level.func_22E0[var_02][var_01]);
  level.func_22E0[var_02][self.func_EDAD] = ::scripts\engine\utility::array_add(level.func_22E0[var_02][self.func_EDAD], self);
  thread scripts\sp\utility_code::func_BF01(var_01);
}

func_F3B7(var_00) {
  self.func_EDAD = var_00;
  self.func_C3BE = undefined;
}

func_6EDC(var_00) {
  var_01 = gettime() + var_00 * 1000;

  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

func_6ED8(var_00) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self _meth_80D0(0);
  wait(var_00 + 2);
  self _meth_80D0(1);
}

func_E2B0() {
  scripts\common\createfx::restart_fx_looper();
}

pauseexploder(var_00) {
  var_00 = var_00 + "";

  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 scripts\engine\utility::pauseeffect();
      }

      return;
    }
  } else {
    foreach(var_06 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_00) {
        continue;
      }
      var_06 scripts\engine\utility::pauseeffect();
    }
  }
}

func_E2B1(var_00) {
  var_00 = var_00 + "";

  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        var_03 func_E2B0();
      }

      return;
    }
  } else {
    foreach(var_06 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_00) {
        continue;
      }
      var_06 func_E2B0();
    }
  }
}

func_9326(var_00) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_00) {
    self.func_C3DE = self getthreatbiasgroup();
    var_01 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_02 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_03 = _getaiarray(var_2[self.team]);
    var_04 = [];

    for(var_05 = 0; var_05 < var_3.size; var_5++) {
      var_4[var_3[var_05] getthreatbiasgroup()] = 1;
    }

    var_06 = getarraykeys(var_04);

    for(var_05 = 0; var_05 < var_6.size; var_5++) {
      _setthreatbias(var_6[var_05], "ignore_everybody", 0);
    }
  } else {
    var_01 = undefined;

    if(self.func_C3DE != "") {
      self setthreatbiasgroup(self.func_C3DE);
    }

    self.func_C3DE = undefined;
  }
}

func_131CC() {
  scripts\sp\vehicle_code::func_13219();
}

func_13221() {
  thread scripts\sp\vehicle_paths::func_13222();
}

func_131FF(var_00) {
  scripts\sp\vehicle_code::func_13201(var_00);
}

func_13206(var_00) {
  scripts\sp\vehicle_code::func_13207(var_00);
}

func_131D5(var_00, var_01) {
  scripts\sp\vehicle::func_1321A(var_00, var_01);
}

func_864C(var_00, var_01) {
  if(isDefined(var_01)) {
    var_01 = var_01 * -100000;
  } else {
    var_01 = (0, 0, -100000);
  }

  return bulletTrace(var_00, var_00 + var_01, 0, self)["position"];
}

func_3C4A(var_00) {
  self.func_D0CE = self.func_D0CE + var_00;
  self notify("update_health_packets");

  if(self.func_D0CE >= 3) {
    self.func_D0CE = 3;
  }
}

maymovetopoint(var_00, var_01) {
  var_02 = melee(var_00, var_01);
  return var_2[0];
}

melee(var_00, var_01) {
  return scripts\sp\vehicle_code::func_12B8(var_00, var_01);
}

func_1749(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  scripts\sp\starts::func_174A();
  var_00 = tolower(var_00);
  var_07 = scripts\sp\starts::func_174B(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
  level.func_10C58[level.func_10C58.size] = var_07;
  level.func_10BA8[var_00] = var_07;
}

func_F343(var_00) {
  level.func_5019 = var_00;
}

func_F344(var_00) {
  level.func_501A = var_00;
}

func_13D91(var_00, var_01, var_02, var_03) {
  var_04 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_05 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_05, var_04) >= var_03;
}

func_7951(var_00, var_01, var_02) {
  var_03 = vectornormalize(var_02 - var_00);
  var_04 = anglesToForward(var_01);
  var_05 = vectordot(var_04, var_03);
  return var_05;
}

func_13D92(var_00, var_01) {
  var_02 = undefined;

  for(var_03 = 0; var_03 < level.players.size; var_3++) {
    var_04 = level.players[var_03] getEye();
    var_02 = scripts\engine\utility::within_fov(var_04, level.players[var_03] getplayerangles(), var_00, var_01);

    if(!var_02) {
      return 0;
    }
  }

  return 1;
}

func_135AF(var_00, var_01) {
  var_02 = var_01 * 1000 - (gettime() - var_00);
  var_02 = var_02 * 0.001;

  if(var_02 > 0) {
    wait(var_02);
  }
}

func_29C0() {
  anim.func_EF75 = gettime();
}

func_5480(var_00) {
  func_29C0();
  scripts\sp\anim::func_1F32(self, var_00);
}

func_7749(var_00, var_01) {
  func_29C0();
  scripts\sp\anim::func_1ECD(self, var_00, undefined, undefined, var_01);
}

func_DBEF(var_00, var_01) {
  if(!isDefined(level.func_D24D)) {
    var_02 = spawn("script_origin", (0, 0, 0));
    var_02 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.func_D24D = var_02;
  }

  func_29C0();
  var_03 = 0;

  if(!isDefined(var_01)) {
    var_03 = level.func_D24D func_74D7(::play_sound_on_tag, level.func_EC91[var_00], undefined, 1);
  } else {
    var_03 = level.func_D24D func_74DD(var_01, ::play_sound_on_tag, level.func_EC91[var_00], undefined, 1);
  }

  return var_03;
}

func_DBF2(var_00) {
  level.func_D24D play_sound_on_tag(level.func_EC91[var_00], undefined, 1);
}

func_DBF5() {
  if(!isDefined(level.func_D24D)) {
    return;
  }
  level.func_D24D delete();
}

func_DBF0() {
  if(!isDefined(level.func_D24D)) {
    return;
  }
  level.func_D24D func_74D9();
}

func_DBF1(var_00) {
  if(!isDefined(level.func_D24D)) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.func_D24D = var_01;
  }

  level.func_D24D play_sound_on_tag(level.func_EC91[var_00], undefined, 1);
}

func_DBF4(var_00) {
  return func_DBEF(var_00, 0.05);
}

func_10350(var_00, var_01) {
  scripts\sp\utility_code::func_1778(var_00);
  func_DBEF(var_00, var_01);
}

func_10352(var_00) {
  scripts\sp\utility_code::func_1778(var_00);
  func_DBF5();
  func_DBF1(var_00);
}

func_10353(var_00) {
  scripts\sp\utility_code::func_1778(var_00);
  func_DBF2(var_00);
}

func_D01B(var_00, var_01) {
  return func_D01E(var_00, 0, undefined, undefined, undefined, var_01);
}

func_1369(var_00, var_01, var_02, var_03, var_04) {
  if(func_9BB2()) {
    return;
  }
  var_05 = spawn("script_origin", (0, 0, 0));
  var_05 endon("death");
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_05 linkto(self);

  if(var_01 > 0) {
    var_05 scripts\engine\utility::delaycall(var_01, ::playsound, var_00, "sounddone");
  } else {
    var_05 playSound(var_00, "sounddone");
  }

  if(isDefined(var_02)) {
    if(isarray(var_02)) {
      for(var_06 = 0; var_06 < var_2.size; var_6++) {
        if(isDefined(var_04) && isDefined(var_4[var_06])) {
          level.player scripts\engine\utility::delaythread(var_3[var_06], ::func_D090, var_2[var_06], var_4[var_06]);
          continue;
        }

        level.player scripts\engine\utility::delaythread(var_3[var_06], ::func_D090, var_2[var_06]);
      }
    } else if(isDefined(var_04))
      level.player scripts\engine\utility::delaythread(var_03, ::func_D090, var_02, var_04);
    else {
      level.player scripts\engine\utility::delaythread(var_03, ::func_D090, var_02);
    }
  }

  if(var_01 > 0) {
    wait(var_01);
  }

  if(!isDefined(scripts\sp\utility_code::func_1362A(var_05, level.player))) {
    var_05 stopsounds();
  }

  wait 0.05;
  var_05 delete();
}

func_D01E(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(level.func_D01D)) {
    var_06 = spawn("script_origin", (0, 0, 0));
    var_06 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.func_D01D = var_06;
  }

  func_29C0();
  var_07 = 0;

  if(!isDefined(var_05)) {
    var_07 = level.func_D01D func_74D7(::func_1369, level.func_EC8E[var_00], var_01, var_02, var_03, var_04);
  } else {
    var_07 = level.func_D01D func_74DD(var_05, ::func_1369, level.func_EC8E[var_00], var_01, var_02, var_03, var_04);
  }

  return var_07;
}

func_D020() {
  if(!isDefined(level.func_D01D)) {
    return;
  }
  level.func_D01D delete();
}

func_D01C() {
  if(!isDefined(level.func_D01D)) {
    return;
  }
  level.func_D01D func_74D9();
}

func_D01F(var_00) {
  func_D020();

  if(!isDefined(level.func_D01D)) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.func_D01D = var_01;
  }

  level.func_D01D func_1369(level.func_EC8E[var_00], 0);
}

func_1034D(var_00, var_01) {
  scripts\sp\utility_code::func_1773(var_00);
  func_D01B(var_00, var_01);
}

func_1034F(var_00) {
  scripts\sp\utility_code::func_1773(var_00);
  func_D01F(var_00);
}

func_1034E(var_00, var_01, var_02, var_03, var_04, var_05) {
  scripts\sp\utility_code::func_1773(var_00);
  func_D01E(var_00, var_01, var_02, var_03, var_04, var_05);
}

func_10346(var_00) {
  scripts\sp\utility_code::func_175F(var_00);
  func_5480(var_00);
}

func_10347(var_00) {
  scripts\sp\utility_code::func_1760(var_00);
  func_7749(var_00);
}

func_DBF3(var_00) {
  func_DBEF(var_00);
}

string(var_00) {
  return "" + var_00;
}

func_9329(var_00, var_01) {
  setignoremegroup(var_00, var_01);
  setignoremegroup(var_01, var_00);
}

func_16E5(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [];
  var_5["function"] = var_01;
  var_5["param1"] = var_02;
  var_5["param2"] = var_03;
  var_5["param3"] = var_04;
  level.func_10707[var_00][level.func_10707[var_00].size] = var_05;
}

func_E031(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < level.func_10707[var_00].size; var_3++) {
    if(level.func_10707[var_00][var_03]["function"] != var_01) {
      var_2[var_2.size] = level.func_10707[var_00][var_03];
    }
  }

  level.func_10707[var_00] = var_02;
}

func_693E(var_00, var_01) {
  if(!isDefined(level.func_10707)) {
    return 0;
  }

  for(var_02 = 0; var_02 < level.func_10707[var_00].size; var_2++) {
    if(level.func_10707[var_00][var_02]["function"] == var_01) {
      return 1;
    }
  }

  return 0;
}

func_E08B(var_00) {
  var_01 = [];

  foreach(var_03 in self.func_10708) {
    if(var_3["function"] == var_00) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  self.func_10708 = var_01;
}

func_1747(var_00, var_01, var_02, var_03, var_04, var_05) {
  foreach(var_07 in self.func_10708) {
    if(var_7["function"] == var_00) {
      return;
    }
  }

  var_09 = [];
  var_9["function"] = var_00;
  var_9["param1"] = var_01;
  var_9["param2"] = var_02;
  var_9["param3"] = var_03;
  var_9["param4"] = var_04;
  var_9["param5"] = var_05;
  self.func_10708[self.func_10708.size] = var_09;
}

func_228A(var_00) {
  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    if(isDefined(var_0[var_01])) {
      var_0[var_01] delete();
    }
  }
}

func_229F(var_00) {
  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_0[var_01] _meth_81D0();
  }
}

func_931D(var_00) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var_00)) {
    wait(var_00);
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

func_15F5(var_00) {
  var_01 = getent(var_00, "targetname");
  var_01 func_15F1();
}

func_15F3(var_00) {
  var_01 = getent(var_00, "script_noteworthy");
  var_01 func_15F1();
}

func_5599(var_00) {
  var_01 = getent(var_00, "targetname");
  var_01 scripts\engine\utility::trigger_off();
}

func_5598(var_00) {
  var_01 = getent(var_00, "script_noteworthy");
  var_01 scripts\engine\utility::trigger_off();
}

func_624C(var_00) {
  var_01 = getent(var_00, "targetname");
  var_01 scripts\engine\utility::trigger_on();
}

func_624B(var_00) {
  var_01 = getent(var_00, "script_noteworthy");
  var_01 scripts\engine\utility::trigger_on();
}

func_77E1() {
  if(!isDefined(self.unique_id)) {
    func_F294();
  }

  return self.unique_id;
}

func_F294() {
  if(!isDefined(level.func_19C9)) {
    level.func_19C9 = 0;
  }

  self.unique_id = "ai" + level.func_19C9;
  level.func_19C9++;
}

func_F5C3(var_00, var_01) {
  var_02 = _getaiarray(var_00);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_2[var_03].pacifist = var_01;
  }
}

func_E198() {
  scripts\sp\colors::func_43AA();
}

func_107B3(var_00, var_01) {
  scripts\sp\colors::func_43AC(var_00, var_01);
}

func_F55D(var_00, var_01) {
  if(!isDefined(level.func_4B58)) {
    level.func_4B58 = [];
  }

  var_00 = func_FEEE(var_00);
  var_01 = func_FEEE(var_01);
  level.func_4B58[var_00] = var_01;

  if(!isDefined(level.func_4B58[var_01])) {
    func_F38A(var_01);
  }
}

func_F38A(var_00) {
  if(!isDefined(level.func_4B58)) {
    level.func_4B58 = [];
  }

  level.func_4B58[var_00] = "none";
}

func_DFEB(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isalive(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

func_DFDA(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_0[var_03];

    if(!isDefined(var_4.func_EDAD)) {
      continue;
    }
    if(var_4.func_EDAD == var_01) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  return var_02;
}

func_E05E(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_0[var_03];

    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == var_01) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  return var_02;
}

func_78AF(var_00, var_01) {
  var_02 = func_79C8("allies", var_00);

  if(!isDefined(var_01)) {
    var_03 = level.player.origin;
  } else {
    var_03 = var_01;
  }

  return scripts\engine\utility::getclosest(var_03, var_02);
}

func_E0AF(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_03].classname, var_01)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_03];
  }

  return var_02;
}

func_E0B0(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_03].model, var_01)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_03];
  }

  return var_02;
}

func_78B0(var_00, var_01, var_02) {
  var_03 = func_79C8("allies", var_00);

  if(!isDefined(var_02)) {
    var_04 = level.player.origin;
  } else {
    var_04 = var_02;
  }

  var_03 = func_E0AF(var_03, var_01);
  return scripts\engine\utility::getclosest(var_04, var_03);
}

func_DA6E(var_00, var_01) {
  for(;;) {
    var_02 = func_78AF(var_00);

    if(!isalive(var_02)) {
      wait 1;
      continue;
    }

    var_02 func_F3B5(var_01);
    return;
  }
}

func_9931(var_00, var_01) {
  for(;;) {
    var_02 = func_78AF(var_00);

    if(!isalive(var_02)) {
      return;
    }
    var_02 func_F3B5(var_01);
    return;
  }
}

func_9932(var_00, var_01, var_02) {
  for(;;) {
    var_03 = func_78B0(var_00, var_02);

    if(!isalive(var_03)) {
      return;
    }
    var_03 func_F3B5(var_01);
    return;
  }
}

func_DA6F(var_00, var_01, var_02) {
  for(;;) {
    var_03 = func_78B0(var_00, var_02);

    if(!isalive(var_03)) {
      wait 1;
      continue;
    }

    var_03 func_F3B5(var_01);
    return;
  }
}

riotshield_lock_orientation(var_00) {
  self orientmode("face angle", var_00);
  self.lockorientation = 1;
}

riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

func_9934(var_00, var_01, var_02) {
  var_03 = 0;
  var_04 = [];

  for(var_05 = 0; var_05 < var_0.size; var_5++) {
    var_06 = var_0[var_05];

    if(var_03 || !issubstr(var_6.classname, var_02)) {
      var_4[var_4.size] = var_06;
      continue;
    }

    var_03 = 1;
    var_06 func_F3B5(var_01);
  }

  return var_04;
}

func_9933(var_00, var_01) {
  var_02 = 0;
  var_03 = [];

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    var_05 = var_0[var_04];

    if(var_02) {
      var_3[var_3.size] = var_05;
      continue;
    }

    var_02 = 1;
    var_05 func_F3B5(var_01);
  }

  return var_03;
}

func_13624(var_00) {
  scripts\sp\utility_code::func_13634(var_00, "script_noteworthy");
}

func_13630(var_00) {
  scripts\sp\utility_code::func_13634(var_00, "targetname");
}

func_135D5(var_00, var_01) {
  if(scripts\engine\utility::flag(var_00)) {
    return;
  }
  level endon(var_00);
  wait(var_01);
}

func_135F1(var_00, var_01) {
  self endon(var_00);
  wait(var_01);
}

func_13635(var_00) {
  self endon("trigger");
  wait(var_00);
}

func_135CA(var_00, var_01) {
  var_02 = spawnStruct();
  var_03 = [];
  var_03 = scripts\engine\utility::array_combine(var_03, getEntArray(var_00, "targetname"));
  var_03 = scripts\engine\utility::array_combine(var_03, getEntArray(var_01, "targetname"));

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    var_02 thread scripts\sp\utility_code::func_65FB(var_3[var_04]);
  }

  var_02 waittill("done");
}

func_5CC9(var_00) {
  var_01 = func_0B77::func_1085E(var_00);
  return var_01;
}

func_6B47(var_00) {
  if(!isDefined(var_00)) {
    var_00 = self;
  }

  var_01 = func_0B77::func_1085E(var_00);
  var_01[[level.func_6B43]]();
  var_1.func_10707 = var_0.func_10708;
  var_1.func_10708 = undefined;
  var_01 thread func_0B77::func_E81A();
  var_1.spawner = var_00;
  var_1.func_ED8A = 1;

  if(isDefined(var_0.func_EE5A)) {
    var_1.func_C05C = var_0.func_EE5A;
  }

  if(isDefined(var_0.func_EE5F)) {
    var_1.noragdoll = var_0.func_EE5F;
  }

  return var_01;
}

func_2C17(var_00) {
  var_01 = func_0B77::func_1085E(var_00);
  var_1.func_10707 = var_0.func_10708;
  var_1.func_10708 = undefined;
  var_01 thread func_0B77::func_E81A();
  return var_01;
}

func_5CC8(var_00) {
  if(!isDefined(var_00)) {
    var_00 = self;
  }

  var_01 = func_0B77::func_1085E(var_00);
  var_01[[level.func_5C7C]]();
  var_1.func_10707 = var_0.func_10708;
  var_1.func_10708 = undefined;
  var_01 thread func_0B77::func_E81A();
  return var_01;
}

func_48C1() {
  var_00 = getEntArray("corpse", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_00, ::func_9591);
  }

  var_00 = getEntArray("corpse_noragdoll", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_00, ::func_9591);
  }

  var_00 = func_7C84("corpse", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_00, ::func_9591);
  }
}

func_9591() {
  if(!isDefined(self.script_animation)) {
    self delete();
  } else {
    self.func_1FBB = "corpse";
    self _meth_839E();

    if(isai(self)) {
      self.ignoreall = 1;
    } else {
      self notsolid();
    }

    if(isDefined(self.target)) {
      var_00 = scripts\engine\utility::get_target_ent(self.target);
      self dontinterpolate();

      if(isai(self)) {
        self _meth_80F1(var_0.origin, var_0.angles);
      } else {
        self.origin = var_0.origin;
        self.angles = var_0.angles;
      }
    }

    var_01 = getweaponmodel(self.weapon);

    if(isDefined(var_01) && var_01 != "") {
      if(isai(self)) {
        func_86E4();
      } else {
        self detach(var_01, "tag_weapon_right");
      }

      if(!isDefined(self.func_EE5A)) {
        var_02 = spawn("weapon_" + self.weapon, self gettagorigin("tag_weapon_right"));
        var_2.angles = self gettagangles("tag_weapon_right");
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

      if(isDefined(self.func_71C8)) {
        self[[self.func_71C8]]();
      }

      self startragdoll();
    }
  }
}

func_7D1E() {
  if(isDefined(self.func_ED9A)) {
    return self.func_ED9A;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

func_F340() {
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
}

func_4793(var_00) {
  if(var_00 == "on") {
    func_61E7();
  } else {
    func_5514();
  }
}

func_13861(var_00, var_01, var_02) {
  if(var_00 == "on") {
    self.var_1198.func_13863 = 1;

    if(isDefined(var_02)) {
      if(var_02 == "right") {
        self.func_13862 = "right";
      } else {
        self.func_13862 = "left";
      }
    }

    if(!isDefined(var_01)) {
      self.func_13864 = level.player;
    } else {
      self.func_13864 = var_01;

      if(!isDefined(var_1.origin)) {
        return;
      }
    }
  } else
    self.var_1198.func_13863 = 0;
}

func_DC45(var_00) {
  if(isplayer(self)) {
    switch (var_00) {
      case "raise":
        func_0E4B::func_1348D();
        break;
      case "lower":
        func_0E4B::func_13485();
        break;
    }

    return;
  }

  if(var_00 == "raise") {
    self.asm.func_DC48 = 1;
  } else {
    self.asm.func_DC48 = 0;
  }

  func_0A1E::func_236E();
}

func_61E7(var_00) {
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(var_00)) {
    self.func_4797 = 1;
  }

  self.turnrate = 0.2;
  level thread scripts\anim\cqb::func_6CB4();
  func_51E1("cqb");
}

func_5514() {
  if(self.type == "dog") {
    return;
  }
  self.func_4797 = undefined;
  self.turnrate = 0.3;
  self.func_478F = undefined;
  func_4145();
}

func_622F() {
  self.func_32D4 = 1;
}

func_5574() {
  self.func_32D4 = undefined;
}

func_4788(var_00) {
  if(!isDefined(var_00)) {
    self.func_4792 = undefined;
  } else {
    self.func_4792 = var_00;

    if(!isDefined(var_0.origin)) {
      return;
    }
  }
}

func_F3B8(var_00) {
  if(isDefined(var_00) && var_00) {
    self.forcesuppression = 1;
  } else {
    self.forcesuppression = undefined;
  }
}

func_F225(var_00, var_01) {
  if(isDefined(var_01)) {
    self notify(var_00, var_01);
  } else {
    self notify(var_00);
  }
}

func_137A3(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_03 endon("complete");
  var_03 scripts\engine\utility::delaythread(var_02, ::func_F225, "complete");
  self waittillmatch(var_00, var_01);
}

func_137A4(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_03 endon("complete");
  var_03 scripts\engine\utility::delaythread(var_02, ::func_F225, "complete");
  self waittill(var_00, var_01);
  return var_01;
}

func_6DDE(var_00) {
  if(!isDefined(self.func_11A3F)) {
    self.func_11A3F = [];
  }

  if(isDefined(self.func_11A3F[var_0.unique_id])) {
    return 0;
  }

  self.func_11A3F[var_0.unique_id] = 1;
  return 1;
}

func_7DC1(var_00) {
  return level.func_EC85[self.func_1FBB][var_00];
}

func_8BC9(var_00) {
  return isDefined(level.func_EC85[self.func_1FBB][var_00]);
}

func_7DC2(var_00, var_01) {
  return level.func_EC85[var_01][var_00];
}

func_7DC3(var_00) {
  return level.func_EC85["generic"][var_00];
}

func_8BCA(var_00) {
  return isDefined(level.func_EC85["generic"][var_00]);
}

func_16EB(var_00, var_01, var_02) {
  if(!isDefined(level.func_12750)) {
    level.func_12750 = [];
    level.func_1274F = [];
  }

  level.func_12750[var_00] = var_01;
  precachestring(var_01);

  if(isDefined(var_02)) {
    level.func_1274F[var_00] = var_02;
  }
}

clearthreatbias(var_00, var_01) {
  _setthreatbias(var_00, var_01, 0);
  _setthreatbias(var_01, var_00, 0);
}

func_11813() {
  scripts\anim\combat_utility::func_11814();
}

func_F417(var_00) {
  self.ignoresuppression = var_00;
}

func_F3E0(var_00) {
  self.goalradius = var_00;
}

func_F2A8(var_00) {
  self.allowdeath = var_00;
}

func_F582(var_00, var_01) {
  if(getdvarint("ai_iw7", 0) == 1) {
    var_02 = "combat";
    func_F48E(var_02, var_00);
    self.func_E80C = level.func_EC85[self.func_1FBB][var_00];
    return;
  }

  if(isDefined(var_01)) {
    self.alwaysrunforward = var_01;
  } else {
    self.alwaysrunforward = 1;
  }

  func_559A();
  self.func_E80C = level.func_EC85[self.func_1FBB][var_00];
  self.func_13872 = self.func_E80C;
}

func_F48E(var_00, var_01) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_00, "move", level.func_EC85[self.func_1FBB][var_01]);
}

func_4169(var_00) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_00, "move");
}

func_F40E(var_00, var_01) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_00, "idle", level.func_EC85[self.func_1FBB][var_01]);
}

func_415D(var_00) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_00, "idle");
}

func_F35F() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.func_55ED = 1;
  self.func_EE56 = 1;
}

func_F303(var_00, var_01, var_02, var_03) {
  scripts\anim\animset::func_950F(var_00, var_01, var_02, var_03);
}

func_F48F(var_00, var_01, var_02) {
  var_03 = scripts\anim\utility::func_B028(var_00);

  if(isarray(var_01)) {
    var_3["straight"] = var_1[0];
    var_3["move_f"] = var_1[0];
    var_3["move_l"] = var_1[1];
    var_3["move_r"] = var_1[2];
    var_3["move_b"] = var_1[3];
  } else {
    var_3["straight"] = var_01;
    var_3["move_f"] = var_01;
  }

  if(isDefined(var_02)) {
    var_3["sprint"] = var_02;
  }

  self.custommoveanimset[var_00] = var_03;
}

func_F2C9(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(isDefined(self.func_22EE)) {
    self.func_22EE = var_00;
  } else {
    return;
  }
}

func_412D() {
  if(isDefined(self.func_22EE)) {
    self.func_22EE = 1;
  }
}

func_C81A(var_00) {
  var_01 = func_0A1E::func_2357(self.asm.archetype, "move_walk_loop", "casual_purpose");
  scripts\asm\asm::asm_setdemeanoranimoverride(var_00, "move", var_01);

  if(var_00 == "casual") {
    thread func_F2C9(1.15);
  }
}

func_416A() {
  thread func_4169(scripts\asm\asm::asm_getdemeanor());
  thread func_412D();
}

func_51E1(var_00) {
  if(var_00 == "cqb") {
    level thread scripts\anim\cqb::func_6CB4();
  }

  if(self.asmname == "soldier") {
    if(var_00 == "casual" || var_00 == "casual_walk" || var_00 == "casual_gun") {
      self.turnrate = 0.1;
    } else if(var_00 == "cqb") {
      self.turnrate = 0.2;
    } else {
      self.turnrate = 0.3;
    }
  }

  self.demeanoroverride = var_00;
}

func_4145() {
  self.demeanoroverride = undefined;

  if(self.asmname == "soldier") {
    self.turnrate = 0.3;
  }
}

func_F3C8(var_00) {
  var_01 = level.func_EC85["generic"][var_00];

  if(isarray(var_01)) {
    self.func_1095A = var_01;
  } else {
    self.func_1095A[0] = var_01;
  }
}

func_13035(var_00, var_01, var_02) {
  scripts\asm\asm_bb::func_296E(var_00);
  scripts\asm\asm_bb::func_296F(var_01);
  var_04 = (-16, 0, 0);
  var_05 = var_00 localtoworldcoords(var_04);
  var_06 = _physicstrace(var_05, var_05 + (0, 0, -72));
  var_07 = (0, var_0.angles[1], 0);

  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self _meth_80F1(var_06, var_07);
  var_08 = var_00 getlinkedparent();

  if(isDefined(var_08)) {
    self linkto(var_08);
  }

  var_09 = self.asmname;
  var_10 = self.func_164D[var_09].func_4BC0;
  var_11 = anim.asm[var_09].states[var_10];
  scripts\asm\asm::func_2388(var_09, var_10, var_11, var_11.func_116FB);
  scripts\asm\asm::func_238A(var_09, "script_use_turret", 0.2);
}

func_11051() {
  scripts\asm\asm_bb::func_296E(undefined);
  scripts\asm\asm_bb::func_296F(undefined);
}

func_4154() {
  self.func_1095A = undefined;
  self notify("stop_specialidle");
}

func_F3CB(var_00, var_01) {
  func_F3CC(var_00, undefined, var_01);
}

func_4155() {
  self notify("movemode");
  func_624D();
  self.func_E80C = undefined;
  self.func_13872 = undefined;
}

func_F3CC(var_00, var_01, var_02) {
  self notify("movemode");

  if(!isDefined(var_02) || var_02) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.func_E80C = level.func_EC85["generic"][var_00];
  self.func_13872 = self.func_E80C;

  if(isDefined(var_01)) {
    self.func_E80B = level.func_EC85["generic"][var_01];
    self.func_13871 = self.func_E80B;
  } else {
    self.func_E80B = undefined;
    self.func_13871 = undefined;
  }
}

func_F583(var_00, var_01, var_02) {
  self notify("movemode");

  if(!isDefined(var_02) || var_02) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.func_E80C = level.func_EC85[self.func_1FBB][var_00];
  self.func_13872 = self.func_E80C;

  if(isDefined(var_01)) {
    self.func_E80B = level.func_EC85[self.func_1FBB][var_01];
    self.func_13871 = self.func_E80B;
  } else {
    self.func_E80B = undefined;
    self.func_13871 = undefined;
  }
}

func_417A() {
  self notify("clear_run_anim");
  self notify("movemode");

  if(self.type == "dog") {
    self.a.movement = "run";
    self.disablearrivals = 0;
    self.func_55ED = 0;
    self.func_EE56 = undefined;
    return;
  }

  if(getdvarint("ai_iw7", 0) == 1) {
    var_00 = "combat";
    self.var_1198.alwaysrunforward = 0;
    func_4169(var_00);
    self.func_E80C = undefined;
    return;
  }

  if(!isDefined(self.func_3B17)) {
    func_624D();
  }

  self.alwaysrunforward = undefined;
  self.func_E80C = undefined;
  self.func_13872 = undefined;
  self.func_E80B = undefined;
  self.func_13871 = undefined;
}

func_CB0F(var_00, var_01, var_02) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(var_00) || !isDefined(var_01) || !isDefined(var_02)) {
    var_00 = 400;
    var_01 = 256;
    var_02 = (0, 0, 0.075);
  }

  var_03 = var_00 * var_00;
  var_04 = 3;
  var_05 = var_02;

  for(;;) {
    wait 0.1;
    var_02 = var_05;

    if(self.code_classname == "script_vehicle") {
      var_06 = self vehicle_getspeed();

      if(var_06 < var_04) {
        var_07 = var_06 / var_04;
        var_02 = var_05 * var_07;
      }
    }

    var_08 = distancesquared(self.origin, level.player.origin);
    var_07 = var_03 / var_08;

    if(var_07 > 1) {
      var_07 = 1;
    }

    var_02 = var_02 * var_07;
    var_09 = var_2[0] + var_2[1] + var_2[2];

    if(var_09 > 0.025) {
      _physicsjitter(self.origin, var_00, var_01, var_2[2], var_2[2] * 2.0);
    }
  }
}

func_F3D5(var_00) {
  self setgoalentity(var_00);
}

func_15F1(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    func_15F2(var_02);
  } else {
    var_03 = getEntArray(var_00, var_01);
    scripts\engine\utility::array_thread(var_03, ::func_15F2, var_02);
  }
}

func_15F2(var_00) {
  if(isDefined(self.func_ED33)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("allies");
  }

  if(isDefined(self.func_ED34)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("axis");
  }

  self notify("trigger", var_00);
}

func_F1DE() {
  self delete();
}

func_8B6C() {
  if(scripts\sp\colors::func_7CE4() == "axis") {
    return isDefined(self.func_ED34) || isDefined(self.func_EDAD);
  }

  return isDefined(self.func_ED33) || isDefined(self.func_EDAD);
}

func_413D() {
  func_4186("axis");
  func_4186("allies");
}

func_4186(var_00) {
  level.func_4BE0[var_00]["r"] = undefined;
  level.func_4BE0[var_00]["b"] = undefined;
  level.func_4BE0[var_00]["c"] = undefined;
  level.func_4BE0[var_00]["y"] = undefined;
  level.func_4BE0[var_00]["p"] = undefined;
  level.func_4BE0[var_00]["o"] = undefined;
  level.func_4BE0[var_00]["g"] = undefined;
}

func_C12D(var_00, var_01) {
  self endon("death");

  if(var_01 > 0) {
    wait(var_01);
  }

  if(!isDefined(self)) {
    return;
  }
  self notify(var_00);
}

func_BE49() {
  self.func_C3FB = self.name;
  self.name = "";
}

func_BE4A() {
  self.name = self.func_C3FB;
}

func_86E4() {
  if(isai(self)) {
    scripts\anim\shared::placeweaponon(self.weapon, "none");
  } else {
    self detach(getweaponmodel(self.weapon), "tag_weapon_right");
  }
}

func_86E2() {
  if(isai(self)) {
    scripts\anim\shared::placeweaponon(self.weapon, "right");
  } else {
    self attach(getweaponmodel(self.weapon), "tag_weapon_right");
  }
}

func_CC06(var_00, var_01) {
  if(!scripts\anim\utility::func_1A18(var_00)) {
    scripts\anim\init::func_98E1(var_00);
  }

  scripts\anim\shared::placeweaponon(var_00, var_01);
}

func_72EC(var_00, var_01) {
  if(!scripts\anim\init::func_A000(var_00)) {
    scripts\anim\init::func_98E1(var_00);
  }

  var_02 = self.weapon != "none";
  var_03 = scripts\anim\utility_common::isusingsidearm();
  var_04 = var_01 == "sidearm";
  var_05 = var_01 == "secondary";

  if(var_02 && var_03 != var_04) {
    if(var_03) {
      var_06 = "none";
    } else if(var_05) {
      var_06 = "back";
    } else {
      var_06 = "chest";
    }

    scripts\anim\shared::placeweaponon(self.weapon, var_06);
    self.lastweapon = self.weapon;
  } else
    self.lastweapon = var_00;

  scripts\anim\shared::placeweaponon(var_00, "right");

  if(var_04) {
    self.func_101B4 = var_00;
  } else if(var_05) {
    self.secondaryweapon = var_00;
  } else {
    self.primaryweapon = var_00;
  }

  self.weapon = var_00;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

func_D1FD(var_00) {
  var_01 = level.player.origin;

  for(;;) {
    if(distance(var_01, level.player.origin) > var_00) {
      break;
    }
    wait 0.05;
  }
}

func_13763(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  thread scripts\sp\utility_code::func_13764(var_04, var_00, var_01);
  thread scripts\sp\utility_code::func_13764(var_04, var_02, var_03);
  var_04 waittill("done");
}

func_137AA(var_00) {
  self waittill(var_00);
}

func_56BA(var_00, var_01, var_02, var_03) {
  var_04 = func_7B92();

  if(isDefined(level.func_1274F[var_00])) {
    if(var_04[[level.func_1274F[var_00]]]()) {
      return;
    }
    var_04 thread scripts\sp\utility_code::func_9021(level.func_12750[var_00], level.func_1274F[var_00], var_01, var_02, var_03);
  } else
    var_04 thread scripts\sp\utility_code::func_9021(level.func_12750[var_00]);
}

func_56BE(var_00, var_01, var_02, var_03, var_04) {
  var_05 = func_7B92();

  if(isDefined(level.func_1274F[var_00]) && var_05[[level.func_1274F[var_00]]]()) {
    return;
  }
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 6);
  var_05 thread scripts\sp\utility_code::func_9021(level.func_12750[var_00], level.func_1274F[var_00], var_02, var_03, var_04, var_01);
}

func_56BF(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = func_7B92();

  if(isDefined(level.func_1274F[var_00]) && var_06[[level.func_1274F[var_00]]]()) {
    return;
  }
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 6);
  var_06 thread scripts\sp\utility_code::func_9021(level.func_12750[var_00], level.func_1274F[var_00], var_03, var_04, var_05, var_01, var_02);
}

func_56BB(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  var_10 = scripts\sp\utility_code::func_900D(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
  func_56BA(var_10, var_07, var_08, var_09);
  thread scripts\sp\utility_code::func_900E(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

func_56BC(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(!isDefined(var_07)) {
    var_07 = 0;
  }

  var_11 = scripts\sp\utility_code::func_900D(var_00, var_02, var_03, var_04, var_05, var_06, var_07);
  thread func_56BE(var_11, var_01, var_08, var_09, var_10);
  thread scripts\sp\utility_code::func_900E(var_00, var_02, var_03, var_04, var_05, var_06, var_07);
}

func_56BD(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(!isDefined(var_08)) {
    var_08 = 0;
  }

  var_12 = scripts\sp\utility_code::func_900D(var_00, var_03, var_04, var_05, var_06, var_07, var_08);
  thread func_56BF(var_12, var_01, var_02, var_09, var_10, var_11);
  thread scripts\sp\utility_code::func_900E(var_00, var_03, var_04, var_05, var_06, var_07, var_08);
}

func_7ECF(var_00) {
  return level.func_EC85["generic"][var_00];
}

func_61E3() {
  self.func_ED27 = 1;
}

func_550D() {
  self.func_ED27 = 0;
  self notify("stop_being_careful");
}

func_623B() {
  self.func_10AB7 = 1;
}

func_5588() {
  self.func_10AB7 = undefined;
}

func_550C() {
  self.disablebulletwhizbyreaction = 1;
}

func_61DF() {
  self.disablebulletwhizbyreaction = undefined;
}

func_F39F() {
  self.fixednode = 1;
}

func_F39E() {
  self.fixednode = 0;
}

func_10619(var_00, var_01) {
  if(isDefined(self.func_ED52)) {
    self endon("death");
    wait(self.func_ED52);
  }

  var_02 = undefined;
  var_03 = isDefined(self.func_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");

  if(isDefined(self.func_ED6E)) {
    var_02 = func_5CC8(self);
  } else if(isDefined(self.func_ED8A)) {
    var_02 = func_6B47(self);
  } else if(isDefined(self.func_ED1B)) {
    var_02 = func_2C17(self);
  } else if(isDefined(self.func_EDB3) || isDefined(var_00)) {
    var_02 = self _meth_8393(var_03);
  } else {
    var_02 = self dospawn(var_03);
  }

  if(isDefined(var_01) && var_01 && isalive(var_02)) {
    var_02 func_B14F();
  }

  if(!isDefined(self.func_ED6E) && !isDefined(self.func_ED8A) && !isDefined(self.func_ED1B)) {
    func_106ED(var_02);
  }

  if(isDefined(self.func_EEB5)) {
    self delete();
  }

  return var_02;
}

func_74D7(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();
  var_06 thread scripts\sp\utility_code::func_74DB(self, var_00, var_01, var_02, var_03, var_04, var_05);
  return scripts\sp\utility_code::func_74DF(var_06);
}

func_74DD(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = spawnStruct();
  var_07 thread scripts\sp\utility_code::func_74DB(self, var_01, var_02, var_03, var_04, var_05, var_06);

  if(isDefined(var_7.func_74DA) || var_07 scripts\engine\utility::waittill_any_timeout(var_00, "function_stack_func_begun") != "timeout") {
    return scripts\sp\utility_code::func_74DF(var_07);
  } else {
    var_07 notify("death");
    return 0;
  }
}

func_74D9() {
  var_00 = [];

  if(isDefined(self.func_74D7[0]) && isDefined(self.func_74D7[0].func_74DA)) {
    var_0[0] = self.func_74D7[0];
  }

  self.func_74D7 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0].func_74DA) {
    return;
  }
  self.func_74D7 = var_00;
}

func_5528() {
  self.func_55ED = 1;
}

func_61F7() {
  self.func_55ED = undefined;
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

func_F2E1(var_00, var_01) {
  _setblur(var_00, var_01);
}

func_F3DD(var_00) {
  self.goalradius = var_00;
}

func_F3D9(var_00) {
  self.func_A906 = var_00;
  self.func_A907 = undefined;
  self.func_A905 = undefined;
  self give_more_perk(var_00);
}

func_F3DA(var_00) {
  var_01 = getnode(var_00, "targetname");
  func_F3D9(var_01);
}

func_F3DC(var_00) {
  self.func_A906 = undefined;
  self.func_A907 = var_00;
  self.func_A905 = undefined;
  self give_mp_super_weapon(var_00);
}

func_F3D3(var_00) {
  func_F3DC(var_0.origin);
  self.func_A905 = var_00;

  if(_isstruct(var_00) && !isDefined(var_0.type)) {
    var_0.type = "struct";
  }
}

func_C27C(var_00) {
  objective_state(var_00, "done");
  level notify("objective_complete" + var_00);
}

func_7C84(var_00, var_01) {
  var_02 = _getspawnerarray();
  var_03 = [];

  if(var_01 == "code_classname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_5.code_classname) && var_5.code_classname == var_00) {
        var_3[var_3.size] = var_05;
      }
    }
  } else if(var_01 == "classname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_5.classname) && var_5.classname == var_00) {
        var_3[var_3.size] = var_05;
      }
    }
  } else if(var_01 == "target") {
    foreach(var_05 in var_02) {
      if(isDefined(var_5.target) && var_5.target == var_00) {
        var_3[var_3.size] = var_05;
      }
    }
  } else if(var_01 == "script_linkname") {
    foreach(var_05 in var_02) {
      if(isDefined(var_5.script_linkname) && var_5.script_linkname == var_00) {
        var_3[var_3.size] = var_05;
      }
    }
  } else if(var_01 == "script_noteworthy") {
    foreach(var_05 in var_02) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_00) {
        var_3[var_3.size] = var_05;
      }
    }
  } else if(var_01 == "targetname") {} else {}

  return var_03;
}

func_22C6(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_03 = [];

  foreach(var_05 in var_00) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_06 = var_05 func_10808();

      if(isDefined(var_6.target) && !isDefined(var_6.func_EE2B)) {
        var_06 thread scripts\sp\vehicle_paths::setsuit();
      }

      var_3[var_3.size] = var_06;
      continue;
    }

    var_06 = var_05 func_10619(var_01);

    if(!var_02) {}

    var_3[var_3.size] = var_06;
  }

  if(!var_02) {}

  return var_03;
}

func_22CD(var_00, var_01, var_02, var_03) {
  var_04 = _getspawnerarray(var_00);
  var_04 = func_22A2(var_04, getEntArray(var_00, "targetname"));

  if(isDefined(level.func_107A7)) {
    var_05 = scripts\engine\utility::getstructarray(var_00, "targetname");

    if(isDefined(var_03) && var_03) {
      func_51D6(var_05);
    }

    var_06 = func_0B77::func_7BC6(var_05);
    var_04 = scripts\engine\utility::array_combine(var_04, var_06);
  }

  return func_22C6(var_04, var_01, var_02);
}

func_22CB(var_00, var_01, var_02, var_03) {
  var_04 = func_7C84(var_00, "script_noteworthy");
  var_04 = func_22A2(var_04, getEntArray(var_00, "script_noteworthy"));

  if(isDefined(level.func_107A7)) {
    var_05 = scripts\engine\utility::getstructarray(var_00, "script_noteworthy");

    if(isDefined(var_03) && var_03) {
      func_51D6(var_05);
    }

    var_06 = func_0B77::func_7BC6(var_05);
    var_04 = scripts\engine\utility::array_combine(var_04, var_06);
  }

  return func_22C6(var_04, var_01, var_02);
}

func_107CD(var_00, var_01) {
  var_02 = _getspawner(var_00, "script_noteworthy");
  var_03 = var_02 func_10619(var_01);
  return var_03;
}

func_107EA(var_00, var_01) {
  var_02 = _getspawner(var_00, "targetname");
  var_03 = var_02 func_10619(var_01);
  return var_03;
}

func_16C5(var_00, var_01, var_02) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.func_545A)) {
    level.func_545A = [];
  }

  if(level.func_545A.size == 5) {
    var_03 = level.func_545A[0];
    level.func_545A = array_remove_index(level.func_545A, 0);
    func_12DB1();
    var_03 thread func_52A5();
  }

  var_04 = "^3";

  if(isDefined(var_02)) {
    switch (var_02) {
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
  var_06 = level.func_545A.size;
  level.func_545A[var_06] = var_05;
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.x = 40;
  var_5.y = 260 + var_06 * 12;
  var_5.label = "" + var_04 + var_00 + ": ^7" + var_01;
  var_5.alpha = 0;
  var_05 fadeovertime(0.2);
  var_5.alpha = 1;
  var_05 endon("death");
  wait 8;
  level.func_545A = scripts\engine\utility::array_remove(level.func_545A, var_05);
  func_12DB1();
  var_05 thread func_52A5();
}

func_52A5() {
  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

func_12DB1() {
  level.func_545A = scripts\engine\utility::array_removeundefined(level.func_545A);

  foreach(var_02, var_01 in level.func_545A) {
    var_01 moveovertime(0.2);
    var_1.y = 260 + var_02 * 12;
  }
}

func_F3E6(var_00) {
  self.grenadeammo = var_00;
}

func_7B91() {
  var_00 = self.origin;
  var_01 = anglestoup(self getplayerangles());
  var_02 = self _meth_8157();
  var_03 = var_00 + (0, 0, var_02);
  var_04 = var_00 + var_01 * var_02;
  var_05 = var_03 - var_04;
  var_06 = var_00 + var_05;
  return var_06;
}

func_F2D8(var_00) {
  self.func_2894 = var_00;
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }
  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  } else {}

  if(!isDefined(level.func_13E0F)) {
    level.func_13E0F = getdvar("xenonGame") == "true";
  } else {}

  if(!isDefined(level.func_DADB)) {
    level.func_DADB = getdvar("ps3Game") == "true";
  } else {}

  if(!isDefined(level.func_13E0E)) {
    level.func_13E0E = getdvar("xb3Game") == "true";
  } else {}

  if(!isDefined(level.func_DADC)) {
    level.func_DADC = getdvar("ps4Game") == "true";
  } else {}
}

func_9BEE() {
  if(level.func_13E0E || level.func_DADC || !level.console) {
    return 1;
  } else {
    return 0;
  }
}

func_266F(var_00) {
  return scripts\sp\autosave::func_1190(var_00);
}

func_2670() {
  return scripts\sp\autosave::func_1190(1);
}

func_F3C7(var_00) {
  self.func_4E2A = func_7ECF(var_00);
}

func_F333(var_00) {
  self.func_4E2A = func_7DC1(var_00);
}

func_4141() {
  self.func_4E2A = undefined;
}

putgunaway() {
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  self.weapon = "none";
}

anim_stopanimscripted() {
  self givescorefortrophyblocks();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

func_5564() {
  self.a.func_5605 = 1;
  self.allowpain = 0;
}

func_6224() {
  self.a.func_5605 = 0;
  self.allowpain = 1;
}

func_2011(var_00) {
  self.func_1C78 = var_00;
}

func_200C() {
  self.func_1C78 = undefined;
}

func_200D(var_00, var_01) {
  if(var_01) {
    if(!isDefined(level.func_2006.func_5602) || level.func_2006.func_5602.size == 0 || var_00 == "all") {
      level.func_2006.func_5602 = [];
      level.func_2006.func_5602[0] = var_00;
    } else if(level.func_2006.func_5602[0] != "all")
      level.func_2006.func_5602 = scripts\engine\utility::array_combine_unique(level.func_2006.func_5602, [var_00]);
  } else {
    if(!isDefined(level.func_2006.func_5602) || level.func_2006.func_5602.size == 0) {
      return;
    }
    if(var_00 == "all") {
      level.func_2006.func_5602 = undefined;
    } else if(level.func_2006.func_5602[0] == "all") {
      level.func_2006.func_5602 = [];

      if(var_00 == "allies") {
        level.func_2006.func_5602[0] = "axis";
      } else {
        level.func_2006.func_5602[0] = "allies";
      }
    } else {
      level.func_2006.func_5602 = scripts\engine\utility::array_remove_array(level.func_2006.func_5602, [var_00]);
      return;
    }
  }
}

func_A62F() {
  self getrankinfofull(0);
  self _meth_81D0();
  return 1;
}

func_22D8(var_00, var_01, var_02) {
  var_03 = getarraykeys(var_00);
  var_04 = [];

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    var_06 = var_3[var_05];
  }

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    var_06 = var_3[var_05];
    var_4[var_06] = spawnStruct();
    var_4[var_06].func_1187 = 1;
    var_4[var_06] thread scripts\sp\utility_code::func_22D9(var_0[var_06], var_01, var_02);
  }

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    var_06 = var_3[var_05];

    if(isDefined(var_0[var_06]) && var_4[var_06].func_1187) {
      var_4[var_06] waittill("_array_wait");
    }
  }
}

func_54C6() {
  self _meth_81D0((0, 0, 0));
}

func_7FBC(var_00) {
  return level.func_EC8C[var_00];
}

func_9D27() {
  return self playerads() > 0.5;
}

func_5575() {
  self.func_E198 = undefined;
  self notify("_disable_reinforcement");
}

func_137DF(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_05)) {
    var_05 = level.player;
  }

  var_06 = spawnStruct();

  if(isDefined(var_03)) {
    var_06 thread func_C12D("timeout", var_03);
  }

  var_06 endon("timeout");

  if(!isDefined(var_00)) {
    var_00 = 0.92;
  }

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_07 = int(var_01 * 20);
  var_08 = var_07;
  self endon("death");
  var_09 = isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_09) {
      var_10 = self getEye();
    } else {
      var_10 = self.origin;
    }

    if(var_05 func_D1DF(var_10, var_00, var_02, var_04)) {
      var_8--;

      if(var_08 <= 0) {
        return 1;
      }
    } else
      var_08 = var_07;

    wait 0.05;
  }
}

func_137E1(var_00, var_01, var_02, var_03) {
  func_137DF(var_01, var_00, var_02, undefined, var_03);
}

func_D1DF(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01)) {
    var_01 = 0.8;
  }

  var_04 = func_7B92();
  var_05 = var_04 getEye();
  var_06 = vectortoangles(var_00 - var_05);
  var_07 = anglesToForward(var_06);
  var_08 = var_04 getplayerangles();
  var_09 = anglesToForward(var_08);
  var_10 = vectordot(var_07, var_09);

  if(var_10 < var_01) {
    return 0;
  }

  if(isDefined(var_02)) {
    return 1;
  }

  var_11 = bulletTrace(var_00, var_05, 0, var_03);
  return var_11["fraction"] == 1;
}

func_6001(var_00, var_01, var_02, var_03) {
  for(var_04 = 0; var_04 < level.players.size; var_4++) {
    if(level.players[var_04] func_D1DF(var_00, var_01, var_02, var_03)) {
      return 1;
    }
  }

  return 0;
}

func_D63A(var_00) {
  var_01 = func_7B92();
  var_02 = vectortoangles(var_00 - var_01 getEye());
  var_03 = anglesToForward(var_02);
  var_04 = var_01 getplayerangles();
  var_05 = anglesToForward(var_04);
  var_06 = vectorcross(var_03, var_05);

  if(var_6[2] < 0) {
    return "left";
  } else {
    return "right";
  }
}

func_CFAC(var_00, var_01) {
  var_02 = gettime();

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(isDefined(var_0.func_D412) && var_0.func_D412 + var_01 >= var_02) {
    return var_0.func_D411;
  }

  var_0.func_D412 = var_02;

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.func_D411 = 0;
    return 0;
  }

  var_03 = level.player getEye();
  var_04 = var_0.origin;

  if(sighttracepassed(var_03, var_04, 1, level.player, var_00)) {
    var_0.func_D411 = 1;
    return 1;
  }

  var_05 = var_00 getEye();

  if(sighttracepassed(var_03, var_05, 1, level.player, var_00)) {
    var_0.func_D411 = 1;
    return 1;
  }

  var_06 = (var_05 + var_04) * 0.5;

  if(sighttracepassed(var_03, var_06, 1, level.player, var_00)) {
    var_0.func_D411 = 1;
    return 1;
  }

  var_0.func_D411 = 0;
  return 0;
}

func_D40E(var_00, var_01) {
  var_02 = var_00 * var_00;

  for(var_03 = 0; var_03 < level.players.size; var_3++) {
    if(distancesquared(var_01, level.players[var_03].origin) < var_02) {
      return 1;
    }
  }

  return 0;
}

func_1938(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  var_02 = 0.75;

  while(var_0.size > 0) {
    wait 1;

    for(var_03 = 0; var_03 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_03]) || !isalive(var_0[var_03])) {
        var_00 = scripts\engine\utility::array_remove(var_00, var_0[var_03]);
        continue;
      }

      if(func_D40E(var_01, var_0[var_03].origin)) {
        continue;
      }
      if(func_6001(var_0[var_03].origin + (0, 0, 48), var_02, 1)) {
        continue;
      }
      if(isDefined(var_0[var_03].func_B14F)) {
        var_0[var_03] func_1101B();
      }

      var_0[var_03] delete();
      var_00 = scripts\engine\utility::array_remove(var_00, var_0[var_03]);
    }
  }
}

func_178D(var_00, var_01, var_02, var_03) {
  func_97A2();
  var_04 = spawnStruct();
  var_4.func_376B = self;
  var_4.func = var_00;
  var_4.func_C8FD = [];

  if(isDefined(var_01)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_03;
  }

  if(!isDefined(level.func_13711.func_13590)) {
    level.func_13711.func_13590 = [var_04];
  } else {
    level.func_13711.func_13590[level.func_13711.func_13590.size] = var_04;
  }
}

func_168D(var_00, var_01, var_02, var_03) {
  func_97A2();
  var_04 = spawnStruct();
  var_4.func_376B = self;
  var_4.func = var_00;
  var_4.func_C8FD = [];

  if(isDefined(var_01)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_4.func_C8FD[var_4.func_C8FD.size] = var_03;
  }

  level.func_13711.func_1523[level.func_13711.func_1523.size] = var_04;
}

func_16DB(var_00, var_01, var_02, var_03, var_04, var_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_6.func_376B = self;
  var_6.func = var_00;
  var_6.func_C8FD = [];

  if(isDefined(var_01)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_03;
  }

  if(isDefined(var_04)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_04;
  }

  if(isDefined(var_05)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_05;
  }

  level.func_13711.func_E7F9[level.func_13711.func_E7F9.size] = var_06;
}

func_16AA(var_00, var_01, var_02, var_03, var_04, var_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_6.func_376B = self;
  var_6.func = var_00;
  var_6.func_C8FD = [];

  if(isDefined(var_01)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_03;
  }

  if(isDefined(var_04)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_04;
  }

  if(isDefined(var_05)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_05;
  }

  level.func_13711.func_E7E0[level.func_13711.func_E7E0.size] = var_06;
}

func_171F(var_00, var_01, var_02, var_03, var_04, var_05) {
  func_97A2();
  var_06 = spawnStruct();
  var_6.func = var_00;
  var_6.func_C8FD = [];

  if(isDefined(var_01)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_03;
  }

  if(isDefined(var_04)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_04;
  }

  if(isDefined(var_05)) {
    var_6.func_C8FD[var_6.func_C8FD.size] = var_05;
  }

  level.func_13711.func_E80A[level.func_13711.func_E80A.size] = var_06;
}

func_16CD(var_00) {
  func_97A2();
  var_01 = spawnStruct();
  var_1.func_376B = self;
  var_1.func_6317 = var_00;
  level.func_13711.func_57D7[level.func_13711.func_57D7.size] = var_01;
}

func_57D6() {
  func_97A2();
  func_57D5(level.func_13711.func_13590.size - 1);
}

func_57D5(var_00) {
  func_97A2();

  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  var_01 = spawnStruct();
  var_02 = level.func_13711.func_13590;
  var_03 = level.func_13711.func_57D7;
  var_04 = level.func_13711.func_E7F9;
  var_05 = level.func_13711.func_E7E0;
  var_06 = level.func_13711.func_E80A;
  var_07 = level.func_13711.func_1523;
  level.func_13711.func_13590 = [];
  level.func_13711.func_E7F9 = [];
  level.func_13711.func_57D7 = [];
  level.func_13711.func_1523 = [];
  level.func_13711.func_E7E0 = [];
  level.func_13711.func_E80A = [];
  var_1.count = var_2.size;
  var_01 scripts\engine\utility::array_levelthread(var_02, scripts\sp\utility_code::func_13774, var_03);
  var_01 thread scripts\sp\utility_code::func_5767(var_07);
  var_01 endon("any_funcs_aborted");

  for(;;) {
    if(var_1.count <= var_00) {
      break;
    }
    var_01 waittill("func_ended");
  }

  var_01 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var_04, scripts\sp\utility_code::func_68CE, []);
  scripts\engine\utility::array_levelthread(var_05, scripts\sp\utility_code::func_68CC);
  scripts\engine\utility::array_levelthread(var_06, scripts\sp\utility_code::func_68CD);
}

func_578A() {
  var_00 = spawnStruct();
  var_01 = level.func_13711.func_E7F9;
  level.func_13711.func_E7F9 = [];

  foreach(var_03 in var_01) {
    level scripts\sp\utility_code::func_68CE(var_03, []);
  }

  var_00 notify("all_funcs_ended");
}

func_9BB5() {
  if(isDefined(level.func_72AD) && level.func_72AD == 1) {
    return 0;
  }

  if(isDefined(level.func_501A) && level.func_501A == level.func_10CDA) {
    return 1;
  }

  if(isDefined(level.func_5019) && level.func_5019 == level.func_10CDA) {
    return 1;
  }

  if(isDefined(level.func_5018)) {
    return level.func_10CDA == "default";
  }

  if(scripts\sp\starts::func_ABDA()) {
    return level.func_10CDA == level.func_10C58[0]["name"];
  }

  return level.func_10CDA == "default";
}

func_13BBF(var_00, var_01) {
  self endon("death");
  var_02 = 0;

  if(isDefined(var_01)) {
    var_02 = 1;
  }

  if(isDefined(var_00)) {
    scripts\engine\utility::flag_assert(var_00);
    level endon(var_00);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_03 = self.origin + (0, 0, 150);
    var_04 = self.origin - (0, 0, 150);
    var_05 = bulletTrace(var_03, var_04, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_06 = "water_movement";

    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_06 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_06 = "water_" + self.a.movement;

    var_07 = scripts\engine\utility::getfx(var_06);
    var_03 = var_5["position"];
    var_08 = (0, self.angles[1], 0);
    var_09 = anglesToForward(var_08);
    var_10 = anglestoup(var_08);
    playFX(var_07, var_03, var_10, var_09);

    if(var_06 != "water_stop" && var_02) {
      thread scripts\engine\utility::play_sound_in_space(var_01, var_03);
    }
  }
}

func_B317(var_00, var_01) {
  var_00 endon("death");
  self endon("death");

  if(!isDefined(var_01)) {
    var_01 = (0, 0, 0);
  }

  for(;;) {
    self.origin = var_0.origin + var_01;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

func_BF95(var_00) {
  scripts\sp\endmission::func_1355(var_00);
}

func_BF97(var_00, var_01, var_02) {
  if(!scripts\engine\utility::flag_exist("nextmission_preload_complete")) {
    scripts\engine\utility::flag_init("nextmission_preload_complete");
  }

  scripts\engine\utility::flag_clear("nextmission_preload_complete");
  scripts\sp\endmission::func_1356(var_00, var_01, var_02);
  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

func_BF98() {
  scripts\sp\endmission::func_1357();
}

func_CE6D(var_00) {}

func_7F6E(var_00) {
  return scripts\sp\endmission::func_12B0(var_00);
}

func_7E2C(var_00) {
  return scripts\sp\endmission::func_12AF(var_00);
}

func_7F70(var_00) {
  return scripts\sp\endmission::func_12B1(var_00);
}

func_13705(var_00) {
  if(!isDefined(var_00)) {
    var_00 = level.script;
  }

  scripts\sp\endmission::func_1455(var_00);
}

func_13C3C(var_00) {
  scripts\sp\endmission::func_1463(var_00);
}

func_13C60() {
  scripts\sp\endmission::func_1464();
}

func_B263(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [];
  var_5[var_5.size] = var_00;

  if(isDefined(var_01)) {
    var_5[var_5.size] = var_01;
  }

  if(isDefined(var_02)) {
    var_5[var_5.size] = var_02;
  }

  if(isDefined(var_03)) {
    var_5[var_5.size] = var_03;
  }

  if(isDefined(var_04)) {
    var_5[var_5.size] = var_04;
  }

  return var_05;
}

func_6AC4() {
  level.func_6AD2 = 1;
}

func_C08C() {
  level.func_6AD2 = 0;
}

_meth_806D() {
  var_00 = self getweaponslistall();
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];
    var_1[var_03] = self getweaponammoclip(var_03);
  }

  var_04 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0) {
    var_04 = var_1["claymore"];
  }

  return var_04;
}

func_1454(var_00) {
  wait(var_00);
}

func_AB9A(var_00, var_01, var_02) {
  var_03 = getdvarfloat(var_00);
  level notify(var_00 + "_lerp_savedDvar");
  level endon(var_00 + "_lerp_savedDvar");
  var_04 = var_01 - var_03;
  var_05 = 0.05;
  var_06 = int(var_02 / var_05);

  if(var_06 > 0) {
    for(var_07 = var_04 / var_06; var_06; var_6--) {
      var_03 = var_03 + var_07;
      _setsaveddvar(var_00, var_03);
      wait(var_05);
    }
  }

  _setsaveddvar(var_00, var_01);
}

func_AB89(var_00, var_01, var_02, var_03) {
  var_04 = getomnvar(var_00);
  level notify(var_00 + "_lerp_savedDvar");
  level endon(var_00 + "_lerp_savedDvar");
  var_05 = var_01 - var_04;
  var_06 = 0.05;
  var_07 = int(var_02 / var_06);

  for(var_08 = var_05 / var_07; var_07; var_7--) {
    var_04 = var_04 + var_08;

    if(isDefined(var_03)) {
      var_09 = func_E753(var_04, var_03);
      setomnvar(var_00, var_09);
    } else
      setomnvar(var_00, var_04);

    wait(var_06);
  }

  if(isDefined(var_03)) {
    var_09 = func_E753(var_01, var_03);
    setomnvar(var_00, var_09);
  } else
    setomnvar(var_00, var_01);
}

func_AB8B(var_00, var_01, var_02) {
  var_03 = getomnvar(var_00);
  level notify(var_00 + "_lerp_savedDvar");
  level endon(var_00 + "_lerp_savedDvar");
  var_04 = var_01 - var_03;
  var_05 = 0.05;
  var_06 = int(var_02 / var_05);

  for(var_07 = var_04 / var_06; var_06; var_6--) {
    var_03 = var_03 + var_07;
    setomnvar(var_00, int(var_03));
    wait(var_05);
  }

  setomnvar(var_00, int(var_01));
}

func_AB9B(var_00, var_01, var_02, var_03) {
  if(func_9BEE()) {
    func_AB9A(var_00, var_02, var_03);
  } else {
    func_AB9A(var_00, var_01, var_03);
  }
}

settimer(var_00, var_01) {
  if(func_9BB7()) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(!var_01 && func_9C32()) {
    return;
  }
  level.player giveachievement(var_00);
}

func_D0A1(var_00) {
  if(func_9BB7()) {
    return;
  }
  if(func_9C32()) {
    return;
  }
  self giveachievement(var_00);
}

func_10327(var_00) {
  level.func_1031B.func_1098F = var_00;
}

func_10326(var_00) {
  level.func_1031B.func_1098C = var_00;
}

func_10324(var_00) {
  level.func_1031B.func_ABA1 = var_00;
}

func_10325(var_00) {
  level.func_1031B.func_ABA2 = var_00;
}

func_10321() {
  if(isDefined(level.func_C014) && level.func_C014) {
    return;
  }
  func_0B0B::func_F5A0();
  setslowmotion(level.func_1031B.func_1098C, level.func_1031B.func_1098F, level.func_1031B.func_ABA1);
}

func_10322() {
  if(isDefined(level.func_C014) && level.func_C014) {
    return;
  }
  setslowmotion(level.func_1031B.func_1098F, level.func_1031B.func_1098C, level.func_1031B.func_ABA2);
  func_0B0B::func_F59F();
}

func_16CC(var_00, var_01, var_02, var_03) {
  level.earthquake[var_00]["magnitude"] = var_01;
  level.earthquake[var_00]["duration"] = var_02;
  level.earthquake[var_00]["radius"] = var_03;
}

func_BDF2(var_00, var_01, var_02) {
  level.func_1188.func_A90A = var_00;

  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  _musicstop(0);
  _musicplay(var_00, 0, 1.0, 1, var_02);
}

func_BDDF(var_00, var_01, var_02, var_03, var_04) {
  thread scripts\sp\utility_code::func_BDE1(var_00, var_01, var_02, var_03, var_04);
}

func_BDE3(var_00, var_01, var_02, var_03, var_04) {
  thread scripts\sp\utility_code::func_BDE1(var_00, var_01, var_02, var_03, var_04, 1);
}

func_BDE5(var_00, var_01, var_02, var_03) {
  if(isDefined(var_01) && var_01 > 0) {
    thread scripts\sp\utility_code::func_BDE6(var_00, var_01, var_02, var_03);
    return;
  }

  func_BDEC();
  func_BDF2(var_00, var_02, var_03);
}

func_BDD5(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  if(isDefined(level.func_1188.func_A90A)) {
    _musicstop(var_01, level.func_1188.func_A90A, var_03);
  } else {}

  level.func_1188.func_A90A = var_00;
  _musicplay(var_00, var_01, var_02, 0, var_03);
  level endon("stop_music");
  wait(var_01);
  level notify("done_crossfading");
}

func_BDEC(var_00) {
  if(!isDefined(var_00) || var_00 <= 0) {
    _musicstop();
  } else {
    _musicstop(var_00);
  }

  level notify("stop_music");
}

func_D121() {
  var_00 = getEntArray("grenade", "classname");

  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    if(isDefined(var_2.func_C182)) {
      continue;
    }
    for(var_03 = 0; var_03 < level.players.size; var_3++) {
      var_04 = level.players[var_03];

      if(distancesquared(var_2.origin, var_4.origin) < 75625) {
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
  if(level.func_7683 < 1) {
    return "easy";
  }

  if(level.func_7683 < 2) {
    return "medium";
  }

  if(level.func_7683 < 3) {
    return "hard";
  }

  return "fu";
}

func_7853(var_00) {
  var_01 = (0, 0, 0);

  foreach(var_03 in var_00) {
    var_01 = var_01 + var_3.origin;
  }

  return var_01 * (1.0 / var_0.size);
}

func_7748() {
  self.func_4CF5 = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    foreach(var_11 in self.func_4CF5) {
      thread[[var_11]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    }
  }
}

func_16B7(var_00) {
  self.func_4CF5[self.func_4CF5.size] = var_00;
}

func_DFE6(var_00) {
  var_01 = [];

  foreach(var_03 in self.func_4CF5) {
    if(var_03 == var_00) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  self.func_4CF5 = var_01;
}

func_D4BF(var_00) {
  self playlocalsound(var_00);
}

func_6278(var_00) {
  if(level.players.size < 1) {
    return;
  }
  foreach(var_02 in level.players) {
    if(var_00 == 1) {
      var_02 enableweapons();
      continue;
    }

    var_02 getradiuspathsighttestnodes();
  }
}

func_11633(var_00) {
  level.player setorigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    level.player setplayerangles(var_0.angles);
  }
}

func_11634(var_00) {
  level.player setplayerangles((0, 0, 0));

  if(isDefined(var_0.angles)) {
    level.player setworldupreferenceangles(var_0.angles);
  }

  level.player setorigin(var_0.origin, 1, 1);
  level.player giveflagcapturexp((0, 0, 0));
}

func_12687() {
  var_00 = [];

  if(isDefined(self.func_6633)) {
    var_00 = self.func_6633;
  }

  if(isDefined(self.entity)) {
    var_0[var_0.size] = self.entity;
  }

  scripts\engine\utility::array_levelthread(var_00, scripts\sp\utility_code::func_12688);
}

func_C621(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  level.player endon("stop_opening_fov");
  wait(var_00);
  level.player getweightedchanceroll(var_01, var_02, 1, var_03, var_04, var_05, var_06, 1);
}

func_77E3(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    var_00 = "all";
  }

  if(!isDefined(var_01)) {
    var_01 = "all";
  }

  var_03 = _getaispeciesarray(var_00, var_01);
  var_04 = [];

  foreach(var_06 in var_03) {
    if(var_06 istouching(self)) {
      var_4[var_4.size] = var_06;
    }
  }

  return var_04;
}

func_7964(var_00) {
  if(!isDefined(var_00)) {
    var_00 = "all";
  }

  var_01 = [];

  if(var_00 == "all") {
    var_01 = func_22A2(level.func_5CC3["allies"].func_2274, level.func_5CC3["axis"].func_2274);
    var_01 = func_22A2(var_01, level.func_5CC3["neutral"].func_2274);
  } else
    var_01 = level.func_5CC3[var_00].func_2274;

  var_02 = [];

  foreach(var_04 in var_01) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(var_04 istouching(self)) {
      var_2[var_2.size] = var_04;
    }
  }

  return var_02;
}

func_7965(var_00) {
  var_01 = func_22A2(level.func_5CC3["allies"].func_2274, level.func_5CC3["axis"].func_2274);
  var_01 = func_22A2(var_01, level.func_5CC3["neutral"].func_2274);
  var_02 = [];

  foreach(var_04 in var_01) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_00) {
      var_2[var_2.size] = var_04;
    }
  }

  return var_02;
}

func_F311(var_00) {
  self.count = var_00;
}

func_7226(var_00, var_01, var_02, var_03) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_04 = undefined;

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type)) {
      var_04 = "struct";
    } else {
      var_04 = "node";
    }
  } else
    var_04 = "entity";

  if(!isDefined(var_01)) {
    var_01 = 300;
  }

  var_05 = self.func_EDB0;
  self.func_EDB0 = 1;
  func_0B77::worldpointinreticle_circle(var_00, var_04, var_02, var_01, var_03);
  self.func_EDB0 = var_05;

  if(!isDefined(self.func_EDB0) || !self.func_EDB0) {
    self.goalradius = level.func_4FF6;
  }
}

func_61F1(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_00)) {
    var_00 = 250;
  }

  if(!isDefined(var_01)) {
    var_01 = 100;
  }

  if(!isDefined(var_02)) {
    var_02 = var_00 * 2;
  }

  if(!isDefined(var_03)) {
    var_03 = var_00 * 1.25;
  }

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  self.func_5953 = var_05;
  thread scripts\sp\utility_code::func_5F8E(var_00, var_01, var_02, var_03, var_04);
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
    wait 2;
    self.goalradius = var_01;
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

func_1376C(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("death");

  if(!isDefined(var_02)) {
    var_02 = 5;
  }

  var_03 = gettime() + var_02 * 1000;

  while(isDefined(var_00)) {
    if(distance(var_0.origin, self.origin) <= var_01) {
      break;
    }
    if(gettime() > var_03) {
      break;
    }
    wait 0.1;
  }
}

func_1376B(var_00, var_01) {
  self endon("death");
  var_00 endon("death");

  while(isDefined(var_00)) {
    if(distance(var_0.origin, self.origin) <= var_01) {
      break;
    }
    wait 0.1;
  }
}

func_1376D(var_00, var_01) {
  self endon("death");
  var_00 endon("death");

  while(isDefined(var_00)) {
    if(distance(var_0.origin, self.origin) > var_01) {
      break;
    }
    wait 0.1;
  }
}

func_8BAB() {
  self endon("death");

  if(!isDefined(self.weapon)) {
    return 0;
  }

  if(scripts\engine\utility::weaponclass(self.weapon) == "spread") {
    return 1;
  }

  return 0;
}

isprimaryweapon(var_00) {
  if(var_00 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_00) != "primary") {
    return 0;
  }

  switch (scripts\engine\utility::weaponclass(var_00)) {
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

func_13817(var_00, var_01) {
  self endon("death");

  if(!isDefined(var_01)) {
    var_01 = self.goalradius;
  }

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_00) < var_01 + 10) {
      break;
    }
  }
}

func_D2CD(var_00, var_01) {
  var_02 = int(getdvar("g_speed"));

  if(!isDefined(level.player.func_764D)) {
    level.player.func_764D = var_02;
  }

  var_03 = int(level.player.func_764D * var_00 * 0.01);
  level.player func_D2D1(var_03, var_01);
}

func_2B78(var_00, var_01) {
  var_02 = self;

  if(!isplayer(var_02)) {
    var_02 = level.player;
  }

  if(!isDefined(var_2.func_BCF5)) {
    var_2.func_BCF5 = 1.0;
  }

  var_03 = var_00 * 0.01;
  var_02 func_2B76(var_03, var_01);
}

func_D2D1(var_00, var_01) {
  var_02 = int(getdvar("g_speed"));

  if(!isDefined(level.player.func_764D)) {
    level.player.func_764D = var_02;
  }

  var_03 = scripts\sp\utility_code::func_764E;
  var_04 = scripts\sp\utility_code::func_764F;
  level.player thread func_D2CE(var_00, var_01, var_03, var_04, "player_speed_set");
}

func_CF97(var_00, var_01) {
  var_02 = scripts\sp\utility_code::func_7647;
  var_03 = scripts\sp\utility_code::func_7648;
  level.player thread func_D2CE(var_00, var_01, var_02, var_03, "player_bob_scale_set");
}

func_2B76(var_00, var_01) {
  var_02 = self;

  if(!isplayer(var_02)) {
    var_02 = level.player;
  }

  if(!isDefined(var_2.func_BCF5)) {
    var_2.func_BCF5 = 1.0;
  }

  var_03 = scripts\sp\utility_code::func_BCF0;
  var_04 = scripts\sp\utility_code::func_BCF3;
  var_02 thread func_D2CE(var_00, var_01, var_03, var_04, "blend_movespeedscale");
}

func_D2CE(var_00, var_01, var_02, var_03, var_04) {
  self notify(var_04);
  self endon(var_04);
  var_05 = [[var_02]]();
  var_06 = var_00;

  if(isDefined(var_01)) {
    var_07 = var_06 - var_05;
    var_08 = 0.05;
    var_09 = var_01 / var_08;
    var_10 = var_07 / var_09;

    while(abs(var_06 - var_05) > abs(var_10 * 1.1)) {
      var_05 = var_05 + var_10;
      [
        [var_03]
      ](var_05);
      wait(var_08);
    }
  }

  [[var_03]](var_06);
}

func_D2CA(var_00) {
  if(!isDefined(level.player.func_764D)) {
    return;
  }
  level.player func_D2D1(level.player.func_764D, var_00);
  waittillframeend;
  level.player.func_764D = undefined;
}

func_2B77(var_00) {
  var_01 = self;

  if(!isplayer(var_01)) {
    var_01 = level.player;
  }

  if(!isDefined(var_1.func_BCF5)) {
    return;
  }
  var_01 func_2B76(1.0, var_00);
  var_1.func_BCF5 = undefined;
}

func_11624(var_00) {
  if(isplayer(self)) {
    self setorigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else if(isai(self))
    self _meth_80F1(var_0.origin, var_0.angles);
  else {
    self.origin = var_0.origin;
    self.angles = var_0.angles;
  }
}

func_11645(var_00, var_01) {
  var_02 = var_00 gettagorigin(var_01);
  var_03 = var_00 gettagangles(var_01);
  self dontinterpolate();

  if(isplayer(self)) {
    self setorigin(var_02);
    self setplayerangles(var_03);
  } else if(isai(self))
    self _meth_80F1(var_02, var_03);
  else {
    self.origin = var_02;
    self.angles = var_03;
  }
}

func_1160F(var_00) {
  self _meth_80F1(var_0.origin, var_0.angles);
  self give_mp_super_weapon(self.origin);
  self give_more_perk(var_00);
}

func_BC00(var_00) {
  foreach(var_02 in level.createfxent) {
    var_2.v["origin"] = var_2.v["origin"] + var_00;
  }
}

func_9F59() {
  return isDefined(self.func_102EB);
}

func_2A75(var_00, var_01, var_02) {
  self endon("stop_sliding");
  self endon("death");
  var_03 = self;

  if(var_03 func_65DF("is_sliding")) {
    var_03 func_65DD("is_sliding");
  } else {
    var_03 func_65E0("is_sliding");
  }

  var_04 = isDefined(level.func_4C5D);
  var_05 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.func_102EB = var_05;
  var_06 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.func_7601 = var_06;
  var_07 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0);
  var_08 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_03, var_07);
  var_09 = 0;
  var_10 = (0, 0, 0);
  var_11 = var_8["normal"];

  for(;;) {
    if(!var_03 isjumping()) {
      var_08 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_03, var_07);
      var_11 = var_8["normal"];

      if(isDefined(var_11)) {
        var_12 = vectordot(var_11, (0, 0, 1));

        if(var_12 <= 0.95) {
          var_09 = acos(var_12);
          var_10 = var_8["position"];
          break;
        }
      }
    }

    wait 0.05;
  }

  var_11 = vectornormalize(scripts\engine\utility::flatten_vector(var_11, (0, 0, 1)));
  var_13 = vectornormalize(vectorcross(var_11, (0, 1, 0)));
  var_14 = vectornormalize(vectorcross(var_11, var_13));
  var_5.angles = var_3.angles;
  var_5.origin = var_3.origin;
  var_15 = vectortoangles(var_11) + var_11 * var_09;
  var_5.func_77BA = spawn("script_model", var_5.origin + anglesToForward(var_15) * 2000);
  var_5.func_77BA.angles = var_15;
  var_3.func_7601.angles = var_15;

  if(!isDefined(var_00)) {
    var_00 = var_03 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var_01)) {
    var_01 = 10;
  }

  if(!isDefined(var_02)) {
    var_02 = 0.035;
  }

  var_05 moveslide((0, 0, 15), 15, var_00);
  var_03 thread play_sound_on_entity("foot_slide_plr_start");
  var_03 _meth_84FE();
  var_03 forceplaygestureviewmodel("ges_slide", var_5.func_77BA, 0.2);

  if(isDefined(level._effect["vfx_slide_dirt"])) {
    var_16 = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_3.func_7601, "tag_origin");
    var_3.func_7601 show();
  }

  var_03 func_65E1("is_sliding");

  if(var_04) {
    var_03 getweaponweight(var_05, undefined, 1);
    wait 1.0;
    var_03 getweightedchanceroll(var_05, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else
    var_03 getweightedchanceroll(var_05, "tag_origin", 0, 180, 180, 180, 180);

  _setsaveddvar("depthSortViewmodel", 1);
  var_03 scripts\engine\utility::allow_fire(0);
  var_03 scripts\engine\utility::allow_prone(0);
  var_03 scripts\engine\utility::allow_stances(0);
  var_03 scripts\engine\utility::allow_reload(0);
  var_03 thread scripts\sp\utility_code::func_5AAD(var_05, var_01, var_02);
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

  if(level.player getteamflagcount()) {
    var_00 unlink();
    var_00 giveflagcapturexp(var_0.func_102EB.slidevelocity);
  }

  if(isDefined(var_0.func_7601)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      var_01 = scripts\engine\utility::getfx("vfx_slide_dirt");

      if(isDefined(var_01)) {
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_0.func_7601, "tag_origin");
      }
    }

    var_0.func_7601 delete();
  }

  if(var_00 func_65DF("is_sliding") && var_00 func_65DB("is_sliding")) {
    var_00 func_65DD("is_sliding");
  }

  var_0.func_102EB delete();
  var_00 scripts\engine\utility::allow_fire(1);
  var_00 scripts\engine\utility::allow_prone(1);
  var_00 scripts\engine\utility::allow_stances(1);
  var_00 scripts\engine\utility::allow_reload(1);
  _setsaveddvar("depthSortViewmodel", 0);
  var_00 notify("stop_sliding");
}

func_2A76(var_00, var_01, var_02) {
  var_03 = self;

  if(var_03 func_65DF("is_sliding")) {
    var_03 func_65DD("is_sliding");
  } else {
    var_03 func_65E0("is_sliding");
  }

  var_03 thread play_sound_on_entity("foot_slide_plr_start");
  var_03 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  var_04 = isDefined(level.func_4C5D);

  if(!isDefined(var_00)) {
    var_00 = var_03 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var_01)) {
    var_01 = 10;
  }

  if(!isDefined(var_02)) {
    var_02 = 0.035;
  }

  var_05 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.func_102EB = var_05;
  var_05 moveslide((0, 0, 15), 15, var_00);
  var_03 func_65E1("is_sliding");

  if(var_04) {
    var_03 getweaponweight(var_05, undefined, 1);
  } else {
    var_03 getweaponvariantattachments(var_05);
  }

  var_03 getradiuspathsighttestnodes();
  var_03 getnumownedactiveagents(0);
  var_03 getnumberoffrozenticksfromwave(1);
  var_03 getnumownedjackals(0);
  var_03 thread scripts\sp\utility_code::func_5AAD(var_05, var_01, var_02);
}

func_638A() {
  var_00 = self;
  var_00 notify("stop soundfoot_slide_plr_loop");
  var_00 thread play_sound_on_entity("foot_slide_plr_end");
  var_00 unlink();
  var_00 giveflagcapturexp(var_0.func_102EB.slidevelocity);
  var_0.func_102EB delete();
  var_00 enableweapons();
  var_00 getnumownedactiveagents(1);
  var_00 getnumberoffrozenticksfromwave(1);
  var_00 getnumownedjackals(1);
  var_00 notify("stop_sliding");

  if(var_00 func_65DF("is_sliding") && var_00 func_65DB("is_sliding")) {
    var_00 func_65DD("is_sliding");
  }
}

func_10808() {
  return scripts\sp\vehicle::func_13237(self);
}

func_7E9C(var_00) {
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

  var_10 = undefined;

  foreach(var_12 in var_02) {
    if(var_12.func_ED9A == var_00) {
      return var_12;
    }
  }
}

func_7E99(var_00) {
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

  var_10 = [];

  foreach(var_12 in var_02) {
    if(var_12.func_ED9A == var_00) {
      var_10[var_10.size] = var_12;
    }
  }

  return var_10;
}

func_F623(var_00, var_01) {
  return (var_0[0], var_0[1], var_01);
}

func_1796(var_00, var_01) {
  return (var_0[0], var_0[1], var_0[2] + var_01);
}

func_F622(var_00, var_01) {
  return (var_0[0], var_01, var_0[2]);
}

func_F621(var_00, var_01) {
  return (var_01, var_0[1], var_0[2]);
}

func_58DA() {
  return isDefined(self.a.func_58DA);
}

func_7C23(var_00) {
  var_01 = func_7B92();

  if(!isDefined(var_00)) {
    var_00 = "steady_rumble";
  }

  var_02 = spawn("script_origin", var_01 getEye());
  var_2.func_99E5 = 1;
  var_02 thread scripts\sp\utility_code::func_12E1F(var_01, var_00);
  return var_02;
}

func_F581(var_00) {
  self.func_99E5 = var_00;
}

func_E7C8(var_00) {
  thread func_E7C9(1, var_00);
}

func_E7C7(var_00) {
  thread func_E7C9(0, var_00);
}

func_E7C9(var_00, var_01) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_02 = var_01 * 20;
  var_03 = var_00 - self.func_99E5;
  var_04 = var_03 / var_02;

  for(var_05 = 0; var_05 < var_02; var_5++) {
    self.func_99E5 = self.func_99E5 + var_04;
    wait 0.05;
  }

  self.func_99E5 = var_00;
}

func_7B92() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self)) {
      return level.player;
    } else {
      return self;
    }
  } else
    return level.player;
}

func_7B93() {
  return int(self _meth_8155("gameskill"));
}

func_228B(var_00, var_01, var_02) {
  var_03 = [];
  var_01 = var_02 - var_01;

  foreach(var_05 in var_00) {
    var_3[var_3.size] = var_05;

    if(var_3.size == var_02) {
      var_03 = scripts\engine\utility::array_randomize(var_03);

      for(var_06 = var_01; var_06 < var_3.size; var_6++) {
        var_3[var_06] delete();
      }

      var_03 = [];
    }
  }

  var_08 = [];

  foreach(var_05 in var_00) {
    if(!isDefined(var_05)) {
      continue;
    }
    var_8[var_8.size] = var_05;
  }

  return var_08;
}

func_1378E(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 0.5;
  }

  self endon("death");

  while(isDefined(self)) {
    if(distance(var_00, self.origin) <= var_01) {
      break;
    }
    wait(var_02);
  }
}

func_558D() {
  self.newenemyreactiondistsq = 0;
}

func_6242() {
  self.newenemyreactiondistsq = squared(512);
}

func_61FF(var_00) {
  self.heat = 1;
  self.func_C009 = 1;
  self.usecombatscriptatcover = 1;

  if(!isDefined(var_00) || !var_00) {
    self.func_596C = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    func_558D();
  }

  self.func_1096A = scripts\anim\animset::func_8CD8;
  self.custommoveanimset["run"] = ::scripts\anim\utility::func_B028("heat_run");
}

func_5537() {
  self.heat = undefined;
  self.func_C009 = undefined;
  self.func_596C = undefined;
  self.usecombatscriptatcover = 0;
  self.maxfaceenemydist = 512;
  self.func_1096A = undefined;
  self.custommoveanimset = undefined;
}

maymovefrompointtopoint() {
  return vehicle_getarray();
}

func_8FE1(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_03 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.func_9019)) {
    level.func_9019 scripts\sp\hud_util::destroyelem();
  }

  level.func_9019 = scripts\sp\hud_util::createfontstring("default", 1.5);
  level.func_9019 scripts\sp\hud_util::setpoint("MIDDLE", undefined, 0, 30 + var_02);
  level.func_9019.color = (1, 1, 1);
  level.func_9019 give_zap_perk(var_00);
  level.func_9019.alpha = 0;
  level.func_9019 fadeovertime(0.5);
  level.func_9019.alpha = 1;
  wait 0.5;
  level.func_9019 endon("death");

  if(isDefined(var_01)) {
    wait(var_01);
  } else {
    return;
  }

  level.func_9019 fadeovertime(var_03);
  level.func_9019.alpha = 0;
  wait(var_03);
  level.func_9019 scripts\sp\hud_util::destroyelem();
}

func_8FF8() {
  var_00 = 1;

  if(isDefined(level.func_9019)) {
    level notify("clearing_hints");
    level.func_9019 fadeovertime(var_00);
    level.func_9019.alpha = 0;
    wait(var_00);
  }
}

func_A5CE(var_00, var_01) {
  if(!isDefined(level.flag[var_00])) {
    return;
  }
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  foreach(var_03 in level.func_4E3F[var_00]) {
    foreach(var_05 in var_03) {
      if(isalive(var_05)) {
        var_05 thread scripts\sp\utility_code::func_A5CF(var_01);
        continue;
      }

      var_05 delete();
    }
  }
}

func_7BB6(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03)) {
    var_03 = "player_view_controller";
  }

  if(!isDefined(var_02)) {
    var_02 = (0, 0, 0);
  }

  var_04 = var_00 gettagorigin(var_01);
  var_05 = spawnturret("misc_turret", var_04, var_03);
  var_5.angles = var_00 gettagangles(var_01);
  var_05 setModel("tag_turret");
  var_05 linkto(var_00, var_01, var_02, (0, 0, 0));
  var_05 makeunusable();
  var_05 hide();
  var_05 give_player_session_tokens("manual");
  return var_05;
}

func_48AA(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_04 childthread scripts\sp\utility_code::func_D961(var_00, self, var_01, var_02, var_03);
  return var_04;
}

func_110A8(var_00) {
  if(!isDefined(self.func_110B7)) {
    self.func_110B7 = [];
  }

  var_01 = [];
  var_02 = self getweaponslistall();

  foreach(var_04 in var_02) {
    var_1[var_04] = [];
    var_1[var_04]["clip_left"] = self getweaponammoclip(var_04, "left");
    var_1[var_04]["clip_right"] = self getweaponammoclip(var_04, "right");
    var_1[var_04]["stock"] = self getweaponammostock(var_04);
  }

  if(!isDefined(var_00)) {
    var_00 = "default";
  }

  self.func_110B7[var_00] = [];
  self.func_110B7[var_00]["current_weapon"] = self getcurrentweapon();
  self.func_110B7[var_00]["inventory"] = var_01;
}

func_E2CF(var_00, var_01) {
  if(!isDefined(var_00)) {
    var_00 = "default";
  }

  if(!isDefined(self.func_110B7) || !isDefined(self.func_110B7[var_00])) {
    return;
  }
  self takeallweapons();

  foreach(var_04, var_03 in self.func_110B7[var_00]["inventory"]) {
    if(weaponinventorytype(var_04) != "altmode") {
      self giveweapon(var_04);
    }

    self setweaponammoclip(var_04, var_3["clip_left"], "left");
    self setweaponammoclip(var_04, var_3["clip_right"], "right");
    self setweaponammostock(var_04, var_3["stock"]);
  }

  var_05 = self.func_110B7[var_00]["current_weapon"];

  if(var_05 != "none") {
    if(scripts\engine\utility::is_true(var_01)) {
      self switchtoweaponimmediate(var_05);
    } else {
      self switchtoweapon(var_05);
    }
  }
}

func_8E7E() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1) {
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
  }
}

func_100D7() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1) {
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
  }
}

func_F492(var_00, var_01) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_01)) {
    var_02 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_03 = var_00 - var_02;
    var_04 = 0.05;
    var_05 = var_01 / var_04;

    for(var_06 = var_03 / var_05; abs(var_00 - var_02) > abs(var_06 * 1.1); var_02 = scripts\asm\asm::asm_getmoveplaybackrate()) {
      scripts\asm\asm::func_237B(var_02 + var_06);
      wait(var_04);
    }
  }

  scripts\asm\asm::func_237B(var_00);
}

func_22C7(var_00, var_01, var_02, var_03, var_04, var_05) {
  foreach(var_07 in var_00) {
    var_07 thread func_1747(var_01, var_02, var_03, var_04, var_05);
  }
}

func_22CA(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = _getspawnerarray(var_00);
  var_06 = func_22A2(var_06, getEntArray(var_00, "targetname"));
  func_22C7(var_06, var_01, var_02, var_03, var_04, var_05);
}

func_22C9(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = func_7C84(var_00, "script_noteworthy");
  var_06 = func_22A2(var_06, getEntArray(var_00, "script_noteworthy"));
  func_22C7(var_06, var_01, var_02, var_03, var_04, var_05);
}

func_22C8(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = func_77DF(var_00);
  func_22C7(var_06, var_01, var_02, var_03, var_04, var_05);
}

func_61ED() {
  self.dontevershoot = 1;
}

func_551B() {
  self.dontevershoot = undefined;
}

func_4960(var_00) {
  if(!isDefined(level.func_11220)) {
    level.func_11220 = [];
  }

  var_01 = spawnStruct();
  var_1.name = var_00;
  level.func_11220[var_00] = var_01;
  return var_01;
}

func_6245() {
  thread func_6246();
}

func_6246() {
  self endon("death");

  for(;;) {
    self.func_115CE = 1;
    wait 0.05;
  }
}

func_5590() {
  self.func_115CE = undefined;
}

func_9A4D() {
  var_00 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_00;
}

func_B3CB(var_00) {
  var_01 = func_9A4D();
  var_02 = [];

  foreach(var_04 in var_01) {
    var_05 = getEntArray(var_4[0], var_4[1]);
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  foreach(var_08 in var_02) {
    if(!isDefined(level.func_12EF[var_8.func_9A4B].func_EB78)) {
      continue;
    }
    foreach(var_11 in var_00) {
      if(!var_11 istouching(var_08)) {
        continue;
      }
      if(!isDefined(var_11.func_9A4E)) {
        var_11.func_9A4E = [];
      }

      var_11.func_9A4E[var_11.func_9A4E.size] = var_08[[level.func_12EF[var_8.func_9A4B].func_EB78]]();
    }
  }
}

func_15BD() {
  if(!isDefined(self.func_9A4E)) {
    return;
  }
  foreach(var_01 in self.func_9A4E) {
    var_01[[level.func_12EF[var_1.func_9A4B].func_AE17]]();
  }

  self.func_9A4E = undefined;
}

func_515D(var_00) {
  func_B3CB(var_00);

  foreach(var_02 in var_00) {
    var_2.func_9A4E = undefined;
  }
}

func_B3CA(var_00) {
  if(getdvar("createfx") != "") {
    return;
  }
  var_01 = getEntArray("script_brushmodel", "classname");
  var_02 = getEntArray("script_model", "classname");

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_1[var_1.size] = var_2[var_03];
  }

  foreach(var_05 in var_00) {
    foreach(var_07 in var_01) {
      if(isDefined(var_7.script_prefab_exploder)) {
        var_7.targetname = var_7.script_prefab_exploder;
      }

      if(!isDefined(var_7.targetname)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
        continue;
      }
      if(var_7.code_classname != "script_model") {
        continue;
      }
      if(!var_07 istouching(var_05)) {
        continue;
      }
      var_7.masked_exploder = 1;
    }
  }
}

func_15AD() {
  var_00 = spawn("script_origin", (0, 0, 0));

  foreach(var_02 in level.createfxent) {
    if(!isDefined(var_2.v["masked_exploder"])) {
      continue;
    }
    var_0.origin = var_2.v["origin"];
    var_0.angles = var_2.v["angles"];

    if(!var_00 istouching(self)) {
      continue;
    }
    var_03 = var_2.v["masked_exploder"];
    var_04 = var_2.v["masked_exploder_spawnflags"];
    var_05 = var_2.v["masked_exploder_script_disconnectpaths"];
    var_06 = spawn("script_model", (0, 0, 0), var_04);
    var_06 setModel(var_03);
    var_6.origin = var_2.v["origin"];
    var_6.angles = var_2.v["angles"];
    var_2.v["masked_exploder"] = undefined;
    var_2.v["masked_exploder_spawnflags"] = undefined;
    var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_6.disconnect_paths = var_05;
    var_6.targetname = var_2.v["exploder"];
    scripts\common\exploder::setup_individual_exploder(var_06);
    var_2.model = var_06;
  }

  var_00 delete();
}

func_5146(var_00, var_01) {
  foreach(var_03 in var_00) {
    var_3.func_5379 = [];
  }

  var_05 = ["destructible_toy", "destructible_vehicle"];
  var_06 = 0;

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  foreach(var_08 in var_05) {
    var_09 = getEntArray(var_08, "targetname");

    foreach(var_11 in var_09) {
      foreach(var_03 in var_00) {
        if(var_01) {
          var_6++;
          var_06 = var_06 % 5;

          if(var_06 == 1) {
            wait 0.05;
          }
        }

        if(!var_03 istouching(var_11)) {
          continue;
        }
        var_11 delete();
        break;
      }
    }
  }
}

func_5153(var_00, var_01) {
  var_02 = getEntArray("script_brushmodel", "classname");
  var_03 = getEntArray("script_model", "classname");

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    var_2[var_2.size] = var_3[var_04];
  }

  var_05 = [];
  var_06 = spawn("script_origin", (0, 0, 0));
  var_07 = 0;

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  foreach(var_09 in var_00) {
    foreach(var_11 in var_02) {
      if(!isDefined(var_11.targetname)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_09 istouching(var_06)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  func_228A(var_05);
  var_06 delete();
}

setflashbangimmunity(var_00) {
  self.func_6EC4 = var_00;
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

func_6EC6(var_00) {
  if(isDefined(self.func_6EC4) && self.func_6EC4) {
    return;
  }
  var_01 = gettime() + var_00 * 1000.0;

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
    var_00 = _getaispeciesarray("axis", "all");
    var_01 = 0;

    foreach(var_03 in var_00) {
      if(!isalive(var_03)) {
        continue;
      }
      if(var_03 istouching(self)) {
        var_01 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_01) {
      var_05 = func_77E3("axis");

      if(!var_5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

func_13822() {
  var_00 = 0;

  for(;;) {
    var_01 = _getaispeciesarray("axis", "all");
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

      wait 0.0125;
    }

    if(!var_02) {
      var_06 = func_77E3("axis");

      if(!var_6.size) {
        break;
      } else
        var_00 = 1;
    }

    wait 0.05;
  }

  return var_00;
}

func_13823(var_00) {
  func_13821();
  scripts\engine\utility::flag_set(var_00);
}

func_1380D(var_00, var_01) {
  var_02 = getent(var_00, "targetname");
  var_02 func_13823(var_01);
}

func_D0F4() {
  if(isplayer(self)) {
    var_00 = self;
  } else {
    var_00 = level.player;
  }

  return isDefined(var_0.space) && var_0.space.func_6F43;
}

func_CFAA() {
  level.player func_65DD("player_zero_attacker_accuracy");
  level.player.ignorerandombulletdamage = 0;
  level.player scripts\sp\gameskill::func_12E0B();
}

func_CFB8() {
  level.player func_65E1("player_zero_attacker_accuracy");
  level.player.attackeraccuracy = 0;
  level.player.ignorerandombulletdamage = 1;
}

func_F520(var_00) {
  var_01 = func_7B92();
  var_1.gs.func_CF81 = var_00;
  var_01 scripts\sp\gameskill::func_12E0B();
}

func_2298(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    var_1[var_3.script_parameters] = var_03;
  }

  return var_01;
}

func_2297(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    var_1[var_3.classname] = var_03;
  }

  return var_01;
}

func_2299(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(isDefined(var_3.script_index)) {
      var_1[var_3.script_index] = var_03;
    }
  }

  return var_01;
}

func_78D5() {
  var_00 = scripts\sp\utility_code::func_78D1();
  var_01 = var_0["team"];

  foreach(var_03 in var_0["codes"]) {
    var_04 = level.func_22DF[var_01][var_03];

    if(isDefined(var_04)) {
      return var_04;
    }
  }

  return undefined;
}

func_78D3() {
  var_00 = scripts\sp\utility_code::func_78D1();
  var_01 = var_0["team"];

  foreach(var_03 in var_0["codes"]) {
    var_04 = level.func_22DD[var_01][var_03];

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

func_7E96(var_00, var_01) {
  var_02 = getent(var_00, var_01);

  if(isDefined(var_02)) {
    return var_02;
  }

  return scripts\engine\utility::getstruct(var_00, var_01);
}

func_7C9A(var_00) {
  return _getcsplineid(var_00);
}

func_7C9B(var_00) {
  return _getcsplineidarray(var_00);
}

grenade_earthquake() {
  thread scripts\sp\utility_code::endondeath();
  self endon("end_explode");
  self waittill("explode", var_00);
  func_7751(var_00);
}

func_7751(var_00) {
  func_5FC7(var_00);
  func_54EF(var_00);
}

func_5FC7(var_00) {
  playrumbleonentity("grenade_rumble", var_00);
  earthquake(0.4, 0.5, var_00, 400);
}

func_54EF(var_00) {
  if(level.player _meth_853E()) {
    return;
  }
  if(!isDefined(level.player.func_A8FD)) {
    level.player.func_A8FD = gettime();
  } else if(gettime() - level.player.func_A8FD < 3000) {
    return;
  }
  level.player.func_A8FD = gettime();

  foreach(var_02 in level.players) {
    if(distance(var_00, var_2.origin) > 600) {
      continue;
    }
    if(var_02 damageconetrace(var_00)) {
      var_02 thread dirteffect(var_00);
    }
  }
}

dirteffect(var_00, var_01) {
  var_02 = func_ECC4(var_00);

  foreach(var_05, var_04 in var_02) {
    thread scripts\sp\gameskill::forcehidegrenadehudwarning(var_05);
  }
}

func_2BC6(var_00) {
  if(!isDefined(self.damageattacker)) {
    return;
  }
  var_01 = func_ECC4(self.damageattacker.origin);

  foreach(var_04, var_03 in var_01) {
    thread scripts\sp\gameskill::func_2BC1(var_04);
  }
}

func_ECC4(var_00) {
  var_01 = vectornormalize(anglesToForward(self.angles));
  var_02 = vectornormalize(anglestoright(self.angles));
  var_03 = vectornormalize(var_00 - self.origin);
  var_04 = vectordot(var_03, var_01);
  var_05 = vectordot(var_03, var_02);
  var_06 = [];
  var_07 = self getcurrentweapon();

  if(var_04 > 0 && var_04 > 0.5 && weapontype(var_07) != "riotshield") {
    var_6["bottom"] = 1;
  }

  if(abs(var_04) < 0.866) {
    if(var_05 > 0) {
      var_6["right"] = 1;
    } else {
      var_6["left"] = 1;
    }
  }

  return var_06;
}

func_C971(var_00) {
  if(!isDefined(self.func_C3D0)) {
    self.func_C3D0 = self.pathrandompercent;
  }

  self.pathrandompercent = var_00;
}

func_C972() {
  if(isDefined(self.func_C3D0)) {
    return;
  }
  self.func_C3D0 = self.pathrandompercent;
  self.pathrandompercent = 0;
}

func_C970() {
  self.pathrandompercent = self.func_C3D0;
  self.func_C3D0 = undefined;
}

func_13876() {
  if(isDefined(self.func_C3E3)) {
    return;
  }
  self.func_C3E2 = self.walkdist;
  self.func_C3E3 = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

func_13875() {
  self.walkdist = self.func_C3E2;
  self.walkdistfacingmotion = self.func_C3E3;
  self.func_C3E2 = undefined;
  self.func_C3E3 = undefined;
}

func_6205() {
  thread func_9330();
}

func_9330() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self.func_6B4B = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_00, var_01);

    if(!isplayer(var_01) && issentient(var_01)) {
      if(isDefined(var_1.enemy) && var_1.enemy != self) {
        continue;
      }
    }

    self.func_6B4B = self.func_6B4B - var_00;

    if(self.func_6B4B <= 0) {
      break;
    }
  }

  self _meth_81D0();
}

func_8E9A() {
  if(!isDefined(self.func_C3E9)) {
    self.func_C3E9 = self setcontents(0);
  }

  self hide();
}

func_100FC() {
  if(!isai(self)) {
    self solid();
  }

  if(isDefined(self.func_C3E9)) {
    self setcontents(self.func_C3E9);
  }

  self show();
}

func_F2E7(var_00) {
  self.veh_brake = var_00;
}

func_553C() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.ignorerandombulletdamage)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self.ignorerandombulletdamage = undefined;
  self.health = self.func_6B4B;
}

func_11905(var_00) {
  var_01 = spawnStruct();
  var_01 scripts\engine\utility::delaythread(var_00, ::func_F225, "timeout");
  return var_01;
}

func_50E4(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  childthread scripts\sp\utility_code::func_50E5(var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07);
}

func_6E7C(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isarray(var_00)) {
    var_00 = [var_00, 0];
  }

  thread scripts\sp\utility_code::func_6E7D(var_01, var_00, var_02, var_03, var_04, var_05, var_06);
}

func_13843(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");

  if(!isarray(var_00)) {
    var_00 = [var_00, 0];
  }

  thread scripts\sp\utility_code::func_13844(var_01, var_00, var_02, var_03, var_04, var_05, var_06);
}

func_61EB(var_00) {
  var_00 = var_00 * 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var_00;
  self.func_BEFA = undefined;
}

func_5517() {
  self.dodangerreact = 0;
  self.func_BEFA = 1;
}

func_F3EC(var_00, var_01) {
  level.func_18D7 = var_00;
  level.func_18D6 = var_01;
}

func_E1F2(var_00) {
  level.func_A936[var_00] = gettime();
}

func_F323(var_00) {
  level.func_4C53 = var_00;
  thread scripts\sp\gameskill::func_E26C();
}

func_4140() {
  level.func_4C53 = undefined;
  thread scripts\sp\gameskill::func_E26C();
}

func_11147(var_00) {
  if(var_0.size > 1) {
    return 0;
  }

  var_01 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if(isDefined(var_1[var_00])) {
    return 1;
  }

  return 0;
}

func_F2DC(var_00, var_01) {
  level.func_28CF[var_00] = var_01;
  scripts\sp\utility_code::func_12D95();
}

func_C27B(var_00) {
  for(var_01 = 0; var_01 < 8; var_1++) {
    _objective_additionalposition(var_00, var_01, (0, 0, 0));
  }
}

func_7AE6(var_00) {
  var_01 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_00 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60) {
    var_1["minutes"]++;
  }

  if(var_1["seconds"] < 10) {
    var_1["seconds"] = "0" + var_1["seconds"];
  }

  return var_01;
}

func_D0CA(var_00) {
  var_01 = level.player getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(var_03 == var_00) {
      return 1;
    }
  }

  return 0;
}

func_D0BD(var_00, var_01) {
  var_02 = level.player getweaponslistall();

  foreach(var_04 in var_02) {
    if(var_04 == var_00) {
      return 1;
    }
  }

  if(isDefined(var_01) && var_01 == 1) {
    if(level.player.func_110BD == var_00) {
      return 1;
    }

    if(level.player.func_110BA == var_00) {
      return 1;
    }
  }

  return 0;
}

func_D0BE(var_00) {
  if(level.player.func_110BD == var_00) {
    return 1;
  }

  if(level.player.func_110BA == var_00) {
    return 1;
  }

  return 0;
}

func_C264(var_00) {
  if(!isDefined(level.func_C265)) {
    level.func_C265 = [];
  }

  if(!isDefined(level.func_C265[var_00])) {
    level.func_C265[var_00] = level.func_C265.size + 1;
  }

  return level.func_C265[var_00];
}

func_C268(var_00) {
  return isDefined(level.func_C265) && isDefined(level.func_C265[var_00]);
}

_meth_848C(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_04 - var_02;
  var_06 = var_03 - var_01;
  var_07 = var_05 / var_06;
  var_00 = var_00 - var_03;
  var_00 = var_07 * var_00;
  var_00 = var_00 + var_04;
  return var_00;
}

func_BDF1(var_00) {
  var_01 = lookupsoundlength(var_00);
  var_01 = var_01 * 0.001;
  return var_01;
}

func_9B9D(var_00) {
  var_01 = _getkeybinding(var_00);
  return var_1["count"];
}

func_ACED(var_00, var_01, var_02) {
  var_03 = var_02 - var_01;
  var_04 = var_00 * var_03;
  var_05 = var_01 + var_04;
  return var_05;
}

func_509E(var_00) {
  level.func_AE21 = var_00;
}

func_50A0(var_00) {
  switch (var_00) {
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

func_116CB(var_00) {
  func_509E(var_00);
  level.template_script = var_00;
  func_50A0(var_00);
}

func_116CD(var_00) {
  level.func_25FA = var_00;
}

func_7616(var_00, var_01) {
  thread func_7617(var_00, var_01);
}

func_7617(var_00, var_01) {
  var_02 = getent(var_00, "script_noteworthy");
  var_02 notify("new_volume_command");
  var_02 endon("new_volume_command");
  wait 0.05;
  scripts\sp\utility_code::func_7615(var_02, var_01);
}

func_7619(var_00) {
  thread func_761A(var_00);
}

func_761A(var_00) {
  var_01 = getent(var_00, "script_noteworthy");
  var_01 notify("new_volume_command");
  var_01 endon("new_volume_command");
  wait 0.05;

  if(!isDefined(var_1.func_75BA)) {
    return;
  }
  var_1.func_75BA = undefined;
  func_7618(var_01);
}

func_7618(var_00) {
  scripts\engine\utility::array_thread(var_0.fx, ::func_E2B0);
}

func_16AE(var_00, var_01) {
  if(!isDefined(level.func_4074)) {
    level.func_4074 = [];
  }

  if(!isDefined(level.func_4074[var_01])) {
    level.func_4074[var_01] = [];
  }

  level.func_4074[var_01][level.func_4074[var_01].size] = var_00;
}

func_4074(var_00) {
  var_01 = level.func_4074[var_00];
  var_01 = scripts\engine\utility::array_removeundefined(var_01);
  func_228A(var_01);
  level.func_4074[var_00] = undefined;
}

func_4075(var_00) {
  if(!isDefined(level.func_4074)) {
    return;
  }
  if(!isDefined(level.func_4074[var_00])) {
    return;
  }
  var_01 = level.func_4074[var_00];
  var_01 = scripts\engine\utility::array_removeundefined(var_01);

  foreach(var_03 in var_01) {
    if(!isai(var_03)) {
      continue;
    }
    if(!isalive(var_03)) {
      continue;
    }
    if(!isDefined(var_3.func_B14F)) {
      continue;
    }
    if(!var_3.func_B14F) {
      continue;
    }
    var_03 func_1101B();
  }

  func_228A(var_01);
  level.func_4074[var_00] = undefined;
}

func_178A(var_00) {
  if(!isDefined(self.func_1274A)) {
    thread scripts\sp\utility_code::func_1789();
  }

  self.func_1274A[self.func_1274A.size] = var_00;
}

func_7DB7() {
  var_00 = [];
  var_01 = getEntArray();

  foreach(var_03 in var_01) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(var_3.classname, "weapon_")) {
      var_0[var_0.size] = var_03;
    }
  }

  return var_00;
}

func_BCA1(var_00, var_01, var_02) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_02)) {
    var_02 = 200;
  }

  var_03 = distance(self.origin, var_00);
  var_04 = var_03 / var_02;
  var_05 = vectornormalize(var_00 - self.origin);
  self moveto(var_00, var_04, 0, 0);
  self rotateto(var_01, var_04, 0, 0);
  wait(var_04);

  if(!isDefined(self)) {
    return;
  }
  self.velocity = var_05 * (var_03 / var_04);
}

func_6E3D(var_00) {
  level endon(var_00);
  self waittill("death");
  scripts\engine\utility::flag_set(var_00);
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

func_51D5(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::getstructarray(var_00, var_01);
  func_51D6(var_03, var_02);
}

func_51D4(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_0.script_linkname;

  if(isDefined(var_01) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["script_linkname"][var_01]) {
      if(isDefined(var_03) && var_00 == var_03) {
        level.struct_class_names["script_linkname"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_01].size == 0) {
      level.struct_class_names["script_linkname"][var_01] = undefined;
    }
  }

  var_01 = var_0.script_noteworthy;

  if(isDefined(var_01) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["script_noteworthy"][var_01]) {
      if(isDefined(var_03) && var_00 == var_03) {
        level.struct_class_names["script_noteworthy"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_01].size == 0) {
      level.struct_class_names["script_noteworthy"][var_01] = undefined;
    }
  }

  var_01 = var_0.target;

  if(isDefined(var_01) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["target"][var_01]) {
      if(isDefined(var_03) && var_00 == var_03) {
        level.struct_class_names["target"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_01].size == 0) {
      level.struct_class_names["target"][var_01] = undefined;
    }
  }

  var_01 = var_0.targetname;

  if(isDefined(var_01) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_01])) {
    foreach(var_04, var_03 in level.struct_class_names["targetname"][var_01]) {
      if(isDefined(var_03) && var_00 == var_03) {
        level.struct_class_names["targetname"][var_01][var_04] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_01].size == 0) {
      level.struct_class_names["targetname"][var_01] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_04, var_03 in level.struct) {
      if(var_00 == var_03) {
        level.struct[var_04] = undefined;
      }
    }
  }
}

func_51D6(var_00, var_01) {
  if(!isDefined(var_00) || !isarray(var_00) || var_0.size == 0) {
    return;
  }
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 0);
  var_01 = scripts\engine\utility::ter_op(var_01 > 0, var_01, 0);

  if(var_01 > 0) {
    foreach(var_03 in var_00) {
      func_51D4(var_03);
      wait(var_01);
    }
  } else {
    foreach(var_03 in var_00) {
      func_51D4(var_03);
    }
  }
}

getstruct_delete(var_00, var_01) {
  var_02 = scripts\engine\utility::getstruct(var_00, var_01);
  func_51D4(var_02);
  return var_02;
}

_meth_8181(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::getstructarray(var_00, var_01);
  func_51D6(var_03, var_02);
  return var_03;
}

func_13DCC(var_00) {
  var_01 = var_00 - self.origin;
  return (vectordot(var_01, anglesToForward(self.angles)), -1.0 * vectordot(var_01, anglestoright(self.angles)), vectordot(var_01, anglestoup(self.angles)));
}

func_10460(var_00, var_01) {
  self ghostattack(0, var_00);

  if(scripts\engine\utility::is_true(var_01)) {
    scripts\engine\utility::delaycall(var_00 + 0.05, ::stoploopsound);
  } else {
    scripts\engine\utility::delaycall(var_00 + 0.05, ::stopsounds);
  }

  scripts\engine\utility::delaycall(var_00 + 0.1, ::delete);
}

func_10461(var_00, var_01, var_02, var_03) {
  self endon("death");
  var_01 = clamp(var_01, 0, 1);
  var_02 = max(0.05, var_02);
  self ghostattack(0.0);
  wait 0.05;

  if(isDefined(var_03)) {
    self playLoopSound(var_00);
  } else {
    self playSound(var_00);
  }

  wait 0.05;
  scripts\engine\utility::delaycall(0.05, ::ghostattack, var_01, var_02);
}

func_5188() {
  self waittill("sounddone");
  self delete();
}

func_5184(var_00) {
  self waittill(var_00);
  self delete();
}

func_9ACE(var_00, var_01, var_02, var_03, var_04) {
  level.func_9AF3 = spawnStruct();
  level.func_9AF3.func_4480 = 3;
  level.func_9AF3.func_6AAA = 1.5;
  level.func_9AF3.func_6A9F = undefined;

  if(isDefined(var_03)) {
    level.func_9AF3.func_ACF2 = [var_00, var_01, var_02, var_03];
  } else {
    level.func_9AF3.func_ACF2 = [var_00, var_01, var_02];
  }

  scripts\engine\utility::noself_array_call(level.func_9AF3.func_ACF2, ::precachestring);
}

func_9ACF(var_00) {
  level.func_9AF3.func_4C88 = var_00;
}

func_9AD0(var_00, var_01, var_02) {
  level.func_9AF3.func_4480 = var_00;
  level.func_9AF3.func_6AAA = var_01;
  level.func_9AF3.func_6A9F = var_02;
}

func_DE97(var_00, var_01, var_02) {
  scripts\anim\animset::func_DEE7(var_00, var_01, var_02);
}

func_2124(var_00) {
  return scripts\anim\animset::func_2126(var_00);
}

func_F2C8(var_00) {
  self.func_1F62 = var_00;
  self notify("move_loop_restart");

  if(var_00 == "creepwalk") {
    self.sharpturnlookaheaddist = 72;
  }
}

func_412C() {
  if(isDefined(self.func_1F62) && self.func_1F62 == "creepwalk") {
    self.sharpturnlookaheaddist = 30;
  }

  self.func_1F62 = undefined;
  self notify("move_loop_restart");
}

func_12641(var_00) {
  if(_istransientloaded(var_00)) {
    return;
  }
  if(!scripts\engine\utility::flag_exist(var_00 + "_loaded")) {
    scripts\engine\utility::flag_init(var_00 + "_loaded");
  }

  _loadtransient(var_00);

  while(!_istransientloaded(var_00)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set(var_00 + "_loaded");
  level notify("new_transient_loaded");
}

func_1264E(var_00) {
  if(!_istransientloaded(var_00)) {
    return;
  }
  _unloadtransient(var_00);

  while(_istransientloaded(var_00)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_clear(var_00 + "_loaded");
}

func_12643(var_00) {
  foreach(var_02 in var_00) {
    thread func_12641(var_02);
  }

  for(;;) {
    var_04 = 1;

    foreach(var_02 in var_00) {
      if(!_istransientloaded(var_02)) {
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

func_12651(var_00) {
  foreach(var_02 in var_00) {
    thread func_1264E(var_02);
  }

  for(;;) {
    var_04 = 1;

    foreach(var_02 in var_00) {
      if(_istransientloaded(var_02)) {
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

func_1263F(var_00) {
  scripts\engine\utility::flag_init(var_00 + "_loaded");
}

func_1264C(var_00, var_01) {
  if(scripts\engine\utility::flag(var_00 + "_loaded")) {
    func_1264E(var_00);
  }

  if(!scripts\engine\utility::flag(var_01 + "_loaded")) {
    func_12641(var_01);
  }
}

func_12653(var_00) {
  _unloadalltransients();
  func_12641(var_00);
}

func_F6DB(var_00, var_01, var_02) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    setdvar(var_00, var_02);
  } else {
    setdvar(var_00, var_01);
  }
}

func_F828(var_00, var_01, var_02) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    _setsaveddvar(var_00, var_02);
  } else {
    _setsaveddvar(var_00, var_01);
  }
}

func_7227(var_00, var_01) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_02 = var_00;
  var_03 = undefined;
  var_04 = undefined;

  if(!isDefined(var_01)) {
    var_01 = 300;
  }

  self.func_4B76 = var_02;
  var_02 script_delay();

  while(isDefined(var_02)) {
    self.func_4B76 = var_02;

    if(isDefined(var_2.lookahead)) {
      break;
    }
    if(isDefined(level.struct_class_names["targetname"][var_2.targetname])) {
      var_04 = ::func_722A;
    } else if(isDefined(var_2.classname)) {
      var_04 = ::func_7228;
    } else {
      var_04 = ::func_7229;
    }

    if(isDefined(var_2.radius) && var_2.radius != 0) {
      self.goalradius = var_2.radius;
    }

    if(self.goalradius < 16) {
      self.goalradius = 16;
    }

    if(isDefined(var_2.height) && var_2.height != 0) {
      self.goalheight = var_2.height;
    }

    var_05 = self.goalradius;
    self childthread[[var_04]](var_02);

    if(isDefined(var_2.animation)) {
      var_02 waittill(var_2.animation);
    } else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_05 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_02 notify("trigger", self);

    if(isDefined(var_2.func_ED9E)) {
      scripts\engine\utility::flag_set(var_2.func_ED9E);
    }

    if(isDefined(var_2.script_parameters)) {
      var_06 = strtok(var_2.script_parameters, " ");

      for(var_07 = 0; var_07 < var_6.size; var_7++) {
        if(isDefined(level.func_4C50)) {
          self[[level.func_4C50]](var_6[var_07], var_02);
        }

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_07]) {
          case "enable_cqb":
            func_61E7();
            break;
          case "disable_cqb":
            func_5514();
            break;
          case "deleteme":
            self delete();
            return;
        }
      }
    }

    if(!isDefined(var_2.func_EE95) && var_01 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(func_722C(var_02, var_01)) {
          break;
        }
        if(isDefined(var_2.animation)) {
          self.goalradius = var_05;
          self give_mp_super_weapon(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }
    if(isDefined(var_2.func_EDA0)) {
      scripts\engine\utility::flag_wait(var_2.func_EDA0);
    }

    var_02 script_delay();
    var_02 = var_02 scripts\engine\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

func_722C(var_00, var_01) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin)) {
    return 1;
  }

  var_02 = undefined;
  var_02 = anglesToForward(self.angles);
  var_03 = vectornormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_04 = scripts\engine\utility::get_target_ent(var_0.target);
    var_02 = vectornormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_02 = anglesToForward(var_0.angles);
  else {
    var_02 = anglesToForward(self.angles);
  }

  if(vectordot(var_02, var_03) > 0) {
    return 1;
  }

  if(distance(level.player.origin, self.origin) < var_01) {
    return 1;
  }

  return 0;
}

func_7229(var_00) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_00 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_00 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_00 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    self give_mp_super_weapon(self.origin);
  } else
    func_F3D9(var_00);
}

func_7228(var_00) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_00 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_00 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_00 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    self give_mp_super_weapon(self.origin);
  } else
    func_F3D3(var_00);
}

func_722A(var_00) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_00 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    func_5528();

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_00 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_00 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    scripts\engine\utility::delaythread(0.05, ::func_61F7);
    self give_mp_super_weapon(self.origin);
  } else
    func_F3DC(var_0.origin);
}

func_D6D9(var_00) {
  if(!isDefined(level.func_D6D8)) {
    level.func_D6D8 = [];
  }

  level.func_D6D8 = scripts\engine\utility::array_add(level.func_D6D8, var_00);
}

func_765B() {
  if(level.func_13E0F) {
    return 1;
  }

  if(level.func_DADB) {
    return 1;
  }

  return 0;
}

func_12B17(var_00) {
  var_01 = "ui_actionslot_" + var_00 + "_forceActive";
  setdvar(var_01, "on");
}

func_12B16(var_00) {
  var_01 = "ui_actionslot_" + var_00 + "_forceActive";
  setdvar(var_01, "turn_off");
}

func_12B18(var_00) {
  var_01 = "ui_actionslot_" + var_00 + "_forceActive";
  setdvar(var_01, "onetime");
}

hastag(var_00, var_01) {
  if(!isDefined(level.has_tag)) {
    level.has_tag = [];
  }

  var_02 = var_00 + "_" + var_01;

  if(isDefined(level.has_tag[var_02])) {
    return level.has_tag[var_02];
  }

  var_03 = _getnumparts(var_00);

  if(var_03 > 0) {
    for(var_04 = 0; var_04 < var_03; var_4++) {
      var_05 = tolower(_getpartname(var_00, var_04));

      if(var_05 == tolower(var_01)) {
        level.has_tag[var_02] = 1;
        return 1;
      }
    }

    level.has_tag[var_02] = 0;
  }

  return 0;
}

func_1119E(var_00, var_01, var_02, var_03) {
  if(!isarray(var_00)) {
    var_00 = [var_00];
  }

  var_04 = 320;
  var_05 = 200;
  var_06 = [];

  foreach(var_10, var_08 in var_00) {
    var_09 = scripts\sp\introscreen::func_111A0(var_08, var_01, var_04, var_05 + var_10 * 20, "center", var_02, var_03);
    var_06 = scripts\engine\utility::array_combine(var_09, var_06);
  }

  wait(var_01);
  scripts\sp\introscreen::func_1119F(var_06, var_04, var_05, var_0.size);
}

func_97A2() {
  if(!scripts\engine\utility::add_init_script("waits", ::func_97A2)) {
    return;
  }
  level.func_13711 = spawnStruct();
  level.func_13711.func_13590 = [];
  level.func_13711.func_E7F9 = [];
  level.func_13711.func_E7E0 = [];
  level.func_13711.func_E80A = [];
  level.func_13711.func_57D7 = [];
  level.func_13711.func_1523 = [];
}

func_F5AF(var_00, var_01) {
  var_02 = [];

  if(isstring(var_00)) {
    var_02 = scripts\engine\utility::get_target_array(var_00);
  } else if(isarray(var_00)) {
    var_02 = var_00;
  }

  if(var_2.size == 0) {
    return;
  }
  foreach(var_04 in var_01) {
    var_05 = undefined;

    foreach(var_07 in var_02) {
      if(!isDefined(var_7.script_noteworthy)) {
        continue;
      }
      if(isplayer(var_04)) {
        if(var_7.script_noteworthy == "player") {
          var_05 = var_07;
          break;
        }
      } else if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_7.script_noteworthy) {
        var_05 = var_07;
        break;
      }
    }

    if(isDefined(var_05)) {
      var_5.func_1146E = 1;
      var_4.func_10CBA = var_05;

      if(isai(var_04)) {
        var_04 give_mp_super_weapon(var_5.origin);
      }

      var_04 func_11624(var_05);
    }
  }

  foreach(var_04 in var_01) {
    if(isDefined(var_4.func_10CBA)) {
      continue;
    }
    foreach(var_07 in var_02) {
      if(!isDefined(var_7.func_1146E)) {
        var_7.func_1146E = 1;
        var_4.func_10CBA = var_07;

        if(isai(var_04)) {
          var_04 give_mp_super_weapon(var_7.origin);
        }

        var_04 func_11624(var_07);
        break;
      }
    }
  }
}

func_A6F2(var_00) {}

func_61F0(var_00) {
  func_0B27::func_5F84(var_00);
}

func_5522() {
  func_0B27::func_5557();
}

func_D08C(var_00, var_01) {
  self endon("death");
  var_02 = 0;
  var_03 = undefined;
  var_04 = 0;

  if(level.player func_7B8C() == "safe") {
    var_03 = 1.0;
    var_04 = 1;
  }

  var_05 = 0;

  if(isDefined(var_01)) {
    var_02 = self playgestureviewmodel(var_00, var_01, var_05, var_03, undefined);
  } else {
    var_02 = self playgestureviewmodel(var_00, undefined, var_05, var_03, undefined);
  }

  return var_02;
}

func_D091(var_00, var_01) {
  self endon("death");

  if(self _meth_819F()) {
    return 0;
  }

  if(self getteamsize()) {
    return 0;
  }

  return func_D090(var_00, var_01);
}

func_D090(var_00, var_01) {
  self endon("death");
  var_02 = 0;
  var_03 = undefined;
  var_04 = 0;

  if(level.player func_7B8C() == "safe") {
    var_03 = 0.2;
    var_04 = 1;
  }

  if(isDefined(var_01) && _isent(var_01)) {
    var_02 = self forceplaygestureviewmodel(var_00, var_01, var_03, undefined, undefined);
  } else {
    var_02 = self forceplaygestureviewmodel(var_00, undefined, var_03, undefined, undefined);
  }

  if(var_02) {
    thread func_0E49::func_D092(var_00, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  }

  return var_02;
}

func_77DB(var_00) {
  return level.func_1162[var_00].func_10878 + level.func_1162[var_00].func_1A09;
}

func_77DD(var_00) {
  level.func_1162[var_00].func_1912 = array_removedeadvehicles(level.func_1162[var_00].func_1912);
  level.func_1162[var_00].func_1912 = scripts\engine\utility::array_removeundefined(level.func_1162[var_00].func_1912);
  return level.func_1162[var_00].func_1A09;
}

func_77DE(var_00) {
  return level.func_1162[var_00].func_10878;
}

func_77DC(var_00) {
  return level.func_1162[var_00].func_1A0D;
}

func_77DF(var_00) {
  return level.func_1162[var_00].spawners;
}

func_77DA(var_00) {
  level.func_1162[var_00].func_1912 = array_removedeadvehicles(level.func_1162[var_00].func_1912);
  level.func_1162[var_00].func_1912 = scripts\engine\utility::array_removeundefined(level.func_1162[var_00].func_1912);
  return level.func_1162[var_00].func_1912;
}

func_75C4(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.func_760A)) {
    func_75CE();
  }

  thread func_75C5(var_00, var_01, var_02, var_03);
}

func_75C5(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_03)) {
    self endon(var_03);
  }

  if(isDefined(var_02)) {
    wait(var_02);
  }

  func_75CD();
  func_1173C(var_01, var_00);
  playFXOnTag(scripts\engine\utility::getfx(var_00), self, var_01);
}

func_75F8(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.func_760A)) {
    func_75CE();
  }

  thread func_75F9(var_00, var_01, var_02, var_03);
}

func_1173C(var_00, var_01) {
  if(self.model == "") {}

  if(!hastag(self.model, var_00)) {
    return;
  }
}

func_75F9(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_03)) {
    self endon(var_03);
  }

  if(isDefined(var_02)) {
    wait(var_02);
  }

  func_75CD();
  func_1173C(var_01, var_00);
  stopFXOnTag(scripts\engine\utility::getfx(var_00), self, var_01);
}

func_75A0(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.func_760A)) {
    func_75CE();
  }

  thread func_75A1(var_00, var_01, var_02, var_03);
}

func_75A1(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_03)) {
    self endon(var_03);
  }

  if(isDefined(var_02)) {
    wait(var_02);
  }

  func_75CD();
  func_1173C(var_01, var_00);
  _killfxontag(scripts\engine\utility::getfx(var_00), self, var_01);
}

func_79E1() {
  self.func_7609++;
  return string(self.func_7609);
}

func_75CE() {
  if(isDefined(self.func_760A)) {
    return;
  }
  self.func_760A = [];
  self.func_7609 = 0;
  thread func_75CF();
}

func_75CF() {
  self endon("death");
  self endon("entitydeleted");
  var_00 = 0;

  for(;;) {
    self waittill("new_fx_call");

    while(self.func_760A.size > 0) {
      var_01 = self.func_760A[0];
      self.func_760A = scripts\engine\utility::array_remove(self.func_760A, var_01);
      self notify(var_01);
      var_0++;

      if(var_00 == 3) {
        wait 0.05;
        var_00 = 0;
      }
    }
  }
}

func_75CD() {
  self endon("death");
  self endon("entitydeleted");
  var_00 = func_79E1();
  self.func_760A = scripts\engine\utility::array_add(self.func_760A, var_00);
  self notify("new_fx_call");
  self waittill(var_00);
}

func_1102B(var_00) {
  if(isDefined(var_00)) {
    self stopgestureviewmodel(var_00);
  } else {
    self stopgestureviewmodel();
  }

  self notify("gesture_stop");
}

func_F526(var_00, var_01) {
  self notify("entering_new_demeanor");

  if(!isDefined(self.func_77C1)) {
    self.func_77C1 = spawnStruct();
  }

  waittillframeend;

  switch (var_00) {
    case "normal":
      func_0E49::func_660C();
      break;
    case "relaxed":
      func_0E49::func_660D();
      break;
    case "safe":
      func_0E49::func_660E(var_01);
      break;
    case "magboots":
      func_0E49::func_660B();
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

func_EBA6(var_00, var_01) {
  func_960B();

  if(isDefined(var_00)) {
    _setsaveddvar("bg_gravity", level.isinphase * var_00);
  }

  if(isDefined(var_01)) {
    _physics_setgravity((0, 0, level._meth_8519 * var_01));
  }
}

func_241F(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(var_00 && !level.func_241D) {
    level.func_241D = var_00;
  } else if(!var_00 && level.func_241D) {
    level.func_241D = var_00;
  }

  if(isDefined(level.func_A056) && isDefined(level.func_A056.func_241A)) {
    [[level.func_A056.func_241A]](level.func_241D);
  }
}

func_F3E4(var_00, var_01) {
  func_960B();

  if(isDefined(var_00)) {
    _setsaveddvar("bg_gravity", var_00);
  }

  if(isDefined(var_01)) {
    _physics_setgravity((0, 0, var_01));
  }
}

func_E1F0() {
  _setsaveddvar("bg_gravity", level.isinphase);
  _physics_setgravity((0, 0, level._meth_8519));
}

func_77B9(var_00) {
  if(isDefined(self.unittype) && self.unittype == "c6") {
    thread func_0C4C::func_1965(var_00);
  } else {
    thread func_0C4C::func_194F(var_00 * 0.1);
    thread func_0C4C::func_1964(var_00);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self.func_D4A4 = undefined;
}

func_77BD(var_00) {
  thread func_0C4C::func_1967(var_00);
}

func_7793(var_00) {
  thread func_0C4C::func_194F(var_00);
}

func_779E(var_00) {
  if(self.unittype == "c6") {
    thread func_0C4C::func_1965(var_00);
  } else {
    func_0C4C::func_1964(var_00);
  }

  self notify("stop_lookat");
}

func_7799(var_00, var_01, var_02) {
  self endon("death");
  thread func_0C4C::func_1955(var_00, var_01, var_02);
}

func_779A(var_00, var_01, var_02, var_03) {
  thread func_0C4C::func_1956(var_00, var_01, var_02, var_03);
}

func_7798(var_00, var_01, var_02) {
  thread func_0C4C::func_194E(var_00, var_01, var_02);
}

func_779C(var_00, var_01) {
  thread func_0C4C::func_1959(var_00, var_01);
}

func_779B(var_00, var_01) {
  func_0C4C::func_196A(var_00, var_01);
}

func_7797(var_00, var_01) {
  func_0C4C::func_1969(var_00, var_01);
}

func_77A9(var_00) {
  func_0C4C::func_195D(var_00);
}

func_77B7(var_00) {
  func_0C4C::func_1960(var_00);
}

func_7791(var_00, var_01, var_02) {
  func_0C4C::func_194C(var_00, var_01, var_02);
}

func_7790(var_00, var_01) {
  func_0C4C::func_192F(var_00, var_01);
}

func_7792(var_00, var_01) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");

  if(!isDefined(self.func_9BDC)) {
    thread func_7798(var_00, 4.0, 0.1);
  }

  if(isDefined(var_01) && var_01) {
    thread func_7799(var_00, 0.15, 0.7);
  }

  wait 0.7;

  for(;;) {
    thread func_7797(var_00, 2.0);
    wait(randomfloatrange(3.0, 5.0));
    var_02 = var_00 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread func_7797(var_02, 2.0);
    wait(randomfloatrange(0.25, 0.5));

    if(scripts\engine\utility::cointoss()) {
      var_02 = var_00 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread func_7797(var_02, 2.0);
      wait(randomfloatrange(0.25, 0.5));
    }
  }
}

func_77B8(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("gesture_stop");
  var_04 = squared(var_01);
  scripts\sp\interaction_manager::func_168F();
  var_05 = distance2dsquared(self.origin, var_2.origin);

  for(;;) {
    if(var_05 < var_04 && scripts\sp\interaction_manager::func_3838(var_01 * 3.0)) {
      break;
    }
    var_05 = distance2dsquared(self.origin, var_2.origin);
    scripts\engine\utility::waitframe();
  }

  self.func_D4A4 = 1;

  if(isDefined(var_03)) {
    thread func_77B7(var_00);
    self[[var_03]]();
  } else
    func_77B7(var_00);

  wait 2.0;
  scripts\sp\interaction_manager::func_DFB5();
  self.func_D4A4 = 0;
}

func_D123() {
  var_00 = level.player _meth_8473();

  if(isDefined(var_00)) {
    return 1;
  } else {
    return 0;
  }
}

func_7B9D() {
  return level.func_D127.func_B154 / scripts\sp\gameskill::func_7A59();
}

func_A1A8(var_00) {
  if(!isDefined(level.func_A056)) {
    return 0;
  }

  if(!isDefined(level.func_A056.func_68B3)) {
    return 0;
  }

  if(!isDefined(var_00)) {
    return level.func_A056.func_68B3.running;
  } else if(!isDefined(level.func_A056.func_68B3.func_68B6[var_00])) {
    return 0;
  } else {
    return level.func_A056.func_68B3.func_68B6[var_00].running;
  }
}

func_13793() {
  while(func_A1A8()) {
    wait 0.05;
  }
}

func_13792(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  while(!isDefined(level.func_A056.func_68B3.func_68B6[var_00])) {
    wait 0.05;
  }

  while(!func_A1A8(var_00)) {
    wait 0.05;
  }

  if(var_01) {
    while(func_A1A8(var_00)) {
      wait 0.05;
    }
  }
}

func_D15B(var_00) {
  if(!isDefined(level.func_A056)) {
    return 0;
  }

  if(level.func_A056.func_D3C1 == var_00) {
    return 1;
  } else {
    return 0;
  }
}

func_B324() {
  if(isDefined(level.func_A056) && level.func_A056.func_B323) {
    return 1;
  } else {
    return 0;
  }
}

func_793C(var_00, var_01, var_02) {
  var_03 = vectortoangles(var_02 - var_01);
  var_04 = var_0[1] - var_3[1];
  var_04 = var_04 + 360;
  var_04 = int(var_04) % 360;

  if(var_04 > 350 || var_04 < 10) {
    var_05 = "8";
  } else if(var_04 < 60) {
    var_05 = "9";
  } else if(var_04 < 120) {
    var_05 = "6";
  } else if(var_04 < 150) {
    var_05 = "3";
  } else if(var_04 < 210) {
    var_05 = "2";
  } else if(var_04 < 240) {
    var_05 = "1";
  } else if(var_04 < 300) {
    var_05 = "4";
  } else {
    var_05 = "7";
  }

  return var_05;
}

func_1C49(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55CA)) {
      self.func_55CA = 0;
    }

    self.func_55CA--;

    if(!self.func_55CA) {
      level.player func_65DD("no_grenade_block_gesture");
    }
  } else {
    if(!isDefined(self.func_55CA)) {
      self.func_55CA = 0;
    }

    self.func_55CA++;
    level.player func_65E1("no_grenade_block_gesture");
  }
}

func_1C75(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55E8)) {
      self.func_55E8 = 0;
    }

    self.func_55E8--;

    if(!self.func_55E8) {
      scripts\engine\utility::flag_clear("weapon_scanning_off");
    }
  } else {
    if(!isDefined(self.func_55E8)) {
      self.func_55E8 = 0;
    }

    self.func_55E8++;
    scripts\engine\utility::flag_set("weapon_scanning_off");
  }
}

func_1C39(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55C0)) {
      self.func_55C0 = 0;
    }

    self.func_55C0--;

    if(!self.func_55C0) {
      level.player func_65DD("disable_antigrav_float");
    }
  } else {
    if(!isDefined(self.func_55C0)) {
      self.func_55C0 = 0;
    }

    self.func_55C0++;

    if(!level.player func_65DF("disable_antigrav_float")) {
      level.player func_65E0("disable_antigrav_float");
    }

    level.player func_65E1("disable_antigrav_float");
  }
}

func_1C3E(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55C2)) {
      self.func_55C2 = 0;
    }

    self.func_55C2--;

    if(!self.func_55C2) {
      _setsaveddvar("cg_drawCrosshair", 1);
    }
  } else {
    if(!isDefined(self.func_55C2)) {
      self.func_55C2 = 0;
    }

    self.func_55C2++;
    _setsaveddvar("cg_drawCrosshair", 0);
  }
}

func_1C72(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55E7)) {
      self.func_55E7 = 0;
    }

    self.func_55E7--;

    if(!self.func_55E7) {
      _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
    }
  } else {
    if(!isDefined(self.func_55E7)) {
      self.func_55E7 = 0;
    }

    self.func_55E7++;
    _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
  }
}

_meth_82EA(var_00) {
  func_1143E();
  self giveweapon(var_00);
  self assignweaponmeleeslot(var_00);
}

func_1143E() {
  var_00 = self _meth_8524();

  if(var_00 != "none") {
    self giveuponsuppressiontime(var_00);
  }
}

func_7AD7() {
  var_00 = self _meth_8524();

  if(var_00 != "none") {
    return var_00;
  } else {
    return undefined;
  }
}

scriptmodelplayanimdeltamotion(var_00) {
  self.func_1586 = var_00;
  self giveweapon(var_00);

  if(!isDefined(self.func_55BD) || !self.func_55BD) {
    self setactionslot(1, "weapon", var_00);
  }
}

func_11425() {
  self setactionslot(1, "");
  self giveuponsuppressiontime(self.func_1586);
  self.func_1586 = undefined;
}

func_77C9() {
  if(isDefined(self.func_1586)) {
    return self.func_1586;
  } else {
    return "";
  }
}

func_1C34(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55BD)) {
      self.func_55BD = 0;
    }

    self.func_55BD--;

    if(!self.func_55BD) {
      if(isDefined(self.func_1586)) {
        self setactionslot(1, "weapon", self.func_1586);
      }
    }
  } else {
    if(!isDefined(self.func_55BD)) {
      self.func_55BD = 0;
    }

    self.func_55BD++;
    self setactionslot(1, "");
  }
}

func_9B4D() {
  if(!isDefined(self.func_55BD)) {
    return 1;
  }

  if(!self.func_55BD) {
    return 1;
  } else {
    return 0;
  }
}

func_7D74(var_00, var_01) {
  if(isDefined(var_00) && var_00 == 1) {
    var_02 = level.player getweaponslist("primary", "altmode");
  } else {
    var_02 = level.player getweaponslist("primary");
  }

  var_03 = [];
  var_04 = level.player func_7AD7();

  if(isDefined(var_04) && (!isDefined(var_01) || var_01 == 0)) {
    foreach(var_06 in var_02) {
      if(var_06 != var_04) {
        var_3[var_3.size] = var_06;
      }
    }
  } else
    var_03 = var_02;

  return var_03;
}

func_1145A(var_00) {
  func_0B29::func_11456(var_00);
  self giveuponsuppressiontime(var_00);
}

func_11428() {
  func_0B29::func_11427();
  self takeallweapons();
}

func_9C8D() {
  return scripts\engine\utility::flag("primary_equipment_input_down");
}

func_9C11() {
  if(self == level.player) {
    if(!isDefined(self.func_93B5) || self.func_93B5 == 0) {
      return 0;
    } else {
      return 1;
    }
  } else if(!isDefined(self.func_2023))
    return 0;
  else {
    return 1;
  }
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
  } else {
    return level.player.curobjid;
  }
}

func_7BD7() {
  if(level.player.curobjid == "") {
    return 0;
  } else if(func_799D(level.player.curobjid) == "drain") {
    return 1;
  } else {
    return level.player getammocount(level.player.curobjid);
  }
}

func_7C3D() {
  if(level.player.func_4B21 == "") {
    return undefined;
  } else {
    return level.player.func_4B21;
  }
}

func_7C3E() {
  if(level.player.func_4B21 == "") {
    return 0;
  } else if(func_799D(level.player.func_4B21) == "drain") {
    return 1;
  } else {
    return level.player getammocount(level.player.func_4B21);
  }
}

func_7CAF() {
  if(level.player.func_110BD == "") {
    return undefined;
  } else {
    return level.player.func_110BD;
  }
}

func_7CB0() {
  if(level.player.func_110BD != "" && func_799D(level.player.func_110BD) == "drain") {
    return 1;
  }

  return level.player.func_110BE;
}

func_7CB1() {
  if(level.player.func_110BA == "") {
    return undefined;
  } else {
    return level.player.func_110BA;
  }
}

func_7CB2() {
  if(level.player.func_110BA != "" && func_799D(level.player.func_110BA) == "drain") {
    return 1;
  }

  return level.player.func_110BB;
}

func_799C(var_00) {
  var_01 = [::func_7BD6, ::func_7CAF, ::func_7C3D, ::func_7CB1];
  var_02 = [::func_7BD7, ::func_7CB0, ::func_7C3E, ::func_7CB2];

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    var_04 = [[var_1[var_03]]]();
    var_05 = [[var_2[var_03]]]();

    if(isDefined(var_04) && var_04 == var_00) {
      return var_05;
    }
  }
}

func_D0C9() {
  if(!isDefined(level.player.func_110C0) || !level.player.func_110C0) {
    return 0;
  } else {
    return 1;
  }
}

func_799D(var_00) {
  return func_0B29::func_129C(var_00);
}

func_78E4() {
  if(getdvarint("ai_corpseSynch")) {
    return self _meth_82CC();
  }

  return self.origin;
}

func_9187(var_00, var_01, var_02) {
  scripts\sp\outline::func_9188(var_00, var_01, var_02);
}

func_9189(var_00, var_01, var_02) {
  scripts\sp\outline::func_918A(var_00, var_01, var_02);
}

func_9199(var_00, var_01) {
  scripts\sp\outline::func_919A(var_00, var_01);
}

func_9196(var_00, var_01, var_02, var_03) {
  scripts\sp\outline::func_9197(var_03, var_00, var_01, var_02, 0);
}

func_9198(var_00, var_01, var_02, var_03) {
  scripts\sp\outline::func_9197(var_03, var_00, var_01, var_02, 1);
}

func_9193(var_00) {
  scripts\sp\outline::func_9194(var_00);
}

func_918D(var_00, var_01) {
  scripts\sp\outline::func_CC8D(var_00, var_01);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + var_00);
}

func_918E(var_00, var_01) {
  thread scripts\sp\outline::func_CC8E(var_00, var_01);
}

func_91A9(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  _setsaveddvar("r_hudoutlineEnable", 1);
  var_01 = "0.5 0.5 0.5";
  var_02 = "1 1 1";

  if(var_00) {
    var_01 = "0.5 0.5 0.5 1";
    var_02 = "0.5 0.5 0.5 0.2";
    var_03 = "0.5 0.5 0.5 1";
    var_04 = "0.7 0.7 0.7 1";
    var_05 = "0.5 0.5 0.5 1";
  } else {
    var_01 = "0.5 0.5 0.5 0";
    var_02 = "0.5 0.5 0.5 0";
    var_03 = "0.5 0.5 0.5 1";
    var_04 = "0.5 0.5 0.5 0.5";
    var_05 = "0.5 0.5 0.5 0.5";
  }

  _setsaveddvar("r_hudoutlineFillColor0", var_01);
  _setsaveddvar("r_hudoutlineFillColor1", var_02);
  _setsaveddvar("r_hudoutlineOccludedOutlineColor", var_03);
  _setsaveddvar("r_hudoutlineOccludedInlineColor", var_04);
  _setsaveddvar("r_hudoutlineOccludedInteriorColor", var_05);
  _setsaveddvar("r_hudOutlineOccludedColorFromFill", 1);
}

func_91A8(var_00, var_01) {
  var_2["allies"] = "friendly";
  var_2["axis"] = "enemy";
  var_2["team3"] = "neutral";
  var_2["dead"] = "neutral";

  if(isDefined(var_01)) {
    var_03 = var_01;
  } else if(isDefined(self.team)) {
    var_03 = self.team;
  } else {
    var_03 = "dead";
  }

  if(var_00 && isDefined(var_2[var_03])) {
    func_F40A(var_2[var_03], 0);
  } else {
    self hudoutlinedisable();
  }
}

func_9131(var_00) {
  setomnvar("ui_show_bink", 1);
  _setsaveddvar("bg_cinematicFullScreen", "0");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame(var_00);

  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  _stopcinematicingame();
  setomnvar("ui_show_bink", 0);
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
}

func_918B(var_00, var_01, var_02) {
  if(isDefined(level.player.func_20F8)) {
    func_918C();
  }

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  _setsaveddvar("r_hudoutlineEnable", 1);
  level.player.func_20F8 = scripts\engine\utility::spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.func_20F8);

  if(!isDefined(var_00)) {
    var_00 = "ar_callouts_default";
  }

  setomnvar("ui_ar_object_text", var_00);
  wait 0.05;

  if(isDefined(var_01) && var_01) {
    func_9196(6, 1, 1, "default");
  } else {
    func_9196(6, 0, 1, "default");
  }

  setomnvar("ui_show_ar_elem", 1);
  thread func_1182(var_02);
}

func_1182(var_00) {
  level.player endon("stop_ar_callout");
  self endon("death");

  for(;;) {
    if(isDefined(var_00)) {
      var_01 = self.origin + var_00;
    } else {
      var_01 = self.origin + (0, 0, 30);
    }

    level.player.func_20F8.origin = var_01;
    wait 0.05;
  }
}

func_918C() {
  func_9193("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.func_20F8 delete();
  level.player.func_20F8 = undefined;
}

func_9145(var_00, var_01) {
  if(!isDefined(var_00)) {
    var_00 = "fluff_messages_default";
  }

  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  setomnvar("ui_sp_fluff_messaging", var_00);
  setomnvar("ui_sp_fluff_messaging_context", var_01);
}

func_914C(var_00, var_01, var_02, var_03) {
  var_04 = 20;

  if(!isDefined(var_02)) {
    var_02 = "default";
  }

  switch (var_02) {
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
  setomnvar("ui_sp_intel_messaging_text", var_01);
  setomnvar("ui_sp_intel_messaging_header", var_00);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread func_12EE();
  var_05 = var_02 == "tally_intel";

  if(var_05) {
    level.player thread func_12ED();
  }

  if(isDefined(var_03)) {
    setomnvar("ui_sp_intel_messaging_ent", 1);
  } else {
    setomnvar("ui_sp_intel_messaging_ent", 0);
  }

  var_06 = "close";
  var_07 = gettime() / 1000;
  var_08 = 5.0;

  while(var_05 && !isDefined(level.player.func_9951) || !var_05 && gettime() / 1000 - var_07 < var_08) {
    if(isDefined(level.player.func_9963)) {
      var_06 = "waypoint";
      break;
    }

    wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.func_9951 = undefined;

  if(var_06 == "waypoint" && isDefined(var_03)) {
    var_09 = scripts\engine\utility::spawn_script_origin(var_03, (0, 0, 0));
    var_9.icon = newhudelem();
    var_9.icon setshader("intel_hint_icon", 32, 32);
    var_9.icon.color = (0, 1, 0.976);
    var_9.icon.alpha = 1.0;
    var_9.icon setwaypoint(1, 1, 0);
    var_9.icon settargetent(var_09);
    var_10 = distance2dsquared(level.player.origin, var_9.origin);

    for(;;) {
      if(distance2dsquared(level.player.origin, var_9.origin) < squared(75.0) || distance2dsquared(level.player.origin, var_9.origin) > var_10 * 2.5) {
        break;
      }
      wait 0.05;
    }

    var_9.icon destroy();
    var_09 delete();
    level.player.func_9963 = undefined;
  } else {
    level.player notify("dismiss_skipped");
    level.player.func_9951 = undefined;
    return;
  }
}

func_12EE() {
  level notify("stopstop_intel_waypoint_int");
  level endon("stop_intel_waypoint");
  self.func_9963 = undefined;
  self notifyonplayercommand("set_waypoint", "+weapnext");
  self waittill("set_waypoint");
  self.func_9963 = 1;
}

func_12ED() {
  self endon("dismiss_skipped");
  self notifyonplayercommand("intel_dismiss", "+gostand");
  self notifyonplayercommand("intel_dismiss", "+activate");
  self notifyonplayercommand("intel_dismiss", "+usereload");
  self waittill("intel_dismiss");
  self.func_9951 = 1;
}

func_9674() {
  var_00 = getEntArray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::array_thread(var_00, ::func_B2FC);
}

func_B2FC() {
  if(isDefined(self.func_EDA0)) {
    scripts\engine\utility::flag_init(self.func_EDA0);
  }

  if(isDefined(self.func_ED48)) {
    scripts\engine\utility::flag_init(self.func_ED48);
  }

  if(isDefined(self.script_rotation_speed)) {
    self.func_10BA1 = self.angles;

    if(!isDefined(self.script_rotation_max)) {
      self.script_rotation_max = (0, 0, 0);
    }

    self.func_E746 = [];

    for(var_00 = 0; var_00 < 3; var_0++) {
      if(self.script_rotation_max[var_00] != 0) {
        if(self.script_rotation_speed[var_00] > 0) {
          self.func_E746[var_00] = ::scripts\sp\math::func_10AB0(self.script_rotation_speed[var_00] * 10, 0, self.func_10BA1[var_00] + self.script_rotation_max[var_00], 0);
          continue;
        }
      }
    }

    thread func_E702();
  }

  if(isDefined(self.func_EEEA)) {
    self.func_10CCA = self.origin;

    if(!isDefined(self.func_EEE9)) {
      self.func_EEE9 = (0, 0, 0);
    }

    self.func_12689 = [];

    for(var_00 = 0; var_00 < 3; var_0++) {
      if(self.func_EEE9[var_00] != 0) {
        if(self.func_EEEA[var_00] > 0) {
          self.func_12689[var_00] = ::scripts\sp\math::func_10AB0(self.func_EEEA[var_00] * 10, 0, self.func_10CCA[var_00] + self.func_EEE9[var_00], 0);
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

  if(isDefined(self.func_EDA0)) {
    scripts\engine\utility::flag_wait(self.func_EDA0);
  }

  for(;;) {
    var_00 = [];

    for(var_01 = 0; var_01 < 3; var_1++) {
      if(self.func_EEEA[var_01] == 0) {
        var_0[var_01] = self.func_10CCA[var_01];
        continue;
      }

      if(self.func_EEEA[var_01] != 0 && self.func_EEE9[var_01] == 0) {
        var_0[var_01] = self.origin[var_01] + self.func_EEEA[var_01] / 20;
        continue;
      }

      if(self.func_EEEA[var_01] > 0 && self.func_EEE9[var_01] != 0) {
        var_0[var_01] = ::scripts\sp\math::func_10AB4(self.func_12689[var_01], self.func_10CCA[var_01]);
      }
    }

    self.origin = (var_0[0], var_0[1], var_0[2]);
    scripts\engine\utility::waitframe();
  }
}

func_E702() {
  self endon("death");
  self endon("stop_manipulate_ent");

  if(isDefined(self.func_EDA0)) {
    scripts\engine\utility::flag_wait(self.func_EDA0);
  }

  for(;;) {
    var_00 = [];

    for(var_01 = 0; var_01 < 3; var_1++) {
      if(self.script_rotation_speed[var_01] == 0) {
        var_0[var_01] = self.func_10BA1[var_01];
        continue;
      }

      if(self.script_rotation_speed[var_01] != 0 && self.script_rotation_max[var_01] == 0) {
        var_0[var_01] = self.angles[var_01] + self.script_rotation_speed[var_01] / 20;
        continue;
      }

      if(self.script_rotation_speed[var_01] > 0 && self.script_rotation_max[var_01] != 0) {
        var_0[var_01] = ::scripts\sp\math::func_10AB4(self.func_E746[var_01], self.func_10BA1[var_01]);
      }
    }

    self.angles = (var_0[0], var_0[1], var_0[2]);
    scripts\engine\utility::waitframe();
  }
}

func_B2FB() {
  self endon("death");

  if(isDefined(self.func_ED48)) {
    scripts\engine\utility::flag_wait(self.func_ED48);

    if(isDefined(self.func_ED54) && self.func_ED54) {
      self delete();
    } else {
      self notify("stop_manipulate_ent");
    }
  }
}

func_B2FA() {
  scripts\engine\utility::waittill_either("death", "stop_manipulate_ent");

  if(isDefined(self.func_E746)) {
    foreach(var_01 in self.func_E746) {
      scripts\sp\math::func_10AAA(var_01);
    }
  }

  if(isDefined(self.func_12689)) {
    foreach(var_01 in self.func_12689) {
      scripts\sp\math::func_10AAA(var_01);
    }
  }
}

func_9DB4(var_00) {
  if(isDefined(self.damageweapon) && self.damageweapon != "alt_none" && self.damageweapon != "none" && getweaponbasename(self.damageweapon) == var_00) {
    return 1;
  }

  return 0;
}

func_9FFE(var_00) {
  var_01 = getweaponattachments(var_00);

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

strip_suffix(var_00, var_01) {
  if(var_0.size <= var_1.size) {
    return var_00;
  }

  if(getsubstr(var_00, var_0.size - var_1.size, var_0.size) == var_01) {
    return getsubstr(var_00, 0, var_0.size - var_1.size);
  }

  return var_00;
}

func_F398(var_00, var_01) {
  self.exception[var_00] = var_01;
}

func_F2A4(var_00) {
  var_01 = getarraykeys(self.exception);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    self.exception[var_1[var_02]] = var_00;
  }
}

waittill_multiple_ents(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("death");
  var_08 = spawnStruct();
  var_8.threads = 0;

  if(isDefined(var_00)) {
    var_00 childthread scripts\engine\utility::waittill_string(var_01, var_08);
    var_8.threads++;
  }

  if(isDefined(var_02)) {
    var_02 childthread scripts\engine\utility::waittill_string(var_03, var_08);
    var_8.threads++;
  }

  if(isDefined(var_04)) {
    var_04 childthread scripts\engine\utility::waittill_string(var_05, var_08);
    var_8.threads++;
  }

  if(isDefined(var_06)) {
    var_06 childthread scripts\engine\utility::waittill_string(var_07, var_08);
    var_8.threads++;
  }

  while(var_8.threads) {
    var_08 waittill("returned");
    var_8.threads--;
  }

  var_08 notify("die");
}

func_7A8F() {
  var_00 = [];

  if(isDefined(self.script_linkto)) {
    var_01 = scripts\engine\utility::get_links();

    foreach(var_03 in var_01) {
      var_04 = getEntArray(var_03, "script_linkname");

      if(var_4.size > 0) {
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

      if(var_4.size > 0) {
        var_00 = scripts\engine\utility::array_combine(var_00, var_04);
      }
    }
  }

  return var_00;
}

func_7A8E() {
  var_00 = func_7A8F();
  return var_0[0];
}

func_E820(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getEntArray(var_00, "targetname");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);

  if(isDefined(level._meth_8134)) {
    var_06 = call[[level._meth_8134]](var_00);

    foreach(var_08 in var_06) {
      if(_isnonentspawner(var_08)) {
        scripts\engine\utility::array_thread([var_08], var_01, var_02, var_03, var_04);
      }
    }
  }

  var_05 = scripts\engine\utility::getstructarray(var_00, "targetname");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
  var_05 = call[[level.getnodearrayfunction]](var_00, "targetname");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
  var_05 = getvehiclenodearray(var_00, "targetname");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
}

func_E81F(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getEntArray(var_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);

  if(isDefined(level._meth_8134)) {
    var_06 = call[[level._meth_8134]]();

    foreach(var_08 in var_06) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == var_00 && _isnonentspawner(var_08)) {
        scripts\engine\utility::array_thread([var_08], var_01, var_02, var_03, var_04);
      }
    }
  }

  var_05 = scripts\engine\utility::getstructarray(var_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
  var_05 = call[[level.getnodearrayfunction]](var_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
  var_05 = getvehiclenodearray(var_00, "script_noteworthy");
  scripts\engine\utility::array_thread(var_05, var_01, var_02, var_03, var_04);
}

func_7B27(var_00) {
  var_01 = getent(var_00, "script_noteworthy");

  if(isDefined(var_01)) {
    return var_01;
  }

  if(scripts\engine\utility::issp()) {
    var_01 = call[[level.getnodefunction]](var_00, "script_noteworthy");

    if(isDefined(var_01)) {
      return var_01;
    }
  }

  var_01 = scripts\engine\utility::getstruct(var_00, "script_noteworthy");

  if(isDefined(var_01)) {
    return var_01;
  }

  var_01 = getvehiclenode(var_00, "script_noteworthy");

  if(isDefined(var_01)) {
    return var_01;
  }
}

func_9C39(var_00) {
  var_01 = level.lock[var_00];
  return var_1.count > var_1.max_count;
}

func_12BDD(var_00) {
  thread scripts\engine\utility::unlock_thread(var_00);
  wait 0.05;
}

func_7EB4(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 500000;
  }

  var_03 = 0;
  var_04 = undefined;

  foreach(var_06 in var_01) {
    var_07 = distance(var_6.origin, var_00);

    if(var_07 <= var_03 || var_07 >= var_02) {
      continue;
    }
    var_03 = var_07;
    var_04 = var_06;
  }

  return var_04;
}

func_22C1(var_00, var_01) {
  for(var_02 = 0; var_02 < var_0.size - 1; var_2++) {
    for(var_03 = var_02 + 1; var_03 < var_0.size; var_3++) {
      if(var_0[var_03][[var_01]]() < var_0[var_02][[var_01]]()) {
        var_04 = var_0[var_03];
        var_0[var_03] = var_0[var_02];
        var_0[var_02] = var_04;
      }
    }
  }

  return var_00;
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
  } else {
    return 0;
  }
}

func_93AB() {
  if(getdvarint("g_yoloMode")) {
    return 1;
  } else {
    return 0;
  }
}

func_B979(var_00, var_01) {
  var_00 waittill("trigger", var_02);
  level.player getrawbaseweaponname(0.1, 0.1);
  level.player scripts\engine\utility::allow_ads(0);

  while(!level.player isonground()) {
    wait 0.05;
  }

  var_03 = level.player getstance();

  if(var_03 != var_01) {
    level.player setstance(var_01);

    if(var_03 == "prone") {
      wait 0.2;
    }
  }

  level.player _meth_80A6();
  level.player scripts\engine\utility::allow_ads(1);
  return var_02;
}

func_19FA(var_00, var_01, var_02, var_03, var_04) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_03) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  self.func_72BD = self.weapon;

  if(isDefined(var_04)) {
    if(self.weapon != var_04) {
      func_192C(self.weapon);
    }

    self.func_72BA = self.func_C828;
    func_72EC(var_04, "primary");
    self.func_13CAE = 1;
    return;
  }

  func_72EC(var_01, "primary");
  func_192C(var_00);
  self.func_72BB = var_00;
  self.func_72BC = var_01;
  self.func_42AE = var_02;
  self.func_72BA = self.func_72BC;
}

func_4125(var_00, var_01, var_02) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_01) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  if(isDefined(var_02)) {
    if(isDefined(self.func_13C4D) && self.func_13C4D.model == getweaponmodel(var_02)) {
      self.func_13C4D delete();
    }

    func_CC06(var_02, "right");
  } else
    func_CC06(self.func_72BD, "right");

  if(isDefined(self.func_13C4D) && var_00) {
    self.func_13C4D delete();
  }

  self.func_72BA = undefined;
  self.func_13CAE = 0;
}

func_192C(var_00) {
  self.func_13C4D = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self.func_13C4D setModel(getweaponmodel(var_00));
  self.func_13C4D notsolid();
  self.func_13C4D.angles = self gettagangles("tag_stowed_back");
  self.func_13C4D linkto(self, "tag_stowed_back");
}

func_46AD(var_00, var_01) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", var_01);
  setomnvar("ui_countdown_timer", gettime() + var_00 * 1000);
  wait(var_00);
  level notify(var_01);
  wait 5;
  setomnvar("ui_countdown_timer", 0);
}

func_46AB() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

func_F44E(var_00) {
  level.func_C086 = !var_00;
}

func_ABD9() {
  return !level.func_C086;
}

func_CE10(var_00, var_01, var_02) {
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame(var_00);
  thread scripts\sp\gameskill::func_E080();
  func_E006();

  if(func_93A6()) {
    scripts\sp\specialist_MAYBE::hide_helmet_impacts();
  }

  level.player scripts\engine\utility::allow_weapon(0);
  level.player getroundswon(1);
  level.player getrankinfoxpamt();
  level.player _meth_8475();
  level.player _meth_8559(0);
  setomnvar("ui_hide_hud", 1);
  level.player func_1C3E(0);
  setomnvar("ui_hide_weapon_info", 1);

  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  thread func_3F71(var_01);

  if(isDefined(var_02)) {
    func_3F72(var_02);

    if(func_93A6()) {
      scripts\sp\specialist_MAYBE::show_helmet_impacts();
    }

    level.player scripts\engine\utility::allow_weapon(1);
    level.player _meth_80A1();
    level.player getroundswon(0);
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

    _setsaveddvar("bg_cinematicFullScreen", "0");
    _setsaveddvar("bg_cinematicCanPause", "0");
    setomnvar("ui_is_bink_skippable", 0);
    _stopcinematicingame();
  } else {
    while(iscinematicplaying()) {
      scripts\engine\utility::waitframe();
    }

    _setsaveddvar("bg_cinematicFullScreen", "0");
    _setsaveddvar("bg_cinematicCanPause", "0");
    setomnvar("ui_is_bink_skippable", 0);
    _stopcinematicingame();

    if(func_93A6()) {
      scripts\sp\specialist_MAYBE::show_helmet_impacts();
    }

    level.player scripts\engine\utility::allow_weapon(1);
    level.player _meth_80A1();
    level.player getroundswon(0);
    level.player _meth_8475();
    level.player _meth_8559(1);
    level.player thread scripts\sp\gameskill::func_8CBA();
    setomnvar("ui_hide_hud", 0);
    level.player func_1C3E(1);
    setomnvar("ui_hide_weapon_info", 0);
    level notify("skippable_cinematic_done");
  }
}

func_3F71(var_00) {
  level endon("skippable_cinematic_done");

  if(isDefined(var_00)) {
    self waittill(var_00);
  }

  setomnvar("ui_is_bink_skippable", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var_01, var_02);

    if(var_01 == "skip_bink_input") {
      level notify("cinematic_skipped");
      _stopcinematicingame();
      break;
    }
  }
}

func_3F72(var_00) {
  level endon("cinematic_skipped");
  var_00 = var_00 * 1000;

  for(;;) {
    var_01 = _cinematicgettimeinmsec();

    if(var_01 >= var_00) {
      return;
    }
    scripts\engine\utility::waitframe();
  }
}

func_93AC() {
  return level.player func_65DF("zero_gravity") && level.player func_65DB("zero_gravity");
}

func_E006(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  if(!isDefined(var_03)) {
    var_03 = 1;
  }

  if(!isDefined(var_04)) {
    var_04 = 1;
  }

  if(!isDefined(var_05)) {
    var_05 = 1;
  }

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  if(var_00) {
    thread func_0E26::func_DFC1();
  }

  if(var_01) {
    thread func_0E25::func_DFBE();
  }

  if(var_02) {
    thread func_0E21::func_DFBA();
  }

  if(var_03) {
    thread scripts\sp\coverwall::func_DFBD();
  }

  if(var_04) {
    thread func_0B1D::func_DFBF();
  }

  if(var_05) {
    thread func_0E2D::func_5139();
  }

  if(var_06) {
    thread func_0E2D::func_A5B9();
  }
}

func_F6FE(var_00) {
  self.func_6A8B = var_00;
}

func_41AD(var_00) {
  self.func_6A8B = "asm";

  if(!isDefined(self.func_6B14) || !self.func_6B14) {
    func_0A1E::func_2376();
  }
}

isfacialstateallowed(var_00) {
  if(!isai(self) && (!isDefined(self.func_6B14) || !self.func_6B14)) {
    return 0;
  }

  if(!isDefined(self.func_6A8B)) {
    self.func_6A8B = "asm";
  }

  var_01 = [];
  var_1["asm"] = 0;
  var_1["filler"] = 1;
  var_1["vignette"] = 2;

  if(var_1[var_00] >= var_1[self.func_6A8B]) {
    return 1;
  }

  return 0;
}

func_F708(var_00) {
  var_00 = max(var_00, 2);
  level.func_2A6F = var_00;
}

dyndof(var_00, var_01) {
  level notify("stop_dyndof");

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
  }

  level.dyndof = scripts\sp\utility_code::create_dyndof();
  level thread scripts\sp\utility_code::dyndof_thread();
}

dyndof_farsettings(var_00, var_01, var_02) {
  if(isDefined(var_00)) {
    level.dyndof.farstart = var_00;
  }

  if(isDefined(var_01)) {
    level.dyndof.farend = var_01;
  }

  if(isDefined(var_02)) {
    level.dyndof.farblur = var_02;
  }
}

dyndof_disable() {
  level notify("stop_dyndof");
  scripts\sp\utility_code::destroy_dyndof();
  func_0B0A::func_583D(1);
}

isactorwallrunning() {
  if(isDefined(self.func_138BC)) {
    return 1;
  }

  return 0;
}