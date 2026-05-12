/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_audio_debug.gsc
*********************************************/

func_00F9() {}

func_06EC(param_00) {
  var_01 = getdvarint("snd_debugRavenAudioHUDY");
  var_02 = lib_02EF::func_4719();
  var_03 = var_02[0];
  var_04 = var_02[1];
  if(var_01 < 0) {
    var_01 = var_04 + var_01;
  }

  var_05 = var_01 + 18 * param_00;
  return var_05;
}

func_06ED(param_00, param_01, param_02, param_03) {
  var_04 = getdvarint("snd_debugRavenAudioHUDX");
  var_05 = lib_02EF::func_4719();
  var_06 = var_05[0];
  var_07 = var_05[1];
  if(isDefined(param_03) == 0) {
    param_03 = (1, 1, 1);
  }

  if(var_04 < 0) {
    var_04 = var_06 + var_04;
  }

  lib_02EF::func_8AA0(var_04 + param_00, func_06EC(param_01), param_02, param_03, 0.75, 1.5);
}

func_06E9() {
  var_00 = undefined;
  if(isDefined(self.var_0116) == 1) {
    var_00 = self.var_0116;
  }

  if(isDefined(self.var_A265) == 1) {
    var_00 = self.var_A265["origin"];
    self.var_0116 = var_00;
    self.var_6C3F = 1;
  }

  if(lib_02F0::func_8006(self) == "clientsnd") {
    if(isDefined(self.var_8F45) == 1) {
      var_00 = self.var_8F45.var_0116;
      self.var_8F46 = var_00;
      if(isDefined(self.var_8F49) == 1) {
        var_00 = var_00 + self.var_8F49;
      }
    } else if(function_0279(self.var_8F45) == 1 && isDefined(self.var_8F46) == 1) {
      var_00 = self.var_8F46;
      if(isDefined(self.var_8F49) == 1) {
        var_00 = var_00 + self.var_8F49;
      }
    } else if(isDefined(self.var_8F49) == 1) {
      var_00 = self.var_8F49;
    }

    self.var_0116 = var_00;
    self.var_6C3F = 1;
  }

  if(function_0279(self) == 1) {
    return undefined;
  }

  return var_00;
}

func_06EA() {
  var_00 = "unknown";
  if(isDefined(self.var_A265) == 1 && isDefined(self.var_A265["soundalias"]) == 1) {
    var_00 = self.var_A265["soundalias"];
  } else if(isDefined(self.var_8F3E) == 1) {
    var_00 = self.var_8F3E;
  }

  return var_00;
}

func_06E8(param_00, param_01, param_02, param_03) {
  var_04 = getDvar("snd_debugRavenAudioFilter");
  var_05 = func_06EA();
  var_06 = undefined;
  var_07 = getsndaliasvalue(var_05, "spatialize");
  if(isDefined(var_07) == 1 && var_07 == "2d") {
    return -1;
  }

  if(isDefined(var_04) == 1 && var_04 != "") {
    if(common_scripts\utility::func_9462(var_05, var_04) < 0) {
      return -1;
    }
  }

  var_06 = func_06E9();
  if(isDefined(var_06) == 0) {
    return -1;
  }

  var_08 = common_scripts\utility::func_AA4A(param_00, param_01, var_06, param_02);
  if(var_08 == 0) {
    return -1;
  }

  var_09 = distance(param_00, var_06);
  if(param_03 > 0 && param_03 < var_09) {
    return -1;
  }

  return var_09;
}

func_06E3(param_00, param_01, param_02, param_03, param_04, param_05) {
  for(var_06 = 0; var_06 < param_01.size; var_06++) {
    var_07 = param_01[var_06];
    var_08 = var_07 func_06E8(param_02, param_03, param_04, param_05);
    if(var_08 >= 0) {
      param_00[param_00.size] = var_07;
    }
  }

  return param_00;
}

