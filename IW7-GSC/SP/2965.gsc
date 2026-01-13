/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2965.gsc
************************/

func_31B3(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_6 = spawnStruct();
  var_6.offset = var_0;
  var_6.var_DCCA = var_1;
  var_6.var_B48B = var_2;
  var_6.var_B758 = var_3;
  var_6.var_2B19 = var_4;
  var_6.delay = var_5;
  level.vehicle.var_116CE.var_4E1C[level.var_13570] = var_6;
}

func_31B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.var_116CE.var_E7BA)) {
    level.vehicle.var_116CE.var_E7BA = [];
  }

  var_6 = func_31B2(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.var_E7BA = var_0;
  level.vehicle.var_116CE.var_E7BA[level.var_13570] = var_6;
}

func_3187(var_0, var_1, var_2) {
  var_3 = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_4E02)) {
    level.vehicle.var_116CE.var_4E02 = [];
  }

  level.vehicle.var_116CE.var_4E02[var_3] = func_31B2(var_0, var_1, var_2);
}

func_31B2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.var_EB9C = var_0;
  var_5.var_5F36 = var_1;
  var_5.fgetarg = var_2;
  if(isDefined(var_3)) {
    var_5.var_28AE = var_3;
  }

  if(isDefined(var_4)) {
    var_5.var_DCA5 = var_4;
  }

  return var_5;
}

func_3197(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_0C = spawnStruct();
  var_0C.effect = loadfx(var_0);
  var_0C.physics_setgravitydynentscalar = var_1;
  var_0C.sound = var_2;
  var_0C.var_312E = var_5;
  var_0C.delay = var_4;
  var_0C.var_136A1 = var_6;
  var_0C.var_10E6A = var_7;
  var_0C.var_C174 = var_8;
  var_0C.var_2A4E = var_3;
  var_0C.var_F1EA = var_9;
  var_0C.var_DFEC = var_0A;
  var_0C.var_24DF = var_0B;
  return var_0C;
}

func_3184(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_131BC[var_0C])) {
    level.vehicle.var_116CE.var_131BC[var_0C] = [];
  }

  level.vehicle.var_116CE.var_131BC[var_0C][level.vehicle.var_116CE.var_131BC[var_0C].size] = func_3197(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

func_3183(var_0) {
  var_1 = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.var_4DF9[var_1])) {
    level.vehicle.var_116CE.var_4DF9[var_1] = [];
  }

  level.vehicle.var_116CE.var_4DF9[var_1] = var_0;
}

func_31B7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  var_0B = level.var_13570;
  level.var_13570 = "rocket_death" + var_0B;
  func_3184(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  level.var_13570 = var_0B;
}

func_31A2(var_0) {
  var_1 = level.var_13570;
  level.vehicle.var_116CE.var_A7C5[var_1] = [[var_0]]();
}

func_31C8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.vehicle.var_116CE.mgturret)) {
    level.vehicle.var_116CE.mgturret = [];
  }

  var_0A = level.var_13570;
  if(!isDefined(level.vehicle.var_116CE.mgturret[var_0A])) {
    level.vehicle.var_116CE.mgturret[var_0A] = [];
  }

  precachemodel(var_2);
  precacheturret(var_0);
  var_0B = spawnStruct();
  var_0B.info = var_0;
  var_0B.physics_setgravitydynentscalar = var_1;
  var_0B.model = var_2;
  var_0B.setthreatbiasagainstall = var_3;
  var_0B.var_5041 = var_4;
  var_0B.var_51AD = var_5;
  var_0B.var_5035 = var_6;
  var_0B.var_5036 = var_7;
  if(isDefined(var_8)) {
    var_0B.var_C367 = var_8;
  }

  if(isDefined(var_9)) {
    var_0B.var_DE46 = var_9;
  }

  level.vehicle.var_116CE.mgturret[var_0A][level.vehicle.var_116CE.mgturret[var_0A].size] = var_0B;
}

