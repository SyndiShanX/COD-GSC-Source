/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\weaponlist.gsc
***********************************************/

function usingautomaticweapon() {
  return weaponisauto(self.weapon) || weaponisbeam(self.weapon) || weaponburstcount(self.weapon) > 0;
}

function usingsemiautoweapon() {
  return weaponissemiauto(self.weapon) || weaponburstcount(self.weapon) == 1;
}

function autoshootanimrate() {
  if(usingautomaticweapon()) {
    return (0.1 / weaponfiretime(self.weapon));
  }

  return 0.5;
}

function burstshootanimrate() {
  if(usingautomaticweapon()) {
    return (0.1 / weaponfiretime(self.weapon));
  }

  if(scripts\anim\utility_common::usingpistol()) {
    return 1;
  }

  return 0.2;
}

function waitaftershot() {
  return 0.25;
}

function shootanimtime(var_0) {
  if(!usingautomaticweapon() || isDefined(var_0) && var_0 == 1) {
    var_1 = 0.5 + randomfloat(1);
    return (weaponfiretime(self.weapon) * var_1);
  }

  return weaponfiretime(self.weapon);
}

function refillclip() {
  if(nullweapon(self.weapon)) {
    self.bulletsinclip = 0;
    return 0;
  }

  if(!isDefined(self.bulletsinclip)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
  } else {
    self.bulletsinclip = weaponclipsize(self.weapon);
  }

  if(self.bulletsinclip <= 0) {
    return 0;
  }

  return 1;
}

function add_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  if(!isDefined(var_3)) {
    var_2 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = "rifle";
  }

  var_0 = tolower(var_0);
  anim.aiweapon[var_0]["type"] = var_1;
  anim.aiweapon[var_0]["time"] = var_2;
  anim.aiweapon[var_0]["clipsize"] = var_3;
  anim.aiweapon[var_0]["anims"] = var_4;
}

function addturret(var_0) {
  anim.aiweapon[tolower(var_0)]["type"] = "turret";
}