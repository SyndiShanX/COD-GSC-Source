/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2572.gsc
**************************************/

_id_10020(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw", 0)) {
    return anim.success;
  }

  return anim.failure;
}

_id_85D3(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw complete")) {
    return anim.success;
  }

  scripts\asm\asm_bb::_id_2964(1);
  return anim.running;
}

_id_85D4(var_0) {
  scripts\asm\asm_bb::_id_2964(undefined);
}

_id_1001E(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "avoid", 0)) {
    return anim.success;
  }

  return anim.failure;
}

_id_85B0(var_0) {
  var_1 = spawnStruct();
  var_1._id_6393 = gettime() + 10000;
  var_1._id_4767 = 0;
  self.bt.instancedata[var_0] = var_1;
  scripts\asm\asm_bb::_id_2963(1);
  _id_0A0A::_id_41A3(var_0);
}

_id_85B1(var_0) {
  self.bt.instancedata[var_0] = undefined;
  scripts\asm\asm_bb::_id_2963(undefined);
}

_id_85AF(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = gettime();

  if(!isDefined(var_1._id_85BA) && !isDefined(self.grenade)) {
    var_1._id_85BA = var_2;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade dive", "end")) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade cower", "end")) {
    var_1._id_4767 = 1;

    if(isDefined(var_1._id_85BA)) {
      var_1._id_6393 = var_2;
    } else {
      var_3 = 3000;
      var_1._id_6393 = var_2 + var_3;
    }
  }

  if(var_1._id_4767) {
    if(isDefined(var_1._id_85BA) && var_2 - var_1._id_85BA > 500) {
      return anim.success;
    }
  } else if(!isDefined(self.grenade))
    return anim.success;

  if(var_2 > var_1._id_6393) {
    return anim.success;
  }

  return anim.running;
}