/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2965.gsc
************************/

func_31B3(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = (0, 0, 0);
  }

  var_06 = spawnStruct();
  var_06.offset = param_00;
  var_06.var_DCCA = param_01;
  var_06.var_B48B = param_02;
  var_06.var_B758 = param_03;
  var_06.var_2B19 = param_04;
  var_06.delay = param_05;
  level.vehicle.var_116CE.var_4E1C[level.var_13570] = var_06;
}

func_31B8(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.vehicle.var_116CE.var_E7BA)) {
    level.vehicle.var_116CE.var_E7BA = [];
  }

  var_06 = func_31B2(param_01, param_02, param_03, param_04, param_05);
  precacherumble(param_00);
  var_06.var_E7BA = param_00;
  level.vehicle.var_116CE.var_E7BA[level.var_13570] = var_06;
}

func_3187(param_00, param_01, param_02) {
  var_03 = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_4E02)) {
    level.vehicle.var_116CE.var_4E02 = [];
  }

  level.vehicle.var_116CE.var_4E02[var_03] = func_31B2(param_00, param_01, param_02);
}

func_31B2(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.var_EB9C = param_00;
  var_05.var_5F36 = param_01;
  var_05.fgetarg = param_02;
  if(isDefined(param_03)) {
    var_05.var_28AE = param_03;
  }

  if(isDefined(param_04)) {
    var_05.var_DCA5 = param_04;
  }

  return var_05;
}

func_3197(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  var_0C = spawnStruct();
  var_0C.effect = loadfx(param_00);
  var_0C.physics_setgravitydynentscalar = param_01;
  var_0C.sound = param_02;
  var_0C.var_312E = param_05;
  var_0C.delay = param_04;
  var_0C.var_136A1 = param_06;
  var_0C.var_10E6A = param_07;
  var_0C.var_C174 = param_08;
  var_0C.var_2A4E = param_03;
  var_0C.var_F1EA = param_09;
  var_0C.var_DFEC = param_0A;
  var_0C.var_24DF = param_0B;
  return var_0C;
}

func_3184(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_131BC[var_0C])) {
    level.vehicle.var_116CE.var_131BC[var_0C] = [];
  }

  level.vehicle.var_116CE.var_131BC[var_0C][level.vehicle.var_116CE.var_131BC[var_0C].size] = func_3197(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_3183(param_00) {
  var_01 = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_4DF9[var_01])) {
    level.vehicle.var_116CE.var_4DF9[var_01] = [];
  }

  level.vehicle.var_116CE.var_4DF9[var_01] = param_00;
}

func_31B7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = level.var_13570;
  level.var_13570 = "rocket_death" + var_0B;
  func_3184(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  level.var_13570 = var_0B;
}

func_31A2(param_00) {
  var_01 = level.var_13570;
  level.vehicle.var_116CE.var_A7C5[var_01] = [
    [param_00]
  ]();
}

func_31C8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(level.vehicle.var_116CE.mgturret)) {
    level.vehicle.var_116CE.mgturret = [];
  }

  var_0A = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.mgturret[var_0A])) {
    level.vehicle.var_116CE.mgturret[var_0A] = [];
  }

  precachemodel(param_02);
  precacheturret(param_00);
  var_0B = spawnStruct();
  var_0B.info = param_00;
  var_0B.physics_setgravitydynentscalar = param_01;
  var_0B.model = param_02;
  var_0B.setthreatbiasagainstall = param_03;
  var_0B.var_5041 = param_04;
  var_0B.var_51AD = param_05;
  var_0B.var_5035 = param_06;
  var_0B.var_5036 = param_07;
  if(isDefined(param_08)) {
    var_0B.var_C367 = param_08;
  }

  if(isDefined(param_09)) {
    var_0B.var_DE46 = param_09;
  }

  level.vehicle.var_116CE.mgturret[var_0A][level.vehicle.var_116CE.mgturret[var_0A].size] = var_0B;
}

