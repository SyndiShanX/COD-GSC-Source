/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_skill.gsc
*********************************************/

func_00D5() {
  level.var_8C73 = getdvarint("skill_rdur_min", 60);
  level.var_8C74 = float(getdvarint("skill_recent_sosc", 1000)) / 1000;
  level.var_8C76 = getdvarint("skill_sos_max_weight", 5);
  level.var_8C77 = float(getdvarint("skill_sos_tanh_scale", 1000)) / 1000;
  level.var_8C75 = float(getdvarint("skill_sos_default_rating", 500)) / 1000;
  level thread func_6B82();
}

func_534E(param_00) {
  if(!param_00 func_57D1()) {
    return;
  }

  if(isDefined(param_00.var_8F28)) {
    return;
  }

  param_00.var_8F28 = level.var_8F28;
  level.var_8F28++;
  var_01 = spawnStruct();
  var_01.var_170A = maps\mp\_utility::func_44FB();
  var_01.var_1708 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "sosRating");
  var_01.var_1709 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "sosWeight");
  if(var_01.var_1709 <= 0.5) {
    var_01.var_1708 = level.var_8C75;
  }

  var_01.var_1704 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfRating");
  var_01.var_1705 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfVariance");
  var_01.var_5C17 = var_01.var_170A;
  var_01.var_80A6 = undefined;
  level.var_8F29[param_00.var_8F28] = var_01;
}

func_7743() {
  foreach(var_01 in level.var_744A) {
    var_01 func_0738();
  }
}

func_775A() {
  func_0738();
}

func_6B82() {
  level.var_8F29 = [];
  level.var_8F28 = 0;
  for(;;) {
    level waittill("player_spawned", var_00);
    func_534E(var_00);
  }
}

func_57D1() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isbot(self)) {
    return 0;
  }

  if(!maps\mp\_utility::func_7A69()) {
    return 0;
  }

  return 1;
}

func_0663(param_00, param_01) {
  var_02 = 1;
  while(param_01) {
    if(param_01 & 1) {
      var_02 = var_02 * param_00;
    }

    param_01 = param_01 >> 1;
    param_00 = param_00 * param_00;
  }

  return var_02;
}

func_05F3(param_00) {
  var_01 = common_scripts\utility::func_8C4F(param_00);
  var_02 = log(function_00D8(abs(param_00)) / 3);
  var_02 = var_02 * var_01;
  return var_02;
}

func_06AC(param_00) {
  if(param_00 <= -3) {
    return -1;
  }

  if(param_00 >= 3) {
    return 1;
  }

  var_01 = param_00 * param_00;
  var_02 = param_00 * 27 + var_01 / 27 + 9 * var_01;
  return var_02;
}

func_0661(param_00) {
  if(param_00 <= -1) {
    return -3;
  }

  if(param_00 >= 1) {
    return 3;
  }

  var_01 = param_00 * param_00;
  var_02 = var_01 * param_00;
  var_03 = 27 * var_02 + var_01 - 1 - param_00;
  var_04 = func_05F3(var_03);
  var_05 = 3 * param_00;
  var_06 = 9 * 1 - var_01;
  var_07 = var_04;
  var_08 = -1 * var_06 / var_07;
  var_09 = var_04 + var_05 + var_08;
  return var_09;
}

func_0662(param_00) {
  var_01 = param_00;
  var_01 = var_01 * 2;
  var_01 = var_01 - 1;
  var_01 = func_0661(var_01) / level.var_8C77;
  return var_01;
}

func_062B(param_00) {
  param_00 = clamp(param_00, -3.141593, 3.141593);
  var_01 = param_00;
  var_01 = func_06AC(var_01 * level.var_8C77);
  var_01 = var_01 + 1;
  var_01 = var_01 * 0.5;
  return var_01;
}

func_0595(param_00, param_01) {
  var_02 = func_0662(param_00);
  var_02 = var_02 + param_01;
  var_03 = func_062B(var_02);
  return var_03;
}

func_05EB(param_00) {
  var_01 = param_00 * 2000;
  return int(var_01);
}

func_05EC(param_00) {
  var_01 = float(param_00) / 2000;
  var_01 = clamp(var_01, 0, 1);
  return var_01;
}

func_05D7(param_00, param_01, param_02, param_03) {
  var_04 = param_00 + param_02 * 0.5 + param_03;
  var_05 = param_00 + param_02 + param_01 + 2 * param_03;
  if(var_05 == 0) {
    return 0.5;
  }

  var_06 = var_04 / var_05;
  return var_06;
}

func_05D8(param_00, param_01) {
  var_02 = param_00 - 0.5;
  var_02 = var_02 * 1;
  var_03 = func_0595(param_01, var_02);
  return var_03;
}

func_0685(param_00) {
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in param_00) {
    var_01 = var_01 + abs(var_04);
  }

  if(var_01 != 0) {
    var_02 = 1 / var_01;
  }

  foreach(var_07, var_04 in param_00) {
    param_00[var_07] = param_00[var_07] * var_02;
  }

  return param_00;
}

