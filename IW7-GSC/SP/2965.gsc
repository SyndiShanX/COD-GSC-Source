/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2965.gsc
**************************************/

_id_31B3(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  var_6 = spawnStruct();
  var_6.offset = var_0;
  var_6._id_DCCA = var_1;
  var_6._id_B48B = var_2;
  var_6._id_B758 = var_3;
  var_6._id_2B19 = var_4;
  var_6.delay = var_5;
  level.vehicle._id_116CE._id_4E1C[level._id_13570] = var_6;
}

_id_31B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle._id_116CE._id_E7BA))
    level.vehicle._id_116CE._id_E7BA = [];

  var_6 = _id_31B2(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6._id_E7BA = var_0;
  level.vehicle._id_116CE._id_E7BA[level._id_13570] = var_6;
}

_id_3187(var_0, var_1, var_2) {
  var_3 = level._id_13570;

  if(!isDefined(level.vehicle._id_116CE._id_4E02))
    level.vehicle._id_116CE._id_4E02 = [];

  level.vehicle._id_116CE._id_4E02[var_3] = _id_31B2(var_0, var_1, var_2);
}

_id_31B2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_EB9C = var_0;
  var_5._id_5F36 = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3))
    var_5._id_28AE = var_3;

  if(isDefined(var_4))
    var_5._id_DCA5 = var_4;

  return var_5;
}

_id_3197(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 1;

  var_12 = spawnStruct();
  var_12.effect = loadfx(var_0);
  var_12.tag = var_1;
  var_12.sound = var_2;
  var_12._id_312E = var_5;
  var_12.delay = var_4;
  var_12._id_136A1 = var_6;
  var_12._id_10E6A = var_7;
  var_12._id_C174 = var_8;
  var_12._id_2A4E = var_3;
  var_12._id_F1EA = var_9;
  var_12._id_DFEC = var_10;
  var_12._id_24DF = var_11;
  return var_12;
}

_id_3184(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level._id_13570;

  if(!isDefined(level.vehicle._id_116CE._id_131BC[var_12]))
    level.vehicle._id_116CE._id_131BC[var_12] = [];

  level.vehicle._id_116CE._id_131BC[var_12][level.vehicle._id_116CE._id_131BC[var_12].size] = _id_3197(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_3183(var_0) {
  var_1 = level._id_13570;

  if(!isDefined(level.vehicle._id_116CE._id_4DF9[var_1]))
    level.vehicle._id_116CE._id_4DF9[var_1] = [];

  level.vehicle._id_116CE._id_4DF9[var_1] = var_0;
}

_id_31B7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level._id_13570;
  level._id_13570 = "rocket_death" + var_11;
  _id_3184(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  level._id_13570 = var_11;
}

_id_31A2(var_0) {
  var_1 = level._id_13570;
  level.vehicle._id_116CE._id_A7C5[var_1] = [[var_0]]();
}

_id_31C8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.vehicle._id_116CE.mgturret))
    level.vehicle._id_116CE.mgturret = [];

  var_10 = level._id_13570;

  if(!isDefined(level.vehicle._id_116CE.mgturret[var_10]))
    level.vehicle._id_116CE.mgturret[var_10] = [];

  precachemodel(var_2);
  precacheturret(var_0);
  var_11 = spawnStruct();
  var_11.info = var_0;
  var_11.tag = var_1;
  var_11.model = var_2;
  var_11._id_01D2 = var_3;
  var_11._id_5041 = var_4;
  var_11._id_51AD = var_5;
  var_11._id_5035 = var_6;
  var_11._id_5036 = var_7;

  if(isDefined(var_8))
    var_11._id_C367 = var_8;

  if(isDefined(var_9))
    var_11._id_DE46 = var_9;

  level.vehicle._id_116CE.mgturret[var_10][level.vehicle._id_116CE.mgturret[var_10].size] = var_11;
}

