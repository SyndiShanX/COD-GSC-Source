/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3123.gsc
************************/

bb_requestcombatmovetype_facemotion() {
  self.var_1198.combatmode_old = 0;
  self.var_1198.bwantstostrafe = 0;
}

bb_requestcombatmovetype_strafe() {
  self.var_1198.combatmode_old = 1;
  self.var_1198.bwantstostrafe = 1;
}

func_295B() {
  self.var_1198.combatmode_old = 2;
  self.var_1198.bwantstostrafe = 0;
}

func_298C() {
  if(!isDefined(self.var_1198.combatmode_old) || self.var_1198.combatmode_old == 0) {
    return 1;
  }

  return 0;
}

func_298D() {
  if(isDefined(self.var_1198.combatmode_old) && self.var_1198.combatmode_old == 2) {
    return 1;
  }

  return 0;
}

func_2979(param_00) {
  self.var_1198.var_2AA1 = param_00;
  if(param_00) {
    self.dontevershoot = 1;
  }
}

func_2921() {
  if(!isDefined(self.var_1198.var_2AA1)) {
    return 0;
  }

  return self.var_1198.var_2AA1;
}