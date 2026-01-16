/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3026.gsc
**************************************/

init() {
  if(isDefined(level.var_90E2)) {
    return;
  }
  level.var_90E2 = spawnStruct();
  level.var_90E2.var_5084 = [];
  level.var_90E2.var_5083 = [];
  level.var_90E2.var_1112E = 1.0;
  level.var_90E2.var_90E0 = 0.0;
  level.var_90E2.var_D3E6 = gettime();
  level.var_7000 = 0.3;
  level thread func_8CDF();
  level thread func_11ADE();
}

func_8CDF() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    wait 0.5;

    if(!isDefined(level.var_D127) || !isDefined(level.var_D127.team) || !scripts\sp\utility::func_D123()) {
      continue;
    }
    var_3 = func_0BDC::func_77D8();

    if(var_3.size == 0) {
      continue;
    }
    var_4 = func_100B6();
    var_5 = func_100B5();

    if(!var_4 && !var_5) {
      if(var_2) {
        var_2 = 0;
        func_1105E(var_3);
      }

      continue;
    } else if(!var_2) {
      var_2 = 1;
    }

    var_6 = level.var_D127;
    var_7 = [];
    var_8 = 0;
    var_9 = 0;

    foreach(var_11 in var_3) {
      if(!isDefined(var_11.var_1912)) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_11);
        continue;
      }

      if(!var_11 func_10022()) {
        continue;
      }
      var_7[var_7.size] = var_11;
    }

    if(var_4) {
      var_13 = func_7E6E(var_7.size);
      func_F661(var_13, var_7);
      var_0 = 1;
    } else if(var_0) {
      func_1105F(var_3);
      var_0 = 0;
    }

    if(var_5) {
      var_14 = func_7E6C(var_7.size);
      func_F660(var_14, var_7);
      var_1 = 1;
    } else if(var_1) {
      func_1105D(var_3);
      var_1 = 0;
    }

    foreach(var_11 in var_3) {
      var_11 func_11ADF();
      var_11 func_11AD9();
    }
  }
}

func_1105E(var_0) {
  foreach(var_2 in var_0) {
    var_2._blackboard.var_7002 = undefined;
    var_2._blackboard.var_90EE = undefined;
  }
}

func_1105F(var_0) {
  foreach(var_2 in var_0) {
    var_2._blackboard.var_90EE = undefined;
  }
}

func_1105D(var_0) {
  foreach(var_2 in var_0) {
    var_2._blackboard.var_7002 = undefined;
  }
}

func_F661(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = level.var_D127;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_5 = var_1[var_3];
    var_2[var_3] = 0;

    if(isDefined(var_5._blackboard.var_90EE)) {
      var_2[var_3] = var_2[var_3] + 1.0;
      var_5._blackboard.var_90EE = undefined;
    }

    var_6 = distance(var_4.origin, var_5.origin);
    var_7 = 1 - clamp(var_6 * 0.00003, 0, 1);
    var_2[var_3] = var_2[var_3] + 2.0 * var_7;
    var_8 = anglesToForward(var_5.angles);
    var_9 = vectordot(var_8, vectornormalize(var_4.origin - var_5.origin));
    var_2[var_3] = var_2[var_3] + var_9 * 1.0;
  }

  var_10 = func_1042E(var_2);

  for(var_3 = 0; var_3 < var_0 && var_3 < var_1.size; var_3++) {
    var_1[var_3]._blackboard.var_90EE = var_4;
  }
}

func_11ADF() {
  if(isDefined(self._blackboard.var_90EE) && isDefined(level.var_D127) && self._blackboard.var_90EE == level.var_D127) {
    if(!scripts\engine\utility::array_contains(level.var_A056.var_90E3, self)) {
      level.var_A056.var_90E3 = scripts\engine\utility::array_add(level.var_A056.var_90E3, self);
    }
  } else if(scripts\engine\utility::array_contains(level.var_A056.var_90E3, self)) {
    level.var_A056.var_90E3 = scripts\engine\utility::array_remove(level.var_A056.var_90E3, self);
    self._blackboard.var_90EC = "";
  }
}

func_11AD9() {
  if(isDefined(self._blackboard.var_7002) && isDefined(level.var_D127) && self._blackboard.var_7002 == level.var_D127) {
    if(!scripts\engine\utility::array_contains(level.var_A056.var_7001, self)) {
      level.var_A056.var_7001 = scripts\engine\utility::array_add(level.var_A056.var_7001, self);
    }
  } else if(scripts\engine\utility::array_contains(level.var_A056.var_7001, self)) {
    level.var_A056.var_7001 = scripts\engine\utility::array_remove(level.var_A056.var_7001, self);
  }
}

