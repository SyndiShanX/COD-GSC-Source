/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3142.gsc
************************/

func_3535() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("damage");
    if(!isDefined(self.var_1198.var_2ABA) && self.var_DE != "MOD_IMPACT") {
      var_00 = 1;
      self.var_1198.var_2ABA = 1;
    } else {
      var_00 = isexplosivedamagemod(self.var_DE) && self.var_E1 > 50;
    }

    var_01 = isexplosivedamagemod(self.var_DE);
    if(var_00) {
      func_3559(1);
    }
  }
}

func_3620() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("damage_subpart", var_00);
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;
    var_04 = 0;
    foreach(var_06 in var_00) {
      if(isexplosivedamagemod(var_06.type)) {
        var_02 = var_02 + var_06.var_3C;
      }

      var_01 = var_01 + var_06.var_3C;
      if(self _meth_850C(var_06.updategamerprofileall, var_06.spawnscriptitem) <= 0) {
        var_03 = 1;
      }

      if(var_06.type != "MOD_IMPACT") {
        var_04 = 1;
      }
    }

    if(!isDefined(self.var_1198.var_2ABA) && var_04) {
      var_08 = 1;
      self.var_1198.var_2ABA = 1;
    } else {
      var_08 = var_02 > 50 || var_03;
    }

    if(var_08) {
      func_3559(1);
    }
  }
}

func_3559(param_00) {
  if(self.a.var_5605) {
    return;
  }

  if(isDefined(self.asm.var_2AD2)) {
    return;
  }

  if(gettime() < self.var_1198.timeoff + 5000) {
    return;
  }

  foreach(var_06, var_02 in self.var_164D) {
    if(isDefined(var_02.var_2F3C)) {
      var_03 = var_02.var_4BC0;
      var_04 = level.asm[var_06].states[var_03];
      if(!isDefined(var_04.var_C87F)) {
        continue;
      }

      var_05 = level.asm[var_06].states[var_04.var_C87F];
      if(param_00) {
        self.var_1198.var_A983 = gettime();
      }

      self.var_1198.timeoff = gettime();
      scripts\asm\asm::asm_setstate(var_04.var_C87F);
      break;
    }
  }
}

func_D4EE(param_00, param_01, param_02, param_03) {
  self.asm.var_2AD2 = 1;
  var_04 = self[[self.var_7191]](param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82EA(param_01, var_04, 1, param_02, 1);
  lib_0A1E::func_231F(param_00, param_01);
}

func_4109(param_00, param_01, param_02) {
  self.asm.var_2AD2 = undefined;
}

func_3EE4(param_00, param_01, param_02) {
  var_03 = self.var_1198.var_A983 == gettime();
  var_04 = lib_0A1E::func_7E5A();
  if(var_03) {
    var_05 = var_04;
  } else {
    var_05 = var_05 + "_small";
  }

  var_06 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_05);
  if(!var_03 || func_8C21(var_06)) {
    return var_06;
  }

  return lib_0A1E::func_2356(param_01, "default");
}

func_D542(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.asm.var_2AD2 = 1;
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, lib_0A1E::asm_getallanimsforstate(param_00, param_01), 1, param_02);
  lib_0A1E::func_231F(param_00, param_01);
}

