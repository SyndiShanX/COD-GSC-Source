/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2961.gsc
**************************************/

func_7CCC(var_0) {
  var_1 = [];
  var_2 = _getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_1[var_1.size] = _getpartname(var_0, var_3);
  }

  return var_1;
}

func_77FF(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_1.size < 1) {
    return var_4;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_2 = squared(var_2);

  foreach(var_6 in var_1) {
    if(!isalive(var_6) || !isDefined(var_6) || !var_3 && isDefined(var_6.a.var_58DA)) {
      continue;
    }
    if(distancesquared(var_6.origin, var_0) <= var_2) {
      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

func_BD6B(var_0, var_1) {
  var_0 = var_0 * 17.6;
  var_2 = var_1 / var_0;
  return var_2;
}

func_F40A(var_0, var_1, var_2) {
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4["friendly"] = 3;
  var_4["enemy"] = 1;
  var_4["objective"] = 5;
  var_4["neutral"] = 0;
  var_3 = var_4[var_0];
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1);
  func_9196(var_3, var_1, var_2);
}

func_45F8(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0) {
    var_2 = var_2 + "-";
  }

  var_0 = func_E753(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10) {
    var_2 = var_2 + (":0" + var_5);
  } else {
    var_2 = var_2 + (":" + var_5);
  }

  if(isDefined(var_1) && var_1) {
    var_6 = var_3;
    var_6 = var_6 - var_4 * 6000;
    var_6 = var_6 - var_5 * 100;
    var_6 = int(var_6 / 10);
    var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

func_E753(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4) {
    return var_0;
  }

  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2) {
    var_5 = floor(var_5);
  } else {
    var_5 = ceil(var_5);
  }

  var_0 = var_5 / var_3;
  return var_0;
}

func_E754(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = func_E753(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

func_111DA(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;
  }

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;
    }

    _setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  _setsunlight(var_1[0], var_1[1], var_1[2]);
}

func_65E3(var_0) {
  while(isDefined(self) && !self.var_65DB[var_0]) {
    self waittill(var_0);
  }
}

func_65E7(var_0) {
  while(isDefined(self) && !self.var_65DB[var_0]) {
    self waittill(var_0);
  }
}

func_65E4(var_0, var_1) {
  while(isDefined(self)) {
    if(func_65DB(var_0)) {
      return;
    }
    if(func_65DB(var_1)) {
      return;
    }
    scripts\engine\utility::waittill_either(var_0, var_1);
  }
}

func_65E6(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self.var_65DB[var_0]) {
      break;
    }
    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }
    scripts\sp\utility_code::func_65FA(var_0, var_1);
  }
}

func_65E8(var_0) {
  while(isDefined(self) && self.var_65DB[var_0]) {
    self waittill(var_0);
  }
}

func_65DC(var_0) {}

func_65E9(var_0, var_1) {
  while(isDefined(self)) {
    if(!func_65DB(var_0)) {
      return;
    }
    if(!func_65DB(var_1)) {
      return;
    }
    scripts\engine\utility::waittill_either(var_0, var_1);
  }
}

func_65E0(var_0) {
  if(!isDefined(self.var_65DB)) {
    self.var_65DB = [];
    self.var_65EA = [];
  }

  self.var_65DB[var_0] = 0;
}

func_65DF(var_0) {
  if(isDefined(self.var_65DB) && isDefined(self.var_65DB[var_0])) {
    return 1;
  }

  return 0;
}

func_65E2(var_0, var_1) {
  self endon("death");
  wait(var_1);
  func_65E1(var_0);
}

func_65E1(var_0) {
  self.var_65DB[var_0] = 1;
  self notify(var_0);
}

func_65DD(var_0, var_1) {
  if(self.var_65DB[var_0]) {
    self.var_65DB[var_0] = 0;
    self notify(var_0);
  }

  if(isDefined(var_1) && var_1) {
    self.var_65DB[var_0] = undefined;
  }
}

func_65DE(var_0, var_1) {
  wait(var_1);

  if(isDefined(self)) {
    func_65DD(var_0);
  }
}

func_65DB(var_0) {
  return self.var_65DB[var_0];
}

func_78C8(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_4 = var_1 getEye();
  }

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_7, var_12);

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

func_78B9(var_0, var_1, var_2) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_3 = var_1 getEye();
  }

  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = -1;

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = vectortoangles(var_0[var_8].origin - var_3);
    var_10 = anglesToForward(var_9);
    var_11 = vectordot(var_6, var_10);

    if(var_11 < var_7) {
      continue;
    }
    var_7 = var_11;
    var_4 = var_8;
  }

  return var_4;
}

func_6E49(var_0, var_1, var_2) {
  scripts\engine\utility::flag_init(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 thread scripts\sp\utility_code::func_1287(var_0, var_2);
  return var_1;
}

func_6E4A(var_0, var_1, var_2) {
  scripts\engine\utility::flag_init(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] thread scripts\sp\utility_code::func_1287(var_0, 0);
  }

  return var_1;
}

func_6E2B(var_0, var_1) {
  wait(var_1);
  scripts\engine\utility::flag_clear(var_0);
}

func_ABD2() {
  if(level.var_B8D0) {
    return;
  }
  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isalive(var_1)) {
      return;
    }
  }

  scripts\engine\utility::flag_set("game_saving");
  var_2 = "levelshots / autosave / autosave_" + level.script + "end";
  _savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1);
  scripts\engine\utility::flag_clear("game_saving");
}

func_16D5(var_0, var_1, var_2) {
  level.var_2668.var_6A42[var_0] = [];
  level.var_2668.var_6A42[var_0]["func"] = var_1;
  level.var_2668.var_6A42[var_0]["msg"] = var_2;
}

func_E00D(var_0) {
  level.var_2668.var_6A42[var_0] = undefined;
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

func_2669(var_0) {
  thread func_266B(var_0);
}

func_266A(var_0) {
  thread func_266B(var_0, undefined, undefined, 1);
}

func_266B(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.var_4B18)) {
    level.var_4B18 = 1;
  }

  var_4 = "levelshots\autosave\autosave_" + level.script + level.var_4B18;
  var_5 = level scripts\sp\autosave::func_12891(level.var_4B18, "autosave", var_4, var_1, var_2, var_3);

  if(isDefined(var_5) && var_5) {
    level.var_4B18++;
  }
}

func_2672(var_0, var_1) {
  thread func_266B(var_0, var_1);
}

func_2673(var_0, var_1) {
  thread func_266B(var_0, var_1, undefined, 1);
}

func_4EF6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {}

    wait 0.05;
  }
}

func_4EF7(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 5;
  }

  for(var_2 = 0; var_2 < var_1 * 20; var_2++) {
    wait 0.05;
  }
}

func_4EF8(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    wait 0.05;
  }
}

func_4295(var_0, var_1) {
  return var_0 >= var_1;
}

func_7E33(var_0, var_1, var_2) {
  return scripts\sp\utility_code::func_4461(var_0, var_1, var_2, ::func_4295);
}

func_79B3(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 < var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

func_7D80(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

func_7B5C(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

func_78BB(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isalive(var_1[var_4])) {
      continue;
    }
    var_5 = distance(var_1[var_4].origin, var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

func_7A05(var_0, var_1, var_2) {
  if(!var_2.size) {
    return;
  }
  var_3 = undefined;
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = anglesToForward(var_4);
  var_6 = -1;

  foreach(var_8 in var_2) {
    var_4 = vectortoangles(var_8.origin - var_0);
    var_9 = anglesToForward(var_4);
    var_10 = vectordot(var_5, var_9);

    if(var_10 < var_6) {
      continue;
    }
    var_6 = var_10;
    var_3 = var_8;
  }

  return var_3;
}

func_78B8(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  foreach(var_7, var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_7;
  }

  return var_3;
}

func_78B5(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_4[var_5] = 0;
    }

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6]) {
          var_4[var_5] = 1;
        }
      }
    }

    var_7 = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(!var_4[var_5] && isDefined(var_1[var_5])) {
        var_7 = 1;
        var_3 = distance(var_0, var_1[var_5].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }

    if(!var_7) {
      return undefined;
    }
  } else {
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_3 = distance(var_0, var_1[0].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }
  }

  var_8 = undefined;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(isDefined(var_1[var_5])) {
      var_4 = 0;

      if(isDefined(var_2)) {
        for(var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_1[var_5] == var_2[var_6]) {
            var_4 = 1;
          }
        }
      }

      if(!var_4) {
        var_9 = distance(var_0, var_1[var_5].origin);

        if(var_9 <= var_3) {
          var_3 = var_9;
          var_8 = var_5;
        }
      }
    }
  }

  if(isDefined(var_8)) {
    return var_1[var_8];
  } else {
    return undefined;
  }
}

func_78AA(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = _getaiarray(var_1);
  } else {
    var_3 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);
  }

  return scripts\engine\utility::getclosest(var_0, var_3);
}

func_78AB(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = _getaiarray(var_1);
  } else {
    var_3 = _getaiarray();
  }

  if(var_3.size == 0) {
    return undefined;
  }

  return func_78B5(var_0, var_3, var_2);
}

func_7BDB(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = distance(var_0, var_1);
  }

  var_3 = max(0.01, var_3);
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

func_3849(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!func_D637(var_0)) {
    return 0;
  }

  if(!sighttracepassed(self getEye(), var_0, var_1, self)) {
    return 0;
  }

  return 1;
}

func_D637(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

func_1101B() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    if(isDefined(self.var_C3B0)) {
      self.attackeraccuracy = self.var_C3B0;
      self.var_C3B0 = undefined;
    } else
      self.attackeraccuracy = 1;
  }

  self.var_B14F = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

func_B14E() {}

func_B14F(var_0) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self.var_C3B0 = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
  }

  self notify("magic_bullet_shield");
  self.var_B14F = 1;
  self.damageshield = 1;
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

func_F416(var_0) {
  self.ignoreme = var_0;
}

func_F415(var_0) {
  self.ignoreall = var_0;
}

func_F39C(var_0) {
  self.favoriteenemy = var_0;
}

func_7B61() {
  return self.pacifist;
}

func_F4B2(var_0) {
  self.pacifist = var_0;
}

func_5151(var_0) {
  scripts\common\exploder::delete_exploder_proc(var_0);
}

func_8E80(var_0) {
  scripts\common\exploder::hide_exploder_models_proc(var_0);
}

func_100DA(var_0) {
  scripts\common\exploder::show_exploder_models_proc(var_0);
}

func_10FEC(var_0) {
  scripts\common\exploder::stop_exploder_proc(var_0);
}

func_79A6(var_0) {
  return scripts\common\exploder::get_exploder_array_proc(var_0);
}

func_6F54(var_0) {
  func_0B77::func_6F5A(var_0);
}

func_7267(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  thread func_7268(var_0, var_1, var_2, var_3);
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

func_7268(var_0, var_1, var_2, var_3) {
  self.var_72CC = 1;
  self.a.var_7280 = var_1;
  self.noragdoll = 1;
  self.var_C05D = var_3;
  self.a.var_4C42 = var_2;
  self.var_4875 = ::func_C812;
  self.maxhealth = 100000;
  self.health = 100000;
  func_6215();

  if(!isDefined(var_3) || var_3 == 0) {
    self.a.var_7266 = var_0 + 181.02;
  } else {
    self.a.var_7266 = var_0;
    thread scripts\anim\notetracks::notetrackposecrawl();
  }
}

func_19D3() {
  self.var_10265 = 1;
  func_54C6();
}

func_D463(var_0) {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  if(!isDefined(var_0)) {
    var_0 = 3;
  }

  func_E23C();
  childthread func_D464();

  for(;;) {
    if(self.unresolved_collision) {
      self.unresolved_collision = 0;

      if(self.var_12BE5 >= var_0) {
        if(isDefined(self.unresolved_collision_mover)) {
          var_1 = self.unresolved_collision_mover;

          if(isDefined(var_1.unresolved_collision_func)) {
            var_1[[var_1.unresolved_collision_func]](self);
          }
        }

        if(isDefined(self.var_8969)) {
          self[[self.var_8969]]();
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
    self waittill("unresolved_collision", var_0);
    self.unresolved_collision = 1;
    self.var_12BE5++;
    self.unresolved_collision_mover = var_0;
  }
}

func_E23C() {
  self.unresolved_collision = 0;
  self.var_12BE5 = 0;
}

func_502A() {
  var_0 = getnodesinradiussorted(self.origin, 500, 0, 200, "Path");

  if(var_0.size) {
    self cancelmantle();
    self dontinterpolate();
    self setorigin(var_0[0].origin);
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

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(func_9BB2()) {
    return;
  }
  var_5 = spawn("script_origin", self.origin);
  var_5 endon("death");
  thread scripts\sp\utility_code::func_517B(var_5, "sounddone");

  if(isDefined(var_1)) {
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkto(self);
  }

  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_5))) {
      var_5 stopsounds();
    }

    wait 0.05;
  } else
    var_5 waittill("sounddone");

  if(isDefined(var_3)) {
    self notify(var_3);
  }

  var_5 delete();
}

func_CE48(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(func_9BB2()) {
    return;
  }
  var_6 = spawn("script_origin", self.origin);
  var_6 endon("death");

  if(!isDefined(var_1)) {
    var_1 = "dirt";
  }

  thread scripts\sp\utility_code::func_517B(var_6, "sounddone");

  if(isDefined(var_2)) {
    var_6 linkto(self, var_2, (0, 0, 0), (0, 0, 0));
  } else {
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 linkto(self);
  }

  var_6 _meth_824E(var_0, var_1, "sounddone");

  if(isDefined(var_3)) {
    if(!isDefined(scripts\sp\utility_code::func_1362A(var_6))) {
      var_6 stopsounds();
    }

    wait 0.05;
  } else
    var_6 waittill("sounddone");

  if(isDefined(var_4)) {
    self notify(var_4);
  }

  var_6 delete();
}

func_CE32(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

play_loop_sound_on_entity_with_pitch(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");
  thread scripts\engine\utility::delete_on_death(var_4);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(var_1)) {
    var_4.origin = self.origin + var_1;
  } else {
    var_4.origin = self.origin;
  }

  var_4.angles = self.angles;
  var_4 linkto(self);
  var_4 playLoopSound(var_0);
  var_4 _meth_8277(var_2, var_3);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

play_loop_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    thread scripts\engine\utility::delete_on_death(var_5);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_3) {
    thread func_5187(var_5);
  }

  if(isDefined(var_1)) {
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkto(self);
  }

  var_5 playLoopSound(var_0);
  self waittill("stop sound" + var_0);

  if(isDefined(var_4)) {
    var_5 playSound(var_4, "sounddone");
    var_5 scripts\engine\utility::delaycall(0.15, ::stoploopsound, var_0);
    var_5 waittill("sounddone");
    var_5 delete();
  } else {
    var_5 stoploopsound(var_0);
    var_5 delete();
  }
}

func_5187(var_0) {
  var_0 endon("death");

  while(isDefined(self)) {
    wait 0.05;
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_106ED(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.var_6CDA)) {
    var_0 scripts\engine\utility::waittill_either("finished spawning", "death");
  }

  if(isalive(var_0)) {
    return 0;
  }

  return 1;
}

func_23B7(var_0) {
  if(isDefined(var_0)) {
    self.var_1FBB = var_0;
  }

  self glinton(level.var_EC87[self.var_1FBB]);
}

func_23B8() {
  var_0 = tolower(self.subclass);

  switch (var_0) {
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
  var_0 = tolower(self.unittype);

  switch (var_0) {
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
  if(isarray(level.var_EC8C[self.var_1FBB])) {
    var_0 = randomint(level.var_EC8C[self.var_1FBB].size);
    self setModel(level.var_EC8C[self.var_1FBB][var_0]);
  } else
    self setModel(level.var_EC8C[self.var_1FBB]);
}

func_10639(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = spawn("script_model", var_1);
  var_3.var_1FBB = var_0;
  var_3 func_23B7();
  var_3 func_23CC();

  if(isDefined(var_2)) {
    var_3.angles = var_2;
  }

  return var_3;
}

func_127AE(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

func_127B3(var_0) {
  return func_127AE(var_0, "targetname");
}

func_F3A1(var_0, var_1) {
  thread func_F3A5(var_0, var_1, ::func_13753, "set_flag_on_dead");
}

func_F3A3(var_0, var_1) {
  thread func_F3A5(var_0, var_1, ::func_13754, "set_flag_on_dead_or_dying");
}

empty_func(var_0) {
  return;
}

func_F3A8(var_0, var_1) {
  self waittill("spawned", var_2);

  if(func_106ED(var_2)) {
    return;
  }
  var_0.var_1912[var_0.var_1912.size] = var_2;
  func_65E1(var_1);
}

func_F3A5(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.var_1912 = [];

  foreach(var_7, var_6 in var_0) {
    var_6 func_65E0(var_3);
  }

  scripts\engine\utility::array_thread(var_0, ::func_F3A8, var_4, var_3);

  foreach(var_7, var_6 in var_0) {
    var_6 func_65E3(var_3);
  }

  [[var_2]](var_4.var_1912);
  scripts\engine\utility::flag_set(var_1);
}

func_F3AB(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_1)) {
    var_0 waittill("trigger", var_2);
    scripts\engine\utility::flag_set(var_1);
    return var_2;
  }
}

func_F3AA(var_0) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set(var_0);
}

func_13753(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::func_13758(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count) {
    var_10.count = var_1;
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility_code::func_13757, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

func_13754(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck) {
      var_3[var_3.size] = var_5;
    }
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread scripts\sp\utility_code::func_13758(var_2);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count) {
    var_7.count = var_1;
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility_code::func_13756, var_7);

  while(var_7.count > 0) {
    var_7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

waittill_nonai_isnt_blocking_tank(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

func_7A9D(var_0, var_1) {
  var_2 = func_7A9E(var_0, var_1);

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

func_7A9E(var_0, var_1) {
  var_2 = _getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0) {
          var_3[var_3.size] = var_5;
        }

        break;
    }
  }

  return var_3;
}

func_7D40(var_0, var_1) {
  var_2 = func_7D43(var_0, var_1);

  if(!var_2.size) {
    return undefined;
  }

  return var_2[0];
}

func_7D43(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(_isspawner(var_6)) {
      if(isDefined(var_6.var_A90E)) {
        var_4[0] = var_6.var_A90E;
        var_3 = func_22A2(var_3, var_4);
      }

      continue;
    }

    var_3 = func_22A2(var_3, var_4);
  }

  return var_3;
}

func_7A9F(var_0, var_1, var_2) {
  var_3 = func_7AA0(var_0, var_1, var_2);

  if(var_3.size > 1) {
    return undefined;
  }

  return var_3[0];
}

func_7AA0(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }

  var_3 = _getaispeciesarray("allies", var_2);
  var_3 = scripts\engine\utility::array_combine(var_3, _getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }

        break;
    }
  }

  return var_4;
}

func_76F4(var_0, var_1) {
  if(isDefined(level.var_76F3[var_0])) {
    if(level.var_76F3[var_0]) {
      wait 0.05;

      if(isalive(self)) {
        self notify("gather_delay_finished" + var_0 + var_1);
      }

      return;
    }

    level waittill(var_0);

    if(isalive(self)) {
      self notify("gather_delay_finished" + var_0 + var_1);
    }

    return;
  }

  level.var_76F3[var_0] = 0;
  wait(var_1);
  level.var_76F3[var_0] = 1;
  level notify(var_0);

  if(isalive(self)) {
    self notify("gather_delay_finished" + var_0 + var_1);
  }
}

func_76F3(var_0, var_1) {
  thread func_76F4(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

func_7F79(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4.script_linkname;

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_1[var_5])) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

func_22A2(var_0, var_1) {
  if(var_0.size == 0) {
    return var_1;
  }

  if(var_1.size == 0) {
    return var_0;
  }

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    } else {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

func_2290(var_0, var_1) {
  var_2 = var_0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(scripts\engine\utility::array_contains(var_0, var_1[var_3])) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_1[var_3]);
    }
  }

  return var_2;
}