_id_31A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle._id_116CE._id_13208))
    level.vehicle._id_116CE._id_13208 = [];

  if(!isDefined(level.vehicle._id_116CE._id_1320A))
    level.vehicle._id_116CE._id_1320A = [];

  if(isDefined(level.vehicle._id_116CE._id_1320A[var_4]) && !level._id_13574) {
    return;
  }
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle._id_116CE._id_13208[var_0][var_1] = var_6;
  scripts\sp\vehicle_lights::_id_8695(var_0, var_1, "all");

  if(isDefined(var_4))
    scripts\sp\vehicle_lights::_id_8695(var_0, var_1, var_4);
}

_id_319B(var_0, var_1) {
  if(!isDefined(level.vehicle._id_116CE._id_8E9D))
    level.vehicle._id_116CE._id_8E9D = [];

  level.vehicle._id_116CE._id_8E9D[var_0] = var_1;
}

_id_3186(var_0, var_1, var_2, var_3) {
  if(var_0 != level._id_13571) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = var_0;

  precachemodel(var_0);
  precachemodel(var_1);

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3)) {
    level.vehicle._id_116CE._id_4E4E[var_0] = var_1;
    level.vehicle._id_131C3[var_0] = var_2;
  } else {
    level.vehicle._id_116CE._id_4E4E[var_3] = var_1;
    level.vehicle._id_131C3[var_3] = var_2;
  }
}

_id_319D(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_92D0))
    level.vehicle._id_116CE._id_92D0 = [];

  if(!isDefined(level.vehicle._id_116CE._id_92D0[level._id_13571]))
    level.vehicle._id_116CE._id_92D0[level._id_13571] = [];

  level.vehicle._id_116CE._id_92D0[level._id_13571][level.vehicle._id_116CE._id_92D0[level._id_13571].size] = var_0;
}

_id_318B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 10;

  level.vehicle._id_116CE._id_5BC3[level._id_13571] = var_0;

  if(isDefined(var_1))
    level.vehicle._id_116CE._id_5BC6[level._id_13571] = var_1;

  level.vehicle._id_116CE._id_5BC5[level._id_13571] = var_2;

  if(isDefined(var_3))
    level.vehicle._id_116CE._id_5BC4[level._id_13571] = var_3;
}

_id_31C5(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_965C();
  scripts\sp\vehicle_code::_id_F9C7();

  if(isDefined(var_2))
    var_0 = var_2;

  precachevehicle(var_0);
  level.vehicle._id_116CE.team[var_3] = "axis";
  level.vehicle._id_116CE._id_AC4A[var_3] = 999;
  level.vehicle._id_116CE._id_8B8F[var_1] = 0;
  level.vehicle._id_116CE._id_B243[var_1] = [];
  level._id_13571 = var_1;
  level._id_13575 = var_0;
  level._id_13570 = var_3;
}

_id_3194(var_0) {
  level.vehicle._id_116CE._id_693A[level._id_13571] = loadfx(var_0);
}

_id_31C6(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    _id_F5FB(var_0, var_1, var_2);

    if(isDefined(var_3) && var_3) {
      _id_F5FB(var_0, var_1, var_2, "_bank");
      _id_F5FB(var_0, var_1, var_2, "_bank_lg");
    }
  } else {
    var_0 = level._id_13570;
    scripts\sp\treadfx::main(var_0);
  }
}

build_aianims(var_0, var_1) {
  var_2 = _id_7CC6();

  foreach(var_4 in var_2)
  _id_F5FB(var_0, var_4);
}

_id_F5FB(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle._id_116CE._id_112D9))
    level.vehicle._id_116CE._id_112D9 = [];

  if(isDefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;
  }

  if(isDefined(var_2))
    level.vehicle._id_116CE._id_112D9[var_0][var_1] = loadfx(var_2);
  else if(isDefined(level.vehicle._id_116CE._id_112D9[var_0]) && isDefined(level.vehicle._id_116CE._id_112D9[var_0][var_1]))
    level.vehicle._id_116CE._id_112D9[var_0][var_1] = undefined;
}

_id_7CC6() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

_id_31C4(var_0) {
  level.vehicle._id_116CE.team[level._id_13570] = var_0;
}

