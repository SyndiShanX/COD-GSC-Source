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

function shootanimtime(var0) {
  if(!usingautomaticweapon() || isDefined(var0) && var0 == 1) {
    var1 = 0.5 + randomfloat(1);
    return (weaponfiretime(self.weapon) * var1);
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

function add_weapon(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 3;
  }

  if(!isDefined(var3)) {
    var2 = 1;
  }

  if(!isDefined(var4)) {
    var4 = "rifle";
  }

  var0 = tolower(var0);
  anim.aiweapon[var0]["type"] = var1;
  anim.aiweapon[var0]["time"] = var2;
  anim.aiweapon[var0]["clipsize"] = var3;
  anim.aiweapon[var0]["anims"] = var4;
}

function addturret(var0) {
  anim.aiweapon[tolower(var0)]["type"] = "turret";
}