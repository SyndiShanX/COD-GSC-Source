/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\emp_debuff_cp.gsc
***********************************************/

function emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", &getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", &setplayerempimmune);
}

function getplayerempimmune() {
  return isDefined(self.empnotallowed);
}

function setplayerempimmune(var0) {
  if(!isDefined(self.empnotallowed)) {
    self.empnotallowed = 0;
  }

  if(var0) {
    self.empnotallowed--;

    if(self.empnotallowed == 0) {
      self.empnotallowed = undefined;
      return;
    }

    return;
  }

  self.empnotallowed++;
}