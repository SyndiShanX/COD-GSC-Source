/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3026.gsc
***************************************/

init() {
  if(isDefined(level.func_90E2)) {
    return;
  }
  level.func_90E2 = spawnStruct();
  level.func_90E2.func_5084 = [];
  level.func_90E2.func_5083 = [];
  level.func_90E2.func_1112E = 1.0;
  level.func_90E2.func_90E0 = 0.0;
  level.func_90E2.func_D3E6 = gettime();
  level.func_7000 = 0.3;
  level thread func_8CDF();
  level thread func_11ADE();
}

func_8CDF() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;

  for(;;) {
    wait 0.5;

    if(!isDefined(level.func_D127) || !isDefined(level.func_D127.team) || !scripts\sp\utility::func_D123()) {
      continue;
    }
    var_03 = func_0BDC::func_77D8();

    if(var_3.size == 0) {
      continue;
    }
    var_04 = func_100B6();
    var_05 = func_100B5();

    if(!var_04 && !var_05) {
      if(var_02) {
        var_02 = 0;
        func_1105E(var_03);
      }

      continue;
    } else if(!var_02)
      var_02 = 1;

    var_06 = level.func_D127;
    var_07 = [];
    var_08 = 0;
    var_09 = 0;

    foreach(var_11 in var_03) {
      if(!isDefined(var_11.func_1912)) {
        var_03 = scripts\engine\utility::array_remove(var_03, var_11);
        continue;
      }

      if(!var_11 func_10022()) {
        continue;
      }
      var_7[var_7.size] = var_11;
    }

    if(var_04) {
      var_13 = func_7E6E(var_7.size);
      func_F661(var_13, var_07);
      var_00 = 1;
    } else if(var_00) {
      func_1105F(var_03);
      var_00 = 0;
    }

    if(var_05) {
      var_14 = func_7E6C(var_7.size);
      func_F660(var_14, var_07);
      var_01 = 1;
    } else if(var_01) {
      func_1105D(var_03);
      var_01 = 0;
    }

    foreach(var_11 in var_03) {
      var_11 func_11ADF();
      var_11 func_11AD9();
    }
  }
}

func_1105E(var_00) {
  foreach(var_02 in var_00) {
    var_2.var_1198.func_7002 = undefined;
    var_2.var_1198.func_90EE = undefined;
  }
}

func_1105F(var_00) {
  foreach(var_02 in var_00) {
    var_2.var_1198.func_90EE = undefined;
  }
}

func_1105D(var_00) {
  foreach(var_02 in var_00) {
    var_2.var_1198.func_7002 = undefined;
  }
}

func_F661(var_00, var_01) {
  var_02 = [];
  var_03 = 0;
  var_04 = level.func_D127;

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    var_05 = var_1[var_03];
    var_2[var_03] = 0;

    if(isDefined(var_5.var_1198.func_90EE)) {
      var_2[var_03] = var_2[var_03] + 1.0;
      var_5.var_1198.func_90EE = undefined;
    }

    var_06 = distance(var_4.origin, var_5.origin);
    var_07 = 1 - clamp(var_06 * 0.00003, 0, 1);
    var_2[var_03] = var_2[var_03] + 2.0 * var_07;
    var_08 = anglesToForward(var_5.angles);
    var_09 = vectordot(var_08, vectornormalize(var_4.origin - var_5.origin));
    var_2[var_03] = var_2[var_03] + var_09 * 1.0;
  }

  var_10 = func_1042E(var_02);

  for(var_03 = 0; var_03 < var_00 && var_03 < var_1.size; var_3++) {
    var_1[var_03].var_1198.func_90EE = var_04;
  }
}

func_11ADF() {
  if(isDefined(self.var_1198.func_90EE) && isDefined(level.func_D127) && self.var_1198.func_90EE == level.func_D127) {
    if(!scripts\engine\utility::array_contains(level.func_A056.func_90E3, self)) {
      level.func_A056.func_90E3 = scripts\engine\utility::array_add(level.func_A056.func_90E3, self);
    }
  } else if(scripts\engine\utility::array_contains(level.func_A056.func_90E3, self)) {
    level.func_A056.func_90E3 = scripts\engine\utility::array_remove(level.func_A056.func_90E3, self);
    self.var_1198.func_90EC = "";
  }
}

func_11AD9() {
  if(isDefined(self.var_1198.func_7002) && isDefined(level.func_D127) && self.var_1198.func_7002 == level.func_D127) {
    if(!scripts\engine\utility::array_contains(level.func_A056.func_7001, self)) {
      level.func_A056.func_7001 = scripts\engine\utility::array_add(level.func_A056.func_7001, self);
    }
  } else if(scripts\engine\utility::array_contains(level.func_A056.func_7001, self))
    level.func_A056.func_7001 = scripts\engine\utility::array_remove(level.func_A056.func_7001, self);
}

