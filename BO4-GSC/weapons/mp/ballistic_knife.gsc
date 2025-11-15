/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\ballistic_knife.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\ballistic_knife;

#namespace ballistic_knife;

autoexec __init__system__() {
  system::register(#"ballistic_knife", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}