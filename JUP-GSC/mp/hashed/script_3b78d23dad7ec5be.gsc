/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3b78d23dad7ec5be.gsc
*************************************************/

#using script_4a8c20678bd6a83e;
#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace zombie_knockdown;

function private autoexec init() {
  registersharedfunc("zombie", "knockdownZombie", &knockdown_ai);
  registersharedfunc("zombie", "isZombieInKnockdown", &function_e67a89537ae7d4b7);
}

function knockdown_ai(source_pos) {
  if(istrue(self.disallow_knockdown)) {
    return;
  }

  if(!isDefined(source_pos)) {
    return;
  }

  if(is_traversing()) {
    return;
  }

  if(!self asmhasstate(self.asmname, "knockdown_in")) {
    return;
  }

  self._blackboard.var_a2f67f5b76db39ca = source_pos;
  self._blackboard.zombieinknockdown = 1;
  function_ac90fa5cc0a80298("knockdown_in");
}

function function_e67a89537ae7d4b7() {
  return istrue(self._blackboard.zombieinknockdown);
}