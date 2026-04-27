/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\weaponlist.gsc
********************************************************/

#using_animtree("generic_human");

usingAutomaticWeapon() {
  return (WeaponIsAuto(self.weapon) || WeaponBurstCount(self.weapon) > 0);
}

usingSemiAutoWeapon() {
  return (weaponIsSemiAuto(self.weapon));
}

autoShootAnimRate() {
  if(usingAutomaticWeapon()) {
    return 0.1 / weaponFireTime(self.weapon);
  } else {
    return 0.5;
  }
}

burstShootAnimRate() {
  if(usingAutomaticWeapon()) {
    return 0.1 / weaponFireTime(self.weapon);
  } else {
    return 0.2;
  }
}

waitAfterShot() {
  return 0.25;
}

shootAnimTime(semiAutoFire) {
  if(!usingAutomaticWeapon() || (isDefined(semiAutofire) && (semiAutofire == true))) {
    rand = 0.5 + randomfloat(1);
    return weaponFireTime(self.weapon) * rand;
  } else {
    return weaponFireTime(self.weapon);
  }
}

RefillClip() {
  assertEX(isDefined(self.weapon), "self.weapon is not defined for " + self.model);

  if(self.weapon == "none") {
    self.bulletsInClip = 0;
    return false;
  }

  if(weaponClass(self.weapon) == "rocketlauncher") {
    if(!self.a.rocketVisible)
      self thread animscripts\combat_utility::showRocketWhenReloadIsDone();
  }

  if(!isDefined(self.bulletsInClip)) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  } else {
    self.bulletsInClip = weaponClipSize(self.weapon);
  }

  assertEX(isDefined(self.bulletsInClip), "RefillClip failed");

  if(self.bulletsInClip <= 0)
    return false;
  else
    return true;
}

add_weapon(name, type, time, clipsize, anims) {
  assert(isDefined(name));
  assert(isDefined(type));
  if(!isDefined(time))
    time = 3.0;
  if(!isDefined(clipsize))
    time = 1;
  if(!isDefined(anims))
    anims = "rifle";

  name = tolower(name);
  anim.AIWeapon[name]["type"] = type;
  anim.AIWeapon[name]["time"] = time;
  anim.AIWeapon[name]["clipsize"] = clipsize;
  anim.AIWeapon[name]["anims"] = anims;
}

addTurret(turret) {
  anim.AIWeapon[tolower(turret)]["type"] = "turret";
}