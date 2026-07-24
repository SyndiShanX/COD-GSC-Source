/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3145.gsc
**************************************/

_id_3FCE(var_0, var_1, var_2, var_3) {
  self.asm._id_7360 = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self _meth_8504(0);
  self.script_pushable = 0;
}

_id_3EC5(var_0, var_1, var_2) {
  if(isDefined(self.asm._id_1269B)) {
    var_3 = self.asm._id_1269B;

    if(var_1 == "trans_out_stand_idle") {
      self.asm._id_1269B = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  } else {
    var_3 = _id_0A1E::_id_235D(var_1);
    self.asm._id_1269B = var_3;
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }
}

_id_3EC4(var_0, var_1, var_2) {
  if(isDefined(self.asm._id_3FDC)) {
    var_3 = self.asm._id_3FDC;

    if(var_1 == "trans_out_combat_react") {
      self.asm._id_3FDC = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  } else {
    var_4 = self.asm._id_1269B;

    if(scripts\engine\utility::cointoss()) {
      var_5 = var_4 + "_a";
    } else {
      var_5 = var_4 + "_b";
    }

    self.asm._id_3FDC = var_5;
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
  }
}

_id_3FD4(var_0, var_1, var_2, var_3) {
  scripts\anim\combat::_id_F296();
  var_4 = self._id_164D[var_0];

  if(isDefined(var_4._id_10E23) && var_4._id_10E23 == "trans_out_stand_idle") {
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, var_2);
  }

  if(isDefined(self.node)) {
    self._blackboard._id_AA3D = self.node;
  }

  _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
}

_id_3FD3(var_0, var_1, var_2, var_3) {
  self.script_pushable = 1;
  _id_0C65::_id_CEB5(var_0, var_1, var_2, var_3);
}

_id_3FD5(var_0, var_1, var_2, var_3) {
  self.script_pushable = 1;
  _id_0F3D::_id_D4DD(var_0, var_1, var_2, var_3);
}

_id_3FD6(var_0, var_1, var_2, var_3) {
  self.script_pushable = 1;
  _id_0C65::_id_D514(var_0, var_1, var_2, var_3);
}

_id_3FD1(var_0, var_1, var_2) {
  self.script_pushable = 0;
}

_id_A00A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

_id_3FE1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291D() == var_3;
}

_id_FFE3(var_0, var_1, var_2, var_3) {
  if(_id_A00A() || scripts\asm\asm_bb::_id_291D() == "combat") {
    var_4 = self.asm._id_1269B;

    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07") {
      return 1;
    }
  }

  return 0;
}

_id_FFDF(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::_id_291D() == "noncombat") {
    var_4 = self.asm._id_1269B;

    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07") {
      return 1;
    }
  }

  return 0;
}

_id_FFD2(var_0, var_1, var_2, var_3) {
  self.asm._id_3FDC = undefined;
  return 1;
}