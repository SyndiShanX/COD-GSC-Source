/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_util.gsc
*********************************************/

func_19FA(param_00, param_01, param_02, param_03) {
  var_04 = getnodesinradius(self.var_0116, param_01, param_00);
  var_05 = [];
  var_06 = self getnearestnode();
  var_07 = anglesToForward(self getangles());
  var_08 = vectornormalize(var_07 * (1, 1, 0));
  foreach(var_0A in var_04) {
    var_0B = vectornormalize(var_0A.var_0116 - self.var_0116 * (1, 1, 0));
    var_0C = vectordot(var_0B, var_08);
    if(var_0C > param_02) {
      if(!param_03 || isDefined(var_06) && function_01F4(var_0A, var_06, 1)) {
        var_05[var_05.size] = var_0A;
      }
    }
  }

  return var_05;
}

func_1A0B(param_00, param_01) {
  if(param_00 == "none") {
    return param_01 == "none";
  } else if(param_00 == "hunt") {
    return param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "guard") {
    return param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "objective") {
    return param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "critical") {
    return param_01 == "critical" || param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "tactical") {
    return 1;
  }
}

func_1AD5(param_00) {
  self botsetpersonality(param_00);
  maps\mp\bots\_bots_personality::func_1939();
  self method_8358();
}

func_1AD3(param_00, param_01) {
  if(param_00 == "default") {
    param_00 = func_1974();
  }

  var_03 = self botgetdifficulty();
  self botsetdifficulty(param_00);
  if(isPlayer(self) && var_03 != param_00) {
    maps\mp\_utility::func_8568();
    var_04 = maps\mp\gametypes\_rank::func_4653(maps\mp\gametypes\_rank::func_46EC());
    self.var_012C["rank"] = var_04;
    var_05 = self.var_012C["prestige"];
    self setrank(var_04, var_05);
  }
}

func_1974() {
  if(!isDefined(level.var_19AE)) {
    level.var_19AE = [];
    level.var_19AE[level.var_19AE.size] = "easy";
    level.var_19AE[level.var_19AE.size] = "normal";
    level.var_19AE[level.var_19AE.size] = "hard";
  }

  if(!isDefined(level.var_1A86)) {
    level.var_1A86 = [];
  }

  if(!isDefined(level.var_1A86["allies"])) {
    level.var_1A86["allies"] = 0;
  }

  if(!isDefined(level.var_1A86["axis"])) {
    level.var_1A86["axis"] = 0;
  }

  if(!isDefined(level.var_1A86["all"])) {
    level.var_1A86["all"] = 0;
  }

  if(!isDefined(self.var_012C["bot_chosen_difficulty"])) {
    var_00 = undefined;
    if(level.var_984D) {
      var_01 = self.var_01A7;
      if(!isDefined(var_01)) {
        var_01 = self.var_1AFA;
      }

      if(!isDefined(var_01)) {
        var_01 = self.var_012C["team"];
      }
    } else {
      var_01 = "all";
    }

    var_00 = level.var_1A86[var_01];
    var_02 = level.var_19AE[var_00];
    self.var_012C["bot_chosen_difficulty"] = func_4151(var_02);
    level.var_1A86[var_01] = level.var_1A86[var_01] + 1 % level.var_19AE.size;
  }

  return self.var_012C["bot_chosen_difficulty"];
}

func_4151(param_00) {
  if(param_00 == "easy") {
    return "recruit";
  }

  if(param_00 == "normal") {
    return "regular";
  }

  if(param_00 == "hard") {
    return common_scripts\utility::func_7A33(["hardened", "veteran"]);
  }
}

func_1A28() {
  if(func_1A2D()) {
    if(self.var_19AC == "capture" || self.var_19AC == "capture_zone") {
      return 1;
    }
  }

  return 0;
}

func_1A32() {
  if(func_1A2D()) {
    if(self.var_19AC == "patrol") {
      return 1;
    }
  }

  return 0;
}

func_1A33() {
  if(func_1A2D()) {
    if(self.var_19AC == "protect" || self.var_19AC == "protect_zone") {
      return 1;
    }
  }

  return 0;
}

func_1A27() {
  if(func_1A2D()) {
    if(self.var_19AC == "bodyguard") {
      return 1;
    }
  }

  return 0;
}

func_1A2D() {
  return isDefined(self.var_19A6);
}

func_1A2E(param_00) {
  if(func_1A2D()) {
    if(func_1B1C(self.var_19A7, param_00)) {
      return 1;
    }
  }

  return 0;
}

func_1A30(param_00) {
  if(func_1A27() && self.var_19A1 == param_00) {
    return 1;
  }

  return 0;
}

func_37DF(param_00, param_01, param_02) {
  var_03 = (0, 0, 11);
  var_04 = (0, 0, 40);
  var_05 = undefined;
  if(param_02 == "stand") {
    return 1;
  } else if(param_02 == "crouch") {
    var_05 = var_04;
  } else if(param_02 == "prone") {
    var_05 = var_03;
  }

  return sighttracepassed(param_01 + var_05, param_00 + var_05, 0, undefined);
}

func_4187(param_00, param_01) {
  var_02 = func_3F07(param_00, param_01);
  if(isDefined(var_02)) {
    var_02 = func_7C84(var_02);
    var_02 = func_4084(var_02);
  }

  return var_02;
}