func_06E2(param_00, param_01) {
  var_02 = getdvarfloat("snd_debugRavenAudioDistance");
  var_03 = [];
  var_04 = param_00 getEye();
  var_05 = param_00 geteyeangles();
  var_06 = getdvarfloat("cg_fov", 65);
  var_07 = cos(var_06);
  if(isDefined(level.var_05B0) == 1 && param_01 >= 3) {
    var_03 = func_06E3(var_03, level.var_05B0, var_04, var_05, var_07, var_02);
  }

  if(isDefined(level.var_071D) == 1 && isDefined(level.var_071D.var_0623) == 1) {
    var_03 = func_06E3(var_03, level.var_071D.var_0623, var_04, var_05, var_07, var_02);
  }

  if(isDefined(level.var_06B2) == 1) {
    if(isDefined(level.var_06B2.var_061A) == 1) {
      var_03 = func_06E3(var_03, level.var_06B2.var_061A, var_04, var_05, var_07, var_02);
    }

    if(isDefined(level.var_06B2.var_0720) == 1) {
      var_03 = func_06E3(var_03, level.var_06B2.var_0720, var_04, var_05, var_07, var_02);
    }

    if(isDefined(level.var_06B2.var_05E5) == 1) {
      var_03 = func_06E3(var_03, level.var_06B2.var_05E5, var_04, var_05, var_07, var_02);
    }
  }

  return var_03;
}

func_06E6() {
  var_00 = func_06E9();
  var_01 = (0, 0, 0);
  var_02 = func_06EA();
  var_03 = getdvarfloat("snd_debugRavenAudioRadius");
  var_04 = var_03;
  var_05 = 0;
  if(isDefined(self.var_001D) == 1) {
    var_01 = self.var_001D;
  }

  if(var_02 != "unknown") {
    var_06 = getsndaliasvalue(var_02, "dist_min");
    if(isDefined(var_06) == 1 && var_06 > 0) {
      var_04 = var_06;
    } else {
      var_05 = 1;
    }
  }

  var_07 = 0;
  foreach(var_09 in level.var_744A) {
    var_0A = var_09 getEye();
    var_07 = lib_02EF::func_578C(var_0A, var_01, var_05);
    if(var_07 == 1) {
      var_05 = var_04;
      break;
    }
  }

  var_0C = getdvarfloat("snd_debugRavenAudioColorScale");
  var_0D = lib_02EF::func_A2BB((1, 1, 1), var_0C);
  var_0E = 0.5;
  if(var_07 == 1 || var_06 == 1) {
    lib_02EF::func_28BB(var_01, var_02, var_05, var_0D, var_0E, 0, 1);
  }
}

func_06E7(param_00, param_01, param_02) {
  var_03 = getdvarfloat("snd_debugRavenAudioCrosshairRadius");
  var_04 = getdvarfloat("cg_fov", 65);
  var_05 = param_00 getEye();
  var_06 = 9999999;
  var_07 = undefined;
  foreach(var_09 in param_01) {
    var_0A = var_09 func_06E9();
    var_0B = param_00 method_8214(var_0A, var_04, var_03);
    if(var_0B == 1) {
      var_0C = param_00 method_8404(var_0A, var_04);
      var_0D = distance2d(var_0C, common_scripts\utility::func_A2BE());
      if(var_0D < var_06) {
        var_06 = var_0D;
        var_07 = var_09;
      }
    }
  }

  return var_07;
}