array_compare(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return 0;
  }

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return 0;
    }

    var_4 = var_1[var_5];

    if(var_4 != var_3) {
      return 0;
    }
  }

  return 1;
}

func_7F77() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");
      var_0 = scripts\engine\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    wait 0.05;
  }
}

func_5B51(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_1.origin)) {
      return;
    }
  }
}

func_5B4C(var_0, var_1, var_2, var_3, var_4, var_5) {
  func_5B51(var_1, var_0, var_2, var_3, var_4, var_5);
}

func_5B4D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;
  }
}

func_5B4E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;) {
    wait 0.05;
  }
}

func_5B52(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for(;;) {
    scripts\engine\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, 0.05);
  }
}

func_5B4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    wait 0.05;

    if(!isDefined(var_0) || !isDefined(var_0.origin)) {
      return;
    }
  }
}

draw_circle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_16 = var_8[var_9];

    if(var_9 + 1 >= var_8.size) {
      var_17 = var_8[0];
      continue;
    }

    var_17 = var_8[var_9 + 1];
  }
}

draw_circle_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;
  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread draw_circle_lines_until_notify(var_9, var_2, var_3, var_4, var_5, var_6);
}

draw_circle_lines_until_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size) {
      var_8 = var_0[0];
    } else {
      var_8 = var_0[var_6 + 1];
    }

    thread func_5B52(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

func_28D7(var_0) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter::func_29C1();

  if(isDefined(var_0)) {
    func_F2DC(var_0, 0);
    var_1 = _getaiarray(var_0);
  } else {
    foreach(var_0 in anim.var_115E7) {
      func_F2DC(var_0, 0);
    }

    var_1 = _getaiarray();
  }

  if(!isDefined(anim.var_3D4B) || !anim.var_3D4B) {
    return;
  }
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_1[var_4].var_28CF = 0;
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];

    if(!isalive(var_5)) {
      continue;
    }
    if(!var_5.var_3D4B) {
      continue;
    }
    if(!var_5.var_9F6B) {
      continue;
    }
    var_5 scripts\sp\utility_code::func_1368E();
    anim.var_29B7 = 0;
  }

  var_6 = gettime() - anim.var_AA27["allies"];

  if(var_6 < 1500) {
    wait(var_6 / 1000);
  }

  if(isDefined(var_0)) {
    level notify(var_0 + " done speaking");
  } else {
    level notify("done speaking");
  }
}

func_28D8(var_0) {
  thread scripts\sp\utility_code::func_28D9(var_0);
}

func_F2DA(var_0) {
  if(!anim.var_3D4B) {
    return;
  }
  if(var_0) {
    if(isDefined(self.var_ED17) && !self.var_ED17 || isDefined(self.unittype) && self.unittype == "c8" || isDefined(self.unittype) && self.unittype == "c12" || isDefined(self.asmname) && self.asmname == "seeker") {
      self.var_28CF = 0;
    } else {
      self.var_28CF = 1;
    }
  } else {
    self.var_28CF = 0;

    if(isDefined(self.var_9F6B) && self.var_9F6B) {
      self waittill("done speaking");
    }
  }
}

func_F5C2(var_0, var_1) {
  if(!anim.var_3D4B) {
    return;
  }
  var_2 = getarraykeys(anim.var_46BD);
  var_3 = scripts\engine\utility::array_contains(var_2, var_1);

  if(!var_3) {
    return;
  }
  var_4 = _getaiarray(var_0);

  foreach(var_6 in var_4) {
    var_6 func_F292(var_1);
    scripts\engine\utility::waitframe();
  }
}

func_F292(var_0) {
  if(!anim.var_3D4B) {
    return;
  }
  var_1 = getarraykeys(anim.var_46BD);
  var_2 = scripts\engine\utility::array_contains(var_1, var_0);

  if(!var_2) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(isDefined(self.var_9F6B) && self.var_9F6B) {
    self waittill("done speaking");
    wait 0.1;
  }

  scripts\anim\battlechatter_ai::func_E11B();
  waittillframeend;
  self.voice = var_0;
  scripts\anim\battlechatter_ai::func_185D();
}

func_6EEB(var_0, var_1) {
  thread func_F3B0(1, var_0, var_1);
}

func_6EEA(var_0, var_1) {
  thread func_F3B0(0, var_0, var_1);
}

func_F3B0(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "allies";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  } else {
    anim.var_C52F = 1;
  }

  while(!isDefined(anim.var_3D4B)) {
    wait 0.05;
  }

  if(!anim.var_3D4B) {
    return;
  }
  wait 1.5;
  level.var_6EE9[var_1] = var_0;
  var_3 = [];
  var_4 = [];

  if(isDefined(level.var_A056) && isDefined(level.var_A056.var_1630)) {
    if(!isDefined(level.var_D127) || anim.player != level.var_D127) {
      anim.player.var_C4B2 = 1;
    }

    var_4 = level.var_A056.var_1630;
    var_4 = scripts\engine\utility::array_removeundefined(var_4);

    foreach(var_6 in var_4) {
      if(isDefined(var_6.team) && var_6.team != "allies") {
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }

      if(isDefined(var_6.var_ED2D) && var_6.var_ED2D == "fake") {
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }
    }
  }

  if(!var_0) {
    if(isDefined(anim.var_C52F)) {
      anim.var_C52F = 0;
    }
  }

  var_3 = _getaiarray(var_1);
  var_3 = scripts\engine\utility::array_combine(var_3, var_4);
  scripts\engine\utility::array_thread(var_3, ::func_F3AF, var_0);
}

func_F3AF(var_0) {
  self.var_6EE9 = var_0;
}

func_7412() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 func_F3C0(0);
    }
  }

  level.var_7410 = 0;
}

func_7413() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 func_F3C0(1);
    }
  }

  level.var_7410 = 1;
}

func_F3C0(var_0) {
  if(var_0) {
    self.var_7411 = undefined;
  } else {
    self.var_7411 = 1;
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
    var_0 = anglesToForward(self.angles);
    var_1 = var_0 * 30;
    var_2 = var_0 * 20;
    var_3 = anglestoright(self.angles);
    var_4 = var_3 * -10;
    var_3 = var_3 * 10;
    wait 0.05;
  }
}

func_7A97() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getstruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

func_7A96() {
  var_0 = func_7A97();

  if(!var_0.size) {
    return undefined;
  }

  return var_0[0];
}

func_7A6F(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    wait 0.05;

    if(isDefined(var_1.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_1 = getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_1 = getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_1 = getent(var_1.target, "targetname");
          break;
        case "struct":
          var_1 = scripts\engine\utility::getstruct(var_1.target, "targetname");
          break;
        default:
      }

      continue;
    }

    break;
  }

  var_2 = var_1;
  return var_2;
}

timeout(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

func_F3BC() {
  if(isDefined(self.var_F3BB)) {
    return;
  }
  self.var_C3EC = self.pathenemyfightdist;
  self.var_C3F4 = self.pathenemylookahead;
  self.var_C3F5 = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.var_F3BB = 1;
}

func_12BFA() {
  if(!isDefined(self.var_F3BB)) {
    return;
  }
  self.pathenemyfightdist = self.var_C3EC;
  self.pathenemylookahead = self.var_C3F4;
  self.maxsightdistsqrd = self.var_C3F5;
  self.var_F3BB = undefined;
}

func_22BA(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_0[var_4])) {
      continue;
    }
    var_1[var_4] = var_0[var_4];
  }

  return var_1;
}

func_22B9(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_removedeadvehicles(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3 func_58DA()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_remove_nokeys(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1) {
      var_2[var_2.size] = var_0[var_3];
    }
  }

  return var_2;
}

func_22B2(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_1 == var_5) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  return var_2;
}

func_22B3(var_0, var_1) {
  if(var_1.size == 0) {
    return var_0;
  }

  var_2 = [];

  foreach(var_9, var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_7 == var_9) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    }
    var_2[var_9] = var_4;
  }

  return var_2;
}

array_remove_index(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

func_22A4(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0) {
    var_4 notify(var_1, var_2);
  }
}

func_1115A() {
  var_0 = spawnStruct();
  var_0.var_2274 = [];
  var_0.lastindex = 0;
  return var_0;
}

func_11161(var_0, var_1) {
  var_0.var_2274[var_0.lastindex] = var_1;
  var_1.var_11159 = var_0.lastindex;
  var_0.lastindex++;
}

func_11162(var_0, var_1) {
  func_11167(var_0, var_1);
  var_0.var_2274[var_0.lastindex - 1] = undefined;
  var_0.lastindex--;
}

func_11163(var_0, var_1) {
  if(isDefined(var_0.var_2274[var_0.lastindex - 1])) {
    var_0.var_2274[var_1] = var_0.var_2274[var_0.lastindex - 1];
    var_0.var_2274[var_1].var_11159 = var_1;
    var_0.var_2274[var_0.lastindex - 1] = undefined;
    var_0.lastindex = var_0.var_2274.size;
  } else {
    var_0.var_2274[var_1] = undefined;
    func_11164(var_0);
  }
}

func_11164(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.var_2274) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0.var_2274 = var_1;

  foreach(var_6, var_3 in var_0.var_2274) {
    var_3.var_11159 = var_6;
  }

  var_0.lastindex = var_0.var_2274.size;
}

func_11167(var_0, var_1) {
  var_0 scripts\sp\utility_code::func_11166(var_0.var_2274[var_0.lastindex - 1], var_1);
}

func_11165(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0 scripts\sp\utility_code::func_11166(var_0.var_2274[var_2], var_0.var_2274[randomint(var_0.lastindex)]);
  }
}

func_4C39(var_0) {
  return scripts\anim\battlechatter_ai::func_4C3B(var_0);
}

func_7CAE(var_0, var_1) {
  var_2 = newhudelem();

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

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = level.var_6A04;
  }

  var_2 give_explosive_armor(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
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
    _updategamerprofile();
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

  _missionfailed(func_93AB());
}

func_F487(var_0) {
  level.var_B8BE = var_0;
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
  var_0 = gettime();

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

  return gettime() - var_0;
}

func_79C8(var_0, var_1) {
  var_2 = _getaiarray(var_0);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5.var_EDAD)) {
      continue;
    }
    if(var_5.var_EDAD != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

get_all_force_color_friendlies() {
  var_0 = _getaiarray("allies");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.var_EDAD)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
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
  var_0 = self.var_EDAD;
  return var_0;
}

func_FEEE(var_0) {
  return level.var_43A3[tolower(var_0)];
}

func_F3B5(var_0) {
  var_1 = func_FEEE(var_0);

  if(!isai(self)) {
    func_F3B7(var_1);
    return;
  }

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.var_ED34 = undefined;
  self.var_ED33 = undefined;
  self.var_C3BE = undefined;
  var_2 = scripts\sp\colors::func_7CE4();

  if(isDefined(self.var_EDAD)) {
    level.var_22E0[var_2][self.var_EDAD] = scripts\engine\utility::array_remove(level.var_22E0[var_2][self.var_EDAD], self);
  }

  self.var_EDAD = var_1;
  level.var_22E0[var_2][var_1] = func_22B9(level.var_22E0[var_2][var_1]);
  level.var_22E0[var_2][self.var_EDAD] = scripts\engine\utility::array_add(level.var_22E0[var_2][self.var_EDAD], self);
  thread scripts\sp\utility_code::func_BF01(var_1);
}

func_F3B7(var_0) {
  self.var_EDAD = var_0;
  self.var_C3BE = undefined;
}

func_6EDC(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

func_6ED8(var_0) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self _meth_80D0(0);
  wait(var_0 + 2);
  self _meth_80D0(1);
}

func_E2B0() {
  scripts\common\createfx::restart_fx_looper();
}

pauseexploder(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        var_3 scripts\engine\utility::pauseeffect();
      }

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 scripts\engine\utility::pauseeffect();
    }
  }
}

func_E2B1(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        var_3 func_E2B0();
      }

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 func_E2B0();
    }
  }
}

func_9326(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_0) {
    self.var_C3DE = self getthreatbiasgroup();
    var_1 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = _getaiarray(var_2[self.team]);
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;
    }

    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++) {
      _setthreatbias(var_6[var_5], "ignore_everybody", 0);
    }
  } else {
    var_1 = undefined;

    if(self.var_C3DE != "") {
      self setthreatbiasgroup(self.var_C3DE);
    }

    self.var_C3DE = undefined;
  }
}

func_131CC() {
  scripts\sp\vehicle_code::func_13219();
}

func_13221() {
  thread scripts\sp\vehicle_paths::func_13222();
}

func_131FF(var_0) {
  scripts\sp\vehicle_code::func_13201(var_0);
}

func_13206(var_0) {
  scripts\sp\vehicle_code::func_13207(var_0);
}

func_131D5(var_0, var_1) {
  scripts\sp\vehicle::func_1321A(var_0, var_1);
}

func_864C(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 = var_1 * -100000;
  } else {
    var_1 = (0, 0, -100000);
  }

  return bulletTrace(var_0, var_0 + var_1, 0, self)["position"];
}

func_3C4A(var_0) {
  self.var_D0CE = self.var_D0CE + var_0;
  self notify("update_health_packets");

  if(self.var_D0CE >= 3) {
    self.var_D0CE = 3;
  }
}

maymovetopoint(var_0, var_1) {
  var_2 = melee(var_0, var_1);
  return var_2[0];
}

melee(var_0, var_1) {
  return scripts\sp\vehicle_code::func_12B8(var_0, var_1);
}

func_1749(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\sp\starts::func_174A();
  var_0 = tolower(var_0);
  var_7 = scripts\sp\starts::func_174B(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  level.var_10C58[level.var_10C58.size] = var_7;
  level.var_10BA8[var_0] = var_7;
}

func_F343(var_0) {
  level.var_5019 = var_0;
}

func_F344(var_0) {
  level.var_501A = var_0;
}

func_13D91(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

func_7951(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

func_13D92(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = scripts\engine\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2) {
      return 0;
    }
  }

  return 1;
}

func_135AF(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0) {
    wait(var_2);
  }
}

func_29C0() {
  anim.var_EF75 = gettime();
}

func_5480(var_0) {
  func_29C0();
  scripts\sp\anim::func_1F32(self, var_0);
}

func_7749(var_0, var_1) {
  func_29C0();
  scripts\sp\anim::func_1ECD(self, var_0, undefined, undefined, var_1);
}

func_DBEF(var_0, var_1) {
  if(!isDefined(level.var_D24D)) {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D24D = var_2;
  }

  func_29C0();
  var_3 = 0;

  if(!isDefined(var_1)) {
    var_3 = level.var_D24D func_74D7(::play_sound_on_tag, level.var_EC91[var_0], undefined, 1);
  } else {
    var_3 = level.var_D24D func_74DD(var_1, ::play_sound_on_tag, level.var_EC91[var_0], undefined, 1);
  }

  return var_3;
}

func_DBF2(var_0) {
  level.var_D24D play_sound_on_tag(level.var_EC91[var_0], undefined, 1);
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

func_DBF1(var_0) {
  if(!isDefined(level.var_D24D)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D24D = var_1;
  }

  level.var_D24D play_sound_on_tag(level.var_EC91[var_0], undefined, 1);
}

func_DBF4(var_0) {
  return func_DBEF(var_0, 0.05);
}

func_10350(var_0, var_1) {
  scripts\sp\utility_code::func_1778(var_0);
  func_DBEF(var_0, var_1);
}

func_10352(var_0) {
  scripts\sp\utility_code::func_1778(var_0);
  func_DBF5();
  func_DBF1(var_0);
}

func_10353(var_0) {
  scripts\sp\utility_code::func_1778(var_0);
  func_DBF2(var_0);
}

func_D01B(var_0, var_1) {
  return func_D01E(var_0, 0, undefined, undefined, undefined, var_1);
}

func_1369(var_0, var_1, var_2, var_3, var_4) {
  if(func_9BB2()) {
    return;
  }
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_5 linkto(self);

  if(var_1 > 0) {
    var_5 scripts\engine\utility::delaycall(var_1, ::playsound, var_0, "sounddone");
  } else {
    var_5 playSound(var_0, "sounddone");
  }

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(isDefined(var_4) && isDefined(var_4[var_6])) {
          level.player scripts\engine\utility::delaythread(var_3[var_6], ::func_D090, var_2[var_6], var_4[var_6]);
          continue;
        }

        level.player scripts\engine\utility::delaythread(var_3[var_6], ::func_D090, var_2[var_6]);
      }
    } else if(isDefined(var_4))
      level.player scripts\engine\utility::delaythread(var_3, ::func_D090, var_2, var_4);
    else {
      level.player scripts\engine\utility::delaythread(var_3, ::func_D090, var_2);
    }
  }

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(scripts\sp\utility_code::func_1362A(var_5, level.player))) {
    var_5 stopsounds();
  }

  wait 0.05;
  var_5 delete();
}

func_D01E(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.var_D01D)) {
    var_6 = spawn("script_origin", (0, 0, 0));
    var_6 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D01D = var_6;
  }

  func_29C0();
  var_7 = 0;

  if(!isDefined(var_5)) {
    var_7 = level.var_D01D func_74D7(::func_1369, level.var_EC8E[var_0], var_1, var_2, var_3, var_4);
  } else {
    var_7 = level.var_D01D func_74DD(var_5, ::func_1369, level.var_EC8E[var_0], var_1, var_2, var_3, var_4);
  }

  return var_7;
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

func_D01F(var_0) {
  func_D020();

  if(!isDefined(level.var_D01D)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level.var_D01D = var_1;
  }

  level.var_D01D func_1369(level.var_EC8E[var_0], 0);
}

func_1034D(var_0, var_1) {
  scripts\sp\utility_code::func_1773(var_0);
  func_D01B(var_0, var_1);
}

func_1034F(var_0) {
  scripts\sp\utility_code::func_1773(var_0);
  func_D01F(var_0);
}

func_1034E(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\sp\utility_code::func_1773(var_0);
  func_D01E(var_0, var_1, var_2, var_3, var_4, var_5);
}

func_10346(var_0) {
  scripts\sp\utility_code::func_175F(var_0);
  func_5480(var_0);
}

func_10347(var_0) {
  scripts\sp\utility_code::func_1760(var_0);
  func_7749(var_0);
}

func_DBF3(var_0) {
  func_DBEF(var_0);
}

string(var_0) {
  return "" + var_0;
}

func_9329(var_0, var_1) {
  setignoremegroup(var_0, var_1);
  setignoremegroup(var_1, var_0);
}

func_16E5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level.var_10707[var_0][level.var_10707[var_0].size] = var_5;
}

func_E031(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.var_10707[var_0].size; var_3++) {
    if(level.var_10707[var_0][var_3]["function"] != var_1) {
      var_2[var_2.size] = level.var_10707[var_0][var_3];
    }
  }

  level.var_10707[var_0] = var_2;
}

func_693E(var_0, var_1) {
  if(!isDefined(level.var_10707)) {
    return 0;
  }

  for(var_2 = 0; var_2 < level.var_10707[var_0].size; var_2++) {
    if(level.var_10707[var_0][var_2]["function"] == var_1) {
      return 1;
    }
  }

  return 0;
}

func_E08B(var_0) {
  var_1 = [];

  foreach(var_3 in self.var_10708) {
    if(var_3["function"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.var_10708 = var_1;
}

func_1747(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self.var_10708) {
    if(var_7["function"] == var_0) {
      return;
    }
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self.var_10708[self.var_10708.size] = var_9;
}

func_228A(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1])) {
      var_0[var_1] delete();
    }
  }
}

func_229F(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] _meth_81D0();
  }
}

func_931D(var_0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

func_15F5(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 func_15F1();
}

func_15F3(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 func_15F1();
}

func_5599(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 scripts\engine\utility::trigger_off();
}

func_5598(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::trigger_off();
}

func_624C(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 scripts\engine\utility::trigger_on();
}

func_624B(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::trigger_on();
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

func_F5C3(var_0, var_1) {
  var_2 = _getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3].pacifist = var_1;
  }
}

func_E198() {
  scripts\sp\colors::func_43AA();
}

