/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1768.gsc
*************************************************/

_id_2CD9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_4 = spawnStruct();
  var_4._id_A97D = var_0;
  var_4._id_C01B = var_1;
  var_4._id_0299 = var_2;
  var_4._id_02B1 = var_3;
  level.vehicle._id_F078._id_43C9[level._id_106B9] = var_4;
}

_id_2CDD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle._id_F078._id_C992)) {
    level.vehicle._id_F078._id_C992 = [];
  }

  var_6 = _id_2CD7(var_1, var_2, var_3, var_4, var_5);
  _func_01B1(var_0);
  var_6._id_C992 = var_0;
  level.vehicle._id_F078._id_C992[level._id_106B9] = var_6;
}

_id_2CB9(var_0, var_1, var_2) {
  var_3 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078._id_43B2)) {
    level.vehicle._id_F078._id_43B2 = [];
  }

  level.vehicle._id_F078._id_43B2[var_3] = _id_2CD7(var_0, var_1, var_2);
}

_id_2CD7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_CB76 = var_0;
  var_5._id_5090 = var_1;
  var_5._id_0359 = var_2;

  if(isDefined(var_3)) {
    var_5._id_232C = var_3;
  }

  if(isDefined(var_4)) {
    var_5._id_BFF3 = var_4;
  }

  return var_5;
}

_id_2CBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_12 = spawnStruct();
  var_12._id_5106 = loadfx(var_0);
  var_12._id_0427 = var_1;
  var_12._id_E050 = var_2;
  var_12._id_2C58 = var_5;
  var_12._id_4649 = var_4;
  var_12._id_107E9 = var_6;
  var_12._id_E793 = var_7;
  var_12._id_A6B5 = var_8;
  var_12._id_2499 = var_3;
  var_12._id_D082 = var_9;
  var_12._id_C3A2 = var_10;
  var_12._id_1DD3 = var_11;
  return var_12;
}

_id_2CB7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078._id_10082[var_12])) {
    level.vehicle._id_F078._id_10082[var_12] = [];
  }

  level.vehicle._id_F078._id_10082[var_12][level.vehicle._id_F078._id_10082[var_12].size] = _id_2CBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_2CDC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078._id_10082[var_11])) {
    level.vehicle._id_F078._id_10082[var_11] = [];
  }

  level.vehicle._id_F078._id_1024D[var_11][level.vehicle._id_F078._id_10082[var_11].size] = _id_2CBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_2CB6(var_0, var_1, var_2, var_3) {
  var_4 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078._id_43D4[var_4])) {
    level.vehicle._id_F078._id_43D4[var_4] = [];
  }

  level.vehicle._id_F078._id_43D4[var_4]["forward"] = var_0;
  level.vehicle._id_F078._id_43D4[var_4]["right"] = var_1;
  level.vehicle._id_F078._id_43D4[var_4]["backward"] = var_2;
  level.vehicle._id_F078._id_43D4[var_4]["left"] = var_3;
}

_id_2CC6(var_0) {
  var_1 = level._id_106B9;
  level.vehicle._id_F078._id_8E9B[var_1] = [[var_0]]();
}

_id_2CE7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078._id_9E6C[var_9])) {
    level.vehicle._id_F078._id_9E6C[var_9] = [];
  }

  var_10 = _id_2CE9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level.vehicle._id_F078._id_9E6C[var_9][level.vehicle._id_F078._id_9E6C[var_9].size] = var_10;
}

_id_2CCD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = level._id_106B9;

  if(isDefined(level.vehicle._id_F078._id_997E[var_9])) {}

  var_10 = _id_2CE9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, undefined, var_8);
  level.vehicle._id_F078._id_997E[var_9] = var_10;
}

_id_2CE9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  precachemodel(var_2);
  _func_01B6(var_0);
  var_10 = spawnStruct();
  var_10._id_7E9E = var_0;
  var_10._id_0427 = var_1;
  var_10.model = var_2;
  var_10._id_45BA = var_3;
  var_10._id_45AD = var_4;
  var_10._id_45AE = var_5;

  if(isDefined(var_6)) {
    var_10._id_A981 = var_6;
  }

  if(isDefined(var_7)) {
    var_10._id_C18B = var_7;
  }

  if(isDefined(var_8) && var_8) {
    var_10._id_9982 = var_8;
  }

  if(isDefined(var_9)) {
    var_10.on_fire_callback = var_9;
  }

  return var_10;
}

_id_2CC8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_2CCA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, undefined);
}

