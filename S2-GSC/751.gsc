/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 751.gsc
*********************************************/

func_524B() {
  lib_02F0::func_7FE7();
  func_525F();
}

func_57B3() {
  return 0;
}

func_7FE6() {}

func_7FE5(param_00, param_01) {
  return param_00;
}

func_4624(param_00) {
  if(isDefined(param_00) == 1) {
    if(isDefined(param_00.name) == 1) {
      return param_00.name;
    }

    if(isDefined(param_00.var_132) == 1) {
      return param_00.var_132;
    }
  }

  return undefined;
}

func_56DB(param_00) {
  var_01 = undefined;
  var_02 = 0;
  if(isDefined(param_00) == 1 && function_0279(param_00) == 0 && isDefined(param_00.classname) == 1 && isDefined(param_00.code_classname) == 1) {
    var_01 = param_00 getentitynumber();
  }

  if(isDefined(var_01) == 1 && var_01 >= 0) {
    var_02 = 1;
  } else if(isDefined(param_00.origin) == 1 && isDefined(param_00.var_8F4E) == 1 && param_00.var_8F4E == "sndentity") {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  return var_02;
}

func_4625() {
  var_00 = undefined;
  if(common_scripts\utility::issp() == 1) {
    var_00 = [level.player];
  } else if(isarray(level.players) == 1) {
    var_00 = level.players;
  }

  return var_00;
}

func_46BD(param_00) {
  var_01 = self;
  var_02 = "tag_origin";
  var_03 = -1;
  if(isDefined(param_00) == 1) {
    var_02 = param_00;
  }

  var_03 = var_01 method_8445(var_02);
  if(isDefined(var_03) == 0 || var_03 == -1) {
    var_02 = "";
  }

  return var_02;
}

func_A77A() {
  while(function_0279(self) == 0) {
    common_scripts\utility::waittill_any("death", "disconnect");
  }
}

func_7A5C(param_00, param_01, param_02) {
  if(isDefined(param_00) && isDefined(param_01)) {
    if(param_00 == param_01) {
      return param_00;
    } else {
      var_03 = randomfloatrange(param_00, param_01);
      return var_03;
    }
  } else if(isDefined(param_01) == 1 && isDefined(param_02) == 0) {
    return param_01;
  } else if(isDefined(var_03)) {
    return var_03;
  }

  return undefined;
}

func_8086(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_02 - param_01;
  var_06 = clamp(param_00, param_01, param_02);
  var_07 = var_06 - param_01 / var_05;
  var_08 = param_04 - param_03;
  var_09 = param_03 + var_08 * var_07;
  return var_09;
}

func_A2BB(param_00, param_01) {
  var_02 = param_00 * (param_01, param_01, param_01);
  return var_02;
}

func_0760(param_00) {
  var_01 = 0;
  var_02 = 0;
  var_03 = 1;
  var_04 = param_00;
  for(var_05 = 0; var_05 < 3; var_05++) {
    var_06 = param_00[var_05];
    if(var_06 > var_02) {
      var_01 = var_05;
      var_02 = var_06;
    }
  }

  var_03 = 1 / var_02;
  var_04 = func_A2BB(var_04, var_03);
  return var_04;
}

func_A2BC(param_00, param_01) {
  var_02 = func_A2BB(param_00, param_01);
  var_03 = func_0760(var_02);
  return var_03;
}

func_A2BD(param_00, param_01) {
  var_02 = func_A2BB(param_00, param_01);
  var_03 = function_026B(var_02, 1, 0);
  return var_03;
}

func_578C(param_00, param_01, param_02) {
  var_03 = distance(param_00, param_01);
  if(var_03 <= param_02) {
    return 1;
  }

  return 0;
}

func_6C21(param_00, param_01, param_02) {
  var_03 = param_00[0];
  var_04 = param_00[1];
  var_05 = param_00[2];
  var_03 = var_03 + param_01 * cos(param_02);
  var_04 = var_04 + param_01 * sin(param_02);
  var_06 = (var_03, var_04, var_05);
  return var_06;
}

randomarrayelement(param_00) {
  var_01 = randomintrange(1, param_00.size);
  var_01 = var_01 - 1;
  var_02 = param_00[var_01];
  return var_02;
}

func_7A5B(param_00, param_01, param_02) {
  var_03 = param_00 - param_02;
  var_04 = param_00 + param_02;
  var_05 = var_04 - var_03;
  var_06 = (randomfloat(var_05[0]), randomfloat(var_05[1]), randomfloat(var_05[2]));
  if(param_01 != (0, 0, 0)) {
    var_03 = param_00 - rotatevector(param_00 - var_03, param_01);
    var_06 = rotatevector(var_06, param_01);
  }

  var_07 = var_03 + var_06;
  return var_07;
}

func_2B5C(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = param_00 - param_02;
  var_08 = param_00 + param_02;
  var_09[0] = (var_08[0], var_08[1], var_08[2]);
  var_09[1] = (var_08[0], var_08[1], var_07[2]);
  var_09[2] = (var_07[0], var_08[1], var_07[2]);
  var_09[3] = (var_07[0], var_08[1], var_08[2]);
  var_0A[0] = (var_08[0], var_07[1], var_08[2]);
  var_0A[1] = (var_08[0], var_07[1], var_07[2]);
  var_0A[2] = (var_07[0], var_07[1], var_07[2]);
  var_0A[3] = (var_07[0], var_07[1], var_08[2]);
  if(param_01 != (0, 0, 0)) {
    var_09[0] = param_00 + rotatevector(param_00 - var_09[0], param_01);
    var_09[1] = param_00 + rotatevector(param_00 - var_09[1], param_01);
    var_09[2] = param_00 + rotatevector(param_00 - var_09[2], param_01);
    var_09[3] = param_00 + rotatevector(param_00 - var_09[3], param_01);
    var_0A[0] = param_00 + rotatevector(param_00 - var_0A[0], param_01);
    var_0A[1] = param_00 + rotatevector(param_00 - var_0A[1], param_01);
    var_0A[2] = param_00 + rotatevector(param_00 - var_0A[2], param_01);
    var_0A[3] = param_00 + rotatevector(param_00 - var_0A[3], param_01);
  }

  for(var_0B = 0; var_0B < 4; var_0B++) {
    var_0C = var_0B + 1;
    if(var_0C == 4) {
      var_0C = 0;
    }
  }
}

func_28BB(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = (param_02, param_02, param_02);
  func_2B5C(param_00, param_01, var_07, param_03, param_04, param_05, param_06);
}

func_2B50(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = (1, 0, 0);
  var_07 = (0, 1, 0);
  var_08 = (0, 0, 1);
  if(isDefined(param_01) == 0) {
    param_01 = 16;
  }

  if(isDefined(param_02) == 0) {
    param_02 = (0, 0, 0);
  } else {
    var_06 = anglesToForward(param_02);
    var_07 = anglestoright(param_02) * -1;
    var_08 = anglestoup(param_02);
  }

  if(isDefined(param_03) == 0) {
    param_03 = (1, 1, 1);
  }

  if(isDefined(param_04) == 0) {
    param_04 = 1;
  }

  if(isDefined(param_05) == 0) {
    param_05 = 1;
  }

  var_06 = var_06 * param_01;
  var_07 = var_07 * param_01;
  var_08 = var_08 * param_01;
  var_09 = 0.333;
  var_0A = (var_09, var_09, var_09);
  var_0B = param_03 * var_0A + (1, 0, 0);
  var_0C = param_03 * var_0A + (0, 1, 0);
  var_0D = param_03 * var_0A + (0, 0, 1);
}

func_4719() {
  var_00 = 1920;
  var_01 = 1080;
  var_02 = getDvar("r_dynamicSceneWidth");
  var_03 = getDvar("r_mode");
  var_04 = strtok(var_03, "x");
  if(isDefined(var_04) == 1 && var_04.size >= 2) {
    var_00 = int(var_04[0]);
    var_01 = int(var_04[1]);
    if(isDefined(level.var_122) == 1 && level.var_122 != 0) {
      var_05 = getdvarint("vid_width");
      var_06 = getdvarint("vid_height");
      if(isDefined(var_06) == 1 && var_06 > 0) {
        var_00 = var_05;
        var_01 = var_06;
      }
    } else if(isDefined(level.var_148) == 1 && level.var_148 != 0) {
      var_00 = int(var_02);
    } else if(isDefined(level.weaponinventorytype) == 1 && level.weaponinventorytype != 0) {
      var_00 = int(var_02);
    }
  }

  return [var_00, var_01];
}

func_7FF6(param_00, param_01, param_02, param_03) {
  if(isDefined(level.var_7FF7) == 0) {
    func_7FE5(isDefined(level.var_7FF7) == 0, "rvPlayAnimation was not initialized!");
    return;
  }

  if(isDefined(param_02) == 0) {
    param_02 = "animnotetrack";
  }

  if(isDefined(param_03) == 0) {
    param_03 = 1;
  }

  self thread[[level.var_7FF7]](param_00, param_01, param_02, param_03);
}

func_063B(param_00, param_01, param_02) {
  if(function_0344(param_00) == 0) {
    return undefined;
  }

  var_03 = getsndaliasvalue(param_00, param_01);
  if(isDefined(var_03) == 0 || "" + var_03 == "") {
    return undefined;
  }

  var_04 = float(var_03);
  for(var_05 = getsndaliasvalue(param_00, "secondaryaliasname"); isDefined(var_05) == 1 && var_05 != ""; var_05 = getsndaliasvalue(var_05, "secondaryaliasname")) {
    var_03 = getsndaliasvalue(param_00, param_01);
    var_03 = float(var_03);
    var_04 = [[param_02]](var_04, var_03);
  }

  return var_04;
}

func_468E(param_00, param_01) {
  var_02 = func_063B(param_00, param_01, ::min);
  return var_02;
}

func_468D(param_00, param_01) {
  var_02 = func_063B(param_00, param_01, ::max);
  return var_02;
}

func_05DA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_09)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(isDefined(param_08)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  if(isDefined(param_07)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07);
  }

  if(isDefined(param_06)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06);
  }

  if(isDefined(param_05)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05);
  }

  if(isDefined(param_04)) {
    self[[param_00]](param_01, param_02, param_03, param_04);
  }

  if(isDefined(param_03)) {
    self[[param_00]](param_01, param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    self[[param_00]](param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self[[param_00]](param_01);
    return;
  }

  self[[param_00]]();
}

func_05D9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_09)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(isDefined(param_08)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  if(isDefined(param_07)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06, param_07);
  }

  if(isDefined(param_06)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05, param_06);
  }

  if(isDefined(param_05)) {
    self[[param_00]](param_01, param_02, param_03, param_04, param_05);
  }

  if(isDefined(param_04)) {
    self[[param_00]](param_01, param_02, param_03, param_04);
  }

  if(isDefined(param_03)) {
    self[[param_00]](param_01, param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    self[[param_00]](param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self[[param_00]](param_01);
    return;
  }

  self[[param_00]]();
}

func_1E74(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(function_0336(param_00) == 1) {
    func_05DA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    return;
  }

  func_05D9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_1E80(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  thread func_1E74(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_8A7C(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = (0, 0, 0);
  var_08 = 39.37008;
  if(isDefined(param_02) == 0) {
    param_02 = 1;
  }

  if(isDefined(param_05) == 0) {
    param_05 = 1;
  }

  if(isDefined(param_06) == 0) {
    param_06 = 343.3;
  }

  if((param_02 == 0 && param_05 == 0) || param_06 == 0) {
    return [0, 0, 0];
  }

  var_09 = param_06 * var_08;
  var_0A = param_00 - param_03;
  var_0B = length(var_0A);
  var_0C = 0;
  var_0D = 0;
  if(param_02 > 0 && param_01 != var_07) {
    var_0C = vectordot(param_01, var_0A) / var_0B;
    var_0C = var_0C * param_02;
  }

  if(param_05 > 0 && param_04 != var_07) {
    var_0D = vectordot(param_04, var_0A) / var_0B;
    var_0D = var_0D * param_05;
  }

  var_0E = var_09 - var_0C / var_09 - var_0D;
  return [var_0E, var_0C, var_0D];
}

func_525E(param_00, param_01) {
  var_02 = [];
  var_03 = 1 / param_01 - 1;
  for(var_04 = 0; var_04 < param_01; var_04++) {
    var_05 = var_04 * var_03;
    var_06 = 0;
    switch (param_00) {
      default:
        break;

      case "linear":
        var_02[0] = 0;
        var_02[1] = 1;
        return var_02;

      case "sine":
        var_06 = 0.5 + cos(var_05 * 180) * -0.5;
        break;

      case "easein":
        var_06 = 1 - cos(var_05 * 90);
        break;

      case "easeout":
        var_06 = sin(var_05 * 90);
        break;

      case "easeinout":
        var_06 = 3 * pow(var_05, 2) - 2 * pow(var_05, 3);
        break;

      case "circularin":
        var_06 = 1 - sqrt(1 - var_05 * var_05);
        break;

      case "circularout":
        var_06 = sqrt(1 - 1 - var_05 * 1 - var_05);
        break;

      case "exponential_40db":
        var_02[0] = 0;
        var_02[1] = 0.01584893;
        var_02[2] = 0.02511887;
        var_02[3] = 0.03981072;
        var_02[4] = 0.06309573;
        var_02[5] = 0.1;
        var_02[6] = 0.1584893;
        var_02[7] = 0.2511886;
        var_02[8] = 0.3981072;
        var_02[9] = 0.6309574;
        var_02[10] = 1;
        return var_02;

      case "exponential_60db":
        var_02[0] = 0;
        var_02[1] = 1.97531E-05;
        var_02[2] = 0.0003160494;
        var_02[3] = 0.0016;
        var_02[4] = 0.00505679;
        var_02[5] = 0.01234568;
        var_02[6] = 0.0256;
        var_02[7] = 0.04742716;
        var_02[8] = 0.08090864;
        var_02[9] = 0.1296;
        var_02[10] = 0.1975309;
        var_02[11] = 0.2892049;
        var_02[12] = 0.4096;
        var_02[13] = 0.5641679;
        var_02[14] = 0.7588345;
        var_02[15] = 1;
        return var_02;

      case "default_vfcurve":
        var_02[0] = 0;
        var_02[1] = 0.2;
        var_02[2] = 0.42;
        var_02[3] = 0.65;
        var_02[4] = 1;
        return var_02;
    }

    var_02[var_02.size] = var_06;
  }

  return var_02;
}

func_525F(param_00) {
  if(isDefined(param_00) == 0) {
    param_00 = 11;
  }

  level.var_5B3 = [];
  level.var_5B3["linear"] = func_525E("linear", param_00);
  level.var_5B3["sine"] = func_525E("sine", param_00);
  level.var_5B3["easein"] = func_525E("easein", param_00);
  level.var_5B3["easeout"] = func_525E("easeout", param_00);
  level.var_5B3["easeinout"] = func_525E("easeinout", param_00);
  level.var_5B3["circularin"] = func_525E("circularin", param_00);
  level.var_5B3["circularout"] = func_525E("circularout", param_00);
  level.var_5B3["exponential_40db"] = func_525E("exponential_40db", param_00);
  level.var_5B3["exponential_60db"] = func_525E("exponential_60db", param_00);
  level.var_5B3["default_vfcurve"] = func_525E("default_vfcurve", param_00);
}

func_06DF(param_00) {
  if(isDefined(param_00) == 0) {
    return "easeout";
  }

  switch (param_00) {
    case "xfade":
      return "easeout";
  }

  return param_00;
}

func_8A79(param_00) {
  var_01 = level.var_5B3[func_06DF(param_00)];
  if(isDefined(var_01) == 1) {
    return var_01.size;
  }

  return 0;
}

func_8A78(param_00) {
  var_01 = level.var_5B3[param_00];
  if(isDefined(var_01) == 1) {
    return 1;
  }

  return 0;
}

func_8A7A(param_00, param_01) {
  param_01 = func_06DF(param_01);
  var_02 = level.var_5B3[param_01];
  param_00 = clamp(param_00, 0, 1);
  var_03 = 0;
  var_04 = 1 / var_02.size - 1;
  if(param_00 == 0) {
    return 0;
  }

  if(param_00 == 1) {
    return 1;
  }

  for(var_05 = 0; var_05 < var_02.size; var_05++) {
    var_06 = var_05 * var_04;
    var_07 = var_05 + 1 * var_04;
    if(param_00 >= var_06 && param_00 <= var_07) {
      var_08 = param_00 - var_06;
      var_09 = var_07 - var_06;
      var_0A = var_08 / var_09;
      var_0B = var_02[var_05];
      var_0C = var_02[var_05 + 1];
      var_0D = var_0C - var_0B;
      var_03 = var_0B + var_0D * var_0A;
      break;
    }
  }

  return var_03;
}

func_0708() {
  if(isDefined(self) == 1 && function_0279(self) == 0 && isDefined(self.var_5C8) == 0) {
    self.var_5C8 = spawnStruct();
    self.var_5C8.var_A60D = 1;
    self.var_5C8.var_6FF7 = 1;
    self.var_5C8.var_996E = [];
  }
}

func_070B(param_00, param_01, param_02) {
  if(isDefined(param_00.var_8F4E) == 1 && param_00.var_8F4E == "clientsnd") {
    changeclientsoundvolume(param_00.var_4983, param_01, param_02);
    return;
  }

  if(isDefined(param_00.var_8F4E) == 1 && param_00.var_8F4E == "sndentity") {
    param_00 scalesoundentityvolume(param_01, param_02);
    return;
  }

  param_00 method_861B(param_01, param_02);
}

func_070A(param_00, param_01, param_02) {
  if(isDefined(param_00.var_8F4E) == 1 && param_00.var_8F4E == "clientsnd") {
    changeclientsoundpitch(param_00.var_4983, param_01, param_02);
    return;
  }

  if(isDefined(param_00.var_8F4E) == 1 && param_00.var_8F4E == "sndentity") {
    param_00 scalesoundentitypitch(param_01, param_02);
    return;
  }

  param_00 method_861A(param_01, param_02);
}

func_070C(param_00, param_01) {
  if(function_0279(self) == 1 || isDefined(self) == 0) {
    return;
  }

  func_0708();
  if(isDefined(param_01) == 1) {
    if(param_01 == ::func_070B) {
      self.var_5C8.var_A60D = param_00;
      return;
    }

    if(param_01 == ::func_070A) {
      self.var_5C8.var_6FF7 = param_00;
      return;
    }
  }
}

func_06F7(param_00) {
  if(isDefined(self.var_5C8) == 1) {
    if(param_00 == ::func_070B) {
      return self.var_5C8.var_A60D;
    } else if(param_00 == ::func_070A) {
      return self.var_5C8.var_6FF7;
    }
  }

  return undefined;
}

func_0707() {
  var_00 = 0;
  var_01 = undefined;
  self waittill("sfx_scale_completed", var_02);
  if(var_02 == ::func_070B) {
    self.var_5C8.var_57B7 = undefined;
    var_01 = "volume";
  }

  if(var_02 == ::func_070A) {
    self.var_5C8.var_57B6 = undefined;
    var_01 = "pitch";
  }

  self.var_5C8.var_996E[var_01] = undefined;
  if(isDefined(self.var_5C8.var_57B7) == 0 && isDefined(self.var_5C8.var_57B6) == 0) {
    self.var_5C8.var_57B5 = undefined;
  }

  self notify("sfx_stop_scale_" + var_01);
  waittillframeend;
}

func_0709(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  self endon("deleted");
  self endon("death");
  var_05 = func_8A79(param_00);
  var_06 = float(param_02) % 0.05;
  param_02 = float(param_02) + 0.05 - var_06;
  var_07 = float(param_02) / float(var_05);
  var_08 = var_07 % 0.05;
  var_07 = var_07 + 0.05 - var_08;
  var_07 = max(var_07, 0.05);
  var_09 = int(var_07 * 1000 + 0.5);
  var_0A = int(param_02 * 1000 + 0.5);
  var_0B = int(0);
  if(isDefined(self.var_5C8.var_57B5) == 1) {
    var_0C = 0;
    if((isDefined(self.var_5C8.var_57B7) == 1 && param_03 == ::func_070B) || isDefined(self.var_5C8.var_57B6) == 1 && param_03 == ::func_070A) {
      var_0C = 1;
    }

    if(var_0C == 1) {
      self notify("sfx_scale_completed", param_03);
      waittillframeend;
      self notify("sfx_scale_interrupted", param_03);
    }
  }

  var_0D = func_06F7(param_03);
  var_0E = 0;
  if(var_0D > param_01) {
    var_0E = 1;
  }

  while(isDefined(self.var_8F3E) == 0 && isDefined(self.guid) == 0) {
    wait 0.05;
  }

  waittillframeend;
  thread func_0707();
  self.var_5C8.var_57B5 = 1;
  var_0F = undefined;
  if(param_03 == ::func_070B) {
    self.var_5C8.var_57B7 = 1;
    var_0F = "volume";
  }

  if(param_03 == ::func_070A) {
    self.var_5C8.var_57B6 = 1;
    var_0F = "pitch";
  }

  self.var_5C8.var_996E[var_0F] = thisthread;
  self endon("sfx_stop_scale_" + var_0F);
  while(var_0B < var_0A && isDefined(self) == 1 && isDefined(self.var_5C8.var_996E[var_0F]) == 1) {
    var_10 = var_0A - var_0B * 0.001;
    if(isDefined(self.var_5C8.var_A6F2) == 1) {
      var_07 = max(self.var_5C8.var_A6F2, 0.05);
    }

    var_11 = min(var_07, var_10);
    var_0B = var_0B + int(var_11 * 1000 + 0.5);
    var_12 = float(var_0B) / float(var_0A);
    var_13 = 1;
    if(var_0E > 0) {
      var_12 = clamp(1 - var_12, 0, 1);
      var_14 = func_8A7A(var_12, param_00);
      var_13 = lerp(param_01, var_0D, var_14);
    } else {
      var_14 = func_8A7A(var_12, param_00);
      var_13 = lerp(var_0D, param_01, var_14);
    }

    [[param_03]](self, var_13, var_11);
    wait(var_11);
    if(isDefined(self) == 1 && function_0279(self) == 0) {
      func_070C(var_13, param_03);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self) == 1) {
    self notify("sfx_scale_completed", param_03);
  }

  if(isDefined(param_04) == 1) {
    self[[param_04]]();
  }
}

func_8AAD(param_00) {
  func_0708();
  self.var_5C8.var_A6F2 = max(param_00, 0.05);
}

func_8AA9(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0.00390625;
  var_06 = 2;
  var_07 = 0;
  var_08 = 4;
  if(func_7FE5(isDefined(self) == 0, "sfx_scale: called on undefined entity")) {
    return;
  }

  if(func_7FE5(function_0279(self) == 1, "sfx_scale: called on removed entity")) {
    return;
  }

  func_0708();
  var_09 = param_01;
  var_0A = undefined;
  var_0B = undefined;
  switch (param_00) {
    case "vol":
    case "Volume":
    case "Vol":
    case "V":
    case "volume":
    case "v":
      var_0A = ::func_070B;
      var_0B = "volume";
      var_09 = clamp(param_01, var_07, var_08);
      func_7FE5(param_01 != var_09, "sfx_scale: clamped volume " + param_01 + " -> " + var_09);
      break;

    case "Pitch":
    case "P":
    case "pitch":
    case "p":
      var_0A = ::func_070A;
      var_0B = "pitch";
      var_09 = clamp(param_01, var_05, var_06);
      func_7FE5(param_01 != var_09, "sfx_scale: clamped pitch " + param_01 + " -> " + var_09);
      break;
  }

  if(isDefined(param_02) == 0 || param_02 == 0) {
    [[var_0A]](self, var_09, 0);
    func_070C(var_09, var_0A);
    self notify("sfx_scale_completed", var_0A);
    self notify("sfx_scale_interrupted");
    self notify("sfx_stop_scale_" + var_0B);
    return;
  }

  thread func_0709(param_03, var_09, param_02, var_0A, param_04);
  if(var_0A == ::func_070B) {
    self notify("rvSndAbortInitialFadeIn");
  }
}

func_8AAF(param_00, param_01, param_02, param_03) {
  func_8AA9("volume", param_00, param_01, param_02, param_03);
}

func_8AAC(param_00, param_01, param_02, param_03) {
  func_8AA9("pitch", param_00, param_01, param_02, param_03);
}

func_8AAB(param_00) {
  return param_00 func_06F7(::func_070B);
}

func_8AAA(param_00) {
  return param_00 func_06F7(::func_070A);
}

func_06F8(param_00) {
  if(isDefined(self.var_5C6) == 0) {
    return;
  }

  if(isDefined(param_00) == 1) {
    if(isDefined(self.var_5C6[param_00]) == 1) {
      if(isDefined(self.var_5C6[param_00].var_93F9) == 1) {
        self[[self.var_5C6[param_00].var_93F9]](self.var_5C6[param_00].var_A22D);
      }

      self.var_5C6[param_00] = undefined;
    }
  } else {
    foreach(var_02 in self.var_5C6) {
      if(isDefined(var_02.var_93F9) == 1) {
        self[[var_02.var_93F9]](var_02.var_A22D);
      }

      self.var_5C6 = undefined;
    }
  }

  if(isDefined(self.var_5C6) == 0 || self.var_5C6.size == 0) {
    level.var_5C5 = common_scripts\utility::func_F93(level.var_5C5, self);
    level.var_5C5 = common_scripts\utility::func_FA0(level.var_5C5);
    self.var_5C6 = undefined;
    self.var_5C7 = undefined;
    self notify("param_stop");
  }
}

func_06FC() {
  self endon("param_stop");
  common_scripts\utility::waittill_any("death", "disconnect");
  func_06F8();
}

func_06FB() {
  if(isDefined(self.var_5C7) == 1) {
    return;
  }

  self.var_5C7 = thisthread;
  thread func_06FC();
  self endon("disconnect");
  self endon("param_stop");
  while(function_0279(self) == 0 && isDefined(self.var_5C6) == 1 && self.var_5C6.size > 0) {
    var_00 = gettime();
    foreach(var_02 in self.var_5C6) {
      var_02.var_5796 = 1;
      if(isDefined(var_02.var_53BF) == 1) {
        var_02.var_53C2 = self[[var_02.var_53BF]](var_02.var_A22D);
      }

      if(isDefined(var_02.var_6C76) == 1) {
        if(var_02.var_A22D.size > 0) {}

        foreach(var_06, var_04 in var_02.var_6C76) {
          if(func_56DB(self) == 1) {
            var_05 = undefined;
            if(var_02.var_A22D.size > 0) {
              var_05 = var_02.var_A22D[var_06];
            }

            self thread[[var_04]](var_02.var_53C2, var_05);
          }
        }
      }

      var_02.var_5796 = undefined;
    }

    wait 0.05;
  }

  if(function_0279(self) == 1) {
    func_06F8();
  }
}

func_06F9(param_00) {
  if(isDefined(level.var_5C5) == 0) {
    level.var_5C5 = [];
  }

  if(isDefined(self.var_5C6) == 0) {
    self.var_5C6 = [];
  }

  if(isDefined(self.var_5C6[param_00]) == 0) {
    self.var_5C6[param_00] = spawnStruct();
  }

  if(common_scripts\utility::func_F79(level.var_5C5, self) == 0) {
    level.var_5C5[level.var_5C5.size] = self;
  }
}

func_8A95(param_00, param_01) {
  func_06F9(param_00);
  self.var_5C6[param_00].var_53BF = param_01;
  self.var_5C6[param_00].var_53C2 = undefined;
  thread func_06FB();
}

func_8A9A(param_00, param_01, param_02) {
  func_06F9(param_00);
  if(isDefined(self.var_5C6[param_00].var_6C76) == 0) {
    self.var_5C6[param_00].var_6C76 = [];
  }

  var_03 = self.var_5C6[param_00].var_6C76.size;
  self.var_5C6[param_00].var_6C76[var_03] = param_01;
  if(isDefined(self.var_5C6[param_00].var_A22D) == 0) {
    self.var_5C6[param_00].var_A22D = [];
  }

  if(common_scripts\utility::func_F79(self.var_5C6[param_00].var_A22D, param_02) == 0) {
    var_04 = self.var_5C6[param_00].var_A22D.size;
    self.var_5C6[param_00].var_A22D[var_04] = param_02;
  } else {}

  thread func_06FB();
}

func_0700(param_00, param_01, param_02) {
  func_06F9(param_00);
  self.var_5C6[param_00].var_92C2 = param_01;
  self.var_5C6[param_00].var_93F9 = param_02;
  if(isDefined(self.var_5C6[param_00].var_92C2) == 1) {
    self[[self.var_5C6[param_00].var_92C2]]();
  }
}

func_8A9B(param_00) {
  func_06F8(param_00);
}

func_8A91(param_00, param_01, param_02, param_03, param_04, param_05) {
  func_0700(param_00, param_01, param_04);
  func_8A95(param_00, param_02);
  func_8A9A(param_00, param_03, param_05);
}

func_8A93(param_00) {
  if(isDefined(self.var_5C6) == 1 && isDefined(self.var_5C6[param_00]) == 1 && isDefined(self.var_5C6[param_00].var_53BF) == 1) {
    var_01 = self.var_5C6[param_00];
    if(isDefined(var_01.var_53C2) == 1) {
      return var_01.var_53C2;
    } else {
      return self[[var_01.var_53BF]](var_01.var_A22D);
    }
  }

  return undefined;
}

func_8A92(param_00) {
  if(isDefined(self.var_5C6) == 1 && isarray(self.var_5C6) == 1 && isDefined(self.var_5C6[param_00]) == 1) {
    return 1;
  }

  return 0;
}

func_8A94(param_00) {
  if(isDefined(self.var_5C6) == 1 && isarray(self.var_5C6) == 1) {
    foreach(var_02 in self.var_5C6) {
      if(var_02.var_53BF == param_00) {
        return 1;
      }
    }
  }

  return 0;
}

func_8A99(param_00) {
  var_01 = gettime();
  if(isDefined(self.var_6C46) == 1 && self.var_6C46 == var_01) {
    return self.var_6C45;
  }

  if(isDefined(self.var_6C40) == 0) {
    self.var_6C40 = self.origin;
  }

  self.var_6C45 = self.origin - self.var_6C40;
  self.var_6C46 = var_01;
  self.var_6C40 = self.origin;
  return self.var_6C45;
}

func_8A98(param_00) {
  var_01 = func_8A99();
  self.var_6C44 = length(var_01);
  return self.var_6C44;
}

func_8A97(param_00) {
  var_01 = gettime();
  if(isDefined(self.var_DD4) == 1 && self.var_DD4 == var_01) {
    return self.var_5AE;
  }

  var_02 = self.angles;
  if(isPlayer(self) == 1 || isai(self) == 1) {
    var_02 = self getplayerangles();
  } else if(isDefined(self.model) == 1) {
    var_03 = 0;
    if(isDefined(param_00) == 1 && isarray(param_00) == 1 && isstring(param_00[0]) == 1) {
      var_04 = param_00[0];
      var_05 = self method_8445(var_04);
      if(var_05 >= 0) {
        var_02 = self gettagangles(var_04);
        if(isDefined(var_02) == 1) {
          var_03 = 1;
        }
      }
    }

    if(var_03 == 0) {
      var_02 = self gettagangles("tag_origin");
    }
  }

  if(var_02[0] > 180) {
    var_02 = var_02 - (360, 0, 0);
  }

  if(var_02[1] > 180) {
    var_02 = var_02 - (0, 360, 0);
  }

  if(var_02[2] > 180) {
    var_02 = var_02 - (0, 0, 360);
  }

  if(isDefined(self.var_5AE) == 0) {
    self.var_5AE = var_02;
  }

  if(isDefined(self.var_5A6) == 0) {
    self.var_5A6 = var_02;
  }

  self.var_5A6 = self.var_5AE;
  self.var_5AE = var_02;
  return self.var_5AE;
}

func_8A96(param_00) {
  var_01 = func_8A97(param_00);
  self.var_5AF = var_01 - self.var_5A6;
  return self.var_5AF;
}

func_070D(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", self.origin);
  var_03 linkTo(self, param_00.var_95A6, param_00.var_6A15, (0, 0, 0));
  var_03 method_808C();
  return var_03;
}

func_070F(param_00, param_01, param_02) {
  param_00.var_378F method_808C();
  param_00.var_378F.var_8F47 = lib_02F0::func_800B(param_00.var_BB4, param_00.var_378F);
  lib_02F0::disableplayeruse(param_00.var_378F.var_8F47, 0, 0);
  lib_02F0::enableplayeruse(param_00.var_378F.var_8F47, param_02, 0);
  common_scripts\utility::func_2CB4(0.05, ::lib_02F0::disableplayeruse, param_00.var_378F.var_8F47, param_01, 0.05);
  common_scripts\utility::func_2CB4(0.05, ::lib_02F0::enableplayeruse, param_00.var_378F.var_8F47, param_02, 0.05);
}

func_0710(param_00, param_01, param_02) {
  if(isDefined(param_00.var_378F) == 0) {
    return;
  }

  var_03 = param_00.var_378F;
  var_04 = param_00.var_378F.var_8F47;
  if(isDefined(var_04) == 1) {
    if(isDefined(param_01) == 1) {
      if(isDefined(param_02) == 0) {
        param_02 = "easeinout";
      }

      lib_02F0::disableplayeruse(var_04, 0, param_01, param_02);
      wait(param_01);
    }

    lib_02F0::func_800E(param_00.var_378F.var_8F47);
    wait 0.05;
  }

  var_03 delete();
  var_03 = undefined;
}

func_06FE(param_00, param_01) {
  var_02 = 0.01;
  var_03 = 0.001;
  var_04 = param_00;
  var_05 = param_01;
  if(var_04 < var_02) {
    var_04 = 0;
  }

  var_06 = var_05.var_A614["speed"][0];
  var_07 = var_05.var_A614["speed"][1];
  var_08 = var_05.var_A614["scale"][0];
  var_09 = var_05.var_A614["scale"][1];
  var_0A = var_05.var_A614["curve"][0];
  var_0B = var_05.var_6FFC["speed"][0];
  var_0C = var_05.var_6FFC["speed"][1];
  var_0D = var_05.var_6FFC["scale"][0];
  var_0E = var_05.var_6FFC["scale"][1];
  var_0F = var_05.var_6FFC["curve"][0];
  var_10 = func_8086(var_04, var_06, var_07, var_08, var_09);
  var_11 = func_8086(var_04, var_0B, var_0C, var_0D, var_0E);
  if(isDefined(var_05.var_378F) == 1 && isDefined(var_05.var_378F.var_8F47) == 1 && var_10 <= var_03) {
    thread func_0710(var_05);
    var_05.var_378F = undefined;
    return;
  } else if(isDefined(var_05.var_378F) == 0 && var_10 > var_03) {
    var_05.var_378F = func_070D(var_05, var_10, var_11);
    return;
  }

  if(isDefined(var_05.var_378F) == 1) {
    if(isDefined(var_05.var_378F.var_8F47) == 0) {
      thread func_070F(var_05, var_10, var_11);
      var_05.var_378F.var_90EE = var_04;
      return;
    }

    var_12 = abs(var_04 - var_05.var_378F.var_90EE);
    if(var_12 > var_02) {
      lib_02F0::disableplayeruse(var_05.var_378F.var_8F47, var_10, 0.05, var_0A);
      lib_02F0::enableplayeruse(var_05.var_378F.var_8F47, var_11, 0.05, var_0F);
      var_05.var_378F.var_90EE = var_04;
      return;
    }
  }
}

func_0702(param_00) {
  var_01 = self.var_5CB;
  var_02 = self.var_5CC;
  if(isDefined(param_00) == 1) {
    foreach(var_04 in param_00) {
      thread func_0710(var_04, var_01, var_02);
    }
  }

  self.var_5CD = undefined;
  self.var_5CB = undefined;
  self.var_5CC = undefined;
  self.var_5CA = undefined;
}

func_070E(param_00, param_01, param_02, param_03, param_04) {
  if(function_0344(param_00) == 0) {
    return;
  }

  if(isDefined(self.var_5CA) == 0) {
    self.var_5CA = [];
  }

  if(isDefined(param_01) == 0) {
    param_01 = "tag_origin";
  }

  if(isDefined(param_02) == 0) {
    param_02 = (0, 0, 0);
  }

  if(isDefined(param_03["curve"]) == 0) {
    param_03["curve"] = ["linear"];
  }

  if(isDefined(param_04["curve"]) == 0) {
    param_04["curve"] = ["xfade"];
  }

  var_05 = spawnStruct();
  var_05.var_BB4 = param_00;
  var_05.var_95A6 = param_01;
  var_05.var_6A15 = param_02;
  var_05.var_6FFC = param_03;
  var_05.var_A614 = param_04;
  self.var_5CA[self.var_5CA.size] = var_05;
  func_8A91("speed", undefined, ::func_8A98, ::func_06FE, ::func_0702, var_05);
}

func_8AB7(param_00, param_01) {
  if(isDefined(param_00) == 0) {
    param_00 = 0.05;
  }

  if(isDefined(param_01) == 0) {
    param_01 = "easeinout";
  }

  self.var_5CD = 1;
  self.var_5CB = param_00;
  self.var_5CC = param_01;
  func_8A9B("speed");
}

func_8AAE(param_00, param_01, param_02, param_03, param_04) {
  thread func_070E(param_00, param_01, param_02, param_03, param_04);
}

func_0718() {
  if(isDefined(self.var_5D1) == 1) {
    self waittill("sfx_stop_audioTimer");
    if(isDefined(self.var_5D1.var_8F40) == 1) {
      self.var_5D1.var_8F40 delete();
    }

    self.var_5D1 = undefined;
  }
}

func_0719(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_02) == 0) {
    param_02 = param_01;
  }

  if(isDefined(param_03) == 0) {
    param_03 = 1;
  }

  if(isDefined(param_04) == 0) {
    param_04 = 1;
  }

  if(isDefined(param_05) == 0) {
    param_05 = "linear";
  }

  thread func_0718();
  self endon("sfx_stop_audioTimer");
  while(gettime() <= self.var_5D1.var_36ED) {
    var_07 = gettime();
    var_08 = self.var_5D1.var_36ED - var_07;
    var_09 = 1000;
    if(var_08 <= 5000) {
      var_09 = 500;
    }

    if(var_08 <= 3000) {
      var_09 = 250;
    }

    if(var_08 <= 1000) {
      var_09 = 50;
    }

    var_0A = var_08 - var_09;
    var_0B = var_0A % var_09;
    var_0A = var_0A + var_09 - var_0B;
    if(var_08 <= var_0A) {
      if(self.var_5D1.var_8F4D != 0) {
        self.var_5D1.var_8F40 playSound(param_01);
        self.var_5D1.var_8F4D = 0;
      } else {
        self.var_5D1.var_8F40 playSound(param_02);
        self.var_5D1.var_8F4D = 1;
      }

      var_0C = func_8086(var_08, 0, param_00, param_04, param_03);
      self.var_5D1.var_8F40 func_8AAC(var_0C, 0.05, param_05);
    }

    wait 0.05;
  }

  if(isDefined(param_06) == 1) {
    self[[param_06]]();
  }

  self notify("sfx_stop_audioTimer");
}

func_8AC4() {
  if(isDefined(self.var_5D1) == 1) {
    self notify("sfx_stop_audioTimer");
  }
}

func_8AC3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(self.var_5D1) == 1) {
    func_8AC4();
  }

  var_08 = gettime();
  param_00 = int(param_00 * 1000 + 0.5);
  if(isDefined(self.var_5D1) == 0) {
    self.var_5D1 = spawnStruct();
    self.var_5D1.var_36ED = var_08 + param_00;
    self.var_5D1.var_8F4D = 0;
    self.var_5D1.var_8F40 = spawn("script_origin", self.origin);
    self.var_5D1.var_8F40 linkTo(self);
  }

  thread func_0719(param_00, param_01, param_02, param_04, param_05, param_06, param_07);
}