func_3F08(param_00, param_01) {
  return getpathdist(param_00, param_01);
}

func_3F07(param_00, param_01) {
  return getnodesonpath(param_00, param_01);
}

func_3F03(param_00, param_01, param_02) {
  return botgetclosestnavigablepoint(param_00, param_01, param_02);
}

func_670D(param_00, param_01) {
  if(!isDefined(self.var_6AA8)) {
    return 0;
  }

  if(isDefined(self.var_6AA8[param_00]) && isDefined(self.var_6AA8[param_00][param_01]) && self.var_6AA8[param_00][param_01]) {
    return 1;
  }

  if(isDefined(self.var_6AA8[param_01]) && isDefined(self.var_6AA8[param_01][param_00]) && self.var_6AA8[param_01][param_00]) {
    return 1;
  }

  return 0;
}

func_4084(param_00) {
  var_01 = param_00;
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = function_0204(param_00[var_02]);
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      if(!common_scripts\utility::func_0F79(var_01, var_03[var_04])) {
        var_01 = common_scripts\utility::func_0F6F(var_01, var_03[var_04]);
      }
    }
  }

  return var_01;
}

func_43CA(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(function_01F4(var_04, param_01, 1)) {
      var_02 = common_scripts\utility::func_0F6F(var_02, var_04);
    }
  }

  return var_02;
}

func_7C84(param_00) {
  param_00[param_00.size - 1] = undefined;
  param_00[0] = undefined;
  return common_scripts\utility::func_0FA0(param_00);
}

func_1B20(param_00) {
  while(!func_194B(param_00)) {
    wait(0.5);
  }
}

func_194B(param_00) {
  if(botautoconnectenabled() != "off") {
    return 1;
  }

  if(isDefined(level.var_0AA1) && level.var_0AA1) {
    return 1;
  }

  if(func_1B3C(param_00)) {
    return 1;
  }

  return 0;
}

func_1B22(param_00) {
  var_01 = gettime();
  for(;;) {
    if(isDefined(param_00)) {
      if(gettime() > var_01 + param_00) {
        return;
      }
    }

    if(!isDefined(self.var_0088)) {
      return;
    } else if(!func_1A1C()) {
      return;
    }

    wait 0.05;
  }
}

func_1A1C(param_00) {
  if(self.var_5B21 == 0) {
    return 0;
  }

  var_01 = gettime() - self.var_5B21;
  var_02 = level.var_1A8C;
  if(isDefined(param_00)) {
    var_02 = param_00;
  }

  return var_01 < var_02;
}

func_1B21(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01) && isDefined(param_02)) {}

  if((!isDefined(param_01) || !isDefined(param_02)) && isDefined(param_03)) {}

  var_04 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];
  if(isDefined(param_01)) {
    var_04[var_04.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_04[var_04.size] = param_02;
  }

  if(isDefined(param_03)) {
    var_04[var_04.size] = param_03;
  }

  if(isDefined(param_00)) {
    var_05 = common_scripts\utility::func_A710(var_04, param_00);
  } else {
    var_05 = common_scripts\utility::func_A712(var_05);
  }

  return var_05;
}

