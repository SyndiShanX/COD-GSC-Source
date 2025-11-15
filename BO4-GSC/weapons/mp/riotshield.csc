/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\riotshield.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\riotshield;

#namespace riotshield;

autoexec __init__system__() {
  system::register(#"riotshield", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}