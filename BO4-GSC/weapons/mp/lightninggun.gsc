/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\lightninggun.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\lightninggun;

#namespace lightninggun;

autoexec __init__system__() {
  system::register(#"lightninggun", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}