/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\emp_debuff_cp.gsc
***********************************************/

emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", ::getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", ::setplayerempimmune);
}

getplayerempimmune() {
  return isDefined(self.empnotallowed);
}

setplayerempimmune(_id_780166328E815D00) {
  if(!isDefined(self.empnotallowed))
    self.empnotallowed = 0;

  if(_id_780166328E815D00) {
    self.empnotallowed--;

    if(self.empnotallowed == 0)
      self.empnotallowed = undefined;
  } else
    self.empnotallowed++;
}