func_107B3(var_0, var_1) {
  scripts\sp\colors::func_43AC(var_0, var_1);
}

func_F55D(var_0, var_1) {
  if(!isDefined(level.var_4B58)) {
    level.var_4B58 = [];
  }

  var_0 = func_FEEE(var_0);
  var_1 = func_FEEE(var_1);
  level.var_4B58[var_0] = var_1;

  if(!isDefined(level.var_4B58[var_1])) {
    func_F38A(var_1);
  }
}

func_F38A(var_0) {
  if(!isDefined(level.var_4B58)) {
    level.var_4B58 = [];
  }

  level.var_4B58[var_0] = "none";
}

func_DFEB(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

func_DFDA(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.var_EDAD)) {
      continue;
    }
    if(var_4.var_EDAD == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

func_E05E(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

func_78AF(var_0, var_1) {
  var_2 = func_79C8("allies", var_0);

  if(!isDefined(var_1)) {
    var_3 = level.player.origin;
  } else {
    var_3 = var_1;
  }

  return scripts\engine\utility::getclosest(var_3, var_2);
}

func_E0AF(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

func_E0B0(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].model, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

func_78B0(var_0, var_1, var_2) {
  var_3 = func_79C8("allies", var_0);

  if(!isDefined(var_2)) {
    var_4 = level.player.origin;
  } else {
    var_4 = var_2;
  }

  var_3 = func_E0AF(var_3, var_1);
  return scripts\engine\utility::getclosest(var_4, var_3);
}

func_DA6E(var_0, var_1) {
  for(;;) {
    var_2 = func_78AF(var_0);

    if(!isalive(var_2)) {
      wait 1;
      continue;
    }

    var_2 func_F3B5(var_1);
    return;
  }
}

func_9931(var_0, var_1) {
  for(;;) {
    var_2 = func_78AF(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 func_F3B5(var_1);
    return;
  }
}

func_9932(var_0, var_1, var_2) {
  for(;;) {
    var_3 = func_78B0(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 func_F3B5(var_1);
    return;
  }
}

func_DA6F(var_0, var_1, var_2) {
  for(;;) {
    var_3 = func_78B0(var_0, var_2);

    if(!isalive(var_3)) {
      wait 1;
      continue;
    }

    var_3 func_F3B5(var_1);
    return;
  }
}

riotshield_lock_orientation(var_0) {
  self orientmode("face angle", var_0);
  self.lockorientation = 1;
}

riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

func_9934(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_3 || !issubstr(var_6.classname, var_2)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    var_3 = 1;
    var_6 func_F3B5(var_1);
  }

  return var_4;
}

func_9933(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
    var_5 func_F3B5(var_1);
  }

  return var_3;
}

func_13624(var_0) {
  scripts\sp\utility_code::func_13634(var_0, "script_noteworthy");
}

func_13630(var_0) {
  scripts\sp\utility_code::func_13634(var_0, "targetname");
}

func_135D5(var_0, var_1) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait(var_1);
}

func_135F1(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

func_13635(var_0) {
  self endon("trigger");
  wait(var_0);
}

func_135CA(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = [];
  var_3 = scripts\engine\utility::array_combine(var_3, getEntArray(var_0, "targetname"));
  var_3 = scripts\engine\utility::array_combine(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2 thread scripts\sp\utility_code::func_65FB(var_3[var_4]);
  }

  var_2 waittill("done");
}

func_5CC9(var_0) {
  var_1 = func_0B77::func_1085E(var_0);
  return var_1;
}

func_6B47(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = func_0B77::func_1085E(var_0);
  var_1[[level.var_6B43]]();
  var_1.var_10707 = var_0.var_10708;
  var_1.var_10708 = undefined;
  var_1 thread func_0B77::func_E81A();
  var_1.spawner = var_0;
  var_1.var_ED8A = 1;

  if(isDefined(var_0.var_EE5A)) {
    var_1.var_C05C = var_0.var_EE5A;
  }

  if(isDefined(var_0.var_EE5F)) {
    var_1.noragdoll = var_0.var_EE5F;
  }

  return var_1;
}

func_2C17(var_0) {
  var_1 = func_0B77::func_1085E(var_0);
  var_1.var_10707 = var_0.var_10708;
  var_1.var_10708 = undefined;
  var_1 thread func_0B77::func_E81A();
  return var_1;
}

func_5CC8(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = func_0B77::func_1085E(var_0);
  var_1[[level.var_5C7C]]();
  var_1.var_10707 = var_0.var_10708;
  var_1.var_10708 = undefined;
  var_1 thread func_0B77::func_E81A();
  return var_1;
}

func_48C1() {
  var_0 = getEntArray("corpse", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_0, ::func_9591);
  }

  var_0 = getEntArray("corpse_noragdoll", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_0, ::func_9591);
  }

  var_0 = func_7C84("corpse", "script_noteworthy");

  if(var_0.size) {
    func_22C7(var_0, ::func_9591);
  }
}

func_9591() {
  if(!isDefined(self.script_animation)) {
    self delete();
  } else {
    self.var_1FBB = "corpse";
    self _meth_839E();

    if(isai(self)) {
      self.ignoreall = 1;
    } else {
      self notsolid();
    }

    if(isDefined(self.target)) {
      var_0 = scripts\engine\utility::get_target_ent(self.target);
      self dontinterpolate();

      if(isai(self)) {
        self _meth_80F1(var_0.origin, var_0.angles);
      } else {
        self.origin = var_0.origin;
        self.angles = var_0.angles;
      }
    }

    var_1 = getweaponmodel(self.weapon);

    if(isDefined(var_1) && var_1 != "") {
      if(isai(self)) {
        func_86E4();
      } else {
        self detach(var_1, "tag_weapon_right");
      }

      if(!isDefined(self.var_EE5A)) {
        var_2 = spawn("weapon_" + self.weapon, self gettagorigin("tag_weapon_right"));
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
      var_3 = getanimlength(func_7DC1(self.script_animation));

      if(var_3 > 0) {
        wait(var_3 * 0.35);
      }

      if(isDefined(self.var_71C8)) {
        self[[self.var_71C8]]();
      }

      self startragdoll();
    }
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
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
}

func_4793(var_0) {
  if(var_0 == "on") {
    func_61E7();
  } else {
    func_5514();
  }
}

func_13861(var_0, var_1, var_2) {
  if(var_0 == "on") {
    self._blackboard.var_13863 = 1;

    if(isDefined(var_2)) {
      if(var_2 == "right") {
        self.var_13862 = "right";
      } else {
        self.var_13862 = "left";
      }
    }

    if(!isDefined(var_1)) {
      self.var_13864 = level.player;
    } else {
      self.var_13864 = var_1;

      if(!isDefined(var_1.origin)) {
        return;
      }
    }
  } else
    self._blackboard.var_13863 = 0;
}

func_DC45(var_0) {
  if(isplayer(self)) {
    switch (var_0) {
      case "raise":
        func_0E4B::func_1348D();
        break;
      case "lower":
        func_0E4B::func_13485();
        break;
    }

    return;
  }

  if(var_0 == "raise") {
    self.asm.var_DC48 = 1;
  } else {
    self.asm.var_DC48 = 0;
  }

  func_0A1E::func_236E();
}

func_61E7(var_0) {
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(var_0)) {
    self.var_4797 = 1;
  }

  self.turnrate = 0.2;
  level thread scripts\anim\cqb::func_6CB4();
  func_51E1("cqb");
}

func_5514() {
  if(self.type == "dog") {
    return;
  }
  self.var_4797 = undefined;
  self.turnrate = 0.3;
  self.var_478F = undefined;
  func_4145();
}

func_622F() {
  self.var_32D4 = 1;
}

func_5574() {
  self.var_32D4 = undefined;
}

func_4788(var_0) {
  if(!isDefined(var_0)) {
    self.var_4792 = undefined;
  } else {
    self.var_4792 = var_0;

    if(!isDefined(var_0.origin)) {
      return;
    }
  }
}

func_F3B8(var_0) {
  if(isDefined(var_0) && var_0) {
    self.forcesuppression = 1;
  } else {
    self.forcesuppression = undefined;
  }
}

func_F225(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
  } else {
    self notify(var_0);
  }
}

func_137A3(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 scripts\engine\utility::delaythread(var_2, ::func_F225, "complete");
  self waittillmatch(var_0, var_1);
}

func_137A4(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 scripts\engine\utility::delaythread(var_2, ::func_F225, "complete");
  self waittill(var_0, var_1);
  return var_1;
}

func_6DDE(var_0) {
  if(!isDefined(self.var_11A3F)) {
    self.var_11A3F = [];
  }

  if(isDefined(self.var_11A3F[var_0.unique_id])) {
    return 0;
  }

  self.var_11A3F[var_0.unique_id] = 1;
  return 1;
}

func_7DC1(var_0) {
  return level.var_EC85[self.var_1FBB][var_0];
}

func_8BC9(var_0) {
  return isDefined(level.var_EC85[self.var_1FBB][var_0]);
}

func_7DC2(var_0, var_1) {
  return level.var_EC85[var_1][var_0];
}

func_7DC3(var_0) {
  return level.var_EC85["generic"][var_0];
}

func_8BCA(var_0) {
  return isDefined(level.var_EC85["generic"][var_0]);
}

func_16EB(var_0, var_1, var_2) {
  if(!isDefined(level.var_12750)) {
    level.var_12750 = [];
    level.var_1274F = [];
  }

  level.var_12750[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2)) {
    level.var_1274F[var_0] = var_2;
  }
}

clearthreatbias(var_0, var_1) {
  _setthreatbias(var_0, var_1, 0);
  _setthreatbias(var_1, var_0, 0);
}

func_11813() {
  scripts\anim\combat_utility::func_11814();
}

func_F417(var_0) {
  self.ignoresuppression = var_0;
}

func_F3E0(var_0) {
  self.goalradius = var_0;
}

func_F2A8(var_0) {
  self.allowdeath = var_0;
}

func_F582(var_0, var_1) {
  if(getdvarint("ai_iw7", 0) == 1) {
    var_2 = "combat";
    func_F48E(var_2, var_0);
    self.var_E80C = level.var_EC85[self.var_1FBB][var_0];
    return;
  }

  if(isDefined(var_1)) {
    self.alwaysrunforward = var_1;
  } else {
    self.alwaysrunforward = 1;
  }

  func_559A();
  self.var_E80C = level.var_EC85[self.var_1FBB][var_0];
  self.var_13872 = self.var_E80C;
}

func_F48E(var_0, var_1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "move", level.var_EC85[self.var_1FBB][var_1]);
}

func_4169(var_0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_0, "move");
}

func_F40E(var_0, var_1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "idle", level.var_EC85[self.var_1FBB][var_1]);
}

func_415D(var_0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_0, "idle");
}

func_F35F() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.var_55ED = 1;
  self.var_EE56 = 1;
}

func_F303(var_0, var_1, var_2, var_3) {
  scripts\anim\animset::func_950F(var_0, var_1, var_2, var_3);
}

func_F48F(var_0, var_1, var_2) {
  var_3 = scripts\anim\utility::func_B028(var_0);

  if(isarray(var_1)) {
    var_3["straight"] = var_1[0];
    var_3["move_f"] = var_1[0];
    var_3["move_l"] = var_1[1];
    var_3["move_r"] = var_1[2];
    var_3["move_b"] = var_1[3];
  } else {
    var_3["straight"] = var_1;
    var_3["move_f"] = var_1;
  }

  if(isDefined(var_2)) {
    var_3["sprint"] = var_2;
  }

  self.custommoveanimset[var_0] = var_3;
}

func_F2C9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(self.var_22EE)) {
    self.var_22EE = var_0;
  } else {
    return;
  }
}

func_412D() {
  if(isDefined(self.var_22EE)) {
    self.var_22EE = 1;
  }
}

func_C81A(var_0) {
  var_1 = func_0A1E::func_2357(self.asm.archetype, "move_walk_loop", "casual_purpose");
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "move", var_1);

  if(var_0 == "casual") {
    thread func_F2C9(1.15);
  }
}

func_416A() {
  thread func_4169(scripts\asm\asm::asm_getdemeanor());
  thread func_412D();
}

func_51E1(var_0) {
  if(var_0 == "cqb") {
    level thread scripts\anim\cqb::func_6CB4();
  }

  if(self.asmname == "soldier") {
    if(var_0 == "casual" || var_0 == "casual_walk" || var_0 == "casual_gun") {
      self.turnrate = 0.1;
    } else if(var_0 == "cqb") {
      self.turnrate = 0.2;
    } else {
      self.turnrate = 0.3;
    }
  }

  self.demeanoroverride = var_0;
}

func_4145() {
  self.demeanoroverride = undefined;

  if(self.asmname == "soldier") {
    self.turnrate = 0.3;
  }
}

func_F3C8(var_0) {
  var_1 = level.var_EC85["generic"][var_0];

  if(isarray(var_1)) {
    self.var_1095A = var_1;
  } else {
    self.var_1095A[0] = var_1;
  }
}

func_13035(var_0, var_1, var_2) {
  scripts\asm\asm_bb::func_296E(var_0);
  scripts\asm\asm_bb::func_296F(var_1);
  var_4 = (-16, 0, 0);
  var_5 = var_0 localtoworldcoords(var_4);
  var_6 = _physicstrace(var_5, var_5 + (0, 0, -72));
  var_7 = (0, var_0.angles[1], 0);

  if(isDefined(self getlinkedparent())) {
    self unlink();
  }

  self _meth_80F1(var_6, var_7);
  var_8 = var_0 getlinkedparent();

  if(isDefined(var_8)) {
    self linkto(var_8);
  }

  var_9 = self.asmname;
  var_10 = self.var_164D[var_9].var_4BC0;
  var_11 = anim.asm[var_9].states[var_10];
  scripts\asm\asm::func_2388(var_9, var_10, var_11, var_11.var_116FB);
  scripts\asm\asm::func_238A(var_9, "script_use_turret", 0.2);
}

func_11051() {
  scripts\asm\asm_bb::func_296E(undefined);
  scripts\asm\asm_bb::func_296F(undefined);
}

func_4154() {
  self.var_1095A = undefined;
  self notify("stop_specialidle");
}

func_F3CB(var_0, var_1) {
  func_F3CC(var_0, undefined, var_1);
}

func_4155() {
  self notify("movemode");
  func_624D();
  self.var_E80C = undefined;
  self.var_13872 = undefined;
}

func_F3CC(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.var_E80C = level.var_EC85["generic"][var_0];
  self.var_13872 = self.var_E80C;

  if(isDefined(var_1)) {
    self.var_E80B = level.var_EC85["generic"][var_1];
    self.var_13871 = self.var_E80B;
  } else {
    self.var_E80B = undefined;
    self.var_13871 = undefined;
  }
}

func_F583(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  func_559A();
  self.var_E80C = level.var_EC85[self.var_1FBB][var_0];
  self.var_13872 = self.var_E80C;

  if(isDefined(var_1)) {
    self.var_E80B = level.var_EC85[self.var_1FBB][var_1];
    self.var_13871 = self.var_E80B;
  } else {
    self.var_E80B = undefined;
    self.var_13871 = undefined;
  }
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
    var_0 = "combat";
    self._blackboard.alwaysrunforward = 0;
    func_4169(var_0);
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

func_CB0F(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    var_0 = 400;
    var_1 = 256;
    var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for(;;) {
    wait 0.1;
    var_2 = var_5;

    if(self.code_classname == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1) {
      var_7 = 1;
    }

    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025) {
      _physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
    }
  }
}

func_F3D5(var_0) {
  self setgoalentity(var_0);
}

func_15F1(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    func_15F2(var_2);
  } else {
    var_3 = getEntArray(var_0, var_1);
    scripts\engine\utility::array_thread(var_3, ::func_15F2, var_2);
  }
}

func_15F2(var_0) {
  if(isDefined(self.var_ED33)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("allies");
  }

  if(isDefined(self.var_ED34)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::func_159B("axis");
  }

  self notify("trigger", var_0);
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

func_4186(var_0) {
  level.var_4BE0[var_0]["r"] = undefined;
  level.var_4BE0[var_0]["b"] = undefined;
  level.var_4BE0[var_0]["c"] = undefined;
  level.var_4BE0[var_0]["y"] = undefined;
  level.var_4BE0[var_0]["p"] = undefined;
  level.var_4BE0[var_0]["o"] = undefined;
  level.var_4BE0[var_0]["g"] = undefined;
}

func_C12D(var_0, var_1) {
  self endon("death");

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
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

func_CC06(var_0, var_1) {
  if(!scripts\anim\utility::func_1A18(var_0)) {
    scripts\anim\init::func_98E1(var_0);
  }

  scripts\anim\shared::placeweaponon(var_0, var_1);
}

func_72EC(var_0, var_1) {
  if(!scripts\anim\init::func_A000(var_0)) {
    scripts\anim\init::func_98E1(var_0);
  }

  var_2 = self.weapon != "none";
  var_3 = scripts\anim\utility_common::isusingsidearm();
  var_4 = var_1 == "sidearm";
  var_5 = var_1 == "secondary";

  if(var_2 && var_3 != var_4) {
    if(var_3) {
      var_6 = "none";
    } else if(var_5) {
      var_6 = "back";
    } else {
      var_6 = "chest";
    }

    scripts\anim\shared::placeweaponon(self.weapon, var_6);
    self.lastweapon = self.weapon;
  } else
    self.lastweapon = var_0;

  scripts\anim\shared::placeweaponon(var_0, "right");

  if(var_4) {
    self.var_101B4 = var_0;
  } else if(var_5) {
    self.secondaryweapon = var_0;
  } else {
    self.primaryweapon = var_0;
  }

  self.weapon = var_0;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

func_D1FD(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }
    wait 0.05;
  }
}

func_13763(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread scripts\sp\utility_code::func_13764(var_4, var_0, var_1);
  thread scripts\sp\utility_code::func_13764(var_4, var_2, var_3);
  var_4 waittill("done");
}

func_137AA(var_0) {
  self waittill(var_0);
}

func_56BA(var_0, var_1, var_2, var_3) {
  var_4 = func_7B92();

  if(isDefined(level.var_1274F[var_0])) {
    if(var_4[[level.var_1274F[var_0]]]()) {
      return;
    }
    var_4 thread scripts\sp\utility_code::func_9021(level.var_12750[var_0], level.var_1274F[var_0], var_1, var_2, var_3);
  } else
    var_4 thread scripts\sp\utility_code::func_9021(level.var_12750[var_0]);
}

func_56BE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_7B92();

  if(isDefined(level.var_1274F[var_0]) && var_5[[level.var_1274F[var_0]]]()) {
    return;
  }
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 6);
  var_5 thread scripts\sp\utility_code::func_9021(level.var_12750[var_0], level.var_1274F[var_0], var_2, var_3, var_4, var_1);
}

func_56BF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_7B92();

  if(isDefined(level.var_1274F[var_0]) && var_6[[level.var_1274F[var_0]]]()) {
    return;
  }
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 6);
  var_6 thread scripts\sp\utility_code::func_9021(level.var_12750[var_0], level.var_1274F[var_0], var_3, var_4, var_5, var_1, var_2);
}