_id_31A9(var_0, var_1, var_2, var_3) {
  level.vehicle._id_116CE._id_8B8F[level._id_13571] = 1;

  if(isDefined(var_0))
    level.vehicle._id_116CE._id_B243[level._id_13571][var_0] = 1;

  if(isDefined(var_1))
    level.vehicle._id_116CE._id_B243[level._id_13571][var_1] = 1;

  if(isDefined(var_2))
    level.vehicle._id_116CE._id_B243[level._id_13571][var_2] = 1;

  if(isDefined(var_3))
    level.vehicle._id_116CE._id_B243[level._id_13571][var_3] = 1;
}

build_bulletshield(var_0) {
  level.vehicle._id_116CE._id_323D[level._id_13570] = var_0;
}

_id_3198(var_0) {
  level.vehicle._id_116CE._id_85A0[level._id_13570] = var_0;
}

build_ace(var_0, var_1) {
  var_2 = level._id_13570;
  level.vehicle._id_116CE._id_1A03[var_2] = [[var_0]]();

  if(isDefined(var_1))
    level.vehicle._id_116CE._id_1A03[var_2] = [[var_1]](level.vehicle._id_116CE._id_1A03[var_2]);
}

_id_3196(var_0) {
  level.vehicle._id_116CE._id_7448[level._id_13570] = var_0;
}

build_atmo_types(var_0) {
  level.vehicle._id_116CE._id_247D[level._id_13570] = [[var_0]]();
}

_id_31CC(var_0) {
  level.vehicle._id_116CE._id_12BCF[level._id_13570] = [[var_0]]();
}

_id_31A3(var_0, var_1, var_2) {
  var_3 = level._id_13570;
  level.vehicle._id_116CE._id_AC4A[var_3] = var_0;
  level.vehicle._id_116CE._id_AC4D[var_3] = var_1;
  level.vehicle._id_116CE._id_AC4C[var_3] = var_2;
}

_id_3188(var_0) {
  level.vehicle._id_116CE._id_4F6B[level._id_13571] = loadfx(var_0);
}

_id_3189(var_0, var_1) {}

_id_31A6(var_0) {
  level._id_13261[level._id_13575][level._id_13570] = var_0;
}

_id_31AC(var_0) {
  level.vehicle._id_116CE._id_1325B[level._id_13570] = var_0;
}

build_all_treadfx(var_0, var_1) {
  level.vehicle._id_116CE._id_2427[level._id_13570]["atmo"] = var_0;
  level.vehicle._id_116CE._id_2427[level._id_13570]["space"] = var_1;
}

bugoutontimeout(var_0) {
  level.vehicle._id_116CE._id_155C[level._id_13570] = var_0;
}

_id_31BF(var_0) {
  level.vehicle._id_116CE._id_F216[level._id_13570] = var_0;
}

_id_31B0(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_D375 = var_0;
  var_2._id_13DCB = var_1;
  precachemodel(var_0);
  level.vehicle._id_116CE._id_13265[level._id_13570] = var_2;
}

_id_3181(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle._id_116CE._id_4DFC))
    level.vehicle._id_116CE._id_4DFC = [];

  var_6 = spawnStruct();
  var_6.delay = var_0;
  var_6._id_5F36 = var_1;
  var_6.height = var_2;
  var_6.radius = var_3;
  var_6._id_115A4 = var_4;
  var_6._id_115A5 = var_5;
  level.vehicle._id_116CE._id_4DFC[level._id_13570] = var_6;
}

_id_31A0(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_8DB1))
    level.vehicle._id_116CE._id_8DB1 = [];

  if(!isDefined(var_0))
    var_0 = level._id_13575;

  level.vehicle._id_116CE._id_8DB1[var_0] = 1;
}

_id_319F(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_1AE5))
    level.vehicle._id_116CE._id_1AE5 = [];

  if(!isDefined(var_0))
    var_0 = level._id_13575;

  level.vehicle._id_116CE._id_1AE5[var_0] = 1;
}

_id_31C2(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_1020A))
    level.vehicle._id_116CE._id_1020A = [];

  if(!isDefined(var_0))
    var_0 = level._id_13575;

  level.vehicle._id_116CE._id_1020A[var_0] = 1;
}

_id_31B6(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_E4F9))
    level.vehicle._id_116CE._id_E4F9 = [];

  level.vehicle._id_116CE._id_E4F9[level._id_13570] = var_0;
}