func_060A(param_00, param_01) {
  var_02 = 0;
  foreach(var_05, var_04 in param_00) {
    if(isDefined(param_01[var_05])) {
      var_02 = var_02 + var_04 * param_01[var_05];
    }
  }

  return var_02;
}

func_06AB(param_00) {
  if(param_00 < -10) {
    return 0 - param_00;
  }

  return func_0684(param_00) / func_0683(param_00);
}

func_073D(param_00, param_01) {
  return param_00 * param_00 + param_01;
}

func_0684(param_00) {
  return 0.3989423 * log(param_00 * param_00 * 0.5 * -1);
}

func_0683(param_00) {
  var_01 = abs(0.7071068 * param_00);
  var_02 = 1 / 1 + 0.5 * var_01;
  var_03 = var_02 * log(var_01 * var_01 * -1 - 1.265512 + var_02 * 1.000024 + var_02 * 0.374092 + var_02 * 0.09678418 + var_02 * -0.1862881 + var_02 * 0.2788681 + var_02 * -1.135204 + var_02 * 1.488516 + var_02 * -0.8221523 + var_02 * 0.1708728);
  if(param_00 >= 0) {
    var_03 = 2 - var_03;
  }

  return 0.5 * var_03;
}

func_0739(param_00) {
  if(isbot(param_00)) {
    return;
  }

  if(!isDefined(param_00.var_8F28)) {
    return;
  }

  level.var_8F29[param_00.var_8F28].var_5C17 = maps\mp\_utility::func_44FB();
  var_01 = level.var_8F29[param_00.var_8F28].var_5C17 - level.var_8F29[param_00.var_8F28].var_170A;
  if(var_01 > level.var_8C73 && isDefined(param_00.var_012C) && isDefined(param_00.var_012C["score"])) {
    level.var_8F29[param_00.var_8F28].var_80A6 = param_00.var_012C["score"] / var_01;
    return;
  }

  level.var_8F29[param_00.var_8F28].var_80A6 = undefined;
}

func_0738() {
  if(!func_57D1()) {
    return;
  }

  if(isDefined(self.var_8C78) || !isDefined(self.var_8F28)) {
    return;
  }

  self.var_8C78 = 1;
  if(!isDefined(level.var_8F29[self.var_8F28])) {
    return;
  }

  foreach(var_01 in level.var_744A) {
    func_0739(var_01);
  }

  var_03 = level.var_8F29[self.var_8F28];
  if(!isDefined(var_03.var_80A6)) {
    return;
  }

  var_04 = var_03.var_5C17 - var_03.var_170A;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = var_03.var_1708 * var_04;
  var_09 = var_04;
  var_0A = var_03.var_1705;
  var_0B = var_03.var_1704;
  var_0C = 0;
  var_0D = 0;
  if(var_0A == 0) {
    var_0A = min(1, max(0.8596 + abs(var_03.var_1704) * -0.18397, 0.05));
  }

  foreach(var_16, var_0F in level.var_8F29) {
    if(var_16 == self.var_8F28) {
      continue;
    }

    if(!isDefined(var_0F.var_80A6)) {
      continue;
    }

    var_10 = var_0F.var_5C17 - max(var_03.var_170A, var_0F.var_170A);
    if(var_10 <= 0) {
      continue;
    }

    var_11 = 7 + var_0A;
    if(var_0F.var_1705) {
      var_11 = var_11 + var_0F.var_1705;
    } else {
      var_11 = var_11 + min(max(abs(var_0F.var_1704) * -0.18397 + 0.8596, 0.05), 1);
    }

    var_12 = sqrt(var_11);
    var_13 = var_0B - var_0F.var_1704 / var_12;
    var_14 = 0;
    if(var_03.var_80A6 > var_0F.var_80A6) {
      var_05 = var_05 + 1;
      var_14 = 1;
    } else if(var_03.var_80A6 < var_0F.var_80A6) {
      var_06 = var_06 + 1;
      var_14 = 0;
    } else {
      var_07 = var_07 + 1;
      var_14 = 0.5;
    }

    var_15 = 1 / 1 + log(var_13 * -1);
    var_0C = var_0C + var_14 - var_15 / var_12;
    var_0D = var_0D + sqrt(var_0A) / var_12 * var_15 * 1 - var_15 / var_11;
    var_08 = var_08 + var_0F.var_1708 * var_10;
    var_09 = var_09 + var_10;
  }

  var_0A = var_0A + 0.0001;
  var_0B = var_0B + var_0A * var_0C;
  var_0A = max(0.05, var_0A * 1 - var_0A * var_0D);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "gdfRating", var_0B);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "gdfVariance", var_0A);
  var_17 = var_08 / var_09;
  var_18 = 1;
  var_19 = func_05D7(var_05, var_06, var_07, level.var_8C74);
  var_1A = func_05D8(var_19, var_17);
  var_1B = var_1A;
  var_1C = min(var_03.var_1709, level.var_8C76);
  var_1D = var_1C + var_18;
  if(var_1D > 0) {
    var_1B = var_03.var_1708 * var_1C + var_1B * var_18 / var_1D;
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "sosRating", var_1B);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "sosWeight", var_03.var_1709 + var_18);
  }
}