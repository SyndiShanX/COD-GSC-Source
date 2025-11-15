/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreaks.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;

#namespace killstreaks;

autoexec __init__system__() {
  system::register(#"killstreaks", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  killstreak_vehicle::init();
}