/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\emp_debuff_cp.gsc
***********************************************/

#using scripts\engine\utility;
#namespace emp_debuff_cp;

function emp_debuff_init() {
  registersharedfunc("emp", "getPlayerEMPImmune", &getplayerempimmune);
  registersharedfunc("emp", "setPlayerEMPImmune", &setplayerempimmune);
}

function getplayerempimmune() {
  return isDefined(self.empnotallowed);
}

function setplayerempimmune(isimmune) {
  if(!isDefined(self.empnotallowed)) {
    self.empnotallowed = 0;
  }

  if(isimmune) {
    assertex(self.empnotallowed > 0, "allow_emp(true) called when emp was already allowed.");
    self.empnotallowed--;

    if(self.empnotallowed == 0) {
      self.empnotallowed = undefined;
    }

    return;
  }

  self.empnotallowed++;
}