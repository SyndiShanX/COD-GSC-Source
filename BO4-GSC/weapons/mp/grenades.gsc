/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\grenades.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\grenades;

#namespace grenades;

autoexec __init__system__() {
  system::register(#"grenades", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}