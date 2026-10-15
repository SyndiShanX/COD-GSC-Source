/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\spawnbeacon.csc
***********************************************/

#include scripts\core_common\spawnbeacon_shared;
#include scripts\core_common\system_shared;

#namespace spawn_beacon;

autoexec __init__system__() {
  system::register(#"spawnbeacon", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
}