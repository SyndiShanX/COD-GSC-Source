/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_99f0716c659bcca.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace zm_hatchet;

function private autoexec __init__system__() {
  system::register(#"zm_hatchet", &init, undefined, undefined, undefined);
}

function init() {
  level.playthrowhatchet = &function_e879ee6d;
  level.createhatchetwatcher = &function_1679806a;
}

function private function_1679806a(s_watcher) {
  s_watcher.onspawnretrievetriggers = &function_4ba658e5;
  s_watcher.pickup = &function_4ba658e5;
  s_watcher.deleteonplayerspawn = 0;
}

function private function_e879ee6d(hatchet) {
  hatchet endon(#"delete", #"death");

  while(true) {
    var_51b88026 = hatchet waittill(#"grenade_stuck");

    if(!isDefined(var_51b88026.hitent) || !isactor(var_51b88026.hitent)) {
      continue;
    }

    if(isalive(var_51b88026.hitent)) {
      var_51b88026.hitent waittill(#"death");
    }

    hatchet unlink();
    waitframe(1);
    hatchet.angles = (hatchet.angles[0] + 90, 0, 0);
    hatchet launch((0, 0, -0.5));
  }
}

function function_4ba658e5(s_watcher, player) {}