/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3185.gsc
**************************************/

_id_3F00(var_0, var_1, var_2, var_3) {
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
    } else
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
  } else if(self.damageyaw > 45 && self.damageyaw <= 135)
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
  else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    if(scripts\engine\utility::is_true(var_3) && !isDefined(self.slappymelee)) {
      if(randomint(100) > 50) {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "forward");
      } else {
        var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "backward");
      }
    } else
      var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "backward");
  } else
    var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");

  return var_4;
}

_id_CF0E(var_0, var_1, var_2, var_3) {
  self scragentsetphysicsmode("gravity");
  self _meth_8281("anim deltas");
  _id_0F3C::_id_CEA8(var_0, var_1, var_2);
}

_id_3EE2(var_0, var_1, var_2) {
  return _id_3F00(var_0, var_1, var_2, 1);
}