_id_2CCA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.vehicle._id_F078._id_10133)) {
    level.vehicle._id_F078._id_10133 = [];
  }

  if(!isDefined(level.vehicle._id_F078._id_10135)) {
    level.vehicle._id_F078._id_10135 = [];
  }

  if(isDefined(level.vehicle._id_F078._id_10135[var_4]) && !level._id_106BB) {
    return;
  }
  var_8 = spawnStruct();
  var_8.name = var_1;
  var_8._id_0427 = var_2;
  var_8._id_4649 = var_5;
  var_8._id_5106 = loadfx(var_3);

  if(isDefined(var_7)) {
    var_8._id_F847 = var_7;
  }

  level.vehicle._id_F078._id_10133[var_0][var_1] = var_8;

  if(!isDefined(var_6) || var_6 == 0) {
    _id_06EA::_id_7217(var_0, var_1, "all");
  }

  if(isDefined(var_4)) {
    _id_06EA::_id_7217(var_0, var_1, var_4);
  }
}

_id_2CC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.vehicle._id_F078._id_487A)) {
    level.vehicle._id_F078._id_487A = [];
  }

  var_7 = spawnStruct();
  var_7.name = var_1;
  var_7._id_0427 = var_2;
  var_7._id_4649 = var_5;
  var_7._id_5106 = loadfx(var_3);
  level.vehicle._id_F078._id_487A[var_0][var_1] = var_7;
}

_id_2CCB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_2CCA(var_1, var_2, var_3, var_4, var_5, var_6, var_0);
}

_id_2CC1(var_0, var_1) {
  if(!isDefined(level.vehicle._id_F078._id_78CC)) {
    level.vehicle._id_F078._id_78CC = [];
  }

  level.vehicle._id_F078._id_78CC[var_0] = var_1;
}

_id_2CB8(var_0, var_1) {
  if(var_0 != level._id_106BA) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  precachemodel(var_0);
  precachemodel(var_1);
  level.vehicle._id_F078._id_43F3[var_0] = var_1;
}

_id_2CC2(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_7CAA)) {
    level.vehicle._id_F078._id_7CAA = [];
  }

  if(!isDefined(level.vehicle._id_F078._id_7CAA[level._id_106BA])) {
    level.vehicle._id_F078._id_7CAA[level._id_106BA] = [];
  }

  level.vehicle._id_F078._id_7CAA[level._id_106BA][level.vehicle._id_F078._id_7CAA[level._id_106BA].size] = var_0;
}

_id_2CBB(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  level.vehicle._id_F078._id_4F5E[level._id_106BA] = var_0;

  if(isDefined(var_1)) {
    level.vehicle._id_F078._id_4F61[level._id_106BA] = var_1;
  }

  level.vehicle._id_F078._id_4F60[level._id_106BA] = var_2;

  if(isDefined(var_3)) {
    level.vehicle._id_F078._id_4F5F[level._id_106BA] = var_3;
  }
}

_id_2CE3(var_0, var_1, var_2, var_3) {
  _id_06E9::_id_10255();

  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  _func_01B7(var_0);
  level.vehicle._id_F078.team[var_3] = "axis";
  level.vehicle._id_F078._id_9365[var_3] = 999;
  level.vehicle._id_F078._id_7500[var_1] = 0;
  level.vehicle._id_F078._id_9972[var_1] = [];
  level._id_106BA = var_1;
  level._id_106BC = var_0;
  level._id_106B9 = var_3;
  level.vehicle._id_F078.model[var_3] = var_1;
}

_id_2CBE(var_0) {
  level.vehicle._id_F078._id_572F[level._id_106BA] = loadfx(var_0);
}

_id_2CBD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    var_1 = "tag_engine_fx";
  }

  var_8 = spawnStruct();
  var_8._id_5106 = loadfx(var_0);
  var_8._id_510B = var_1;

  if(isDefined(var_2)) {
    var_8._id_9C16 = loadfx(var_2);
    var_8._id_9C17 = var_3;
  }

  if(isDefined(var_4)) {
    var_8._id_9CD9 = loadfx(var_4);
    var_8._id_9CDA = var_5;
  }

  if(isDefined(var_6)) {
    var_8._id_9E9B = loadfx(var_6);
    var_8._id_9E9C = var_7;
  }

  level.vehicle._id_F078._id_545C[level._id_106B9] = var_8;
}

