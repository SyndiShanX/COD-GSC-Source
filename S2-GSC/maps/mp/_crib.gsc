/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_crib.gsc
*********************************************/

func_00D5() {
  precacheshellshock("frag_grenade_mp");
  func_78AB();
  func_78AF();
  func_A4AB();
  func_72B0();
}

func_78AB() {
  func_669D("main", "player_view1_start", "player_view1_end");
  var_00 = func_669C("main", "Primary Weapon", "radial_weapons_primary", ::func_0880);
  var_01 = func_669C("main", "Secondary Weapon", "radial_weapons_secondary", ::func_0881);
  var_02 = func_669C("main", "Gears", "radial_gears", ::func_0876);
  var_03 = func_669C("main", "Kill Streaks", "radial_killstreaks", ::func_0877);
  var_04 = func_669C("main", "Leaderboards", "radial_leaderboards", ::func_0878);
  func_669D("gears", "player_view2_start", "player_view2_end");
  func_669D("weapons_primary", "player_view3_start", "player_view3_end");
  func_669D("weapons_secondary", "player_view3_start", "player_view3_end");
  func_669D("killstreak", "player_view4_start", "player_view4_end");
  func_669D("leaderboards", "player_view5_start", "player_view5_end");
}

func_78AF() {
  foreach(var_01 in level.var_78AC) {
    func_8F1B(var_01);
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      if(isDefined(var_01[var_02 + 1])) {
        var_03 = func_4586(var_01[var_02].var_7585, var_01[var_02 + 1].var_7585);
        var_01[var_02].var_366E = var_03;
        var_01[var_02 + 1].var_9188 = var_03;
        continue;
      }

      var_03 = func_4586(var_01[var_02].var_7585, var_01[0].var_7585) + 180;
      if(var_03 > 360) {
        var_03 = var_03 - 360;
      }

      var_01[var_02].var_366E = var_03;
      var_01[0].var_9188 = var_03;
    }
  }

  thread func_A162();
  thread func_A940();
  thread func_A8EE();
  thread func_2B49();
}

func_2B49() {
  level endon("game_ended");
  level.var_2856 = 1;
  for(;;) {
    if(!isDefined(level.var_6999)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.var_6999 buttonpresseddevonly("BUTTON_Y")) {
      wait 0.05;
    }

    level.var_6999 method_8617("mouse_click");
    if(var_00) {
      level.var_2856 = level.var_2856 * -1;
      var_00 = 0;
    }

    while(level.var_6999 buttonpresseddevonly("BUTTON_Y")) {
      wait 0.05;
    }
  }
}

func_72B0() {
  level thread func_6B6C();
  level thread func_7E29();
}

func_7E29() {
  level waittill("game_ended");
  setDvar("2562", 1);
}

func_6B6C() {
  level waittill("connected", var_00);
  var_00 thread func_7ABE();
  var_00 waittill("spawned_player");
  wait(1);
  var_00 takeallweapons();
  setDvar("2562", 0);
  if(!isDefined(var_00)) {
    return;
  } else {
    level.var_6999 = var_00;
  }

  var_00 thread func_4304();
  func_ACC8("main");
}

func_7ABE() {
  self endon("disconnect");
  var_00 = "autoassign";
  while(!isDefined(self.var_012C["team"])) {
    wait 0.05;
  }

  self notify("menuresponse", game["menu_team"], var_00);
  wait(0.5);
  var_01 = getarraykeys(level.var_2321);
  var_02 = [];
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(!issubstr(var_01[var_03], "custom")) {
      var_02[var_02.size] = var_01[var_03];
    }
  }

  for(;;) {
    var_04 = var_02[0];
    self notify("menuresponse", "changeclass", var_04);
    self waittill("spawned_player");
    wait(0.1);
  }
}

func_4304() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    var_00 = self getnormalizedmovement();
    var_01 = vectortoangles(var_00);
    level.var_7F3D = int(var_01[1]);
    wait 0.05;
  }
}