func_56BB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_10 = scripts\sp\utility_code::func_900D(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  func_56BA(var_10, var_7, var_8, var_9);
  thread scripts\sp\utility_code::func_900E(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

func_56BC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  var_11 = scripts\sp\utility_code::func_900D(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread func_56BE(var_11, var_1, var_8, var_9, var_10);
  thread scripts\sp\utility_code::func_900E(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_56BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  var_12 = scripts\sp\utility_code::func_900D(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread func_56BF(var_12, var_1, var_2, var_9, var_10, var_11);
  thread scripts\sp\utility_code::func_900E(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

func_7ECF(var_0) {
  return level.var_EC85["generic"][var_0];
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
  self.fixednode = 1;
}

func_F39E() {
  self.fixednode = 0;
}

func_10619(var_0, var_1) {
  if(isDefined(self.var_ED52)) {
    self endon("death");
    wait(self.var_ED52);
  }

  var_2 = undefined;
  var_3 = isDefined(self.var_EED1) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");

  if(isDefined(self.var_ED6E)) {
    var_2 = func_5CC8(self);
  } else if(isDefined(self.var_ED8A)) {
    var_2 = func_6B47(self);
  } else if(isDefined(self.var_ED1B)) {
    var_2 = func_2C17(self);
  } else if(isDefined(self.var_EDB3) || isDefined(var_0)) {
    var_2 = self _meth_8393(var_3);
  } else {
    var_2 = self dospawn(var_3);
  }

  if(isDefined(var_1) && var_1 && isalive(var_2)) {
    var_2 func_B14F();
  }

  if(!isDefined(self.var_ED6E) && !isDefined(self.var_ED8A) && !isDefined(self.var_ED1B)) {
    func_106ED(var_2);
  }

  if(isDefined(self.var_EEB5)) {
    self delete();
  }

  return var_2;
}

func_74D7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread scripts\sp\utility_code::func_74DB(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return scripts\sp\utility_code::func_74DF(var_6);
}

func_74DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread scripts\sp\utility_code::func_74DB(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7.var_74DA) || var_7 scripts\engine\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout") {
    return scripts\sp\utility_code::func_74DF(var_7);
  } else {
    var_7 notify("death");
    return 0;
  }
}

func_74D9() {
  var_0 = [];

  if(isDefined(self.var_74D7[0]) && isDefined(self.var_74D7[0].var_74DA)) {
    var_0[0] = self.var_74D7[0];
  }

  self.var_74D7 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0].var_74DA) {
    return;
  }
  self.var_74D7 = var_0;
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

func_F2E1(var_0, var_1) {
  _setblur(var_0, var_1);
}

func_F3DD(var_0) {
  self.goalradius = var_0;
}

func_F3D9(var_0) {
  self.var_A906 = var_0;
  self.var_A907 = undefined;
  self.var_A905 = undefined;
  self give_more_perk(var_0);
}

func_F3DA(var_0) {
  var_1 = getnode(var_0, "targetname");
  func_F3D9(var_1);
}

func_F3DC(var_0) {
  self.var_A906 = undefined;
  self.var_A907 = var_0;
  self.var_A905 = undefined;
  self give_mp_super_weapon(var_0);
}

func_F3D3(var_0) {
  func_F3DC(var_0.origin);
  self.var_A905 = var_0;

  if(_isstruct(var_0) && !isDefined(var_0.type)) {
    var_0.type = "struct";
  }
}

func_C27C(var_0) {
  objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

func_7C84(var_0, var_1) {
  var_2 = _getspawnerarray();
  var_3 = [];

  if(var_1 == "code_classname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.code_classname) && var_5.code_classname == var_0) {
        var_3[var_3.size] = var_5;
      }
    }
  } else if(var_1 == "classname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.classname) && var_5.classname == var_0) {
        var_3[var_3.size] = var_5;
      }
    }
  } else if(var_1 == "target") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.target) && var_5.target == var_0) {
        var_3[var_3.size] = var_5;
      }
    }
  } else if(var_1 == "script_linkname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_linkname) && var_5.script_linkname == var_0) {
        var_3[var_3.size] = var_5;
      }
    }
  } else if(var_1 == "script_noteworthy") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0) {
        var_3[var_3.size] = var_5;
      }
    }
  } else if(var_1 == "targetname") {}

  return var_3;
}

func_22C6(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_6 = var_5 func_10808();

      if(isDefined(var_6.target) && !isDefined(var_6.var_EE2B)) {
        var_6 thread scripts\sp\vehicle_paths::setsuit();
      }

      var_3[var_3.size] = var_6;
      continue;
    }

    var_6 = var_5 func_10619(var_1);

    if(!var_2) {}

    var_3[var_3.size] = var_6;
  }

  if(!var_2) {}

  return var_3;
}

func_22CD(var_0, var_1, var_2, var_3) {
  var_4 = _getspawnerarray(var_0);
  var_4 = func_22A2(var_4, getEntArray(var_0, "targetname"));

  if(isDefined(level.var_107A7)) {
    var_5 = scripts\engine\utility::getstructarray(var_0, "targetname");

    if(isDefined(var_3) && var_3) {
      func_51D6(var_5);
    }

    var_6 = func_0B77::func_7BC6(var_5);
    var_4 = scripts\engine\utility::array_combine(var_4, var_6);
  }

  return func_22C6(var_4, var_1, var_2);
}

func_22CB(var_0, var_1, var_2, var_3) {
  var_4 = func_7C84(var_0, "script_noteworthy");
  var_4 = func_22A2(var_4, getEntArray(var_0, "script_noteworthy"));

  if(isDefined(level.var_107A7)) {
    var_5 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");

    if(isDefined(var_3) && var_3) {
      func_51D6(var_5);
    }

    var_6 = func_0B77::func_7BC6(var_5);
    var_4 = scripts\engine\utility::array_combine(var_4, var_6);
  }

  return func_22C6(var_4, var_1, var_2);
}

func_107CD(var_0, var_1) {
  var_2 = _getspawner(var_0, "script_noteworthy");
  var_3 = var_2 func_10619(var_1);
  return var_3;
}

func_107EA(var_0, var_1) {
  var_2 = _getspawner(var_0, "targetname");
  var_3 = var_2 func_10619(var_1);
  return var_3;
}

func_16C5(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.var_545A)) {
    level.var_545A = [];
  }

  if(level.var_545A.size == 5) {
    var_3 = level.var_545A[0];
    level.var_545A = array_remove_index(level.var_545A, 0);
    func_12DB1();
    var_3 thread func_52A5();
  }

  var_4 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_4 = "^1";
        break;
      case "green":
      case "g":
        var_4 = "^2";
        break;
      case "yellow":
      case "y":
        var_4 = "^3";
        break;
      case "blue":
      case "b":
        var_4 = "^4";
        break;
      case "cyan":
      case "c":
        var_4 = "^5";
        break;
      case "purple":
      case "p":
        var_4 = "^6";
        break;
      case "white":
      case "w":
        var_4 = "^7";
        break;
      case "bl":
      case "black":
        var_4 = "^8";
        break;
    }
  }

  var_5 = scripts\sp\hud_util::createfontstring("default", 1);
  var_6 = level.var_545A.size;
  level.var_545A[var_6] = var_5;
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.x = 40;
  var_5.y = 260 + var_6 * 12;
  var_5.label = "" + var_4 + var_0 + ": ^7" + var_1;
  var_5.alpha = 0;
  var_5 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5 endon("death");
  wait 8;
  level.var_545A = scripts\engine\utility::array_remove(level.var_545A, var_5);
  func_12DB1();
  var_5 thread func_52A5();
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
  level.var_545A = scripts\engine\utility::array_removeundefined(level.var_545A);

  foreach(var_2, var_1 in level.var_545A) {
    var_1 moveovertime(0.2);
    var_1.y = 260 + var_2 * 12;
  }
}

func_F3E6(var_0) {
  self.grenadeammo = var_0;
}

func_7B91() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self _meth_8157();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

func_F2D8(var_0) {
  self.var_2894 = var_0;
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }
  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  }

  if(!isDefined(level.var_13E0F)) {
    level.var_13E0F = getdvar("xenonGame") == "true";
  }

  if(!isDefined(level.var_DADB)) {
    level.var_DADB = getdvar("ps3Game") == "true";
  }

  if(!isDefined(level.var_13E0E)) {
    level.var_13E0E = getdvar("xb3Game") == "true";
  }

  if(!isDefined(level.var_DADC)) {
    level.var_DADC = getdvar("ps4Game") == "true";
  }
}

func_9BEE() {
  if(level.var_13E0E || level.var_DADC || !level.console) {
    return 1;
  } else {
    return 0;
  }
}

func_266F(var_0) {
  return scripts\sp\autosave::func_1190(var_0);
}

func_2670() {
  return scripts\sp\autosave::func_1190(1);
}

func_F3C7(var_0) {
  self.var_4E2A = func_7ECF(var_0);
}

func_F333(var_0) {
  self.var_4E2A = func_7DC1(var_0);
}

func_4141() {
  self.var_4E2A = undefined;
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
  self.a.var_5605 = 1;
  self.allowpain = 0;
}

func_6224() {
  self.a.var_5605 = 0;
  self.allowpain = 1;
}

func_2011(var_0) {
  self.var_1C78 = var_0;
}

func_200C() {
  self.var_1C78 = undefined;
}

func_200D(var_0, var_1) {
  if(var_1) {
    if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0 || var_0 == "all") {
      level.var_2006.var_5602 = [];
      level.var_2006.var_5602[0] = var_0;
    } else if(level.var_2006.var_5602[0] != "all")
      level.var_2006.var_5602 = scripts\engine\utility::array_combine_unique(level.var_2006.var_5602, [var_0]);
  } else {
    if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0) {
      return;
    }
    if(var_0 == "all") {
      level.var_2006.var_5602 = undefined;
    } else if(level.var_2006.var_5602[0] == "all") {
      level.var_2006.var_5602 = [];

      if(var_0 == "allies") {
        level.var_2006.var_5602[0] = "axis";
      } else {
        level.var_2006.var_5602[0] = "allies";
      }
    } else {
      level.var_2006.var_5602 = scripts\engine\utility::array_remove_array(level.var_2006.var_5602, [var_0]);
      return;
    }
  }
}

func_A62F() {
  self getrankinfofull(0);
  self _meth_81D0();
  return 1;
}

func_22D8(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnStruct();
    var_4[var_6].var_1187 = 1;
    var_4[var_6] thread scripts\sp\utility_code::func_22D9(var_0[var_6], var_1, var_2);
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_0[var_6]) && var_4[var_6].var_1187) {
      var_4[var_6] waittill("_array_wait");
    }
  }
}

func_54C6() {
  self _meth_81D0((0, 0, 0));
}

func_7FBC(var_0) {
  return level.var_EC8C[var_0];
}

func_9D27() {
  return self playerads() > 0.5;
}

func_5575() {
  self.var_E198 = undefined;
  self notify("_disable_reinforcement");
}

func_137DF(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = level.player;
  }

  var_6 = spawnStruct();

  if(isDefined(var_3)) {
    var_6 thread func_C12D("timeout", var_3);
  }

  var_6 endon("timeout");

  if(!isDefined(var_0)) {
    var_0 = 0.92;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9) {
      var_10 = self getEye();
    } else {
      var_10 = self.origin;
    }

    if(var_5 func_D1DF(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0) {
        return 1;
      }
    } else
      var_8 = var_7;

    wait 0.05;
  }
}

func_137E1(var_0, var_1, var_2, var_3) {
  func_137DF(var_1, var_0, var_2, undefined, var_3);
}

func_D1DF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.8;
  }

  var_4 = func_7B92();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1) {
    return 0;
  }

  if(isDefined(var_2)) {
    return 1;
  }

  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

func_6001(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] func_D1DF(var_0, var_1, var_2, var_3)) {
      return 1;
    }
  }

  return 0;
}

func_D63A(var_0) {
  var_1 = func_7B92();
  var_2 = vectortoangles(var_0 - var_1 getEye());
  var_3 = anglesToForward(var_2);
  var_4 = var_1 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = vectorcross(var_3, var_5);

  if(var_6[2] < 0) {
    return "left";
  } else {
    return "right";
  }
}

func_CFAC(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0.var_D412) && var_0.var_D412 + var_1 >= var_2) {
    return var_0.var_D411;
  }

  var_0.var_D412 = var_2;

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.var_D411 = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 1, level.player, var_0)) {
    var_0.var_D411 = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 1, level.player, var_0)) {
    var_0.var_D411 = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 1, level.player, var_0)) {
    var_0.var_D411 = 1;
    return 1;
  }

  var_0.var_D411 = 0;
  return 0;
}

func_D40E(var_0, var_1) {
  var_2 = var_0 * var_0;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

func_1938(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(func_D40E(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(func_6001(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3].var_B14F)) {
        var_0[var_3] func_1101B();
      }

      var_0[var_3] delete();
      var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}

func_178D(var_0, var_1, var_2, var_3) {
  func_97A2();
  var_4 = spawnStruct();
  var_4.var_376B = self;
  var_4.func = var_0;
  var_4.var_C8FD = [];

  if(isDefined(var_1)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_3;
  }

  if(!isDefined(level.var_13711.var_13590)) {
    level.var_13711.var_13590 = [var_4];
  } else {
    level.var_13711.var_13590[level.var_13711.var_13590.size] = var_4;
  }
}

func_168D(var_0, var_1, var_2, var_3) {
  func_97A2();
  var_4 = spawnStruct();
  var_4.var_376B = self;
  var_4.func = var_0;
  var_4.var_C8FD = [];

  if(isDefined(var_1)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4.var_C8FD[var_4.var_C8FD.size] = var_3;
  }

  level.var_13711.var_1523[level.var_13711.var_1523.size] = var_4;
}

func_16DB(var_0, var_1, var_2, var_3, var_4, var_5) {
  func_97A2();
  var_6 = spawnStruct();
  var_6.var_376B = self;
  var_6.func = var_0;
  var_6.var_C8FD = [];

  if(isDefined(var_1)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_5;
  }

  level.var_13711.var_E7F9[level.var_13711.var_E7F9.size] = var_6;
}

func_16AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  func_97A2();
  var_6 = spawnStruct();
  var_6.var_376B = self;
  var_6.func = var_0;
  var_6.var_C8FD = [];

  if(isDefined(var_1)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_5;
  }

  level.var_13711.var_E7E0[level.var_13711.var_E7E0.size] = var_6;
}

func_171F(var_0, var_1, var_2, var_3, var_4, var_5) {
  func_97A2();
  var_6 = spawnStruct();
  var_6.func = var_0;
  var_6.var_C8FD = [];

  if(isDefined(var_1)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6.var_C8FD[var_6.var_C8FD.size] = var_5;
  }

  level.var_13711.var_E80A[level.var_13711.var_E80A.size] = var_6;
}

func_16CD(var_0) {
  func_97A2();
  var_1 = spawnStruct();
  var_1.var_376B = self;
  var_1.var_6317 = var_0;
  level.var_13711.var_57D7[level.var_13711.var_57D7.size] = var_1;
}

func_57D6() {
  func_97A2();
  func_57D5(level.var_13711.var_13590.size - 1);
}

func_57D5(var_0) {
  func_97A2();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = spawnStruct();
  var_2 = level.var_13711.var_13590;
  var_3 = level.var_13711.var_57D7;
  var_4 = level.var_13711.var_E7F9;
  var_5 = level.var_13711.var_E7E0;
  var_6 = level.var_13711.var_E80A;
  var_7 = level.var_13711.var_1523;
  level.var_13711.var_13590 = [];
  level.var_13711.var_E7F9 = [];
  level.var_13711.var_57D7 = [];
  level.var_13711.var_1523 = [];
  level.var_13711.var_E7E0 = [];
  level.var_13711.var_E80A = [];
  var_1.count = var_2.size;
  var_1 scripts\engine\utility::array_levelthread(var_2, scripts\sp\utility_code::func_13774, var_3);
  var_1 thread scripts\sp\utility_code::func_5767(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1.count <= var_0) {
      break;
    }
    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var_4, scripts\sp\utility_code::func_68CE, []);
  scripts\engine\utility::array_levelthread(var_5, scripts\sp\utility_code::func_68CC);
  scripts\engine\utility::array_levelthread(var_6, scripts\sp\utility_code::func_68CD);
}

func_578A() {
  var_0 = spawnStruct();
  var_1 = level.var_13711.var_E7F9;
  level.var_13711.var_E7F9 = [];

  foreach(var_3 in var_1) {
    level scripts\sp\utility_code::func_68CE(var_3, []);
  }

  var_0 notify("all_funcs_ended");
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

func_13BBF(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = 1;
  }

  if(isDefined(var_0)) {
    scripts\engine\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isplayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_6 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = scripts\engine\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2) {
      thread scripts\engine\utility::play_sound_in_space(var_1, var_3);
    }
  }
}

func_B317(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

func_BF95(var_0) {
  scripts\sp\endmission::func_1355(var_0);
}

func_BF97(var_0, var_1, var_2) {
  if(!scripts\engine\utility::flag_exist("nextmission_preload_complete")) {
    scripts\engine\utility::flag_init("nextmission_preload_complete");
  }

  scripts\engine\utility::flag_clear("nextmission_preload_complete");
  scripts\sp\endmission::func_1356(var_0, var_1, var_2);
  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

func_BF98() {
  scripts\sp\endmission::func_1357();
}

func_CE6D(var_0) {}

func_7F6E(var_0) {
  return scripts\sp\endmission::func_12B0(var_0);
}

func_7E2C(var_0) {
  return scripts\sp\endmission::func_12AF(var_0);
}

func_7F70(var_0) {
  return scripts\sp\endmission::func_12B1(var_0);
}

func_13705(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.script;
  }

  scripts\sp\endmission::func_1455(var_0);
}

func_13C3C(var_0) {
  scripts\sp\endmission::func_1463(var_0);
}

func_13C60() {
  scripts\sp\endmission::func_1464();
}

func_B263(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_5[var_5.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_5[var_5.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_4;
  }

  return var_5;
}

func_6AC4() {
  level.var_6AD2 = 1;
}

func_C08C() {
  level.var_6AD2 = 0;
}

_meth_806D() {
  var_0 = self getweaponslistall();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0) {
    var_4 = var_1["claymore"];
  }

  return var_4;
}

func_1454(var_0) {
  wait(var_0);
}

func_AB9A(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_3 = var_3 + var_7;
      _setsaveddvar(var_0, var_3);
      wait(var_5);
    }
  }

  _setsaveddvar(var_0, var_1);
}

func_AB89(var_0, var_1, var_2, var_3) {
  var_4 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_5 = var_1 - var_4;
  var_6 = 0.05;
  var_7 = int(var_2 / var_6);

  for(var_8 = var_5 / var_7; var_7; var_7--) {
    var_4 = var_4 + var_8;

    if(isDefined(var_3)) {
      var_9 = func_E753(var_4, var_3);
      setomnvar(var_0, var_9);
    } else
      setomnvar(var_0, var_4);

    wait(var_6);
  }

  if(isDefined(var_3)) {
    var_9 = func_E753(var_1, var_3);
    setomnvar(var_0, var_9);
  } else
    setomnvar(var_0, var_1);
}

func_AB8B(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    setomnvar(var_0, int(var_3));
    wait(var_5);
  }

  setomnvar(var_0, int(var_1));
}

func_AB9B(var_0, var_1, var_2, var_3) {
  if(func_9BEE()) {
    func_AB9A(var_0, var_2, var_3);
  } else {
    func_AB9A(var_0, var_1, var_3);
  }
}

settimer(var_0, var_1) {
  if(func_9BB7()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1 && func_9C32()) {
    return;
  }
  level.player giveachievement(var_0);
}

func_D0A1(var_0) {
  if(func_9BB7()) {
    return;
  }
  if(func_9C32()) {
    return;
  }
  self giveachievement(var_0);
}

func_10327(var_0) {
  level.var_1031B.var_1098F = var_0;
}

func_10326(var_0) {
  level.var_1031B.var_1098C = var_0;
}

func_10324(var_0) {
  level.var_1031B.var_ABA1 = var_0;
}

func_10325(var_0) {
  level.var_1031B.var_ABA2 = var_0;
}

func_10321() {
  if(isDefined(level.var_C014) && level.var_C014) {
    return;
  }
  func_0B0B::func_F5A0();
  setslowmotion(level.var_1031B.var_1098C, level.var_1031B.var_1098F, level.var_1031B.var_ABA1);
}

func_10322() {
  if(isDefined(level.var_C014) && level.var_C014) {
    return;
  }
  setslowmotion(level.var_1031B.var_1098F, level.var_1031B.var_1098C, level.var_1031B.var_ABA2);
  func_0B0B::func_F59F();
}

func_16CC(var_0, var_1, var_2, var_3) {
  level.earthquake[var_0]["magnitude"] = var_1;
  level.earthquake[var_0]["duration"] = var_2;
  level.earthquake[var_0]["radius"] = var_3;
}

