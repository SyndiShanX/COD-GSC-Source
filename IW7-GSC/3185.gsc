/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3185.gsc
*********************************************/

func_3F00(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_E3)) {
    self.var_E3 = 0;
  }

  if(isDefined(self.slappymelee)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "slappy");
  }

  if(!scripts\engine\utility::istrue(self.entered_playspace) || isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  }

  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    if(scripts\engine\utility::istrue(var_3) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
      } else {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "backward");
      }
    } else {
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "forward");
    }
  } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "right");
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    if(scripts\engine\utility::istrue(var_4) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "forward");
      } else {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "backward");
      }
    } else {
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "backward");
    }
  } else {
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "left");
  }

  return var_4;
}

func_CF0E(var_0, var_1, var_2, var_3) {
  self gib_fx_override("gravity");
  self ghostlaunched("anim deltas");
  lib_0F3C::func_CEA8(var_0, var_1, var_2);
}

func_3EE2(var_0, var_1, var_2) {
  return func_3F00(var_0, var_1, var_2, 1);
}