func_CF37(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.asm.var_2AD2 = 1;
  var_04 = lib_0A1E::func_2356(param_01, "enter");
  var_05 = lib_0A1E::func_2356(param_01, "recover");
  var_06 = max(0, self.empstartcallback - getanimlength(var_04) - getanimlength(var_05));
  if(var_06 > 0) {
    self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
    self _meth_82AB(lib_0A1E::func_2356(param_01, "stun"), 1, param_02);
    wait(var_06);
  }

  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_CF1C(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.asm.var_2AD2 = 1;
  if(!scripts\asm\asm_bb::bb_isselfdestruct() && !isDefined(self.var_30E9) || !self.var_30E9) {
    self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
    self _meth_82AB(lib_0A1E::func_2356(param_01, "stun"), 1, param_02);
    wait(level.var_3546);
  }

  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_411A(param_00, param_01, param_02) {
  self.asm.var_2AD2 = undefined;
}

func_8C21(param_00) {
  var_01 = getmovedelta(param_00);
  var_02 = self _meth_84AC();
  var_03 = rotatevector(var_01, self.angles);
  var_04 = var_02 + var_03;
  if(self maymovefrompointtopoint(var_02, var_04, 0, 1)) {
    return 1;
  }

  return 0;
}

func_3527(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
  }

  var_03 = lib_0A1E::func_7E5A();
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_35D7(param_00, param_01, param_02, param_03) {
  self stoploopsound();
  if(isDefined(self.var_3135.var_71C9)) {
    [[self.var_3135.var_71C9]]();
  }

  if(isDefined(self.var_E601)) {
    self.var_E601 delete();
  }

  if(isDefined(self.asm.var_F1FD)) {
    func_F1FD();
    return;
  }

  if(self.a.nodeath == 1) {
    lib_0C60::func_4E36();
    return;
  }

  if(isDefined(self.var_4E46)) {
    var_04 = self[[self.var_4E46]]();
    if(!isDefined(var_04)) {
      var_04 = 1;
    }

    if(var_04) {
      return;
    }
  }

  if(isDefined(self.var_4E2A)) {
    var_05 = self.var_4E2A;
  } else {
    var_06 = level.asm[param_01].states[param_02].var_71A5;
    var_05 = self[[var_06]](param_00, param_01, param_03);
  }

  if(!isDefined(self.asm.var_4E73)) {
    self getyawtoenemy("vox_c12_death", "vox_c12_death", 1);
  }

  playFXOnTag(level.var_7649["c12_implode_buildup"], self, "j_spinelowerbottom");
  self clearanim(lib_0A1E::func_2342(), param_02);
  self _meth_82EA(param_01, var_05, 1, param_02);
  self endon("terminate_death_thread");
  lib_0A1E::func_231F(param_00, param_01);
  self notify("endPlayDeathAnim");
  var_07 = self gettagorigin("j_spinelowerbottom");
  playFX(level.var_7649["c12_implode_explosion"], var_07);
  func_35A5();
  playrumbleonposition("heavy_1s", var_07);
  earthquake(1, 0.5, var_07, 1200);
  scripts\engine\utility::waitframe();
  lib_0C60::func_4E36();
  self delete();
}

func_F1FD() {
  var_00 = self gettagorigin("j_spinelowerbottom");
  playFX(level.var_7649["c12_selfdestruct_explosion"], var_00);
  func_35FD();
  scripts\engine\utility::waitframe();
  if(isDefined(self.var_3135.var_71C9)) {
    [[self.var_3135.var_71C9]]();
  }

  var_00 = self.origin + (0, 0, 60);
  radiusdamage(var_00 + (0, 0, 32), 512, 150, 20, self);
  physicsexplosionsphere(var_00, 1000, 50, 1);
  level.player playrumbleonentity("heavy_1s");
  earthquake(2.25, 0.3, var_00, 1200);
  level thread func_F20A(var_00);
  lib_0C60::func_4E36();
  destroynavrepulsor("c12_selfdestruct");
  self delete();
}

func_F20A(param_00) {
  var_01 = spawn("script_origin", param_00);
  var_01 playSound("c12_self_destruct", "sounddone");
  var_01 waittill("sounddone");
  var_01 delete();
}

func_35A5() {
  level thread func_F20A(self.origin);
  func_3539("implode");
}

func_35FD() {
  var_00 = [];
  if(self getscriptablepartstate("head") == "rodeofinal") {
    var_00[var_00.size] = "head";
  }

  func_3539("selfdestruct");
}

func_3539(param_00, param_01) {
  var_02 = ["head", "torso", "left_arm", "right_arm", "left_leg", "right_leg", "hip_pack_left", "hip_pack_right"];
  if(isDefined(self.asm.var_4E73)) {
    if(!isDefined(param_01)) {
      param_01 = [];
    }

    param_01 = scripts\engine\utility::array_combine(param_01, ["head", "torso", "left_arm", "right_arm", "hip_pack_left", "hip_pack_right"]);
  }

  if(isDefined(param_01)) {
    var_02 = scripts\engine\utility::array_remove_array(var_02, param_01);
  }

  foreach(var_04 in var_02) {
    if(self getscriptablepartstate(var_04) == "dismember") {
      continue;
    }

    self setscriptablepartstate(var_04 + "_death_fx", param_00);
  }
}