func_BDF2(var_0, var_1, var_2) {
  level.var_1188.var_A90A = var_0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  _musicstop(0);
  _musicplay(var_0, 0, 1.0, 1, var_2);
}

func_BDDF(var_0, var_1, var_2, var_3, var_4) {
  thread scripts\sp\utility_code::func_BDE1(var_0, var_1, var_2, var_3, var_4);
}

func_BDE3(var_0, var_1, var_2, var_3, var_4) {
  thread scripts\sp\utility_code::func_BDE1(var_0, var_1, var_2, var_3, var_4, 1);
}

func_BDE5(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 > 0) {
    thread scripts\sp\utility_code::func_BDE6(var_0, var_1, var_2, var_3);
    return;
  }

  func_BDEC();
  func_BDF2(var_0, var_2, var_3);
}

func_BDD5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(level.var_1188.var_A90A)) {
    _musicstop(var_1, level.var_1188.var_A90A, var_3);
  }

  level.var_1188.var_A90A = var_0;
  _musicplay(var_0, var_1, var_2, 0, var_3);
  level endon("stop_music");
  wait(var_1);
  level notify("done_crossfading");
}

func_BDEC(var_0) {
  if(!isDefined(var_0) || var_0 <= 0) {
    _musicstop();
  } else {
    _musicstop(var_0);
  }

  level notify("stop_music");
}

func_D121() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    if(isDefined(var_2.var_C182)) {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

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

func_7853(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3.origin;
  }

  return var_1 * (1.0 / var_0.size);
}

func_7748() {
  self.var_4CF5 = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    foreach(var_11 in self.var_4CF5) {
      thread[[var_11]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }
}

func_16B7(var_0) {
  self.var_4CF5[self.var_4CF5.size] = var_0;
}

func_DFE6(var_0) {
  var_1 = [];

  foreach(var_3 in self.var_4CF5) {
    if(var_3 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.var_4CF5 = var_1;
}

func_D4BF(var_0) {
  self playlocalsound(var_0);
}

func_6278(var_0) {
  if(level.players.size < 1) {
    return;
  }
  foreach(var_2 in level.players) {
    if(var_0 == 1) {
      var_2 enableweapons();
      continue;
    }

    var_2 getradiuspathsighttestnodes();
  }
}

func_11633(var_0) {
  level.player setorigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    level.player setplayerangles(var_0.angles);
  }
}

func_11634(var_0) {
  level.player setplayerangles((0, 0, 0));

  if(isDefined(var_0.angles)) {
    level.player setworldupreferenceangles(var_0.angles);
  }

  level.player setorigin(var_0.origin, 1, 1);
  level.player giveflagcapturexp((0, 0, 0));
}

func_12687() {
  var_0 = [];

  if(isDefined(self.var_6633)) {
    var_0 = self.var_6633;
  }

  if(isDefined(self.entity)) {
    var_0[var_0.size] = self.entity;
  }

  scripts\engine\utility::array_levelthread(var_0, scripts\sp\utility_code::func_12688);
}

func_C621(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player getweightedchanceroll(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

func_77E3(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_3 = _getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self)) {
      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

func_7964(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = [];

  if(var_0 == "all") {
    var_1 = func_22A2(level.var_5CC3["allies"].var_2274, level.var_5CC3["axis"].var_2274);
    var_1 = func_22A2(var_1, level.var_5CC3["neutral"].var_2274);
  } else
    var_1 = level.var_5CC3[var_0].var_2274;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

func_7965(var_0) {
  var_1 = func_22A2(level.var_5CC3["allies"].var_2274, level.var_5CC3["axis"].var_2274);
  var_1 = func_22A2(var_1, level.var_5CC3["neutral"].var_2274);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

func_F311(var_0) {
  self.count = var_0;
}

func_7226(var_0, var_1, var_2, var_3) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_4 = undefined;

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type)) {
      var_4 = "struct";
    } else {
      var_4 = "node";
    }
  } else
    var_4 = "entity";

  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  var_5 = self.var_EDB0;
  self.var_EDB0 = 1;
  func_0B77::worldpointinreticle_circle(var_0, var_4, var_2, var_1, var_3);
  self.var_EDB0 = var_5;

  if(!isDefined(self.var_EDB0) || !self.var_EDB0) {
    self.goalradius = level.var_4FF6;
  }
}

func_61F1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = 250;
  }

  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0 * 2;
  }

  if(!isDefined(var_3)) {
    var_3 = var_0 * 1.25;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self.var_5953 = var_5;
  thread scripts\sp\utility_code::func_5F8E(var_0, var_1, var_2, var_3, var_4);
}

func_5523() {
  self notify("stop_dynamic_run_speed");
}

func_D282() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(func_8BAB()) {
    var_0 = 250;
  }

  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = var_1;
    var_2 = level.player;
    self setgoalentity(var_2);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

func_D281() {
  self notify("stop_player_seek");
}

func_1376C(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  var_3 = gettime() + var_2 * 1000;

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }
    if(gettime() > var_3) {
      break;
    }
    wait 0.1;
  }
}

func_1376B(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }
    wait 0.1;
  }
}

func_1376D(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) > var_1) {
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

isprimaryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  switch (scripts\engine\utility::weaponclass(var_0)) {
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
  var_0 = self getweaponslistall();

  if(!isDefined(var_0)) {
    return 0;
  }

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal")) {
      return 1;
    }
  }

  return 0;
}

func_13817(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = self.goalradius;
  }

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

func_D2CD(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isDefined(level.player.var_764D)) {
    level.player.var_764D = var_2;
  }

  var_3 = int(level.player.var_764D * var_0 * 0.01);
  level.player func_D2D1(var_3, var_1);
}

func_2B78(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2)) {
    var_2 = level.player;
  }

  if(!isDefined(var_2.var_BCF5)) {
    var_2.var_BCF5 = 1.0;
  }

  var_3 = var_0 * 0.01;
  var_2 func_2B76(var_3, var_1);
}

func_D2D1(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if(!isDefined(level.player.var_764D)) {
    level.player.var_764D = var_2;
  }

  var_3 = scripts\sp\utility_code::func_764E;
  var_4 = scripts\sp\utility_code::func_764F;
  level.player thread func_D2CE(var_0, var_1, var_3, var_4, "player_speed_set");
}

func_CF97(var_0, var_1) {
  var_2 = scripts\sp\utility_code::func_7647;
  var_3 = scripts\sp\utility_code::func_7648;
  level.player thread func_D2CE(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

func_2B76(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2)) {
    var_2 = level.player;
  }

  if(!isDefined(var_2.var_BCF5)) {
    var_2.var_BCF5 = 1.0;
  }

  var_3 = scripts\sp\utility_code::func_BCF0;
  var_4 = scripts\sp\utility_code::func_BCF3;
  var_2 thread func_D2CE(var_0, var_1, var_3, var_4, "blend_movespeedscale");
}

func_D2CE(var_0, var_1, var_2, var_3, var_4) {
  self notify(var_4);
  self endon(var_4);
  var_5 = [[var_2]]();
  var_6 = var_0;

  if(isDefined(var_1)) {
    var_7 = var_6 - var_5;
    var_8 = 0.05;
    var_9 = var_1 / var_8;
    var_10 = var_7 / var_9;

    while(abs(var_6 - var_5) > abs(var_10 * 1.1)) {
      var_5 = var_5 + var_10;
      [
        [var_3]
      ](var_5);
      wait(var_8);
    }
  }

  [[var_3]](var_6);
}

func_D2CA(var_0) {
  if(!isDefined(level.player.var_764D)) {
    return;
  }
  level.player func_D2D1(level.player.var_764D, var_0);
  waittillframeend;
  level.player.var_764D = undefined;
}

func_2B77(var_0) {
  var_1 = self;

  if(!isplayer(var_1)) {
    var_1 = level.player;
  }

  if(!isDefined(var_1.var_BCF5)) {
    return;
  }
  var_1 func_2B76(1.0, var_0);
  var_1.var_BCF5 = undefined;
}

func_11624(var_0) {
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

func_11645(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isplayer(self)) {
    self setorigin(var_2);
    self setplayerangles(var_3);
  } else if(isai(self))
    self _meth_80F1(var_2, var_3);
  else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

func_1160F(var_0) {
  self _meth_80F1(var_0.origin, var_0.angles);
  self give_mp_super_weapon(self.origin);
  self give_more_perk(var_0);
}

func_BC00(var_0) {
  foreach(var_2 in level.createfxent) {
    var_2.v["origin"] = var_2.v["origin"] + var_0;
  }
}

func_9F59() {
  return isDefined(self.var_102EB);
}

func_2A75(var_0, var_1, var_2) {
  self endon("stop_sliding");
  self endon("death");
  var_3 = self;

  if(var_3 func_65DF("is_sliding")) {
    var_3 func_65DD("is_sliding");
  } else {
    var_3 func_65E0("is_sliding");
  }

  var_4 = isDefined(level.var_4C5D);
  var_5 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.var_102EB = var_5;
  var_6 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.var_7601 = var_6;
  var_7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0);
  var_8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_3, var_7);
  var_9 = 0;
  var_10 = (0, 0, 0);
  var_11 = var_8["normal"];

  for(;;) {
    if(!var_3 isjumping()) {
      var_8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_3, var_7);
      var_11 = var_8["normal"];

      if(isDefined(var_11)) {
        var_12 = vectordot(var_11, (0, 0, 1));

        if(var_12 <= 0.95) {
          var_9 = acos(var_12);
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
  var_15 = vectortoangles(var_11) + var_11 * var_9;
  var_5.var_77BA = spawn("script_model", var_5.origin + anglesToForward(var_15) * 2000);
  var_5.var_77BA.angles = var_15;
  var_3.var_7601.angles = var_15;

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.035;
  }

  var_5 moveslide((0, 0, 15), 15, var_0);
  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 _meth_84FE();
  var_3 forceplaygestureviewmodel("ges_slide", var_5.var_77BA, 0.2);

  if(isDefined(level._effect["vfx_slide_dirt"])) {
    var_16 = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_3.var_7601, "tag_origin");
    var_3.var_7601 show();
  }

  var_3 func_65E1("is_sliding");

  if(var_4) {
    var_3 getweaponweight(var_5, undefined, 1);
    wait 1.0;
    var_3 getweightedchanceroll(var_5, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else
    var_3 getweightedchanceroll(var_5, "tag_origin", 0, 180, 180, 180, 180);

  _setsaveddvar("depthSortViewmodel", 1);
  var_3 scripts\engine\utility::allow_fire(0);
  var_3 scripts\engine\utility::allow_prone(0);
  var_3 scripts\engine\utility::allow_stances(0);
  var_3 scripts\engine\utility::allow_reload(0);
  var_3 thread scripts\sp\utility_code::func_5AAD(var_5, var_1, var_2);
  var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
}

func_6389() {
  var_0 = self;

  if(level.player isgestureplaying()) {
    var_0 stopgestureviewmodel("ges_slide");
    var_0 notify("stop soundfoot_slide_plr_loop");
    var_0 thread play_sound_on_entity("foot_slide_plr_end");
  }

  var_0 scripts\engine\utility::delaycall(0.2, ::_meth_84FD);

  if(level.player getteamflagcount()) {
    var_0 unlink();
    var_0 giveflagcapturexp(var_0.var_102EB.slidevelocity);
  }

  if(isDefined(var_0.var_7601)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      var_1 = scripts\engine\utility::getfx("vfx_slide_dirt");

      if(isDefined(var_1)) {
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_0.var_7601, "tag_origin");
      }
    }

    var_0.var_7601 delete();
  }

  if(var_0 func_65DF("is_sliding") && var_0 func_65DB("is_sliding")) {
    var_0 func_65DD("is_sliding");
  }

  var_0.var_102EB delete();
  var_0 scripts\engine\utility::allow_fire(1);
  var_0 scripts\engine\utility::allow_prone(1);
  var_0 scripts\engine\utility::allow_stances(1);
  var_0 scripts\engine\utility::allow_reload(1);
  _setsaveddvar("depthSortViewmodel", 0);
  var_0 notify("stop_sliding");
}

func_2A76(var_0, var_1, var_2) {
  var_3 = self;

  if(var_3 func_65DF("is_sliding")) {
    var_3 func_65DD("is_sliding");
  } else {
    var_3 func_65E0("is_sliding");
  }

  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  var_4 = isDefined(level.var_4C5D);

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.035;
  }

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.var_102EB = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);
  var_3 func_65E1("is_sliding");

  if(var_4) {
    var_3 getweaponweight(var_5, undefined, 1);
  } else {
    var_3 getweaponvariantattachments(var_5);
  }

  var_3 getradiuspathsighttestnodes();
  var_3 getnumownedactiveagents(0);
  var_3 getnumberoffrozenticksfromwave(1);
  var_3 getnumownedjackals(0);
  var_3 thread scripts\sp\utility_code::func_5AAD(var_5, var_1, var_2);
}

func_638A() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 giveflagcapturexp(var_0.var_102EB.slidevelocity);
  var_0.var_102EB delete();
  var_0 enableweapons();
  var_0 getnumownedactiveagents(1);
  var_0 getnumberoffrozenticksfromwave(1);
  var_0 getnumownedjackals(1);
  var_0 notify("stop_sliding");

  if(var_0 func_65DF("is_sliding") && var_0 func_65DB("is_sliding")) {
    var_0 func_65DD("is_sliding");
  }
}

func_10808() {
  return scripts\sp\vehicle::func_13237(self);
}

func_7E9C(var_0) {
  var_1 = scripts\sp\trigger::func_7AA4();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_7 = scripts\sp\trigger::func_7AA5();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_10 = undefined;

  foreach(var_12 in var_2) {
    if(var_12.var_ED9A == var_0) {
      return var_12;
    }
  }
}

func_7E99(var_0) {
  var_1 = scripts\sp\trigger::func_7AA4();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_7 = scripts\sp\trigger::func_7AA5();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_10 = [];

  foreach(var_12 in var_2) {
    if(var_12.var_ED9A == var_0) {
      var_10[var_10.size] = var_12;
    }
  }

  return var_10;
}

func_F623(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

func_1796(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

func_F622(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

func_F621(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

func_58DA() {
  return isDefined(self.a.var_58DA);
}

func_7C23(var_0) {
  var_1 = func_7B92();

  if(!isDefined(var_0)) {
    var_0 = "steady_rumble";
  }

  var_2 = spawn("script_origin", var_1 getEye());
  var_2.var_99E5 = 1;
  var_2 thread scripts\sp\utility_code::func_12E1F(var_1, var_0);
  return var_2;
}

func_F581(var_0) {
  self.var_99E5 = var_0;
}

func_E7C8(var_0) {
  thread func_E7C9(1, var_0);
}

func_E7C7(var_0) {
  thread func_E7C9(0, var_0);
}

func_E7C9(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.var_99E5;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.var_99E5 = self.var_99E5 + var_4;
    wait 0.05;
  }

  self.var_99E5 = var_0;
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

func_228B(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = scripts\engine\utility::array_randomize(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++) {
        var_3[var_6] delete();
      }

      var_3 = [];
    }
  }

  var_8 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_8[var_8.size] = var_5;
  }

  return var_8;
}

func_1378E(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  self endon("death");

  while(isDefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }
    wait(var_2);
  }
}

func_558D() {
  self.newenemyreactiondistsq = 0;
}

func_6242() {
  self.newenemyreactiondistsq = squared(512);
}

func_61FF(var_0) {
  self.heat = 1;
  self.var_C009 = 1;
  self.usecombatscriptatcover = 1;

  if(!isDefined(var_0) || !var_0) {
    self.var_596C = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    func_558D();
  }

  self.var_1096A = scripts\anim\animset::func_8CD8;
  self.custommoveanimset["run"] = scripts\anim\utility::func_B028("heat_run");
}

func_5537() {
  self.heat = undefined;
  self.var_C009 = undefined;
  self.var_596C = undefined;
  self.usecombatscriptatcover = 0;
  self.maxfaceenemydist = 512;
  self.var_1096A = undefined;
  self.custommoveanimset = undefined;
}

maymovefrompointtopoint() {
  return vehicle_getarray();
}

func_8FE1(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.var_9019)) {
    level.var_9019 scripts\sp\hud_util::destroyelem();
  }

  level.var_9019 = scripts\sp\hud_util::createfontstring("default", 1.5);
  level.var_9019 scripts\sp\hud_util::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level.var_9019.color = (1, 1, 1);
  level.var_9019 give_zap_perk(var_0);
  level.var_9019.alpha = 0;
  level.var_9019 fadeovertime(0.5);
  level.var_9019.alpha = 1;
  wait 0.5;
  level.var_9019 endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    return;
  }

  level.var_9019 fadeovertime(var_3);
  level.var_9019.alpha = 0;
  wait(var_3);
  level.var_9019 scripts\sp\hud_util::destroyelem();
}

func_8FF8() {
  var_0 = 1;

  if(isDefined(level.var_9019)) {
    level notify("clearing_hints");
    level.var_9019 fadeovertime(var_0);
    level.var_9019.alpha = 0;
    wait(var_0);
  }
}

func_A5CE(var_0, var_1) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in level.var_4E3F[var_0]) {
    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        var_5 thread scripts\sp\utility_code::func_A5CF(var_1);
        continue;
      }

      var_5 delete();
    }
  }
}

func_7BB6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "player_view_controller";
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 give_player_session_tokens("manual");
  return var_5;
}

func_48AA(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread scripts\sp\utility_code::func_D961(var_0, self, var_1, var_2, var_3);
  return var_4;
}

func_110A8(var_0) {
  if(!isDefined(self.var_110B7)) {
    self.var_110B7 = [];
  }

  var_1 = [];
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    var_1[var_4] = [];
    var_1[var_4]["clip_left"] = self getweaponammoclip(var_4, "left");
    var_1[var_4]["clip_right"] = self getweaponammoclip(var_4, "right");
    var_1[var_4]["stock"] = self getweaponammostock(var_4);
  }

  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  self.var_110B7[var_0] = [];
  self.var_110B7[var_0]["current_weapon"] = self getcurrentweapon();
  self.var_110B7[var_0]["inventory"] = var_1;
}

func_E2CF(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.var_110B7) || !isDefined(self.var_110B7[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_4, var_3 in self.var_110B7[var_0]["inventory"]) {
    if(weaponinventorytype(var_4) != "altmode") {
      self giveweapon(var_4);
    }

    self setweaponammoclip(var_4, var_3["clip_left"], "left");
    self setweaponammoclip(var_4, var_3["clip_right"], "right");
    self setweaponammostock(var_4, var_3["stock"]);
  }

  var_5 = self.var_110B7[var_0]["current_weapon"];

  if(var_5 != "none") {
    if(scripts\engine\utility::is_true(var_1)) {
      self switchtoweaponimmediate(var_5);
    } else {
      self switchtoweapon(var_5);
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

func_F492(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_1)) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_3 = var_0 - var_2;
    var_4 = 0.05;
    var_5 = var_1 / var_4;

    for(var_6 = var_3 / var_5; abs(var_0 - var_2) > abs(var_6 * 1.1); var_2 = scripts\asm\asm::asm_getmoveplaybackrate()) {
      scripts\asm\asm::func_237B(var_2 + var_6);
      wait(var_4);
    }
  }

  scripts\asm\asm::func_237B(var_0);
}

func_22C7(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0) {
    var_7 thread func_1747(var_1, var_2, var_3, var_4, var_5);
  }
}