func_8A81() {
  level notify("sfx_dvar_stop");
}

func_06F6() {
  level endon("game_ended");
  level endon("sfx_dvar_stop");
  for(;;) {
    foreach(var_01 in level.var_5C0) {
      var_02 = var_01.var_1E61;
      var_03 = var_01.var_59E1;
      var_04 = getDvar(var_03);
      if(isDefined(var_02) && isDefined(var_03) && isDefined(var_04) && var_01.value != var_04) {
        var_05 = [[var_02]](var_03, var_04);
        if(isDefined(var_05)) {
          setDvar(var_03, var_05);
          var_01.value = var_05;
        } else {
          var_01.value = var_04;
        }
      }
    }

    wait 0.05;
    if(isDefined(level.hostmigrationtimer)) {
      func_A782();
      foreach(var_01 in level.var_5C0) {
        _sfx_dvar_init_value(var_01.var_59E1, var_01.value);
      }
    }
  }
}

func_A782() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  var_00 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_00;
}

func_06F5() {
  if(isDefined(level.var_5C0) == 0) {
    level.var_5C0 = [];
    level thread func_06F6();
  }
}

func_06F4(param_00, param_01, param_02) {
  func_8A80(param_00);
  level.var_5C0[param_00] = spawnStruct();
  level.var_5C0[param_00].var_1E61 = param_02;
  level.var_5C0[param_00].var_59E1 = param_00;
  level.var_5C0[param_00].value = param_01;
  _sfx_dvar_init_value(param_00, param_01);
}

