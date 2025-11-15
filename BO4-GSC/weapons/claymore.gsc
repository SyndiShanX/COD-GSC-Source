/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\claymore.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\proximity_grenade;
#include scripts\weapons\weaponobjects;

#namespace claymore;

autoexec __init__system__() {
  system::register(#"claymore", &init_shared, undefined, undefined);
}

init_shared() {
  weaponobjects::function_e6400478("claymore", &createclaymorewatcher, 0);
}

createclaymorewatcher(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = undefined;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.deleteonplayerspawn = 0;
  watcher.detectiondot = cos(70);
  watcher.detectionmindist = 20;
  watcher.detectiongraceperiod = 0.6;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &function_c9893179;
  watcher.stun = &weaponobjects::weaponstun;
  watcher.var_994b472b = &function_aeb91d3;
}

function_aeb91d3(player) {
  self weaponobjects::weaponobjectfizzleout();
}

function_c9893179(watcher, player) {
  proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
  self.weapon = getweapon(#"claymore");
}