func_669D(param_00, param_01, param_02) {
  if(isDefined(level.var_78AC) && level.var_78AC.size) {}

  var_03 = getent(param_02, "targetname");
  var_04 = vectornormalize(anglesToForward(var_03.var_001D)) * 40;
  level.var_78AC[param_00] = [];
  level.var_78AD[param_00]["view_start"] = param_01;
  level.var_78AD[param_00]["view_pos"] = var_03.var_0116 + var_04;
  level.var_78AD[param_00]["player_view_pos"] = var_03.var_0116;
  level.var_78AD[param_00]["view_angles"] = var_03.var_001D;
}

func_669C(param_00, param_01, param_02, param_03) {
  var_04 = getent(param_02, "targetname");
  var_05 = func_463D(param_00, var_04);
  var_06 = spawnStruct();
  var_06.var_7584 = var_04.var_0116;
  var_06.var_00E5 = param_01;
  var_06.var_3DD7 = 1;
  var_06.var_3DD6 = (0.5, 0.5, 1);
  var_06.var_7585 = var_05;
  var_06.var_0875 = param_03;
  var_06.var_78C9 = 8;
  level.var_78AC[param_00][level.var_78AC[param_00].size] = var_06;
  return var_06;
}

func_A162() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_78AA)) {
      wait 0.05;
      continue;
    }

    var_00 = level.var_08BF;
    foreach(var_02 in level.var_78AC[level.var_78AA]) {
      if(func_572C(var_02.var_9188, var_02.var_366E)) {
        level.var_08BF = var_02;
        continue;
      }

      var_02.var_3DD6 = (0.5, 0.5, 1);
    }

    if(isDefined(level.var_08BF)) {
      level.var_08BF.var_3DD6 = (1, 1, 0.5);
      if(isDefined(var_00) && var_00 != level.var_08BF) {
        level.var_6999 method_8617("mouse_over");
      }
    }

    wait 0.05;
  }
}

func_A940() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_6999)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.var_6999 buttonpresseddevonly("BUTTON_A")) {
      wait 0.05;
    }

    level.var_6999 method_8617("mouse_click");
    if(isDefined(level.var_08BF) && var_00) {
      level.var_08BF notify("select_button_pressed");
      [[level.var_08BF.var_0875]]();
      var_00 = 0;
    }

    while(level.var_6999 buttonpresseddevonly("BUTTON_A")) {
      wait 0.05;
    }
  }
}

func_A8EE() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_6999)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.var_6999 buttonpresseddevonly("BUTTON_X")) {
      wait 0.05;
    }

    level.var_6999 method_8617("mouse_click");
    if(var_00) {
      func_0874();
      var_00 = 0;
    }

    while(level.var_6999 buttonpresseddevonly("BUTTON_X")) {
      wait 0.05;
    }
  }
}

func_8F1B(param_00) {
  for(var_01 = 0; var_01 < param_00.size - 1; var_01++) {
    for(var_02 = 0; var_02 < param_00.size - 1 - var_01; var_02++) {
      if(param_00[var_02 + 1].var_7585 < param_00[var_02].var_7585) {
        func_1DD7(param_00[var_02], param_00[var_02 + 1]);
      }
    }
  }
}

func_1DD7(param_00, param_01) {
  var_02 = param_00.var_7584;
  var_03 = param_00.var_00E5;
  var_04 = param_00.var_7585;
  var_05 = param_00.var_0875;
  var_06 = param_00.var_78C9;
  param_00.var_7584 = param_01.var_7584;
  param_00.var_00E5 = param_01.var_00E5;
  param_00.var_7585 = param_01.var_7585;
  param_00.var_0875 = param_01.var_0875;
  param_00.var_78C9 = param_01.var_78C9;
  param_01.var_7584 = var_02;
  param_01.var_00E5 = var_03;
  param_01.var_7585 = var_04;
  param_01.var_0875 = var_05;
  param_01.var_78C9 = var_06;
}