_sfx_dvar_init_value(param_00, param_01) {
  var_02 = getDvar(param_00);
  if(isDefined(var_02) == 0 || var_02 == "") {
    setdvarifuninitialized(param_00, param_01);
  }
}

func_8A80(param_00) {
  if(isDefined(level.var_5C0[param_00])) {
    level.var_5C0[param_00] = undefined;
  }
}

func_8A7F(param_00, param_01, param_02) {
  func_06F5();
  func_06F4(param_00, param_01, param_02);
}

func_0705() {
  if(isDefined(level.var_5B7) == 1) {
    return;
  }

  level.var_5B7 = thisthread;
  while(isDefined(level.var_5B6) == 1) {
    var_00 = gettime();
    var_01 = [];
    foreach(var_03 in level.var_5B6) {
      if(var_03.duration > 0) {
        var_01[var_01.size] = var_03;
        if(var_03.time == var_00) {
          continue;
        }

        var_03.duration = var_03.duration - 1;
        if(var_03.var_99F9 <= var_00) {
          var_03.alpha = 0;
          var_03 settext("");
        }

        continue;
      }

      var_03 destroy();
    }

    level.var_5B6 = var_01;
    wait 0.05;
  }
}

func_0704(param_00) {
  var_01 = undefined;
  var_02 = gettime();
  var_03 = param_00 * 50;
  return var_01;
}

