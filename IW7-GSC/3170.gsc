/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3170.gsc
**************************************/

_id_811C() {
  if(isDefined(self._id_130A9)) {
    var_0 = self _meth_8143();
    return (var_0[0], var_0[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

_id_7AA3() {
  var_0 = _id_811C();
  return var_0;
}

_id_7AA2(var_0) {
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

_id_ADA1(var_0, var_1) {
  self.asm._id_11A90._id_AD94 = _id_0A1E::_id_2356(var_1, "aim_1");
  self.asm._id_11A90._id_AD95 = _id_0A1E::_id_2356(var_1, "aim_2");
  self.asm._id_11A90._id_AD96 = _id_0A1E::_id_2356(var_1, "aim_3");
  self.asm._id_11A90._id_AD97 = _id_0A1E::_id_2356(var_1, "aim_4");
  self.asm._id_11A90._id_AD98 = _id_0A1E::_id_2356(var_1, "aim_6");
  self.asm._id_11A90._id_AD99 = _id_0A1E::_id_2356(var_1, "aim_7");
  self.asm._id_11A90._id_AD9A = _id_0A1E::_id_2356(var_1, "aim_8");
  self.asm._id_11A90._id_AD9B = _id_0A1E::_id_2356(var_1, "aim_9");
  self.asm._id_58EC = 1;
  self.asm._id_11A90._id_D890 = 0;
  var_2 = _id_0A1E::_id_2356(var_1, "aim_knob");
  self _meth_82A2(var_2, 1.0, 0.2, 1.0);
  self.rightaimlimit = -80;
  self.leftaimlimit = 80;
}

_id_CF03(var_0, var_1, var_2, var_3) {
  self._blackboard._id_5D3B = undefined;
  thread _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0, 0);
  _id_ADA1(var_0, var_1);
}

_id_4756(var_0, var_1, var_2) {
  self.asm._id_58EC = 0;
  var_3 = _id_0A1E::_id_2356(var_1, "aim_knob");
  self clearanim(var_3, 0.2);
  self _meth_82D0();
  var_4 = self _meth_8164();

  if(isDefined(var_4) && var_4 == self.asm.turret) {
    self _meth_83AF();
  }

  self.asm.turret.origin = self.asm._id_12A7E;
  self.asm.turret.angles = self.asm._id_12A57;
  self.asm.turret = undefined;
  self.asm._id_12A7E = undefined;
  self.asm._id_12A57 = undefined;
}

_id_4725(var_0, var_1, var_2) {
  self.asm._id_58EC = 0;
  var_3 = _id_0A1E::_id_2356(var_1, "aim_knob");
  self clearanim(var_3, 0.2);
  self _meth_82D0();
}

_id_CEB3(var_0, var_1, var_2, var_3) {
  self._blackboard._id_98F4 = undefined;
  _id_AB30(self.weapon);
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_AB31(var_0, var_1) {
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
  self._blackboard._id_AB58 = var_5;
}

_id_AB30(var_0) {
  scripts\anim\shared::_id_5390();
  var_1 = self.weaponinfo[var_0].position;

  if(var_1 != "none") {
    thread _id_AB31(var_0, var_1);
  }

  scripts\anim\shared::_id_5398(var_0);

  if(var_0 == self.weapon) {
    self.weapon = "none";
  }

  self._blackboard._id_5D3B = 1;
  scripts\anim\shared::_id_12E61();
}

_id_12A82(var_0, var_1, var_2, var_3) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

_id_8BCD(var_0, var_1, var_2, var_3) {
  return isDefined(self.asm._id_1310E) && self.asm._id_1310E;
}

_id_3E9E(var_0, var_1, var_2) {
  if(isDefined(self._blackboard._id_5D3B)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "remount");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

_id_CEB0(var_0, var_1, var_2, var_3) {
  self.asm._id_1310E = 1;
  var_4 = scripts\asm\asm_bb::bb_getrequestedturret();
  _id_0A1E::_id_2366(var_0, var_1, var_2);
  self.asm._id_12A7E = var_4.origin;
  self.asm._id_12A57 = var_4.angles;
  self.asm.turret = var_4;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

_id_C021(var_0, var_1, var_2, var_3) {
  self.asm._id_1310E = 1;
  var_4 = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm._id_12A7E = var_4.origin;
  self.asm._id_12A57 = var_4.angles;
  self.asm.turret = var_4;
  self _meth_83D7(scripts\asm\asm_bb::bb_getrequestedturret());
}

_id_CEB2(var_0, var_1, var_2, var_3) {
  self.asm._id_1310E = undefined;
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_FFE4(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.asm._id_1310E) && self.asm._id_1310E;

  if(var_4) {
    var_5 = self _meth_8164();
    var_6 = scripts\asm\asm_bb::bb_getrequestedturret();
    var_7 = isDefined(var_5) && var_5 _meth_8165() == self;
    var_8 = var_7 && isDefined(var_6) && var_6 == var_5;
    return !var_8;
  } else {
    var_9 = scripts\asm\asm::_id_BCE7(var_0, var_1, var_2, var_3);
    var_10 = scripts\asm\shared\utility::isatcovernode();
    return var_9 || !var_10;
  }
}

_id_CEAF(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node)) {
    self._blackboard._id_522F = self.node;
    self.keepclaimednodeifvalid = 1;
  }

  self._id_4C93 = ::_id_C0C0;
  self._blackboard._id_98F4 = 1;
  var_4 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  if(isDefined(self.node)) {
    if(isDefined(self._blackboard._id_5D3B)) {
      self _meth_80F1(self.node.origin, self.angles);
      self orientmode("face angle", self.node.angles[1]);
    } else {
      var_5 = getangledelta(var_4);
      var_6 = self.node.angles[1] - var_5;
      self orientmode("face angle", var_6);
    }
  } else
    self orientmode("face angle", self.angles[1]);

  self endon(var_1 + "_finished");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1.0, var_2, 1.0);
  _id_0A1E::_id_2369(var_0, var_1, var_4);
  var_7 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_7 == "end") {
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }
}

_id_116E7(var_0, var_1, var_2) {
  self._id_4C93 = undefined;
}

_id_CEB1(var_0, var_1, var_2, var_3) {
  self._blackboard._id_522F = undefined;
  self._blackboard._id_98F4 = undefined;
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_C0C0(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "pistol_holster":
      scripts\anim\shared::placeweaponon(self.weapon, "none");
      break;
    case "lmg_pickup":
      self._blackboard._id_AB58 delete();
      self._blackboard._id_AB58 = undefined;
      scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

_id_B0E9(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node)) {
    var_4 = self.node _meth_8169();

    if(!scripts\engine\utility::array_contains(var_4, "over")) {
      return var_3 == "high";
    }

    return var_3 == "stand";
  }

  return 0;
}

_id_527F(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard._id_E1AF)) {
    return self._blackboard._id_E1AF == var_3;
  }

  return 0;
}