/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2575.gsc
************************/

func_9898(param_00) {
  self.acceptablemeleefraction = 0.95;
  self.var_B627 = 36;
  self.fnismeleevalid = ::ismeleevalid;
  self.fnmeleecharge_init = ::meleecharge_init_mp;
  self.fnmeleecharge_terminate = ::meleecharge_terminate_mp;
  self.fnmeleevsplayer_init = ::meleevsplayer_init_mp;
  self.fnmeleevsplayer_terminate = ::meleevsplayer_terminate_mp;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return level.success;
}

canmovefrompointtopoint(param_00, param_01) {
  var_02 = navtrace(param_00, param_01, self, 1);
  var_03 = var_02["fraction"];
  if(var_03 >= self.acceptablemeleefraction) {
    var_04 = 0;
  } else {
    var_04 = 1;
  }

  return !var_04;
}

ismeleevalid(param_00, param_01) {
  if(scripts\asm\asm_bb::bb_ismissingaleg()) {
    return 0;
  }

  if(!scripts\aitypes\melee::ismeleevalid_common(param_00, param_01)) {
    return 0;
  }

  var_02 = scripts\aitypes\melee::gettargetchargepos(param_00);
  if(!isDefined(var_02)) {
    return 0;
  }

  if(!canmovefrompointtopoint(self.origin, var_02)) {
    return 0;
  }

  return 1;
}

meleecharge_init_mp(param_00) {
  self scragentsetscripted(1);
}

meleecharge_terminate_mp(param_00) {
  self scragentsetscripted(0);
  self _meth_8484();
}

meleevsplayer_init_mp(param_00) {
  self scragentsetscripted(1);
}

meleevsplayer_terminate_mp(param_00) {
  self scragentsetscripted(0);
  self _meth_8484();
}