/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3185.gsc
***********************************************/

func_3F00(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.damageyaw)) {
    self.damageyaw = 0;
  }

  if(isDefined(self.slappymelee)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "slappy");
  }

  if(!scripts\engine\utility::is_true(self.entered_playspace) || isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(scripts\engine\utility::is_true(var_3) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
      } else {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "backward");
      }
    } else {
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
    }
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
  }
  else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    if(scripts\engine\utility::is_true(var_3) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
      } else {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "backward");
      }
    } else {
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "backward");
    }
  } else {
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
  }

  return var_4;
}

func_CF0E(var_0, var_1, var_2, var_3) {
  self scragentsetphysicsmode("gravity");
  self ghostlaunched("anim deltas");
  lib_0F3C::func_CEA8(var_0, var_1, var_2);
}

func_3EE2(var_0, var_1, var_2) {
  return func_3F00(var_0, var_1, var_2, 1);
}