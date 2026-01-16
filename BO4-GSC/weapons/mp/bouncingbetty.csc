/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\bouncingbetty.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\bouncingbetty;

#namespace bouncingbetty;

autoexec __init__system__() {
  system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}