func_0703(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = 640;
  var_08 = 480;
  var_09 = var_07 / var_08;
  var_0A = func_4719();
  var_0B = var_0A[0];
  var_0C = var_0A[1];
  var_0D = var_0B / var_0C;
  var_0E = -0.5 * var_08 * var_0D - var_07;
  var_0F = param_00 / var_0B * var_07 + 1 - param_00 / var_0B * 0.5 * var_0E;
  var_10 = param_01 / var_0C * var_08;
  if(isDefined(level.var_5B6) == 0) {
    level.var_5B6 = [];
  }

  level thread func_0705();
  var_11 = func_0704(param_06);
  var_11.x = var_0F;
  var_11.y = var_10;
  var_11 settext(param_02);
  var_11.color = param_03;
  var_11.alpha = param_04;
  var_11.fontscale = param_05 * 0.5;
  var_11.font = "smallfixed";
  var_11.alignx = "left";
  var_11.aligny = "bottom";
  var_11.var_4DF6 = "fullscreen";
  var_11.vertalign = "fullscreen";
  var_11.xoffset = 0;
  var_11.yoffset = 0;
  var_11.var_AACF = 0;
  var_11.var_AAEC = 0;
}

func_8AA0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_02) == 0 || param_02 == "") {
    return;
  }

  if(isDefined(param_03) == 0) {
    param_03 = func_A2BB((1, 1, 1), 1);
  }

  if(isDefined(param_04) == 0) {
    param_04 = 1;
  }

  if(isDefined(param_05) == 0) {
    param_05 = 1;
  }

  if(isDefined(param_06) == 0) {
    param_06 = 1;
  }

  if(isDefined(level.var_5B5) == 1) {
    func_0703(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  }
}