func_22CA(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _getspawnerarray(var_0);
  var_6 = func_22A2(var_6, getEntArray(var_0, "targetname"));
  func_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

func_22C9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_7C84(var_0, "script_noteworthy");
  var_6 = func_22A2(var_6, getEntArray(var_0, "script_noteworthy"));
  func_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

func_22C8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_77DF(var_0);
  func_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

func_61ED() {
  self.dontevershoot = 1;
}

func_551B() {
  self.dontevershoot = undefined;
}

func_4960(var_0) {
  if(!isDefined(level.var_11220)) {
    level.var_11220 = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.var_11220[var_0] = var_1;
  return var_1;
}

func_6245() {
  thread func_6246();
}

func_6246() {
  self endon("death");

  for(;;) {
    self.var_115CE = 1;
    wait 0.05;
  }
}

func_5590() {
  self.var_115CE = undefined;
}

func_9A4D() {
  var_0 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_0;
}

func_B3CB(var_0) {
  var_1 = func_9A4D();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = getEntArray(var_4[0], var_4[1]);
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isDefined(level.var_12EF[var_8.var_9A4B].var_EB78)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isDefined(var_11.var_9A4E)) {
        var_11.var_9A4E = [];
      }

      var_11.var_9A4E[var_11.var_9A4E.size] = var_8[[level.var_12EF[var_8.var_9A4B].var_EB78]]();
    }
  }
}

func_15BD() {
  if(!isDefined(self.var_9A4E)) {
    return;
  }
  foreach(var_1 in self.var_9A4E) {
    var_1[[level.var_12EF[var_1.var_9A4B].var_AE17]]();
  }

  self.var_9A4E = undefined;
}

func_515D(var_0) {
  func_B3CB(var_0);

  foreach(var_2 in var_0) {
    var_2.var_9A4E = undefined;
  }
}

func_B3CA(var_0) {
  if(getdvar("createfx") != "") {
    return;
  }
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1[var_1.size] = var_2[var_3];
  }

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
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
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7.masked_exploder = 1;
    }
  }
}

func_15AD() {
  var_0 = spawn("script_origin", (0, 0, 0));

  foreach(var_2 in level.createfxent) {
    if(!isDefined(var_2.v["masked_exploder"])) {
      continue;
    }
    var_0.origin = var_2.v["origin"];
    var_0.angles = var_2.v["angles"];

    if(!var_0 istouching(self)) {
      continue;
    }
    var_3 = var_2.v["masked_exploder"];
    var_4 = var_2.v["masked_exploder_spawnflags"];
    var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
    var_6 = spawn("script_model", (0, 0, 0), var_4);
    var_6 setModel(var_3);
    var_6.origin = var_2.v["origin"];
    var_6.angles = var_2.v["angles"];
    var_2.v["masked_exploder"] = undefined;
    var_2.v["masked_exploder_spawnflags"] = undefined;
    var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_6.disconnect_paths = var_5;
    var_6.targetname = var_2.v["exploder"];
    scripts\common\exploder::setup_individual_exploder(var_6);
    var_2.model = var_6;
  }

  var_0 delete();
}

func_5146(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3.var_5379 = [];
  }

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1) {
            wait 0.05;
          }
        }

        if(!var_3 istouching(var_11)) {
          continue;
        }
        var_11 delete();
        break;
      }
    }
  }
}

func_5153(var_0, var_1) {
  var_2 = getEntArray("script_brushmodel", "classname");
  var_3 = getEntArray("script_model", "classname");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2[var_2.size] = var_3[var_4];
  }

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.targetname)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  func_228A(var_5);
  var_6 delete();
}

setflashbangimmunity(var_0) {
  self.var_6EC4 = var_0;
}

func_6EC3() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0) {
    return 0;
  }

  return var_0 * 0.001;
}

func_6EC5() {
  return func_6EC3() > 0;
}

func_6EC6(var_0) {
  if(isDefined(self.var_6EC4) && self.var_6EC4) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var_1);
  } else {
    self.flashendtime = var_1;
  }

  self notify("flashed");
  self give_money(1);
}

func_13821() {
  for(;;) {
    var_0 = _getaispeciesarray("axis", "all");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 istouching(self)) {
        var_1 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_1) {
      var_5 = func_77E3("axis");

      if(!var_5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

func_13822() {
  var_0 = 0;

  for(;;) {
    var_1 = _getaispeciesarray("axis", "all");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(var_4 func_58DA()) {
          continue;
        }
        var_2 = 1;
        var_0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_2) {
      var_6 = func_77E3("axis");

      if(!var_6.size) {
        break;
      } else
        var_0 = 1;
    }

    wait 0.05;
  }

  return var_0;
}

func_13823(var_0) {
  func_13821();
  scripts\engine\utility::flag_set(var_0);
}

func_1380D(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 func_13823(var_1);
}

func_D0F4() {
  if(isplayer(self)) {
    var_0 = self;
  } else {
    var_0 = level.player;
  }

  return isDefined(var_0.space) && var_0.space.var_6F43;
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

func_F520(var_0) {
  var_1 = func_7B92();
  var_1.gs.var_CF81 = var_0;
  var_1 scripts\sp\gameskill::func_12E0B();
}

func_2298(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3.script_parameters] = var_3;
  }

  return var_1;
}

func_2297(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3.classname] = var_3;
  }

  return var_1;
}

func_2299(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_index)) {
      var_1[var_3.script_index] = var_3;
    }
  }

  return var_1;
}

func_78D5() {
  var_0 = scripts\sp\utility_code::func_78D1();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.var_22DF[var_1][var_3];

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

func_78D3() {
  var_0 = scripts\sp\utility_code::func_78D1();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.var_22DD[var_1][var_3];

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

func_6EC7() {
  self.flashendtime = undefined;
  self give_money(0);
}

func_7E96(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return scripts\engine\utility::getstruct(var_0, var_1);
}

func_7C9A(var_0) {
  return _getcsplineid(var_0);
}

func_7C9B(var_0) {
  return _getcsplineidarray(var_0);
}

grenade_earthquake() {
  thread scripts\sp\utility_code::endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  func_7751(var_0);
}

func_7751(var_0) {
  func_5FC7(var_0);
  func_54EF(var_0);
}

func_5FC7(var_0) {
  playrumbleonentity("grenade_rumble", var_0);
  earthquake(0.4, 0.5, var_0, 400);
}

func_54EF(var_0) {
  if(level.player _meth_853E()) {
    return;
  }
  if(!isDefined(level.player.var_A8FD)) {
    level.player.var_A8FD = gettime();
  } else if(gettime() - level.player.var_A8FD < 3000) {
    return;
  }
  level.player.var_A8FD = gettime();

  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0)) {
      var_2 thread dirteffect(var_0);
    }
  }
}

dirteffect(var_0, var_1) {
  var_2 = func_ECC4(var_0);

  foreach(var_5, var_4 in var_2) {
    thread scripts\sp\gameskill::forcehidegrenadehudwarning(var_5);
  }
}

func_2BC6(var_0) {
  if(!isDefined(self.damageattacker)) {
    return;
  }
  var_1 = func_ECC4(self.damageattacker.origin);

  foreach(var_4, var_3 in var_1) {
    thread scripts\sp\gameskill::func_2BC1(var_4);
  }
}

func_ECC4(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && weapontype(var_7) != "riotshield") {
    var_6["bottom"] = 1;
  }

  if(abs(var_4) < 0.866) {
    if(var_5 > 0) {
      var_6["right"] = 1;
    } else {
      var_6["left"] = 1;
    }
  }

  return var_6;
}

func_C971(var_0) {
  if(!isDefined(self.var_C3D0)) {
    self.var_C3D0 = self.pathrandompercent;
  }

  self.pathrandompercent = var_0;
}

func_C972() {
  if(isDefined(self.var_C3D0)) {
    return;
  }
  self.var_C3D0 = self.pathrandompercent;
  self.pathrandompercent = 0;
}

func_C970() {
  self.pathrandompercent = self.var_C3D0;
  self.var_C3D0 = undefined;
}

func_13876() {
  if(isDefined(self.var_C3E3)) {
    return;
  }
  self.var_C3E2 = self.walkdist;
  self.var_C3E3 = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

func_13875() {
  self.walkdist = self.var_C3E2;
  self.walkdistfacingmotion = self.var_C3E3;
  self.var_C3E2 = undefined;
  self.var_C3E3 = undefined;
}

func_6205() {
  thread func_9330();
}

func_9330() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self.var_6B4B = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isplayer(var_1) && issentient(var_1)) {
      if(isDefined(var_1.enemy) && var_1.enemy != self) {
        continue;
      }
    }

    self.var_6B4B = self.var_6B4B - var_0;

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

func_F2E7(var_0) {
  self.veh_brake = var_0;
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
  self.health = self.var_6B4B;
}

func_11905(var_0) {
  var_1 = spawnStruct();
  var_1 scripts\engine\utility::delaythread(var_0, ::func_F225, "timeout");
  return var_1;
}

func_50E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  childthread scripts\sp\utility_code::func_50E5(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_6E7C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isarray(var_0)) {
    var_0 = [var_0, 0];
  }

  thread scripts\sp\utility_code::func_6E7D(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

func_13843(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isarray(var_0)) {
    var_0 = [var_0, 0];
  }

  thread scripts\sp\utility_code::func_13844(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

func_61EB(var_0) {
  var_0 = var_0 * 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var_0;
  self.var_BEFA = undefined;
}

func_5517() {
  self.dodangerreact = 0;
  self.var_BEFA = 1;
}

func_F3EC(var_0, var_1) {
  level.var_18D7 = var_0;
  level.var_18D6 = var_1;
}

func_E1F2(var_0) {
  level.var_A936[var_0] = gettime();
}

func_F323(var_0) {
  level.var_4C53 = var_0;
  thread scripts\sp\gameskill::func_E26C();
}

func_4140() {
  level.var_4C53 = undefined;
  thread scripts\sp\gameskill::func_E26C();
}

func_11147(var_0) {
  if(var_0.size > 1) {
    return 0;
  }

  var_1 = [];
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

  if(isDefined(var_1[var_0])) {
    return 1;
  }

  return 0;
}

func_F2DC(var_0, var_1) {
  level.var_28CF[var_0] = var_1;
  scripts\sp\utility_code::func_12D95();
}

func_C27B(var_0) {
  for(var_1 = 0; var_1 < 8; var_1++) {
    _objective_additionalposition(var_0, var_1, (0, 0, 0));
  }
}

func_7AE6(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60) {
    var_1["minutes"]++;
  }

  if(var_1["seconds"] < 10) {
    var_1["seconds"] = "0" + var_1["seconds"];
  }

  return var_1;
}

func_D0CA(var_0) {
  var_1 = level.player getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_D0BD(var_0, var_1) {
  var_2 = level.player getweaponslistall();

  foreach(var_4 in var_2) {
    if(var_4 == var_0) {
      return 1;
    }
  }

  if(isDefined(var_1) && var_1 == 1) {
    if(level.player.var_110BD == var_0) {
      return 1;
    }

    if(level.player.var_110BA == var_0) {
      return 1;
    }
  }

  return 0;
}

func_D0BE(var_0) {
  if(level.player.var_110BD == var_0) {
    return 1;
  }

  if(level.player.var_110BA == var_0) {
    return 1;
  }

  return 0;
}

func_C264(var_0) {
  if(!isDefined(level.var_C265)) {
    level.var_C265 = [];
  }

  if(!isDefined(level.var_C265[var_0])) {
    level.var_C265[var_0] = level.var_C265.size + 1;
  }

  return level.var_C265[var_0];
}

func_C268(var_0) {
  return isDefined(level.var_C265) && isDefined(level.var_C265[var_0]);
}

_meth_848C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

func_BDF1(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 * 0.001;
  return var_1;
}

func_9B9D(var_0) {
  var_1 = _getkeybinding(var_0);
  return var_1["count"];
}

func_ACED(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

func_509E(var_0) {
  level.var_AE21 = var_0;
}

func_50A0(var_0) {
  switch (var_0) {
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

func_116CB(var_0) {
  func_509E(var_0);
  level.template_script = var_0;
  func_50A0(var_0);
}

func_116CD(var_0) {
  level.var_25FA = var_0;
}

func_7616(var_0, var_1) {
  thread func_7617(var_0, var_1);
}

func_7617(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  wait 0.05;
  scripts\sp\utility_code::func_7615(var_2, var_1);
}

func_7619(var_0) {
  thread func_761A(var_0);
}

func_761A(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  wait 0.05;

  if(!isDefined(var_1.var_75BA)) {
    return;
  }
  var_1.var_75BA = undefined;
  func_7618(var_1);
}

func_7618(var_0) {
  scripts\engine\utility::array_thread(var_0.fx, ::func_E2B0);
}

func_16AE(var_0, var_1) {
  if(!isDefined(level.var_4074)) {
    level.var_4074 = [];
  }

  if(!isDefined(level.var_4074[var_1])) {
    level.var_4074[var_1] = [];
  }

  level.var_4074[var_1][level.var_4074[var_1].size] = var_0;
}

func_4074(var_0) {
  var_1 = level.var_4074[var_0];
  var_1 = scripts\engine\utility::array_removeundefined(var_1);
  func_228A(var_1);
  level.var_4074[var_0] = undefined;
}

func_4075(var_0) {
  if(!isDefined(level.var_4074)) {
    return;
  }
  if(!isDefined(level.var_4074[var_0])) {
    return;
  }
  var_1 = level.var_4074[var_0];
  var_1 = scripts\engine\utility::array_removeundefined(var_1);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3.var_B14F)) {
      continue;
    }
    if(!var_3.var_B14F) {
      continue;
    }
    var_3 func_1101B();
  }

  func_228A(var_1);
  level.var_4074[var_0] = undefined;
}

func_178A(var_0) {
  if(!isDefined(self.var_1274A)) {
    thread scripts\sp\utility_code::func_1789();
  }

  self.var_1274A[self.var_1274A.size] = var_0;
}

func_7DB7() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(var_3.classname, "weapon_")) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

func_BCA1(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_2)) {
    var_2 = 200;
  }

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectornormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self.velocity = var_5 * (var_3 / var_4);
}

func_6E3D(var_0) {
  level endon(var_0);
  self waittill("death");
  scripts\engine\utility::flag_set(var_0);
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

func_51D5(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstructarray(var_0, var_1);
  func_51D6(var_3, var_2);
}

func_51D4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.script_linkname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0) {
      level.struct_class_names["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0.script_noteworthy;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0) {
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["target"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_1].size == 0) {
      level.struct_class_names["target"][var_1] = undefined;
    }
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_1].size == 0) {
      level.struct_class_names["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3) {
        level.struct[var_4] = undefined;
      }
    }
  }
}

func_51D6(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0);
  var_1 = scripts\engine\utility::ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      func_51D4(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0) {
      func_51D4(var_3);
    }
  }
}

getstruct_delete(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0, var_1);
  func_51D4(var_2);
  return var_2;
}

_meth_8181(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstructarray(var_0, var_1);
  func_51D6(var_3, var_2);
  return var_3;
}

func_13DCC(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglesToForward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

func_10460(var_0, var_1) {
  self ghostattack(0, var_0);

  if(scripts\engine\utility::is_true(var_1)) {
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stoploopsound);
  } else {
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stopsounds);
  }

  scripts\engine\utility::delaycall(var_0 + 0.1, ::delete);
}

func_10461(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 = clamp(var_1, 0, 1);
  var_2 = max(0.05, var_2);
  self ghostattack(0.0);
  wait 0.05;

  if(isDefined(var_3)) {
    self playLoopSound(var_0);
  } else {
    self playSound(var_0);
  }

  wait 0.05;
  scripts\engine\utility::delaycall(0.05, ::ghostattack, var_1, var_2);
}

func_5188() {
  self waittill("sounddone");
  self delete();
}

func_5184(var_0) {
  self waittill(var_0);
  self delete();
}

func_9ACE(var_0, var_1, var_2, var_3, var_4) {
  level.var_9AF3 = spawnStruct();
  level.var_9AF3.var_4480 = 3;
  level.var_9AF3.var_6AAA = 1.5;
  level.var_9AF3.var_6A9F = undefined;

  if(isDefined(var_3)) {
    level.var_9AF3.var_ACF2 = [var_0, var_1, var_2, var_3];
  } else {
    level.var_9AF3.var_ACF2 = [var_0, var_1, var_2];
  }

  scripts\engine\utility::noself_array_call(level.var_9AF3.var_ACF2, ::precachestring);
}

func_9ACF(var_0) {
  level.var_9AF3.var_4C88 = var_0;
}

func_9AD0(var_0, var_1, var_2) {
  level.var_9AF3.var_4480 = var_0;
  level.var_9AF3.var_6AAA = var_1;
  level.var_9AF3.var_6A9F = var_2;
}

func_DE97(var_0, var_1, var_2) {
  scripts\anim\animset::func_DEE7(var_0, var_1, var_2);
}

func_2124(var_0) {
  return scripts\anim\animset::func_2126(var_0);
}

func_F2C8(var_0) {
  self.var_1F62 = var_0;
  self notify("move_loop_restart");

  if(var_0 == "creepwalk") {
    self.sharpturnlookaheaddist = 72;
  }
}

func_412C() {
  if(isDefined(self.var_1F62) && self.var_1F62 == "creepwalk") {
    self.sharpturnlookaheaddist = 30;
  }

  self.var_1F62 = undefined;
  self notify("move_loop_restart");
}

func_12641(var_0) {
  if(_istransientloaded(var_0)) {
    return;
  }
  if(!scripts\engine\utility::flag_exist(var_0 + "_loaded")) {
    scripts\engine\utility::flag_init(var_0 + "_loaded");
  }

  _loadtransient(var_0);

  while(!_istransientloaded(var_0)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set(var_0 + "_loaded");
  level notify("new_transient_loaded");
}

func_1264E(var_0) {
  if(!_istransientloaded(var_0)) {
    return;
  }
  _unloadtransient(var_0);

  while(_istransientloaded(var_0)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_clear(var_0 + "_loaded");
}

func_12643(var_0) {
  foreach(var_2 in var_0) {
    thread func_12641(var_2);
  }

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(!_istransientloaded(var_2)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  level notify("new_transient_loaded");
}

func_12651(var_0) {
  foreach(var_2 in var_0) {
    thread func_1264E(var_2);
  }

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(_istransientloaded(var_2)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      break;
    }
    scripts\engine\utility::waitframe();
  }
}

func_1263F(var_0) {
  scripts\engine\utility::flag_init(var_0 + "_loaded");
}

func_1264C(var_0, var_1) {
  if(scripts\engine\utility::flag(var_0 + "_loaded")) {
    func_1264E(var_0);
  }

  if(!scripts\engine\utility::flag(var_1 + "_loaded")) {
    func_12641(var_1);
  }
}

func_12653(var_0) {
  _unloadalltransients();
  func_12641(var_0);
}

func_F6DB(var_0, var_1, var_2) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    setdvar(var_0, var_2);
  } else {
    setdvar(var_0, var_1);
  }
}

func_F828(var_0, var_1, var_2) {
  if(!isDefined(level.console)) {
    func_F305();
  }

  if(func_9BEE()) {
    _setsaveddvar(var_0, var_2);
  } else {
    _setsaveddvar(var_0, var_1);
  }
}

func_7227(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  self.var_4B76 = var_2;
  var_2 script_delay();

  while(isDefined(var_2)) {
    self.var_4B76 = var_2;

    if(isDefined(var_2.lookahead)) {
      break;
    }
    if(isDefined(level.struct_class_names["targetname"][var_2.targetname])) {
      var_4 = ::func_722A;
    } else if(isDefined(var_2.classname)) {
      var_4 = ::func_7228;
    } else {
      var_4 = ::func_7229;
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

    var_5 = self.goalradius;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation)) {
      var_2 waittill(var_2.animation);
    } else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2.var_ED9E)) {
      scripts\engine\utility::flag_set(var_2.var_ED9E);
    }

    if(isDefined(var_2.script_parameters)) {
      var_6 = strtok(var_2.script_parameters, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level.var_4C50)) {
          self[[level.var_4C50]](var_6[var_7], var_2);
        }

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_7]) {
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

    if(!isDefined(var_2.var_EE95) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(func_722C(var_2, var_1)) {
          break;
        }
        if(isDefined(var_2.animation)) {
          self.goalradius = var_5;
          self give_mp_super_weapon(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }
    if(isDefined(var_2.var_EDA0)) {
      scripts\engine\utility::flag_wait(var_2.var_EDA0);
    }

    var_2 script_delay();
    var_2 = var_2 scripts\engine\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

func_722C(var_0, var_1) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin)) {
    return 1;
  }

  var_2 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_4 = scripts\engine\utility::get_target_ent(var_0.target);
    var_2 = vectornormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_2 = anglesToForward(var_0.angles);
  else {
    var_2 = anglesToForward(self.angles);
  }

  if(vectordot(var_2, var_3) > 0) {
    return 1;
  }

  if(distance(level.player.origin, self.origin) < var_1) {
    return 1;
  }

  return 0;
}

