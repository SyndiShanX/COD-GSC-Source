/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\grenades.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\weapons\weaponobjects;

#namespace grenades;

init_shared() {
  weaponobjects::function_e6400478(#"eq_sticky_grenade", &creategrenadewatcher, 1);
  weaponobjects::function_e6400478(#"concussion_grenade", &creategrenadewatcher, 1);
  weaponobjects::function_e6400478(#"hash_5825488ac68418af", &creategrenadewatcher, 1);
}

creategrenadewatcher(watcher) {
  watcher.onspawn = &function_aa95d684;
}

function_aa95d684(watcher, player) {
  self clientfield::set("enemyequip", 1);
  self thread function_5f86757d();
}

function_5f86757d() {
  level endon(#"game_ended");
  self waittill(#"explode", #"death");

  if(!isDefined(self)) {
    return;
  }

  self clientfield::set("enemyequip", 0);
}