func_33C7(param_00) {
  foreach(var_02 in level.var_78AC[param_00]) {
    var_02 thread func_33C6(param_00);
  }
}

func_33C6(param_00) {
  level endon("game_ended");
  self endon("remove_button");
  var_01 = level.var_78AD[param_00]["view_pos"];
  var_02 = var_01 + func_78A9(self.var_7585, 4);
  for(;;) {
    var_03 = (1, 0, 0);
    if(func_572C(self.var_9188, self.var_366E)) {
      var_03 = (1, 1, 0);
    }

    if(isDefined(level.var_2856) && level.var_2856 > 0) {
      var_04 = var_01 + func_78A9(level.var_7F3D, 2);
    }

    wait 0.05;
  }
}

func_ACC8(param_00, param_01) {
  level.var_08BF = undefined;
  if(isDefined(level.var_78AA) && level.var_78AA != "") {
    level.var_78AE = level.var_78AA;
  } else {
    level.var_78AE = "main";
    level.var_78AA = "main";
  }

  foreach(var_03 in level.var_78AC[level.var_78AE]) {
    var_03 notify("remove_button");
  }

  if(isDefined(param_01) && param_01) {
    level.var_6999 func_47F3(level.var_78AD[level.var_78AE]["view_start"], param_00);
  } else {
    level.var_6999 func_47F2(level.var_78AD[param_00]["view_start"]);
  }

  level thread func_33C7(param_00);
  level.var_78AA = param_00;
}

func_463D(param_00, param_01) {
  var_02 = level.var_78AD[param_00]["view_angles"];
  var_03 = level.var_78AD[param_00]["view_pos"];
  var_03 = var_03 + vectornormalize(anglesToForward(var_02)) * 40;
  var_04 = anglesToForward(var_02);
  var_05 = vectornormalize(anglestoup(var_02));
  var_06 = param_01.var_001D;
  var_07 = param_01.var_0116;
  var_08 = vectornormalize(vectorfromlinetopoint(var_03, var_03 + var_04, var_07));
  var_09 = acos(vectordot(var_08, var_05));
  if(vectordot(anglestoright(var_02), var_08) < 0) {
    var_09 = 360 - var_09;
  }

  return var_09;
}

func_78A9(param_00, param_01) {
  var_02 = (270 - param_00, 0, 0);
  var_03 = anglesToForward(var_02);
  var_04 = vectornormalize(var_03);
  var_05 = var_04 * param_01;
  return var_05;
}

func_4586(param_00, param_01) {
  var_02 = param_00 + param_01 + 720 / 2 - 360;
  return var_02;
}

func_572C(param_00, param_01) {
  var_02 = level.var_7F3D > param_00 && level.var_7F3D < 360;
  var_03 = level.var_7F3D > 0 && level.var_7F3D < param_01;
  if(param_00 > param_01) {
    var_04 = var_02 || var_03;
  } else {
    var_04 = level.var_7F3D > param_01 && level.var_7F3D < var_02;
  }

  return var_04;
}

func_0874() {
  if(isDefined(level.var_78AA) && level.var_78AA != "main") {
    func_ACC8("main", 1);
    return;
  }
}

func_0880() {
  iprintlnbold("action_weapons_primary");
  func_ACC8("weapons_primary");
}

func_0881() {
  iprintlnbold("action_weapons_secondary");
  func_ACC8("weapons_secondary");
}

func_0876() {
  iprintlnbold("action_gears");
  func_ACC8("gears");
}

func_0877() {
  iprintlnbold("action_killstreak");
  func_ACC8("killstreak");
}

func_0878() {
  iprintlnbold("action_leaderboards");
  func_ACC8("leaderboards");
}

func_A4AB() {
  level.var_A4AC = [];
  func_1D19("player_view1_start");
  func_1D19("player_view2_start");
  func_1D19("player_view3_start");
  func_1D19("player_view4_start");
  func_1D19("player_view5_start");
}

