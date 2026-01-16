/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3145.gsc
*********************************************/

func_3FCE(var_0, var_1, var_2, var_3) {
  self.asm.var_7360 = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self func_8504(0);
  self.ispreloadzonescomplete = 0;
}

func_3EC5(var_0, var_1, var_2) {
  if(isDefined(self.asm.var_1269B)) {
    var_3 = self.asm.var_1269B;
    if(var_1 == "trans_out_stand_idle") {
      self.asm.var_1269B = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

  var_3 = lib_0A1E::func_235D(var_2);
  self.asm.var_1269B = var_3;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_3EC4(var_0, var_1, var_2) {
  if(isDefined(self.asm.var_3FDC)) {
    var_3 = self.asm.var_3FDC;
    if(var_1 == "trans_out_combat_react") {
      self.asm.var_3FDC = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

  var_4 = self.asm.var_1269B;
  if(scripts\engine\utility::cointoss()) {
    var_5 = var_4 + "_a";
  } else {
    var_5 = var_5 + "_b";
  }

  self.asm.var_3FDC = var_5;
  return scripts\asm\asm::asm_lookupanimfromalias(var_2, var_5);
}

func_3FD4(var_0, var_1, var_2, var_3) {
  scripts\anim\combat::func_F296();
  var_4 = self.var_164D[var_0];
  if(isDefined(var_4.var_10E23) && var_4.var_10E23 == "trans_out_stand_idle") {
    childthread scripts\asm\shared_utility::setuseanimgoalweight(var_1, var_2);
  }

  if(isDefined(self.node)) {
    self._blackboard.var_AA3D = self.node;
  }

  lib_0A1E::func_235F(var_0, var_1, var_2, 1);
}

func_3FD3(var_0, var_1, var_2, var_3) {
  self.ispreloadzonescomplete = 1;
  lib_0C65::func_CEB5(var_0, var_1, var_2, var_3);
}

func_3FD5(var_0, var_1, var_2, var_3) {
  self.ispreloadzonescomplete = 1;
  lib_0F3D::func_D4DD(var_0, var_1, var_2, var_3);
}

func_3FD6(var_0, var_1, var_2, var_3) {
  self.ispreloadzonescomplete = 1;
  lib_0C65::func_D514(var_0, var_1, var_2, var_3);
}

func_3FD1(var_0, var_1, var_2) {
  self.ispreloadzonescomplete = 0;
}

func_A00A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

func_3FE1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291D() == var_3;
}

func_FFE3(var_0, var_1, var_2, var_3) {
  if(func_A00A() || scripts\asm\asm_bb::func_291D() == "combat") {
    var_4 = self.asm.var_1269B;
    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07") {
      return 1;
    }
  }

  return 0;
}

func_FFDF(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::func_291D() == "noncombat") {
    var_4 = self.asm.var_1269B;
    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07") {
      return 1;
    }
  }

  return 0;
}

func_FFD2(var_0, var_1, var_2, var_3) {
  self.asm.var_3FDC = undefined;
  return 1;
}