func_06E5(param_00, param_01) {
  var_02 = getdvarvector("snd_debugRavenAudioColor");
  var_03 = getdvarfloat("snd_debugRavenAudioColorScale");
  var_04 = lib_02EF::func_A2BD(var_02, var_03 * 10);
  var_05 = getdvarfloat("cg_fov", 65);
  var_06 = func_06E9();
  var_07 = func_06EA();
  var_08 = "?";
  var_09 = "?";
  var_0A = param_00 getEye();
  var_0B = param_00 geteyeangles();
  var_0C = anglestoright(var_0B);
  if(var_07 != "unknown") {
    var_0D = lib_02EF::func_468E(var_07, "dist_min");
    var_0E = lib_02EF::func_468D(var_07, "dist_max");
    if(isDefined(var_0D) == 1 && var_0D > 0) {
      var_08 = var_0D;
    }

    if(isDefined(var_0E) == 1 && var_0E > 0) {
      var_09 = var_0E;
    }
  }

  if(isDefined(var_07) == 1) {
    var_0F = getdvarfloat("snd_debugRavenAudioScale");
    var_10 = distance(var_06, var_0A);
    var_11 = 1;
    if(function_02A2(var_08) == 1 && var_08 > 0 && function_02A2(var_09) == 1 && var_09 > 0) {
      lib_02EF::func_8086(var_10, var_08, var_09, 1, 0.5);
    }

    var_12 = var_10 * 0.002;
    var_13 = var_0F * var_12;
    lib_02EF::func_8AA6(var_06 + (0, 0, -1.5 * var_13 * 12), var_07, var_04, var_11, var_13, 1, var_0C);
    var_13 = var_0F * 0.666 * var_12;
    var_14 = "d: " + var_08 + " / " + var_10 + " / " + var_09;
    lib_02EF::func_8AA6(var_06 + (0, 0, -3.5 * var_13 * 12), var_14, var_04, var_11, var_13, 1, var_0C);
  }

  if(isDefined(var_09) == 1 && function_02A2(var_09) == 1 && var_09 > 0) {
    var_15 = 0.25;
    var_16 = var_04;
    var_17 = 1;
    var_18 = lib_02EF::func_A2BB(var_16, var_15) + (1, 0, 0);
    var_19 = lib_02EF::func_A2BB(var_16, var_15) + (0, 1, 0);
    var_1A = lib_02EF::func_A2BB(var_16, var_15) + (0, 0, 1);
    var_1B = (0, var_09, 0);
    var_1C = (var_09, 0, 0);
    var_1D = (0, 0, var_09);
  }
}

func_06E4(param_00) {
  if(param_00 <= 1) {
    return;
  }

  if(isDefined(level.var_744A) == 0) {
    if(isDefined(level.var_27EE) == 0 || isDefined(level.var_721C) == 0) {
      return;
    } else {
      level.var_744A = [];
      level.var_744A[level.var_744A.size] = level.var_721C;
    }
  }

  level.var_05B8 = [];
  foreach(var_02 in level.var_744A) {
    var_03 = [];
    var_03 = func_06E2(var_02, param_00);
    level.var_05B8 = common_scripts\utility::func_0F73(level.var_05B8, var_03);
  }

  if(level.var_744A.size > 1) {
    level.var_05B8 = common_scripts\utility::func_0F97(level.var_05B8);
  }

  var_05 = getdvarint("snd_debugRavenAudioDrawLimit");
  var_06 = 0;
  if(level.var_05B8.size >= var_05) {
    var_07 = [];
    foreach(var_02 in level.var_744A) {
      var_07[var_07.size] = var_02 getEye();
    }

    var_0A = common_scripts\utility::func_A2B9(var_07);
    level.var_05B8 = function_01AC(level.var_05B8, var_0A);
    foreach(var_0C in level.var_05B8) {
      if(isDefined(var_0C.var_6C3F) == 1) {
        var_0C.var_0116 = undefined;
        var_0C.var_6C3F = undefined;
      }
    }
  }

  foreach(var_0F in level.var_05B8) {
    if(var_05 > 0 && var_06 >= var_05) {
      func_06ED(520, 2, "** " + var_05 + " LIMITED **", (1, 0, 0));
      break;
    }

    var_0F func_06E6();
    var_06 = var_06 + 1;
  }

  var_11 = [];
  foreach(var_02 in level.var_744A) {
    var_13 = func_06E7(var_02, level.var_05B8, param_00);
    if(isDefined(var_13) == 1) {
      var_13 func_06E5(var_02, param_00);
      var_11 = common_scripts\utility::func_0F6F(var_11, var_13);
      var_06 = var_06 + 1;
    }
  }
}