func_1B16(param_00, param_01, param_02) {
  level endon("game_ended");
  childthread func_A1DA();
  var_03 = common_scripts\utility::func_A71A(param_00, param_01, param_02, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_03;
}

func_A1DA(param_00, param_01) {
  self endon("stop_usebutton_watcher");
  wait 0.05;
  while(self useButtonPressed()) {
    wait 0.05;
  }

  self notify("use_button_no_longer_pressed");
}

func_1B3C(param_00) {
  foreach(var_02 in level.var_6E97) {
    if(isai(var_02)) {
      if(isDefined(param_00) && param_00) {
        if(!maps\mp\_utility::func_5800(var_02)) {
          continue;
        }
      }

      return 1;
    }
  }

  return 0;
}

func_19F1(param_00, param_01, param_02) {
  if(!isDefined(level.var_37DD)) {
    return undefined;
  }

  if(isarray(param_01)) {
    if(isDefined(param_02) && param_02) {
      var_03 = undefined;
      var_04 = 999999999;
      foreach(var_06 in param_01) {
        var_07 = common_scripts\utility::func_0F7E(level.var_37DA, var_06);
        var_08 = level.var_37DB[var_07];
        var_09 = distancesquared(self.var_0116, var_08);
        if(var_09 < var_04) {
          var_03 = var_06;
          var_04 = var_09;
        }
      }

      param_01 = var_03;
    } else {
      param_01 = common_scripts\utility::func_7A33(param_01);
    }
  }

  var_0B = level.var_37DC[param_01];
  if(!isDefined(param_00) || param_00 == "stand") {
    return var_0B;
  } else if(param_00 == "crouch") {
    var_0C = [];
    foreach(var_0E in var_0B) {
      if(var_0E.var_2864[param_01]) {
        var_0C = common_scripts\utility::func_0F6F(var_0C, var_0E);
      }
    }

    return var_0C;
  } else if(var_0C == "prone") {
    var_0C = [];
    foreach(var_10 in var_0E) {
      if(var_10.var_7779[var_0B]) {
        var_0E = common_scripts\utility::func_0F6F(var_0E, var_10);
      }
    }

    return var_0E;
  }

  return undefined;
}

func_19CE(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = self.var_19A1 getvelocity();
  if(lengthsquared(var_04) > 100) {
    var_05 = getnodesinradius(param_00, param_01 * 1.75, param_01 * 0.5, 500);
    var_06 = [];
    var_07 = vectornormalize(var_04);
    for(var_08 = 0; var_08 < var_05.size; var_08++) {
      var_09 = vectornormalize(var_05[var_08].var_0116 - self.var_19A1.var_0116);
      if(vectordot(var_09, var_07) > 0.1) {
        var_06[var_06.size] = var_05[var_08];
      }
    }
  } else {
    var_06 = getnodesinradius(param_01, param_02, 0, 500);
  }

  if(isDefined(param_02) && param_02) {
    var_0A = vectornormalize(self.var_19A1.var_0116 - self.var_0116);
    var_0B = var_06;
    var_06 = [];
    foreach(var_0D in var_0B) {
      var_09 = vectornormalize(var_0D.var_0116 - self.var_19A1.var_0116);
      if(vectordot(var_0A, var_09) > 0.2) {
        var_06[var_06.size] = var_0D;
      }
    }
  }

  var_0F = [];
  var_10 = [];
  var_11 = [];
  for(var_08 = 0; var_08 < var_06.size; var_08++) {
    var_12 = distancesquared(var_06[var_08].var_0116, param_00) > 10000;
    var_13 = abs(var_06[var_08].var_0116[2] - self.var_19A1.var_0116[2]) < 50;
    if(var_12) {
      var_0F[var_0F.size] = var_06[var_08];
    }

    if(var_13) {
      var_10[var_10.size] = var_06[var_08];
    }

    if(var_12 && var_13) {
      var_11[var_11.size] = var_06[var_08];
    }

    if(var_08 % 100 == 99) {
      wait 0.05;
    }
  }

  if(var_11.size > 0) {
    var_03 = self method_8366(var_11, var_11.size * 0.15, "node_capture", param_00, undefined, self.var_2C89);
  }

  if(!isDefined(var_03)) {
    wait 0.05;
    if(var_10.size > 0) {
      var_03 = self method_8366(var_10, var_10.size * 0.15, "node_capture", param_00, undefined, self.var_2C89);
    }

    if(!isDefined(var_03) && var_0F.size > 0) {
      wait 0.05;
      var_03 = self method_8366(var_0F, var_0F.size * 0.15, "node_capture", param_00, undefined, self.var_2C89);
    }
  }

  return var_03;
}

func_19CC(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = getnodesinradius(param_00, param_01, 0, 500);
  if(var_04.size > 0) {
    var_03 = self method_8366(var_04, var_04.size * 0.15, "node_capture", param_00, param_02, self.var_2C89);
  }

  return var_03;
}

func_19CD(param_00, param_01) {
  var_02 = undefined;
  if(param_00.size > 0) {
    var_02 = self method_8366(param_00, param_00.size * 0.15, "node_capture", undefined, param_01, self.var_2C89);
  }

  return var_02;
}

func_19CF(param_00, param_01) {
  var_02 = undefined;
  if(param_00.size > 0) {
    var_02 = self method_8366(param_00, param_00.size * 0.25, "node_capture", param_01, undefined, self.var_2C89);
  }

  return var_02;
}

func_19CB(param_00, param_01) {
  var_02 = undefined;
  var_03 = getnodesinradius(param_00, param_01, 0, 500);
  if(var_03.size > 0) {
    var_02 = self method_8366(var_03, var_03.size * 0.15, "node_protect", param_00, self.var_2C89);
  }

  return var_02;
}

func_1A99(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  var_06 = getnodesinradius(param_00, param_01, 0, 500);
  if(isDefined(var_06) && var_06.size >= 2) {
    var_05 = func_19D0(var_06, param_02);
  }

  if(!isDefined(var_05)) {
    if(!isDefined(param_03)) {
      param_03 = 0;
    }

    if(!isDefined(param_04)) {
      param_04 = 1;
    }

    var_07 = randomfloatrange(self.var_19AA * param_03, self.var_19AA * param_04);
    var_08 = anglesToForward((0, randomint(360), 0));
    var_05 = param_00 + var_08 * var_07;
  }

  return var_05;
}

func_1A98(param_00, param_01, param_02) {
  var_03 = undefined;
  if(param_01.size >= 2) {
    var_03 = func_19D0(param_01, param_02);
  }

  if(!isDefined(var_03)) {
    var_04 = common_scripts\utility::func_7A33(param_01);
    var_05 = var_04.var_0116 - param_00;
    var_03 = param_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1);
  }

  return var_03;
}

func_19D0(param_00, param_01) {
  var_02 = undefined;
  var_03 = common_scripts\utility::func_0F92(param_00);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    for(var_05 = var_04 + 1; var_05 < var_03.size; var_05++) {
      var_06 = var_03[var_04];
      var_07 = var_03[var_05];
      if(function_01F4(var_06, var_07, 1)) {
        var_02 = (var_06.var_0116[0] + var_07.var_0116[0] * 0.5, var_06.var_0116[1] + var_07.var_0116[1] * 0.5, var_06.var_0116[2] + var_07.var_0116[2] * 0.5);
        if(isDefined(param_01) && self[[param_01]](var_02) == 1) {
          return var_02;
        }
      }
    }
  }

  return var_02;
}

