/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3145.gsc
************************/

func_3FCE(param_00, param_01, param_02, param_03) {
  self.asm.var_7360 = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self _meth_8504(0);
  self.ispreloadzonescomplete = 0;
}

func_3EC5(param_00, param_01, param_02) {
  if(isDefined(self.asm.var_1269B)) {
    var_03 = self.asm.var_1269B;
    if(param_01 == "trans_out_stand_idle") {
      self.asm.var_1269B = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  }

  var_03 = lib_0A1E::func_235D(param_02);
  self.asm.var_1269B = var_03;
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_3EC4(param_00, param_01, param_02) {
  if(isDefined(self.asm.var_3FDC)) {
    var_03 = self.asm.var_3FDC;
    if(param_01 == "trans_out_combat_react") {
      self.asm.var_3FDC = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
  }

  var_04 = self.asm.var_1269B;
  if(scripts\engine\utility::cointoss()) {
    var_05 = var_04 + "_a";
  } else {
    var_05 = var_05 + "_b";
  }

  self.asm.var_3FDC = var_05;
  return scripts\asm\asm::asm_lookupanimfromalias(param_02, var_05);
}

func_3FD4(param_00, param_01, param_02, param_03) {
  scripts\anim\combat::func_F296();
  var_04 = self.var_164D[param_00];
  if(isDefined(var_04.var_10E23) && var_04.var_10E23 == "trans_out_stand_idle") {
    childthread scripts\asm\shared_utility::setuseanimgoalweight(param_01, param_02);
  }

  if(isDefined(self.target_getindexoftarget)) {
    self.var_1198.var_AA3D = self.target_getindexoftarget;
  }

  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

func_3FD3(param_00, param_01, param_02, param_03) {
  self.ispreloadzonescomplete = 1;
  lib_0C65::func_CEB5(param_00, param_01, param_02, param_03);
}

func_3FD5(param_00, param_01, param_02, param_03) {
  self.ispreloadzonescomplete = 1;
  lib_0F3D::func_D4DD(param_00, param_01, param_02, param_03);
}

func_3FD6(param_00, param_01, param_02, param_03) {
  self.ispreloadzonescomplete = 1;
  lib_0C65::func_D514(param_00, param_01, param_02, param_03);
}

func_3FD1(param_00, param_01, param_02) {
  self.ispreloadzonescomplete = 0;
}

func_A00A(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

func_3FE1(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::func_291D() == param_03;
}

func_FFE3(param_00, param_01, param_02, param_03) {
  if(func_A00A() || scripts\asm\asm_bb::func_291D() == "combat") {
    var_04 = self.asm.var_1269B;
    if(var_04 == "civ02" || var_04 == "civ04" || var_04 == "civ06" || var_04 == "civ07") {
      return 1;
    }
  }

  return 0;
}

func_FFDF(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::func_291D() == "noncombat") {
    var_04 = self.asm.var_1269B;
    if(var_04 == "civ02" || var_04 == "civ04" || var_04 == "civ06" || var_04 == "civ07") {
      return 1;
    }
  }

  return 0;
}

func_FFD2(param_00, param_01, param_02, param_03) {
  self.asm.var_3FDC = undefined;
  return 1;
}