func_31A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.var_116CE.var_13208)) {
    level.vehicle.var_116CE.var_13208 = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_1320A)) {
    level.vehicle.var_116CE.var_1320A = [];
  }

  if(isDefined(level.vehicle.var_116CE.var_1320A[var_4]) && !level.var_13574) {
    return;
  }

  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.physics_setgravitydynentscalar = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle.var_116CE.var_13208[var_0][var_1] = var_6;
  scripts\sp\vehicle_lights::func_8695(var_0, var_1, "all");
  if(isDefined(var_4)) {
    scripts\sp\vehicle_lights::func_8695(var_0, var_1, var_4);
  }
}

func_319B(var_0, var_1) {
  if(!isDefined(level.vehicle.var_116CE.var_8E9D)) {
    level.vehicle.var_116CE.var_8E9D = [];
  }

  level.vehicle.var_116CE.var_8E9D[var_0] = var_1;
}

func_3186(var_0, var_1, var_2, var_3) {
  if(var_0 != level.var_13571) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  precachemodel(var_0);
  precachemodel(var_1);
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    level.vehicle.var_116CE.var_4E4E[var_0] = var_1;
    level.vehicle.var_131C3[var_0] = var_2;
    return;
  }

  level.vehicle.var_116CE.var_4E4E[var_3] = var_1;
  level.vehicle.var_131C3[var_3] = var_2;
}

func_319D(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_92D0)) {
    level.vehicle.var_116CE.var_92D0 = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_92D0[level.var_13571])) {
    level.vehicle.var_116CE.var_92D0[level.var_13571] = [];
  }

  level.vehicle.var_116CE.var_92D0[level.var_13571][level.vehicle.var_116CE.var_92D0[level.var_13571].size] = var_0;
}

func_318B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  level.vehicle.var_116CE.var_5BC3[level.var_13571] = var_0;
  if(isDefined(var_1)) {
    level.vehicle.var_116CE.var_5BC6[level.var_13571] = var_1;
  }

  level.vehicle.var_116CE.var_5BC5[level.var_13571] = var_2;
  if(isDefined(var_3)) {
    level.vehicle.var_116CE.var_5BC4[level.var_13571] = var_3;
  }
}

func_31C5(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::func_965C();
  scripts\sp\vehicle_code::func_F9C7();
  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  precachevehicle(var_0);
  level.vehicle.var_116CE.team[var_3] = "axis";
  level.vehicle.var_116CE.var_AC4A[var_3] = 999;
  level.vehicle.var_116CE.var_8B8F[var_1] = 0;
  level.vehicle.var_116CE.var_B243[var_1] = [];
  level.var_13571 = var_1;
  level.var_13575 = var_0;
  level.var_13570 = var_3;
}

func_3194(var_0) {
  level.vehicle.var_116CE.var_693A[level.var_13571] = loadfx(var_0);
}

func_31C6(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    func_F5FB(var_0, var_1, var_2);
    if(isDefined(var_3) && var_3) {
      func_F5FB(var_0, var_1, var_2, "_bank");
      func_F5FB(var_0, var_1, var_2, "_bank_lg");
      return;
    }

    return;
  }

  var_0 = level.var_13570;
  scripts\sp\treadfx::main(var_0);
}

build_aianims(var_0, var_1) {
  var_2 = func_7CC6();
  foreach(var_4 in var_2) {
    func_F5FB(var_0, var_4);
  }
}

func_F5FB(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.var_116CE.var_112D9)) {
    level.vehicle.var_116CE.var_112D9 = [];
  }

  if(isDefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;
  }

  if(isDefined(var_2)) {
    level.vehicle.var_116CE.var_112D9[var_0][var_1] = loadfx(var_2);
    return;
  }

  if(isDefined(level.vehicle.var_116CE.var_112D9[var_0]) && isDefined(level.vehicle.var_116CE.var_112D9[var_0][var_1])) {
    level.vehicle.var_116CE.var_112D9[var_0][var_1] = undefined;
  }
}

func_7CC6() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

func_31C4(var_0) {
  level.vehicle.var_116CE.team[level.var_13570] = var_0;
}