func_2C6C() {
  if(isDefined(self.var_19A9)) {
    return self.var_19A9.var_0116;
  } else if(isDefined(self.var_19A7)) {
    return self.var_19A7;
  }

  return undefined;
}

func_1937() {
  if(!maps\mp\_utility::func_0F5C()) {
    return 0;
  }

  if(maps\mp\_utility::func_573D()) {
    return 0;
  }

  if(func_1A36()) {
    return 0;
  }

  if(self isusingturret()) {
    return 0;
  }

  if(isDefined(level.var_685D) || isDefined(level.nukecoolingdown)) {
    return 0;
  }

  if(isDefined(level.nobotscorestreaks)) {
    return 0;
  }

  if(isDefined(self.var_A019) && self.var_A019) {
    return 0;
  }

  if(isDefined(self.var_260C) && self.var_260C) {
    return 0;
  }

  if(!self method_85EB()) {
    return 0;
  }

  if(self method_846C()) {
    return 0;
  }

  if(maps\mp\_utility::func_44FC() > 0) {
    var_00 = 1;
    foreach(var_02 in level.var_6E97) {
      if(isalive(var_02) && !isalliedsentient(self, var_02)) {
        var_00 = 0;
      }
    }

    if(var_00) {
      return 0;
    }
  }

  if(common_scripts\utility::func_562E(self.var_1B2F)) {
    return 0;
  }

  if(!func_1A1C(500)) {
    return 1;
  }

  if(!isalive(self.var_0088)) {
    return 1;
  }

  return 0;
}

func_1AB2() {
  var_00 = undefined;
  var_01 = botmemoryflags("investigated", "killer_died");
  var_02 = botmemoryflags("investigated");
  var_03 = common_scripts\utility::func_7A33(botgetmemoryevents(0, gettime() - 10000, 1, "death", var_01, self));
  if(isDefined(var_03)) {
    var_00 = var_03;
    self.var_1A7C = 10000;
  } else {
    var_04 = undefined;
    if(self method_835F() != "none") {
      var_04 = self method_835C();
    }

    var_05 = botgetmemoryevents(0, gettime() - -20536, 1, "kill", var_02, self);
    var_06 = botgetmemoryevents(0, gettime() - -20536, 1, "death", var_01, self);
    var_03 = common_scripts\utility::func_7A33(common_scripts\utility::func_0F73(var_05, var_06));
    if(isDefined(var_03) > 0 && !isDefined(var_04) || distancesquared(var_04, var_03) > 1000000) {
      var_00 = var_03;
      self.var_1A7C = -20536;
    }
  }

  if(isDefined(var_00)) {
    var_07 = getzonenearest(var_00);
    var_08 = getzonenearest(self.var_0116);
    if(isDefined(var_07) && isDefined(var_08) && var_08 != var_07) {
      var_09 = botzonegetcount(var_07, self.var_01A7, "ally") + botzonegetcount(var_07, self.var_01A7, "path_ally");
      if(var_09 > 1) {
        var_00 = undefined;
      }
    }
  }

  if(isDefined(var_00)) {
    self.var_1A7B = var_00;
  }

  return var_00;
}

func_193A() {
  if(self method_8367()) {
    var_00 = self method_835C();
    if(distancesquared(self.var_0116, var_00) < 256) {
      return 1;
    }
  }

  return 0;
}

func_19B9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {}

func_19BA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {}

func_19B8(param_00, param_01, param_02, param_03, param_04) {}

func_1A07() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();
  foreach(var_03 in var_01) {
    var_00 = var_00 + self getweaponammoclip(var_03);
    var_00 = var_00 + self getweaponammostock(var_03);
  }

  return var_00;
}

func_1A8B() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(self getweaponammoclip(var_02) > 0) {
      return 0;
    }

    if(self getweaponammostock(var_02) > 0) {
      return 0;
    }
  }

  return 1;
}

func_19F2() {
  var_00 = 0;
  var_01 = self getweaponslistoffhands();
  foreach(var_03 in var_01) {
    var_00 = var_00 + self getweaponammostock(var_03);
  }

  return var_00;
}

func_1A3A(param_00, param_01) {
  switch (param_00) {
    case "trap_directional":
      switch (param_01) {
        case "claymore_mp":
          return 1;
      }
      break;

    case "trap":
      switch (param_01) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }
      break;

    case "trap_follower":
      switch (param_01) {
        case "tracking_drone_mp":
          return 1;
      }
      break;

    case "c4":
      switch (param_01) {
        case "c4_mp":
          return 1;
      }
      break;

    case "tacticalinsertion":
      switch (param_01) {
        case "s2_tactical_insertion_device_mp":
          return 1;
      }
      break;
  }

  return 0;
}

