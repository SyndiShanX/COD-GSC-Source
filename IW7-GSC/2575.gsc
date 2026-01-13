/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 2575.gsc
***********************************************/

func_9898(var_0) {
  self.acceptablemeleefraction = 0.95;
  self.var_B627 = 36;
  self.fnismeleevalid = ::ismeleevalid;
  self.fnmeleecharge_init = ::meleecharge_init_mp;
  self.fnmeleecharge_terminate = ::meleecharge_terminate_mp;
  self.fnmeleevsplayer_init = ::meleevsplayer_init_mp;
  self.fnmeleevsplayer_terminate = ::meleevsplayer_terminate_mp;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return anim.success;
}

canmovefrompointtopoint(var_0, var_1) {
  var_2 = navtrace(var_0, var_1, self, 1);
  var_3 = var_2["fraction"];

  if(var_3 >= self.acceptablemeleefraction) {
    var_4 = 0;
  } else {
    var_4 = 1;
  }

  return !var_4;
}

ismeleevalid(var_0, var_1) {
  if(scripts\asm\asm_bb::bb_ismissingaleg()) {
    return 0;
  }

  if(!scripts\aitypes\melee::ismeleevalid_common(var_0, var_1)) {
    return 0;
  }

  var_2 = scripts\aitypes\melee::gettargetchargepos(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!canmovefrompointtopoint(self.origin, var_2)) {
    return 0;
  }

  return 1;
}

meleecharge_init_mp(var_0) {
  self scragentsetscripted(1);
}

meleecharge_terminate_mp(var_0) {
  self scragentsetscripted(0);
  self _meth_8484();
}

meleevsplayer_init_mp(var_0) {
  self scragentsetscripted(1);
}

meleevsplayer_terminate_mp(var_0) {
  self scragentsetscripted(0);
  self _meth_8484();
}