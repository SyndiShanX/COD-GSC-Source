/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\grenade_response.gsc
***********************************************/

grenadereturnthrow(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade_response", "return throw complete"))
    return anim.success;

  scripts\asm\asm_bb::bb_requestgrenadereturnthrow(1);
  return anim.running;
}

grenadereturnthrow_terminate(var_0) {
  scripts\asm\asm_bb::bb_requestgrenadereturnthrow(0);
}

shouldgrenadeavoid(var_0) {
  if(isDefined(self.grenade) && distancesquared(self.grenade.origin, self.origin) < 90000)
    return anim.success;

  return anim.failure;
}

cangrenaderespond(var_0) {
  if(istrue(self.disablegrenaderesponse))
    return anim.failure;

  return anim.success;
}