func_31A4(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.vehicle.var_116CE.var_13208)) {
    level.vehicle.var_116CE.var_13208 = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_1320A)) {
    level.vehicle.var_116CE.var_1320A = [];
  }

  if(isDefined(level.vehicle.var_116CE.var_1320A[param_04]) && !level.var_13574) {
    return;
  }

  var_06 = spawnStruct();
  var_06.name = param_01;
  var_06.physics_setgravitydynentscalar = param_02;
  var_06.delay = param_05;
  var_06.effect = loadfx(param_03);
  level.vehicle.var_116CE.var_13208[param_00][param_01] = var_06;
  scripts\sp\vehicle_lights::func_8695(param_00, param_01, "all");
  if(isDefined(param_04)) {
    scripts\sp\vehicle_lights::func_8695(param_00, param_01, param_04);
  }
}

func_319B(param_00, param_01) {
  if(!isDefined(level.vehicle.var_116CE.var_8E9D)) {
    level.vehicle.var_116CE.var_8E9D = [];
  }

  level.vehicle.var_116CE.var_8E9D[param_00] = param_01;
}

func_3186(param_00, param_01, param_02, param_03) {
  if(param_00 != level.var_13571) {
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
    level.vehicle.var_116CE.var_4E4E[param_00] = param_01;
    level.vehicle.var_131C3[param_00] = param_02;
    return;
  }

  level.vehicle.var_116CE.var_4E4E[param_03] = param_01;
  level.vehicle.var_131C3[param_03] = param_02;
}

func_319D(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_92D0)) {
    level.vehicle.var_116CE.var_92D0 = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_92D0[level.var_13571])) {
    level.vehicle.var_116CE.var_92D0[level.var_13571] = [];
  }

  level.vehicle.var_116CE.var_92D0[level.var_13571][level.vehicle.var_116CE.var_92D0[level.var_13571].size] = param_00;
}

func_318B(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 10;
  }

  level.vehicle.var_116CE.var_5BC3[level.var_13571] = param_00;
  if(isDefined(param_01)) {
    level.vehicle.var_116CE.var_5BC6[level.var_13571] = param_01;
  }

  level.vehicle.var_116CE.var_5BC5[level.var_13571] = param_02;
  if(isDefined(param_03)) {
    level.vehicle.var_116CE.var_5BC4[level.var_13571] = param_03;
  }
}

func_31C5(param_00, param_01, param_02, param_03) {
  scripts\sp\utility::func_965C();
  scripts\sp\vehicle_code::func_F9C7();
  if(isDefined(param_02)) {
    param_00 = param_02;
  }

  precachevehicle(param_00);
  level.vehicle.var_116CE.team[param_03] = "axis";
  level.vehicle.var_116CE.var_AC4A[param_03] = 999;
  level.vehicle.var_116CE.var_8B8F[param_01] = 0;
  level.vehicle.var_116CE.var_B243[param_01] = [];
  level.var_13571 = param_01;
  level.var_13575 = param_00;
  level.var_13570 = param_03;
}

func_3194(param_00) {
  level.vehicle.var_116CE.var_693A[level.var_13571] = loadfx(param_00);
}

func_31C6(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00)) {
    func_F5FB(param_00, param_01, param_02);
    if(isDefined(param_03) && param_03) {
      func_F5FB(param_00, param_01, param_02, "_bank");
      func_F5FB(param_00, param_01, param_02, "_bank_lg");
      return;
    }

    return;
  }

  param_00 = level.var_13570;
  scripts\sp\treadfx::main(param_00);
}

build_aianims(param_00, param_01) {
  var_02 = func_7CC6();
  foreach(var_04 in var_02) {
    func_F5FB(param_00, var_04);
  }
}

func_F5FB(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.vehicle.var_116CE.var_112D9)) {
    level.vehicle.var_116CE.var_112D9 = [];
  }

  if(isDefined(param_03)) {
    param_01 = param_01 + param_03;
    param_02 = param_02 + param_03;
  }

  if(isDefined(param_02)) {
    level.vehicle.var_116CE.var_112D9[param_00][param_01] = loadfx(param_02);
    return;
  }

  if(isDefined(level.vehicle.var_116CE.var_112D9[param_00]) && isDefined(level.vehicle.var_116CE.var_112D9[param_00][param_01])) {
    level.vehicle.var_116CE.var_112D9[param_00][param_01] = undefined;
  }
}

func_7CC6() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

func_31C4(param_00) {
  level.vehicle.var_116CE.team[level.var_13570] = param_00;
}