func_7229(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_0 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_0 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    self give_mp_super_weapon(self.origin);
  } else
    func_F3D9(var_0);
}

func_7228(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_0 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_0 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    self give_mp_super_weapon(self.origin);
  } else
    func_F3D3(var_0);
}

func_722A(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::func_1ECE(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    func_5528();

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity")) {
      var_0 scripts\sp\anim::func_1ECB(self, var_0.animation);
    } else {
      var_0 scripts\sp\anim::func_1ED1(self, var_0.animation);
    }

    scripts\engine\utility::delaythread(0.05, ::func_61F7);
    self give_mp_super_weapon(self.origin);
  } else
    func_F3DC(var_0.origin);
}

func_D6D9(var_0) {
  if(!isDefined(level.var_D6D8)) {
    level.var_D6D8 = [];
  }

  level.var_D6D8 = scripts\engine\utility::array_add(level.var_D6D8, var_0);
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

func_12B17(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "on");
}

func_12B16(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "turn_off");
}

func_12B18(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "onetime");
}

hastag(var_0, var_1) {
  if(!isDefined(level.has_tag)) {
    level.has_tag = [];
  }

  var_2 = var_0 + "_" + var_1;

  if(isDefined(level.has_tag[var_2])) {
    return level.has_tag[var_2];
  }

  var_3 = _getnumparts(var_0);

  if(var_3 > 0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tolower(_getpartname(var_0, var_4));

      if(var_5 == tolower(var_1)) {
        level.has_tag[var_2] = 1;
        return 1;
      }
    }

    level.has_tag[var_2] = 0;
  }

  return 0;
}

func_1119E(var_0, var_1, var_2, var_3) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  var_4 = 320;
  var_5 = 200;
  var_6 = [];

  foreach(var_10, var_8 in var_0) {
    var_9 = scripts\sp\introscreen::func_111A0(var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3);
    var_6 = scripts\engine\utility::array_combine(var_9, var_6);
  }

  wait(var_1);
  scripts\sp\introscreen::func_1119F(var_6, var_4, var_5, var_0.size);
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

func_F5AF(var_0, var_1) {
  var_2 = [];

  if(isstring(var_0)) {
    var_2 = scripts\engine\utility::get_target_array(var_0);
  } else if(isarray(var_0)) {
    var_2 = var_0;
  }

  if(var_2.size == 0) {
    return;
  }
  foreach(var_4 in var_1) {
    var_5 = undefined;

    foreach(var_7 in var_2) {
      if(!isDefined(var_7.script_noteworthy)) {
        continue;
      }
      if(isplayer(var_4)) {
        if(var_7.script_noteworthy == "player") {
          var_5 = var_7;
          break;
        }
      } else if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_7.script_noteworthy) {
        var_5 = var_7;
        break;
      }
    }

    if(isDefined(var_5)) {
      var_5.var_1146E = 1;
      var_4.var_10CBA = var_5;

      if(isai(var_4)) {
        var_4 give_mp_super_weapon(var_5.origin);
      }

      var_4 func_11624(var_5);
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.var_10CBA)) {
      continue;
    }
    foreach(var_7 in var_2) {
      if(!isDefined(var_7.var_1146E)) {
        var_7.var_1146E = 1;
        var_4.var_10CBA = var_7;

        if(isai(var_4)) {
          var_4 give_mp_super_weapon(var_7.origin);
        }

        var_4 func_11624(var_7);
        break;
      }
    }
  }
}

func_A6F2(var_0) {}

func_61F0(var_0) {
  func_0B27::func_5F84(var_0);
}

func_5522() {
  func_0B27::func_5557();
}

func_D08C(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if(level.player func_7B8C() == "safe") {
    var_3 = 1.0;
    var_4 = 1;
  }

  var_5 = 0;

  if(isDefined(var_1)) {
    var_2 = self playgestureviewmodel(var_0, var_1, var_5, var_3, undefined);
  } else {
    var_2 = self playgestureviewmodel(var_0, undefined, var_5, var_3, undefined);
  }

  return var_2;
}

func_D091(var_0, var_1) {
  self endon("death");

  if(self _meth_819F()) {
    return 0;
  }

  if(self getteamsize()) {
    return 0;
  }

  return func_D090(var_0, var_1);
}

func_D090(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if(level.player func_7B8C() == "safe") {
    var_3 = 0.2;
    var_4 = 1;
  }

  if(isDefined(var_1) && _isent(var_1)) {
    var_2 = self forceplaygestureviewmodel(var_0, var_1, var_3, undefined, undefined);
  } else {
    var_2 = self forceplaygestureviewmodel(var_0, undefined, var_3, undefined, undefined);
  }

  if(var_2) {
    thread func_0E49::func_D092(var_0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  }

  return var_2;
}

func_77DB(var_0) {
  return level.var_1162[var_0].var_10878 + level.var_1162[var_0].var_1A09;
}

func_77DD(var_0) {
  level.var_1162[var_0].var_1912 = array_removedeadvehicles(level.var_1162[var_0].var_1912);
  level.var_1162[var_0].var_1912 = scripts\engine\utility::array_removeundefined(level.var_1162[var_0].var_1912);
  return level.var_1162[var_0].var_1A09;
}

func_77DE(var_0) {
  return level.var_1162[var_0].var_10878;
}

func_77DC(var_0) {
  return level.var_1162[var_0].var_1A0D;
}

func_77DF(var_0) {
  return level.var_1162[var_0].spawners;
}

func_77DA(var_0) {
  level.var_1162[var_0].var_1912 = array_removedeadvehicles(level.var_1162[var_0].var_1912);
  level.var_1162[var_0].var_1912 = scripts\engine\utility::array_removeundefined(level.var_1162[var_0].var_1912);
  return level.var_1162[var_0].var_1912;
}

func_75C4(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75C5(var_0, var_1, var_2, var_3);
}

func_75C5(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_2)) {
    wait(var_2);
  }

  func_75CD();
  func_1173C(var_1, var_0);
  playFXOnTag(scripts\engine\utility::getfx(var_0), self, var_1);
}

func_75F8(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75F9(var_0, var_1, var_2, var_3);
}

func_1173C(var_0, var_1) {
  if(self.model == "") {}

  if(!hastag(self.model, var_0)) {
    return;
  }
}

func_75F9(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_2)) {
    wait(var_2);
  }

  func_75CD();
  func_1173C(var_1, var_0);
  stopFXOnTag(scripts\engine\utility::getfx(var_0), self, var_1);
}

func_75A0(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_760A)) {
    func_75CE();
  }

  thread func_75A1(var_0, var_1, var_2, var_3);
}

func_75A1(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_2)) {
    wait(var_2);
  }

  func_75CD();
  func_1173C(var_1, var_0);
  _killfxontag(scripts\engine\utility::getfx(var_0), self, var_1);
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
  var_0 = 0;

  for(;;) {
    self waittill("new_fx_call");

    while(self.var_760A.size > 0) {
      var_1 = self.var_760A[0];
      self.var_760A = scripts\engine\utility::array_remove(self.var_760A, var_1);
      self notify(var_1);
      var_0++;

      if(var_0 == 3) {
        wait 0.05;
        var_0 = 0;
      }
    }
  }
}

func_75CD() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = func_79E1();
  self.var_760A = scripts\engine\utility::array_add(self.var_760A, var_0);
  self notify("new_fx_call");
  self waittill(var_0);
}

func_1102B(var_0) {
  if(isDefined(var_0)) {
    self stopgestureviewmodel(var_0);
  } else {
    self stopgestureviewmodel();
  }

  self notify("gesture_stop");
}

func_F526(var_0, var_1) {
  self notify("entering_new_demeanor");

  if(!isDefined(self.var_77C1)) {
    self.var_77C1 = spawnStruct();
  }

  waittillframeend;

  switch (var_0) {
    case "normal":
      func_0E49::func_660C();
      break;
    case "relaxed":
      func_0E49::func_660D();
      break;
    case "safe":
      func_0E49::func_660E(var_1);
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

func_EBA6(var_0, var_1) {
  func_960B();

  if(isDefined(var_0)) {
    _setsaveddvar("bg_gravity", level.isinphase * var_0);
  }

  if(isDefined(var_1)) {
    _physics_setgravity((0, 0, level._meth_8519 * var_1));
  }
}

func_241F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0 && !level.var_241D) {
    level.var_241D = var_0;
  } else if(!var_0 && level.var_241D) {
    level.var_241D = var_0;
  }

  if(isDefined(level.var_A056) && isDefined(level.var_A056.var_241A)) {
    [[level.var_A056.var_241A]](level.var_241D);
  }
}

func_F3E4(var_0, var_1) {
  func_960B();

  if(isDefined(var_0)) {
    _setsaveddvar("bg_gravity", var_0);
  }

  if(isDefined(var_1)) {
    _physics_setgravity((0, 0, var_1));
  }
}

func_E1F0() {
  _setsaveddvar("bg_gravity", level.isinphase);
  _physics_setgravity((0, 0, level._meth_8519));
}

func_77B9(var_0) {
  if(isDefined(self.unittype) && self.unittype == "c6") {
    thread func_0C4C::func_1965(var_0);
  } else {
    thread func_0C4C::func_194F(var_0 * 0.1);
    thread func_0C4C::func_1964(var_0);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self.var_D4A4 = undefined;
}

func_77BD(var_0) {
  thread func_0C4C::func_1967(var_0);
}

func_7793(var_0) {
  thread func_0C4C::func_194F(var_0);
}

func_779E(var_0) {
  if(self.unittype == "c6") {
    thread func_0C4C::func_1965(var_0);
  } else {
    func_0C4C::func_1964(var_0);
  }

  self notify("stop_lookat");
}

func_7799(var_0, var_1, var_2) {
  self endon("death");
  thread func_0C4C::func_1955(var_0, var_1, var_2);
}

func_779A(var_0, var_1, var_2, var_3) {
  thread func_0C4C::func_1956(var_0, var_1, var_2, var_3);
}

func_7798(var_0, var_1, var_2) {
  thread func_0C4C::func_194E(var_0, var_1, var_2);
}

func_779C(var_0, var_1) {
  thread func_0C4C::func_1959(var_0, var_1);
}

func_779B(var_0, var_1) {
  func_0C4C::func_196A(var_0, var_1);
}

func_7797(var_0, var_1) {
  func_0C4C::func_1969(var_0, var_1);
}

func_77A9(var_0) {
  func_0C4C::func_195D(var_0);
}

func_77B7(var_0) {
  func_0C4C::func_1960(var_0);
}

func_7791(var_0, var_1, var_2) {
  func_0C4C::func_194C(var_0, var_1, var_2);
}

func_7790(var_0, var_1) {
  func_0C4C::func_192F(var_0, var_1);
}

func_7792(var_0, var_1) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");

  if(!isDefined(self.var_9BDC)) {
    thread func_7798(var_0, 4.0, 0.1);
  }

  if(isDefined(var_1) && var_1) {
    thread func_7799(var_0, 0.15, 0.7);
  }

  wait 0.7;

  for(;;) {
    thread func_7797(var_0, 2.0);
    wait(randomfloatrange(3.0, 5.0));
    var_2 = var_0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread func_7797(var_2, 2.0);
    wait(randomfloatrange(0.25, 0.5));

    if(scripts\engine\utility::cointoss()) {
      var_2 = var_0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread func_7797(var_2, 2.0);
      wait(randomfloatrange(0.25, 0.5));
    }
  }
}

func_77B8(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("gesture_stop");
  var_4 = squared(var_1);
  scripts\sp\interaction_manager::func_168F();
  var_5 = distance2dsquared(self.origin, var_2.origin);

  for(;;) {
    if(var_5 < var_4 && scripts\sp\interaction_manager::func_3838(var_1 * 3.0)) {
      break;
    }
    var_5 = distance2dsquared(self.origin, var_2.origin);
    scripts\engine\utility::waitframe();
  }

  self.var_D4A4 = 1;

  if(isDefined(var_3)) {
    thread func_77B7(var_0);
    self[[var_3]]();
  } else
    func_77B7(var_0);

  wait 2.0;
  scripts\sp\interaction_manager::func_DFB5();
  self.var_D4A4 = 0;
}

func_D123() {
  var_0 = level.player _meth_8473();

  if(isDefined(var_0)) {
    return 1;
  } else {
    return 0;
  }
}

func_7B9D() {
  return level.var_D127.var_B154 / scripts\sp\gameskill::func_7A59();
}

func_A1A8(var_0) {
  if(!isDefined(level.var_A056)) {
    return 0;
  }

  if(!isDefined(level.var_A056.var_68B3)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return level.var_A056.var_68B3.running;
  } else if(!isDefined(level.var_A056.var_68B3.var_68B6[var_0])) {
    return 0;
  } else {
    return level.var_A056.var_68B3.var_68B6[var_0].running;
  }
}

func_13793() {
  while(func_A1A8()) {
    wait 0.05;
  }
}

func_13792(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  while(!isDefined(level.var_A056.var_68B3.var_68B6[var_0])) {
    wait 0.05;
  }

  while(!func_A1A8(var_0)) {
    wait 0.05;
  }

  if(var_1) {
    while(func_A1A8(var_0)) {
      wait 0.05;
    }
  }
}

func_D15B(var_0) {
  if(!isDefined(level.var_A056)) {
    return 0;
  }

  if(level.var_A056.var_D3C1 == var_0) {
    return 1;
  } else {
    return 0;
  }
}

func_B324() {
  if(isDefined(level.var_A056) && level.var_A056.var_B323) {
    return 1;
  } else {
    return 0;
  }
}

func_793C(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;

  if(var_4 > 350 || var_4 < 10) {
    var_5 = "8";
  } else if(var_4 < 60) {
    var_5 = "9";
  } else if(var_4 < 120) {
    var_5 = "6";
  } else if(var_4 < 150) {
    var_5 = "3";
  } else if(var_4 < 210) {
    var_5 = "2";
  } else if(var_4 < 240) {
    var_5 = "1";
  } else if(var_4 < 300) {
    var_5 = "4";
  } else {
    var_5 = "7";
  }

  return var_5;
}

func_1C49(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55CA)) {
      self.var_55CA = 0;
    }

    self.var_55CA--;

    if(!self.var_55CA) {
      level.player func_65DD("no_grenade_block_gesture");
    }
  } else {
    if(!isDefined(self.var_55CA)) {
      self.var_55CA = 0;
    }

    self.var_55CA++;
    level.player func_65E1("no_grenade_block_gesture");
  }
}

func_1C75(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55E8)) {
      self.var_55E8 = 0;
    }

    self.var_55E8--;

    if(!self.var_55E8) {
      scripts\engine\utility::flag_clear("weapon_scanning_off");
    }
  } else {
    if(!isDefined(self.var_55E8)) {
      self.var_55E8 = 0;
    }

    self.var_55E8++;
    scripts\engine\utility::flag_set("weapon_scanning_off");
  }
}

func_1C39(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55C0)) {
      self.var_55C0 = 0;
    }

    self.var_55C0--;

    if(!self.var_55C0) {
      level.player func_65DD("disable_antigrav_float");
    }
  } else {
    if(!isDefined(self.var_55C0)) {
      self.var_55C0 = 0;
    }

    self.var_55C0++;

    if(!level.player func_65DF("disable_antigrav_float")) {
      level.player func_65E0("disable_antigrav_float");
    }

    level.player func_65E1("disable_antigrav_float");
  }
}

func_1C3E(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55C2)) {
      self.var_55C2 = 0;
    }

    self.var_55C2--;

    if(!self.var_55C2) {
      _setsaveddvar("cg_drawCrosshair", 1);
    }
  } else {
    if(!isDefined(self.var_55C2)) {
      self.var_55C2 = 0;
    }

    self.var_55C2++;
    _setsaveddvar("cg_drawCrosshair", 0);
  }
}

func_1C72(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55E7)) {
      self.var_55E7 = 0;
    }

    self.var_55E7--;

    if(!self.var_55E7) {
      _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
    }
  } else {
    if(!isDefined(self.var_55E7)) {
      self.var_55E7 = 0;
    }

    self.var_55E7++;
    _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
  }
}

_meth_82EA(var_0) {
  func_1143E();
  self giveweapon(var_0);
  self assignweaponmeleeslot(var_0);
}

func_1143E() {
  var_0 = self _meth_8524();

  if(var_0 != "none") {
    self giveuponsuppressiontime(var_0);
  }
}

func_7AD7() {
  var_0 = self _meth_8524();

  if(var_0 != "none") {
    return var_0;
  } else {
    return undefined;
  }
}

scriptmodelplayanimdeltamotion(var_0) {
  self.var_1586 = var_0;
  self giveweapon(var_0);

  if(!isDefined(self.var_55BD) || !self.var_55BD) {
    self setactionslot(1, "weapon", var_0);
  }
}

func_11425() {
  self setactionslot(1, "");
  self giveuponsuppressiontime(self.var_1586);
  self.var_1586 = undefined;
}

func_77C9() {
  if(isDefined(self.var_1586)) {
    return self.var_1586;
  } else {
    return "";
  }
}

func_1C34(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55BD)) {
      self.var_55BD = 0;
    }

    self.var_55BD--;

    if(!self.var_55BD) {
      if(isDefined(self.var_1586)) {
        self setactionslot(1, "weapon", self.var_1586);
      }
    }
  } else {
    if(!isDefined(self.var_55BD)) {
      self.var_55BD = 0;
    }

    self.var_55BD++;
    self setactionslot(1, "");
  }
}

func_9B4D() {
  if(!isDefined(self.var_55BD)) {
    return 1;
  }

  if(!self.var_55BD) {
    return 1;
  } else {
    return 0;
  }
}

func_7D74(var_0, var_1) {
  if(isDefined(var_0) && var_0 == 1) {
    var_2 = level.player getweaponslist("primary", "altmode");
  } else {
    var_2 = level.player getweaponslist("primary");
  }

  var_3 = [];
  var_4 = level.player func_7AD7();

  if(isDefined(var_4) && (!isDefined(var_1) || var_1 == 0)) {
    foreach(var_6 in var_2) {
      if(var_6 != var_4) {
        var_3[var_3.size] = var_6;
      }
    }
  } else
    var_3 = var_2;

  return var_3;
}

func_1145A(var_0) {
  func_0B29::func_11456(var_0);
  self giveuponsuppressiontime(var_0);
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
    if(!isDefined(self.var_93B5) || self.var_93B5 == 0) {
      return 0;
    } else {
      return 1;
    }
  } else if(!isDefined(self.var_2023))
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
  if(level.player.var_4B21 == "") {
    return undefined;
  } else {
    return level.player.var_4B21;
  }
}

func_7C3E() {
  if(level.player.var_4B21 == "") {
    return 0;
  } else if(func_799D(level.player.var_4B21) == "drain") {
    return 1;
  } else {
    return level.player getammocount(level.player.var_4B21);
  }
}

func_7CAF() {
  if(level.player.var_110BD == "") {
    return undefined;
  } else {
    return level.player.var_110BD;
  }
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
  } else {
    return level.player.var_110BA;
  }
}

func_7CB2() {
  if(level.player.var_110BA != "" && func_799D(level.player.var_110BA) == "drain") {
    return 1;
  }

  return level.player.var_110BB;
}

func_799C(var_0) {
  var_1 = [::func_7BD6, ::func_7CAF, ::func_7C3D, ::func_7CB1];
  var_2 = [::func_7BD7, ::func_7CB0, ::func_7C3E, ::func_7CB2];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = [[var_1[var_3]]]();
    var_5 = [[var_2[var_3]]]();

    if(isDefined(var_4) && var_4 == var_0) {
      return var_5;
    }
  }
}