func_31A9(var_0, var_1, var_2, var_3) {
  level.vehicle.var_116CE.var_8B8F[level.var_13571] = 1;
  if(isDefined(var_0)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][var_0] = 1;
  }

  if(isDefined(var_1)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][var_1] = 1;
  }

  if(isDefined(var_2)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][var_2] = 1;
  }

  if(isDefined(var_3)) {
    level.vehicle.var_116CE.var_B243[level.var_13571][var_3] = 1;
  }
}

build_bulletshield(var_0) {
  level.vehicle.var_116CE.var_323D[level.var_13570] = var_0;
}

func_3198(var_0) {
  level.vehicle.var_116CE.missileoutline[level.var_13570] = var_0;
}

build_ace(var_0, var_1) {
  var_2 = level.var_13570;
  level.vehicle.var_116CE.var_1A03[var_2] = [[var_0]]();
  if(isDefined(var_1)) {
    level.vehicle.var_116CE.var_1A03[var_2] = [[var_1]](level.vehicle.var_116CE.var_1A03[var_2]);
  }
}

func_3196(var_0) {
  level.vehicle.var_116CE.var_7448[level.var_13570] = var_0;
}

build_atmo_types(var_0) {
  level.vehicle.var_116CE.var_247D[level.var_13570] = [[var_0]]();
}

func_31CC(var_0) {
  level.vehicle.var_116CE.var_12BCF[level.var_13570] = [[var_0]]();
}

func_31A3(var_0, var_1, var_2) {
  var_3 = level.var_13570;
  level.vehicle.var_116CE.var_AC4A[var_3] = var_0;
  level.vehicle.var_116CE.var_AC4D[var_3] = var_1;
  level.vehicle.var_116CE.var_AC4C[var_3] = var_2;
}

func_3188(var_0) {
  level.vehicle.var_116CE.var_4F6B[level.var_13571] = loadfx(var_0);
}

func_3189(var_0, var_1) {}

func_31A6(var_0) {
  level.var_13261[level.var_13575][level.var_13570] = var_0;
}

func_31AC(var_0) {
  level.vehicle.var_116CE.var_1325B[level.var_13570] = var_0;
}

build_all_treadfx(var_0, var_1) {
  level.vehicle.var_116CE.var_2427[level.var_13570]["atmo"] = var_0;
  level.vehicle.var_116CE.var_2427[level.var_13570]["space"] = var_1;
}

bugoutontimeout(var_0) {
  level.vehicle.var_116CE.var_155C[level.var_13570] = var_0;
}

func_31BF(var_0) {
  level.vehicle.var_116CE.var_F216[level.var_13570] = var_0;
}

func_31B0(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.var_D375 = var_0;
  var_2.var_13DCB = var_1;
  precachemodel(var_0);
  level.vehicle.var_116CE.var_13265[level.var_13570] = var_2;
}

func_3181(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.var_116CE.var_4DFC)) {
    level.vehicle.var_116CE.var_4DFC = [];
  }

  var_6 = spawnStruct();
  var_6.delay = var_0;
  var_6.var_5F36 = var_1;
  var_6.height = var_2;
  var_6.fgetarg = var_3;
  var_6.var_115A4 = var_4;
  var_6.var_115A5 = var_5;
  level.vehicle.var_116CE.var_4DFC[level.var_13570] = var_6;
}

func_31A0(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_8DB1)) {
    level.vehicle.var_116CE.var_8DB1 = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.var_13575;
  }

  level.vehicle.var_116CE.var_8DB1[var_0] = 1;
}

func_319F(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_1AE5)) {
    level.vehicle.var_116CE.var_1AE5 = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.var_13575;
  }

  level.vehicle.var_116CE.var_1AE5[var_0] = 1;
}

func_31C2(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_1020A)) {
    level.vehicle.var_116CE.var_1020A = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.var_13575;
  }

  level.vehicle.var_116CE.var_1020A[var_0] = 1;
}

func_31B6(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_E4F9)) {
    level.vehicle.var_116CE.var_E4F9 = [];
  }

  level.vehicle.var_116CE.var_E4F9[level.var_13570] = var_0;
}