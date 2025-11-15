/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_designator_grenade.gsc
*******************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

designator_Start(killstreakName, designatorName, onTargetAcquiredCallback) {
  AssertEx(isDefined(onTargetAcquiredCallback), "designator onTargetAcquiredCallback must be specified for " + designatorName);

  self endon("death");
  self.marker = undefined;

  if(self GetCurrentWeapon() == designatorName) {
    self thread designator_DisableUsabilityDuringGrenadePullback(designatorName);
    self thread designator_WaitForGrenadeFire(killstreakName, designatorName, onTargetAcquiredCallback);

    self designator_WaitForWeaponChange(designatorName);

    return (!(self GetAmmoCount(designatorName) && self HasWeapon(designatorName)));
  }

  return false;
}

designator_DisableUsabilityDuringGrenadePullback(designatorName) {
  self endon("death");
  self endon("disconnect");

  usedWeaponName = "";
  while(usedWeaponName != designatorName) {
    self waittill("grenade_pullback", usedWeaponName);
  }

  self _disableUsability();
  self designator_EnableUsabilityWhenDesignatorFinishes();
}

designator_EnableUsabilityWhenDesignatorFinishes() {
  self endon("death");
  self endon("disconnect");

  self waittill_any("grenade_fire", "weapon_change");
  self _enableUsability();
}

designator_WaitForGrenadeFire(killstreakName, designatorName, callbackFunc) {
  self endon("designator_finished");

  self endon("spawned_player");
  self endon("disconnect");

  designatorGrenade = undefined;
  usedWeaponName = "";
  while(usedWeaponName != designatorName) {
    self waittill("grenade_fire", designatorGrenade, usedWeaponName);
  }

  if(IsAlive(self)) {
    designatorGrenade.owner = self;
    designatorGrenade.weaponName = designatorName;

    self.marker = designatorGrenade;

    self thread designator_OnTargetAcquired(killstreakName, designatorGrenade, callbackFunc);
  } else {
    designatorGrenade Delete();
  }

  self notify("designator_finished");
}

designator_WaitForWeaponChange(designatorName) {
  self endon("spawned_player");
  self endon("disconnect");

  currentWeapon = self getCurrentWeapon();
  while(currentWeapon == designatorName) {
    self waittill("weapon_change", currentWeapon);
  }

  if(self GetAmmoCount(designatorName) == 0) {
    self designator_RemoveDesignatorAndRestorePreviousWeapon(designatorName);
  }

  self notify("designator_finished");
}

designator_RemoveDesignatorAndRestorePreviousWeapon(designatorName) {
  if(self HasWeapon(designatorName)) {
    self TakeWeapon(designatorName);

  }
}

designator_OnTargetAcquired(killstreakName, designatorGrenade, onTargetAcquiredCallback) {
  designatorGrenade waittill("missile_stuck", stuckTo);

  if(isDefined(designatorGrenade.owner)) {
    self thread[[onTargetAcquiredCallback]](killstreakName, designatorGrenade);
  }

  if(isDefined(designatorGrenade)) {
    designatorGrenade Delete();
  }
}