func_8AA4(param_00) {
  if(isDefined(param_00) == 1 && param_00 != 0) {
    level.var_5B5 = 1;
    return;
  }

  level.var_5B5 = undefined;
}

func_8AA2(param_00, param_01) {
  if(isDefined(param_01) == 0) {
    param_01 = 1;
  }

  var_02 = func_4719();
  var_03 = var_02[0];
  var_04 = var_02[1];
  var_05 = param_00.size;
  var_06 = var_05 * 6 * param_01;
  var_07 = var_03 * 0.5 - var_06 * 0.5;
  var_08 = var_04 * 0.5 - 6;
  return [var_07, var_08];
}

func_8AA3(param_00, param_01) {
  var_02 = func_8AA2(param_00, param_01);
  var_03 = var_02[0];
  var_04 = var_02[1];
  var_04 = var_04 * 0.5 + 6;
  return [var_03, var_04];
}

func_0706(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = int(param_05 / 0.05);
  var_08 = 0;
  var_09 = int(param_06 / 0.05);
  var_0A = 1;
  var_0B = 0;
  if(isDefined(level.var_5AD) == 0) {
    level.var_5AD = [];
  }

  if(level.var_5AD.size > 0) {
    var_0C = 12 * param_04;
    foreach(var_0E in level.var_5AD) {
      if(common_scripts\utility::func_F79(level.var_5AD, param_01) == 1) {
        param_01 = param_01 + var_0C;
        continue;
      }

      break;
    }
  }

  level.var_5AD = common_scripts\utility::func_F6F(level.var_5AD, param_01);
  while(var_08 < var_07) {
    if(var_08 < var_09) {
      var_10 = int(float(var_08) / float(var_0A));
      var_10 = var_10 % 2;
      if(var_10) {
        var_08 = var_08 + 1;
        wait 0.05;
        continue;
      }
    }

    var_11 = float(var_08) / float(var_07);
    var_11 = clamp(var_11, 0, 1);
    var_12 = func_8A7A(1 - var_11, "easeout");
    var_13 = func_A2BD(param_03, var_12);
    func_8AA0(param_00, param_01, param_02, var_13, var_12, param_04, 1);
    var_08 = var_08 + 1;
    wait 0.05;
  }

  level.var_5AD = common_scripts\utility::func_F93(level.var_5AD, param_01);
}