func_1B2A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("disconnect");
  self endon("death");
  if(isDefined(param_04)) {
    self endon(param_04);
  }

  if(isDefined(param_05)) {
    self endon(param_05);
  }

  if(isDefined(param_06)) {
    self endon(param_06);
  }

  if(isDefined(param_07)) {
    self endon(param_07);
  }

  wait(0.5);
  var_08 = 1;
  if(self isusingturret()) {
    var_08 = 0;
  }

  var_09 = squared(self method_835D());
  while(var_08) {
    if(self method_8367() && self method_8377()) {
      if(distancesquared(self method_835C(), self.var_0116) < var_09) {
        if(length(self getvelocity()) <= 1) {
          var_08 = 0;
        }
      }
    }

    if(var_08) {
      wait 0.05;
    }
  }

  var_0A = self.var_0116;
  var_0B = (0, 0, self getviewheight());
  if(isDefined(param_00)) {
    self.var_A8C9 = [];
    foreach(var_0D in param_00) {
      var_0E = 0;
      if(distance2dsquared(self.var_0116, var_0D.var_0116) <= 40) {
        var_0E = 1;
      }

      var_0F = self getEye();
      var_10 = vectordot((0, 0, 1), vectornormalize(var_0D.var_0116 + var_0B - var_0F));
      if(abs(var_10) > 0.92) {
        var_0E = 1;
      }

      if(!var_0E) {
        self.var_A8C9[self.var_A8C9.size] = var_0D;
      }
    }
  }

  if(!isDefined(self.var_A8C9)) {
    return;
  }

  thread func_A8CA();
  self.var_A8C9 = common_scripts\utility::func_0F92(self.var_A8C9);
  foreach(var_0D in self.var_A8C9) {
    var_0D.var_A8C7[self.var_37CD] = 1;
    var_0D.var_A8C6[self.var_37CD] = 1;
  }

  var_14 = [];
  for(var_15 = 0; var_15 < self.var_A8C9.size; var_15++) {
    var_14[var_15] = [];
    var_16 = vectornormalize(self.var_A8C9[var_15].var_0116 - self.var_0116);
    for(var_17 = 0; var_17 < self.var_A8C9.size; var_17++) {
      if(var_15 == var_17) {
        continue;
      }

      var_18 = vectornormalize(self.var_A8C9[var_17].var_0116 - self.var_0116);
      var_19 = vectordot(var_16, var_18);
      if(var_19 > 0.94) {
        var_14[var_15] = common_scripts\utility::func_0F6F(var_14[var_15], var_17);
      }
    }
  }

  for(;;) {
    var_1A = -1;
    var_1B = 0;
    for(var_15 = 0; var_15 < self.var_A8C9.size; var_15++) {
      if(var_14[var_15].size > var_1B) {
        var_1A = var_15;
        var_1B = var_14[var_15].size;
      }
    }

    if(var_1A == -1) {
      break;
    }

    self.var_A8C9[var_1A].var_A8C7[self.var_37CD] = 0.5;
    self.var_A8C9[var_1A].var_A8C6[self.var_37CD] = 0.5;
    var_14[var_1A] = [];
    for(var_15 = 0; var_15 < var_14.size; var_15++) {
      if(common_scripts\utility::func_0F79(var_14[var_15], var_1A)) {
        var_14[var_15] = common_scripts\utility::func_0F93(var_14[var_15], var_1A);
      }
    }
  }

  var_1C = gettime();
  var_1D = var_1C;
  var_1E = [];
  var_1F = undefined;
  if(isDefined(param_01)) {
    var_1F = (0, param_01, 0);
  }

  var_20 = isDefined(var_1F) && isDefined(param_02);
  var_21 = undefined;
  var_22 = undefined;
  wait(0.1);
  for(;;) {
    var_23 = gettime();
    self notify("still_watching_nodes");
    var_24 = self method_8375();
    if(isDefined(param_03) && var_23 >= param_03) {
      return;
    }

    if(maps\mp\bots\_bots_strategy::func_1A14()) {
      self botlookatpoint(undefined);
      wait(0.2);
      continue;
    }

    if(!self method_8367() || !self method_8377()) {
      wait(0.2);
      continue;
    }

    if(isDefined(var_22) && var_22.var_A8C7[self.var_37CD] == 0) {
      var_1D = var_23;
    }

    if(self.var_A8C9.size > 0) {
      var_25 = 0;
      if(isDefined(self.var_0088)) {
        var_26 = self lastknownpos(self.var_0088);
        var_27 = self lastknowntime(self.var_0088);
        if(var_27 && var_23 - var_27 < 5000) {
          var_28 = vectornormalize(var_26 - self.var_0116);
          var_29 = 0;
          for(var_15 = 0; var_15 < self.var_A8C9.size; var_15++) {
            var_2A = vectornormalize(self.var_A8C9[var_15].var_0116 - self.var_0116);
            var_19 = vectordot(var_28, var_2A);
            if(var_19 > var_29) {
              var_29 = var_19;
              var_22 = self.var_A8C9[var_15];
              var_25 = 1;
            }
          }
        }
      }

      if(!var_25 && var_23 >= var_1D) {
        var_2B = [];
        for(var_15 = 0; var_15 < self.var_A8C9.size; var_15++) {
          var_0D = self.var_A8C9[var_15];
          var_2C = var_0D getnodenumber();
          if(var_20 && !common_scripts\utility::func_AA4A(self.var_0116, var_1F, var_0D.var_0116, param_02)) {
            continue;
          }

          if(distance2dsquared(self.var_0116, var_0D.var_0116) <= 10) {
            continue;
          }

          if(!isDefined(var_1E[var_2C])) {
            var_1E[var_2C] = 0;
          }

          if(common_scripts\utility::func_AA4A(self.var_0116, self getangles(), var_0D.var_0116, var_24)) {
            var_1E[var_2C] = var_23;
          }

          for(var_2D = 0; var_2D < var_2B.size; var_2D++) {
            if(var_1E[var_2B[var_2D] getnodenumber()] > var_1E[var_2C]) {
              break;
            }
          }

          var_2B = common_scripts\utility::func_0F86(var_2B, var_0D, var_2D);
        }

        var_21 = var_22;
        var_22 = undefined;
        if(var_2B.size == 1) {
          var_22 = var_2B[0];
        } else if(var_2B.size > 1) {
          var_2E = [];
          var_2F = 0;
          for(var_15 = 0; var_15 < var_2B.size; var_15++) {
            var_30 = 1 - var_15 / var_2B.size - 1 * 0.5;
            var_31 = [var_2B[var_15], var_2B[var_15].var_A8C7[self.var_37CD] * var_30];
            var_2E[var_2E.size] = var_31;
            var_2F = var_2F + var_31[1];
          }

          var_32 = randomfloat(var_2F);
          for(var_15 = 0; var_15 < var_2E.size; var_15++) {
            if(var_32 < var_2E[var_15][1]) {
              var_22 = var_2E[var_15][0];
              break;
            }

            var_32 = var_32 - var_2E[var_15][1];
          }
        }

        if(isDefined(var_22)) {
          var_1D = var_23 + randomintrange(3000, 5000);
          var_33 = !isDefined(var_21) || var_21 != var_22;
          if(var_33 && common_scripts\utility::func_562E(self.var_1957)) {
            childthread func_1A10(var_22);
          }
        }
      }

      if(isDefined(var_25)) {
        var_34 = var_25.var_0116 + var_13;
        if(distance2dsquared(self.var_0116, var_34) <= 10) {
          self botlookatpoint(undefined);
          var_25 = undefined;
          var_20 = 0;
        } else {
          self botlookatpoint(var_34, 0.4, "script_search");
        }
      }
    }

    wait(0.2);
  }
}