func_06EB(param_00) {
  var_01 = getDvar("snd_debugRavenAudioFilter");
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = "";
  var_08 = "";
  var_09 = 0;
  if(isDefined(level.var_05B0) == 1) {
    var_02 = level.var_05B2;
    var_03 = level.var_05B1;
  }

  if(isDefined(level.var_071D) == 1 && isDefined(level.var_071D.var_0623) == 1) {
    var_04 = level.var_071D.var_0623.size;
  }

  if(isDefined(level.var_06B2) == 1 && isDefined(level.var_06B2.var_061A) == 1) {
    var_04 = var_04 + level.var_06B2.var_061A.size;
  }

  if(isDefined(level.var_06B2) == 1 && isDefined(level.var_06B2.var_0720) == 1) {
    var_05 = level.var_06B2.var_0720.size;
  }

  if(isDefined(level.var_06B2) == 1 && isDefined(level.var_06B2.var_05E5) == 1) {
    var_06 = level.var_06B2.var_05E5.size;
  }

  if(isDefined(level.var_05B8) == 1 && level.var_05B8.size > 0 && param_00 >= 3) {
    var_07 = var_07 + " (" + level.var_05B8.size + " visible)";
  }

  if(isDefined(var_01) == 1 && var_01 != "") {
    var_08 = var_08 + "\" + var_01 + "\";
  }

  if(isDefined(level.var_05C5) == 1) {
    var_09 = level.var_05C5.size;
  }

  func_06ED(0, 0, "Audio Entity count: " + var_04);
  func_06ED(0, 1, "Network Sound Entity count: " + var_05);
  func_06ED(0, 2, "Client Sound count: " + var_06);
  func_06ED(0, 3, "Audio Parameter Entity count: " + var_09);
  if(param_00 >= 3) {
    var_0A = 4;
    func_06ED(0, var_0A, " CreateFX sfx (loop) count: " + var_02);
    var_0A++;
    func_06ED(0, var_0A, " CreateFX sfx_interval count: " + var_03);
    var_0A++;
    var_0B = "";
    if(isDefined(level.var_05B8) == 1 && level.var_05B8.size > 0) {
      var_0B = var_0B + level.var_05B8.size;
    } else {
      var_0B = var_0B + "0";
    }

    if(isDefined(var_01) == 1 && var_01 != "") {
      var_0B = var_0B + " (" + var_08 + ")";
    }

    func_06ED(0, var_0A, " Visible Sound count: " + var_0B);
    var_0A++;
  }
}

func_06E1(param_00) {
  var_01 = 0.75;
  var_02 = getdvarint("snd_debugRavenAudioCrosshair");
  var_03 = getdvarfloat("snd_debugRavenAudioCrosshairAlpha");
  var_04 = getdvarfloat("snd_debugRavenAudioCrosshairRadius", "64");
  if(var_02 != 0 && isDefined(level.var_05B4) == 0) {
    var_05 = newhudelem();
    var_05.var_01D3 = 320;
    var_05.var_01D7 = 240;
    var_05.var_0010 = "center";
    var_05.var_0011 = "middle";
    var_05.var_00C6 = "fullscreen";
    var_05.var_01CA = "fullscreen";
    var_05.var_00A0 = 1;
    var_05.var_0184 = 1;
    level.var_05B4 = var_05;
  }

  if(var_02 != 0 && isDefined(level.var_05B4) == 1) {
    level.var_05B4 setshader("widg_circle", int(var_04 * 2 * var_01), int(var_04 * 2));
    level.var_05B4.var_0018 = var_03;
  }

  if(var_02 == 0 && isDefined(level.var_05B4) == 1) {
    level.var_05B4 destroy();
    level.var_05B4 = undefined;
  }
}

func_06E0(param_00) {
  if(isDefined(param_00) == 1 && param_00 < 1) {
    return;
  }

  if(getDvar("1459") != "on") {
    if(isDefined(level.var_05B0) == 1 && level.var_05B0.size > 0) {
      return;
    }
  } else {
    while(isDefined(level.var_27EE) == 0) {
      wait 0.05;
    }
  }

  while(isDefined(level.var_2804) == 0) {
    wait 0.05;
  }

  level.var_05B0 = [];
  level.var_05B2 = 0;
  level.var_05B1 = 0;
  for(var_01 = 0; var_01 < level.var_2804.size; var_01++) {
    var_02 = level.var_2804[var_01];
    if(isDefined(var_02.var_A265["type"]) == 0) {
      continue;
    }

    if(var_02.var_A265["type"] == "soundfx") {
      level.var_05B2++;
      level.var_05B0[level.var_05B0.size] = var_02;
    }

    if(var_02.var_A265["type"] == "soundfx_interval") {
      level.var_05B1++;
      level.var_05B0[level.var_05B0.size] = var_02;
    }
  }
}

func_06EE() {}

func_06EF() {
  level endon("snd_debug_end");
  for(;;) {
    var_00 = getdvarint("snd_debugRavenAudio");
    if(var_00 != 0) {
      func_06E0(var_00);
      func_06E4(var_00);
      func_06E1(var_00);
      func_06EB(var_00);
    }

    wait 0.05;
  }
}