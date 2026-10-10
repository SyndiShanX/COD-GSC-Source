/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_686729055b66c6e4.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace zombie_stun;

function private autoexec init() {
  registersharedfunc("zombie", "stunZombie", &stun_ai);
  registersharedfunc("zombie", "clearStunZombie", &clear_stun);
}

function processstun(taskid, params) {
  if(!is_stunned()) {
    return anim.failure;
  }

  self clearpath();
  return anim.running;
}

function stun_ai(duration) {
  if(isDefined(self.aisettings) && !istrue(self.aisettings.var_836834377fb9b633)) {
    return;
  }

  if(istrue(self.disallow_stun)) {
    return;
  }

  assert(isDefined(duration));

  if(!isDefined(self.asmname)) {
    return;
  }

  if(!self asmhasstate(self.asmname, "stun_in")) {
    return;
  }

  end_time = gettime() + int(duration * 1000);

  if(isDefined(self.var_b40984b29c45936d) && self.var_b40984b29c45936d > end_time) {
    return;
  }

  self._blackboard.var_e42e5f8ee06d791d = end_time;
  self._blackboard.var_8b915e6d74944598 = 1;
  function_ac90fa5cc0a80298("stun_in");
}

function is_stunned() {
  return isDefined(self._blackboard.var_e42e5f8ee06d791d) && gettime() < self._blackboard.var_e42e5f8ee06d791d;
}

function clear_stun() {
  if(isDefined(self._blackboard)) {
    self._blackboard.var_e42e5f8ee06d791d = 0;
    self._blackboard.var_8b915e6d74944598 = 0;
  }
}