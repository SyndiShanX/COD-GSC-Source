/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3123.gsc
************************/

bb_requestcombatmovetype_facemotion() {
  self._blackboard.combatmode_old = 0;
  self._blackboard.bwantstostrafe = 0;
}

bb_requestcombatmovetype_strafe() {
  self._blackboard.combatmode_old = 1;
  self._blackboard.bwantstostrafe = 1;
}

func_295B() {
  self._blackboard.combatmode_old = 2;
  self._blackboard.bwantstostrafe = 0;
}

func_298C() {
  if(!isDefined(self._blackboard.combatmode_old) || self._blackboard.combatmode_old == 0) {
    return 1;
  }

  return 0;
}

func_298D() {
  if(isDefined(self._blackboard.combatmode_old) && self._blackboard.combatmode_old == 2) {
    return 1;
  }

  return 0;
}

func_2979(var_0) {
  self._blackboard.var_2AA1 = var_0;
  if(var_0) {
    self.dontevershoot = 1;
  }
}

func_2921() {
  if(!isDefined(self._blackboard.var_2AA1)) {
    return 0;
  }

  return self._blackboard.var_2AA1;
}