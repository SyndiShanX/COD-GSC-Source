/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\proximity_grenade.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\proximity_grenade;

#namespace proximity_grenade;

autoexec __init__system__() {
  system::register(#"proximity_grenade", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}