func_F660(var_00, var_01) {
  var_02 = [];
  var_03 = 0;
  var_04 = level.func_D127;
  var_05 = anglesToForward(var_4.angles);

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    var_06 = var_1[var_03];
    var_2[var_03] = 0;

    if(isDefined(var_6.var_1198.func_7002)) {
      var_2[var_03] = var_2[var_03] + 2.0;
      var_6.var_1198.func_7002 = undefined;
    }

    var_07 = distance(var_4.origin, var_6.origin);
    var_08 = 1 - clamp(var_07 * 0.00001, 0, 1);
    var_2[var_03] = var_2[var_03] + 1.5 * var_08;
    var_09 = vectornormalize(var_4.origin - var_6.origin);
    var_10 = anglesToForward(var_6.angles);
    var_11 = vectordot(var_10, var_09);
    var_2[var_03] = var_2[var_03] + var_11 * 1.0;
    var_11 = -1.0 * vectordot(var_05, var_09);
    var_2[var_03] = var_2[var_03] + var_11 * 2.0;
  }

  var_12 = func_1042E(var_02);

  for(var_03 = 0; var_03 < var_00 && var_03 < var_1.size; var_3++) {
    var_1[var_03].var_1198.func_7002 = var_04;
  }
}

func_1042E(var_00) {
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_1[var_1.size] = var_02;
  }

  for(var_02 = 0; var_02 < var_1.size - 1; var_2++) {
    for(var_03 = var_02 + 1; var_03 < var_1.size; var_3++) {
      if(var_0[var_03] < var_0[var_02]) {
        var_04 = var_0[var_03];
        var_0[var_03] = var_0[var_02];
        var_0[var_02] = var_04;
        var_04 = var_1[var_03];
        var_1[var_03] = var_1[var_02];
        var_1[var_02] = var_04;
      }
    }
  }

  return var_01;
}

func_11ADE() {
  var_00 = 0.05;
  var_01 = "fly";
  var_02 = "fly";
  var_03 = gettime();
  var_04 = 0;

  for(;;) {
    wait(var_00);

    if(!scripts\sp\utility::func_D123()) {
      continue;
    }
    var_05 = gettime();
    var_06 = level.func_D127.spaceship_mode;

    if(var_06 == "hover") {
      var_07 = 2000;
    } else {
      var_07 = 300;
    }

    if(var_06 != var_01) {
      var_01 = var_06;
      var_03 = var_05;
    }

    if(var_02 != var_06 && var_05 - var_03 > var_07) {
      var_02 = var_06;
    }

    if(level.func_D127.spaceship_boosting) {
      var_08 = -1000;
    } else if(var_02 == "hover") {
      var_08 = level.func_A48E.func_A3F5;

      if(level.func_90E2.func_90E0 < 0.25) {
        level.func_90E2.func_90E0 = 0.25;
      }
    } else if(var_02 == "fly" && var_06 == "fly")
      var_08 = -4000;
    else {
      var_08 = 0;
    }

    if(var_08 != 0) {
      var_09 = var_00 * (1000 / var_08);
    } else {
      var_09 = 0;
    }

    level.func_90E2.func_90E0 = level.func_90E2.func_90E0 + var_09;
    level.func_90E2.func_90E0 = clamp(level.func_90E2.func_90E0, 0, 1);
  }
}

func_7E6E(var_00) {
  var_01 = int(level.func_A48E.func_A3F4 * level.func_90E2.func_1112E);
  var_00 = int(var_00 * level.func_90E2.func_90E0);

  if(var_00 > var_01) {
    var_00 = var_01;
  }

  return var_00;
}

func_7E6C(var_00) {
  if(scripts\sp\utility::func_7B9D() < 0.4) {
    return 0;
  }

  return int(min(level.func_7000 * 10.0, var_00 * level.func_7000));
}

func_100B5() {
  if(level.func_7000 <= 0) {
    return 0;
  }

  if(level.func_D127.ignoreme) {
    return 0;
  }

  return 1;
}

func_100B6() {
  if(level.func_90E2.func_1112E <= 0) {
    return 0;
  }

  if(level.func_D127.ignoreme) {
    return 0;
  }

  return 1;
}

func_10022() {
  if(!self.var_1198.func_90EA) {
    return 0;
  }

  if(self.var_1198.func_9DC2) {
    return 0;
  }

  if(isDefined(self.var_1198.func_A9D1) && self.var_1198.func_A9D1 + 5000 < gettime()) {
    return 0;
  }

  if(isDefined(self.var_1198.func_90EE) && self.var_1198.func_90EE != level.func_D127) {
    return 0;
  }

  if(!isenemyteam(level.func_D127.team, self.team)) {
    return 0;
  }

  if(!isDefined(self.func_9B4C) && self.func_9B4C) {
    return 0;
  }

  if(func_0BDC::func_9BCF()) {
    return 0;
  }

  return 1;
}

func_7E67(var_00) {
  var_01 = scripts\engine\utility::array_find(level.func_90E2.func_5084, var_00);
  return var_01;
}