func_1A10(param_00) {
  if(isDefined(self.var_28C8)) {
    var_01 = self.var_28C8;
    if(var_01 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait(1);
    }

    if(var_01 == "prone") {
      if(func_A8CD(self getnearestnode(), param_00)) {
        self botsetstance("prone");
      } else {
        var_01 = "crouch";
      }
    }

    if(var_01 == "crouch") {
      if(func_A8CC(self getnearestnode(), param_00)) {
        self botsetstance("crouch");
      } else {
        var_01 = "stand";
      }
    }

    if(var_01 == "stand") {
      self botsetstance("stand");
    }
  }
}

func_A8CD(param_00, param_01) {
  var_02 = param_01 getnodenumber();
  if(!isDefined(param_00.var_777C) || !isDefined(param_00.var_777C[var_02])) {
    var_03 = sighttracepassed(param_00.var_0116 + (0, 0, 11), param_01.var_0116 + (0, 0, 11), 0, undefined);
    param_00.var_777C[var_02] = var_03;
  }

  return param_00.var_777C[var_02];
}

func_A8CC(param_00, param_01) {
  var_02 = param_01 getnodenumber();
  if(!isDefined(param_00.var_777C) || !isDefined(param_00.var_777C[var_02])) {
    var_03 = sighttracepassed(param_00.var_0116 + (0, 0, 40), param_01.var_0116 + (0, 0, 11), 0, undefined);
    param_00.var_777C[var_02] = var_03;
  }

  return param_00.var_777C[var_02];
}

func_A8CB() {
  self notify("bot_watch_nodes_stop");
  if(isDefined(self.var_A8C9)) {
    foreach(var_01 in self.var_A8C9) {
      func_A8C8(var_01);
    }
  }

  self.var_A8C9 = undefined;
}

func_A8C8(param_00) {
  param_00.var_A8C7[self.var_37CD] = undefined;
  param_00.var_A8C6[self.var_37CD] = undefined;
}

func_A8CA() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  for(;;) {
    var_00 = common_scripts\utility::func_A71A(0.5, "still_watching_nodes");
    if(!isDefined(var_00) || var_00 != "still_watching_nodes") {
      func_A8CB();
      return;
    }
  }
}

