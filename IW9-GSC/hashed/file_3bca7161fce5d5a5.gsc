/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3bca7161fce5d5a5.gsc
***********************************************/

choosestandingdeathanim(asmname, statename, params, bmoving) {
  if(!isDefined(self.damageyaw))
    self.damageyaw = 0;

  if(isDefined(self._id_7FD86AD1EEB439F0))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "slappy");

  if(!istrue(self.entered_playspace) || isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "forward");

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(istrue(bmoving) && !isDefined(self._id_7FD86AD1EEB439F0)) {
      if(randomint(100) > 50)
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "forward");
      else
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "backward");
    } else
      deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "forward");
  } else if(self.damageyaw > 45 && self.damageyaw <= 135)
    deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "right");
  else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    if(istrue(bmoving) && !isDefined(self._id_7FD86AD1EEB439F0)) {
      if(randomint(100) > 50)
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "forward");
      else
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "backward");
    } else
      deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "backward");
  } else
    deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "left");

  return deathanim;
}

playdeathanim(asmname, statename, params) {
  self animmode("gravity");
  self animmode("angle deltas");
  scripts\asm\shared\utility::playanim(asmname, statename);
}

choosemovingdeathanim(asmname, statename, params) {
  return choosestandingdeathanim(asmname, statename, params, 1);
}