/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\trophy_system;

#namespace trophy_system;

autoexec __init__system__() {
  system::register(#"trophy_system", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}