/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3065.gsc
**************************************/

_id_33FF(var_0) {
  self._id_87F6 = 1;
  _id_0BFE::_id_97F9();
  _id_0A10::_id_3376();
  self.bt._id_71CC = _id_0BFE::_id_F1F1;
  return anim.success;
}

_id_336F(var_0) {
  scripts\asm\asm_bb::bb_requestsmartobject("crouch");
}

_id_336E(var_0) {
  if(!isDefined(self.grenade)) {
    return anim.success;
  }

  return anim.running;
}

_id_3370(var_0) {
  scripts\asm\asm_bb::bb_requestsmartobject("stand");
}

_id_846E(var_0) {
  if(!isDefined(self.grenade)) {
    return anim.failure;
  }

  if(!isDefined(self.pathgoalpos)) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw")) {
    return anim.success;
  }

  return anim.running;
}

_id_846F(var_0) {}

_id_85C1(var_0) {
  scripts\asm\asm_bb::_id_2964(1);
}

_id_85C3(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw complete")) {
    return anim.success;
  }

  if(!isDefined(self.grenade)) {
    return anim.success;
  }

  return anim.running;
}

_id_85C2(var_0) {
  scripts\asm\asm_bb::_id_2964(undefined);
}

_id_335B(var_0) {
  if(_id_0A0B::_id_7C35("torso") == "dismember") {
    return anim.failure;
  }

  return _id_0A18::_id_3928(var_0);
}