func_1A59(param_00, param_01) {
  if(isDefined(param_01) && param_01 != (0, 0, 0)) {
    if(!common_scripts\utility::func_AA4A(self.var_0116, self getangles(), param_01, self method_8375())) {
      var_02 = self botpredictseepoint(param_01);
      if(isDefined(var_02)) {
        self botlookatpoint(var_02 + (0, 0, 40), 1, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, param_01);
  }
}

func_19F7(param_00, param_01) {
  if(isDefined(param_01) && isDefined(param_01.var_003A)) {
    if(param_01.var_003A == "grenade") {
      if(isDefined(param_00) && param_00.var_003A == "worldspawn") {
        return undefined;
      }

      if(!func_19C0(param_01)) {
        return param_00;
      }
    } else if(param_01.var_003A == "rocket") {
      if(isDefined(param_01.var_A319)) {
        return param_01.var_A319;
      }

      if(isDefined(param_01.var_01B9) && param_01.var_01B9 == "remote" || param_01.var_01B9 == "odin") {
        return param_01;
      }

      if(maps\mp\_utility::func_579B()) {
        if(isDefined(param_01.var_0117) && param_01.var_0117.var_003A == "worldspawn") {
          return undefined;
        }
      }

      if(isDefined(param_01.var_0117)) {
        return param_01.var_0117;
      }
    } else if(param_01.var_003A == "worldspawn" || param_01.var_003A == "trigger_hurt") {
      return undefined;
    }

    return param_01;
  }

  return param_00;
}

func_19C0(param_00) {
  var_01 = param_00.var_A9AB;
  if(!isDefined(var_01)) {
    var_01 = param_00.var_A9E0;
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  if(issubstr(var_01, "c4_mp")) {
    return 1;
  }

  if(issubstr(var_01, "claymore_mp")) {
    return 1;
  }

  if(issubstr(var_01, "proximity_explosive_mp")) {
    return 1;
  }

  return 0;
}

func_1B1C(param_00, param_01) {
  return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

func_1931(param_00) {
  param_00.var_4D3C = [];
  if(param_00.var_1A23 == "use") {
    func_1932(param_00);
    return;
  }

  if(param_00.var_1A23 == "damage") {
    func_1930(param_00);
    return;
  }
}

func_1AB4(param_00) {
  param_00.var_0CA3 = 1;
  level.var_5CB7 = common_scripts\utility::func_0F93(level.var_5CB7, param_00);
}

func_1932(param_00) {
  if(!issubstr(param_00.var_003B, "trigger_use")) {
    return;
  }

  if(!isDefined(param_00.var_01A2)) {
    return;
  }

  if(isDefined(param_00.var_1AF7)) {
    return;
  }

  if(!isDefined(param_00.var_A1F5)) {
    return;
  }

  var_01 = getnodearray(param_00.var_01A2, "targetname");
  if(var_01.size != 1) {
    return;
  }

  param_00.var_1AF7 = var_01[0];
  if(!isDefined(level.var_5CB7)) {
    level.var_5CB7 = [];
  }

  level.var_5CB7 = common_scripts\utility::func_0F6F(level.var_5CB7, param_00);
}

func_1930(param_00) {
  if(!issubstr(param_00.var_003B, "trigger_damage")) {
    return;
  }

  var_01 = getnodearray(param_00.var_01A2, "targetname");
  if(var_01.size != 2) {
    return;
  }

  param_00.var_1AF9 = var_01;
  if(!isDefined(level.var_5CB7)) {
    level.var_5CB7 = [];
  }

  level.var_5CB7 = common_scripts\utility::func_0F6F(level.var_5CB7, param_00);
}

func_1A01(param_00, param_01) {
  var_02 = 0;
  foreach(var_05, var_04 in param_00) {
    if(var_02 == param_01) {
      return var_05;
    }

    var_02++;
  }

  return undefined;
}

func_1A09(param_00, param_01) {
  for(var_02 = 0; var_02 < level.var_AC9C; var_02++) {
    var_03 = getzonenodeforindex(var_02);
    var_03.var_A571 = 0;
  }

  var_04 = getzonenodeforindex(param_00);
  return func_1A0A(var_04, param_01);
}

func_1A0A(param_00, param_01) {
  var_02 = [];
  var_02[0] = getnodezone(param_00);
  param_00.var_A571 = 1;
  var_03 = function_0204(param_00);
  foreach(var_05 in var_03) {
    if(!var_05.var_A571) {
      var_06 = distance(param_00.var_0116, var_05.var_0116);
      if(var_06 < param_01) {
        var_07 = func_1A0A(var_05, param_01 - var_06);
        var_02 = common_scripts\utility::func_0F73(var_07, var_02);
      }
    }
  }

  return var_02;
}

func_1981(param_00) {
  return isDefined(param_00) && isDefined(param_00.var_253C) && param_00.var_253C;
}

func_19F9(param_00) {
  return level.var_1A79[param_00];
}

func_1A02() {
  return int(func_19EE() / 2);
}

func_19EE() {
  var_00 = function_0364();
  var_00 = max(var_00, getdvarint("5321", 0));
  if(var_00 > level.var_6079) {
    return level.var_6079;
  }

  return var_00;
}

func_1AA9() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;
  for(;;) {
    if(isDefined(level.var_1AAB) && level.var_1AAB.size > 0) {
      var_00 = level.var_1AAB[0];
      if(isDefined(var_00) && isDefined(var_00.var_0117)) {
        var_01 = undefined;
        if(isDefined(var_00.var_6E85)) {
          var_01 = var_00.var_0117[[var_00.var_3F02]](var_00.var_6E82, var_00.var_6E83, var_00.var_6E84, var_00.var_6E85);
        } else if(isDefined(var_00.var_6E84)) {
          var_01 = var_00.var_0117[[var_00.var_3F02]](var_00.var_6E82, var_00.var_6E83, var_00.var_6E84);
        } else if(isDefined(var_00.var_6E83)) {
          var_01 = var_00.var_0117[[var_00.var_3F02]](var_00.var_6E82, var_00.var_6E83);
        } else if(isDefined(var_00.var_6E82)) {
          var_01 = var_00.var_0117[[var_00.var_3F02]](var_00.var_6E82);
        } else {
          var_01 = var_00.var_0117[[var_00.var_3F02]]();
        }

        var_00.var_0117 notify(var_00.var_6602, var_01);
      }

      var_02 = [];
      for(var_03 = 1; var_03 < level.var_1AAB.size; var_03++) {
        var_02[var_03 - 1] = level.var_1AAB[var_03];
      }

      level.var_1AAB = var_02;
    }

    wait 0.05;
  }
}

func_1AA8(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_1AAB)) {
    level.var_1AAB = [];
  }

  foreach(var_08, var_07 in level.var_1AAB) {
    if(var_07.var_0117 == self && var_07.var_0109 == param_00) {
      self notify(var_07.var_0109);
      level.var_1AAB[var_08] = undefined;
    }
  }

  var_07 = spawnStruct();
  var_07.var_0117 = self;
  var_07.var_0109 = param_00;
  var_07.var_6602 = var_07.var_0109 + "_done";
  var_07.var_3F02 = param_01;
  var_07.var_6E82 = param_02;
  var_07.var_6E83 = param_03;
  var_07.var_6E84 = param_04;
  var_07.var_6E85 = param_05;
  level.var_1AAB[level.var_1AAB.size] = var_07;
  if(!isDefined(level.var_1AAA)) {
    level.var_1AAA = 1;
    level thread func_1AA9();
  }

  self waittill(var_07.var_6602, var_09);
  return var_09;
}

func_1A36() {
  return maps\mp\_utility::func_581D() || self islinked();
}

func_19F8(param_00) {
  var_01 = self getweaponslistprimaries();
  foreach(var_03 in var_01) {
    var_04 = weaponclipsize(var_03);
    var_05 = self getweaponammostock(var_03);
    if(var_05 <= var_04) {
      return 1;
    }

    if(self getfractionmaxammo(var_03) <= param_00) {
      return 1;
    }
  }

  return 0;
}

func_1A9D(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 256;
  }

  if(!isDefined(param_02)) {
    param_02 = 50;
  }

  var_03 = getnodesinradiussorted(param_00, param_01, 0, param_02, "Path");
  foreach(var_05 in var_03) {
    var_06 = param_00 + (0, 0, 30);
    var_07 = var_05.var_0116 + (0, 0, 30);
    var_08 = physicstrace(var_06, var_07);
    if(func_1B1C(var_08, var_07)) {
      return 1;
    }

    wait 0.05;
  }

  return 0;
}