func_31A9(param_00, param_01, param_02, param_03) {
  level.vehicle.var_116CE.var_8B8F[level.var_13571] = 1;
  if(isDefined(param_00)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][param_00] = 1;
  }

  if(isDefined(param_01)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][param_01] = 1;
  }

  if(isDefined(param_02)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][param_02] = 1;
  }

  if(isDefined(param_03)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][param_03] = 1;
  }
}

build_bulletshield(param_00) {
  level.vehicle.var_116CE.var_323D[level.var_13570] = param_00;
}

func_3198(param_00) {
  level.vehicle.var_116CE.missileoutline[level.var_13570] = param_00;
}

build_ace(param_00, param_01) {
  var_02 = level.var_13570;
  level.vehicle.var_116CE.var_1A03[var_02] = [
    [param_00]
  ]();
  if(isDefined(param_01)) {
    level.vehicle.var_116CE.var_1A03[var_02] = [[param_01]](level.vehicle.var_116CE.var_1A03[var_02]);
  }
}

func_3196(param_00) {
  level.vehicle.var_116CE.var_7448[level.var_13570] = param_00;
}

build_atmo_types(param_00) {
  level.vehicle.var_116CE.var_247D[level.var_13570] = [
    [param_00]
  ]();
}

func_31CC(param_00) {
  level.vehicle.var_116CE.var_12BCF[level.var_13570] = [
    [param_00]
  ]();
}

func_31A3(param_00, param_01, param_02) {
  var_03 = level.var_13570;
  level.vehicle.var_116CE.var_AC4A[var_03] = param_00;
  level.vehicle.var_116CE.var_AC4D[var_03] = param_01;
  level.vehicle.var_116CE.var_AC4C[var_03] = param_02;
}

func_3188(param_00) {
  level.vehicle.var_116CE.var_4F6B[level.var_13571] = loadfx(param_00);
}

func_3189(param_00, param_01) {}

func_31A6(param_00) {
  level.var_13261[level.var_13575][level.var_13570] = param_00;
}

func_31AC(param_00) {
  level.vehicle.var_116CE.var_1325B[level.var_13570] = param_00;
}

build_all_treadfx(param_00, param_01) {
  level.vehicle.var_116CE.var_2427[level.var_13570]["atmo"] = param_00;
  level.vehicle.var_116CE.var_2427[level.var_13570]["space"] = param_01;
}

bugoutontimeout(param_00) {
  level.vehicle.var_116CE.var_155C[level.var_13570] = param_00;
}

func_31BF(param_00) {
  level.vehicle.var_116CE.var_F216[level.var_13570] = param_00;
}

func_31B0(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_D375 = param_00;
  var_02.var_13DCB = param_01;
  precachemodel(param_00);
  level.vehicle.var_116CE.var_13265[level.var_13570] = var_02;
}

func_3181(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.vehicle.var_116CE.var_4DFC)) {
    level.vehicle.var_116CE.var_4DFC = [];
  }

  var_06 = spawnStruct();
  var_06.delay = param_00;
  var_06.var_5F36 = param_01;
  var_06.height = param_02;
  var_06.fgetarg = param_03;
  var_06.var_115A4 = param_04;
  var_06.var_115A5 = param_05;
  level.vehicle.var_116CE.var_4DFC[level.var_13570] = var_06;
}

func_31A0(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_8DB1)) {
    level.vehicle.var_116CE.var_8DB1 = [];
  }

  if(!isDefined(param_00)) {
    param_00 = level.var_13575;
  }

  level.vehicle.var_116CE.var_8DB1[param_00] = 1;
}

func_319F(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_1AE5)) {
    level.vehicle.var_116CE.var_1AE5 = [];
  }

  if(!isDefined(param_00)) {
    param_00 = level.var_13575;
  }

  level.vehicle.var_116CE.var_1AE5[param_00] = 1;
}

func_31C2(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_1020A)) {
    level.vehicle.var_116CE.var_1020A = [];
  }

  if(!isDefined(param_00)) {
    param_00 = level.var_13575;
  }

  level.vehicle.var_116CE.var_1020A[param_00] = 1;
}

func_31B6(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_E4F9)) {
    level.vehicle.var_116CE.var_E4F9 = [];
  }

  level.vehicle.var_116CE.var_E4F9[level.var_13570] = param_00;
}