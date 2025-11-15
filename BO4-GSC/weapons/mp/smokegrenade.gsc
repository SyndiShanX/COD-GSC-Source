/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\smokegrenade.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\smokegrenade;

#namespace smokegrenade;

autoexec __init__system__() {
  system::register(#"smokegrenade", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}