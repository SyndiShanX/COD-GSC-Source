/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\tabun.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\tabun;

#namespace tabun;

autoexec __init__system__() {
  system::register(#"tabun", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}