func_8AA1(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_03) == 0) {
    param_03 = (1, 0, 0);
  }

  if(isDefined(param_04) == 0) {
    param_04 = 2;
  }

  if(isDefined(param_05) == 0) {
    param_05 = 4;
  }

  if(isDefined(param_06) == 0) {
    param_06 = 1;
  }

  if(isDefined(param_01) == 0 || isDefined(param_02) == 0) {
    var_07 = func_8AA3(param_00, param_04);
    if(isDefined(param_01) == 0) {
      param_01 = var_07[0];
    }

    if(isDefined(param_02) == 0) {
      param_02 = var_07[1];
    }
  }

  level thread func_0706(param_01, param_02, param_00, param_03, param_04, param_05, param_06);
}

func_8AA5(param_00, param_01, param_02, param_03, param_04, param_05) {}

func_8AA6(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = param_06 * param_01.size * -2.93 * param_04;
}

func_0716(param_00) {
  if(param_00 <= 9 && param_00 >= 0) {
    return "0" + param_00;
  }

  return "" + param_00;
}

func_0715(param_00, param_01, param_02) {
  if(isDefined(param_01) == 0) {
    param_01 = 20;
  }

  if(isDefined(param_02) == 0) {
    param_02 = 0;
  }

  var_03 = int(param_00 / param_01);
  var_04 = int(var_03 / 60);
  var_05 = int(var_04 / 60);
  var_06 = int(var_05 / 24);
  var_07 = param_00 % param_01;
  var_08 = var_07 / param_01 * 100;
  var_09 = var_03 % 60;
  var_0A = var_04 % 60;
  var_0B = var_05 % 60;
  var_0C = var_06 % 99;
  var_0D = func_0716(var_07);
  var_0E = func_0716(var_08);
  var_0F = func_0716(var_09);
  var_10 = func_0716(var_0A);
  var_11 = func_0716(var_0B);
  var_12 = func_0716(var_0C);
  var_13 = var_12 + ":" + var_11 + ":" + var_10 + ":" + var_0F;
  if(param_02 == 1) {
    var_13 = var_13 + "." + var_0E;
  } else {
    var_13 = var_13 + ":" + var_0D;
  }

  return var_13;
}

func_0714(param_00, param_01, param_02) {
  if(isDefined(param_00) == 0) {
    param_00 = 0;
  }

  var_03 = param_02 / 20;
  var_04 = param_00;
  var_04 = var_04 + param_01 * var_03;
  var_04 = floor(var_04);
  var_04 = int(var_04);
  return var_04;
}

