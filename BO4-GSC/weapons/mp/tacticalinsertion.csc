/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\tacticalinsertion.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\tacticalinsertion;

#namespace tacticalinsertion;

autoexec __init__system__() {
  system::register(#"tacticalinsertion", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}