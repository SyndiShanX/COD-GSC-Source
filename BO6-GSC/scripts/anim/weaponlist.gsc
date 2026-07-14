/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\weaponlist.gsc
***************************************/

#using scripts\anim\utility_common;
#namespace weaponlist;

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

  if(utility_common::ispistol(self.weapon)) {
    return 1;
  }

  return 0.2;
}

function waitaftershot() {
  return 0.25;
}

function shootanimtime(semiautofire) {
  if(!usingautomaticweapon() || semiautofire == 1) {
    rand = 0.5 + randomfloat(1);
    return (weaponfiretime(self.weapon) * rand);
  }

  return weaponfiretime(self.weapon);
}

function refillclip() {
  assert(isDefined(self.weapon), "<dev string:x24>" + self.model);

  if(isnullweapon(self.weapon)) {
    self.bulletsinclip = 0;
    return 0;
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  assert(self.bulletsinclip > 0, "<dev string:x47>");
}

function add_weapon(name, type, time, clipsize, anims) {
  assert(isDefined(name));
  assert(isDefined(type));

  if(!isDefined(time)) {
    time = 3;
  }

  if(!isDefined(clipsize)) {
    time = 1;
  }

  if(!isDefined(anims)) {
    anims = "rifle";
  }

  name = tolower(name);
  anim.aiweapon[name]["type"] = type;
  anim.aiweapon[name]["time"] = time;
  anim.aiweapon[name]["clipsize"] = clipsize;
  anim.aiweapon[name]["anims"] = anims;
}

function addturret(turret) {
  anim.aiweapon[tolower(turret)]["type"] = "turret";
}