func_1D19(param_00) {
  level.var_A4AC[param_00] = [];
  var_01 = getent(param_00, "targetname");
  level.var_A4AC[param_00][level.var_A4AC[param_00].size] = var_01;
  while(isDefined(var_01) && isDefined(var_01.var_01A2)) {
    var_02 = getent(var_01.var_01A2, "targetname");
    level.var_A4AC[param_00][level.var_A4AC[param_00].size] = var_02;
    var_01 = var_02;
  }
}

func_47F2(param_00) {
  if(!isDefined(level.var_34D5)) {
    var_01 = level.var_A4AC[param_00][0];
    level.var_34D5 = spawn("script_model", var_01.var_0116);
    level.var_34D5.var_001D = var_01.var_001D;
    self setorigin(level.var_34D5.var_0116 - (0, 0, 65));
    self linkto(level.var_34D5);
    wait 0.05;
    self setangles(level.var_34D5.var_001D);
    thread func_3DF9();
  }

  var_02 = 1;
  var_03 = abs(distance(level.var_34D5.var_0116, level.var_A4AC[param_00][level.var_A4AC[param_00].size - 1].var_0116));
  var_02 = var_02 * var_03 / 1200;
  var_02 = max(var_02, 0.1);
  var_04 = var_02;
  if(!1) {
    var_04 = var_04 * var_02 * level.var_A4AC[param_00].size + 1;
  }

  thread func_1883(3, var_04);
  foreach(var_07, var_06 in level.var_A4AC[param_00]) {
    if(1) {
      if(var_07 != level.var_A4AC[param_00].size - 1) {
        continue;
      }
    }

    level.var_34D5 moveto(var_06.var_0116, var_02, var_02 * 0.5, 0);
    level.var_34D5 rotateto(var_06.var_001D, var_02, var_02 * 0.5, 0);
    wait(var_02);
  }
}

func_47F3(param_00, param_01) {
  var_02 = 1;
  var_03 = abs(distance(level.var_34D5.var_0116, level.var_78AD[param_01]["player_view_pos"]));
  var_02 = var_02 * var_03 / 1200;
  var_02 = max(var_02, 0.1);
  var_04 = var_02;
  if(!1) {
    var_04 = var_04 * var_02 * level.var_A4AC[param_00].size + 1;
  }

  thread func_1883(3, var_04);
  if(!1) {
    for(var_05 = level.var_A4AC[param_00].size - 1; var_05 >= 0; var_05--) {
      var_06 = level.var_A4AC[param_00][var_05];
      level.var_34D5 moveto(var_06.var_0116, var_02);
      level.var_34D5 rotateto(var_06.var_001D, var_02);
      wait(var_02);
    }
  }

  thread func_1883(3, var_02);
  var_07 = level.var_78AD[param_01]["player_view_pos"];
  var_08 = level.var_78AD[param_01]["view_angles"];
  level.var_34D5 moveto(var_07, var_02, var_02 * 0.5, 0);
  level.var_34D5 rotateto(var_08, var_02, var_02 * 0.5, 0);
  wait(var_02);
}

func_9D01(param_00) {
  self setblurforplayer(20, param_00 + 0.2 / 2);
  self setblurforplayer(0, param_00 + 0.2 / 2);
  self shellshock("frag_grenade_mp", param_00 + 0.2);
}

func_1883(param_00, param_01) {
  var_02 = int(param_01 / 0.05);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = var_03 / var_02;
    var_05 = sin(180 * var_04);
    var_06 = param_00 * var_05;
    setDvar("797", var_06);
    wait 0.05;
  }

  setDvar("797", 0);
}

func_3DF9() {
  level endon("game_ended");
  self endon("disconnect");
  level.var_34D5 endon("remove_dummy");
  for(;;) {
    self setangles(level.var_34D5.var_001D);
    wait 0.05;
  }
}