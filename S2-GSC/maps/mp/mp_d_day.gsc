/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_d_day.gsc
*********************************************/

func_00F9() {
  setdvarifuninitialized("loadscreen_poses", 0);
  lib_04A2::func_00F9();
  lib_040A::func_00F9();
  lib_04A1::func_00F9();
  maps\mp\_load::func_00F9();
  maps\mp\mp_d_day_lighting::func_00F9();
  maps\mp\mp_d_day_aud::func_00F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_d_day");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_d_day_killstreak";
  level.var_5A6B = "mp_d_day_killstreak";
  level.var_47CD = "mp_d_day_glide1";
  level.var_47CE = "mp_d_day_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  setDvar("1520", "-0.3 1 0.3 13");
  setDvar("5800", 3);
  setDvar("4230", 400);
  func_854F();
  level thread maps\mp\_utility::func_5246();
  thread func_918C();
  level thread func_5461();
}

func_854F() {
  setDvar("330", 1);
  setDvar("1271", 30);
}

func_918C() {
  var_00 = [(3419.79, 6397.19, 735.927), (1774.04, 6258.63, 724.925), (1005.1, 8224.58, 863.727), (688.495, 7922.39, 900.26), (2013.09, 3907.71, 365.023), (2489.66, 5191.32, 335.633), (-1613.17, 7480.25, 799.985), (-151.475, 6909.94, 749.729), (-900.085, 9282.89, 924.29), (-1221.37, 3117.04, 357.256), (824.276, 2733.36, 350.209), (-2921.04, 7171.94, 823.524), (-2411.72, 5768.69, 760.266), (-2562.08, 5337.96, 695.713), (-1954.52, 3878.88, 375.158), (-2825.11, 4752.04, 293.088)];
  wait(4);
  var_01 = 10;
  var_02 = 10;
  for(;;) {
    var_03 = randomfloatrange(0.8, 2);
    wait(var_03);
    while(var_02 == var_01) {
      var_02 = randomintrange(10, 25);
    }

    activateclientexploder(var_02);
    if(var_02 < 15) {
      activateclientexploder(1);
    } else if(var_02 > 14 && var_02 < 20) {
      activateclientexploder(2);
    } else {
      activateclientexploder(3);
    }

    thread func_0FF4(var_00[var_02 - 10]);
    var_01 = var_02;
  }
}

func_0FF4(param_00) {
  var_01 = 0.4;
  wait(2);
  earthquake(var_01, 1, param_00, 600);
}

func_5461() {
  level endon("game_ended");
  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
    return;
  }

  if(isDefined(game["status"]) && game["status"] != "normal") {
    return;
  }

  if(!isDefined(level.var_984D) || !level.var_984D) {
    return;
  }

  level waittill("matchStartTimer");
  thread func_7043();
  thread func_7043(10, 0, 15, 3, 1600);
  thread func_3AAD();
}

func_3AAD() {
  wait(2);
  var_00 = 8;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    var_02 = randomfloatrange(0.05, 0.25);
    var_03 = randomfloatrange(9, 12);
    var_04 = 1;
    var_05 = 1800;
    var_06 = randomintrange(-2000, 2000);
    var_07 = 1;
    thread func_7043(var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    wait(0.75);
  }
}

