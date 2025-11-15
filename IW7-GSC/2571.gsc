/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2571.gsc
************************/

func_98C9(param_00) {
  if(!isDefined(self.var_1198.scriptableparts)) {
    self.var_1198.scriptableparts = [];
  }

  if(!isDefined(self.var_1198.scriptableparts[param_00])) {
    self.var_1198.scriptableparts[param_00] = spawnStruct();
    self.var_1198.scriptableparts[param_00].state = "normal";
  }
}

func_F591(param_00, param_01) {
  if(self.var_1198.scriptableparts[param_00].state == "dismember") {
    return;
  }

  if(self.var_1198.scriptableparts[param_00].state != "normal" && param_01 != "dismember") {
    self.var_1198.scriptableparts[param_00].state = self.var_1198.scriptableparts[param_00].state + "_both";
  } else {
    self.var_1198.scriptableparts[param_00].state = param_01;
  }

  self.var_1198.scriptableparts[param_00].time = gettime();
}

func_F592(param_00, param_01, param_02) {
  self endon("entitydeleted");
  func_F591(param_00, param_01);
  if(isDefined(param_02)) {
    wait(param_02);
  }

  if(isDefined(self.var_EF39)) {
    return 1;
  }

  var_03 = self.var_1198.scriptableparts[param_00].state;
  if(isDefined(level.var_5667[self.unittype])) {
    if(param_00 != "head" && var_03 != "dismember") {
      if(func_13077(self.unittype)) {
        var_03 = var_03 + "_lite";
      }
    }
  }

  self setscriptablepartstate(param_00, var_03);
}

func_F6C9(param_00) {
  var_01 = param_00 + "_dism_fx";
  var_02 = func_7C35(param_00);
  if(var_02 == "normal") {
    var_02 = "undamaged";
  } else if(issubstr(var_02, "_both")) {
    var_02 = "dmg_both";
  }

  if(!isDefined(level.var_93A9) && isDefined(level.var_5667[self.unittype])) {
    if(param_00 != "head") {
      if(func_13077(self.unittype)) {
        var_02 = var_02 + "_lite";
      }
    }
  }

  self setscriptablepartstate(var_01, var_02);
}

func_13077(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_5667[param_00].size; var_02++) {
    if(gettime() - level.var_5667[param_00][var_02] > 1000) {
      continue;
    }

    var_01[var_01.size] = level.var_5667[param_00][var_02];
  }

  if(var_01.size < 0) {
    var_01[var_01.size] = gettime();
    level.var_5667[param_00] = var_01;
    return 0;
  }

  level.var_5667[param_00] = var_01;
  return 1;
}

func_7C35(param_00) {
  if(!isDefined(self.var_1198.scriptableparts)) {
    return "normal";
  }

  if(!isDefined(self.var_1198.scriptableparts[param_00])) {
    return "normal";
  }

  return self.var_1198.scriptableparts[param_00].state;
}

func_2040() {
  if(func_7C35("left_leg") == "dismember" || func_7C35("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

func_2EE2() {
  if(func_7C35("left_leg") == "dismember" && func_7C35("right_leg") == "dismember") {
    return 1;
  }

  return 0;
}

func_203F() {
  if(func_7C35("left_arm") == "dismember" || func_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

func_E52D() {
  if(func_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}

func_AB53() {
  if(func_7C35("left_arm") == "dismember") {
    return 1;
  }

  return 0;
}

func_2EE1() {
  if(func_7C35("left_arm") == "dismember" && func_7C35("right_arm") == "dismember") {
    return 1;
  }

  return 0;
}