func_0717(param_00) {
  if(isDefined(param_00) == 0) {
    param_00 = 0;
  }

  var_01 = level.var_5D0.var_3E6B / 20;
  level.var_5D0 endon("sfx_timecode_done");
  level.var_5D0.var_565F = 1;
  level.var_5D0.var_3E71 = 0;
  level.var_5D0.var_52DB = param_00;
  while(isDefined(level.var_5D0) == 1 && level.var_5D0.var_565F == 1) {
    var_02 = level.var_5D0.var_75F6;
    var_03 = level.var_5D0.var_75F7;
    var_04 = 1;
    var_05 = level.var_5D0.fadeovertime;
    var_06 = func_0714(param_00, level.var_5D0.var_3E71, level.var_5D0.var_3E6B);
    var_07 = func_0715(var_06, level.var_5D0.var_3E6B);
    func_8AA0(var_02, var_03, var_07, (1, 1, 1), var_04, var_05, 1);
    if(level.var_5D0.var_6014.size > 0) {
      var_03 = var_03 + var_05 * 12;
      func_8AA0(var_02, var_03, "--------------", (1, 1, 1), var_04, var_05, 1);
      var_03 = var_03 + var_05 * 12;
      foreach(var_09 in level.var_5D0.var_6014) {
        var_0A = var_09[1];
        var_0B = func_0714(param_00, var_09[0], level.var_5D0.var_3E6B);
        var_0C = func_0715(var_0B, level.var_5D0.var_3E6B);
        var_0D = var_0C + " - " + var_0A + "\n";
        func_8AA0(var_02, var_03, var_0D, (1, 1, 1), var_04, var_05, 1);
        var_03 = var_03 + var_05 * 12;
      }
    }

    level.var_5D0.var_3E71 = level.var_5D0.var_3E71 + 1;
    wait 0.05;
  }
}

func_8AC1() {
  if(isDefined(level.var_5D0) == 0) {
    return;
  }

  level.var_5D0 notify("sfx_timecode_done");
  level.var_5D0.var_565F = 0;
  level.var_5D0.var_5848 = 0;
  level.var_5D0.var_6014 = undefined;
  level.var_5D0 = undefined;
}

func_8ABF(param_00) {
  if(isDefined(level.var_5D0) == 0) {
    func_8ABE();
  }

  var_01 = level.var_5D0.var_6014.size;
  level.var_5D0.var_6014[var_01] = [level.var_5D0.var_3E71, param_00];
}

func_8AC0() {
  if(isDefined(level.var_5D0) == 1 && isDefined(level.var_5D0.var_6014) == 1) {
    for(var_00 = 0; var_00 < level.var_5D0.var_6014.size; var_00++) {
      level.var_5D0.var_6014[var_00] = undefined;
    }
  }
}

func_8ABE(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 1;
  if(isDefined(level.var_5D0) == 1) {
    func_8AC1();
  }

  level.var_5D0 = spawnStruct();
  level.var_5D0.var_6014 = [];
  if(isDefined(param_00) == 0) {
    param_00 = 20;
  }

  if(isDefined(param_01) == 0) {
    param_01 = 2;
  }

  param_01 = param_01 / 1;
  var_07 = func_4719();
  var_08 = var_07[0];
  var_09 = var_07[1];
  var_0A = 84 * param_01;
  var_0B = var_08 * 0.5 - var_0A * 0.5;
  var_0C = var_09 * 0.5 - 6;
  if(isDefined(param_02) == 0) {
    param_02 = var_0B;
  }

  if(isDefined(param_03) == 0) {
    var_0D = 192;
    param_03 = var_0C + var_0D;
  }

  level.var_5D0.var_75F6 = param_02;
  level.var_5D0.var_75F7 = param_03;
  level.var_5D0.fadeovertime = param_01;
  level.var_5D0.var_3E6B = param_00;
  level.var_5D0.var_5848 = var_06;
  level.var_5D0.var_A231 = param_04;
  level.var_5D0 thread func_0717(param_05);
}

func_06F2(param_00, param_01, param_02, param_03) {
  if(param_02.size < 2) {
    return;
  }

  var_04 = param_02.size - 1;
  var_05 = 1;
  var_06 = 1 / var_04;
  var_07 = param_00;
  while(var_04 > 0) {
    var_08 = param_02[var_04];
    var_09 = param_02[var_04 - 1];
    if(function_0296(var_08) == 1 && function_0296(var_09) == 1 && var_08 != var_09) {
      if(function_0296(param_03) == 1) {
        var_08 = var_08 + param_03;
        var_09 = var_09 + param_03;
      }
    }

    var_07 = func_A2BB(param_00, var_05 * 1.5);
    var_05 = var_05 - var_06;
    var_04--;
  }
}

func_06F3(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = [];
  var_05[0] = self.origin;
  self endon("sfx_drawpath_stop");
  while(var_05.size > 0) {
    var_06 = [];
    if(var_04 >= param_02) {
      for(var_07 = 1; var_07 < var_05.size; var_07++) {
        var_06[var_07 - 1] = var_05[var_07];
      }
    } else {
      var_06 = var_05;
    }

    if(isDefined(self) == 1 && isDefined(self.origin) == 1 && function_0279(self) == 0) {
      var_06[var_06.size] = self.origin;
    }

    var_05 = var_06;
    func_06F2(param_00, param_01, var_05, param_03);
    var_04++;
    wait 0.05;
  }
}

func_8A7E(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00) == 0) {
    param_00 = (1, 1, 1);
  }

  if(isDefined(param_01) == 0) {
    param_01 = 0;
  }

  if(isDefined(param_02) == 0) {
    param_02 = 5;
  }

  param_02 = int(20 * param_02);
  thread func_06F3(param_00, param_01, param_02, param_03);
}

