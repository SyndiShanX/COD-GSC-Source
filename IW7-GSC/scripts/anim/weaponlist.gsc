/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\weaponlist.gsc
***************************************/

usingautomaticweapon() {
  return weaponisauto(self.var_394) || weaponisbeam(self.var_394) || weaponburstcount(self.var_394) > 0;
}

usingsemiautoweapon() {
  return weaponissemiauto(self.var_394);
}

autoshootanimrate() {
  if(usingautomaticweapon()) {
    return 0.1 / weaponfiretime(self.var_394);
  }

  return 0.5;
}

burstshootanimrate() {
  if(usingautomaticweapon()) {
    return 0.1 / weaponfiretime(self.var_394);
  }

  return 0.2;
}

waitaftershot() {
  return 0.25;
}

shootanimtime(param_00) {
  if(!usingautomaticweapon() || isDefined(param_00) && param_00 == 1) {
    var_01 = 0.5 + randomfloat(1);
    return weaponfiretime(self.var_394) * var_01;
  }

  return weaponfiretime(self.var_394);
}

refillclip() {
  if(self.var_394 == "none") {
    self.bulletsinclip = 0;
    return 0;
  }

  if(!isDefined(self.bulletsinclip)) {
    self.bulletsinclip = weaponclipsize(self.var_394);
  } else {
    self.bulletsinclip = weaponclipsize(self.var_394);
  }

  if(self.bulletsinclip <= 0) {
    return 0;
  }

  return 1;
}

add_weapon(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_02)) {
    param_02 = 3;
  }

  if(!isDefined(param_03)) {
    param_02 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = "rifle";
  }

  param_00 = tolower(param_00);
  level.aiweapon[param_00]["type"] = param_01;
  level.aiweapon[param_00]["time"] = param_02;
  level.aiweapon[param_00]["clipsize"] = param_03;
  level.aiweapon[param_00]["anims"] = param_04;
}

addturret(param_00) {
  level.aiweapon[tolower(param_00)]["type"] = "turret";
}