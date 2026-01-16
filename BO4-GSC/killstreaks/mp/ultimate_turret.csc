/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ultimate_turret.csc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;
#include scripts\killstreaks\ultimate_turret_shared;

#namespace ultimate_turret;

autoexec __init__system__() {
  system::register(#"ultimate_turret", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  bundle = struct::get_script_bundle("killstreak", "killstreak_ultimate_turret");
  killstreak_vehicle::init_killstreak(bundle);
}