func_1A80(param_00) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.var_3716 = [];
  level.var_3715 = [];
  level.var_3714 = [];
  for(;;) {
    wait(1);
    var_01 = [];
    if(!isDefined(param_00)) {
      continue;
    }

    foreach(var_03 in level.var_6E97) {
      if(!isDefined(var_03.var_01A7)) {
        continue;
      }

      if(var_03[[param_00]]() && !isDefined(var_01[var_03.var_01A7])) {
        level.var_3714[var_03.var_01A7] = undefined;
        level.var_3716[var_03.var_01A7] = var_03 method_843B(1);
        if(isDefined(level.var_3716[var_03.var_01A7])) {
          if(!isDefined(level.var_3715[var_03.var_01A7]) || !common_scripts\utility::func_0F79(level.var_3716[var_03.var_01A7], level.var_3715[var_03.var_01A7])) {
            level.var_3715[var_03.var_01A7] = common_scripts\utility::func_7A33(level.var_3716[var_03.var_01A7]);
          }

          if(isDefined(level.var_3715[var_03.var_01A7])) {
            var_04 = [];
            foreach(var_06 in level.var_6E97) {
              if(!isDefined(var_06.var_01A7)) {
                continue;
              }

              if(var_06[[param_00]]() && var_06.var_01A7 == var_03.var_01A7) {
                var_04[var_04.size] = var_06;
              }
            }

            var_04 = function_01AC(var_04, level.var_3715[var_03.var_01A7]);
            if(var_04.size > 0) {
              level.var_3714[var_03.var_01A7] = var_04[0];
            }
          }
        }

        var_01[var_03.var_01A7] = 1;
      }
    }
  }
}

func_1B17() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.var_01A7)) {
    return 0;
  }

  if(self.var_01A7 == "spectator") {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(!maps\mp\_utility::func_566A(self)) {
    return 0;
  }

  if(!isDefined(self.var_6F7D) || self.var_6F7D == "camper") {
    return 0;
  }

  return 1;
}

func_1B13() {
  if(!isDefined(level.var_3714)) {
    return;
  }

  if(!isDefined(level.var_3714[self.var_01A7])) {
    return;
  }

  if(level.var_3714[self.var_01A7] == self) {
    maps\mp\bots\_bots_strategy::func_19A3();
    self botsetscriptgoal(level.var_3715[self.var_01A7], 128, "objective", undefined, 256);
    func_1B21();
  }
}

func_19D4(param_00, param_01) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance(param_00);
  wait(param_01);
  self botsetstance("none");
}

func_19AF(param_00) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait(param_00);
  self botsetflag("disable_movement", 0);
}