/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\shockrifle.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\shockrifle;

#namespace shockrifle;

autoexec __init__system__() {
  system::register(#"shockrifle", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}