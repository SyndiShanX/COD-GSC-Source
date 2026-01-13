/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3170.gsc
************************/

_meth_811C() {
  if(isDefined(self.var_130A9)) {
    var_0 = self getspawnteam();
    return (var_0[0], var_0[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

func_7AA3() {
  var_0 = _meth_811C();
  return var_0;
}

func_7AA2(var_0) {
  var_1 = undefined;
  if(isDefined(self._blackboard.shootparams)) {
    var_1 = self._blackboard.shootparams;
  } else if(isDefined(self.asm.shootparams)) {
    var_1 = self.asm.shootparams;
  }

  if(!isDefined(var_1)) {
    return undefined;
  } else if(isDefined(var_1.ent)) {
    return var_1.ent getshootatpos();
  } else if(isDefined(var_1.pos)) {
    return var_1.pos;
  }

  return undefined;
}

func_ADA1(var_0, var_1) {
  self.asm.var_11A90.var_AD94 = lib_0A1E::func_2356(var_1, "aim_1");
  self.asm.var_11A90.var_AD95 = lib_0A1E::func_2356(var_1, "aim_2");
  self.asm.var_11A90.var_AD96 = lib_0A1E::func_2356(var_1, "aim_3");
  self.asm.var_11A90.var_AD97 = lib_0A1E::func_2356(var_1, "aim_4");
  self.asm.var_11A90.var_AD98 = lib_0A1E::func_2356(var_1, "aim_6");
  self.asm.var_11A90.var_AD99 = lib_0A1E::func_2356(var_1, "aim_7");
  self.asm.var_11A90.var_AD9A = lib_0A1E::func_2356(var_1, "aim_8");
  self.asm.var_11A90.var_AD9B = lib_0A1E::func_2356(var_1, "aim_9");
  self.asm.var_58EC = 1;
  self.asm.var_11A90.var_D890 = 0;
  var_2 = lib_0A1E::func_2356(var_1, "aim_knob");
  self give_attacker_kill_rewards(var_2, 1, 0.2, 1);
  self.setdevdvar = -80;
  self.setmatchdatadef = 80;
}

func_CF03(var_0, var_1, var_2, var_3) {
  self._blackboard.var_5D3B = undefined;
  thread lib_0A1E::func_235F(var_0, var_1, var_2, 1, 0);
  func_ADA1(var_0, var_1);
}

func_4756(var_0, var_1, var_2) {
  self.asm.var_58EC = 0;
  var_3 = lib_0A1E::func_2356(var_1, "aim_knob");
  self clearanim(var_3, 0.2);
  self _meth_82D0();
  var_4 = self _meth_8164();
  if(isDefined(var_4) && var_4 == self.asm.turret) {
    self _meth_83AF();
  }

  self.asm.turret.origin = self.asm.var_12A7E;
  self.asm.turret.angles = self.asm.var_12A57;
  self.asm.turret = undefined;
  self.asm.var_12A7E = undefined;
  self.asm.var_12A57 = undefined;
}

func_4725(var_0, var_1, var_2) {
  self.asm.var_58EC = 0;
  var_3 = lib_0A1E::func_2356(var_1, "aim_knob");
  self clearanim(var_3, 0.2);
  self _meth_82D0();
}

func_CEB3(var_0, var_1, var_2, var_3) {
  self._blackboard.var_98F4 = undefined;
  func_AB30(self.var_394);
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_AB31(var_0, var_1) {
  if(self _meth_81B7()) {
    return "none";
  }

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = getweaponmodel(var_0);
  var_3 = self gettagorigin("tag_weapon_right");
  var_4 = self gettagangles("tag_weapon_right");
  var_5 = spawn("script_model", var_3);
  var_5 setModel(var_2);
  var_5.angles = var_4;
  self.a.weaponposdropping[var_1] = "none";
  self._blackboard.var_AB58 = var_5;
}

func_AB30(var_0) {
  scripts\anim\shared::func_5390();
  var_1 = self.var_39B[var_0].weaponisauto;
  if(var_1 != "none") {
    thread func_AB31(var_0, var_1);
  }

  scripts\anim\shared::func_5398(var_0);
  if(var_0 == self.var_394) {
    self.var_394 = "none";
  }

  self._blackboard.var_5D3B = 1;
  scripts\anim\shared::func_12E61();
}

func_12A82(var_0, var_1, var_2, var_3) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_8BCD(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm.var_1310E) && self.asm.var_1310E;
}

func_3E9E(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.var_5D3B)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "remount");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

func_CEB0(var_0, var_1, var_2, var_3) {
  self.asm.var_1310E = 1;
  var_4 = scripts\asm\asm_bb::bb_getrequestedturret();
  lib_0A1E::func_2366(var_0, var_1, var_2);
  self.asm.var_12A7E = var_4.origin;
  self.asm.var_12A57 = var_4.angles;
  self.asm.turret = var_4;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_C021(var_0, var_1, var_2, var_3) {
  self.asm.var_1310E = 1;
  var_4 = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm.var_12A7E = var_4.origin;
  self.asm.var_12A57 = var_4.angles;
  self.asm.turret = var_4;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

func_CEB2(var_0, var_1, var_2, var_3) {
  self.asm.var_1310E = undefined;
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_FFE4(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.asm.var_1310E) && self.asm.var_1310E;
  if(var_4) {
    var_5 = self _meth_8164();
    var_6 = scripts\asm\asm_bb::bb_getrequestedturret();
    var_7 = isDefined(var_5) && var_5 _meth_8165() == self;
    var_8 = var_7 && isDefined(var_6) && var_6 == var_5;
    return !var_8;
  }

  var_9 = scripts\asm\asm::func_BCE7(var_4, var_5, var_6, var_7);
  var_0A = scripts\asm\shared_utility::isatcovernode();
  return var_9 || !var_0A;
}

func_CEAF(var_0, var_1, var_2, var_3) {
  if(isDefined(self.target_getindexoftarget)) {
    self._blackboard.var_522F = self.target_getindexoftarget;
    self.sendmatchdata = 1;
  }

  self.var_4C93 = ::func_C0C0;
  self._blackboard.var_98F4 = 1;
  var_4 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  if(isDefined(self.target_getindexoftarget)) {
    if(isDefined(self._blackboard.var_5D3B)) {
      self _meth_80F1(self.target_getindexoftarget.origin, self.angles);
      self orientmode("face angle", self.target_getindexoftarget.angles[1]);
    } else {
      var_5 = getangledelta(var_4);
      var_6 = self.target_getindexoftarget.angles[1] - var_5;
      self orientmode("face angle", var_6);
    }
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  self endon(var_1 + "_finished");
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  var_7 = lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  if(var_7 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

func_116E7(var_0, var_1, var_2) {
  self.var_4C93 = undefined;
}

func_CEB1(var_0, var_1, var_2, var_3) {
  self._blackboard.var_522F = undefined;
  self._blackboard.var_98F4 = undefined;
  lib_0A1E::func_2364(var_0, var_1, var_2);
}

func_C0C0(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "pistol_holster":
      scripts\anim\shared::placeweaponon(self.var_394, "none");
      break;

    case "lmg_pickup":
      self._blackboard.var_AB58 delete();
      self._blackboard.var_AB58 = undefined;
      scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

func_B0E9(var_0, var_1, var_2, var_3) {
  if(isDefined(self.target_getindexoftarget)) {
    var_4 = self.target_getindexoftarget _meth_8169();
    if(!scripts\engine\utility::array_contains(var_4, "over")) {
      return var_3 == "high";
    }

    return var_3 == "stand";
  }

  return 0;
}

func_527F(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.var_E1AF)) {
    return self._blackboard.var_E1AF == var_3;
  }

  return 0;
}