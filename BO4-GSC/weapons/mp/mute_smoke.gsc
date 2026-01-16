/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\mute_smoke.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\mute_smoke;

#namespace mute_smoke;

autoexec __init__system__() {
  system::register(#"mute_smoke", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}