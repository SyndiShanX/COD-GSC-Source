/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\weapons.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\weapons;

#namespace weapons;

autoexec __init__system__() {
  system::register(#"weapons", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}