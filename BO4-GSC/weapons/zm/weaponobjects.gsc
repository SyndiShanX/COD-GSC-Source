/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\zm\weaponobjects.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\util;

#namespace weaponobjects;

autoexec __init__system__() {
  system::register(#"weaponobjects", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}