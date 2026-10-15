/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\trapd.gsc
***********************************************/

#include scripts\weapons\molotov;
#include scripts\weapons\proximity_grenade;
#include scripts\weapons\weaponobjects;

#namespace trapd;

function_ae7e49da(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 0;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = undefined;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.detectiondot = cos(70);
  watcher.detectionmindist = 20;
  watcher.detectiongraceperiod = 0.6;
  watcher.stuntime = 3;
  watcher.notequipment = 1;
  watcher.activationdelay = 0.5;
  watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
  watcher.stun = &weaponobjects::weaponstun;
  return watcher;
}

function_1daa29fc(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 0;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.detectionmindist = 64;
  watcher.detectiongraceperiod = 0.6;
  watcher.stuntime = 3;
  watcher.notequipment = 1;
  watcher.activationdelay = 0.5;
  watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
  watcher.stun = &weaponobjects::weaponstun;
  return watcher;
}

function_d8d3b49b(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 0;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.detectionmindist = 64;
  watcher.detectiongraceperiod = 0.6;
  watcher.stuntime = 3;
  watcher.notequipment = 1;
  watcher.activationdelay = 0.5;
  watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
  watcher.stun = &weaponobjects::weaponstun;
  return watcher;
}

function_518130e(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 0;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.detectionmindist = 64;
  watcher.detectiongraceperiod = 0.6;
  watcher.stuntime = 3;
  watcher.notequipment = 1;
  watcher.activationdelay = 0.5;
  watcher.ondetonatecallback = &function_367f94ba;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
  watcher.stun = &weaponobjects::weaponstun;
  return watcher;
}

function_367f94ba(attacker, weapon, target) {
  self.killcament.starttime = gettime();
  self molotov::function_462c8632(self.owner, self.origin, (0, 0, 1), (0, 0, -400), self.killcament, weapon, self.team, getscriptbundle(self.weapon.customsettings));
  self hide();
  wait 10;
  self delete();
}