_id_2CD8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    var_6._id_9C16 = var_0;
    var_6._id_9C17 = var_1;
  }

  if(isDefined(var_2)) {
    var_6._id_9CD9 = var_2;
    var_6._id_9CDA = var_3;
  }

  if(isDefined(var_4)) {
    var_6._id_9E9B = var_4;
    var_6._id_9E9C = var_5;
  }

  level.vehicle._id_F078._id_BF17[level._id_106B9] = var_6;
}

_id_2CE4(var_0, var_1, var_2, var_3) {
  if(!scripts\common\utility::issp()) {
    return;
  }
  if(isDefined(var_0)) {
    _id_D42A(var_0, var_1, var_2);

    if(isDefined(var_3) && var_3) {
      _id_D42A(var_0, var_1, var_2, "_bank");
      _id_D42A(var_0, var_1, var_2, "_bank_lg");
    }
  } else {
    var_0 = level._id_106B9;
    _id_06EC::main();
  }
}

_id_2CAC(var_0, var_1) {
  var_2 = _id_679E();

  foreach(var_4 in var_2) {
    _id_D42A(var_0, var_4);
  }
}

_id_D42A(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle._id_F078._id_EBC9)) {
    level.vehicle._id_F078._id_EBC9 = [];
  }

  if(isDefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;
  }

  if(isDefined(var_2)) {
    level.vehicle._id_F078._id_EBC9[var_0][var_1] = loadfx(var_2);
  } else if(isDefined(level.vehicle._id_F078._id_EBC9[var_0]) && isDefined(level.vehicle._id_F078._id_EBC9[var_0][var_1])) {
    level.vehicle._id_F078._id_EBC9[var_0][var_1] = undefined;
  }
}

_id_679E() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

_id_2CE2(var_0) {
  level.vehicle._id_F078.team[level._id_106B9] = var_0;
}

_id_2CAF(var_0) {
  level.vehicle._id_F078._id_2D2B[level._id_106B9] = var_0;
}

_id_2CC0(var_0) {
  level.vehicle._id_F078._id_7150[level._id_106B9] = var_0;
}

_id_2CAA(var_0, var_1, var_2, var_3) {
  var_4 = level._id_106B9;
  level.vehicle._id_F078._id_1306[var_4] = [[var_0]]();

  if(isDefined(var_2) && isDefined(level._id_6016) && isDefined(level._id_6016["set_vehicle_anims_" + var_2])) {
    level.vehicle._id_F078._id_1306[var_4] = [[level._id_6016["set_vehicle_anims_" + var_2]]](level.vehicle._id_F078._id_1306[var_4]);
  } else if(isDefined(var_1)) {
    level.vehicle._id_F078._id_1306[var_4] = [[var_1]](level.vehicle._id_F078._id_1306[var_4]);
  }

  if(isDefined(var_3)) {
    level.vehicle._id_F078._id_1306[var_4] = [[var_3]](level.vehicle._id_F078._id_1306[var_4]);
  }
}

_id_2CAE(var_0) {
  level.vehicle._id_F078._id_1D82[level._id_106B9] = [[var_0]]();
}

_id_2CEA(var_0) {
  level.vehicle._id_F078._id_F97C[level._id_106B9] = [[var_0]]();
}

_id_2CC7(var_0, var_1, var_2) {
  var_3 = level._id_106B9;
  level.vehicle._id_F078._id_9365[var_3] = var_0;
  level.vehicle._id_F078._id_936A[var_3] = var_1;
  level.vehicle._id_F078._id_9369[var_3] = var_2;
}

_id_2CBA(var_0, var_1) {}

_id_2CB5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0.85;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.15;
  }

  if(!isDefined(var_3)) {
    var_3 = 8;
  }

  var_4 = spawnStruct();
  var_4._id_10155 = level._id_106B9;
  var_4._id_9446 = var_0;
  var_4._id_9D03 = var_1;
  var_4._id_765B = var_2;
  var_4._id_2D78 = var_3;
  level.vehicle._id_F078._id_42DB[level._id_106B9] = var_4;
}

_id_2CCC(var_0) {
  level._id_10313[level._id_106BC][level._id_106B9] = var_0;
}

_id_2CAD(var_0, var_1) {
  level.vehicle._id_F078._id_1D60[level._id_106B9]["atmo"] = var_0;
  level.vehicle._id_F078._id_1D60[level._id_106B9]["space"] = var_1;
}

_id_2CA9(var_0) {
  level.vehicle._id_F078._id_0E62[level._id_106B9] = var_0;
}

