/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\weaponlist.gsc
***********************************************/

usingautomaticweapon() {
  return weaponisauto(self.weapon) || weaponisbeam(self.weapon) || weaponburstcount(self.weapon) > 0;
}

usingsemiautoweapon() {
  return weaponissemiauto(self.weapon) || weaponburstcount(self.weapon) == 1;
}

autoshootanimrate() {
  if(usingautomaticweapon())
    return 0.1 / weaponfiretime(self.weapon);
  else
    return 0.5;
}

burstshootanimrate() {
  if(usingautomaticweapon())
    return 0.1 / weaponfiretime(self.weapon);
  else if(_id_2B79931B08683E0A::usingpistol())
    return 1;
  else
    return 0.2;
}

waitaftershot() {
  return 0.25;
}

shootanimtime(_id_CA751625CC66A1F0) {
  if(!usingautomaticweapon() || isDefined(_id_CA751625CC66A1F0) && _id_CA751625CC66A1F0 == 1) {
    _id_00AE14C5A8B1B582 = 0.5 + randomfloat(1);
    return weaponfiretime(self.weapon) * _id_00AE14C5A8B1B582;
  } else
    return weaponfiretime(self.weapon);
}

refillclip() {
  if(isnullweapon(self.weapon)) {
    self.bulletsinclip = 0;
    return 0;
  }

  if(!isDefined(self.bulletsinclip))
    self.bulletsinclip = weaponclipsize(self.weapon);
  else
    self.bulletsinclip = weaponclipsize(self.weapon);
}

add_weapon(name, type, time, clipsize, anims) {
  if(!isDefined(time))
    time = 3.0;

  if(!isDefined(clipsize))
    time = 1;

  if(!isDefined(anims))
    anims = "rifle";

  name = tolower(name);
  anim.aiweapon[name]["type"] = type;
  anim.aiweapon[name]["time"] = time;
  anim.aiweapon[name]["clipsize"] = clipsize;
  anim.aiweapon[name]["anims"] = anims;
}

addturret(turret) {
  anim.aiweapon[tolower(turret)]["type"] = "turret";
}