func_7043(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level endon("game_ended");
  var_07 = common_scripts\utility::func_46B5("intro_flight_path_start", "targetname");
  var_08 = common_scripts\utility::func_46B5("intro_flight_path_end", "targetname");
  if(!isDefined(param_00)) {
    param_00 = 100;
  }

  if(!isDefined(var_07) || !isDefined(var_08)) {
    return;
  }

  if(!isDefined(param_04)) {
    param_04 = 2000;
  }

  if(!isDefined(param_02)) {
    param_02 = 18;
  }

  if(!isDefined(param_01)) {
    param_01 = 5;
  }

  if(!isDefined(param_03)) {
    param_03 = 5;
  }

  if(isDefined(param_06) && param_06) {
    var_09 = "ks_fighter_strafe_usa";
    var_0A = "vehicle_usa_fighter_thunderbolt_vista";
    var_0B = "vehicle_usa_fighter_thunderbolt_vista_fade";
  } else {
    var_09 = "ks_emergency_airdrop_usa";
    var_0A = "usa_bomber_commando_vista";
    var_0B = "usa_bomber_commando_vista_fade";
  }

  var_0C = 1200;
  var_0D = 1;
  var_0E = [];
  var_0F = 1;
  var_10 = var_07.var_0116 + (0, 0, param_04);
  var_11 = var_08.var_0116 + (0, 0, param_04);
  wait(param_01);
  while(var_0D <= param_03) {
    var_12 = spawn("script_model", var_10);
    var_12 setModel(var_0B);
    var_12 thread func_7016(var_0A);
    if(isDefined(var_09)) {
      var_12 scriptmodelplayanim(var_09);
    }

    var_0E[var_0E.size] = var_12;
    var_12.var_001D = vectortoangles(vectornormalize(var_11 - var_10));
    var_13 = anglesToForward(var_12.var_001D);
    var_14 = anglestoright(var_12.var_001D);
    if(isDefined(param_06) && param_06) {
      playFXOnTag(common_scripts\utility::func_44F5("fighter_plane_flyover"), var_12, "tag_origin");
    } else {
      playFXOnTag(common_scripts\utility::func_44F5("bomber_plane_flyover"), var_12, "tag_origin");
    }

    if(isDefined(param_05) && var_0F) {
      var_10 = var_10 + var_14 * param_05;
      var_11 = var_11 + var_14 * param_05;
      var_0F = 0;
    }

    switch (var_0D) {
      case 1:
        var_12.var_0116 = var_10;
        var_12.var_4800 = var_11;
        var_12.var_7035 = 1;
        var_12.var_7021 = var_0D + param_00;
        break;

      case 2:
        var_12.var_0116 = var_10 + var_14 * var_0C * -1 + var_13 * var_0C * -1;
        var_12.var_4800 = var_11 + var_14 * var_0C * -1 + var_13 * var_0C * -1;
        var_12.var_7035 = 2;
        var_12.var_7021 = var_0D + param_00;
        break;

      case 3:
        var_12.var_0116 = var_10 + var_14 * var_0C + var_13 * var_0C * -1;
        var_12.var_4800 = var_11 + var_14 * var_0C + var_13 * var_0C * -1;
        var_12.var_7035 = 3;
        var_12.var_7021 = var_0D + param_00;
        break;

      case 4:
        var_12.var_0116 = var_10 + var_14 * var_0C * -2 + var_13 * var_0C * -2;
        var_12.var_4800 = var_11 + var_14 * var_0C * -2 + var_13 * var_0C * -2;
        var_12.var_7035 = 4;
        var_12.var_7021 = var_0D + param_00;
        break;

      case 5:
        var_12.var_0116 = var_10 + var_14 * var_0C * 2 + var_13 * var_0C * -2;
        var_12.var_4800 = var_11 + var_14 * var_0C * 2 + var_13 * var_0C * -2;
        var_12.var_7035 = 5;
        var_12.var_7021 = var_0D + param_00;
        break;
    }

    var_12 thread func_7025();
    var_12 lib_0378::func_8D74("mp_intro_dday_plane_flyover", var_0A, var_12.var_7021);
    var_12 moveto(var_12.var_4800, param_02);
    var_0D++;
    wait 0.05;
  }

  wait(param_02 - 1);
  foreach(var_12 in var_0E) {
    var_12 thread func_7017(var_0B);
  }
}

func_7025() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;
  var_01 = 5;
  var_02 = -8;
  var_03 = randomfloatrange(1, 2);
  var_04 = 1;
  for(;;) {
    if(var_04 % 2 == 0) {
      self rotateto(self.var_001D + (0, 0, var_01), var_03);
    } else if(var_04 % 3 == 0) {
      self rotateto(self.var_001D + (0, 0, var_00), var_03);
    } else {
      self rotateto(self.var_001D + (0, 0, var_02), var_03);
    }

    wait(var_03);
    var_04++;
  }
}

func_7016(param_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = 0.5;
  self setmaterialscriptparam(0, 1, var_01);
  wait(var_01);
  self setModel(param_00);
}

func_7017(param_00) {
  var_01 = 1;
  self setModel(param_00);
  self setmaterialscriptparam(1, 0, var_01);
}