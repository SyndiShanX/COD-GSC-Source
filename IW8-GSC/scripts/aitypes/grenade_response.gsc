/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\grenade_response.gsc
************************************************/

function grenadereturnthrow(var0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade_response", "return throw complete")) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestgrenadereturnthrow(1);
  return anim.running;
}

function grenadereturnthrow_terminate(var0) {
  scripts\asm\asm_bb::bb_requestgrenadereturnthrow(0);
}

function shouldgrenadeavoid(var0) {
  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) < 90000) {
    return anim.success;
  }

  return anim.failure;
}

function cangrenaderespond(var0) {
  if(istrue(self.disablegrenaderesponse)) {
    return anim.failure;
  }

  return anim.success;
}