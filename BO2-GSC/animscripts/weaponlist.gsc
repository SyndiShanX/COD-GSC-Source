/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\weaponlist.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\combat_utility;

usingautomaticweapon() {
  if(self.weapon == "none" || !self animscripts\utility::holdingweapon())
    return false;

  if(weaponissemiauto(self.weapon))
    return false;

  if(weaponisboltaction(self.weapon))
    return false;

  class = self.weaponclass;

  if(class == "rifle" || class == "mg" || class == "smg")
    return true;

  return false;
}

usingsemiautoweapon() {
  return weaponissemiauto(self.weapon);
}

autoshootanimrate() {
  if(usingautomaticweapon())
    return 0.1 / weaponfiretime(self.weapon) * getdvarfloat(#"_id_DA8BDE9E");
  else
    return 0.2;
}

burstshootanimrate() {
  if(usingautomaticweapon())
    return 0.16 / weaponfiretime(self.weapon);
  else
    return 0.2;
}

waitaftershot() {
  return 0.25;
}

shootanimtime(semiautofire) {
  if(!usingautomaticweapon() || isDefined(semiautofire) && semiautofire == 1) {
    rand = 0.5 + randomfloat(1);
    return weaponfiretime(self.weapon) * rand;
  } else
    return weaponfiretime(self.weapon);
}

refillclip() {
  assert(isDefined(self.weapon), "self.weapon is not defined for " + self.model);

  if(self.weapon == "none") {
    self.bulletsinclip = 0;
    return false;
  }

  if(self.weaponclass == "rocketlauncher") {
    if(!self.a.rocketvisible)
      self thread animscripts\combat_utility::showrocketwhenreloadisdone();

    if(self.a.rockets <= 0)
      self.a.rockets = weaponclipsize(self.weapon);
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  assert(isDefined(self.bulletsinclip), "RefillClip failed");

  if(self.bulletsinclip <= 0)
    return false;
  else
    return true;
}

precacheweaponswitchfx() {
}