/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3170.gsc
************************/

_meth_811C() {
  if(isDefined(self.var_130A9)) {
    var_00 = self getspawnteam();
    return (var_00[0], var_00[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

func_7AA3() {
  var_00 = _meth_811C();
  return var_00;
}

func_7AA2(param_00) {
  var_01 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    var_01 = self.var_1198.shootparams;
  } else if(isDefined(self.asm.shootparams)) {
    var_01 = self.asm.shootparams;
  }

  if(!isDefined(var_01)) {
    return undefined;
  } else if(isDefined(var_01.ent)) {
    return var_01.ent getshootatpos();
  } else if(isDefined(var_01.pos)) {
    return var_01.pos;
  }

  return undefined;
}

func_ADA1(param_00, param_01) {
  self.asm.var_11A90.var_AD94 = lib_0A1E::func_2356(param_01, "aim_1");
  self.asm.var_11A90.var_AD95 = lib_0A1E::func_2356(param_01, "aim_2");
  self.asm.var_11A90.var_AD96 = lib_0A1E::func_2356(param_01, "aim_3");
  self.asm.var_11A90.var_AD97 = lib_0A1E::func_2356(param_01, "aim_4");
  self.asm.var_11A90.var_AD98 = lib_0A1E::func_2356(param_01, "aim_6");
  self.asm.var_11A90.var_AD99 = lib_0A1E::func_2356(param_01, "aim_7");
  self.asm.var_11A90.var_AD9A = lib_0A1E::func_2356(param_01, "aim_8");
  self.asm.var_11A90.var_AD9B = lib_0A1E::func_2356(param_01, "aim_9");
  self.asm.var_58EC = 1;
  self.asm.var_11A90.var_D890 = 0;
  var_02 = lib_0A1E::func_2356(param_01, "aim_knob");
  self give_attacker_kill_rewards(var_02, 1, 0.2, 1);
  self.setdevdvar = -80;
  self.setmatchdatadef = 80;
}

func_CF03(param_00, param_01, param_02, param_03) {
  self.var_1198.var_5D3B = undefined;
  thread lib_0A1E::func_235F(param_00, param_01, param_02, 1, 0);
  func_ADA1(param_00, param_01);
}

func_4756(param_00, param_01, param_02) {
  self.asm.var_58EC = 0;
  var_03 = lib_0A1E::func_2356(param_01, "aim_knob");
  self clearanim(var_03, 0.2);
  self _meth_82D0();
  var_04 = self _meth_8164();
  if(isDefined(var_04) && var_04 == self.asm.turret) {
    self _meth_83AF();
  }

  self.asm.turret.origin = self.asm.var_12A7E;
  self.asm.turret.angles = self.asm.var_12A57;
  self.asm.turret = undefined;
  self.asm.var_12A7E = undefined;
  self.asm.var_12A57 = undefined;
}

func_4725(param_00, param_01, param_02) {
  self.asm.var_58EC = 0;
  var_03 = lib_0A1E::func_2356(param_01, "aim_knob");
  self clearanim(var_03, 0.2);
  self _meth_82D0();
}

func_CEB3(param_00, param_01, param_02, param_03) {
  self.var_1198.var_98F4 = undefined;
  func_AB30(self.var_394);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_AB31(param_00, param_01) {
  if(self _meth_81B7()) {
    return "none";
  }

  self.a.weaponposdropping[param_01] = param_00;
  var_02 = getweaponmodel(param_00);
  var_03 = self gettagorigin("tag_weapon_right");
  var_04 = self gettagangles("tag_weapon_right");
  var_05 = spawn("script_model", var_03);
  var_05 setModel(var_02);
  var_05.angles = var_04;
  self.a.weaponposdropping[param_01] = "none";
  self.var_1198.var_AB58 = var_05;
}

func_AB30(param_00) {
  scripts\anim\shared::func_5390();
  var_01 = self.var_39B[param_00].weaponisauto;
  if(var_01 != "none") {
    thread func_AB31(param_00, var_01);
  }

  scripts\anim\shared::func_5398(param_00);
  if(param_00 == self.var_394) {
    self.var_394 = "none";
  }

  self.var_1198.var_5D3B = 1;
  scripts\anim\shared::func_12E61();
}

func_12A82(param_00, param_01, param_02, param_03) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_8BCD(param_00, param_01, param_02, param_03) {
  return isDefined(self.asm.var_1310E) && self.asm.var_1310E;
}

func_3E9E(param_00, param_01, param_02) {
  if(isDefined(self.var_1198.var_5D3B)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "remount");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
}

func_CEB0(param_00, param_01, param_02, param_03) {
  self.asm.var_1310E = 1;
  var_04 = scripts\asm\asm_bb::bb_getrequestedturret();
  lib_0A1E::func_2366(param_00, param_01, param_02);
  self.asm.var_12A7E = var_04.origin;
  self.asm.var_12A57 = var_04.angles;
  self.asm.turret = var_04;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_C021(param_00, param_01, param_02, param_03) {
  self.asm.var_1310E = 1;
  var_04 = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm.var_12A7E = var_04.origin;
  self.asm.var_12A57 = var_04.angles;
  self.asm.turret = var_04;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_CEB2(param_00, param_01, param_02, param_03) {
  self.asm.var_1310E = undefined;
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_FFE4(param_00, param_01, param_02, param_03) {
  var_04 = isDefined(self.asm.var_1310E) && self.asm.var_1310E;
  if(var_04) {
    var_05 = self _meth_8164();
    var_06 = scripts\asm\asm_bb::bb_getrequestedturret();
    var_07 = isDefined(var_05) && var_05 _meth_8165() == self;
    var_08 = var_07 && isDefined(var_06) && var_06 == var_05;
    return !var_08;
  }

  var_09 = scripts\asm\asm::func_BCE7(var_04, var_05, var_06, var_07);
  var_0A = scripts\asm\shared_utility::isatcovernode();
  return var_09 || !var_0A;
}

func_CEAF(param_00, param_01, param_02, param_03) {
  if(isDefined(self.target_getindexoftarget)) {
    self.var_1198.var_522F = self.target_getindexoftarget;
    self.sendmatchdata = 1;
  }

  self.var_4C93 = ::func_C0C0;
  self.var_1198.var_98F4 = 1;
  var_04 = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  if(isDefined(self.target_getindexoftarget)) {
    if(isDefined(self.var_1198.var_5D3B)) {
      self _meth_80F1(self.target_getindexoftarget.origin, self.angles);
      self orientmode("face angle", self.target_getindexoftarget.angles[1]);
    } else {
      var_05 = getangledelta(var_04);
      var_06 = self.target_getindexoftarget.angles[1] - var_05;
      self orientmode("face angle", var_06);
    }
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  self endon(param_01 + "_finished");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_2369(param_00, param_01, var_04);
  var_07 = lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  if(var_07 == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_116E7(param_00, param_01, param_02) {
  self.var_4C93 = undefined;
}

func_CEB1(param_00, param_01, param_02, param_03) {
  self.var_1198.var_522F = undefined;
  self.var_1198.var_98F4 = undefined;
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_C0C0(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "pistol_holster":
      scripts\anim\shared::placeweaponon(self.var_394, "none");
      break;

    case "lmg_pickup":
      self.var_1198.var_AB58 delete();
      self.var_1198.var_AB58 = undefined;
      scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

func_B0E9(param_00, param_01, param_02, param_03) {
  if(isDefined(self.target_getindexoftarget)) {
    var_04 = self.target_getindexoftarget _meth_8169();
    if(!scripts\engine\utility::array_contains(var_04, "over")) {
      return param_03 == "high";
    }

    return param_03 == "stand";
  }

  return 0;
}

func_527F(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_1198.var_E1AF)) {
    return self.var_1198.var_E1AF == param_03;
  }

  return 0;
}