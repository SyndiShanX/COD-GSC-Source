/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_vehicle.gsc
*********************************************/

func_1D1D(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_A2F4)) {
    level.var_A2F4 = [];
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = (0, 0, 0);
  }

  var_06 = spawnStruct();
  var_06.var_6A15 = param_00;
  var_06.var_7A63 = param_01;
  var_06.var_607B = param_02;
  var_06.var_61BD = param_03;
  var_06.var_176E = param_04;
  var_06.var_2CAC = param_05;
  level.var_A2F4[level.var_A635] = var_06;
}

func_1D20(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_A3A1)) {
    level.var_A3A1 = [];
  }

  var_06 = func_1D1C(param_01, param_02, param_03, param_04, param_05);
  precacherumble(param_00);
  var_06.var_7F47 = param_00;
  level.var_A3A1[level.var_A635] = var_06;
}

func_1D02(param_00, param_01, param_02) {
  var_03 = level.var_A635;
  if(!isDefined(level.var_A2F0)) {
    level.var_A2F0 = [];
  }

  level.var_A2F0[var_03] = func_1D1C(param_00, param_01, param_02);
}

func_1D1C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.var_807E = param_00;
  var_05.var_3511 = param_01;
  var_05.var_14F = param_02;
  if(isDefined(param_03)) {
    var_05.var_162F = param_03;
  }

  if(isDefined(param_04)) {
    var_05.var_7A47 = param_04;
  }

  return var_05;
}

func_1D0B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  var_0B = spawnStruct();
  var_0B.var_359B = loadfx(param_00);
  var_0B.var_95A6 = param_01;
  var_0B.var_8F2C = param_02;
  var_0B.var_1CD7 = param_05;
  var_0B.var_2CAC = param_04;
  var_0B.var_A68B = param_06;
  var_0B.var_9340 = param_07;
  var_0B.var_6810 = param_08;
  var_0B.var_16FE = param_03;
  var_0B.var_83C2 = param_09;
  var_0B.var_7C80 = param_0A;
  return var_0B;
}

func_1CFE(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = level.var_A635;
  if(func_55D1(var_0B)) {
    return;
  }

  if(!isDefined(level.var_A2F1[var_0B])) {
    level.var_A2F1[var_0B] = [];
  }

  level.var_A2F1[var_0B][level.var_A2F1[var_0B].size] = func_1D0B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_55D1(param_00) {
  if(!isDefined(level.var_A2F2)) {
    return 0;
  }

  if(!isDefined(level.var_A2F2[param_00])) {
    return 0;
  }

  if(isDefined(level.var_A638)) {
    return 1;
  }

  return level.var_A2F2[param_00];
}

func_1D14(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_A362)) {
    level.var_A362 = [];
  }

  if(!isDefined(level.var_A364)) {
    level.var_A364 = [];
  }

  if(isDefined(level.var_A364[param_04]) && !level.var_A638) {
    return;
  }

  var_06 = spawnStruct();
  var_06.var_109 = param_01;
  var_06.var_95A6 = param_02;
  var_06.var_2CAC = param_05;
  var_06.var_359B = loadfx(param_03);
  level.var_A362[param_00][param_01] = var_06;
  maps\mp\gametypes\_vehicle_code::func_4890(param_00, param_01, "all");
  if(isDefined(param_04)) {
    maps\mp\gametypes\_vehicle_code::func_4890(param_00, param_01, param_04);
  }
}

func_1D01(param_00, param_01, param_02, param_03) {
  if(param_00 != level.var_A637 && level.var_A637 != "script_model") {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  precachemodel(param_00);
  precachemodel(param_01);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    level.var_A2F8[param_00] = param_01;
    level.var_A2F9[param_00] = param_02;
    return;
  }

  level.var_A2F8[param_03] = param_01;
  level.var_A2F9[param_03] = param_02;
}

func_1D26(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_15D)) {
    level.var_15D = tolower(getDvar("1673"));
  }

  if(isDefined(param_02)) {
    param_00 = param_02;
  }

  if(!isDefined(level.var_A2F1)) {
    level.var_A2F1 = [];
  }

  if(!isDefined(level.var_A2EE)) {
    level.var_A2EE = [];
  }

  if(!isDefined(level.var_A2F1[param_03])) {
    level.var_A2F1[param_03] = [];
  }

  level.var_A3C9[param_03] = "axis";
  level.var_A35D[param_03] = 999;
  level.var_A339[param_01] = 0;
  level.var_A370[param_01] = [];
  level.var_A637 = param_01;
  level.var_A639 = param_00;
  level.var_A635 = param_03;
}

func_1CFA(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  for(var_07 = 0; var_07 < param_00.size; var_07++) {}

  if(!isDefined(param_04)) {
    param_04 = level.var_A635;
  }

  var_08 = spawnStruct();
  var_08.var_ACB7 = param_02;
  var_08.var_ACB5 = param_03;
  var_08.var_ACB4 = param_01;
  var_08.var_ACB6 = [];
  var_08.zones_effect_lists_debug = [];
  foreach(var_0A in param_00) {
    var_0B = var_08.var_ACB6.size;
    var_08.var_ACB6[var_0B] = [];
    var_08.zones_effect_lists_debug[var_0B] = [];
    foreach(var_0D in var_0A) {
      var_0E = var_08.var_ACB6[var_0B].size;
      var_08.var_ACB6[var_0B][var_0E] = loadfx(var_0D);
      var_08.zones_effect_lists_debug[var_0B][var_0E] = var_0D;
    }
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_08.var_29AE = param_05;
  var_08.var_29AF = param_06;
  var_08.var_2F3D = 1;
  level.var_A2EC[param_04] = var_08;
}

func_1D13(param_00, param_01, param_02) {
  var_03 = level.var_A635;
  level.var_A35D[var_03] = param_00;
  level.var_A35F[var_03] = param_01;
  level.var_A35E[var_03] = param_02;
}

func_1D16(param_00) {
  level.var_A3F5[level.var_A639][level.var_A635] = param_00;
}

func_A366(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  maps\mp\gametypes\_vehicle_code::func_5D77(param_00, param_01);
}

func_A365(param_00, param_01) {
  maps\mp\gametypes\_vehicle_code::func_5D75(param_00, param_01);
}

func_A3B5(param_00) {
  if(!isDefined(self) || !isDefined(self.var_3A) || !isDefined(param_00)) {
    return;
  }

  if(!isDefined(level.var_A362[self.var_3A])) {
    return;
  }

  var_01 = level.var_A362[self.var_3A][param_00];
  if(!isDefined(var_01)) {
    return;
  }

  if(isDefined(var_01.var_2CAC)) {
    var_02 = var_01.var_2CAC;
  } else {
    var_02 = 0;
  }

  self endon("death");
  childthread common_scripts\utility::func_6755(::playfxontag, var_02, var_01.var_359B, self, var_01.var_95A6);
  self.var_5D72[param_00] = 1;
}

func_A3B4(param_00) {
  if(!isDefined(self.var_5D72)) {
    return;
  }

  if(!isDefined(self.var_5D72[param_00])) {
    return;
  }

  var_01 = level.var_A362[self.var_3A][param_00];
  if(!isDefined(var_01)) {
    return;
  }

  stopFXOnTag(var_01.var_359B, self, var_01.var_95A6);
  self.var_5D72[param_00] = undefined;
}

func_A320() {
  if(isDefined(self.var_4C17)) {
    return self.var_BC - self.var_4C17;
  }

  return self.var_BC;
}

func_A321() {
  if(isDefined(self.var_4C17)) {
    return self.var_FB - self.var_4C17;
  }

  return self.var_FB;
}