func_D0C9() {
  if(!isDefined(level.player.var_110C0) || !level.player.var_110C0) {
    return 0;
  } else {
    return 1;
  }
}

func_799D(var_0) {
  return func_0B29::func_129C(var_0);
}

func_78E4() {
  if(getdvarint("ai_corpseSynch")) {
    return self _meth_82CC();
  }

  return self.origin;
}

func_9187(var_0, var_1, var_2) {
  scripts\sp\outline::func_9188(var_0, var_1, var_2);
}

func_9189(var_0, var_1, var_2) {
  scripts\sp\outline::func_918A(var_0, var_1, var_2);
}

func_9199(var_0, var_1) {
  scripts\sp\outline::func_919A(var_0, var_1);
}

func_9196(var_0, var_1, var_2, var_3) {
  scripts\sp\outline::func_9197(var_3, var_0, var_1, var_2, 0);
}

func_9198(var_0, var_1, var_2, var_3) {
  scripts\sp\outline::func_9197(var_3, var_0, var_1, var_2, 1);
}

func_9193(var_0) {
  scripts\sp\outline::func_9194(var_0);
}

func_918D(var_0, var_1) {
  scripts\sp\outline::func_CC8D(var_0, var_1);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + var_0);
}

func_918E(var_0, var_1) {
  thread scripts\sp\outline::func_CC8E(var_0, var_1);
}

func_91A9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  _setsaveddvar("r_hudoutlineEnable", 1);
  var_1 = "0.5 0.5 0.5";
  var_2 = "1 1 1";

  if(var_0) {
    var_1 = "0.5 0.5 0.5 1";
    var_2 = "0.5 0.5 0.5 0.2";
    var_3 = "0.5 0.5 0.5 1";
    var_4 = "0.7 0.7 0.7 1";
    var_5 = "0.5 0.5 0.5 1";
  } else {
    var_1 = "0.5 0.5 0.5 0";
    var_2 = "0.5 0.5 0.5 0";
    var_3 = "0.5 0.5 0.5 1";
    var_4 = "0.5 0.5 0.5 0.5";
    var_5 = "0.5 0.5 0.5 0.5";
  }

  _setsaveddvar("r_hudoutlineFillColor0", var_1);
  _setsaveddvar("r_hudoutlineFillColor1", var_2);
  _setsaveddvar("r_hudoutlineOccludedOutlineColor", var_3);
  _setsaveddvar("r_hudoutlineOccludedInlineColor", var_4);
  _setsaveddvar("r_hudoutlineOccludedInteriorColor", var_5);
  _setsaveddvar("r_hudOutlineOccludedColorFromFill", 1);
}

func_91A8(var_0, var_1) {
  var_2["allies"] = "friendly";
  var_2["axis"] = "enemy";
  var_2["team3"] = "neutral";
  var_2["dead"] = "neutral";

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else if(isDefined(self.team)) {
    var_3 = self.team;
  } else {
    var_3 = "dead";
  }

  if(var_0 && isDefined(var_2[var_3])) {
    func_F40A(var_2[var_3], 0);
  } else {
    self hudoutlinedisable();
  }
}

func_9131(var_0) {
  setomnvar("ui_show_bink", 1);
  _setsaveddvar("bg_cinematicFullScreen", "0");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame(var_0);

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

func_918B(var_0, var_1, var_2) {
  if(isDefined(level.player.var_20F8)) {
    func_918C();
  }

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  _setsaveddvar("r_hudoutlineEnable", 1);
  level.player.var_20F8 = scripts\engine\utility::spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.var_20F8);

  if(!isDefined(var_0)) {
    var_0 = "ar_callouts_default";
  }

  setomnvar("ui_ar_object_text", var_0);
  wait 0.05;

  if(isDefined(var_1) && var_1) {
    func_9196(6, 1, 1, "default");
  } else {
    func_9196(6, 0, 1, "default");
  }

  setomnvar("ui_show_ar_elem", 1);
  thread func_1182(var_2);
}

func_1182(var_0) {
  level.player endon("stop_ar_callout");
  self endon("death");

  for(;;) {
    if(isDefined(var_0)) {
      var_1 = self.origin + var_0;
    } else {
      var_1 = self.origin + (0, 0, 30);
    }

    level.player.var_20F8.origin = var_1;
    wait 0.05;
  }
}

func_918C() {
  func_9193("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.var_20F8 delete();
  level.player.var_20F8 = undefined;
}

func_9145(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "fluff_messages_default";
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  setomnvar("ui_sp_fluff_messaging", var_0);
  setomnvar("ui_sp_fluff_messaging_context", var_1);
}

func_914C(var_0, var_1, var_2, var_3) {
  var_4 = 20;

  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  switch (var_2) {
    case "intel_acepilot0":
      var_4 = 0;
      break;
    case "intel_acepilot1":
      var_4 = 1;
      break;
    case "intel_acepilot2":
      var_4 = 2;
      break;
    case "intel_acepilot3":
      var_4 = 3;
      break;
    case "intel_acepilot4":
      var_4 = 4;
      break;
    case "intel_acepilot5":
      var_4 = 5;
      break;
    case "intel_acepilot6":
      var_4 = 6;
      break;
    case "intel_acepilot7":
      var_4 = 7;
      break;
    case "intel_acepilot8":
      var_4 = 8;
      break;
    case "intel_acepilot9":
      var_4 = 9;
      break;
    case "intel_acepilot10":
      var_4 = 10;
      break;
    case "intel_acepilot11":
      var_4 = 11;
      break;
    case "intel_acepilot12":
      var_4 = 12;
      break;
    case "intel_acepilot13":
      var_4 = 13;
      break;
    case "intel_acepilot14":
      var_4 = 14;
      break;
    case "intel_acepilot15":
      var_4 = 15;
      break;
    case "intel_acepilot16":
      var_4 = 16;
      break;
    case "intel_acepilot17":
      var_4 = 17;
      break;
    case "intel_acepilot18":
      var_4 = 18;
      break;
    case "intel_acepilot19":
      var_4 = 19;
      break;
    case "default":
      var_4 = 20;
      break;
    case "capops_intel":
      var_4 = 20;
      break;
    case "tally_intel":
      var_4 = 21;
      break;
    case "jackal_intel":
      var_4 = 22;
      break;
    case "sdf_intel_1":
      var_4 = 23;
      break;
    case "news_intel":
      var_4 = 24;
      break;
    case "eweapon_intel":
      var_4 = 25;
      break;
    case "scan_intel":
      var_4 = 26;
      break;
    case "intel_captain0":
      var_4 = 27;
      break;
    case "intel_captain1":
      var_4 = 28;
      break;
    case "intel_captain2":
      var_4 = 29;
      break;
    case "intel_captain3":
      var_4 = 30;
      break;
    case "intel_captain4":
      var_4 = 31;
      break;
    case "intel_captain5":
      var_4 = 32;
      break;
    case "intel_captain6":
      var_4 = 33;
      break;
    case "intel_captain7":
      var_4 = 34;
      break;
    case "intel_captain8":
      var_4 = 35;
      break;
    case "intel_captain9":
      var_4 = 36;
      break;
    case "intel_scrap":
      var_4 = 37;
      break;
    case "intel_reticle":
      var_4 = 38;
      break;
    case "intel_attachment":
      var_4 = 39;
      break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", var_4);
  setomnvar("ui_sp_intel_messaging_text", var_1);
  setomnvar("ui_sp_intel_messaging_header", var_0);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread func_12EE();
  var_5 = var_2 == "tally_intel";

  if(var_5) {
    level.player thread func_12ED();
  }

  if(isDefined(var_3)) {
    setomnvar("ui_sp_intel_messaging_ent", 1);
  } else {
    setomnvar("ui_sp_intel_messaging_ent", 0);
  }

  var_6 = "close";
  var_7 = gettime() / 1000;
  var_8 = 5.0;

  while(var_5 && !isDefined(level.player.var_9951) || !var_5 && gettime() / 1000 - var_7 < var_8) {
    if(isDefined(level.player.var_9963)) {
      var_6 = "waypoint";
      break;
    }

    wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.var_9951 = undefined;

  if(var_6 == "waypoint" && isDefined(var_3)) {
    var_9 = scripts\engine\utility::spawn_script_origin(var_3, (0, 0, 0));
    var_9.icon = newhudelem();
    var_9.icon setshader("intel_hint_icon", 32, 32);
    var_9.icon.color = (0, 1, 0.976);
    var_9.icon.alpha = 1.0;
    var_9.icon setwaypoint(1, 1, 0);
    var_9.icon settargetent(var_9);
    var_10 = distance2dsquared(level.player.origin, var_9.origin);

    for(;;) {
      if(distance2dsquared(level.player.origin, var_9.origin) < squared(75.0) || distance2dsquared(level.player.origin, var_9.origin) > var_10 * 2.5) {
        break;
      }
      wait 0.05;
    }

    var_9.icon destroy();
    var_9 delete();
    level.player.var_9963 = undefined;
  } else {
    level.player notify("dismiss_skipped");
    level.player.var_9951 = undefined;
    return;
  }
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
  var_0 = getEntArray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::func_B2FC);
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

    for(var_0 = 0; var_0 < 3; var_0++) {
      if(self.script_rotation_max[var_0] != 0) {
        if(self.script_rotation_speed[var_0] > 0) {
          self.var_E746[var_0] = scripts\sp\math::func_10AB0(self.script_rotation_speed[var_0] * 10, 0, self.var_10BA1[var_0] + self.script_rotation_max[var_0], 0);
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

    for(var_0 = 0; var_0 < 3; var_0++) {
      if(self.var_EEE9[var_0] != 0) {
        if(self.var_EEEA[var_0] > 0) {
          self.var_12689[var_0] = scripts\sp\math::func_10AB0(self.var_EEEA[var_0] * 10, 0, self.var_10CCA[var_0] + self.var_EEE9[var_0], 0);
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
    var_0 = [];

    for(var_1 = 0; var_1 < 3; var_1++) {
      if(self.var_EEEA[var_1] == 0) {
        var_0[var_1] = self.var_10CCA[var_1];
        continue;
      }

      if(self.var_EEEA[var_1] != 0 && self.var_EEE9[var_1] == 0) {
        var_0[var_1] = self.origin[var_1] + self.var_EEEA[var_1] / 20;
        continue;
      }

      if(self.var_EEEA[var_1] > 0 && self.var_EEE9[var_1] != 0) {
        var_0[var_1] = scripts\sp\math::func_10AB4(self.var_12689[var_1], self.var_10CCA[var_1]);
      }
    }

    self.origin = (var_0[0], var_0[1], var_0[2]);
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
    var_0 = [];

    for(var_1 = 0; var_1 < 3; var_1++) {
      if(self.script_rotation_speed[var_1] == 0) {
        var_0[var_1] = self.var_10BA1[var_1];
        continue;
      }

      if(self.script_rotation_speed[var_1] != 0 && self.script_rotation_max[var_1] == 0) {
        var_0[var_1] = self.angles[var_1] + self.script_rotation_speed[var_1] / 20;
        continue;
      }

      if(self.script_rotation_speed[var_1] > 0 && self.script_rotation_max[var_1] != 0) {
        var_0[var_1] = scripts\sp\math::func_10AB4(self.var_E746[var_1], self.var_10BA1[var_1]);
      }
    }

    self.angles = (var_0[0], var_0[1], var_0[2]);
    scripts\engine\utility::waitframe();
  }
}

func_B2FB() {
  self endon("death");

  if(isDefined(self.var_ED48)) {
    scripts\engine\utility::flag_wait(self.var_ED48);

    if(isDefined(self.var_ED54) && self.var_ED54) {
      self delete();
    } else {
      self notify("stop_manipulate_ent");
    }
  }
}

func_B2FA() {
  scripts\engine\utility::waittill_either("death", "stop_manipulate_ent");

  if(isDefined(self.var_E746)) {
    foreach(var_1 in self.var_E746) {
      scripts\sp\math::func_10AAA(var_1);
    }
  }

  if(isDefined(self.var_12689)) {
    foreach(var_1 in self.var_12689) {
      scripts\sp\math::func_10AAA(var_1);
    }
  }
}

func_9DB4(var_0) {
  if(isDefined(self.damageweapon) && self.damageweapon != "alt_none" && self.damageweapon != "none" && getweaponbasename(self.damageweapon) == var_0) {
    return 1;
  }

  return 0;
}

func_9FFE(var_0) {
  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "epic")) {
      return 1;
    }
  }

  return 0;
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

func_F398(var_0, var_1) {
  self.exception[var_0] = var_1;
}

func_F2A4(var_0) {
  var_1 = getarraykeys(self.exception);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    self.exception[var_1[var_2]] = var_0;
  }
}

waittill_multiple_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnStruct();
  var_8.threads = 0;

  if(isDefined(var_0)) {
    var_0 childthread scripts\engine\utility::waittill_string(var_1, var_8);
    var_8.threads++;
  }

  if(isDefined(var_2)) {
    var_2 childthread scripts\engine\utility::waittill_string(var_3, var_8);
    var_8.threads++;
  }

  if(isDefined(var_4)) {
    var_4 childthread scripts\engine\utility::waittill_string(var_5, var_8);
    var_8.threads++;
  }

  if(isDefined(var_6)) {
    var_6 childthread scripts\engine\utility::waittill_string(var_7, var_8);
    var_8.threads++;
  }

  while(var_8.threads) {
    var_8 waittill("returned");
    var_8.threads--;
  }

  var_8 notify("die");
}

func_7A8F() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = scripts\engine\utility::array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

func_7A9A() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = scripts\engine\utility::array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

func_7A8E() {
  var_0 = func_7A8F();
  return var_0[0];
}

func_E820(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);

  if(isDefined(level._meth_8134)) {
    var_6 = call[[level._meth_8134]](var_0);

    foreach(var_8 in var_6) {
      if(_isnonentspawner(var_8)) {
        scripts\engine\utility::array_thread([var_8], var_1, var_2, var_3, var_4);
      }
    }
  }

  var_5 = scripts\engine\utility::getstructarray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
}

func_E81F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);

  if(isDefined(level._meth_8134)) {
    var_6 = call[[level._meth_8134]]();

    foreach(var_8 in var_6) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == var_0 && _isnonentspawner(var_8)) {
        scripts\engine\utility::array_thread([var_8], var_1, var_2, var_3, var_4);
      }
    }
  }

  var_5 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
}

func_7B27(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(scripts\engine\utility::issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "script_noteworthy");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = scripts\engine\utility::getstruct(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }
}

func_9C39(var_0) {
  var_1 = level.lock[var_0];
  return var_1.count > var_1.max_count;
}

func_12BDD(var_0) {
  thread scripts\engine\utility::unlock_thread(var_0);
  wait 0.05;
}

func_7EB4(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }

  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

func_22C1(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
      }
    }
  }

  return var_0;
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

func_B979(var_0, var_1) {
  var_0 waittill("trigger", var_2);
  level.player getrawbaseweaponname(0.1, 0.1);
  level.player scripts\engine\utility::allow_ads(0);

  while(!level.player isonground()) {
    wait 0.05;
  }

  var_3 = level.player getstance();

  if(var_3 != var_1) {
    level.player setstance(var_1);

    if(var_3 == "prone") {
      wait 0.2;
    }
  }

  level.player _meth_80A6();
  level.player scripts\engine\utility::allow_ads(1);
  return var_2;
}

func_19FA(var_0, var_1, var_2, var_3, var_4) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_3) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  self.var_72BD = self.weapon;

  if(isDefined(var_4)) {
    if(self.weapon != var_4) {
      func_192C(self.weapon);
    }

    self.var_72BA = self.var_C828;
    func_72EC(var_4, "primary");
    self.var_13CAE = 1;
    return;
  }

  func_72EC(var_1, "primary");
  func_192C(var_0);
  self.var_72BB = var_0;
  self.var_72BC = var_1;
  self.var_42AE = var_2;
  self.var_72BA = self.var_72BC;
}

func_4125(var_0, var_1, var_2) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_1) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  if(isDefined(var_2)) {
    if(isDefined(self.var_13C4D) && self.var_13C4D.model == getweaponmodel(var_2)) {
      self.var_13C4D delete();
    }

    func_CC06(var_2, "right");
  } else
    func_CC06(self.var_72BD, "right");

  if(isDefined(self.var_13C4D) && var_0) {
    self.var_13C4D delete();
  }

  self.var_72BA = undefined;
  self.var_13CAE = 0;
}

func_192C(var_0) {
  self.var_13C4D = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self.var_13C4D setModel(getweaponmodel(var_0));
  self.var_13C4D notsolid();
  self.var_13C4D.angles = self gettagangles("tag_stowed_back");
  self.var_13C4D linkto(self, "tag_stowed_back");
}

func_46AD(var_0, var_1) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", var_1);
  setomnvar("ui_countdown_timer", gettime() + var_0 * 1000);
  wait(var_0);
  level notify(var_1);
  wait 5;
  setomnvar("ui_countdown_timer", 0);
}

func_46AB() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

func_F44E(var_0) {
  level.var_C086 = !var_0;
}

func_ABD9() {
  return !level.var_C086;
}

func_CE10(var_0, var_1, var_2) {
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame(var_0);
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

  thread func_3F71(var_1);

  if(isDefined(var_2)) {
    func_3F72(var_2);

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

func_3F71(var_0) {
  level endon("skippable_cinematic_done");

  if(isDefined(var_0)) {
    self waittill(var_0);
  }

  setomnvar("ui_is_bink_skippable", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "skip_bink_input") {
      level notify("cinematic_skipped");
      _stopcinematicingame();
      break;
    }
  }
}

func_3F72(var_0) {
  level endon("cinematic_skipped");
  var_0 = var_0 * 1000;

  for(;;) {
    var_1 = _cinematicgettimeinmsec();

    if(var_1 >= var_0) {
      return;
    }
    scripts\engine\utility::waitframe();
  }
}

func_93AC() {
  return level.player func_65DF("zero_gravity") && level.player func_65DB("zero_gravity");
}

func_E006(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(var_0) {
    thread func_0E26::func_DFC1();
  }

  if(var_1) {
    thread func_0E25::func_DFBE();
  }

  if(var_2) {
    thread func_0E21::func_DFBA();
  }

  if(var_3) {
    thread scripts\sp\coverwall::func_DFBD();
  }

  if(var_4) {
    thread func_0B1D::func_DFBF();
  }

  if(var_5) {
    thread func_0E2D::func_5139();
  }

  if(var_6) {
    thread func_0E2D::func_A5B9();
  }
}

func_F6FE(var_0) {
  self.var_6A8B = var_0;
}

func_41AD(var_0) {
  self.var_6A8B = "asm";

  if(!isDefined(self.var_6B14) || !self.var_6B14) {
    func_0A1E::func_2376();
  }
}

isfacialstateallowed(var_0) {
  if(!isai(self) && (!isDefined(self.var_6B14) || !self.var_6B14)) {
    return 0;
  }

  if(!isDefined(self.var_6A8B)) {
    self.var_6A8B = "asm";
  }

  var_1 = [];
  var_1["asm"] = 0;
  var_1["filler"] = 1;
  var_1["vignette"] = 2;

  if(var_1[var_0] >= var_1[self.var_6A8B]) {
    return 1;
  }

  return 0;
}

func_F708(var_0) {
  var_0 = max(var_0, 2);
  level.var_2A6F = var_0;
}

dyndof(var_0, var_1) {
  level notify("stop_dyndof");

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
  }

  level.dyndof = scripts\sp\utility_code::create_dyndof();
  level thread scripts\sp\utility_code::dyndof_thread();
}

dyndof_farsettings(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.dyndof.farstart = var_0;
  }

  if(isDefined(var_1)) {
    level.dyndof.farend = var_1;
  }

  if(isDefined(var_2)) {
    level.dyndof.farblur = var_2;
  }
}

dyndof_disable() {
  level notify("stop_dyndof");
  scripts\sp\utility_code::destroy_dyndof();
  func_0B0A::func_583D(1);
}

isactorwallrunning() {
  if(isDefined(self.var_138BC)) {
    return 1;
  }

  return 0;
}