func_0607(param_00, param_01) {
  var_02 = func_063D();
  var_03 = param_00;
  var_04 = "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params;adsr_name;adsr_zone_npc;adsr_zone_player";
  foreach(var_06 in var_02) {
    var_07 = function_0274(var_06, var_03, var_04);
    if(isarray(var_07) == 1) {
      var_08 = var_07[0];
      var_09 = var_07[1];
      for(var_0A = var_08 + 1; var_0A < var_09; var_0A++) {
        var_0B = tablelookupbyrow(var_06, var_0A, 0);
        if(var_0B == param_01) {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_0636(param_00, param_01, param_02) {
  var_03 = param_01[0];
  var_04 = "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params;adsr_name;adsr_zone_npc;adsr_zone_player";
  var_05 = function_0274(param_00, var_03, var_04);
  if(isarray(var_05) == 1) {
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_08 = [];
    for(var_09 = 0; var_09 < param_01.size; var_09++) {
      var_0A = tablelookup_1(param_00, 0, var_03, var_09, var_06, var_07);
      var_08[var_08.size] = var_0A;
    }

    var_0B = [];
    for(var_09 = var_06 + 1; var_09 < var_07; var_09++) {
      var_0C = tablelookupbyrow(param_00, var_09, 0);
      if((isDefined(param_02) == 1 && var_0C == param_02) || isDefined(param_02) == 0) {
        var_0D = [];
        for(var_0E = 0; var_0E < var_08.size; var_0E++) {
          var_0F = var_08[var_0E];
          var_10 = tablelookupbyrow(param_00, var_09, var_0E);
          var_0D[var_0F] = var_10;
        }

        var_0B[var_0B.size] = var_0D;
      }
    }

    if(var_0B.size > 0) {
      return var_0B;
    }
  }

  return undefined;
}

rvn_audio_include_additional_soundtablefilenames(param_00) {
  level._audioadditionalsountablefiles[param_00] = param_00;
}

func_063D() {
  var_00 = [];
  var_00[0] = "soundtables/" + level.script + ".csv";
  if(isDefined(level.var_579A) == 1 && level.var_579A == 1 && isDefined(level.var_79C2) == 1) {
    var_00[var_00.size] = "soundtables/mp_raid_defaults.csv";
  }

  if(common_scripts\utility::issp() == 1) {
    var_00[var_00.size] = "soundtables/sp_defaults.csv";
  } else {
    var_00[var_00.size] = "soundtables/mp_defaults.csv";
  }

  if(isDefined(level._audioadditionalsountablefiles)) {
    foreach(var_02 in level._audioadditionalsountablefiles) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_063C(param_00, param_01) {
  var_02 = func_063D();
  var_03 = [];
  foreach(var_05 in var_02) {
    var_03[var_03.size] = func_0636(var_05, param_00, param_01);
  }

  if(var_03.size > 0) {
    return var_03;
  }

  return undefined;
}

func_94CA(param_00) {
  var_01 = func_0607("mix_names", param_00);
  return var_01;
}

func_46B9(param_00) {
  var_01 = ["mix_names", "volmod", "value", "fadein", "fadeout"];
  return func_063C(var_01, param_00);
}

func_0711(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self;
  var_05 notify("sfx_submix_envelope_" + param_00);
  var_05 endon("death");
  var_05 endon("disconnect");
  var_05 endon("sfx_submix_envelope_" + param_00);
  if(isDefined(param_04) == 0) {
    param_04 = 1;
  }

  var_05 setaltsceneobj(param_00, 0);
  var_05 method_8629(param_00, 0, 0);
  wait 0.05;
  var_05 method_8629(param_00, param_04, param_01);
  wait(param_01);
  wait(param_02);
  var_05 method_8629(param_00, 0, param_03);
  wait(param_03);
  waittillframeend;
  var_05 method_8627(param_00);
}

func_8AB8(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_05) == 0) {
    if(common_scripts\utility::issp() == 1) {
      param_05 = [level.player];
    } else if(isDefined(level.players) == 1) {
      param_05 = level.players;
    }
  }

  foreach(var_07 in param_05) {
    var_07 func_0711(param_00, param_01, param_02, param_03, param_04);
  }
}

func_42DD(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 2;
  }

  if(!isDefined(level.var_5A9)) {
    level.var_5A9 = [];
  }

  if(!isDefined(level.var_5A9[param_01])) {
    level.var_5A9[param_01] = common_scripts\utility::array_randomize(getarraykeys(param_00));
  }

  if(level.var_5A9[param_01].size <= param_02) {
    var_03 = common_scripts\utility::array_randomize(common_scripts\utility::func_F94(getarraykeys(param_00), level.var_5A9[param_01]));
    level.var_5A9[param_01] = common_scripts\utility::func_F73(var_03, level.var_5A9[param_01]);
  }

  var_04 = level.var_5A9[param_01][level.var_5A9[param_01].size - 1];
  level.var_5A9[param_01][level.var_5A9[param_01].size - 1] = undefined;
  return param_00[var_04];
}

func_7FF8(param_00, param_01) {
  var_02 = self.origin;
  var_03 = self.angles;
  var_04 = "r";
  var_05 = "default";
  if(isDefined(param_00) && param_00) {
    var_04 = "l";
  }

  var_06 = "step_";
  if(isDefined(param_01) && param_01) {
    var_06 = var_06 + "run_";
  } else {
    var_06 = var_06 + "walk_";
  }

  if(isPlayer(self) == 1) {
    var_06 = var_06 + "plr_";
  } else {
    var_07 = "J_Ball_RI";
    var_08 = 180;
    if(param_00) {
      var_07 = "J_Ball_LE";
      var_08 = 0;
    }

    if(self method_8445(var_07) >= 0) {
      var_02 = self gettagorigin(var_07);
    }
  }

  var_09 = bulletTrace(var_02 + (0, 0, 0), var_02 + (0, 0, -64), 0);
  if(var_09["fraction"] < 1 && var_09["fraction"] > 0 && var_09["surfacetype"] != "none") {
    var_05 = var_09["surfacetype"];
    var_02 = var_09["position"];
    var_0A = var_06 + var_05;
    if(isPlayer(self) == 1) {
      var_0A = var_0A + "_" + var_04;
    }

    if(function_0344(var_0A) == 0) {
      var_05 = "default";
    }
  }

  var_06 = var_06 + var_05;
  if(isPlayer(self) == 1) {
    var_06 = var_06 + "_" + var_04;
  }

  if(function_0344(var_06) == 0) {
    return;
  }

  lib_02F0::func_800A(var_06, var_02);
}

func_8D6A(param_00, param_01) {
  if(param_01 != "" && isstring(param_01) == 1) {
    func_7FE5(1, "level notify( \" + param_01 + "\" )");
    level notify(param_01);
  }

  return "";
}

func_8DE6(param_00, param_01) {
  var_02 = "snd_enveffectsprio_shellshock";
  var_03 = strtok(param_01, " ");
  var_04 = 1;
  var_05 = 1;
  var_06 = 0.05;
  var_07 = "default";
  var_08 = ["alcove_carpet", "alcove_concrete", "alcove_marble", "alcove_metal", "alcove_wood", "alley", "bridge_ext", "bunker_concrete", "canyon", "cargo_container_sml", "cave", "city_street", "courtyard", "default", "elevator", "elevator_shaft", "field", "hall_carpet", "hall_concrete", "hall_marble", "hall_metal", "hall_wood", "hallway_carpet", "hallway_concrete", "hallway_concrete_lrg", "hallway_marble", "hallway_metal", "hallway_wood", "hangar", "mountains", "near_death", "parking_lot", "rooftop", "room_carpet", "room_concrete", "room_marble", "room_metal", "room_wood", "sewer", "stairwell", "tunnel", "underpass", "underwater", "veh_int"];
  if(isDefined(var_03[0]) == 1) {
    var_09 = var_03[0];
    if(var_09 == "0" || int(var_09) > 0) {
      var_0A = int(var_09) % var_08.size;
      var_07 = var_08[var_0A];
    } else if(int(var_09) >= 0) {
      var_07 = var_09;
    }
  }

  if(isDefined(var_03[1]) == 1) {
    var_05 = float(var_03[1]);
  }

  if(isDefined(var_03[2]) == 1) {
    var_04 = float(var_03[2]);
  }

  if(param_01 == "" || int(param_01) < 0) {
    level.player method_8632(var_02, var_06);
    iprintlnbold("xxxx REVERB DEACTIVATED xxxx");
    param_01 = "";
  } else {
    level.player method_8631(var_02, var_07, var_04, var_05, var_06);
    iprintlnbold("Reverb: " + var_07 + " Wet: " + var_05 + " Dry: " + var_04);
  }

  return param_01;
}

func_071E() {
  var_00 = self;
  var_00 endon("stop_crosshair3D");
  for(;;) {
    var_01 = var_00 getEye();
    var_02 = var_00 geteyeangles();
    var_03 = anglesToForward(var_02);
    var_04 = anglestoright(var_02);
    var_05 = var_01 + var_03 * 8192;
    var_06 = bulletTrace(var_01, var_05, 1, var_00, 1, 1);
    if(isDefined(var_06) == 1 && isDefined(var_06["position"]) == 1 && var_06["position"] != var_01) {
      var_07 = var_06["position"];
      var_08 = var_06["surfacetype"];
      var_09 = "( " + var_07[0] + ", " + var_07[1] + ", " + var_07[2] + " )";
      var_0A = distance(var_07, var_01);
      var_0B = var_0A * 0.002;
      var_0C = 1 * var_0B;
      func_2B50(var_07, 4, (0, 0, 0), (1, 1, 1), 1, 1);
      var_0D = -1.5 * var_0C * 12;
      func_8AA6(var_07 + (0, 0, var_0D), var_09, (1, 1, 1), 1, var_0C, 1, var_04);
      if(isDefined(var_08) == 1) {
        var_0E = "" + var_08 + "";
        var_0F = 1 + abs(var_03[2]);
        var_0D = -3 * var_0F * var_0C * 12;
        func_8AA6(var_07 + (0, 0, var_0D), var_0E, func_A2BB((1, 1, 1), 0.666), 0.666, var_0C, 1, var_04);
      }
    }

    wait 0.05;
  }
}

func_8D1F(param_00, param_01) {
  var_02 = int(param_01);
  foreach(var_04 in level.players) {
    if(var_02 > 0) {
      var_04 thread func_071E();
      continue;
    }

    var_04 notify("stop_crosshair3D");
  }

  return param_01;
}

func_8DC9(param_00, param_01) {
  common_scripts\_createfx::func_646();
  return "";
}

func_8DCA(param_00, param_01) {
  level._createfx.selected_fx_ents = [];
  for(var_02 = 0; var_02 < level.createfxent.size; var_02++) {
    var_03 = level.createfxent[var_02];
    if(isDefined(var_03.v["type"]) == 0) {
      continue;
    }

    if(isDefined(var_03.v["origin"]) == 1 && common_scripts\utility::string_starts_with(var_03.v["type"], "soundfx") == 1) {
      var_04 = var_03.v["origin"];
      var_05 = (270, 0, 0);
      var_04 = (floor(var_04[0]), floor(var_04[1]), floor(var_04[2]));
      var_03.v["angles"] = var_05;
      var_03.v["origin"] = var_04;
      level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_03;
    }
  }

  common_scripts\_createfx::update_selected_ents();
  level._createfx.selected_fx_ents = [];
  return "";
}