func_F660(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = level.var_D127;
  var_5 = anglesToForward(var_4.angles);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_6 = var_1[var_3];
    var_2[var_3] = 0;

    if(isDefined(var_6._blackboard.var_7002)) {
      var_2[var_3] = var_2[var_3] + 2.0;
      var_6._blackboard.var_7002 = undefined;
    }

    var_7 = distance(var_4.origin, var_6.origin);
    var_8 = 1 - clamp(var_7 * 0.00001, 0, 1);
    var_2[var_3] = var_2[var_3] + 1.5 * var_8;
    var_9 = vectornormalize(var_4.origin - var_6.origin);
    var_10 = anglesToForward(var_6.angles);
    var_11 = vectordot(var_10, var_9);
    var_2[var_3] = var_2[var_3] + var_11 * 1.0;
    var_11 = -1.0 * vectordot(var_5, var_9);
    var_2[var_3] = var_2[var_3] + var_11 * 2.0;
  }

  var_12 = func_1042E(var_2);

  for(var_3 = 0; var_3 < var_0 && var_3 < var_1.size; var_3++) {
    var_1[var_3]._blackboard.var_7002 = var_4;
  }
}

func_1042E(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_1.size] = var_2;
  }

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
      if(var_0[var_3] < var_0[var_2]) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
        var_4 = var_1[var_3];
        var_1[var_3] = var_1[var_2];
        var_1[var_2] = var_4;
      }
    }
  }

  return var_1;
}

func_11ADE() {
  var_0 = 0.05;
  var_1 = "fly";
  var_2 = "fly";
  var_3 = gettime();
  var_4 = 0;

  for(;;) {
    wait(var_0);

    if(!scripts\sp\utility::func_D123()) {
      continue;
    }
    var_5 = gettime();
    var_6 = level.var_D127.spaceship_mode;

    if(var_6 == "hover") {
      var_7 = 2000;
    } else {
      var_7 = 300;
    }

    if(var_6 != var_1) {
      var_1 = var_6;
      var_3 = var_5;
    }

    if(var_2 != var_6 && var_5 - var_3 > var_7) {
      var_2 = var_6;
    }

    if(level.var_D127.spaceship_boosting) {
      var_8 = -1000;
    } else if(var_2 == "hover") {
      var_8 = level.var_A48E.var_A3F5;

      if(level.var_90E2.var_90E0 < 0.25) {
        level.var_90E2.var_90E0 = 0.25;
      }
    } else if(var_2 == "fly" && var_6 == "fly") {
      var_8 = -4000;
    }
    else {
      var_8 = 0;
    }

    if(var_8 != 0) {
      var_9 = var_0 * (1000 / var_8);
    } else {
      var_9 = 0;
    }

    level.var_90E2.var_90E0 = level.var_90E2.var_90E0 + var_9;
    level.var_90E2.var_90E0 = clamp(level.var_90E2.var_90E0, 0, 1);
  }
}

func_7E6E(var_0) {
  var_1 = int(level.var_A48E.var_A3F4 * level.var_90E2.var_1112E);
  var_0 = int(var_0 * level.var_90E2.var_90E0);

  if(var_0 > var_1) {
    var_0 = var_1;
  }

  return var_0;
}

func_7E6C(var_0) {
  if(scripts\sp\utility::func_7B9D() < 0.4) {
    return 0;
  }

  return int(min(level.var_7000 * 10.0, var_0 * level.var_7000));
}

func_100B5() {
  if(level.var_7000 <= 0) {
    return 0;
  }

  if(level.var_D127.ignoreme) {
    return 0;
  }

  return 1;
}

func_100B6() {
  if(level.var_90E2.var_1112E <= 0) {
    return 0;
  }

  if(level.var_D127.ignoreme) {
    return 0;
  }

  return 1;
}

func_10022() {
  if(!self._blackboard.var_90EA) {
    return 0;
  }

  if(self._blackboard.var_9DC2) {
    return 0;
  }

  if(isDefined(self._blackboard.var_A9D1) && self._blackboard.var_A9D1 + 5000 < gettime()) {
    return 0;
  }

  if(isDefined(self._blackboard.var_90EE) && self._blackboard.var_90EE != level.var_D127) {
    return 0;
  }

  if(!isenemyteam(level.var_D127.team, self.team)) {
    return 0;
  }

  if(!isDefined(self.var_9B4C) && self.var_9B4C) {
    return 0;
  }

  if(func_0BDC::func_9BCF()) {
    return 0;
  }

  return 1;
}

func_7E67(var_0) {
  var_1 = scripts\engine\utility::array_find(level.var_90E2.var_5084, var_0);
  return var_1;
}