_id_2CDE(var_0) {
  level.vehicle._id_F078._id_D08F[level._id_106B9] = var_0;
}

_id_2CD6(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_B682 = var_0;
  var_2._id_10F4D = var_1;
  precachemodel(var_0);
  level.vehicle._id_F078._id_10325[level._id_106B9] = var_2;
}

_id_2CC4(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_7788)) {
    level.vehicle._id_F078._id_7788 = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level._id_106BC;
  }

  level.vehicle._id_F078._id_7788[var_0] = 1;
}

_id_2CC3(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_13B5)) {
    level.vehicle._id_F078._id_13B5 = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level._id_106BC;
  }

  level.vehicle._id_F078._id_13B5[var_0] = 1;
}

_id_2CDF(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_DD5E)) {
    level.vehicle._id_F078._id_DD5E = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level._id_106BC;
  }

  level.vehicle._id_F078._id_DD5E[var_0] = 1;
}

_id_2CAB(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_147C)) {
    level.vehicle._id_F078._id_147C = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level._id_106BC;
  }

  level.vehicle._id_F078._id_147C[var_0] = 1;
}

_id_2CDB(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_C832)) {
    level.vehicle._id_F078._id_C832 = [];
  }

  level.vehicle._id_F078._id_C832[level._id_106B9] = var_0;
}

_id_2CEB(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_43CF)) {
    level.vehicle._id_F078._id_43CF = [];
  }

  level.vehicle._id_F078._id_43CF[level._id_106BC] = var_0;
}

_id_2CD5(var_0, var_1, var_2) {
  var_3 = level._id_106B9;
  level.vehicle._id_F078._id_B65C[var_3] = [[var_0]]();

  if(isDefined(var_1)) {
    level.vehicle._id_F078._id_B65C[var_3] = [[var_1]](level.vehicle._id_F078._id_B65C[var_3]);
  }

  if(isDefined(var_2)) {
    level.vehicle._id_F078._id_B65C[var_3] = [[var_2]](level.vehicle._id_F078._id_B65C[var_3]);
  }
}

build_rider_seat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10._id_DD6C = var_0;
  var_10._id_31D4 = var_1;
  var_10._id_24F5 = var_2;
  var_10._id_9E6C = var_4;
  var_10._id_43C7 = var_3;
  var_10._id_5795 = var_5;
  var_10._id_4A32 = var_6;
  var_10._id_992D = var_7;
  var_10._id_9513 = var_8;
  var_10._id_2529 = var_9;
  return var_10;
}

build_mainturret_fire_jolt(var_0, var_1) {
  var_2 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078.mainturret_jolt[var_2])) {
    level.vehicle._id_F078.mainturret_jolt[var_2] = [];
  }

  if(!isDefined(var_0)) {
    var_0 = "tag_flash";
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = spawnStruct();
  var_3._id_0427 = var_0;
  var_3._id_023B = var_1;
  level.vehicle._id_F078.mainturret_jolt[var_2] = var_3;
}

build_mainturret_fire_quake(var_0, var_1, var_2, var_3) {
  var_4 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078.mainturret_quake[var_4])) {
    level.vehicle._id_F078.mainturret_quake[var_4] = [];
  }

  if(!isDefined(var_0)) {
    var_0 = "tag_flash";
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 350;
  }

  var_5 = spawnStruct();
  var_5._id_0427 = var_0;
  var_5._id_023B = var_1;
  var_5._id_5090 = var_2;
  var_5._id_0359 = var_3;
  level.vehicle._id_F078.mainturret_quake[var_4] = var_5;
}

build_mainturret_fire_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_106B9;

  if(!isDefined(level.vehicle._id_F078.mainturret_rumble[var_6])) {
    level.vehicle._id_F078.mainturret_rumble[var_6] = [];
  }

  if(!isDefined(var_0)) {
    var_0 = "tag_flash";
  }

  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(!isDefined(var_3)) {
    var_3 = 300;
  }

  if(!isDefined(var_2)) {
    var_2 = "light_2s";
  }

  if(!isDefined(var_4)) {
    var_4 = "light_1s";
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_7 = spawnStruct();
  var_7._id_0427 = var_0;
  var_7.near_dist = var_1;
  var_7._id_5973 = var_3;
  var_7.near_rumble = var_2;
  var_7.far_rumble = var_4;
  var_7.use_vehicle_for_tag = var_5;
  level.vehicle._id_F078.mainturret_rumble[var_6] = var_7;
  _func_01B1(var_2);
  _func_01B1(var_4);
}