/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3065.gsc
************************/

func_33FF(param_00) {
  self.var_87F6 = 1;
  lib_0BFE::func_97F9();
  lib_0A10::func_3376();
  self.var_3135.var_71CC = ::lib_0BFE::func_F1F1;
  return level.success;
}

func_336F(param_00) {
  scripts\asm\asm_bb::bb_requestsmartobject("crouch");
}

func_336E(param_00) {
  if(!isDefined(self.objective_position)) {
    return level.success;
  }

  return level.running;
}

func_3370(param_00) {
  scripts\asm\asm_bb::bb_requestsmartobject("stand");
}

_meth_846E(param_00) {
  if(!isDefined(self.objective_position)) {
    return level.failure;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw")) {
    return level.success;
  }

  return level.running;
}

forceplaygestureviewmodel(param_00) {}

_meth_85C1(param_00) {
  scripts\asm\asm_bb::func_2964(1);
}

_meth_85C3(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw complete")) {
    return level.success;
  }

  if(!isDefined(self.objective_position)) {
    return level.success;
  }

  return level.running;
}

_meth_85C2(param_00) {
  scripts\asm\asm_bb::func_2964(undefined);
}

func_335B(param_00) {
  if(lib_0A0B::func_7C35("torso") == "dismember") {
    return level.failure;
  }

  return lib_0A18::func_3928(param_00);
}