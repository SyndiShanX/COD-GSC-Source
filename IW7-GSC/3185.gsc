/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3185.gsc
************************/

func_3F00(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_E3)) {
    self.var_E3 = 0;
  }

  if(isDefined(self.slappymelee)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "slappy");
  }

  if(!scripts\engine\utility::istrue(self.entered_playspace) || isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "forward");
  }

  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    if(scripts\engine\utility::istrue(param_03) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "forward");
      } else {
        var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "backward");
      }
    } else {
      var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "forward");
    }
  } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
    var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "right");
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    if(scripts\engine\utility::istrue(var_04) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "forward");
      } else {
        var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "backward");
      }
    } else {
      var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "backward");
    }
  } else {
    var_04 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "left");
  }

  return var_04;
}

func_CF0E(param_00, param_01, param_02, param_03) {
  self gib_fx_override("gravity");
  self ghostlaunched("anim deltas");
  lib_0F3C::func_CEA8(param_00, param_01, param_02);
}

func_3EE2(param_00, param_01, param_02) {
  return func_3F00(param_00, param_01, param_02, 1);
}